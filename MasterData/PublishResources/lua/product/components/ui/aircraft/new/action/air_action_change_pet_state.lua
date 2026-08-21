_class("AirActionChangePetState", AirActionBase)
AirActionChangePetState = AirActionChangePetState

function AirActionChangePetState:Constructor(pet, state)
  self._pet = pet
  self._targetState = state
end

function AirActionChangePetState:Start()
  self._pet:SetState(self._targetState)
  self:Stop()
end

function AirActionChangePetState:IsOver()
  return true
end

function AirActionChangePetState:Stop()
  self._running = false
end
