_class("UIActivityN28ButtonStatus", Object)
UIActivityN28ButtonStatus = UIActivityN28ButtonStatus

function UIActivityN28ButtonStatus:Constructor(checkComponentStatus, loadData, callback)
  self._callback = callback
  self._checkComponentStatusHandler = checkComponentStatus
  self._loadDataHandler = loadData
  self._buttonStatus = ActivityN28ComponentStatus.None
  self._time = 0
  self._timerHandler = nil
  if self._checkComponentStatusHandler == nil or self._loadDataHandler == nil or self._callback == nil then
    return
  end
  self:CheckButtonStatus()
end

function UIActivityN28ButtonStatus:Release()
  self:CancelEvent()
end

function UIActivityN28ButtonStatus:CancelEvent()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function UIActivityN28ButtonStatus:CheckButtonStatus()
  self._buttonStatus, self._time = self._checkComponentStatusHandler()
  self:RefreshButtonStatus()
  if self._buttonStatus == ActivityN28ComponentStatus.Open or self._buttonStatus == ActivityN28ComponentStatus.TimeLock then
    self:StartTimer()
  end
end

function UIActivityN28ButtonStatus:StartTimer()
  self:CancelEvent()
  self._timerHandler = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self._time = self._time - 1
    if self._time <= 0 then
      GameGlobal.TaskManager():StartTask(self.LoadData, self)
      self:CancelEvent()
    end
    self:RefreshButtonStatus()
  end)
end

function UIActivityN28ButtonStatus:LoadData(TT)
  self._loadDataHandler(TT)
  self:CheckButtonStatus()
end

function UIActivityN28ButtonStatus:RefreshButtonStatus()
  if self._buttonStatus == ActivityN28ComponentStatus.Open or self._buttonStatus == ActivityN28ComponentStatus.TimeLock then
    self._callback(self._buttonStatus, UIActivityN28Helper.GetTimeString(self._time))
  elseif self._buttonStatus == ActivityN28ComponentStatus.Close or self._buttonStatus == ActivityN28ComponentStatus.MissionLock or self._buttonStatus == ActivityN28ComponentStatus.ActivityEnd then
    self._callback(self._buttonStatus, "")
  end
end

function UIActivityN28ButtonStatus:GetButtontStatus()
  return self._buttonStatus
end

function UIActivityN28ButtonStatus:GetRemainTime()
  return self._time
end

function UIActivityN28ButtonStatus:GetRemainTimeStr()
  return UIActivityN28Helper.GetTimeString(self._time)
end
