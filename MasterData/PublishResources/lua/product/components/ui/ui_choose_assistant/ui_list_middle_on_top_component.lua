_class("ui_list_middle_on_top_component", Object)
ui_list_middle_on_top_component = ui_list_middle_on_top_component

function ui_list_middle_on_top_component.InitListLayout(contentRect, widgetList, cellWidth, cellHeight, bHorizon, bVertical)
  local cellCount = #widgetList
  local contentTarSize = contentRect.sizeDelta
  local contentTarPos = contentRect.anchoredPosition
  local conTarWidth = contentRect.sizeDelta.x
  local conTarHeight = contentRect.sizeDelta.y
  local conTarPosX = contentRect.anchoredPosition.x
  local conTarPosY = contentRect.anchoredPosition.y
  if bHorizon then
    conTarWidth = cellWidth * cellCount
    conTarPosX = 0.0
  end
  if bVertical then
    conTarHeight = cellHeight * cellCount
    conTarPosY = 0.0
  end
  contentTarSize = Vector2(conTarWidth, conTarHeight)
  contentRect.sizeDelta = contentTarSize
  contentRect.anchoredPosition = Vector2(conTarPosX, conTarPosY)
  local firstPosX = -conTarWidth / 2 + cellWidth / 2
  local firstPosY = conTarHeight / 2 - cellHeight / 2
  for index, widget in ipairs(widgetList) do
    local itemGo = widget:GetGameObject()
    itemGo.transform.anchorMin = Vector2(0.5, 0.5)
    itemGo.transform.anchorMax = Vector2(0.5, 0.5)
    itemGo.transform.sizeDelta = Vector2(cellWidth, cellHeight)
    local posX = itemGo.transform.anchoredPosition.x
    local posY = itemGo.transform.anchoredPosition.y
    if bHorizon then
      posX = firstPosX + cellWidth * (index - 1)
    end
    if bVertical then
      posY = firstPosY - cellHeight * (index - 1)
    end
    itemGo.transform.anchoredPosition = Vector2(posX, posY)
  end
end

function ui_list_middle_on_top_component:Constructor(widgetList, scrollRect, contentRect, bHorizon, bVertical)
  self._bHaveBar = false
  self._items = widgetList
  self._scrollRect = scrollRect
  self._content = contentRect
  self._itemCount = #self._items
  self._sortTb = {}
  for index, value in ipairs(self._items) do
    local sortData = {}
    sortData.idx = index
    sortData.absDis = 0
    sortData.curPos = 0
    table.insert(self._sortTb, sortData)
  end
  self._bHorizon = bHorizon
  self._bVertical = bVertical
  self._lastContentPosX = self._content.anchoredPosition.x
  self._lastContentPosY = self._content.anchoredPosition.y
  self._contentWidth = self._content.sizeDelta.x
  self._contentHeight = self._content.sizeDelta.y
  if self._itemCount > 0 then
    local cellTrans = self._items[1]:GetGameObject().transform
    self._cellWidth = cellTrans.sizeDelta.x
    self._cellHeight = cellTrans.sizeDelta.y
  end
end

function ui_list_middle_on_top_component:SetCustomScrollBar(barGo, slidingAreaGo, handlerGo)
  if self._itemCount <= 0 then
    barGo:SetActive(false)
    return
  end
  barGo:SetActive(true)
  self._bHaveBar = true
  self._barGo = barGo
  self._slidingAreaGo = slidingAreaGo
  self._handlerGo = handlerGo
  if self._bHorizon then
  elseif self._bVertical then
    local slidingLength = self._slidingAreaGo.transform.sizeDelta.y
    local tarHandlerLength = slidingLength / self._itemCount
    local curHandlerSize = self._handlerGo.transform.sizeDelta
    self._handlerGo.transform.sizeDelta = Vector2(curHandlerSize.x, tarHandlerLength)
    local curHandlerPos = self._handlerGo.transform.anchoredPosition
    self._handlerGo.transform.anchoredPosition = Vector2(curHandlerPos.x, 0)
    self._conStartPosOffForBar = self._contentHeight / 2 - self._cellHeight / 2
    self._conStartPosMaxForBar = self._contentHeight - self._cellHeight
    self._barProgressLength = slidingLength - tarHandlerLength
  end
end

function ui_list_middle_on_top_component:_RefreshScrollBar()
  if not self._bHaveBar or self._bHorizon then
  elseif self._bVertical then
    local edgePos = self._content.anchoredPosition.y + self._conStartPosOffForBar
    if edgePos < 0 then
      edgePos = 0
    elseif edgePos > self._conStartPosMaxForBar then
      edgePos = self._conStartPosMaxForBar
    end
    local newPos = 0
    if self._conStartPosMaxForBar == 0 then
      newPos = 0
    else
      newPos = 0 - edgePos / self._conStartPosMaxForBar * self._barProgressLength
    end
    local curHandlerPos = self._handlerGo.transform.anchoredPosition
    self._handlerGo.transform.anchoredPosition = Vector2(curHandlerPos.x, newPos)
  end
end

function ui_list_middle_on_top_component:OnUpdate(deltaTimeMS)
  if self._content.anchoredPosition.x ~= self._lastContentPosX or self._content.anchoredPosition.y ~= self._lastContentPosY then
    self:_RefreshClothListSibling()
    self:_RefreshScrollBar()
    self._lastContentPosX = self._content.anchoredPosition.x
    self._lastContentPosY = self._content.anchoredPosition.y
  end
