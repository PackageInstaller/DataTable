_class("UIWorldBossDanLastRecordController", UIController)
UIWorldBossDanLastRecordController = UIWorldBossDanLastRecordController

function UIWorldBossDanLastRecordController:OnShow(uiParams)
  self:InitWidget()
end

function UIWorldBossDanLastRecordController:InitWidget()
  self._uianim = self:GetGameObject("uianim")
  self._danBadgeGen = self:GetUIComponent("UISelectObjectPath", "DanBadgeGen")
  self._bg = self:GetUIComponent("RawImageLoader", "Bg")
  self._danText = self:GetUIComponent("UILocalizationText", "DanText")
end

function UIWorldBossDanLastRecordController:ConfirmBtnOnClick(go)
  self:CloseDialog()
end
