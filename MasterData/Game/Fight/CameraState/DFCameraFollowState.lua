local FocusOffset = Vector3.New(0.0, 0.3, 0.0)
local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCameraStateBase = require("Game.Fight.CameraState.DormFightCameraStateBase")
local DormFightCameraFollowState = class("DormFightCameraFollowState", DormFightCameraStateBase)

function DormFightCameraFollowState:OnInit()
  self._cameraTrans = nil
  self._characterCtrl = nil
  self._radius = ConfigData.game_config.dFCameraFollowRadius or 0
  self._height = ConfigData.game_config.dFCameraInitialHeight or 0
  self._minHeight = ConfigData.game_config.dFCameraMinHeight or 0
  self._maxHeight = ConfigData.game_config.dFCameraMaxHeight or 0
  self._horizontalRatio = ConfigData.game_config.dFCameraHorizontalRatio or 0
  self._verticalRatio = ConfigData.game_config.dFCameraVerticalRatio or 0
  self._transferLerpValue = ConfigData.game_config.dFCameraFollowLerpValue or 0
  self._angle = 0
  self._targetPosition = Vector3.New(0, 0, 0)
  self._targetRotation = Quaternion.identity
  self._dragListener = BindCallback(self, self.OnDrag)
end

function DormFightCameraFollowState:OnEnter(prevState)
  self._cameraTrans = self._owner:GetCameraTrans()
  local dormFightCtrl = ControllerManager:GetController(ControllerTypeId.DormFight)
  self._characterCtrl = dormFightCtrl:GetCharacterCtrl()
  local sceneUiCtrl = dormFightCtrl:GetSceneUiCtrl()
  sceneUiCtrl:SetDragListener(self._dragListener)
end

function DormFightCameraFollowState:OnExit(nextState)
  local dormFightCtrl = ControllerManager:GetController(ControllerTypeId.DormFight)
  local sceneUiCtrl = dormFightCtrl:GetSceneUiCtrl()
  sceneUiCtrl:SetDragListener(nil)
end

function DormFightCameraFollowState:OnUpdate(deltaTime)
  local character = self._characterCtrl:GetMainCharacterByComp(DormFightConst.DormFightComp.Myself)
  if character == nil then
    return
  end
  local position = character:GetPosition() + FocusOffset
  local radians = self._angle * math.pi / 180
  self._targetPosition.x = self._radius * math.cos(radians) + position.x
  self._targetPosition.y = position.y + self._height
  self._targetPosition.z = self._radius * math.sin(radians) + position.z
  local forward = Vector3.New(position.x - self._targetPosition.x, position.y - self._targetPosition.y, position.z - self._targetPosition.z)
  self._targetRotation = Quaternion.LookRotation(forward, Vector3.up)
  local curPosition = self._cameraTrans.position
  if Vector3.SqrMagnitude(curPosition - self._targetPosition) < 1.0E-4 then
    return
  end
  local curRotation = self._cameraTrans.rotation
  self._cameraTrans.position = Vector3.Lerp(curPosition, self._targetPosition, self._transferLerpValue)
  self._cameraTrans.rotation = Quaternion.Slerp(curRotation, self._targetRotation, self._transferLerpValue)
end

function DormFightCameraFollowState:OnDrag(dx, dy)
  self._angle = self._angle + dx * self._horizontalRatio
  if self._angle < 0 then
    self._angle = self._angle + 360
  elseif self._angle > 360 then
    self._angle = self._angle - 360
  end
  self._height = math.clamp(self._height + dy * self._verticalRatio, self._minHeight, self._maxHeight)
end

return DormFightCameraFollowState
