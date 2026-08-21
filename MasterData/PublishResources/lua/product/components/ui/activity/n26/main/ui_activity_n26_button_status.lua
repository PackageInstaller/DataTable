_class("UIActivityN26ButtonStatus", Object)
UIActivityN26ButtonStatus = UIActivityN26ButtonStatus

function UIActivityN26ButtonStatus:Constructor(checkComponentStatus, loadData, callback)
  self._callback = callback
  self._checkComponentStatusHandler = checkComponentStatus
  self._loadDataHandler = loadData
  self._buttonStatus = ActivityComponentStatus.None
  self._time = 0
  self._timerHandler = nil
  if self._checkComponentStatusHandler == nil or self._loadDataHandler == nil or self._callback == nil then
    return
  end
  self:CheckButtonStatus()
end

function UIActivityN26ButtonStatus:Release()
  self:CancelEvent()
end

function UIActivityN26ButtonStatus:CancelEvent()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function UIActivityN26ButtonStatus:CheckButtonStatus()
  self._buttonStatus, self._time = self._checkComponentStatusHandler()
  self:RefreshButtonStatus()
  if self._buttonStatus == ActivityComponentStatus.Open or self._buttonStatus == ActivityComponentStatus.TimeLock then
    self:StartTimer()
  end
end

function UIActivityN26ButtonStatus:StartTimer()
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

function UIActivityN26ButtonStatus:LoadData(TT)
  self._loadDataHandler(TT)
  self:CheckButtonStatus()
end

function UIActivityN26ButtonStatus:RefreshButtonStatus()
  if self._buttonStatus == ActivityComponentStatus.Open or self._buttonStatus == ActivityComponentStatus.TimeLock then
    self._callback(self._buttonStatus, UIActivityN26Helper.GetTimeString(self._time))
  elseif self._buttonStatus == ActivityComponentStatus.Close or self._buttonStatus == ActivityComponentStatus.MissionLock or self._buttonStatus == ActivityComponentStatus.ActivityEnd then
    self._callback(self._buttonStatus, "")
  end
end

function UIActivityN26ButtonStatus:GetButtontStatus()
  return self._buttonStatus
end

function UIActivityN26ButtonStatus:GetRemainTime()
  return self._time
end

function UIActivityN26ButtonStatus:GetRemainTimeStr()
  return UIActivityN26Helper.GetTimeString(self._time)
end
