local UIGuidanceController = require("UIGuidance/UIGuidanceController")
local Order = {}

function Order:OnStart(ca)
  UIGuidanceController.CloseUIGuide()
  UIManager:Open(ca.panelName, ca.params)
end

function Order:IsFinish()
  return true
end

return Order
