//
//  ViewController.swift
//  stopWatch
//
//  Created by nice on 2018/10/16.
//  Copyright © 2018 NICE. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    var resetBtn: UIButton!
    var timeLab: UILabel!
    var playBtn: UIButton!
    var stopBtn: UIButton!
    var timer: Timer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupUI()
    }

    func setupUI(){
        
        self.view.backgroundColor = UIColor.black

        resetBtn = UIButton.init(type: UIButton.ButtonType.custom)
        resetBtn.setTitle("Reset", for: UIControl.State.normal)
        resetBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        resetBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(resetBtn)
        resetBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-50)
            make.height.width.equalTo(100)
        }
        resetBtn.addTarget(self, action: #selector(resetAction), for: UIControl.Event.touchUpInside)
        
        timeLab = UILabel.init()
        timeLab.textColor = UIColor.white
        timeLab.textAlignment = NSTextAlignment.center
        timeLab.font = UIFont.systemFont(ofSize: 30)
        timeLab.text = "0.0"
        self.view .addSubview(timeLab)
        timeLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(resetBtn.snp_bottomMargin)
            make.height.equalTo(100)
        }
        
        playBtn = UIButton.init()
        playBtn.backgroundColor = UIColor.red
        playBtn.setTitle("start", for: UIControl.State.normal)
        self.view.addSubview(playBtn)
        playBtn.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.top.equalTo(timeLab.snp_bottomMargin)
        }
        playBtn.addTarget(self, action: #selector(startTimer), for: UIControl.Event.touchUpInside)
        
        stopBtn = UIButton.init()
        stopBtn.backgroundColor = UIColor.green
        stopBtn.setTitle("stop", for: UIControl.State.normal)
        self.view.addSubview(stopBtn)
        stopBtn.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview()
            make.left.equalTo(playBtn.snp_rightMargin)
            make.top.equalTo(timeLab.snp_bottomMargin)
            make.width.equalTo(playBtn)
        }
        stopBtn.addTarget(self, action: #selector(stopTimer), for: UIControl.Event.touchUpInside)
    }
    
    
    @objc func startTimer (){
        
        timer = Timer.init(timeInterval: 0.1, repeats: true, block: { (timer) in
            
            let currentTime: Float = Float(self.timeLab.text ?? "0.0") ?? 0.0
            
            self.timeLab.text = String(format: "%.1f", currentTime + 0.1)
            
        })
        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
        self.playBtn.isEnabled = false
        
    }
    
    @objc func stopTimer (){
        
        timer.invalidate()
        self.playBtn.isEnabled = true
    }
    
    @objc func resetAction() {
        self.timeLab.text = "0.0"
        self.timer.invalidate()
        self.playBtn.isEnabled = true
    }
    
}

