_class("AirActionMoveToLeave", AirActionBase)
AirActionMoveToLeave = AirActionMoveToLeave

function AirActionMoveToLeave:Constructor(pet, main)
  self._main = main
  self._pet = pet
  self._exitFloor = 1
  self._pos = self._main:ExitPosition()
  self._pet:SetAsLeavingPet()
  self._pet:SetState(AirPetState.Leaving)
end

function AirActionMoveToLeave:Start()
  self._moveToAction = AirActionMoveToDo:New(self._pet, self._exitFloor, self._pos, AircraftPetMoveType.ToLeave, self._main)
  self._moveToAction:Start()
  self._running = true
end

function AirActionMoveToLeave:IsOver()
  return not self._running
end

function AirActionMoveToLeave:Update(deltaTimeMS)
  if self._running then
    self._moveToAction:Update(deltaTimeMS)
    if self._moveToAction:IsOver() then
      self._running = false
      self:Stop()
    end
  end
end

function AirActionMoveToLeave:Duration()
  return nil
end

function AirActionMoveToLeave:CurrentTime()
  return nil
end

function AirActionMoveToLeave:Stop()
  if self._running then
  else
    self._main:RemoveRestPet(self._pet:TemplateID())
  end
end

function AirActionMoveToLeave:Dispose()
  if self._running then
    AirLog("离开中的星灵行为析构：", self._pet:TemplateID())
  end
end

function AirActionMoveToLeave:Pets()
  return {
    self._pet
  }
end
