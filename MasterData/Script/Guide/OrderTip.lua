local UIGuidanceController = require("UIGuidance/UIGuidanceController")
local Order = {}
local isWaitClick = false
local isFinish = false

function Order:OnStart(ca)
  isFinish = false
  UIGuidanceController.ActiveUIGuide()
  UIGuidanceController.PlaySound(ca.soundId)
  UIGuidanceController.ShowTip(ca.x, ca.y, ca.text, ca.left, ca.top, ca.pfp, ca.isWaitClick, ca.isDoTween, ca.speed)
  isWaitClick = ca.isWaitClick
  if ca.autoCompletedTime > 0 then
    GuideManager:Delay(ca.autoCompletedTime, function()
      isFinish = true
    end)
  end
end

function Order:IsFinish()
  if isWaitClick then
    local tempFinish = isFinish or UIGuidanceController.IsFinish()
    if tempFinish then
      UIGuidanceController.ShowClick(false)
    end
    return tempFinish
  else
    return true
  end
end

return Order
