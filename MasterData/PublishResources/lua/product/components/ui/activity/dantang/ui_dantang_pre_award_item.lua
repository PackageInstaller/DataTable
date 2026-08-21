_class("UIDanTangPreAwardsItem", UICustomWidget)
UIDanTangPreAwardsItem = UIDanTangPreAwardsItem

function UIDanTangPreAwardsItem:OnShow(uiParams)
  self:InitWidget()
end

function UIDanTangPreAwardsItem:InitWidget()
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.count = self:GetUIComponent("UILocalizationText", "count")
end

function UIDanTangPreAwardsItem:SetData(asset, onClick)
  self._itemID = asset.assetid
  local cfg = Cfg.cfg_item[self._itemID]
  if not cfg then
    Log.exception("cfg_item 中缺少物品", self._itemID)
  end
  self.icon:LoadImage(cfg.Icon)
  self.count:SetText(asset.count)
  self._onClick = onClick
end

function UIDanTangPreAwardsItem:RootOnClick(go)
  self._onClick(self._itemID, go)
end
