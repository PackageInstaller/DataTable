_class("UIRecruitGesture", Object)
UIRecruitGesture = UIRecruitGesture

function UIRecruitGesture:Constructor(etl, longPressTime, onLongPressBegin, onLongPressing, onLongPressEnd, onDragBegin, onDrag, onDragEnd, onRelease)
  self._uiEventListner = UICustomUIEventListener:New()
  self._uiEventListner:AddUICustomEventListener(etl, UIEvent.Press, function(e)
    self:_OnPress(e)
  end)
  self._uiEventListner:AddUICustomEventListener(etl, UIEvent.Release, function(e)
    self:_OnRelease(e)
  end)
  self._uiEventListner:AddUICustomEventListener(etl, UIEvent.BeginDrag, function(e)
    self:_OnDragBegin(e)
  end)
  self._uiEventListner:AddUICustomEventListener(etl, UIEvent.Drag, function(e)
    self:_OnDrag(e)
  end)
  self._uiEventListner:AddUICustomEventListener(etl, UIEvent.EndDrag, function(e)
    self:_OnDragEnd(e)
  end)
  self._longPressTime = longPressTime
  self._longPressBegin = onLongPressBegin
  self._longPressing = onLongPressing
  self._longPressEnd = onLongPressEnd
  self._dragBegin = onDragBegin
  self._drag = onDrag
  self._dragEnd = onDragEnd
  self._release = onRelease
  self._isMouseDown = false
  self._isLongPressing = false
  self._isDragging = false
  self._timer = 0
  self._enable = true
end

function UIRecruitGesture:Update(dtMS)
  if not self._enable then
    return
  end
  if not self._isDragging then
    if self._isLongPressing then
      if self._longPressing then
        self._longPressing()
      end
    elseif self._isMouseDown then
      self._timer = self._timer + dtMS
      if self._timer > self._longPressTime then
        self._isLongPressing = true
        if self._longPressBegin then
          self._longPressBegin()
        end
      end
    end
  end
end

function UIRecruitGesture:Dispose()
  self._uiEventListner:Dispose()
  self._uiEventListner = nil
  self._enable = false
end

function UIRecruitGesture:_OnPress(e)
  if not self._enable then
    return
  end
  self._isMouseDown = true
  self._timer = 0
end

function UIRecruitGesture:_OnRelease(e)
  if not self._enable then
    return
  end
  self._isMouseDown = false
  if self._isLongPressing then
    if self._longPressEnd then
      self._longPressEnd()
    end
    self._isLongPressing = false
  end
  if self._release then
    self._release()
  end
end

function UIRecruitGesture:_OnDragBegin(e)
  if not self._enable then
    return
  end
  if not self._isMouseDown then
    return
  end
  self._isDragging = true
  if self._isLongPressing then
    if self._longPressEnd then
      self._longPressEnd()
    end
    self._isLongPressing = false
  end
  if self._dragBegin then
    self._dragBegin()
  end
end

function UIRecruitGesture:_OnDrag(e)
  if not self._enable then
    return
  end
  if not self._isMouseDown then
    return
  end
  self._isDragging = true
  if self._drag then
    self._drag(e)
  end
end

function UIRecruitGesture:_OnDragEnd(e)
  if not self._enable then
    return
  end
  if self._dragEnd then
    self._dragEnd()
  end
  self._isDragging = false
end

function UIRecruitGesture:SetEnable(enable)
  if enable then
  else
    self._isMouseDown = false
    self._isDragging = false
    self._timer = 0
    if self._isLongPressing then
      if self._longPressEnd then
        self._longPressEnd()
      end
      self._isLongPressing = false
    end
  end
  self._enable = enable
end

function UIRecruitGesture:IsDragging()
  return self._isDragging
end

function UIRecruitGesture:IsLongPressing()
  return self._isLongPressing
end
