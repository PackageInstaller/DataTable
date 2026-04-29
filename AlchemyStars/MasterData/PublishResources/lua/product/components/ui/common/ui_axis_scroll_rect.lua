_class("UIAxisScrollRect", GameEventListener)
UIAxisScrollRect = UIAxisScrollRect
_class("UIAxisScrollRectData", Object)
UIAxisScrollRectData = UIAxisScrollRectData
_class("UIAxisScrollRectDataUI", Object)
UIAxisScrollRectDataUI = UIAxisScrollRectDataUI
_class("UIAxisScrollRectAdsorb", Object)
UIAxisScrollRectAdsorb = UIAxisScrollRectAdsorb

function UIAxisScrollRectData:Constructor()
  self._luaIndex = 0
  self._ui = nil
end

function UIAxisScrollRectDataUI:Constructor()
  self._data = nil
  self._widget = nil
end

function UIAxisScrollRectAdsorb:Constructor()
  self._valid = false
  self._cdTick = 0
  self._cdPeriod = 0
  self._targetValue = 0
  self._speed = 0
end

function UIAxisScrollRectAdsorb:Start(cdPeriod, currentValue, targetValue)
  self._valid = true
  self._cdTick = 0
  self._cdPeriod = cdPeriod
  self._targetValue = targetValue
  self._speed = (targetValue - currentValue) / cdPeriod
end

function UIAxisScrollRectAdsorb:Stop()
  self._valid = false
end

UIAxisScrollRect.PI_2 = 1.5707963
UIAxisScrollRect.PI = 3.1415926
UIAxisScrollRect.TWO_PI = 6.2831852

function UIAxisScrollRect:Constructor(world)
  local baseConstructor = GameEventListener.Constructor
  baseConstructor(self, world)
  self._gameGlobal = GameGlobal:GetInstance()
  self._h3dTimer = self._gameGlobal.h3dTimer
  self._uiController = nil
  self._scrollRect = nil
  self._scrollContent = nil
  self._splitCount = 0
  self._splitAlpha = 0
  self._uiCustomEventListener = UICustomUIEventListener:New()
  self._timerHandler = nil
  self._fnContentChanged = nil
  self._fnSelectChanged = nil
  self._fnScrollChanged = nil
  self._fnEndscrollEvent = nil
  self._fnEndscrollEventNextFrame = false
  self._uiCustomWidgetName = nil
  self._cellSize = nil
  self._spacing = 0
  self._vertLayout = false
  self._layoutDirty = false
  self._axisR = 0
  self._contentSize = 0
  self._autoAdsorb = true
  self._autoAdsorbDirty = false
  self._autoAdsorbPeriod = 200
  self._autoAdsorbThreshold = 5.0E-4
  self._isDragging = false
  self._emptyCount = 0
  self._dataCount = 0
  self._selectedPreLuaIndex = 0
  self._selectedLuaIndex = 0
  self._beginDragPosition = Vector2(0, 0)
  self._scrollLimit = Vector4(-1, -1, -1, -1)
  self._scaleRuler = {}
  self._adsorb = UIAxisScrollRectAdsorb:New()
  self._itemDatas = {}
  self._itemDataUIs = {}
end

function UIAxisScrollRect:Dispose()
  self._itemDatas = nil
  self._itemDataUIs = nil
  self._uiCustomEventListener:Dispose()
  self._uiCustomEventListener = nil
  if self._timerHandler ~= nil then
    self._h3dTimer:CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  self._gameGlobal = nil
  self._h3dTimer = nil
end

function UIAxisScrollRect:AddScaleRuler(orgScale, zoomInScaleX, zoomInScaleY)
  table.insert(self._scaleRuler, Vector3(orgScale, zoomInScaleX, zoomInScaleY))
end

