_class("UITimerHolder", Object)
UITimerHolder = UITimerHolder

function UITimerHolder:Constructor()
  self._timers = {}
  
  function self._onTigger(key, func)
    if not self._timers then
      return
    end
    self._timers[key] = nil
    func()
  end
  
  function self._onTiggerInfinite(key, func)
    if not self._timers then
      return
    end
    func()
  end
end

function UITimerHolder:StartTimer(key, time, func)
  if not key then
    Log.fatal("Key must be given!")
    return
  end
  if self._timers[key] then
    self:StopTimer(key)
  end
  self._timers[key] = GameGlobal.Timer():AddEvent(time, self._onTigger, key, func)
end

function UITimerHolder:StartTimerInfinite(key, time, func)
  if self._timers[key] then
    self:StopTimer(key)
  end
  self._timers[key] = GameGlobal.Timer():AddEventTimes(time, TimerTriggerCount.Infinite, self._onTiggerInfinite, key, func)
end

function UITimerHolder:StopTimer(key)
  local event = self._timers[key]
  if event then
    self._timers[key] = nil
    GameGlobal.Timer():CancelEvent(event)
  end
end

function UITimerHolder:Dispose()
  if not self._timers then
    return
  end
  for key, event in pairs(self._timers) do
    GameGlobal.Timer():CancelEvent(event)
  end
  self._timers = nil
end
