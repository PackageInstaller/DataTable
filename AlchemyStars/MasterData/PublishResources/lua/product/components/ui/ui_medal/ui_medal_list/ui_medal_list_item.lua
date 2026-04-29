_class("UIMedalListItem", UICustomWidget)
UIMedalListItem = UIMedalListItem

function UIMedalListItem:Constructor()
  self.itemData = nil
  self.callBack = nil
  self._atlas = self:GetAsset("UIMedal.spriteatlas", LoadType.SpriteAtlas)
end

function UIMedalListItem:OnShow(uiParams)
  self:InitWidget()
end

function UIMedalListItem:InitWidget()
  self.select = self:GetGameObject("select")
  self.red = self:GetGameObject("red")
  self.lock = self:GetGameObject("lock")
  self.icon = self:GetUIComponent("Image", "icon")
  self.iconRt = self:GetUIComponent("RectTransform", "icon")
end

function UIMedalListItem:GetData()
  return self.itemData
end

function UIMedalListItem:GetID()
  return self.itemData:GetTemplID()
end

function UIMedalListItem:SetData(itemData, isSelect, callback)
  self.itemData = itemData
  self.callBack = callback
  self.select:SetActive(isSelect)
  self.lock:SetActive(not itemData:IsReceive())
  local cfgMedal = itemData:GetTempl()
  local iconSp = self._atlas:GetSprite(cfgMedal.Icon)
  if iconSp then
    local rect = iconSp.rect
    self.icon.sprite = iconSp
    self.iconRt.sizeDelta = Vector2(rect.width * 0.4, rect.height * 0.4)
  end
  self.red:SetActive(itemData:IsNew())
end

function UIMedalListItem:SetSelect(bSelect)
  self.select:SetActive(bSelect)
end

function UIMedalListItem:BgOnClick(go)
  if self.callBack then
    self.callBack(self)
  end
end

function UIMedalListItem:SetNewReviewed()
  self.red:SetActive(false)
end
