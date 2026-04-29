_class("UICrazyLoginV2Item", UICustomWidget)
UICrazyLoginV2Item = UICrazyLoginV2Item

function UICrazyLoginV2Item:OnShow(uiParams)
  self:InitWidget()
end

function UICrazyLoginV2Item:InitWidget()
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._iconRect = self:GetUIComponent("RectTransform", "Icon")
  self._iconRectDefaultSize = Vector2(self._iconRect.sizeDelta.x, self._iconRect.sizeDelta.y)
  self._iconImg = self:GetUIComponent("RawImage", "Icon")
  self._countArea = self:GetUIComponent("Image", "CountArea")
  self._countText = self:GetUIComponent("UILocalizationText", "CountText")
end

function UICrazyLoginV2Item:SetData(data, callback)
  self._itemId = data.assetid
  self._itemCount = data.count
  self._callback = callback
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

function UICrazyLoginV2Item:_SetAlpha(alpha)
  self._iconImg.color = Color(self._iconImg.color.r, self._iconImg.color.g, self._iconImg.color.b, alpha)
  self._countArea.color = Color(self._countArea.color.r, self._countArea.color.g, self._countArea.color.b, alpha)
  self._countText.color = Color(self._countText.color.r, self._countText.color.g, self._countText.color.b, alpha)
end

function UICrazyLoginV2Item:IconOnClick(go)
  if self._callback then
    self._callback(self._itemId, go.transform.position)
  end
end
