_class("EffectControllerComponent", Object)
EffectControllerComponent = EffectControllerComponent

function EffectControllerComponent:Constructor(bindEntity, bindPos, duration, type)
  self.BindEntity = bindEntity
  self.BindPos = bindPos
  self.Duration = duration
  self.CurrentTime = 0
  self.HeightOffset = 0
  self._effectType = type
  self._targetGridPos = nil
  self._moveSpeed = 1
  self._followMove = true
  self._followRotate = true
  self._bindLayer = 0
  self._onDestroy = nil
  self._casterEntityID = nil
  self._followRotateCaster = false
  self._onlyUseBindPosHigh = false
  self._gridRenderPos = nil
  self._noResetRotationOnCreated = false
  self._posOffSet = nil
end

function EffectControllerComponent:SetBindHead(isBindHead)
  self._bindHead = true
end

function EffectControllerComponent:IsBindHead()
  return self._bindHead
end

function EffectControllerComponent:GetHeightOffset()
  return self.HeightOffset
end

function EffectControllerComponent:GetBindEntity()
  return self.BindEntity
end

function EffectControllerComponent:SetHeightOffset(heightOffset)
  self.HeightOffset = heightOffset
end

function EffectControllerComponent:GetEffectType()
  return self._effectType
end

function EffectControllerComponent:SetTargetGridPos(targetGridPos)
  self._targetGridPos = targetGridPos
end

function EffectControllerComponent:GetTargetGridPos()
  return self._targetGridPos
end

function EffectControllerComponent:SetMoveSpeed(speed)
  self._moveSpeed = speed
end

function EffectControllerComponent:GetMoveSpeed()
  return self._moveSpeed
end

function EffectControllerComponent:SetEffectType(effectType)
  self._effectType = effectType
end

function EffectControllerComponent:SetFollowMove(followMove)
  self._followMove = followMove
end

function EffectControllerComponent:GetFollowMove()
  return self._followMove
end

function EffectControllerComponent:SetFollowRotate(followRotate)
  self._followRotate = followRotate
end

function EffectControllerComponent:GetFollowRotate()
  return self._followRotate
end

function EffectControllerComponent:GetBindLayer()
  return self._bindLayer
end

function EffectControllerComponent:SetBindLayer(layer)
  self._bindLayer = layer
end

function EffectControllerComponent:SetDestroyCallback(fun)
  self._onDestroy = fun
end

function EffectControllerComponent:GetDestroyCallback()
  return self._onDestroy
end

function EffectControllerComponent:GetEffectCasterID()
  return self._casterEntityID
end

function EffectControllerComponent:SetEffectCasterID(casterEntityID)
  self._casterEntityID = casterEntityID
end

function EffectControllerComponent:GetFollowRotateCaster()
  return self._followRotateCaster
end

function EffectControllerComponent:SetFollowRotateCaster(isFollow)
  self._followRotateCaster = isFollow
end

function EffectControllerComponent:SetGirdRenderPos(renderPos)
  self._gridRenderPos = renderPos
  self._onlyUseBindPosHigh = true
end

function EffectControllerComponent:GetGridRenderPos()
  return self._gridRenderPos
end

function EffectControllerComponent:IsOnlyUserBindPosHigh()
  return self._onlyUseBindPosHigh
end

function EffectControllerComponent:SetNoResetRotationOnCreated(b)
  self._noResetRotationOnCreated = b
end

function EffectControllerComponent:IsNoResetRotationOnCreated()
  return self._noResetRotationOnCreated
end

function EffectControllerComponent:SetPosOffSet(offSet)
  self._posOffSet = offSet
end

function EffectControllerComponent:GetPosOffSet()
  return self._posOffSet
end

function Entity:EffectController()
  return self:GetComponent(self.WEComponentsEnum.EffectController)
end

function Entity:HasEffectController()
  return self:HasComponent(self.WEComponentsEnum.EffectController)
end

function Entity:AddEffectController(bindEntity, bindPos, duration, type, effectID)
  local index = self.WEComponentsEnum.EffectController
  local component = EffectControllerComponent:New(bindEntity, bindPos, duration, type)
  component._effectID = effectID
  self:AddComponent(index, component)
end

function Entity:AddEffect(duration)
  local index = self.WEComponentsEnum.EffectController
  local component = EffectControllerComponent:New(nil, nil, duration)
  self:AddComponent(index, component)
end

function Entity:AddEffectType(type, duration)
  self:AddEffectController(nil, nil, duration, type)
end

function Entity:ReplaceEffectController()
  local index = self.WEComponentsEnum.EffectController
  local component = EffectControllerComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveEffectController()
  if self:HasEffectController() then
    self:RemoveComponent(self.WEComponentsEnum.EffectController)
  end
end
