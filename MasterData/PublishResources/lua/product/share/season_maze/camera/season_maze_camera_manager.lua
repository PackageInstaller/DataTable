_class("SeasonMazeCameraManager", Object)
SeasonMazeCameraManager = SeasonMazeCameraManager

function SeasonMazeCameraManager:Constructor()
end

function SeasonMazeCameraManager:OnInit(seasonID, seasonIDBT)
  if EDITOR or IsPc() then
    self._seasonCamera = SeasonMazeCameraPc:New(seasonID, seasonIDBT)
  else
    self._seasonCamera = SeasonMazeCameraMobile:New(seasonID, seasonIDBT)
  end
  self._seasonCamera:SetPositionForce()
end

function SeasonMazeCameraManager:Update(deltaTime)
  self._seasonCamera:Update(deltaTime, SeasonInputMode.Input)
end

function SeasonMazeCameraManager:Dispose()
  self._seasonCamera:Dispose()
  self._seasonCamera = nil
end

function SeasonMazeCameraManager:SwitchMode(mode)
  self._seasonCamera:SwitchMode(mode)
end

function SeasonMazeCameraManager:SeasonCamera()
  return self._seasonCamera
end

function SeasonMazeCameraManager:Camera()
  return self._seasonCamera:Camera()
end

function SeasonMazeCameraManager:DoEnterAnim()
  local camera = self:Camera()
  local curSize = camera.orthographicSize
  local fromSize = curSize + 0.4
  camera.orthographicSize = fromSize
  camera:DOOrthoSize(curSize, 1.2)
end

function SeasonMazeCameraManager:UnLock(zoneMask, zoneID2Animation)
  self._seasonCamera:UnLock(zoneMask, zoneID2Animation)
end
