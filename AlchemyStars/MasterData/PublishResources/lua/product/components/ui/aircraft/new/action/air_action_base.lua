_class("AirActionBase", Object)
AirActionBase = AirActionBase

function AirActionBase:Constructor()
  self._duration = 0
  self._curTime = 0
  self._running = false
  self._des = nil
end

function AirActionBase:Start()
  self._running = true
end

function AirActionBase:IsOver()
  return self._curTime > self._duration
end

function AirActionBase:Update(deltaTimeMS)
  if self._running and not self:IsOver() then
    self._curTime = self._curTime + deltaTimeMS
  end
end

function AirActionBase:Stop()
  self._running = false
  self._curTime = 0
  self._duration = 0
end

function AirActionBase:Duration()
  return self._duration
end

function AirActionBase:CurrentTime()
  return self._curTime
end

function AirActionBase:GetPets()
  return nil
end

function AirActionBase:Dispose()
end

function AirActionBase:Log(...)
  Log.debug("[AircraftAction] ", ...)
end

function AirActionBase:LogStart()
end

function AirActionBase:LogStop()
end

function AirActionBase:GetActionType()
  return AircraftActionType.None
end
