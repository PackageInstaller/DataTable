local RotateAngularSpeed = 15
local DormFightCameraStateBase = require("Game.Fight.CameraState.DormFightCameraStateBase")
local DormFightCameraRotateSceneState = class("DormFightCameraRotateSceneState", DormFightCameraStateBase)

function DormFightCameraRotateSceneState:OnInit()
  self._cameraTrans = nil
  self._height = 0
  self._radius = nil
  self._angle = 0
  self._focusPoint = Vector3.zero
  self._curPosition = Vector3.New(0, 0, 0)
end

function DormFightCameraRotateSceneState:OnEnter(prevState)
  self._cameraTrans = self._owner:GetCameraTrans()
  local position = self._cameraTrans.position
  self._height = position.y - self._focusPoint.y
  local dx = position.x - self._focusPoint.x
  local dz = position.z - self._focusPoint.z
  self._radius = math.sqrt(dx * dx + dz * dz)
  self._angle = math.acos(dx / self._radius) * 180 / math.pi
end

function DormFightCameraRotateSceneState:OnUpdate(deltaTime)
  self._angle = self._angle + RotateAngularSpeed * deltaTime
  if self._angle < 0 then
    self._angle = self._angle + 360
  elseif self._angle > 360 then
    self._angle = self._angle - 360
  end
  local radians = self._angle * math.pi / 180
  self._curPosition.x = self._radius * math.cos(radians) + self._focusPoint.x
  self._curPosition.y = self._focusPoint.y + self._height
  self._curPosition.z = self._radius * math.sin(radians) + self._focusPoint.z
  if not IsNull(self._cameraTrans) then
    self._cameraTrans.position = self._curPosition
    self._cameraTrans:LookAt(self._focusPoint)
  end
end

return DormFightCameraRotateSceneState
