_class("UIActivityBetweenTheChaptersAwardItem", UICustomWidget)
UIActivityBetweenTheChaptersAwardItem = UIActivityBetweenTheChaptersAwardItem

function UIActivityBetweenTheChaptersAwardItem:OnShow(uiParams)
  self:InitWidget()
end

function UIActivityBetweenTheChaptersAwardItem:InitWidget()
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._iconRect = self:GetUIComponent("RectTransform", "Icon")
  self._iconRectDefaultSize = Vector2(self._iconRect.sizeDelta.x, self._iconRect.sizeDelta.y)
  self._iconImg = self:GetUIComponent("RawImage", "Icon")
  self._countArea = self:GetUIComponent("Image", "CountArea")
  self._countText = self:GetUIComponent("UILocalizationText", "CountText")
end

function UIActivityBetweenTheChaptersAwardItem:SetData(data, itemInfoCallback)
  if not data then
    self:Hide()
    return
  end
  self._itemId = data.assetid
  self._itemCount = data.count
  self._itemInfoCallback = itemInfoCallback
  local cfg_item = Cfg.cfg_item[self._itemId]
  if not cfg_item then
    return
  end
  local icon = cfg_item.Icon
  self._icon:LoadImage(icon)
  self._countText:SetText(self._itemCount)
  local isHead = false
  if isHead then
    self._iconRect.sizeDelta = Vector2(self._iconRect.sizeDelta.x, self._iconRect.sizeDelta.x * 1.2)
  else
    self._iconRect.sizeDelta = self._iconRectDefaultSize
  end
end

function UIActivityBetweenTheChaptersAwardItem:_SetAlpha(alpha)
  self._iconImg.color = Color(self._iconImg.color.r, self._iconImg.color.g, self._iconImg.color.b, alpha)
  self._countArea.color = Color(self._countArea.color.r, self._countArea.color.g, self._countArea.color.b, alpha)
  self._countText.color = Color(self._countText.color.r, self._countText.color.g, self._countText.color.b, alpha)
end

function UIActivityBetweenTheChaptersAwardItem:IconOnClick(go)
  if self._itemInfoCallback then
    local tr = go.transform
    local pos = tr.position
    self._itemInfoCallback(self._itemId, pos)
  end
end
