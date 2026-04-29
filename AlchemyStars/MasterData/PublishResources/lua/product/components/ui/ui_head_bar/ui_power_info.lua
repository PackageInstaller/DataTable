_class("UIPowerInfo", UICustomWidget)
UIPowerInfo = UIPowerInfo
local modf = math.modf

function UIPowerInfo:OnShow()
  self._inited = true
  self._tips = self:GetGameObject("tips")
  self._bgpos = self:GetUIComponent("Transform", "bgpos")
  self._tips:SetActive(false)
  self:AttachEvent(GameEventType.OnUIEmptyClose, self.OnUIEmptyClose)
  self:GetCurrentPhyTimer()
end

function UIPowerInfo:GetCurrentPhyTimer()
  self:Lock("UIPowerInfo:GetCurrentPhyTimer")
  GameGlobal.TaskManager():StartTask(self.OnGetCurrentPhyTimer, self)
end

function UIPowerInfo:OnGetCurrentPhyTimer(TT)
  local res, startTime, intervalRecoverTime, leftRecoverTime, allRecoverTime = self._roleModule:GetRecoverData(TT, 0)
  self:UnLock("UIPowerInfo:GetCurrentPhyTimer")
  if not self._inited then
    return
  end
  if not res:GetSucc() then
    Log.fatal("###OnGetCurrentPhyTimer false !")
    return
  end
  local gapTimeNum = intervalRecoverTime * 1000
  local nextTimeNum = leftRecoverTime * 1000
  if self._startPhyTimerEvent then
    GameGlobal.RealTimer():CancelEvent(self._startPhyTimerEvent)
    self._startPhyTimerEvent = nil
  end
  self._startPhyTimerEvent = GameGlobal.RealTimer():AddEvent(nextTimeNum, function(gapTimeNum)
    self:StartPhyTimer(gapTimeNum)
  end, gapTimeNum)
end

function UIPowerInfo:StartPhyTimer(gapTime)
  if self._startPhyTimerLoopEvent then
    GameGlobal.RealTimer():CancelEvent(self._startPhyTimerLoopEvent)
    self._startPhyTimerLoopEvent = nil
  end
  self:StartPhyTimerLoop()
  self._startPhyTimerLoopEvent = GameGlobal.RealTimer():AddEventTimes(gapTime, TimerTriggerCount.Infinite, function()
    self:StartPhyTimerLoop()
  end)
end

function UIPowerInfo:StartPhyTimerLoop()
  self:Lock("UIPowerInfo:StartPhyTimerLoop")
  GameGlobal.TaskManager():StartTask(self.OnStartPhyTimerLoop, self)
end

function UIPowerInfo:OnStartPhyTimerLoop(TT)
  local res = self._roleModule:GetRecoverData(TT, 0)
  self:UnLock("UIPowerInfo:StartPhyTimerLoop")
  if not self._inited then
    return
  end
  if res:GetSucc() then
    self:ShowPhyPoint()
  else
    Log.fatal("###GetRecoverData false --> result --> ", res:GetResult())
  end
end

function UIPowerInfo:ShowPhyPoint()
  self._currentPhysicalPower = self._roleModule:GetHealthPoint()
  if self._currentPhysicalPower == nil then
    self._currentPhysicalPower = 0
  end
  self._upperPhysicalPower = self._roleModule:GetHpLevelMax()
  if self._upperPhysicalPower == nil then
    self._upperPhysicalPower = 0
  end
  self:ChangePhysicalPowerNumber(self._currentPhysicalPower, self._upperPhysicalPower)
end

function UIPowerInfo:OnHide()
  self._inited = false
  self:DetachEvent(GameEventType.OnUIEmptyClose, self.OnUIEmptyClose)
  if self._startPhyTimerEvent then
    GameGlobal.RealTimer():CancelEvent(self._startPhyTimerEvent)
    self._startPhyTimerEvent = nil
  end
  if self._startPhyTimerLoopEvent then
    GameGlobal.RealTimer():CancelEvent(self._startPhyTimerLoopEvent)
    self._startPhyTimerLoopEvent = nil
  end
end

