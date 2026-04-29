_class("UIBuildCollectRewardItem", UICustomWidget)
UIBuildCollectRewardItem = UIBuildCollectRewardItem

function UIBuildCollectRewardItem:OnShow(uiParams)
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._countLabel = self:GetUIComponent("UILocalizationText", "Count")
  self._quatyImg = self:GetUIComponent("Image", "Quaty")
  self._quatyGo = self:GetGameObject("Quaty")
  self.atlas = self:GetAsset("UIHomelandBackpack.spriteatlas", LoadType.SpriteAtlas)
end

function UIBuildCollectRewardItem:OnHide()
  self.atlas = nil
end

function UIBuildCollectRewardItem:Refresh(reward, clickCallback)
  local cfg = Cfg.cfg_item[reward[1]]
  self._iconLoader:LoadImage(cfg.Icon)
  self._countLabel:SetText(reward[2])
  self._id = reward[1]
  self._clickCallback = clickCallback
  self._quatyImg.sprite = self.atlas:GetSprite("n17_shop_kuang0" .. cfg.Color)
end

function UIBuildCollectRewardItem:BtnOnClick(go)
  if self._clickCallback then
    self._clickCallback(self._id, go)
  end
end
