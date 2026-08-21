_class("AirActionMoveToWorkOld", AirActionBase)
AirActionMoveToWorkOld = AirActionMoveToWorkOld

function AirActionMoveToWorkOld:Constructor(pet, room, main)
  self._pet = pet
  self._room = room
  self._main = main
end

function AirActionMoveToWorkOld:Start()
  self._running = true
  self._point = self._room:GetPointHolder():PopPoint()
  self._moveAction = AirActionMove:New(self._pet, self._point:Pos(), self._room:Floor(), self._main, "移动-到工作房间")
  self._moveAction:Start()
  self._pet:SetState(AirPetState.MoveToWork)
  self:LogStart()
end

function AirActionMoveToWorkOld:Update(deltaTimeMS)
  if self._running then
    if self._moveAction:IsOver() then
      self._running = false
      self:Stop()
    else
      self._moveAction:Update(deltaTimeMS)
    end
  end
end

function AirActionMoveToWorkOld:IsOver()
  return not self._running
end

function AirActionMoveToWorkOld:Stop()
  if self._running then
    self._running = false
    self._moveAction:Stop()
  else
    self._main:StartWorkingAction(self._pet)
  end
  self._room:GetPointHolder():ReleasePoint(self._point)
end

function AirActionMoveToWorkOld:GetPets()
  return {
    self._pet
  }
end
