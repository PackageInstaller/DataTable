_class("AircraftMover", Object)
AircraftMover = AircraftMover

function AircraftMover:Constructor(transform, target, speed)
  self._speed = speed
  self._transform = transform
  self._target = target
  self._timer = 0
  self._running = false
end

function AircraftMover:Begin()
  self._from = self._transform.position:Clone()
  local distance = Vector3.Distance(self._from, self._target)
  self._duration = distance / self._speed * 1000
  self._timer = 0
  self._running = true
end

function AircraftMover:Finish()
  self._transform.position = self._target
  self._running = false
end

function AircraftMover:Update(deltaTimeMS)
  if self._running then
    self._timer = self._timer + deltaTimeMS
    if self._timer > self._duration then
      self:Finish()
    else
      self._transform.position = Vector3.Lerp(self._from, self._target, self._timer / self._duration)
    end
  end
end

function AircraftMover:ResetTarget(target)
  self._from = self._transform.position:Clone()
  self._target = target
  local distance = Vector3.Distance(self._from, self._target)
  self._duration = distance / self._speed * 1000
  self._timer = 0
end

function AircraftMover:IsArrive()
  return not self._running
end

_class("AircraftPetMover", Object)
AircraftPetMover = AircraftPetMover

function AircraftPetMover:Constructor(pet, target, speed)
  self._pet = pet
  self._target = target
  self._mover = AircraftMover:New(self._pet:Transform(), target, speed)
end

function AircraftPetMover:Begin()
  self._pet:Transform().forward = self._target - self._pet:Transform().position:Clone()
  self._pet:Anim_Walk()
  self._mover:Begin()
end

function AircraftPetMover:Finish()
  self._mover:Finish()
end

function AircraftPetMover:Update(deltaTimeMS)
  if not self._mover:IsArrive() then
    self._mover:Update(deltaTimeMS)
  end
end

function AircraftPetMover:ResetTarget(target)
  self._mover:ResetTarget(target)
end

function AircraftPetMover:IsArrive()
  return self._mover:IsArrive()
end

function AircraftPetMover:Pet()
  return self._pet
end
