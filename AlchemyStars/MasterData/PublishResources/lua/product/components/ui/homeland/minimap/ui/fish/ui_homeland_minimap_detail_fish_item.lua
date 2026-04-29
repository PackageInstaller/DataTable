_class("UIHomelandMinimapDetailFishItem", UICustomWidget)
UIHomelandMinimapDetailFishItem = UIHomelandMinimapDetailFishItem

function UIHomelandMinimapDetailFishItem:OnShow()
  self.bg = self:GetUIComponent("Image", "bg")
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.probText = self:GetUIComponent("UILocalizationText", "probText")
  self.atlas = self:GetAsset("UIHomelandMap.spriteatlas", LoadType.SpriteAtlas)
end

function UIHomelandMinimapDetailFishItem:SetData(itemID, prob)
  self.itemID = itemID
  local cfg = Cfg.cfg_item[itemID]
  self.imgIcon:LoadImage(cfg.Icon)
  self.bg.sprite = self.atlas:GetSprite("n17_dt_dykuang0" .. cfg.Color)
  self.probText:SetText(StringTable.Get("str_homeland_minimap_detail_drop_prob_" .. prob))
end

function UIHomelandMinimapDetailFishItem:bgOnClick(go)
  self:ShowDialog("UIItemTipsHomeland", self.itemID, go)
end
