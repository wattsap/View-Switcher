//
//  SwitchingViewController.swift
//  View Switcher
//
//  Created by Andrew Watts on 6/3/15.
//  Copyright (c) 2015 Andrew Watts. All rights reserved.
//

import UIKit

class SwitchingViewController: UIViewController {
    private var blackViewController: BlackViewController!
    private var yellowViewController: YellowViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        blackViewController =
            storyboard?.instantiateViewControllerWithIdentifier("Black")
                as! BlackViewController
        blackViewController.view.frame = view.frame
        switchViewController(from: nil, to: blackViewController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        if blackViewController != nil && blackViewController!.view.superview == nil {
            blackViewController = nil
        }
        if yellowViewController != nil && yellowViewController!.view.superview == nil {
            yellowViewController = nil
        }
    }
    
    @IBAction func switchViews(sender: UIBarButtonItem){
        if yellowViewController?.view.superview == nil {
            if yellowViewController == nil {
                yellowViewController =
                    storyboard?.instantiateViewControllerWithIdentifier("Yellow")
                        as! YellowViewController
            }
        }
        else if blackViewController?.view.superview == nil {
            blackViewController = storyboard?.instantiateViewControllerWithIdentifier("Black")as! BlackViewController
        }
        
        UIView.beginAnimations("View Flip", context: nil)
        UIView.setAnimationDuration(0.4)
        UIView.setAnimationCurve(.EaseInOut)
        if blackViewController != nil && blackViewController.view.superview != nil {
            UIView.setAnimationTransition(.FlipFromRight, forView: view, cache: true)
            yellowViewController.view.frame = view.frame
            switchViewController(from: blackViewController, to: yellowViewController)
        } else {
            UIView.setAnimationTransition(.FlipFromLeft, forView: view, cache: true)
            blackViewController.view.frame = view.frame
            switchViewController(from: yellowViewController, to: blackViewController)
        }
        UIView.commitAnimations()
    }
    
    private func switchViewController( from fromVC:UIViewController?, to toVC:UIViewController?){
        if fromVC != nil {
            fromVC!.willMoveToParentViewController(nil)
            fromVC!.view.removeFromSuperview()
            fromVC!.removeFromParentViewController()
        }
        if toVC != nil {
            self.addChildViewController(toVC!)
            self.view.insertSubview(toVC!.view, atIndex: 0)
            toVC!.didMoveToParentViewController(self)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
