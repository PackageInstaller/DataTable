_class("AirActionMoveAndWandering", AirActionBase)
AirActionMoveAndWandering = AirActionMoveAndWandering

function AirActionMoveAndWandering:Constructor(pet, main, area, duaration, point)
  self._pet = pet
  self._main = main
  self._area = area
  self._duration = duaration
  self._holder = self._main:GetPointHolder(self._area)
  self._point = point
end

function AirActionMoveAndWandering:Start()
  self._moveAction = AirActionMove:New(self._pet, self._point:Pos(), self._holder:Floor(), self._main, "移动-到漫游点")
  self._wanderAction = AirActionWandering:New(self._pet, self._holder, self._duration, "漫游", self._main)
  self._moveAction:Start()
  self._pet:SetMovingTargetArea(self._area)
  self._pet:SetState(AirPetState.Transiting)
  self._running = true
  self:LogStart()
end

function AirActionMoveAndWandering:Update(deltaTimeMS)
  if self._running then
    if self._moveAction and self._moveAction:IsOver() then
      if self._wanderAction:IsOver() then
        self._running = false
        self:Stop()
      else
        self._wanderAction:Update(deltaTimeMS)
      end
    else
      self._moveAction:Update(deltaTimeMS)
      if self._moveAction:IsOver() then
        self._pet:SetMovingTargetArea(nil)
        local random = AirHelper.RandomRelationPet(self._main, self._pet)
        if not random then
          self._wanderAction:Start()
        end
        self._holder:ReleasePoint(self._point)
      end
    end
  end
end

function AirActionMoveAndWandering:IsOver()
  return not self._running
end

function AirActionMoveAndWandering:Stop()
  if self._running then
    if not self._moveAction:IsOver() then
      self._moveAction:Stop()
    end
    if not self._wanderAction:IsOver() then
      self._wanderAction:Stop()
    end
    self._running = false
  else
    self._main:RandomActionForPet(self._pet)
  end
  self._holder:ReleasePoint(self._point)
  self:LogStop()
end

function AirActionMoveAndWandering:Duration()
  return self._wanderAction:Duration()
end

function AirActionMoveAndWandering:CurrentTime()
  return self._wanderAction:CurrentTime()
end

function AirActionMoveAndWandering:GetPets()
  return {
    self._pet
  }
end
