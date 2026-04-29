_class("UIHomeHelpItem", UICustomWidget)
UIHomeHelpItem = UIHomeHelpItem

function UIHomeHelpItem:OnShow(uiParams)
end

function UIHomeHelpItem:GetUIComponents()
  self._titleBig = self:GetUIComponent("UILocalizationText", "titleBig")
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._msg = self:GetUIComponent("UILocalizationText", "msg")
  self._msgRect = self:GetUIComponent("RectTransform", "ContentRect")
  self._scrollRect = self:GetUIComponent("ScrollRect", "ScrollView")
  self._viewPort = self:GetUIComponent("Image", "Viewport")
  self._uiDrag = self:GetUIComponent("UIDrag", "bg")
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._scrollRect.gameObject), UIEvent.BeginDrag, function(pointData)
    self:OnBeginDrag(pointData)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._scrollRect.gameObject), UIEvent.Drag, function(pointData)
    self:OnDragEvent(pointData)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._scrollRect.gameObject), UIEvent.EndDrag, function(pointData)
    self:OnEndDrag(pointData)
  end)
  self._dragState = 0
end

function UIHomeHelpItem:OnBeginDrag(pointData)
  local delta = pointData.delta
  local d_x = delta.x
  local d_y = delta.y
  if math.abs(d_x) > math.abs(d_y) then
    self._dragState = 2
    self._scrollRect.enabled = false
    self._viewPort.raycastTarget = false
    self._uiDrag:OnBeginDrag(pointData)
  else
    self._dragState = 1
  end
end

function UIHomeHelpItem:OnDragEvent(pointData)
  local x = pointData.delta.x
  local y = pointData.delta.y
  if self._dragState == 1 then
    if self._scrollRect then
      self._scrollRect:OnDrag(pointData)
    end
  elseif self._dragState == 2 and self._uiDrag then
    self._uiDrag:OnDrag(pointData)
  end
end

function UIHomeHelpItem:OnEndDrag(pointData)
  if self._scrollRect then
    self._scrollRect.enabled = true
  end
  if self._viewPort then
    self._viewPort.raycastTarget = true
  end
  if self._dragState == 2 and self._uiDrag then
    self._uiDrag:OnEndDrag(pointData)
  end
  self._dragState = 0
end

function UIHomeHelpItem:SetData(index, titleBig, titleSmall, icon, msg)
  self:GetUIComponents()
  self._index = index
  self._titleBig:SetText(StringTable.Get(titleSmall))
  if icon then
    self._icon:LoadImage(icon)
  end
  self._msg:SetText(StringTable.Get(msg))
end

function UIHomeHelpItem:ResetPos()
  self._msgRect.anchoredPosition = Vector2.zero
end
