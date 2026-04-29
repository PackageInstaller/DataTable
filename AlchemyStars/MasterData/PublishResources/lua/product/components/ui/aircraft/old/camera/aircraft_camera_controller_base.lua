AircraftCameraType = {
  FixedField = 1,
  BezierPath = 2,
  Sphere = 3,
  Strange = 4
}
_enum("AircraftCameraType", AircraftCameraType)
_class("AircraftCameraControllerBase", Object)
AircraftCameraControllerBase = AircraftCameraControllerBase

function AircraftCameraControllerBase:Constructor()
  self._pos = nil
  self._rot = nil
  self._input = nil
end

function AircraftCameraControllerBase:Init(camera, input)
end

function AircraftCameraControllerBase:GetType()
end

function AircraftCameraControllerBase:Update(deltaTimeMS)
end

function AircraftCameraControllerBase:GetPos()
  return self._pos
end

function AircraftCameraControllerBase:GetRot()
  return self._rot
end

function AircraftCameraControllerBase:Dispose()
end

function AircraftCameraControllerBase:Reset()
end
