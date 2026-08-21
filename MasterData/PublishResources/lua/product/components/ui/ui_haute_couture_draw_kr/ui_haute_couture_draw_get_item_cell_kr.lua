_class("UIHauteCoutureDrawGetItemCellKR", UICustomWidget)
UIHauteCoutureDrawGetItemCellKR = UIHauteCoutureDrawGetItemCellKR

function UIHauteCoutureDrawGetItemCellKR:Constructor()
  self._atlas = self:GetAsset("UIHauteCoutureKR.spriteatlas", LoadType.SpriteAtlas)
  self._qualityBgDic = {
    [1] = "krsenior_tips_kuang07",
    [2] = "krsenior_tips_kuang06",
    [3] = "krsenior_tips_kuang05",
    [4] = "krsenior_tips_kuang04",
    [5] = "krsenior_tips_kuang03",
    [6] = "krsenior_tips_kuang02"
  }
end

function UIHauteCoutureDrawGetItemCellKR:OnShow()
  self.qualitybg = self:GetUIComponent("Image", "qualitybg")
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self.name = self:GetUIComponent("UILocalizationText", "name")
  self.select = self:GetGameObject("select")
  self.bg = self:GetUIComponent("Image", "bg")
end

function UIHauteCoutureDrawGetItemCellKR:SetData(itemInfo, showName, clickCallback)
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

function UIHauteCoutureDrawGetItemCellKR:EnableInteract(enable)
end

function UIHauteCoutureDrawGetItemCellKR:BgOnClick(go)
  if self._clickCallback then
    self._clickCallback(self._item_index, go.transform.position)
  end
end
