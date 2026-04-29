_class("AirActionWandering", AirActionBase)
AirActionWandering = AirActionWandering

function AirActionWandering:Constructor(pet, pointHolder, duration, des, main)
  if pet == nil then
    return
  end
  self._main = main
  self._pet = pet
  self._pointHolder = pointHolder
  self._duration = duration
  self._curTime = 0
  self._des = des
end

function AirActionWandering:Start()
  self:_reset()
  self._running = true
  self._curTime = 0
  self._pet:SetState(AirPetState.Wandering)
end

function AirActionWandering:Update(deltaTimeMS)
  if self._running then
    if self._duration then
      self._curTime = self._curTime + deltaTimeMS
      if self._curTime > self._duration then
        self:Stop()
        return
      end
    end
    if self._moveAction:IsOver() then
      if self._standAction:IsOver() then
        self:_reset()
      else
        self._standAction:Update(deltaTimeMS)
      end
    else
      self._moveAction:Update(deltaTimeMS)
      if self._moveAction:IsOver() then
        local random = AirHelper.RandomRelationPet(self._main, self._pet)
        if not random then
          self._standAction:Start()
        end
      end
    end
  end
end

function AirActionWandering:IsOver()
  return not self._running
end

function AirActionWandering:Stop()
  if self._running then
    if not self._moveAction:IsOver() then
      self._moveAction:Stop()
    end
    if not self._standAction:IsOver() then
      self._standAction:Stop()
    end
    self._running = false
  end
  self._pointHolder:ReleasePoint(self._point)
end

function AirActionWandering:_reset()
  local release
  if self._point then
    release = self._point
  end
  self._point = self._pointHolder:PopPoint()
  self._moveAction = AirActionMove:New(self._pet, self._point:Pos(), self._pointHolder:Floor(), self._main, "移动-漫游")
  self._standAction = AirActionStand:New(self._pet, 15000, 25000)
  self._moveAction:Start()
  if release then
    if not release:IsOccupied() then
      Log.fatal(self._des)
    end
    self._pointHolder:ReleasePoint(release)
  end
end

function AirActionWandering:GetPets()
  return {
    self._pet
  }
end
