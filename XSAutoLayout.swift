//
//  XSAutoLayout.swift
//  SwiftApp
//
//  Created by xisi on 15/10/27.
//  Copyright © 2015年 xisi. All rights reserved.
//

import Foundation
import UIKit


//  MARK: - 自定义运算符
//_______________________________________________________________________________________________________________

/// *
func * (layout: XSAutoLayout, multiplier: CGFloat) -> XSAutoLayout {
    layout.multiplier = multiplier;
    return layout
}

/// /
func / (layout: XSAutoLayout, multiplier: CGFloat) -> XSAutoLayout {
    layout.multiplier = 1 / multiplier;
    return layout
}

/// +
func + (layout: XSAutoLayout, constant: CGFloat) -> XSAutoLayout {
    layout.constant = constant;
    return layout
}

/// -
func - (layout: XSAutoLayout, constant: CGFloat) -> XSAutoLayout {
    layout.constant = constant;
    return layout
}


/// ==
func == (layout1: XSAutoLayout, layout2: XSAutoLayout) -> NSLayoutConstraint {
    let constraint = NSLayoutConstraint(item: layout1.view, attribute: layout1.attr, relatedBy: .Equal,
        toItem: layout2.view, attribute: layout2.attr, multiplier: layout2.multiplier, constant: layout2.constant)
    let ancestorView = ancesstorView(layout1.view, view2: layout2.view)
    ancestorView.addConstraint(constraint)
    return constraint
}

/// >=
func >= (layout1: XSAutoLayout, layout2: XSAutoLayout) -> NSLayoutConstraint {
    let constraint = NSLayoutConstraint(item: layout1.view, attribute: layout1.attr, relatedBy: .GreaterThanOrEqual,
        toItem: layout2.view, attribute: layout2.attr, multiplier: layout2.multiplier, constant: layout2.constant)
    let ancestorView = ancesstorView(layout1.view, view2: layout2.view)
    ancestorView.addConstraint(constraint)
    return constraint
}

/// <=
func <= (layout1: XSAutoLayout, layout2: XSAutoLayout) -> NSLayoutConstraint {
    let constraint = NSLayoutConstraint(item: layout1.view, attribute: layout1.attr, relatedBy: .LessThanOrEqual,
        toItem: layout2.view, attribute: layout2.attr, multiplier: layout2.multiplier, constant: layout2.constant)
    let ancestorView = ancesstorView(layout1.view, view2: layout2.view)
    ancestorView.addConstraint(constraint)
    return constraint
}


/// 找到两个视图的公共父视图（包括这两个视图本身）
private func ancesstorView(view1: UIView, view2: UIView) -> UIView {
    var ancestorView: UIView!
    if view1.isDescendantOfView(view2) {
        ancestorView = view2
    } else if view2.isDescendantOfView(view1) {
        ancestorView = view1
    } else if view1.isDescendantOfView(view2.superview!) {
        ancestorView = view2.superview
    } else if view2.isDescendantOfView(view1.superview!) {
        ancestorView = view1.superview
    } else {
        ancestorView = view1.superview
    }
    return ancestorView
}



//  MARK: - XSAutoLayout
//_______________________________________________________________________________________________________________

/// 自动布局对象
class XSAutoLayout: NSObject {
    private var view: UIView!
    private var attr: NSLayoutAttribute!
    private var multiplier: CGFloat! = 1
    private var constant: CGFloat! = 0
}



//  MARK: - extionsion UIView
//_______________________________________________________________________________________________________________

extension UIView {
    /// 初始化
    public class func create() -> UIView {
        let view = self.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    var left: XSAutoLayout {                //  --  1
        return layoutWithAttr(.Left)
    }
    var right: XSAutoLayout {               //  --  2
        return layoutWithAttr(.Right)
    }
    var top: XSAutoLayout {                 //  --  3
        return layoutWithAttr(.Top)
    }
    var bottom: XSAutoLayout {              //  --  4
        return layoutWithAttr(.Bottom)
    }
    var leading: XSAutoLayout {             //  --  5
        return layoutWithAttr(.Leading)
    }
    var trailing: XSAutoLayout {            //  --  6
        return layoutWithAttr(.Trailing)
    }
    var width: XSAutoLayout {               //  --  7
        return layoutWithAttr(.Width)
    }
    var height: XSAutoLayout {              //  --  8
        return layoutWithAttr(.Height)
    }
    var centerX: XSAutoLayout {             //  --  9
        return layoutWithAttr(.CenterX)
    }
    var centerY: XSAutoLayout {             //  --  10
        return layoutWithAttr(.CenterY)
    }
    var baseline: XSAutoLayout {            //  --  11
        return layoutWithAttr(.Baseline)
    }
    var notAnAttribute: XSAutoLayout {      //  --  0
        return layoutWithAttr(.NotAnAttribute)
    }
    
    
    /// 通用
    private func layoutWithAttr(attr: NSLayoutAttribute) -> XSAutoLayout {
        let layout = XSAutoLayout()
        layout.view = self
        layout.attr = attr
        return layout
    }
}