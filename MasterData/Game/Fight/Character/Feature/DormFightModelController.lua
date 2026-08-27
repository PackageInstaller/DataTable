local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterFeatureBase = require("Game.Fight.Character.Feature.DormFightCharacterFeatureBase")
local StateFactory = require("Game.Fight.Character.State.StateFactory")
local CS_UnityEngine_ForceMode = CS.UnityEngine.ForceMode
local DormFightModelController = class("DormFightModelController", DormFightCharacterFeatureBase)
local StateLayer = {Movement = 1, Attack = 2}

function DormFightModelController:ctor(_)
  self._curStateList = {}
  self._cachedStateDict = {}
  self._velocity = 0
  self._targetVelocity = 0
  self._propertyCtrl = nil
  self._lastCheckGroundedFrame = 0
  self._lastCheckGroundedResult = false
  self._lastCheckHitWallFrame = 0
  self._lastCheckHitWallResult = false
  self.transform = nil
  self.rigidBody = nil
  self.ragBody = nil
  self.characterCo = nil
  self.collider = nil
  self.modelRoot = nil
end

function DormFightModelController:OnInit()
  self.transform = self._owner.transform
  self.rigidBody = self._owner.rigidBody
  self.ragBody = self._owner.ragBody
  self.collider = self._owner.collider
  self.characterCo = self._owner.characterCo
  self.modelRoot = self._owner.modelRoot
  self._propertyCtrl = self._owner:GetFeature(DormFightConst.FeatureEnum.PropertyController)
  self:TransferTo(StateLayer.Movement, DormFightConst.StateEnum.MovementLayer_Born)
  self:TransferTo(StateLayer.Attack, DormFightConst.StateEnum.AttackLayer_Born)
end

function DormFightModelController:OnUpdate(deltaTime)
  self:UpdateVelocity(deltaTime)
  for _, state in ipairs(self._curStateList) do
    state:OnUpdate(deltaTime)
  end
end

function DormFightModelController:OnDestroy()
end

function DormFightModelController:GetComp()
  return self._owner:GetComp()
end

function DormFightModelController:GetPosition()
  return self._owner:GetPosition()
end

function DormFightModelController:SetHandDetectHit(hitEnabled)
  self._owner:SetHandDetectHit(hitEnabled)
end

function DormFightModelController:SetTargetVelocity(velocity)
  self._targetVelocity = velocity
end

function DormFightModelController:UpdateVelocity(deltaTime)
  if math.abs(self._velocity - self._targetVelocity) > 1.0E-5 then
    if self._velocity > self._targetVelocity then
      local acceleratedVelocity = self._propertyCtrl:GetProperty(DormFightConst.PropertyEnum.NegativeAcceleratedVelocity)
      self._velocity = math.max(self._targetVelocity, self._velocity + acceleratedVelocity * deltaTime)
    else
      local acceleratedVelocity = self._propertyCtrl:GetProperty(DormFightConst.PropertyEnum.AcceleratedVelocity)
      self._velocity = math.min(self._targetVelocity, self._velocity + acceleratedVelocity * deltaTime)
    end
  end
  local velocity = (Vector3.forward * self.rigidBody.rotation).normalized * self._velocity
  velocity.y = self.rigidBody.velocity.velocity
  self.rigidBody.velocity = velocity
end

function DormFightModelController:IsInState(stateType)
  local res = false
  for _, v in ipairs(self._curStateList) do
    if v:GetStateType() == stateType then
      res = true
      break
    end
  end
  return res
end

function DormFightModelController:PostEvent(eventType, ...)
  for _, v in ipairs(self._curStateList) do
    v:OnEvent(eventType, ...)
  end
end

function DormFightModelController:GetState(stateType, layer)
  local res = self._cachedStateDict[stateType]
  if res == nil then
    res = StateFactory.CreateState(stateType)
    res:Init(self, layer, stateType)
    self._cachedStateDict[stateType] = res
  end
  return res
end

function DormFightModelController:TryGetCurState(layer)
  local index = -1
  local res
  for i, v in ipairs(self._curStateList) do
    if v:GetLayer() == layer then
      index = i
      res = v
      break
    end
  end
  return index, res
end

function DormFightModelController:TransferTo(layer, stateType)
  local index, prevState = self:TryGetCurState(layer)
  local nextState = self:GetState(stateType, layer)
  if prevState ~= nil then
    prevState:OnExit(nextState)
  end
  if index == -1 then
    table.insert(self._curStateList, nextState)
  else
    self._curStateList[index] = nextState
  end
  nextState:OnEnter(prevState)
end

function DormFightModelController:CheckIsGrounded()
  local curFrame = Time.frameCount
  if curFrame == self._lastCheckGroundedFrame then
    return self._lastCheckGroundedResult
  end
  if IsNull(self.characterCo) then
    return false
  end
  local res = self.characterCo:CheckIsGrounded()
  self._lastCheckGroundedFrame = curFrame
  self._lastCheckGroundedResult = res
  return res
end

function DormFightModelController:CheckHitWall()
  local curFrame = Time.frameCount
  if curFrame == self._lastCheckHitWallFrame then
    return self._lastCheckHitWallResult
  end
  if IsNull(self.characterCo) then
    return false
  end
  local res = self.characterCo:CheckHitWall()
  self._lastCheckHitWallFrame = curFrame
  self._lastCheckHitWallResult = res
  return res
end

function DormFightModelController:Hit(velocity)
  if velocity == nil or IsNull(self.ragBody) or IsNull(self.ragBody.RootBoneRb) then
    return
  end
  local propertyCtrl = self:GetFeature(DormFightConst.FeatureEnum.PropertyController)
  local forceStrength = propertyCtrl ~= nil and propertyCtrl:GetProperty(DormFightConst.PropertyEnum.HitForceStrength) or 0
  local rb = self.ragBody.RootBoneRb
  rb:AddForce(velocity.normalized * forceStrength, CS_UnityEngine_ForceMode.Impulse)
end

function DormFightModelController:KnockOut(velocity)
  if velocity == nil or IsNull(self.ragBody) or IsNull(self.ragBody.RootBoneRb) then
    return
  end
  local propertyCtrl = self:GetFeature(DormFightConst.FeatureEnum.PropertyController)
  local forceStrength = propertyCtrl ~= nil and propertyCtrl:GetProperty(DormFightConst.PropertyEnum.KnockOutForceStrength) or 0
  local rb = self.ragBody.RootBoneRb
  rb:AddForce(velocity.normalized * forceStrength, CS_UnityEngine_ForceMode.Impulse)
end

function DormFightModelController:SetRogBodyEnabled(enabled)
  self.ragBody:BeginStateTransition(enabled and "dead" or "default")
  self.rigidBody.isKinematic = enabled
  self.collider.enabled = not enabled
end

function DormFightModelController:SetIgnoreWallCollider(ignore)
  self._owner:SetIgnoreWallCollider(ignore)
end

function DormFightModelController:GetHeadSpotPosition()
  local position = self.modelRoot.position
  position.y = position.y + 1
  return position
end

function DormFightModelController:GetFootSpotPosition()
  local position = self.modelRoot.position
  position.y = position.y + 0.1
  return position
end

return DormFightModelController