function UIAxisScrollRect:Create(uiController, scrollRectName, contentName, splitCount)
  self._uiController = uiController
  self._scrollRect = uiController:GetUIComponent("ScrollRect", scrollRectName)
  self._scrollContent = uiController:GetUIComponent("UISelectObjectPath", contentName)
  self._splitCount = splitCount
  self._splitAlpha = self.TWO_PI / self._splitCount
  local content = self._scrollRect.content
  local image = content:GetComponent("Image")
  if image == nil then
    image = content.gameObject:AddComponent(typeof(UnityEngine.UI.Image))
    image.color = Color(1, 1, 1, 0)
  end
  local event = self._uiCustomEventListener.Get(content.gameObject)
  self._uiCustomEventListener:AddUICustomEventListener(event, UIEvent.BeginDrag, function(a)
    self:OnBeginDrag(a)
  end)
  self._uiCustomEventListener:AddUICustomEventListener(event, UIEvent.Drag, function(a)
    self:OnDrag(a)
  end)
  self._uiCustomEventListener:AddUICustomEventListener(event, UIEvent.EndDrag, function(a)
    self:OnEndDrag(a)
  end)
  self._scrollRect.onValueChanged:AddListener(function(value)
    self:OnScrollRectMoved(value)
  end)
  self._timerHandler = self._h3dTimer:AddEventTimes(0, TimerTriggerCount.Infinite, function()
    self:OnTimer()
  end)
end

function UIAxisScrollRect:SpawnObjects(uiCustomWidgetName, cellSize, spacing, isVert)
  self._uiCustomWidgetName = uiCustomWidgetName
  self._cellSize = cellSize
  self._spacing = spacing
  self._vertLayout = isVert
  self._axisR = self._splitCount * (self:GetItemSize() + self._spacing) / self.TWO_PI
  self._axisR = (self:GetItemSize() + self._spacing) * 0.5 / math.tan(self._splitAlpha * 0.5)
  local itemCount = math.ceil(self._splitCount * 0.5)
  self._itemPool = self._scrollContent:SpawnObjects(self._uiCustomWidgetName, itemCount)
  for i = 1, itemCount do
    local uiWidget = self._itemPool[i]
    uiWidget:Enable(false)
    self:SetWidgetUIToCellSize(uiWidget)
    local dataUI = UIAxisScrollRectDataUI:New()
    dataUI._widget = uiWidget
    table.insert(self._itemDataUIs, dataUI)
  end
  self:UpdateEmptyCount()
  return self._itemPool
end

function UIAxisScrollRect:SetWidgetUIToCellSize(uiWidget)
  local view = uiWidget:View()
  local rt = view.transform
  rt.pivot = Vector2.one * 0.5
  rt.localScale = Vector3.one
  rt.anchorMin = Vector2.one * 0.5
  rt.anchorMax = Vector2.one * 0.5
  rt.sizeDelta = self._cellSize
  rt.anchoredPosition = Vector2.zero
end

function UIAxisScrollRect:AddContentChangedListener(fnListener)
  self._fnContentChanged = fnListener
end

function UIAxisScrollRect:AddSelectChangedListener(fnListener)
  self._fnSelectChanged = fnListener
end

function UIAxisScrollRect:AddScrollChangedListener(fnListener)
  self._fnScrollChanged = fnListener
end

function UIAxisScrollRect:AddEndScrollEventListener(fnListener)
  self._fnEndscrollEvent = fnListener
end

function UIAxisScrollRect:SetDataCount(dataCount, selectedLuaIndex, updateLayout)
  self._dataCount = dataCount
  if 1 <= selectedLuaIndex and selectedLuaIndex <= self._dataCount then
    self._selectedLuaIndex = selectedLuaIndex
  else
    self._selectedLuaIndex = 1
  end
  for i = 1, self._dataCount do
    local data = UIAxisScrollRectData:New()
    data._luaIndex = i
    table.insert(self._itemDatas, data)
  end
  self:UpdateContentSize()
  self._layoutDirty = true
  if updateLayout ~= false then
    self:FireUpdateItemLayout()
  end
end

function UIAxisScrollRect:FireUpdateItemLayout()
  if self._layoutDirty then
    self._layoutDirty = false
    self:ScrollTo(self._selectedLuaIndex, nil)
    self:UpdateItemLayout()
    self:FireSelectChanged()
  elseif self._fnContentChanged ~= nil then
    for k, v in pairs(self._itemDataUIs) do
      if v._data ~= nil then
        self._fnContentChanged(v._widget, v._data._luaIndex)
      end
    end
  end
