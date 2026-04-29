_class("UIBuildSkinTips", UIController)
UIBuildSkinTips = UIBuildSkinTips

function UIBuildSkinTips:OnShow(uiParams)
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._conditionLabel = self:GetUIComponent("UILocalizationText", "Condition")
  local skinId = uiParams[1]
  local cfg = Cfg.cfg_item_architecture_skin[skinId]
  self._nameLabel:SetText(StringTable.Get(cfg.SkinName))
  self._conditionLabel:SetText(StringTable.Get(cfg.UnLockCondition, cfg.Level))
end

function UIBuildSkinTips:BtnGotoOnClick(go)
  self:CloseDialog()
end

function UIBuildSkinTips:MaskOnClick(go)
  self:CloseDialog()
end