function UIPowerInfo:SetData(tr, currencyItem, matchType)
  self._bgpos.position = tr.position
  if currencyItem then
    self.powerItem = currencyItem
    currencyItem:SetBgCallBack(function()
      self:Lock("UIPowerOpened")
      GameGlobal.TaskManager():StartTask(self.OnBtnOpenPhysicalPowerWindowOnClick, self)
    end)
  else
    local sop = self:GetUIComponent("UISelectObjectPath", "power")
    self.currencyMenu = sop:SpawnObject("UICurrencyMenu")
    if matchType == MatchType.MT_Mission then
      self.currencyMenu:SetData({
        RoleAssetID.RoleAssetPhyPoint,
        RoleAssetID.RoleAssetDoubleRes
      }, false)
    else
      self.currencyMenu:SetData({
        RoleAssetID.RoleAssetPhyPoint
      }, false)
    end
    self.powerItem = self.currencyMenu:GetItemByTypeId(RoleAssetID.RoleAssetPhyPoint)
    self.powerItem:SetBgCallBack(function()
      self:Lock("UIPowerOpened")
      GameGlobal.TaskManager():StartTask(self.OnBtnOpenPhysicalPowerWindowOnClick, self)
    end)
    self.powerItem:SetAddCallBack(function()
      self:ShowDialog("UIGetPhyPointController")
    end)
    self.doubleItem = self.currencyMenu:GetItemByTypeId(RoleAssetID.RoleAssetDoubleRes)
    if self.doubleItem then
      local aircraftModule = self:GetModule(AircraftModule)
      local room = aircraftModule:GetResRoom()
      if room then
        self.doubleItem:Enable(true)
      else
        self.doubleItem:Enable(false)
      end
    end
  end
  self:ChangePhysicalPowerNumber(self._currentPhysicalPower, self._upperPhysicalPower)
end

function UIPowerInfo:Constructor()
  if not self._roleModule then
    self._roleModule = GameGlobal.GetModule(RoleModule)
  end
  self._canMoreThanUpper = true
  self._currentPhysicalPower = self._roleModule:GetHealthPoint()
  if self._currentPhysicalPower == nil then
    self._currentPhysicalPower = 0
  end
  self._upperPhysicalPower = self._roleModule:GetHpLevelMax()
  if self._upperPhysicalPower == nil then
    self._upperPhysicalPower = 0
  end
  self._isOpen = false
  self._currentTime = 0
  self._intervalTime = 0
  self._nextTime = 0
  self._allTime = 0
  self:AttachEvent(GameEventType.RolePropertyChanged, self.ChangePhysicalPowerNumber)
end

function UIPowerInfo:Dispose()
  self._currentTimeTex = nil
  self._nextTimeTex = nil
  self._allTimeTex = nil
  self._currentPhysicalPower = 0
  self._upperPhysicalPower = 0
  self._currentTime = 0
  self._intervalTime = 0
  self._nextTime = 0
  self._allTime = 0
  self._isOpen = false
  self._pos = nil
  self._safe = nil
  self:DetachEvent(GameEventType.RolePropertyChanged, self.ChangePhysicalPowerNumber)
end

function UIPowerInfo:OnBtnOpenPhysicalPowerWindowOnClick(TT)
  if not self._roleModule then
    self._roleModule = GameGlobal.GetModule(RoleModule)
  end
  local res, startTime, intervalRecoverTime, leftRecoverTime, allRecoverTime = self._roleModule:GetRecoverData(TT, 0)
  self:UnLock("UIPowerOpened")
  if not res:GetSucc() then
    return
  end
  if not self._pos then
    self._pos = self:GetUIComponent("RectTransform", "pos")
  end
  if not self._safe then
    self._safe = self:FindParentWithName(self._pos)
  end
  local posOffset = self._pos.position - self._safe.position
  self._currentPhysicalPower = self._roleModule:GetHealthPoint()
  if self._currentPhysicalPower == nil then
    self._currentPhysicalPower = 0
  end
  self._upperPhysicalPower = self._roleModule:GetHpLevelMax()
  if self._upperPhysicalPower == nil then
    self._upperPhysicalPower = 0
  end
  self:ChangePhysicalPowerNumber(self._currentPhysicalPower, self._upperPhysicalPower)
  self:OpenPowerInfoRunTime(startTime, intervalRecoverTime, leftRecoverTime, allRecoverTime, function()
    self:GetServerLastPhysicalPower()
  end)
  self:ShowDialog("UIEmptyController", posOffset, self._pos.sizeDelta)
end

function UIPowerInfo:OnUIEmptyClose()
  self:ClosePowerInfoRunTime()
end

function UIPowerInfo:FindParentWithName(trans)
  if trans.parent.name == "SafeArea" then
    return trans.parent
  else
    return self:FindParentWithName(trans.parent)
  end
end

function UIPowerInfo:GetServerLastPhysicalPower()
  GameGlobal.TaskManager():StartTask(self.OnGetServerLastPhysicalPower, self)
end