end

function UIAxisScrollRect:GetItemSize()
  if self._vertLayout then
    return self._cellSize.y
  else
    return self._cellSize.x
  end
end

function UIAxisScrollRect:GetViewportSize()
  local viewport = self._scrollRect.viewport
  if self._vertLayout then
    return viewport.rect.height
  else
    return viewport.rect.width
  end
end

function UIAxisScrollRect:SetContentSize(contentSize)
  self._contentSize = contentSize
  local content = self._scrollRect.content
  local sizeDelta = content.sizeDelta
  if self._vertLayout then
    sizeDelta.y = contentSize
  else
    sizeDelta.x = contentSize
  end
  content.sizeDelta = sizeDelta
end

function UIAxisScrollRect:GetNormalizedPosition()
  if self._vertLayout then
    return 1 - self._scrollRect.verticalNormalizedPosition
  else
    return self._scrollRect.horizontalNormalizedPosition
  end
end

function UIAxisScrollRect:SetNormalizedPosition(value)
  if self._vertLayout then
    self._scrollRect.verticalNormalizedPosition = 1 - value
  else
    self._scrollRect.horizontalNormalizedPosition = value
  end
end

function UIAxisScrollRect:NormalizedPosition(value)
  if self._vertLayout then
    return 1 - value
  else
    return value
  end
end

function UIAxisScrollRect:SetItemUIPosition(uiItem, position)
  local view = uiItem._widget:View()
  local rt = view.transform
  local anchoredPosition = rt.anchoredPosition
  local anchorPivot = (rt.anchorMin + rt.anchorMax) * 0.5
  if self._vertLayout then
    anchoredPosition.y = self._contentSize * anchorPivot.y - position
  else
    anchoredPosition.x = position - self._contentSize * anchorPivot.x
  end
  rt.anchoredPosition = anchoredPosition
end

function UIAxisScrollRect:GetScrollVelocity()
  local velocity = self._scrollRect.velocity
  if self._vertLayout then
    return velocity.y
  else
    return velocity.x
  end
end

function UIAxisScrollRect:SetScrollVelocity(velocity)
  local inVelocity = velocity
  velocity = self._scrollRect.velocity
  if self._vertLayout then
    velocity.y = inVelocity
  else
    velocity.x = inVelocity
  end
  self._scrollRect.velocity = velocity
end

function UIAxisScrollRect:GetScrollDragDelta(position)
  local screenDelta = 0
  if self._vertLayout then
    screenDelta = position.y - self._beginDragPosition.y
  else
    screenDelta = self._beginDragPosition.x - position.x
  end
  return screenDelta
end

function UIAxisScrollRect:SetItemUIScale(uiItem, localScaleX, localScaleY)
  local view = uiItem._widget:View()
  local rt = view.transform
  rt.localScale = Vector3(localScaleX, localScaleY, 1)
end

function UIAxisScrollRect:UpdateEmptyCount()
  local itemSize = self:GetItemSize() + self._spacing
  local viewSize = self:GetViewportSize()
  self._emptyCount = viewSize / itemSize
  self._emptyCount = math.ceil(self._emptyCount - 1)
end

function UIAxisScrollRect:UpdateContentSize()
  local itemSize = self:GetItemSize() + self._spacing
  local contentSize = itemSize * (self._emptyCount + self._dataCount)
  self:SetContentSize(contentSize)
end

function UIAxisScrollRect:OnBeginDrag(eventData)
  self._adsorb:Stop()
  self._isDragging = true
  self._beginDragPosition = eventData.position
  self._scrollRect:OnBeginDrag(eventData)
end

function UIAxisScrollRect:OnDrag(eventData)
  self._adsorb:Stop()
  self._isDragging = true
  self._scrollRect:OnDrag(eventData)
end

function UIAxisScrollRect:OnEndDrag(eventData)
  self._adsorb:Stop()
  self._isDragging = false
  self._scrollRect:OnEndDrag(eventData)
end

