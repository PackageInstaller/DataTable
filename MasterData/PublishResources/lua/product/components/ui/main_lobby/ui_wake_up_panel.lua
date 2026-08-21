_class("UIWakeUpPanel", UIController)
UIWakeUpPanel = UIWakeUpPanel

function UIWakeUpPanel:OnShow(uiParams)
end

function UIWakeUpPanel:CloseOnClick(go)
  self:CloseDialog()
end
