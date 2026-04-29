_class("AirActionMoveToWandering", AirActionBase)
AirActionMoveToWandering = AirActionMoveToWandering

function AirActionMoveToWandering:Constructor(main, pet, holder, point, duration)
  self._main = main
  self._pet = pet
  self._pet:SetState(AirPetState.Transiting)
  self._holder = holder
  self._point = point
  self._duration = duration
end

function AirActionMoveToWandering:Start()
  self._moveToAction = AirActionMoveToDo:New(self._pet, self._holder:Floor(), self._point:Pos(), AircraftPetMoveType.ToWandering, self._main)
  self._moveToAction:Start()
  self._running = true
end

function AirActionMoveToWandering:IsOver()
  return not self._running
end

function AirActionMoveToWandering:Update(deltaTimeMS)
  if self._running then
    self._moveToAction:Update(deltaTimeMS)
    if self._moveToAction:IsOver() then
      self._running = false
      self:Stop()
    end
  end
end

function AirActionMoveToWandering:Duration()
  return nil
end

function AirActionMoveToWandering:CurrentTime()
  return nil
end

function AirActionMoveToWandering:Stop()
  if self._running then
    self._moveToAction:Stop()
    self._running = false
  else
    local action = AirActionWandering:New(self._pet, self._holder, self._duration, "开始漫游", self._main)
    self._pet:StartMainAction(action)
  end
  self._holder:ReleasePoint(self._point)
end

function AirActionMoveToWandering:Dispose()
end

function AirActionMoveToWandering:Pets()
  return {
    self._pet
  }
end