function UIAxisScrollRect:OnScrollRectMoved(value)
  if not self._adsorb._valid then
    self._autoAdsorbDirty = true
  end
  local scrollValue = self:GetNormalizedPosition()
  if self._scrollLimit.z > 0 and scrollValue < self._scrollLimit.z then
    self:SetNormalizedPosition(self._scrollLimit.z)
    value = self._scrollRect.normalizedPosition
  end
  if 0 < self._scrollLimit.w and scrollValue > self._scrollLimit.w then
    self:SetNormalizedPosition(self._scrollLimit.w)
    value = self._scrollRect.normalizedPosition
  end
  if self._fnScrollChanged ~= nil then
    self._fnScrollChanged(value)
  end
  self:UpdateSelectedIndex()
  self:UpdateItemLayout()
  self:FireSelectChanged()
end

function UIAxisScrollRect:OnTimer()
  local deltaTime = self._gameGlobal:GetDeltaTime()
  if self._fnEndscrollEventNextFrame then
    self._fnEndscrollEventNextFrame = false
    if self._fnEndscrollEvent ~= nil then
      self._fnEndscrollEvent(self._scrollRect.normalizedPosition)
    end
  end
  self:CheckAdsorbMoved(deltaTime)
  self:AutoAdsorbMoved(deltaTime)
end

function UIAxisScrollRect:GetEmptyItemUI()
  for k, v in pairs(self._itemDataUIs) do
    if v._data == nil then
      return v
    end
  end
end

function UIAxisScrollRect:GetScaleRuler(orgScale)
  local minScale, maxScale
  for k, v in pairs(self._scaleRuler) do
    if orgScale <= v.x then
      maxScale = v
      break
    end
    minScale = v
  end
  local zoomInScale = Vector2(1, 1)
  if maxScale ~= nil then
    local dt = (orgScale - minScale.x) / (maxScale.x - minScale.x)
    zoomInScale.x = minScale.y + dt * (maxScale.y - minScale.y)
    zoomInScale.y = minScale.z + dt * (maxScale.z - minScale.z)
  end
  return zoomInScale
end

function UIAxisScrollRect:UpdateSelectedIndex()
  local pastScrollValue = self:GetNormalizedPosition()
  pastScrollValue = math.min(pastScrollValue, 1)
  pastScrollValue = math.max(pastScrollValue, 0)
  local viewportSize = self:GetViewportSize()
  local itemSize = self:GetItemSize() + self._spacing
  local pastScrollHeight = pastScrollValue * (self._contentSize - viewportSize)
  local pastItemCount = pastScrollHeight / itemSize
  local luaIndex = 1 + math.floor(pastItemCount + 0.5)
  if luaIndex <= self._dataCount then
    self._selectedLuaIndex = luaIndex
  end
end

