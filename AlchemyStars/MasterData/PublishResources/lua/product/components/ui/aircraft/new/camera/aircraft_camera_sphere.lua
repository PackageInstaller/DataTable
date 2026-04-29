_class("AircraftCameraSphere", Object)
AircraftCameraSphere = AircraftCameraSphere

function AircraftCameraSphere:Constructor(input, far)
  self._input = input
  self._scaleParam = Cfg.cfg_aircraft_camera.decorateScaleParam.Value
  self._rotateSpeed = Cfg.cfg_aircraft_camera.decorateDragParam.Value
  self._farPoint = far
  self._target = nil
  self._xRange = nil
  self._yRange = nil
  self._scaleRange = nil
end

function AircraftCameraSphere:Dispose()
end

function AircraftCameraSphere:Reset()
  self._pos = self._farPoint
  self._rot = Quaternion.identity
end

function AircraftCameraSphere:ChangeView(cfg)
  self._pos = Vector3(cfg.Dpos[1], cfg.Dpos[2], cfg.Dpos[3])
  self._target = Vector3(cfg.Tpos[1], cfg.Tpos[2], cfg.Tpos[3])
  self._xRange = Vector2(cfg.Xr[1], cfg.Xr[2])
  self._yRange = Vector2(cfg.Yr[1], cfg.Yr[2])
  self._scaleRange = Vector2(cfg.Sr[1], cfg.Sr[2])
  self._rot = Quaternion.LookRotation(self._target - self._pos, Vector3.up)
  self.x = self:clampAngle(self._rot.eulerAngles.y)
  if self.x < self._xRange.x or self.x > self._xRange.y then
    Log.exception("相机默认位置的水平旋转超出旋转范围：", cfg.ID, "，水平角度：", self.x, "，限制范围为：", self._xRange.x, ",", self._xRange.y)
    self.x = Mathf.Clamp(self.x, self._xRange.x, self._xRange.y)
  end
  self.y = self:clampAngle(self._rot.eulerAngles.x)
  if self._pos.y < self._yRange.x or self._pos.y > self._yRange.y then
    Log.exception("相机的默认位置高度超出范围：", cfg.ID)
    self._pos.y = Mathf.Clamp(self._pos.y, self._yRange.x, self._yRange.y)
  end
  self._distance = Vector3.Distance(self._pos, self._target)
  if self._distance < self._scaleRange.x or self._distance > self._scaleRange.y then
    self._distance = Mathf.Clamp(self._distance, self._scaleRange.x, self._scaleRange.y)
    local forward = self._rot * Vector3(0, 0, 1)
    self._pos = -forward * self._distance + self._target
  end
end

function AircraftCameraSphere:ChangeTarget(cfg, useFloorTarget)
  if useFloorTarget then
    if cfg.FloorPos then
      self._target = Vector3(cfg.FloorPos[1], cfg.FloorPos[2], cfg.FloorPos[3])
    else
      self._target = Vector3(cfg.Tpos[1], cfg.Tpos[2], cfg.Tpos[3])
    end
  else
    self._target = Vector3(cfg.Tpos[1], cfg.Tpos[2], cfg.Tpos[3])
  end
  self._rot = Quaternion.LookRotation(self._target - self._pos, Vector3.up)
  self._distance = Vector3.Distance(self._pos, self._target)
end

function AircraftCameraSphere:Pos()
  return self._pos
end

function AircraftCameraSphere:Rot()
  return self._rot
end

function AircraftCameraSphere:clampAngle(angle)
  if angle < -180 then
    return angle + 360
  end
  if 180 < angle then
    return angle - 360
  end
  return angle
end

function AircraftCameraSphere:OnDrag(delta)
  local rotVec = delta * self._rotateSpeed
  local x = self.x + rotVec.x
  x = self:_HandleX(x)
  local y = self.y - rotVec.y
  local rotation = Quaternion.Euler(y, x, 0)
  local target = self._target + rotation * Vector3(0, 0, -self._distance)
  if target.y > self._yRange.y or target.y < self._yRange.x then
    y = self.y
    rotation = Quaternion.Euler(y, x, 0)
    target = self._target + rotation * Vector3(0, 0, -self._distance)
  end
  self.x = x
  self.y = y
  self._pos = target
  self._rot = rotation
end

function AircraftCameraSphere:OnScale(length)
  local forward = self._rot * Vector3(0, 0, 1)
  self._pos = self._pos + forward * (length * self._scaleParam)
  self._distance = Vector3.Distance(self._target, self._pos)
  if self._distance < self._scaleRange.x or self._distance > self._scaleRange.y then
    self._distance = Mathf.Clamp(self._distance, self._scaleRange.x, self._scaleRange.y)
    self._pos = -forward * self._distance + self._target
  end
end

function AircraftCameraSphere:_HandleX(x)
  x = self:clampAngle(x)
  x = Mathf.Clamp(x, self._xRange.x, self._xRange.y)
  return x
end
