local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterStateBase = require("Game.Fight.Character.State.DormFightCharacterStateBase")
local MovementMoveState = class("MovementMoveState", DormFightCharacterStateBase)

function MovementMoveState:ctor()
  self._targetForward = Quaternion.identity
  self._propertyCtrl = nil
end

function MovementMoveState:OnInit()
  self._propertyCtrl = self._owner:GetFeature(DormFightConst.FeatureEnum.PropertyController)
end

function MovementMoveState:OnEnter(prevState)
  local moveSpeed = 0
  if self._propertyCtrl ~= nil then
    moveSpeed = self._propertyCtrl:GetProperty(DormFightConst.PropertyEnum.MoveSpeed)
  end
  self._owner:SetTargetVelocity(moveSpeed)
  local animatorCtrl = self._owner:GetFeature(DormFightConst.FeatureEnum.AnimatorController)
  if animatorCtrl ~= nil then
    animatorCtrl:PlayWalkAnimation()
  end
end

function MovementMoveState:OnExit(nextState)
  self._owner:SetTargetVelocity(0.0)
end

function MovementMoveState:OnUpdate(deltaTime)
  local rigidBody = self._owner.rigidBody
  if not IsNull(rigidBody) then
    local rotateRatio = self._propertyCtrl:GetProperty(DormFightConst.PropertyEnum.RotateRatio)
    rigidBody.rotation = Quaternion.Slerp(rigidBody.rotation, self._targetForward, rotateRatio)
  end
end

function MovementMoveState:OnEvent(eventType, arg1)
  if eventType == DormFightConst.EventEnum.StopMoving then
    self:TransferTo(DormFightConst.StateEnum.MovementLayer_Idle)
  elseif eventType == DormFightConst.EventEnum.Run then
    self:TransferTo(DormFightConst.StateEnum.MovementLayer_Run)
  elseif eventType == DormFightConst.EventEnum.Move then
    self._targetForward = Quaternion.LookRotation(arg1, Vector3.up)
  elseif eventType == DormFightConst.EventEnum.KnockOut then
    self:TransferTo(DormFightConst.StateEnum.MovementLayer_KnockOut)
  end
end

return MovementMoveState
