local PlotController = require("UIDialog/Model_PlotController")
local UIGuidanceController = require("UIGuidance/UIGuidanceController")
local Order = {}
local checkParamList = false

function Order:OnStart(ca)
  checkParamList = #ca.paramList > 0
  for k, v in pairs(ca.paramList) do
    Net.SetGuideNoUpdateLimit(v.paramEnum, v.paramVal)
  end
  UIGuidanceController.CloseUIGuide()
  UIManager:Open(UIPath.UIDialog, Json.encode({
    id = ca.paragraphId
  }))
end

function Order:IsFinish()
  local checkParamComplete = true
  if checkParamList then
    checkParamComplete = Net.updateGuideNoLimit == nil
  end
  return checkParamComplete and PlotController:IsFinish()
end

return Order
