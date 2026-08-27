local CS_UnityEngine_Camera = CS.UnityEngine.Camera
local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCtrlBase = require("Game.Fight.Ctrl.DormFightCtrlBase")
local DormFightCameraStateFactory = require("Game.Fight.CameraState.DormFightCameraStateFactory")
local DormFightCameraCtrl = class("DormFightCameraCtrl", DormFightCtrlBase)

function DormFightCameraCtrl:ctor(_)
  self._camera = nil
  self._cameraTrans = nil
  self._curState = nil
  self._cachedState = {}
end

function DormFightCameraCtrl:OnEnterFightScene()
  self._camera = CS_UnityEngine_Camera.main
  if not IsNull(self._camera) then
    self._cameraTrans = self._camera.transform
  end
  self:TransferTo(DormFightConst.CameraStateEnum.RotateScene)
end

function DormFightCameraCtrl:OnFightStart()
  self:TransferTo(DormFightConst.CameraStateEnum.FollowCharacter)
end

function DormFightCameraCtrl:OnExitFightScene()
  self._camera = nil
  self._cameraTrans = nil
  self._curState = nil
  self._cachedState = {}
end

function DormFightCameraCtrl:OnUpdate(deltaTime)
  if self._curState ~= nil then
    self._curState:OnUpdate(deltaTime)
  end
end

function DormFightCameraCtrl:GetCameraTrans()
  return self._cameraTrans
end

function DormFightCameraCtrl:TransferTo(stateType)
  if stateType == nil or self._cachedState == nil then
    return
  end
  if self._cachedState[stateType] == nil then
    local state = DormFightCameraStateFactory.CreateCameraState(stateType)
    if state ~= nil then
      state:Init(self)
      self._cachedState[stateType] = state
    end
  end
  local nextState = self._cachedState[stateType]
  if self._curState ~= nil then
    self._curState:OnExit(nextState)
  end
  local prevState = self._curState
  self._curState = nextState
  self._curState:OnEnter(prevState)
end

return DormFightCameraCtrl
