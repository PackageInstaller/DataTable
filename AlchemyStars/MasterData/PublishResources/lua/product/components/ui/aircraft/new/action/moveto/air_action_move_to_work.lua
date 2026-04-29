_class("AirActionMoveToWork", AirActionBase)
AirActionMoveToWork = AirActionMoveToWork

function AirActionMoveToWork:Constructor(main, pet)
  self._main = main
  self._pet = pet
  local room = self._main:GetRoomBySpaceID(self._pet:GetSpace())
  self._holder = room:GetPointHolder()
  self._point = self._holder:PopPoint()
  self._pet:SetState(AirPetState.MoveToWork)
end

function AirActionMoveToWork:Start()
  self._moveToAction = AirActionMoveToDo:New(self._pet, self._holder:Floor(), self._point:Pos(), AircraftPetMoveType.ToWork, self._main)
  self._moveToAction:Start()
  self._running = true
end

function AirActionMoveToWork:IsOver()
  return not self._running
end

function AirActionMoveToWork:Update(deltaTimeMS)
  if self._running then
    self._moveToAction:Update(deltaTimeMS)
    if self._moveToAction:IsOver() then
      self._running = false
      self:Stop()
    end
  end
end

function AirActionMoveToWork:Duration()
  return nil
end

function AirActionMoveToWork:CurrentTime()
  return nil
end

function AirActionMoveToWork:Stop()
  if self._running then
    self._running = false
  else
    self._main:StartWorkingAction(self._pet)
  end
  self._holder:ReleasePoint(self._point)
end

function AirActionMoveToWork:Dispose()
end

function AirActionMoveToWork:Pets()
  return {
    self._pet
  }
end
