local UIGuidanceController = require("UIGuidance/UIGuidanceController")
local Order = {}

function Order:OnStart(ca)
  UIGuidanceController.ActiveUIGuide()
  UIGuidanceController.SetFocus(ca.x, ca.y, ca.w, ca.h, ca.left, ca.top)
  UIGuidanceController.ShowFinger(ca.isShowFinger)
  UIGuidanceController.SetBgAlpha(ca.alpha)
end

function Order:IsFinish()
  return true
end

return Order
