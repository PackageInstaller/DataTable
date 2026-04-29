_class("UIHauteCoutureDrawGetItemCellGL", UICustomWidget)
UIHauteCoutureDrawGetItemCellGL = UIHauteCoutureDrawGetItemCellGL

function UIHauteCoutureDrawGetItemCellGL:Constructor()
  self._atlas = self:GetAsset("UIHauteCoutureGL.spriteatlas", LoadType.SpriteAtlas)
end

function UIHauteCoutureDrawGetItemCellGL:OnShow()
  self.qualitybg = self:GetUIComponent("Image", "qualitybg")
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self.name = self:GetUIComponent("UILocalizationText", "name")
  self.select = self:GetGameObject("select")
  self.bg = self:GetUIComponent("Image", "bg")
  self.buyGo = self:GetGameObject("buy")
end

function UIHauteCoutureDrawGetItemCellGL:SetData(itemInfo, showName, clickCallback, checkBuy)
  self._item_id = itemInfo.item_id
  if checkBuy then
    self.buyGo:SetActive(3220000 == self._item_id)
  else
    self.buyGo:SetActive(false)
  end
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
  self.qualitybg.sprite = self._atlas:GetSprite("N17_produce_bg_item_" .. quality)
  self._clickCallback = clickCallback
end

function UIHauteCoutureDrawGetItemCellGL:EnableInteract(enable)
end

function UIHauteCoutureDrawGetItemCellGL:BgOnClick(go)
  if self._clickCallback then
    self._clickCallback(self._item_index, go.transform.position)
  end
end
