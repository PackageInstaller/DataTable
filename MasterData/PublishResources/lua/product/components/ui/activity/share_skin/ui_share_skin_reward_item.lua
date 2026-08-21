_class("UIShareSkinRewardItem", UICustomWidget)
UIShareSkinRewardItem = UIShareSkinRewardItem

function UIShareSkinRewardItem:OnShow(uiParams)
  self:InitWidget()
end

function UIShareSkinRewardItem:InitWidget()
  self.txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self.txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.tipsPosGo = self:GetGameObject("tipsPos")
end

function UIShareSkinRewardItem:SetData(itemid, count, clickCb)
  self._clickCb = clickCb
  self._itemId = itemid
  self._roleAsset = RoleAsset:New(itemid, count)
  self.txtCount:SetText(count)
  local cfg = Cfg.cfg_item[itemid]
  if cfg then
    self.txtName:SetText(StringTable.Get(cfg.Name))
    self.imgIcon:LoadImage(cfg.Icon)
  end
end

function UIShareSkinRewardItem:ItemBtnOnClick(go)
  if self._clickCb then
    self._clickCb(self._itemId, self.tipsPosGo.transform.position)
  end
end
