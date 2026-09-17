local this = class("modulePhotoSizeHandle", G_UIModuleBase)
local _PivotConfig = {
  [L_Const.pivotType.none] = C_Vector2(0.5, 0.5),
  [L_Const.pivotType.left] = C_Vector2(1, 0.5),
  [L_Const.pivotType.top] = C_Vector2(0.5, 0),
  [L_Const.pivotType.right] = C_Vector2(0, 0.5),
  [L_Const.pivotType.bottom] = C_Vector2(0.5, 1),
  [L_Const.pivotType.topLeft] = C_Vector2(1, 0),
  [L_Const.pivotType.topRight] = C_Vector2(0, 0),
  [L_Const.pivotType.bottomLeft] = C_Vector2(1, 1),
  [L_Const.pivotType.bottomRight] = C_Vector2(0, 1)
}
local _minSize = {x = 300, y = 300}

function this.bind()
  return {}
end

function this.methods()
  return {
    onDrag_left = function(self, screenPos)
      self.mode = L_Const.pivotType.left
      self:onDrag(screenPos)
    end,
    onDrag_top = function(self, screenPos)
      self.mode = L_Const.pivotType.top
      self:onDrag(screenPos)
    end,
    onDrag_right = function(self, screenPos)
      self.mode = L_Const.pivotType.right
      self:onDrag(screenPos)
    end,
    onDrag_bottom = function(self, screenPos)
      self.mode = L_Const.pivotType.bottom
      self:onDrag(screenPos)
    end,
    onDrag_topLeft = function(self, screenPos)
      self.mode = L_Const.pivotType.topLeft
      self:onDrag(screenPos)
    end,
    onDrag_topRight = function(self, screenPos)
      self.mode = L_Const.pivotType.topRight
      self:onDrag(screenPos)
    end,
    onDrag_bottomRight = function(self, screenPos)
      self.mode = L_Const.pivotType.bottomRight
      self:onDrag(screenPos)
    end,
    onDrag_bottomLeft = function(self, screenPos)
      self.mode = L_Const.pivotType.bottomLeft
      self:onDrag(screenPos)
    end,
    onDragMain = function(self, screenPos)
      self:onDragMain(screenPos)
    end,
    onDragMainEnd = function(self, screenPos)
      self.lastMainPos = nil
    end
  }
end

function this:open()
  self.mode = L_Const.pivotType.none
  self:initListener()
  self.isDragging = false
  self.rectTransform = self.gameObject:GetComponent(typeof(C_RectTransform))
end

function this:initListener()
  local CDragBtn = CS.Lens.Framework.UI.LDragButton
  local count = self.gameObject.transform.childCount
  self._onDragBegin = handler(self, self.onDragBegin)
  self._onDragEnd = handler(self, self.onDragEnd)
  for i = 0, count - 1 do
    local child = self.gameObject.transform:GetChild(i)
    local dragBtn = child.gameObject:GetComponent(typeof(CDragBtn))
    if dragBtn ~= nil then
      dragBtn.onDragBegin:AddListener(self._onDragBegin)
      dragBtn.onDragEnd:AddListener(self._onDragEnd)
    end
  end
end

function this:removeListener()
  local CDragBtn = CS.Lens.Framework.UI.LDragButton
  local count = self.gameObject.transform.childCount
  for i = 0, count - 1 do
    local child = self.gameObject.transform:GetChild(i)
    local dragBtn = child.gameObject:GetComponent(typeof(CDragBtn))
    if dragBtn ~= nil then
      dragBtn.onDragBegin:RemoveListener(self._onDragBegin)
      dragBtn.onDragEnd:RemoveListener(self._onDragEnd)
      dragBtn.onDragBegin:RemoveAllListeners()
      dragBtn.onDragEnd:RemoveAllListeners()
    end
  end
end

function this:initInfo(m)
  self.sizeMode = m
end

function this:initRef(data)
  self.imgRoot = data.imgRoot
  self.parentRect = self.gameObject.transform.parent:GetComponent(typeof(C_RectTransform))
  self.photoRect = data.photoRect
end

function this:onDragBegin(v)
  self.isDragging = true
  self.lastPos = v
end

function this:onDragEnd(v)
  self.isDragging = false
  self.lastPos = nil
  self.mode = L_Const.pivotType.none
  local currentPosition = self.rectTransform.anchoredPosition
  local oldPivot = self.rectTransform.pivot
  self.rectTransform.pivot = C_Vector2(0.5, 0.5)
  local pivotOffset = C_Vector2(0.5, 0.5) - oldPivot
  self.rectTransform.anchoredPosition = currentPosition + pivotOffset * self.rectTransform.sizeDelta
end

