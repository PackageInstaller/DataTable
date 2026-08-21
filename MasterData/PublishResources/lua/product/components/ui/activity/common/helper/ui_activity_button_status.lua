_class("UIActivityButtonStatus", Object)
UIActivityButtonStatus = UIActivityButtonStatus

function UIActivityButtonStatus:Constructor(checkComponentStatus, loadData, callback, dayStr, hourStr, minusStr, lessOneMinusStr)
  self._callback = callback
  self._checkComponentStatusHandler = checkComponentStatus
  self._loadDataHandler = loadData
  self._dayStr = dayStr
  self._hourStr = hourStr
  self._minusStr = minusStr
  self._lessOneMinusStr = lessOneMinusStr
  self._buttonStatus = ActivityComponentStatus.None
  self._time = 0
  self._timerHandler = nil
  if self._checkComponentStatusHandler == nil or self._loadDataHandler == nil or self._callback == nil then
    return
  end
  self:CheckButtonStatus()
end

function UIActivityButtonStatus:Release()
  self:CancelEvent()
end

function UIActivityButtonStatus:CancelEvent()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function UIActivityButtonStatus:CheckButtonStatus()
  self._buttonStatus, self._time = self._checkComponentStatusHandler()
  self:RefreshButtonStatus()
  if self._buttonStatus == ActivityComponentStatus.Open or self._buttonStatus == ActivityComponentStatus.TimeLock then
    self:StartTimer()
  end
end

function UIActivityButtonStatus:StartTimer()
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

function UIActivityButtonStatus:LoadData(TT)
  self._loadDataHandler(TT)
  self:CheckButtonStatus()
end

function UIActivityButtonStatus:RefreshButtonStatus()
  if self._buttonStatus == ActivityComponentStatus.Open or self._buttonStatus == ActivityComponentStatus.TimeLock then
    self._callback(self._buttonStatus, UIActivityCustomHelper.GetTimeString(self._time, self._dayStr, self._hourStr, self._minusStr, self._lessOneMinusStr))
  elseif self._buttonStatus == ActivityComponentStatus.Close or self._buttonStatus == ActivityComponentStatus.MissionLock or self._buttonStatus == ActivityComponentStatus.ActivityEnd then
    self._callback(self._buttonStatus, "")
  end
end

function UIActivityButtonStatus:GetButtontStatus()
  return self._buttonStatus
end

function UIActivityButtonStatus:GetRemainTime()
  return self._time
end

function UIActivityButtonStatus:GetRemainTimeStr()
  return UIActivityCustomHelper.GetTimeString(self._time)
end
