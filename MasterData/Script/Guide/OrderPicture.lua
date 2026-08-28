local UIGuidanceController = require("UIGuidance/UIGuidanceController")
local Order = {}
local isFinish = false

function Order:OnStart(ca)
  isFinish = false
  UIGuidanceController.CloseUIGuide()
  UIManager:Open("UI/Battle/Tutorial/Battle_tutorial", tostring(ca.guildanceOrderId), function()
    isFinish = true
  end)
end

function Order:IsFinish()
  return isFinish
end

return Order