function UIPowerInfo:OnGetServerLastPhysicalPower(TT)
  if not self._roleModule then
    self._roleModule = GameGlobal.GetModule(RoleModule)
  end
  local res, startTime, intervalRecoverTime, leftRecoverTime, allRecoverTime = self._roleModule:GetRecoverData(TT, 0)
  if not res:GetSucc() then
    return
  end
  self._currentPhysicalPower = self._roleModule:GetHealthPoint()
  if self._currentPhysicalPower == nil then
    self._currentPhysicalPower = 0
  end
  self._upperPhysicalPower = self._roleModule:GetHpLevelMax()
  if self._upperPhysicalPower == nil then
    self._upperPhysicalPower = 0
  end
  self:ChangePhysicalPowerNumber(self._currentPhysicalPower, self._upperPhysicalPower)
end

function UIPowerInfo:AddPhysicalPower(value)
  self._currentPhysicalPower = self._currentPhysicalPower + value
  if not self._canMoreThanUpper and self._currentPhysicalPower > self._upperPhysicalPower then
    self._currentPhysicalPower = self._upperPhysicalPower
  end
  if self._currentPhysicalPower < 0 then
    self._currentPhysicalPower = 0
  end
  self:ChangePhysicalPowerNumber(self._currentPhysicalPower, self._upperPhysicalPower)
end

function UIPowerInfo:AddPhysicalPowerUpper(value)
  self._upperPhysicalPower = self._upperPhysicalPower + value
  if self._upperPhysicalPower < 0 then
    self._upperPhysicalPower = 0
  end
  self:ChangePhysicalPowerNumber(self._currentPhysicalPower, self._upperPhysicalPower)
end

function UIPowerInfo:ChangePhysicalPowerNumber(newCurrent, newUpper)
  local newc = newCurrent
  local newu = newUpper
  if newc < 0 then
    newc = 0
  end
  if newu < 0 then
    newu = 0
  end
  if not self._canMoreThanUpper and newc > newu then
    newc = newu
  end
  self._currentPhysicalPower = newc
  self._upperPhysicalPower = newu
  local currentStr, upperStr
  if self._currentPhysicalPower > 999 then
    currentStr = "999+"
  else
    currentStr = self._currentPhysicalPower .. ""
  end
  if self._upperPhysicalPower > 999 then
    upperStr = "999+"
  else
    upperStr = self._upperPhysicalPower .. ""
  end
  upperStr = "<color=#aeaeae>" .. upperStr .. "</color>"
  if self._currentPhysicalPower > self._upperPhysicalPower then
    currentStr = "<color=#00ffea>" .. currentStr .. "</color>"
  else
    currentStr = "<color=#ffffff>" .. currentStr .. "</color>"
  end
  if self.powerItem then
    self.powerItem:SetText(currentStr .. "<color=#ffffff>/</color>" .. upperStr)
  end
end

function UIPowerInfo:GetCurrentPhysicalPower()
  local isFull = false
  if self._currentPhysicalPower >= self._upperPhysicalPower then
    isFull = true
  end
  return isFull
end

function UIPowerInfo:OpenPowerInfoRunTime(startTime, intervalRecoverTime, leftRecoverTime, allRecoverTime, callback)
  self._tips:SetActive(true)
  if not self._currentTimeTex then
    self._currentTimeTex = self:GetUIComponent("UILocalizationText", "txtCurrent")
  end
  if not self._nextTimeTex then
    self._nextTimeTex = self:GetUIComponent("UILocalizationText", "txtNext")
  end
  if not self._allTimeTex then
    self._allTimeTex = self:GetUIComponent("UILocalizationText", "txtAll")
  end
  self._currentTime = startTime
  self._intervalTime = intervalRecoverTime
  self._nextTime = leftRecoverTime
  self._allTime = allRecoverTime
  self._addPhysicalPowerEvent = callback
  self:_RunTime()
  self:ChangeCurrentTime(self._currentTime)
  self:ChangeNextRecoverTime(self._nextTime)
  self:ChangeAllRecoverTime(self._allTime)
end

function UIPowerInfo:ClosePowerInfoRunTime()
  if not self._svrTimeModule then
    self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  end
  if self._currentTimeEvent then
    GameGlobal.RealTimer():CancelEvent(self._currentTimeEvent)
  end
  if self._InvertalTimeEvent then
    GameGlobal.RealTimer():CancelEvent(self._InvertalTimeEvent)
  end
  if self._AllTimeOverimeEvent then
    GameGlobal.RealTimer():CancelEvent(self._AllTimeOverimeEvent)
  end
  self._addPhysicalPowerEvent = nil
  self._isOpen = false
  self._tips:SetActive(false)
