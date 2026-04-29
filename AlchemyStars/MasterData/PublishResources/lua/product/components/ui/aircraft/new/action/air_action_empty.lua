_class("AirActionEmpty", AirActionBase)
AirActionEmpty = AirActionEmpty

function AirActionEmpty:Constructor(pet)
  self._pet = pet
end

function AirActionEmpty:Start()
  self._running = true
end

function AirActionEmpty:Update(deltaTimeMS)
end

function AirActionEmpty:IsOver()
  return not self._running
end

function AirActionEmpty:Stop()
  self._running = false
end

function AirActionEmpty:GetPets()
  return {
    self._pet
  }
end
