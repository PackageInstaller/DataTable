_class("AirActionDestroyPet", AirActionBase)
AirActionDestroyPet = AirActionDestroyPet

function AirActionDestroyPet:Constructor(pet, main)
  self._pet = pet
  self._main = main
end

function AirActionDestroyPet:Start()
  self._main:RemoveRestPet(self._pet:TemplateID())
  self._running = false
end

function AirActionDestroyPet:Update(deltaTimeMS)
end

function AirActionDestroyPet:IsOver()
  return true
end

function AirActionDestroyPet:Stop()
end
