_class("HomelandInputControllerMedalWallBase", Object)
HomelandInputControllerMedalWallBase = HomelandInputControllerMedalWallBase

function HomelandInputControllerMedalWallBase:Constructor()
  self._speedMin = MedalWallConfig.SpeedMin
  self._speedMax = MedalWallConfig.SpeedMax
end

function HomelandInputControllerMedalWallBase:Init(mainCharacterController, medalWallCameraController)
  self._mainCharacterController = mainCharacterController
  self._medalWallCameraController = medalWallCameraController
end

function HomelandInputControllerMedalWallBase:Dispose()
end

function HomelandInputControllerMedalWallBase:Update(deltaTimeMS)
end

function HomelandInputControllerMedalWallBase:HandleMove(moveVec)
end

function HomelandInputControllerMedalWallBase:HandleRotate(rotateVec)
end

function HomelandInputControllerMedalWallBase:HandleScale(scale)
end

function HomelandInputControllerMedalWallBase:Enter(cameraTransform)
  self._medalWallCameraController:UpdateCameraTransform(cameraTransform)
end

function HomelandInputControllerMedalWallBase:HandleMedalClick(pos)
end

function HomelandInputControllerMedalWallBase:_GetMoveSpeed()
  return self._speedMin + self._medalWallCameraController:ScalePercent() * (self._speedMax - self._speedMin)
end
