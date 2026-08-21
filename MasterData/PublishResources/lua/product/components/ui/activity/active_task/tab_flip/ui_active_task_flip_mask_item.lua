_class("UIActiveTaskFlipMaskItem", UICustomWidget)
UIActiveTaskFlipMaskItem = UIActiveTaskFlipMaskItem

function UIActiveTaskFlipMaskItem:OnShow()
  self:_GetComponent()
end

function UIActiveTaskFlipMaskItem:OnHide()
end

function UIActiveTaskFlipMaskItem:_GetComponent()
  self._bgObj = self:GetGameObject("bg")
  self._rect = self:GetUIComponent("RectTransform", "rect")
  self._anim = self:GetUIComponent("Animation", "rect")
end

function UIActiveTaskFlipMaskItem:SetData(data, gridSize, callback)
  self._isFliped = data.isFlip
  self._index = data.index
  self._gridSize = gridSize
  self._callback = callback
  self:InitComponent()
end

function UIActiveTaskFlipMaskItem:InitComponent()
  self:SetFlipState(self._isFliped)
  self._rect.anchorMax = Vector2(0, 1)
  self._rect.anchorMin = Vector2(0, 1)
  self._rect.sizeDelta = Vector2(self._gridSize.x, self._gridSize.y)
  local row = math.floor(self._index / 10)
  local arrange = -(self._index % 10)
  self._rect.anchoredPosition = Vector2(row * self._gridSize.x, arrange * self._gridSize.y)
end

function UIActiveTaskFlipMaskItem:SetFlipState(isFlip)
  self._isFliped = isFlip
  self._bgObj:SetActive(not self._isFliped)
end

function UIActiveTaskFlipMaskItem:GetCellIndex()
  return self._index
end

function UIActiveTaskFlipMaskItem:GetMaskPos()
  return self._rect.anchoredPosition
end

function UIActiveTaskFlipMaskItem:IsMaskFliped()
  return self._isFliped
end

function UIActiveTaskFlipMaskItem:MaskBtnOnClick()
  if self._isFliped then
    return
  end
  if self._callback then
    self._callback(self)
  end
end
