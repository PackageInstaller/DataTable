_class("AirActionRotate", AirActionBase)
AirActionRotate = AirActionRotate

function AirActionRotate:Constructor(pet, target, baseTime)
  self._pet = pet
  self._target = target
  if baseTime then
    self._baseTime = baseTime
  else
    local forward = self._pet:Transform().forward
    local dir = Vector3.Normalize(target - self._pet:WorldPosition())
    local angle = Vector3.Angle(forward, dir)
    local angle2time = 1.75
    self._baseTime = angle * angle2time
  end
end

function AirActionRotate:Start()
  if not self._target then
    self._running = false
    return
  end
  local delta = self._target - self._pet:WorldPosition()
  if self._baseTime <= 5 then
    delta.y = 0
    self._pet:SetRotation(Quaternion.LookRotation(delta, Vector3.up))
    self._running = false
    return
  elseif delta:Magnitude() < 1.0E-6 then
    self._running = false
    AirLog("转向方向为0，不处理", debug.traceback())
    return
  end
  self.duration = 0
  self._running = true
  self._startTime = GameGlobal:GetInstance():GetCurrentTime()
  local newPos = Vector3(self._target.x, self._pet:Transform().position.y, self._target.z)
  self._targetRotation = Quaternion.LookRotation(newPos - self._pet:Transform().position:Clone(), Vector3.up)
  self._originRotation = self._pet:Transform().rotation
end

function AirActionRotate:Update(deltaTimeMS)
  if self._running == false then
    return
  end
  self._duration = GameGlobal:GetInstance():GetCurrentTime() - self._startTime
  if self._duration > self._baseTime then
    self._running = false
    self._duration = self._baseTime
  end
  if self._pet then
    self._pet:SetRotation(Quaternion.Lerp(self._originRotation, self._targetRotation, self._duration / self._baseTime))
  end
end

function AirActionRotate:IsOver()
  return not self._running
end

function AirActionRotate:Stop()
  self._running = false
end

function AirActionRotate:GetPets()
  return {
    self._pet
  }
end