function UIAxisScrollRect:UpdateItemLayout()
  local itemSize = self:GetItemSize() + self._spacing
  local scrollValue = self:GetNormalizedPosition()
  local viewSize = self:GetViewportSize()
  local totalScrollSize = self._contentSize - viewSize
  local identityValue = (self._selectedLuaIndex - 1) * itemSize / totalScrollSize
  local offsetValue = identityValue - scrollValue
  local offsetAlpha = offsetValue * totalScrollSize / self._axisR
  local deltaMin = math.floor((offsetAlpha + self.PI_2) / self._splitAlpha)
  local deltaMax = math.floor((self.PI_2 - offsetAlpha) / self._splitAlpha)
  local dataUICount = #self._itemDataUIs
  if dataUICount < deltaMin + deltaMax + 1 then
    deltaMax = deltaMax - 1
  end
  local theMinAlpha = offsetAlpha - deltaMin * self._splitAlpha
  local theMinIndex = self._selectedLuaIndex - deltaMin
  local theMaxIndex = self._selectedLuaIndex + deltaMax
  local theTmpIndex = theMinIndex
  theMinIndex = math.max(theMinIndex, 1)
  theMinAlpha = theMinAlpha + (theMinIndex - theTmpIndex) * self._splitAlpha
  theMaxIndex = math.min(theMaxIndex, self._dataCount)
  for k, v in pairs(self._itemDatas) do
    if v._ui ~= nil and (theMinIndex > v._luaIndex or theMaxIndex < v._luaIndex) then
      v._ui._data = nil
      v._ui._widget:Enable(false)
      v._ui = nil
    end
  end
  local cache = {}
  local identityPosition = scrollValue * totalScrollSize + viewSize * 0.5
  for i = theMinIndex, theMaxIndex do
    local itemAlpha = theMinAlpha + (i - theMinIndex) * self._splitAlpha
    local itemData = self._itemDatas[i]
    if itemData._ui == nil then
      local ui = self:GetEmptyItemUI()
      ui._data = itemData
      ui._widget:Enable(true)
      itemData._ui = ui
      if self._fnContentChanged ~= nil then
        self._fnContentChanged(ui._widget, i)
      end
    end
    local deltaPosition = math.sin(itemAlpha) * self._axisR
    local absItemAlpha = math.abs(itemAlpha)
    local localScale = math.sin(self.PI_2 - absItemAlpha)
    local cacheItem = {
      itemAlpha = itemAlpha,
      deltaPosition = deltaPosition,
      localScale = localScale
    }
    cache[i] = cacheItem
  end
  local totalOffset = 0
  for i = self._selectedLuaIndex, theMinIndex, -1 do
    local cacheItem = cache[i]
    local itemData = self._itemDatas[i]
    local offset = totalOffset
    local zoomInScale = self:GetScaleRuler(cacheItem.localScale)
    if i == self._selectedLuaIndex then
      local deltaSize = (zoomInScale.y - 1) * cacheItem.localScale * (itemSize * 0.5 - cacheItem.deltaPosition)
      offset = (zoomInScale.y - 1) * cacheItem.deltaPosition
      totalOffset = totalOffset - deltaSize
    else
      local deltaSize = (zoomInScale.y - 1) * cacheItem.localScale * itemSize
      offset = offset - deltaSize * 0.5
      totalOffset = totalOffset - deltaSize
    end
    self:SetItemUIPosition(itemData._ui, identityPosition + cacheItem.deltaPosition + offset)
    self:SetItemUIScale(itemData._ui, cacheItem.localScale * zoomInScale.x, cacheItem.localScale * zoomInScale.y)
  end
  local totalOffset = 0
  for i = self._selectedLuaIndex, theMaxIndex do
    local cacheItem = cache[i]
    local itemData = self._itemDatas[i]
    local offset = totalOffset
    local zoomInScale = self:GetScaleRuler(cacheItem.localScale)
    if i == self._selectedLuaIndex then
      local deltaSize = (zoomInScale.y - 1) * cacheItem.localScale * (itemSize * 0.5 + cacheItem.deltaPosition)
      offset = (zoomInScale.y - 1) * cacheItem.deltaPosition
      totalOffset = totalOffset + deltaSize
    else
      local deltaSize = (zoomInScale.y - 1) * cacheItem.localScale * itemSize
      offset = offset + deltaSize * 0.5
      totalOffset = totalOffset + deltaSize
    end
    self:SetItemUIPosition(itemData._ui, identityPosition + cacheItem.deltaPosition + offset)
    self:SetItemUIScale(itemData._ui, cacheItem.localScale * zoomInScale.x, cacheItem.localScale * zoomInScale.y)
  end
end

function UIAxisScrollRect:FireSelectChanged()
  if self._selectedPreLuaIndex == self._selectedLuaIndex then
    return
  end
  if self._fnSelectChanged ~= nil then
    local preUI = self:GetItemWidgetUI(self._selectedPreLuaIndex)
    local curUI = self:GetItemWidgetUI(self._selectedLuaIndex)
    self._fnSelectChanged(self._selectedPreLuaIndex, self._selectedLuaIndex, preUI, curUI)
  end
  self._selectedPreLuaIndex = self._selectedLuaIndex
end