end

function ui_list_middle_on_top_component:_CalCenterPos()
  local oriCenterX = 0
  local oriCenterY = 0
  local curCenterX = oriCenterX - self._content.anchoredPosition.x
  local curCenterY = oriCenterY - self._content.anchoredPosition.y
  self._curCenter = Vector2(curCenterX, curCenterY)
end

function ui_list_middle_on_top_component:_CalDisSqrToCenter(pos)
  local disX = pos.x - self._curCenter.x
  local disY = pos.y - self._curCenter.y
  local absDis = disX * disX + disY * disY
  return absDis
end

function ui_list_middle_on_top_component:_CalDisTo(posA, posB)
  local absDis = 0
  if self._bHorizon then
    absDis = math.abs(posA.x - posB.x)
  elseif self._bVertical then
    absDis = math.abs(posA.y - posB.y)
  end
  return absDis
end

function ui_list_middle_on_top_component:_RefreshClothListSibling()
  if not self._items then
    return
  end
  self:_CalCenterPos()
  local minAbs = -1
  local topCellPos = Vector2.zero
  for index, item in ipairs(self._items) do
    local curCellPos = item:GetGameObject().transform.anchoredPosition
    local absDis = self:_CalDisSqrToCenter(curCellPos)
    local tmpCell = self._sortTb[index]
    if minAbs < 0 or minAbs > absDis then
      minAbs = absDis
      topCellPos.x = curCellPos.x
      topCellPos.y = curCellPos.y
    end
    if tmpCell then
      tmpCell.idx = index
      tmpCell.absDis = absDis
      tmpCell.curPos = curCellPos
    end
  end
  table.sort(self._sortTb, function(a, b)
    return a.absDis > b.absDis
  end)
  for index, value in ipairs(self._sortTb) do
    local item = self._items[value.idx]
    local itemGo = item:GetGameObject()
    itemGo.transform:SetSiblingIndex(index - 1)
    if item.SetIsOnTop then
      if index == self._itemCount then
        item:SetIsOnTop(true)
      else
        item:SetIsOnTop(false)
      end
    end
    if item.SetOrderLayer then
      local absToTop = self:_CalDisTo(value.curPos, topCellPos)
      local orderLayer = self:_CalSkinListOrderLayer(absToTop + 1)
      item:SetOrderLayer(orderLayer)
    end
  end
end

function ui_list_middle_on_top_component:_CalSkinListOrderLayer(absDis)
  local param = self._cellWidth
  if param <= 0 then
    return 1
  end
  local a, b = math.modf(absDis / param)
  return a
end

function ui_list_middle_on_top_component:RefreshListOrder()
  self:_RefreshClothListSibling()
  self:_RefreshScrollBar()
end

function ui_list_middle_on_top_component:CalculateNewIndexByDragPos(dragBeginEPos, dragEndEPos, curSelIndex)
  if self._itemCount <= 1 then
    return 1
  end
  local absLPos = 0
  local cellSize = 1
  local dragBeginPos = 0
  local dragEndPos = 0
  local bDragForward = false
  if self._bHorizon then
    local lPosX = self._content.anchoredPosition.x - self._contentWidth / 2
    if 0 <= lPosX then
      lPosX = -self._cellWidth / 2
    elseif lPosX <= -self._contentWidth then
      lPosX = -self._contentWidth + self._cellWidth / 2
    end
    absLPos = math.abs(lPosX)
    cellSize = self._cellWidth
    dragBeginPos = dragBeginEPos.x
    dragEndPos = dragEndEPos.x
    if dragBeginPos > dragEndPos then
      bDragForward = true
    end
  elseif self._bVertical then
    local lPosY = self._content.anchoredPosition.y + self._contentHeight / 2
    if lPosY <= 0 then
      lPosY = self._cellHeight / 2
    elseif lPosY >= self._contentHeight then
      lPosY = self._contentHeight - self._cellHeight / 2
    end
    absLPos = math.abs(lPosY)
    cellSize = self._cellHeight
    dragBeginPos = dragBeginEPos.y
    dragEndPos = dragEndEPos.y
    if dragBeginPos < dragEndPos then
      bDragForward = true
    end
  end
  local c = math.ceil(absLPos / cellSize)
  local _, d = math.modf(absLPos / cellSize)
  local tmpIdx = curSelIndex
  tmpIdx = c
  if tmpIdx == curSelIndex then
    if bDragForward then
      if 0.7 < d then
        tmpIdx = tmpIdx + 1
      end
    elseif d < 0.3 then
      tmpIdx = tmpIdx - 1
    end
  end
  local finalIdx = 1
  if tmpIdx > self._itemCount then
    finalIdx = self._itemCount
  elseif tmpIdx <= 0 then
    finalIdx = 1
  else
    finalIdx = tmpIdx
  end
  return finalIdx
end

function ui_list_middle_on_top_component:CalcPosParam(idx)
  local pos = 0
  if not idx or self._itemCount <= 1 then
    return pos
  end
  if self._bHorizon then
    local startPos = self._contentWidth / 2 + self._cellWidth / 2
    pos = startPos - idx * self._cellWidth
  elseif self._bVertical then
    local startPos = -1 * self._contentHeight / 2 - self._cellHeight / 2
    pos = startPos + idx * self._cellHeight
  end
  return pos
end