function this:onDrag(screenPos)
  if self.lastPos == nil then
    self.lastPos = screenPos
    return
  end
  local prePos = L_GameUtil.spToLpInRectangle(self.rectTransform, self.lastPos)
  local pos = L_GameUtil.spToLpInRectangle(self.rectTransform, screenPos)
  self.lastPos = screenPos
  local offset = pos - prePos
  local pivot = _PivotConfig[self.mode]
  local oldPivot = self.rectTransform.pivot
  if self.mode == L_Const.pivotType.left or self.mode == L_Const.pivotType.topLeft or self.mode == L_Const.pivotType.bottomLeft then
    offset.x = -offset.x
  end
  if self.mode == L_Const.pivotType.bottom or self.mode == L_Const.pivotType.bottomLeft or self.mode == L_Const.pivotType.bottomRight then
    offset.y = -offset.y
  end
  if self.mode == L_Const.pivotType.left or self.mode == L_Const.pivotType.right then
    offset.y = 0
  elseif self.mode == L_Const.pivotType.top or self.mode == L_Const.pivotType.bottom then
    offset.x = 0
  end
  offset = self:setDeltaWithMode(offset)
  offset = self:outRectCheck(offset)
  local targetSize = self.rectTransform.sizeDelta + offset
  if self.sizeMode.isFree then
    targetSize.x = math.max(targetSize.x, _minSize.x)
    targetSize.y = math.max(targetSize.y, _minSize.y)
  elseif self.sizeMode.ratio then
    local ratio = self.sizeMode.ratio
    local minx, miny
    if ratio.x > ratio.y then
      minx = _minSize.x
      miny = _minSize.y / ratio.x * ratio.y
    else
      miny = _minSize.y
      minx = _minSize.x / ratio.y * ratio.x
    end
    targetSize.x = math.max(targetSize.x, minx)
    targetSize.y = math.max(targetSize.y, miny)
  end
  local currentPosition = self.rectTransform.anchoredPosition
  self.rectTransform.pivot = pivot
  self.rectTransform.sizeDelta = targetSize
  local pivotOffset = pivot - oldPivot
  self.rectTransform.anchoredPosition = currentPosition + pivotOffset * self.rectTransform.sizeDelta
  self:emit("onHandleSizeChange")
end

function this:setDeltaWithMode(size)
  if self.sizeMode.isFree then
  else
    local ratio = self.sizeMode.ratio
    if ratio then
      local ratioX = ratio.x
      local ratioY = ratio.y
      if self.mode == L_Const.pivotType.left or self.mode == L_Const.pivotType.right then
        size.y = size.x / ratioX * ratioY
      elseif self.mode == L_Const.pivotType.top or self.mode == L_Const.pivotType.bottom then
        size.x = size.y / ratioY * ratioX
      elseif math.abs(size.x) > math.abs(size.y) then
        size.y = size.x / ratioX * ratioY
      else
        size.x = size.y / ratioY * ratioX
      end
    end
  end
  return size
end

function this:outRectCheck(offset)
  local currentPosition = self.rectTransform.anchoredPosition
  local leftLimit, rightLimit, topLimit, bottomLimit = self:getLimit()
  local leftExpand = 0
  local rightExpand = 0
  local topExpand = 0
  local bottomExpand = 0
  if self.mode == L_Const.pivotType.left then
    leftExpand = offset.x
    topExpand = offset.y / 2
    bottomExpand = offset.y / 2
  elseif self.mode == L_Const.pivotType.top then
    leftExpand = offset.x / 2
    rightExpand = offset.x / 2
    topExpand = offset.y
  elseif self.mode == L_Const.pivotType.right then
    rightExpand = offset.x
    topExpand = offset.y / 2
    bottomExpand = offset.y / 2
  elseif self.mode == L_Const.pivotType.bottom then
    leftExpand = offset.x / 2
    rightExpand = offset.x / 2
    bottomExpand = offset.y
  elseif self.mode == L_Const.pivotType.topLeft then
    leftExpand = offset.x
    topExpand = offset.y
  elseif self.mode == L_Const.pivotType.topRight then
    rightExpand = offset.x
    topExpand = offset.y
  elseif self.mode == L_Const.pivotType.bottomRight then
    rightExpand = offset.x
    bottomExpand = offset.y
  elseif self.mode == L_Const.pivotType.bottomLeft then
    leftExpand = offset.x
    bottomExpand = offset.y
  end
  local subLeft = math.max(leftExpand - leftLimit, 0)
  local subRight = math.max(rightExpand - rightLimit, 0)
  local subTop = math.max(topExpand - topLimit, 0)
  local subBottom = math.max(bottomExpand - bottomLimit, 0)
  if self.sizeMode.isFree then
    if 0 < subLeft then
      offset.x = leftLimit
    end
    if 0 < subRight then
      offset.x = rightLimit
    end
    if 0 < subBottom then
      offset.y = bottomLimit
    end
    if 0 < subTop then
      offset.y = topLimit
    end
  else
    local maxScale = 1
    if 0 < leftExpand and leftLimit < leftExpand then
      maxScale = math.min(maxScale, leftLimit / leftExpand)
    end
    if 0 < rightExpand and rightLimit < rightExpand then
      maxScale = math.min(maxScale, rightLimit / rightExpand)
    end
    if 0 < topExpand and topLimit < topExpand then
      maxScale = math.min(maxScale, topLimit / topExpand)
    end
    if 0 < bottomExpand and bottomLimit < bottomExpand then
      maxScale = math.min(maxScale, bottomLimit / bottomExpand)
    end
    if maxScale < 1 then
      offset = offset * maxScale
    end
  end
  return offset
