_class("UIHauteCoutureDrawGetItemCellBLH", UICustomWidget)
UIHauteCoutureDrawGetItemCellBLH = UIHauteCoutureDrawGetItemCellBLH

function UIHauteCoutureDrawGetItemCellBLH:Constructor()
  self._atlas = self:GetAsset("UIHauteCoutureBLH.spriteatlas", LoadType.SpriteAtlas)
  self._qualityBgDic = {
    [1] = "n17_shop_kuang01",
    [2] = "n17_shop_kuang02",
    [3] = "n17_shop_kuang03",
    [4] = "n17_shop_kuang04",
    [5] = "n17_shop_kuang05",
    [6] = "n17_shop_kuang06"
  }
end

function UIHauteCoutureDrawGetItemCellBLH:OnShow()
  self.qualitybg = self:GetUIComponent("Image", "qualitybg")
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self.name = self:GetUIComponent("UILocalizationText", "name")
  self.select = self:GetGameObject("select")
  self.bg = self:GetUIComponent("Image", "bg")
end

function UIHauteCoutureDrawGetItemCellBLH:SetData(itemInfo, showName, clickCallback)
  self._item_id = itemInfo.item_id
  self._item_index = itemInfo.item_index
  if showName then
    self.name:SetText(StringTable.Get(itemInfo.item_name))
  else
    self.name:SetText("")
  end
  self.txtCount:SetText(itemInfo.item_count)
  local icon = itemInfo.icon
  self.imgIcon:LoadImage(icon)
  local quality = itemInfo.color
  local spRes = self._qualityBgDic[quality]
  self.qualitybg.sprite = self._atlas:GetSprite(spRes)
  self._clickCallback = clickCallback
end

function UIHauteCoutureDrawGetItemCellBLH:EnableInteract(enable)
end

function UIHauteCoutureDrawGetItemCellBLH:BgOnClick(go)
  if self._clickCallback then
    self._clickCallback(self._item_index, go.transform.position)
  end
end
