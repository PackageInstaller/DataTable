_class("SeasonCameraManager", Object)
SeasonCameraManager = SeasonCameraManager

function SeasonCameraManager:Constructor()
end

function SeasonCameraManager:OnInit(seasonID, seasonIDBT)
  if EDITOR or IsPc() then
    self._seasonCamera = SeasonCameraPc:New(seasonID, seasonIDBT)
  else
    self._seasonCamera = SeasonCameraMobile:New(seasonID, seasonIDBT)
  end
  self._seasonCamera:SetPositionForce()
  if seasonID == UISeasonID.S5 then
    HelperProxy:GetInstance():InitCameraShake()
    self._canShake = true
  end
end

function SeasonCameraManager:Update(deltaTime, inputMode)
  self._seasonCamera:Update(deltaTime, inputMode)
end

function SeasonCameraManager:Dispose()
  self._seasonCamera:Dispose()
  self._seasonCamera = nil
  if self._canShake then
    HelperProxy:GetInstance():DestroyCameraShake()
  end
end

function SeasonCameraManager:SwitchMode(mode)
  self._seasonCamera:SwitchMode(mode)
end

function SeasonCameraManager:SeasonCamera()
  return self._seasonCamera
end

function SeasonCameraManager:Camera()
  return self._seasonCamera:Camera()
end

function SeasonCameraManager:DoEnterAnim()
  local camera = self:Camera()
  local curSize = camera.orthographicSize
  local fromSize = curSize + 0.4
  camera.orthographicSize = fromSize
  camera:DOOrthoSize(curSize, 1.2)
end

function SeasonCameraManager:UnLock(zoneMask, zoneID2Animation)
  self._seasonCamera:UnLock(zoneMask, zoneID2Animation)
end