end

function this:applyRatio(ratio)
  local x = ratio.x
  local y = ratio.y
  local size = self.rectTransform.sizeDelta
  local sizeX = size.x
  local sizeY = size.y
  local curRatio = sizeX / sizeY
  local targetRatio = x / y
  if curRatio == targetRatio then
    return
  end
  local targetWidth, targetHeight
  if curRatio > targetRatio then
    targetWidth = sizeX
    targetHeight = targetWidth / targetRatio
  else
    targetHeight = sizeY
    targetWidth = targetHeight * targetRatio
  end
  local leftLimit, rightLimit, topLimit, bottomLimit = self:getLimit()
  local subY = (targetHeight - sizeY) / 2
  local subX = (targetWidth - sizeX) / 2
  local top, bottom = subY, subY
  local left, right = subX, subX
  if topLimit < top or bottomLimit < bottom then
    local subTop = top - topLimit
    local subBottom = bottom - bottomLimit
    if subTop > subBottom then
      local requireHeight = topLimit * 2
      targetHeight = sizeY + requireHeight
    else
      local requireHeight = bottomLimit * 2
      targetHeight = sizeY + requireHeight
    end
    targetWidth = targetHeight * targetRatio
  elseif leftLimit < left or rightLimit < right then
    local subLeft = left - leftLimit
    local subRight = right - rightLimit
    if subLeft > subRight then
      local requireWidth = leftLimit * 2
      targetWidth = sizeX + requireWidth
    else
      local requireWidth = rightLimit * 2
      targetWidth = sizeX + requireWidth
    end
    targetHeight = targetWidth / targetRatio
  end
  self.rectTransform.sizeDelta = C_Vector2(targetWidth, targetHeight)
  self:emit("onHandleSizeChange")
end

function this:getLimit()
  local currentPosition = self.rectTransform.anchoredPosition
  local parentMinX = self.parentRect.rect.xMin
  local parentMinY = self.parentRect.rect.yMin
  local parentMaxX = self.parentRect.rect.xMax
  local parentMaxY = self.parentRect.rect.yMax
  local photoMinX = self.photoRect.rect.xMin
  local photoMinY = self.photoRect.rect.yMin
  local photoMaxX = self.photoRect.rect.xMax
  local photoMaxY = self.photoRect.rect.yMax
  local photoPos = self.photoRect.anchoredPosition
  photoMaxY = photoMaxY + photoPos.y
  photoMaxX = photoMaxX + photoPos.x
  photoMinY = photoMinY + photoPos.y
  photoMinX = photoMinX + photoPos.x
  parentMinX = math.max(photoMinX, parentMinX)
  parentMinY = math.max(photoMinY, parentMinY)
  parentMaxX = math.min(photoMaxX, parentMaxX)
  parentMaxY = math.min(photoMaxY, parentMaxY)
  local oriHalfX = self.rectTransform.sizeDelta.x / 2
  local oriHalfY = self.rectTransform.sizeDelta.y / 2
  local oriAnchorPosition = currentPosition + (C_Vector2(0.5, 0.5) - self.rectTransform.pivot) * self.rectTransform.sizeDelta
  local oriTopLeft = oriAnchorPosition + C_Vector2(-oriHalfX, oriHalfY)
  local oriBottomRight = oriAnchorPosition + C_Vector2(oriHalfX, -oriHalfY)
  local leftLimit = oriTopLeft.x - parentMinX
  local rightLimit = parentMaxX - oriBottomRight.x
  local topLimit = parentMaxY - oriTopLeft.y
  local bottomLimit = oriBottomRight.y - parentMinY
  leftLimit = math.max(leftLimit, 0)
  rightLimit = math.max(rightLimit, 0)
  topLimit = math.max(topLimit, 0)
  bottomLimit = math.max(bottomLimit, 0)
  return leftLimit, rightLimit, topLimit, bottomLimit
end

function this:refresh()
end

function this:syncRectMask()
  self.rectTransform.anchoredPosition = C_Vector2.zero
  self.rectTransform.sizeDelta = self.imgRoot.sizeDelta
  self:emit("onHandleSizeChange")
end

function this:onDragMain(screenPos)
  if self.lastMainPos == nil then
    self.lastMainPos = screenPos
    return
  end
  local prePos = L_GameUtil.spToLpInRectangle(self.rectTransform, self.lastMainPos)
  local pos = L_GameUtil.spToLpInRectangle(self.rectTransform, screenPos)
  self.lastMainPos = screenPos
  local offset = pos - prePos
  local leftLimit, rightLimit, topLimit, bottomLimit = self:getLimit()
  offset.x = math.clamp(offset.x, -leftLimit, rightLimit)
  offset.y = math.clamp(offset.y, -bottomLimit, topLimit)
  self.rectTransform.anchoredPosition = self.rectTransform.anchoredPosition + offset
  self:emit("onHandleSizeChange")
end

function this:close()
  self:removeListener()
end

return this
