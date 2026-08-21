_class("AirActionStand", AirActionBase)
AirActionStand = AirActionStand

function AirActionStand:Constructor(pet, min, max)
  self._pet = pet
  if max then
    self._duration = math.random(min, max)
  else
    self._duration = min
  end
end

function AirActionStand:Start()
  self._running = true
  self._curTime = 0
  self._pet:Anim_Stand()
  self:LogStart()
end

function AirActionStand:Update(deltaTimeMS)
  if self._running then
    self._curTime = self._curTime + deltaTimeMS
    if self._curTime > self._duration then
      self:Stop()
    end
  end
end

function AirActionStand:IsOver()
  return not self._running
end

function AirActionStand:Stop()
  self._running = false
  self._curTime = self._duration + 1
  self:LogStop()
end

function AirActionStand:GetPets()
  return {
    self._pet
  }
end
