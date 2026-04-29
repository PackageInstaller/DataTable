_class("AircraftPetWaitElevator", Object)
AircraftPetWaitElevator = AircraftPetWaitElevator

function AircraftPetWaitElevator:Constructor(main, pet, index, linePos)
  self._main = main
  self._pet = pet
  self._lineIdx = index
  self._targetPos = linePos
  self._mover = AircraftMover:New(self._pet:Transform(), self._targetPos, AircraftSpeed.Pet)
  self._mover:Begin()
  self._pet:Transform().forward = self._targetPos - self._pet:WorldPosition()
  self._pet:Anim_Walk()
  self._state = AircraftWaitElevState.MoveToLine
end

function AircraftPetWaitElevator:Update(dtMS)
  if self._state == AircraftWaitElevState.MoveToLine then
    self._mover:Update(dtMS)
    if self._mover:IsArrive() then
      self._mover = nil
      self._waitTime = self._main:Time()
      self._pet:SetWaitElevatorTime(self._main:Time())
      self._pet:Anim_Stand()
      self._state = AircraftWaitElevState.WaitInLine
    end
  elseif self._state == AircraftWaitElevState.WaitInLine then
  elseif self._state == AircraftWaitElevState.MoveToNext then
    self._mover:Update(dtMS)
    if self._mover:IsArrive() then
      self._mover = nil
      self._pet:SetWaitElevatorTime(self._main:Time())
      self._pet:Anim_Stand()
      self._state = AircraftWaitElevState.WaitInLine
    end
  end
end

function AircraftPetWaitElevator:Index()
  return self._lineIdx
end

function AircraftPetWaitElevator:ResetIndex(index, pos, wait)
  self._lineIdx = index
  self._targetPos = pos
  if self._state == AircraftWaitElevState.MoveToLine then
    self._mover:ResetTarget(self._targetPos)
  elseif self._state == AircraftWaitElevState.WaitInLine then
    self._mover = AircraftMover:New(self._pet:Transform(), self._targetPos, AircraftSpeed.Pet)
    self._pet:Transform().forward = self._targetPos - self._pet:WorldPosition()
    self._pet:Anim_Walk()
    self._mover:Begin()
    self._state = AircraftWaitElevState.MoveToNext
  elseif self._state == AircraftWaitElevState.MoveToNext then
    self._mover:ResetTarget(self._targetPos)
  end
end

function AircraftPetWaitElevator:CheckPet(pet)
  return self._pet:PstID() == pet:PstID()
end

function AircraftPetWaitElevator:Pet()
  return self._pet
end

function AircraftPetWaitElevator:IsWaiting()
  return self._state == AircraftWaitElevState.WaitInLine
end
