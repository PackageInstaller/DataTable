_class("UIS3HelperBanner", UICustomWidget)
UIS3HelperBanner = UIS3HelperBanner

function UIS3HelperBanner:OnShow()
  self:InitWidget()
end

function UIS3HelperBanner:OnHide()
  if self._scrollEvent then
    GameGlobal.Timer():CancelEvent(self._scrollEvent)
    self._scrollEvent = nil
  end
  self._matRes = {}
  if self._scrollPlayer and self._scrollPlayer:IsPlaying() then
    self._scrollPlayer:Stop()
  end
  self._scrollPlayer = nil
end

function UIS3HelperBanner:SetData(tabIndex)
  if tabIndex then
    self._tabIndex = tabIndex
  else
    self._tabIndex = 1
  end
  self:InitScrollView()
end

function UIS3HelperBanner:InitWidget()
  self._cellArea1Go = self:GetGameObject("CellArea1")
  self._cellArea2Go = self:GetGameObject("CellArea2")
  local cellGen1 = self:GetUIComponent("UISelectObjectPath", "CellArea1")
  self._cellWidget1 = cellGen1:SpawnObject("UIS3HelperBannerItem")
  local cellGen2 = self:GetUIComponent("UISelectObjectPath", "CellArea2")
  self._cellWidget2 = cellGen2:SpawnObject("UIS3HelperBannerItem")
  self._cellCanvas1 = self:GetUIComponent("CanvasGroup", "CellArea1")
  self._cellCanvas2 = self:GetUIComponent("CanvasGroup", "CellArea2")
  self._cellRect1 = self:GetUIComponent("RectTransform", "CellArea1")
  self._cellRect2 = self:GetUIComponent("RectTransform", "CellArea2")
  self._imageLeftGo = self:GetGameObject("ImageLeft")
  self._imageRightGo = self:GetGameObject("ImageRight")
  self._rollInterval = 5000
  if not self._tabIndex then
    self._tabIndex = 1
  end
end

function UIS3HelperBanner:ScrollToIndex(tarIdx)
  if self._count <= 1 then
    return
  end
  if self._scrollIng then
    return
  end
  local oldIndex = self._currIdx
  local tmpIdx = tarIdx
  if tmpIdx > self._count then
    self._currIdx = tmpIdx % self._count
  elseif tmpIdx <= 0 then
    self._currIdx = self._count
  else
    self._currIdx = tmpIdx
  end
  for i = 1, #self._idxItems do
    self._idxItems[i]:Flush(self._currIdx)
  end
  self:_SetCellForAnim()
  self:_SetScrollCellData(self._cellWidget1, oldIndex)
  self:_SetScrollCellData(self._cellWidget2, self._currIdx)
  self:_PlayScrollAnim(oldIndex < self._currIdx)
  self:_CreateScrollEvent()
  self:_RefreshArrowBtn()
end

function UIS3HelperBanner:ImageLeftOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  if self._count <= 1 then
    return
  end
  local tmpIdx = self._currIdx - 1
  self:ScrollToIndex(tmpIdx)
end

function UIS3HelperBanner:ImageRightOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  if self._count <= 1 then
    return
  end
  local tmpIdx = self._currIdx + 1
  self:ScrollToIndex(tmpIdx)
end

function UIS3HelperBanner:InitScrollView()
  self:_SetCellForNormal()
  self._isDarging = false
  self._isScrollReady = false
  self:_CreateScrollData()
  self._currIdx = 1
  self:_CreateScrollItem()
  self:_CreateScrollEvent()
  self:_RefreshArrowBtn()
  self._isScrollReady = true
end

function UIS3HelperBanner:_RefreshArrowBtn()
  local showLeft = true
  if self._currIdx == 1 then
    showLeft = false
  end
  local showRight = true
  if self._currIdx == self._count then
    showRight = false
  end
  self._imageLeftGo:SetActive(showLeft)
  self._imageRightGo:SetActive(showRight)
end

