require("homeland_input_controller_build_base")
_class("HomelandInputControllerBuildMobile", HomelandInputControllerBuildBase)
HomelandInputControllerBuildMobile = HomelandInputControllerBuildMobile

function HomelandInputControllerBuildMobile:Constructor(homelandClient)
  self._homelandClient = homelandClient
end

function HomelandInputControllerBuildMobile:Init(mainCharacterController, globalCameraController)
  HomelandInputControllerBuildMobile.super.Init(self, mainCharacterController, globalCameraController)
  self._homdelandBuildManager = self._homelandClient:BuildManager()
  self._buildCam = self._homelandClient:CameraManager():GlobalCameraController():CameraCmp()
  self._rotateFactorX = 0.03
  self._rotateFactorY = 0.03
  self._inputMoveVec = Vector2.zero
  self._movementVec = nil
  self._moveInput = false
  self._guideLock = false
end

function HomelandInputControllerBuildMobile:Leave()
  self._inputMoveVec = Vector2.zero
  self._movementVec = nil
  self._moveInput = false
end

function HomelandInputControllerBuildMobile:Update(deltaTimeMS)
  if self._guideLock then
    return
  end
  if self._moveInput then
    if self._inputMoveVec.x ~= 0 or self._inputMoveVec.y ~= 0 then
      self._movementVec = Vector3(self._inputMoveVec.x, 0, self._inputMoveVec.y)
    else
      self._movementVec = nil
    end
    self._moveInput = false
  end
  if self._movementVec then
    self._globalCameraController:Move(self._movementVec:SetNormalize() * self:_GetMoveSpeed() * deltaTimeMS / 1000)
    self:CheckAndLimitMovePos()
  end
end

function HomelandInputControllerBuildMobile:HandleMove(moveVec)
  self._inputMoveVec = moveVec
  self._moveInput = true
end

function HomelandInputControllerBuildMobile:HandleRotate(rotateVec)
  self._globalCameraController:HandleRotate(rotateVec.x * self._rotateFactorX, rotateVec.y * self._rotateFactorY)
end

function HomelandInputControllerBuildMobile:HandleScale(scale)
  self._globalCameraController:HandleScale(scale)
end

function HomelandInputControllerBuildMobile:HandleBuildAreaDown(pos)
  if self._curBuildingInfo and self._homdelandBuildManager:PressBuilding(self._buildCam:ScreenPointToRay(pos)) == self._curBuildingInfo then
    self._touchBuilding = true
    return true
  end
end

function HomelandInputControllerBuildMobile:HandleBuildAreaMove(pos)
  self._homdelandBuildManager:DragBuilding(self._buildCam:ScreenPointToRay(pos))
end

function HomelandInputControllerBuildMobile:HandleBuildAreaClick(pos)
  self._curBuildingInfo = self._homdelandBuildManager:SelectBuilding(self._buildCam:ScreenPointToRay(pos))
end

function HomelandInputControllerBuildMobile:TouchBuilding()
  return self._touchBuilding
end

function HomelandInputControllerBuildMobile:ReleaseTouch()
  self._touchBuilding = false
  self._homdelandBuildManager:ReleaseTouch()
end

function HomelandInputControllerBuildMobile:SetCurrentBuilding(info)
  self._curBuildingInfo = info
  if info == nil then
    self._touchBuilding = false
  end
end

function HomelandInputControllerBuildMobile:HandleDragIn(buildingID)
  self._dragInBuildingID = buildingID
end

function HomelandInputControllerBuildMobile:MoveDragInFinger(pos)
  local ray = self._buildCam:ScreenPointToRay(pos)
  if self._touchBuilding then
    self._homdelandBuildManager:DragBuilding(self._buildCam:ScreenPointToRay(pos))
  elseif self._dragInBuildingID and self._homdelandBuildManager:RayTargetInCircle(ray) then
    self._touchBuilding = true
    self._curBuildingInfo = self._homdelandBuildManager:Add(self._dragInBuildingID, ray)
    self._homdelandBuildManager:PressBuilding(ray)
    self._dragInBuildingID = nil
  end
end

function HomelandInputControllerBuildMobile:SetGuideLock(guideLock)
  self._guideLock = guideLock
end
