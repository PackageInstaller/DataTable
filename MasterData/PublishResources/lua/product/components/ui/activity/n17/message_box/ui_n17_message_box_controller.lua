_class("UIN17MessageBoxController", UIController)
UIN17MessageBoxController = UIN17MessageBoxController

function UIN17MessageBoxController:Constructor()
end

function UIN17MessageBoxController:OnShow(uiParams)
  local title = uiParams[1]
  local desc = uiParams[2]
  self._callback = uiParams[3]
  UIWidgetHelper.SetLocalizationText(self, "_title", title)
  UIWidgetHelper.SetLocalizationText(self, "_desc", desc)
end

function UIN17MessageBoxController:ConfirmBtnOnClick()
  self:CloseDialog()
  if self._callback then
    self._callback()
  end
end