end

function UIPowerInfo:_RunTime()
  self._currentTimeEvent = GameGlobal.RealTimer():AddEventTimes(1000, TimerTriggerCount.Infinite, self.ChangeCurrentTimeEvent, self)
  if self._allTime == 0 then
    return
  end
  self._InvertalTimeEvent = GameGlobal.RealTimer():AddEventTimes(1000, TimerTriggerCount.Infinite, self.InvertalTimeOverEvent, self)
  self._AllTimeOverimeEvent = GameGlobal.RealTimer():AddEventTimes(self._allTime * 1000, 1, self.AllTimeOverEvent, self)
end

function UIPowerInfo:ChangeCurrentTimeEvent()
  local svrTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime()
  self._currentTime = modf(svrTime / 1000)
  self:ChangeCurrentTime(self._currentTime)
end

function UIPowerInfo:AllTimeOverEvent()
  if self._InvertalTimeEvent then
    GameGlobal.RealTimer():CancelEvent(self._InvertalTimeEvent)
  end
  if self._addPhysicalPowerEvent then
    self:_addPhysicalPowerEvent()
  end
  self:ChangeAllRecoverTime(0)
  self:ChangeNextRecoverTime(0)
end

function UIPowerInfo:InvertalTimeOverEvent()
  self._allTime = self._allTime - 1
  if self._allTime < 0 then
    self._allTime = 0
  end
  self:ChangeAllRecoverTime(self._allTime)
  self._nextTime = self._nextTime - 1
  while 0 >= self._nextTime do
    if self._addPhysicalPowerEvent then
      self:_addPhysicalPowerEvent()
    end
    self._nextTime = self._nextTime + self._intervalTime
  end
  self:ChangeNextRecoverTime(self._nextTime)
end

function UIPowerInfo:ChangeCurrentTime(time)
  local timeStr = os.date("%X", time)
  self:ShowCurrentTimeOnText(timeStr)
end

function UIPowerInfo:ChangeNextRecoverTime(nextTime)
  local timeTable = self:ChangeSecondToTime(nextTime)
  local timeStr = self:ChangeTimeTableToStr(timeTable)
  self:ShowNextTimeOnText(timeStr)
end

function UIPowerInfo:ChangeAllRecoverTime(allTime)
  local timeTable = self:ChangeSecondToTime(allTime)
  local timeStr = self:ChangeTimeTableToStr(timeTable)
  self:ShowAllTimeOnText(timeStr)
end

function UIPowerInfo:ShowCurrentTimeOnText(timeStr)
  if self._currentTimeTex then
    self._currentTimeTex:SetText(timeStr)
  end
end

function UIPowerInfo:ShowNextTimeOnText(timeStr)
  if self._nextTimeTex then
    self._nextTimeTex:SetText(timeStr)
  end
end

function UIPowerInfo:ShowAllTimeOnText(timeStr)
  if self._allTimeTex then
    self._allTimeTex:SetText(timeStr)
  end
end

function UIPowerInfo:ChangeSecondToTime(second)
  local timeTable = {
    hour = 0,
    min = 0,
    sec = 0
  }
  if second == 0 then
    return timeTable
  end
  local sec = modf(second % 60)
  local minAll = modf((second - sec) / 60)
  local min = modf(minAll % 60)
  local hour = modf((minAll - min) / 60)
  timeTable.hour = hour
  timeTable.min = min
  timeTable.sec = sec
  return timeTable
end

function UIPowerInfo:ChangeTimeToSecond(timeTable)
  local second = 0
  local hour = timeTable.hour
  local min = timeTable.min
  local sec = timeTable.sec
  if 0 < hour then
    second = hour * 3600 + second
  end
  if 0 < min then
    second = min * 60 + second
  end
  if 0 < sec then
    second = sec + second
  end
  return second
end

function UIPowerInfo:ChangeTimeTableToStr(timeTable)
  local hourStr, minStr, secStr
  if timeTable.hour > 9 then
    hourStr = timeTable.hour
  else
    hourStr = "0" .. timeTable.hour
  end
  if 9 < timeTable.min then
    minStr = timeTable.min
  else
    minStr = "0" .. timeTable.min
  end
  if 9 < timeTable.sec then
    secStr = timeTable.sec
  else
    secStr = "0" .. timeTable.sec
  end
  return hourStr .. ":" .. minStr .. ":" .. secStr
end

function UIPowerInfo:OnAppResume()
  if self._isOpen then
    self:BtnOpenPhysicalPowerWindowOnClick()
  end
end
