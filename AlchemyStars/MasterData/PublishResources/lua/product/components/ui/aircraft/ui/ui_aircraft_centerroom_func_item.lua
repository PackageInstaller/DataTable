_class("UIAircraftCenterRoomFuncItem", UICustomWidget)
UIAircraftCenterRoomFuncItem = UIAircraftCenterRoomFuncItem

function UIAircraftCenterRoomFuncItem:OnShow(uiParams)
  self:InitWidget()
  self.timeModule = self:GetModule(SvrTimeModule)
  self._enable = true
end

function UIAircraftCenterRoomFuncItem:OnClose()
  self._enable = false
  if self.sliderTimer then
    GameGlobal.Timer():CancelEvent(self.sliderTimer)
    self.sliderTimer = nil
  end
  if self.updateTimer then
    GameGlobal.Timer():CancelEvent(self.updateTimer)
    self.updateTimer = nil
  end
end

function UIAircraftCenterRoomFuncItem:OnHide()
  self:OnClose()
end

function UIAircraftCenterRoomFuncItem:InitWidget()
  self.textValue = self:GetUIComponent("UILocalizationText", "TextValue")
  self.textTitle = self:GetUIComponent("UILocalizationText", "TextTitle")
  self.slider = self:GetUIComponent("Image", "slider")
end

function UIAircraftCenterRoomFuncItem:SetData(roomData)
  self._roomData = roomData
  self:Refresh()
end

function UIAircraftCenterRoomFuncItem:Refresh()
  self.textTitle.text = string.format(StringTable.Get("str_aircraft_centerroom_affinity"), string.format("%.2f", self._roomData:GetPeriodAffinity()))
  local updateTime, updateCycle = self._roomData:GetAffinityUpdateTime()
  local cycleMin = math.floor(updateCycle / 60)
  local min = self:GetCurrentCycleTimeMIN(updateTime, updateCycle)
  self.slider.fillAmount = min / cycleMin
  self.textValue.text = string.format("%s/%smin", min, cycleMin)
  if self.sliderTimer then
    GameGlobal.Timer():CancelEvent(self.sliderTimer)
    self.sliderTimer = nil
  end
  if self.updateTimer then
    GameGlobal.Timer():CancelEvent(self.updateTimer)
    self.updateTimer = nil
  end
  self.sliderTimer = GameGlobal.Timer():AddEventTimes(10000, TimerTriggerCount.Infinite, function()
    local updateTime, updateCycle = self._roomData:GetAffinityUpdateTime()
    local cycleMin = math.floor(updateCycle / 60)
    local min = self:GetCurrentCycleTimeMIN(updateTime, updateCycle)
    self.slider.fillAmount = min / cycleMin
    self.textValue.text = string.format("%s/%smin", min, cycleMin)
  end)
  self.updateTimer = GameGlobal.Timer():AddEvent(self:GetRequestTimeMS(updateTime), function()
    GameGlobal.TaskManager():StartTask(self.RequestUpdateAffinity, self)
  end)
end

function UIAircraftCenterRoomFuncItem:GetCurrentCycleTimeMIN(updateTime, updateCycle)
  local now = self.timeModule:GetServerTime() / 1000 / 60
  return math.floor(now - (updateTime / 60 - updateCycle / 60))
end

function UIAircraftCenterRoomFuncItem:GetRequestTimeMS(updateTime)
  local now = math.floor(self.timeModule:GetServerTime())
  return updateTime * 1000 - now
end

function UIAircraftCenterRoomFuncItem:RequestUpdateAffinity(TT)
  local airModule = self:GetModule(AircraftModule)
  local result = airModule:UpdateAffinity(TT)
  if result:GetSucc() then
    if self._enable then
      self:Refresh()
    end
  else
    ToastManager.ShowToast(airModule:GetErrorMsg(result:GetResult()))
  end
end
