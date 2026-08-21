_class("DeadMarkComponent", Object)
DeadMarkComponent = DeadMarkComponent

function DeadMarkComponent:Constructor(addCount)
  self._casterEntityID = nil
  self._chainAttackTimeIndex = -1
  self._chainAttackStageIndex = 1
  self._hasDoLogicDead = false
  self._addCount = addCount
  self._deadStateID = nil
  self._autoBeadAttackTimeIndex = -1
end

function DeadMarkComponent:SetDeadCasterID(casterEntityID)
  self._casterEntityID = casterEntityID
end

function DeadMarkComponent:GetDeadCasterID()
  return self._casterEntityID
end

function DeadMarkComponent:SetChainAttackIndex(atkIndex)
  self._chainAttackTimeIndex = atkIndex
end

function DeadMarkComponent:GetChainAttackIndex()
  return self._chainAttackTimeIndex
end

function DeadMarkComponent:SetChainAttackStageIndex(atkIndex)
  self._chainAttackStageIndex = atkIndex
end

function DeadMarkComponent:GetChainAttackStageIndex()
  return self._chainAttackStageIndex
end

function DeadMarkComponent:SetDoLogicDead(hasDoLogic)
  self._hasDoLogicDead = hasDoLogic
end

function DeadMarkComponent:HasDoLogicDead()
  return self._hasDoLogicDead
end

function DeadMarkComponent:GetDeadMarkAddCount()
  return self._addCount
end

function DeadMarkComponent:SetDeadStateID(deadStateID)
  self._deadStateID = deadStateID
end

function DeadMarkComponent:GetDeadStateID()
  return self._deadStateID
end

function DeadMarkComponent:SetAutoBeadAttackIndex(atkIndex)
  self._autoBeadAttackTimeIndex = atkIndex
end

function DeadMarkComponent:GetAutoBeadAttackIndex()
  return self._autoBeadAttackTimeIndex
end

function Entity:DeadMark()
  return self:GetComponent(self.WEComponentsEnum.DeadMark)
end

function Entity:HasDeadMark()
  return self:HasComponent(self.WEComponentsEnum.DeadMark)
end

function Entity:AddDeadMark()
  local addCount = self._world:BattleStat():FetchNewDeadMarkAddCount()
  local index = self.WEComponentsEnum.DeadMark
  local component = DeadMarkComponent:New(addCount)
  self:AddComponent(index, component)
  self._world:GetSyncLogger():Trace({
    key = "AddDeadMark",
    entityID = self:GetID()
  })
end

function Entity:ReplaceDeadMark()
  local addCount = self._world:BattleStat():FetchNewDeadMarkAddCount()
  local index = self.WEComponentsEnum.DeadMark
  local component = DeadMarkComponent:New(addCount)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveDeadMark()
  if self:HasDeadMark() then
    self:RemoveComponent(self.WEComponentsEnum.DeadMark)
  end
end
