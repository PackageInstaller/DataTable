local this = class("modulePhotoStampHandle", G_UIModuleBase)
local _maxScale = 2
local _minScale = 0.5
local _dir = {
  rb = 1,
  rt = 2,
  lb = 3,
  lt = 4
}

function this.bind()
  return {}
end

function this.methods()
  return {
    onDrag = function(self, screenPos)
      self:onDrag(screenPos)
    end,
    onBeginDrag = function(self, screenPos)
      self.lastScreenPos = screenPos
      self:beginRecordPos()
    end,
    onEndDrag = function(self, screenPos)
      self:endRecordPos()
    end,
    onDragHandle = function(self, screenPos)
      self:onDragHandle(screenPos)
    end,
    onBeginDragHandle = function(self, screenPos)
      self.lastScreenPos = screenPos
      self:beginRecordScale()
    end,
    onEndDragHandle = function(self, screenPos)
      self:endRecordScale()
    end,
    onClickDel = function(self)
      self:emit("onClickDel", self.bindRect)
    end,
    onBeginDrag1 = function(self, screenPos)
      self.lastScreenPos = screenPos
      self:beginRecordPos()
    end,
    onEndDrag1 = function(self, screenPos)
      self:endRecordPos()
    end,
    onDragHandleRB = function(self, screenPos)
      self:onDragHandle(screenPos, _dir.rb)
    end,
    onBeginDrag2 = function(self, screenPos)
      self.lastScreenPos = screenPos
      self:beginRecordPos()
    end,
    onEndDrag2 = function(self, screenPos)
      self:endRecordPos()
    end,
    onDragHandleRT = function(self, screenPos)
      self:onDragHandle(screenPos, _dir.rt)
    end,
    onBeginDrag3 = function(self, screenPos)
      self.lastScreenPos = screenPos
      self:beginRecordPos()
    end,
    onEndDrag3 = function(self, screenPos)
      self:endRecordPos()
    end,
    onDragHandleLT = function(self, screenPos)
      self:onDragHandle(screenPos, _dir.lt)
    end
  }
end

function this:open()
  self.rectTransform = self.gameObject:GetComponent(typeof(C_RectTransform))
  self.bindComponents.btnDrag.DragObjParent = self.rectTransform.parent
end

function this:bindStamp(uiRect, isScaleMode, isPhotoEdit)
  self.bindRect = uiRect
  self.rectTransform.localPosition = uiRect.localPosition
  self.rectTransform.sizeDelta = uiRect.sizeDelta
  self.oriSize = uiRect.sizeDelta
  local scale = isScaleMode and uiRect.localScale.x or 1
  self.scaleMode = isScaleMode
  self.rectTransform.sizeDelta = self.oriSize * C_Vector2(scale, scale)
  local img = uiRect.gameObject:GetComponent(typeof(C_LImage))
  local width = img.sprite.rect.size.x
  local height = img.sprite.rect.size.y
  self.maxSize = C_Vector2(width * _maxScale, height * _maxScale)
  self.minSize = C_Vector2(width * _minScale, height * _minScale)
  self.rectTransform:SetAsLastSibling()
end

function this:setActive(b)
  self.gameObject:SetActive(b)
  if not b then
    self.bindRect = nil
  end
end

function this:onDrag(screenPos)
  if self.lastScreenPos == nil then
    self.lastScreenPos = screenPos
    return
  end
  local prePos = L_GameUtil.spToLpInRectangle(self.rectTransform.parent, self.lastScreenPos)
  local curPos = L_GameUtil.spToLpInRectangle(self.rectTransform.parent, screenPos)
  local offset = curPos - prePos
  local targetPos = self.rectTransform.localPosition + offset
  local sizeLimit = self.rectTransform.parent.rect.size
  targetPos.x = math.clamp(targetPos.x, -sizeLimit.x / 2, sizeLimit.x / 2)
  targetPos.y = math.clamp(targetPos.y, -sizeLimit.y / 2, sizeLimit.y / 2)
  self.rectTransform.localPosition = targetPos
  self.bindRect.localPosition = targetPos
  self.lastScreenPos = screenPos
end

function this:onDragHandle(screenPos, dir)
  if self.lastScreenPos == nil then
    self.lastScreenPos = screenPos
    return
  end
  local prePos = L_GameUtil.spToLpInRectangle(self.rectTransform.parent, self.lastScreenPos)
  local curPos = L_GameUtil.spToLpInRectangle(self.rectTransform.parent, screenPos)
  local offset = curPos - prePos
  if dir == _dir.rt then
    offset.x = offset.x * 2
    offset.y = offset.y * 2
  elseif dir == _dir.rb then
    offset.x = offset.x * 2
    offset.y = -offset.y * 2
  elseif dir == _dir.lt then
    offset.x = -offset.x * 2
    offset.y = offset.y * 2
  elseif dir == _dir.lb then
    offset.x = -offset.x * 2
    offset.y = -offset.y * 2
  else
    offset.x = -offset.x * 2
    offset.y = -offset.y * 2
  end
  local curSize = self.rectTransform.sizeDelta
  local ratio = curSize.x / curSize.y
  local targetSize = curSize + offset
  if math.abs(offset.x) > math.abs(offset.y) then
    targetSize.y = targetSize.x / ratio
  else
    targetSize.x = targetSize.y * ratio
  end
  targetSize.x = math.clamp(targetSize.x, self.minSize.x, self.maxSize.x)
  targetSize.y = math.clamp(targetSize.y, self.minSize.y, self.maxSize.y)
  self.rectTransform.sizeDelta = targetSize
  if self.scaleMode then
    local scale = targetSize.x / self.bindRect.sizeDelta.x
    self.bindRect.localScale = C_Vector3(scale, scale, 1)
  else
    self.bindRect.sizeDelta = targetSize
  end
  self.lastScreenPos = screenPos
end

function this:refresh()
end

function this:close()
end

function this:beginRecordPos()
  if self.bindRect then
    self.beginPos = {
      x = self.bindRect.localPosition.x,
      y = self.bindRect.localPosition.y
    }
  end
end

function this:endRecordPos()
  if self.bindRect and self.beginPos then
    self.endPos = {
      x = self.bindRect.localPosition.x,
      y = self.bindRect.localPosition.y
    }
    self:emit("onPosChanged", self.beginPos, self.endPos)
    self.beginPos = nil
    self.endPos = nil
  end
end

function this:beginRecordScale()
  if not self.scaleMode then
    return
  end
  if self.bindRect then
    self.beginScale = self.bindRect.localScale.x
  end
end

function this:endRecordScale()
  if not self.scaleMode then
    return
  end
  if self.bindRect and self.beginScale then
    self.endScale = self.bindRect.localScale.x
    self:emit("onScaleChanged", self.beginScale, self.endScale)
    self.beginScale = nil
    self.endScale = nil
  end
end

return this
