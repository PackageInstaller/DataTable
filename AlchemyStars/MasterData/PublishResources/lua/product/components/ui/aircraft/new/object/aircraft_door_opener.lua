_class("AircraftDoorOpener", Object)
AircraftDoorOpener = AircraftDoorOpener

function AircraftDoorOpener:Constructor(transformLeft, transformRight)
  self._left = transformLeft
  self._right = transformRight
  self._leftDefault = Vector3(0, 0, 0)
  self._rightDefault = Vector3(0, 0, 0)
  self._leftEnd = Vector3(0, 0, -20)
  self._rightEnd = Vector3(0, 0, 20)
  self._leftEndRot = Quaternion.Euler(0, 0, -20)
  self._rightEndRot = Quaternion.Euler(0, 0, 20)
  self._leftDefaultRot = Quaternion.identity
  self._rightDefaultRot = Quaternion.identity
  self._left.eulerAngles = self._leftDefault
  self._right.eulerAngles = self._rightDefault
  self._speed = 30
  self._stayTime = 1300
  self._state = AirStairDoorState.Idle
  self._totalDua = math.abs(self._leftEnd.z - self._leftDefault.z) / self._speed * 1000
end

function AircraftDoorOpener:Open()
  if self._state == AirStairDoorState.Opening then
  elseif self._state == AirStairDoorState.Stay then
    self._timer = 0
  elseif self._state == AirStairDoorState.Closing then
    self._state = AirStairDoorState.Opening
    local leftZ = self._left.eulerAngles.z
    self._duration = math.abs(leftZ - self._leftDefault.z) / self._speed * 1000
    self._timer = 0
    self._leftTarget = self._leftEnd
    self._rightTarget = self._rightEnd
  elseif self._state == AirStairDoorState.Idle then
    self._state = AirStairDoorState.Opening
    self._duration = self._totalDua
    self._timer = 0
    self._leftTarget = self._leftEnd
    self._rightTarget = self._rightEnd
  end
end

function AircraftDoorOpener:Init()
end

function AircraftDoorOpener:Update(deltaTimeMS)
  if self._state == AirStairDoorState.Idle then
  elseif self._state == AirStairDoorState.Opening then
    self._timer = self._timer + deltaTimeMS
    local t = self._timer / self._duration
    if 1 < t then
      self._left.eulerAngles = self._leftEnd
      self._right.eulerAngles = self._rightEnd
      self._timer = 0
      self._duration = self._stayTime
      self._state = AirStairDoorState.Stay
    else
      local leftR = self._left.rotation
      local rightR = self._right.rotation
      self._left.rotation = Quaternion.Lerp(leftR, self._leftEndRot, t)
      self._right.rotation = Quaternion.Lerp(rightR, self._rightEndRot, t)
    end
  elseif self._state == AirStairDoorState.Stay then
    self._timer = self._timer + deltaTimeMS
    if self._timer > self._duration then
      self._timer = 0
      self._duration = self._totalDua
      self._state = AirStairDoorState.Closing
    end
  elseif self._state == AirStairDoorState.Closing then
    self._timer = self._timer + deltaTimeMS
    local t = self._timer / self._duration
    if 1 < t then
      self._left.eulerAngles = self._leftDefault
      self._right.eulerAngles = self._rightDefault
      self._timer = 0
      self._duration = 0
      self._state = AirStairDoorState.Idle
    else
      local leftR = self._left.rotation
      local rightR = self._right.rotation
      self._left.rotation = Quaternion.Lerp(leftR, self._leftDefaultRot, t)
      self._right.rotation = Quaternion.Lerp(rightR, self._rightDefaultRot, t)
    end
  end
end

function AircraftDoorOpener:Dispose()
end
