_class("UISetPrivacySetTipsController", UIController)
UISetPrivacySetTipsController = UISetPrivacySetTipsController

function UISetPrivacySetTipsController:OnShow(uiParams)
  self._tips = self:GetUIComponent("UILocalizationText", "Tips")
  local tips = uiParams[1]
  self._confirmCallback = uiParams[2]
  self._tips.text = tips
end

function UISetPrivacySetTipsController:CancelBtnOnClick()
  self:CloseDialog()
end

function UISetPrivacySetTipsController:ConfirmBtnOnClick()
  self:CloseDialog()
  if self._confirmCallback then
    self._confirmCallback()
  end
end