function UIS3HelperBanner:_MatchOpenTime(cfgTab)
  local loginModule = self:GetModule(LoginModule)
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local svrTime = svrTimeModule:GetServerTime() * 0.001
  local retTab = {}
  for k, v in pairs(cfgTab) do
    local openTime = 0
    if v.OpenTime ~= nil then
      openTime = loginModule:GetTimeStampByTimeStr(v.OpenTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
    end
    if svrTime >= openTime then
      table.insert(retTab, v)
    end
  end
  return retTab
end

function UIS3HelperBanner:_CreateScrollData()
  self._carouselTab = {}
  self._cfgTab = Cfg.cfg_season_helper({
    SeasonID = UISeasonID.S3,
    Tab = self._tabIndex
  })
  self._cfgTab = self:_MatchOpenTime(self._cfgTab)
  self._count = table.count(self._cfgTab)
  for i = 1, self._count do
    local cfg_item_middle = {}
    cfg_item_middle.data = self._cfgTab[i]
    table.insert(self._carouselTab, cfg_item_middle)
  end
  table.sort(self._carouselTab, function(a, b)
    if a.data.OrderInTab == b.data.OrderInTab then
      return a.data.ID < b.data.ID
    else
      return a.data.OrderInTab < b.data.OrderInTab
    end
  end)
end

function UIS3HelperBanner:_CreateScrollItem()
  self._grid = self:GetUIComponent("UISelectObjectPath", "grid")
  self._grid:SpawnObjects("UIS3HelperBannerIdxItem", self._count)
  self._idxItems = self._grid:GetAllSpawnList()
  for i = 1, #self._idxItems do
    self._idxItems[i]:SetData(i, self._currIdx)
  end
  self._content = self:GetUIComponent("RectTransform", "Content")
  self._scroll = self:GetGameObject("scroll")
  self._height = 745
  self._width = 1235
  local dataCount = #self._carouselTab
  if dataCount == 0 then
    self._scroll:SetActive(false)
    return
  end
  self:_SetCellForAnim()
  self:_SetScrollCellData(self._cellWidget2, 1)
  self:_PlayScrollAnim()
end

function UIS3HelperBanner:_SetScrollCellData(cellWidget, dataIndex)
  cellWidget:SetData(self._carouselTab[dataIndex], function(cfgID)
  end, function(eventData)
    if self._count <= 1 then
      return
    end
    if self._scrollIng then
      return
    end
    self._bDragPosY = eventData.position.y
    self._bDragPosX = eventData.position.x
    self._isDarging = true
    if self._scrollEvent then
      GameGlobal.Timer():CancelEvent(self._scrollEvent)
      self._scrollEvent = nil
    end
  end, function(eventData)
    if self._count <= 1 then
      return
    end
  end, function(eventData)
    if self._count <= 1 then
      return
    end
    if not self._isDarging then
      return
    end
    local triggerRange = self._width * 0.1
    local tmpIdx = self._currIdx
    local idChanged = false
    self._eDragPosY = eventData.position.y
    self._eDragPosX = eventData.position.x
    local delta = math.abs(self._eDragPosX - self._bDragPosX)
    if self._eDragPosX < self._bDragPosX then
      if triggerRange < delta and tmpIdx < self._count then
        tmpIdx = tmpIdx + 1
        idChanged = true
      else
      end
    else
      if triggerRange < delta and 1 < tmpIdx then
        tmpIdx = tmpIdx - 1
        idChanged = true
      else
      end
    end
    local newIdx = tmpIdx
    if tmpIdx > self._count then
      newIdx = tmpIdx % self._count
    elseif tmpIdx <= 0 then
      newIdx = self._count
    else
      newIdx = tmpIdx
    end
    self._isDarging = false
    if idChanged then
      self:ScrollToIndex(newIdx)
    else
      self:_CreateScrollEvent()
    end
  end)
end

function UIS3HelperBanner:_CreateScrollEvent()
  do return end
  local deltaTime = self._rollInterval
  local dir = 1
  if self._scrollEvent then
    GameGlobal.Timer():CancelEvent(self._scrollEvent)
    self._scrollEvent = nil
  end
  if 1 < self._count then
    self._scrollEvent = GameGlobal.Timer():AddEventTimes(deltaTime, TimerTriggerCount.Infinite, function()
      if not self._isDarging then
        local idx = self._currIdx
        if dir == 1 then
          idx = self._currIdx + 1
        else
          idx = self._currIdx - 1
        end
        if idx < 1 then
          idx = self._count
        elseif idx > self._count then
          idx = 1
        end
        for i = 1, #self._idxItems do
          self._idxItems[i]:Flush(idx)
        end
        self:ScrollToIndex(idx)
      end
    end)
  end
end

function UIS3HelperBanner:_SetCellForNormal()
  self._cellArea1Go:SetActive(true)
  self._cellArea2Go:SetActive(false)
  self._cellCanvas1.alpha = 1
  self._cellRect1.anchoredPosition = Vector2(0, 0)
  self._cellRect2.anchoredPosition = Vector2(0, 0)
end

function UIS3HelperBanner:_SetCellForAnim()
  self._cellArea1Go:SetActive(true)
  self._cellArea2Go:SetActive(true)
  self._cellRect1.anchoredPosition = Vector2(0, 0)
  self._cellRect2.anchoredPosition = Vector2(0, 0)
end

function UIS3HelperBanner:OnUpdate(deltaTimeMS)
  if self._isScrollReady and self._count <= 1 then
    return
  end
end

function UIS3HelperBanner:_PlayScrollAnim(bDown)
  self._cellCanvas1.alpha = 1
  self._cellCanvas2.alpha = 0
  self._scrollIng = true
  self._cellCanvas1:DOFade(0, 0.3)
  self._cellCanvas2:DOFade(1, 0.3):OnComplete(function()
    self:_SetCellForNormal()
    self:_SetScrollCellData(self._cellWidget1, self._currIdx)
    self._scrollIng = false
  end)
end
