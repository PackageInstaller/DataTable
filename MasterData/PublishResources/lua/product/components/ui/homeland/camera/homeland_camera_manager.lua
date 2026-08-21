_class("HomelandCameraManager", Object)
HomelandCameraManager = HomelandCameraManager

function HomelandCameraManager:Constructor()
  self._followCameraController = HomelandFollowCameraController:New()
  self._globalCameraController = HomelandGlobalCameraController:New()
  self._medalWallCameraController = HomelandMedalWallCameraController:New()
  self._mode = HomelandMode.Normal
end

function HomelandCameraManager:Init(homelandClient)
  self._followCameraController:Init(homelandClient)
  self._globalCameraController:Init(homelandClient)
  self._medalWallCameraController:Init(homelandClient)
end

function HomelandCameraManager:SetGlobalCameraLock(lock)
  self._globalCameraController:SetLockCamera(lock)
end

function HomelandCameraManager:Dispose()
  self._followCameraController:Dispose()
  self._globalCameraController:Dispose()
  self._medalWallCameraController:Dispose()
end

function HomelandCameraManager:Update(deltaTimeMS)
  self._followCameraController:Update()
end

function HomelandCameraManager:FollowCameraController()
  return self._followCameraController
end

function HomelandCameraManager:GlobalCameraController()
  return self._globalCameraController
end

function HomelandCameraManager:MedalWallCameraController()
  return self._medalWallCameraController
end

function HomelandCameraManager:OnModeChanged(mode)
  self._mode = mode
  if mode == HomelandMode.Normal then
    self._globalCameraController:SetActive(false)
    self._followCameraController:SetActive(true)
  elseif mode == HomelandMode.Build then
    self._followCameraController:SetActive(false)
    self._globalCameraController:SetActive(true)
  elseif mode == HomelandMode.Story then
    self._followCameraController:SetActive(false)
    self._globalCameraController:SetActive(false)
  end
end

function HomelandCameraManager:Rotation()
  local cam
  if self._mode == HomelandMode.Normal then
    cam = self._followCameraController
  else
    cam = self._globalCameraController
  end
  return cam:Rotation()
end

function HomelandCameraManager:GetCamera()
  if self._mode == HomelandMode.Normal then
    return self._followCameraController:CameraCmp()
  elseif self._mode == HomelandMode.Build then
    return self._globalCameraController:CameraCmp()
  end
end

function HomelandCameraManager:SetMedalWallCameraActive(isActive)
  if isActive then
    self._followCameraController:SetActive(false)
    self._medalWallCameraController:SetActive(true)
  else
    self._medalWallCameraController:SetActive(false)
    self._followCameraController:SetActive(true)
  end
end