function UIAxisScrollRect:CheckAdsorbMoved(deltaTime)
  if not self._autoAdsorb then
    return
  end
  if not self._autoAdsorbDirty then
    return
  end
  if self._isDragging then
    return
  end
  local velocity = self:GetScrollVelocity()
  if math.abs(velocity) > 100 then
    return
  end
  self._autoAdsorbDirty = false
  self:SetScrollVelocity(0)
  self:ScrollTo(self._selectedLuaIndex, self._autoAdsorbPeriod)
end

function UIAxisScrollRect:AutoAdsorbMoved(deltaTime)
  if not self._adsorb._valid then
    return
  end
  local scrollValue = self:GetNormalizedPosition()
  scrollValue = scrollValue + self._adsorb._speed * deltaTime
  self._adsorb._cdTick = self._adsorb._cdTick + deltaTime
  if self._adsorb._cdTick >= self._adsorb._cdPeriod then
    scrollValue = self._adsorb._targetValue
    self._adsorb:Stop()
  end
  self:SetNormalizedPosition(scrollValue)
  if not self._adsorb._valid then
    self._fnEndscrollEventNextFrame = true
  end
end

function UIAxisScrollRect:ScrollTo(luaIndex, durationMS)
  if luaIndex <= 0 or luaIndex > self._dataCount then
    return
  end
  if self._adsorb._valid then
    return
  end
  local itemSize = self:GetItemSize() + self._spacing
  local scrollValue = self:GetNormalizedPosition()
  local viewSize = self:GetViewportSize()
  local totalScrollSize = self._contentSize - viewSize
  local identityValue = (luaIndex - 1) * itemSize / totalScrollSize
  if math.abs(identityValue - scrollValue) > self._autoAdsorbThreshold then
    if durationMS == nil then
      self:SetNormalizedPosition(identityValue)
      self._fnEndscrollEventNextFrame = true
    else
      self._adsorb:Start(durationMS, scrollValue, identityValue)
    end
  end
  return self:NormalizedPosition(identityValue)
end

function UIAxisScrollRect:GetSelectedLuaIndex()
  return self._selectedLuaIndex
end

function UIAxisScrollRect:GetItemWidgetUI(luaIndex)
  local itemData
  if 1 <= luaIndex and luaIndex <= self._dataCount then
    itemData = self._itemDatas[luaIndex]
  end
  if itemData ~= nil and itemData._ui ~= nil then
    return itemData._ui._widget
  end
  return nil
end

function UIAxisScrollRect:GetDataCount()
  return self._dataCount
end

function UIAxisScrollRect:GetEmptyCount()
  return self._emptyCount
end

function UIAxisScrollRect:GetTotalCount()
  return self._dataCount + self._emptyCount
end

function UIAxisScrollRect:GetContentSize()
  return self._contentSize
end

function UIAxisScrollRect:GetItemSpacing()
  return self._spacing
end

function UIAxisScrollRect:SetAutoAdsorb(autoAdsorb, autoAdsorbPeriod)
  self._autoAdsorb = autoAdsorb
  self._autoAdsorbPeriod = autoAdsorbPeriod
  if self._autoAdsorbPeriod == nil then
    self._autoAdsorbPeriod = 200
  end
end

function UIAxisScrollRect:GetRawScrollRect()
  return self._scrollRect
end

function UIAxisScrollRect:GetScrollLimit()
  return Vector2(self._scrollLimit.x, self._scrollLimit.y)
end

function UIAxisScrollRect:SetScrollLimit(minLuaIndex, maxLuaIndex)
  self._scrollLimit.x = minLuaIndex
  self._scrollLimit.y = maxLuaIndex
  local itemSize = self:GetItemSize() + self._spacing
  local viewSize = self:GetViewportSize()
  local totalScrollSize = self._contentSize - viewSize
  if minLuaIndex <= 0 then
    self._scrollLimit.z = -1
  else
    self._scrollLimit.z = (minLuaIndex - 1) * itemSize / totalScrollSize
    self._scrollLimit.z = self._scrollLimit.z + 5.0E-4
  end
  if maxLuaIndex <= 0 then
    self._scrollLimit.w = -1
  else
    self._scrollLimit.w = (maxLuaIndex - 1) * itemSize / totalScrollSize
    self._scrollLimit.w = self._scrollLimit.w + 5.0E-4
  end
end
