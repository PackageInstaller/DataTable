_class("UUIShopHomelandPreviewItem", UICustomWidget)
UUIShopHomelandPreviewItem = UUIShopHomelandPreviewItem

function UUIShopHomelandPreviewItem:Constructor()
end

function UUIShopHomelandPreviewItem:OnShow(uiParams)
  self:_GetComponents()
end

function UUIShopHomelandPreviewItem:_GetComponents()
  self._picture = self:GetUIComponent("RawImageLoader", "Picture")
  self._pictureObj = self:GetGameObject("Picture")
  self._uiDrag = self:GetUIComponent("UIDrag", "Picture")
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._pictureObj), UIEvent.BeginDrag, function(pointData)
    self:OnBeginDrag(pointData)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._pictureObj), UIEvent.Drag, function(pointData)
    self:OnDragEvent(pointData)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._pictureObj), UIEvent.EndDrag, function(pointData)
    self:OnEndDrag(pointData)
  end)
  self._dragState = 0
end

function UUIShopHomelandPreviewItem:SetData(picture)
  self._picture:LoadImage(picture)
end

function UUIShopHomelandPreviewItem:OnBeginDrag(pointData)
  local delta = pointData.delta
  local d_x = delta.x
  local d_y = delta.y
  if math.abs(d_x) > math.abs(d_y) then
    self._dragState = 2
    self._uiDrag:OnBeginDrag(pointData)
  else
    self._dragState = 1
  end
end

function UUIShopHomelandPreviewItem:OnDragEvent(pointData)
  if self._dragState == 2 and self._uiDrag then
    self._uiDrag:OnDrag(pointData)
  end
end

function UUIShopHomelandPreviewItem:OnEndDrag(pointData)
  if self._dragState == 2 and self._uiDrag then
    self._uiDrag:OnEndDrag(pointData)
  end
  self._dragState = 0
end
