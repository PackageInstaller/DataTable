_class("UIRugueLikeResetMsgBoxController", UIController)
UIRugueLikeResetMsgBoxController = UIRugueLikeResetMsgBoxController

function UIRugueLikeResetMsgBoxController:OnShow(uiParam)
  self._msg = uiParam[1]
  self._callBack = uiParam[2]
  self._msgTex = self:GetUIComponent("UILocalizationText", "msg")
  self._msgTex:SetText(self._msg)
end

function UIRugueLikeResetMsgBoxController:sureBtnOnClick()
  if self._callBack then
    self._callBack()
  end
  self:CloseDialog()
end
