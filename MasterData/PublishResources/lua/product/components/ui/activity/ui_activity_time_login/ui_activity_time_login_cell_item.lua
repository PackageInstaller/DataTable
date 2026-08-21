_class("UIActivityTimeLoginCellItem", UICustomWidget)
UIActivityTimeLoginCellItem = UIActivityTimeLoginCellItem

function UIActivityTimeLoginCellItem:OnShow(uiParams)
  self:InitWidget()
end

function UIActivityTimeLoginCellItem:InitWidget()
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._iconRect = self:GetUIComponent("RectTransform", "Icon")
  self._iconRectDefaultSize = Vector2(self._iconRect.sizeDelta.x, self._iconRect.sizeDelta.y)
  self._iconImg = self:GetUIComponent("RawImage", "Icon")
  self._countArea = self:GetUIComponent("Image", "CountArea")
  self._countText = self:GetUIComponent("UILocalizationText", "CountText")
end

function UIActivityTimeLoginCellItem:SetData(roleAsset, tipsCallback)
  self._roleAsset = roleAsset
  self._itemId = roleAsset.assetid
  self._itemCount = roleAsset.count
  self._tipsCallback = tipsCallback
  local cfg_item = Cfg.cfg_item[self._itemId]
  if not cfg_item then
    return
  end
  local icon = cfg_item.Icon
  self._icon:LoadImage(icon)
  self._countText:SetText(self._itemCount)
  local isHead = false
  if self._itemId >= 3750000 and self._itemId <= 3759999 then
    isHead = true
  end
  if isHead then
    local whRate = 1
    if self._itemId >= 3751000 and self._itemId <= 3751999 then
      whRate = 0.8421052631578947
    elseif self._itemId >= 3752000 and self._itemId <= 3752999 then
      whRate = 0.6388888888888888
    elseif self._itemId >= 3753000 and self._itemId <= 3753999 then
      whRate = 0.6388888888888888
    end
    self._iconRect.sizeDelta = Vector2(self._iconRect.sizeDelta.x, self._iconRect.sizeDelta.x * whRate)
  else
    self._iconRect.sizeDelta = self._iconRectDefaultSize
  end
end

function UIActivityTimeLoginCellItem:IconOnClick(go)
  if self._tipsCallback then
    self._tipsCallback(self._roleAsset.assetid, go.transform.position)
  end
end
