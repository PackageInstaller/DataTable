_class("UIHauteCoutureDrawGetItemCellPLM", UICustomWidget)
UIHauteCoutureDrawGetItemCellPLM = UIHauteCoutureDrawGetItemCellPLM

function UIHauteCoutureDrawGetItemCellPLM:Constructor()
  self._atlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
end

function UIHauteCoutureDrawGetItemCellPLM:OnShow()
  self.qualitybg = self:GetUIComponent("Image", "qualitybg")
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self.name = self:GetUIComponent("UILocalizationText", "name")
  self.select = self:GetGameObject("select")
  self.bg = self:GetUIComponent("Image", "bg")
end

function UIHauteCoutureDrawGetItemCellPLM:SetData(itemInfo, showName, clickCallback)
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
  self.qualitybg.sprite = self._atlas:GetSprite("spirit_shengji_se" .. quality)
  self._clickCallback = clickCallback
end

function UIHauteCoutureDrawGetItemCellPLM:EnableInteract(enable)
end

function UIHauteCoutureDrawGetItemCellPLM:BgOnClick(go)
  if self._clickCallback then
    self._clickCallback(self._item_index, go.transform.position)
  end
end
