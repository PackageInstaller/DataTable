_class("AirActionLeave", AirActionBase)
AirActionLeave = AirActionLeave

function AirActionLeave:Constructor(pet, floor, main)
  self._pet = pet
  self._floor = floor
  self._main = main
  self._exit = self._main:ExitPosition()
end

function AirActionLeave:Start()
  self._moveAction = AirActionMove:New(self._pet, self._exit, self._floor, self._main, "移动-离开")
  self._destroyAction = AirActionDestroyPet:New(self._pet, self._main)
  self._moveAction:Start()
  self._running = true
  self._pet:SetState(AirPetState.Leaving)
  self:LogStart()
end

function AirActionLeave:Update(deltaTimeMS)
  if self._running then
    if self._moveAction:IsOver() then
      self._destroyAction:Start()
      self._running = false
      self:Stop()
    else
      self._moveAction:Update(deltaTimeMS)
    end
  end
end

function AirActionLeave:IsOver()
  return not self._running
end

function AirActionLeave:Stop()
  if self._running then
    if not self._moveAction:IsOver() then
      self._moveAction:Stop()
    end
    self._running = false
  end
  self._main = nil
  self._pet = nil
  self:LogStop()
end

function AirActionLeave:GetPets()
  return {
    self._pet
  }
end
