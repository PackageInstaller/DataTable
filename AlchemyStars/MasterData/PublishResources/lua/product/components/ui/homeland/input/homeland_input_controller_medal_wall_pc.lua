require("homeland_input_controller_medal_wall_base")
_class("HomelandInputControllerMedalWallPC", HomelandInputControllerMedalWallBase)
HomelandInputControllerMedalWallPC = HomelandInputControllerMedalWallPC

function HomelandInputControllerMedalWallPC:Constructor(homelandClient)
  self._mouseWheelFactor = MedalWallConfig.WheelFactor
  self._clickInterval = 500
  self._input = GameGlobal.EngineInput()
  self._homelandClient = homelandClient
  self._homelandBuildManager = self._homelandClient:BuildManager()
  self._medalWallCam = self._homelandClient:CameraManager():MedalWallCameraController():CameraCmp()
  self._inputX = 0
  self._inputY = 0
  self._mouseMoved = false
  self._mouseDownTime = 0
  self._currentEvent = UnityEngine.EventSystems.EventSystem.current
end

function HomelandInputControllerMedalWallPC:Update(deltaTimeMS)
  self._inputX = 0
  self._inputY = 0
  if self._input.GetKey(UnityEngine.KeyCode.W) then
    self._inputY = 1
  elseif self._input.GetKey(UnityEngine.KeyCode.S) then
    self._inputY = -1
  end
  if self._input.GetKey(UnityEngine.KeyCode.A) then
    self._inputX = -1
  elseif self._input.GetKey(UnityEngine.KeyCode.D) then
    self._inputX = 1
  end
  if self._inputX ~= 0 or self._inputY ~= 0 then
    local movementVec = Vector3(self._inputX, self._inputY, 0)
    movementVec = movementVec:SetNormalize()
    local percent = self:_GetMoveSpeed() * deltaTimeMS / 1000
    movementVec = movementVec * percent
    self._medalWallCameraController:HandleMove(movementVec.x, movementVec.y)
  end
  if self._input.GetMouseButtonDown(0) and not self._currentEvent:IsPointerOverGameObject() then
    self._mouseMoved = false
    self._mouseDownTime = GameGlobal:GetInstance():GetCurrentTime()
  end
  if self._input.GetMouseButtonUp(0) and not self._mouseMoved and GameGlobal:GetInstance():GetCurrentTime() - self._mouseDownTime < self._clickInterval then
    self._homelandBuildManager:OnClickMedal(self._medalWallCam:ScreenPointToRay(self._input.mousePosition))
  end
  if self._input.GetMouseButton(0) and not self._currentEvent:IsPointerOverGameObject() then
    local mx = self._input.GetAxis("Mouse X")
    local my = self._input.GetAxis("Mouse Y")
    local movementVec = Vector3(mx, my, 0)
    movementVec = movementVec:SetNormalize() * self:_GetMoveSpeed() * deltaTimeMS / 1000
    self._medalWallCameraController:HandleMove(movementVec.x, movementVec.y)
    self._mouseMoved = self._mouseMoved or mx ~= 0 and my ~= 0
  end
  local mouseWheel = self._input.GetAxis("Mouse ScrollWheel")
  if mouseWheel ~= 0 then
    self._medalWallCameraController:HandleScale(mouseWheel * self._mouseWheelFactor)
  end
end
