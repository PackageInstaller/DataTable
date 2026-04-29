_class("UpdatTimer", Object)
UpdatTimer = UpdatTimer

function UpdatTimer:Constructor(endTime, updateDetla, interCallback)
  self._endTime = endTime
  self._updateDetla = updateDetla
  self._interEvent = Callback:New(0, interCallback)
  self._beginEvent = nil
  self._endEvent = nil
  self._interTime = 0
  self._pause = false
  self._curTime = self:_GetCurrentTime()
  self._isEnd = false
end

function UpdatTimer:SetBeginEvent(callback, ...)
  self._beginEvent = Callback:New(0, callback, ...)
end

function UpdatTimer:SetInterEvent(callback, ...)
  self._interEvent = Callback:New(0, callback, ...)
end

function UpdatTimer:SetEndEvent(callback, ...)
  self._endEvent = Callback:New(0, callback, ...)
end

function UpdatTimer:SetPause(pause)
  self._pause = pause
end

function UpdatTimer:IsPauseing()
  return self._pause
end

function UpdatTimer:OnUpdateEvent(deltaTime)
  if self._pause then
    return
  end
  self._interTime = self._interTime + deltaTime
  if self._interTime >= self._updateDetla then
    self._interTime = 0
    self._interEvent:Call()
  end
  if self._endTime and not self._isEnd then
    self._endTime = self._endTime - deltaTime
    if 0 >= self._endTime then
      self._endEvent:Call()
      self._endEvent = nil
      self._isEnd = true
    end
  end
end

function UpdatTimer:_GetCurrentTime()
  if self._world then
    local timeService = self._world:GetService("Time")
    return timeService:GetCurrentTimeMs()
  else
    return GameGlobal:GetInstance():GetCurrentTime()
  end
end

function UpdatTimer:GetLastTime()
  return self._endTime > 0 and self._endTime or 0
end
