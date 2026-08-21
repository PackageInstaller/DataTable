_class("UISummer1SelectInfoReview", UICustomWidget)
UISummer1SelectInfoReview = UISummer1SelectInfoReview

function UISummer1SelectInfoReview:OnShow(uiParams)
  self:InitWidget()
end

function UISummer1SelectInfoReview:InitWidget()
  self.txt_name = self:GetUIComponent("UILocalizationText", "txt_name")
  self.txt_have = self:GetUIComponent("UILocalizationText", "txt_have")
  self.txt_desc = self:GetUIComponent("UILocalizationText", "txt_desc")
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._countLabel = self:GetUIComponent("UILocalizationText", "Count")
end

function UISummer1SelectInfoReview:SetData(roleAsset)
  local cfg = Cfg.cfg_item[roleAsset.assetid]
  self._iconLoader:LoadImage(cfg.Icon)
  self._countLabel:SetText(roleAsset.count)
  self.txt_name:SetText(StringTable.Get(cfg.Name))
  self.txt_desc:SetText(StringTable.Get(cfg.Intro))
  local roleModule = GameGlobal.GetModule(RoleModule)
  local c = roleModule:GetAssetCount(roleAsset.assetid) or 0
  self.txt_have:SetText(c)
end

function UISummer1SelectInfoReview:rootFrameOnClick()
end
