require("trigger_type")
_class("TriggerBase", Object)
TriggerBase = TriggerBase

function TriggerBase:Constructor(owner, triggerCond)
  self._owner = owner
  self._world = owner._world
  self._triggerType = triggerCond[1]
  self._x = triggerCond[2]
  self._y = triggerCond[3]
  self._z = triggerCond[4]
  self._param = {}
  for i = 2, #triggerCond do
    table.insert(self._param, triggerCond[i])
  end
end

function TriggerBase:GetNotifyType()
  return self._owner:GetNotifyType()
end

function TriggerBase:GetTriggerType()
  return self._triggerType
end

function TriggerBase:OnNotify(notify)
end

function TriggerBase:IsSatisfied(notify)
  return false
end

function TriggerBase:Reset()
end

function TriggerBase:GetOwnerEntity()
  return self._owner:GetOwnerEntity()
end

function TriggerBase:GetWorld()
  return self._owner:GetWorld()
end

function TriggerBase:GetTriggerParamByIndex(paramIndex)
  local paramCount = #self._param
  if paramIndex > paramCount then
    return nil
  end
  return self._param[paramIndex]
end

_class("CombinedTrigger", TriggerBase)
CombinedTrigger = CombinedTrigger

function CombinedTrigger:Constructor(triggerOwner, notifyTypes, world)
  self._triggers = {}
  self._world = world
  self._triggerOwner = triggerOwner
  self._notifyType = notifyTypes
end

function CombinedTrigger:GetNotifyType()
  return self._notifyType
end

function CombinedTrigger:AddTrigger(trigger)
  table.insert(self._triggers, trigger)
end

function CombinedTrigger:GetTriggers()
  return self._triggers
end

function CombinedTrigger:OnNotifyWrapper(notify)
  local notifyList = self:GetNotifyType()
  for k, notifyType in ipairs(notifyList) do
    if notify:GetNotifyType() == notifyType then
      for i, trigger in ipairs(self._triggers) do
        trigger:OnNotify(notify)
      end
      return
    end
  end
end

function CombinedTrigger:CheckNotifyGameTurn(notify)
  if self._world:MatchType() ~= MatchType.MT_BlackFist then
    return true
  end
  for i, trigger in ipairs(self._triggers) do
    if trigger:GetTriggerType() == TriggerType.DonotCheckGameTurn then
      return true
    end
  end
  local ownerEntity = self._triggerOwner:GetOwnerEntity()
  if notify:NeedCheckGameTurn() and ownerEntity:HasGameTurn() then
    local ownerEntityTurn = ownerEntity:GameTurn():GetGameTurn()
    if notify:GetNotifyType() == NotifyType.EnemyTurnStart or notify:GetNotifyType() == NotifyType.EnemyTurnEnd then
      local enemyTurn = notify:GetNotifyEntity():GameTurn():GetGameTurn()
      if enemyTurn == ownerEntityTurn then
        return false
      end
    elseif self._world:GetGameTurn() ~= ownerEntityTurn then
      return false
    end
  end
  return true
end

function CombinedTrigger:IsSatisfied(notify)
  if not self:CheckNotifyGameTurn(notify) then
    return false
  end
  for i, trigger in ipairs(self._triggers) do
    if not trigger:IsSatisfied(notify) then
      return false
    end
  end
  return true
end

function CombinedTrigger:Reset()
  for i, trigger in ipairs(self._triggers) do
    trigger:Reset()
  end
end

function CombinedTrigger:GetTriggerOwner()
  return self._triggerOwner
end

function CombinedTrigger:OnTrigger(notify)
  self._triggerOwner:OnTrigger(notify, self._triggers)
end

function CombinedTrigger:SetActive(active)
  self._active = active
end

function CombinedTrigger:IsActive()
  return self._active
end

function CombinedTrigger:GetOwnerEntity()
  return self._triggerOwner:GetOwnerEntity()
end

function CombinedTrigger:GetWorld()
  return self._world
end

_class("TriggerCount", TriggerBase)
TriggerCount = TriggerCount

function TriggerCount:Constructor()
  self._count = 0
end

function TriggerCount:SetCount(val)
  self._count = val
end

function TriggerCount:AddCount(val)
  self._count = self._count + val
end

function TriggerCount:IsSatisfied(notify)
  return self._count >= self._x
end

function TriggerCount:Reset()
  self._count = 0
end

_class("TTNone", TriggerBase)
TTNone = TTNone

function TTNone:IsSatisfied(notify)
  return false
end

_class("TTAlways", TriggerBase)
TTAlways = TTAlways

function TTAlways:IsSatisfied(notify)
  return true
end

_class("TTNotifyMe", TriggerBase)
TTNotifyMe = TTNotifyMe

function TTNotifyMe:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  if notify:GetNotifyType() == NotifyType.CoffinMusumeSkillChangeLight then
    return table.icontains(notify:GetSelectLightID(), owner:GetID())
  end
  local entity = notify:GetNotifyEntity()
  return owner == entity
end

_class("TTProb", TriggerBase)
TTProb = TTProb

function TTProb:IsSatisfied(notify)
  local rate = self._x
  if self._y and self._y == 1 then
    local buffID = self._z
    local owner = self:GetOwnerEntity()
    local cBuff = owner:BuffComponent()
    local key = "ExtraProb" .. tostring(buffID)
    local addVal = cBuff:GetBuffValue(key) or 0
    rate = rate + addVal
  end
  local randomSvc = self._world:GetService("RandomLogic")
  local r = randomSvc:LogicRand()
  return rate > r
end

_class("TTNotifyMeProb", TriggerBase)
TTNotifyMeProb = TTNotifyMeProb

function TTNotifyMeProb:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  local entity = notify:GetNotifyEntity()
  local randomSvc = self._world:GetService("RandomLogic")
  local r = randomSvc:LogicRand()
  return owner == entity and r < self._x
end

_class("TTProbMultiplyLayer", TriggerBase)
TTProbMultiplyLayer = TTProbMultiplyLayer

function TTProbMultiplyLayer:IsSatisfied(notify)
  local buffId = self._x
  local rateParam = self._y
  local owner = self:GetOwnerEntity()
  local cBuff = owner:BuffComponent()
  local layerCount = 0
  local instance = cBuff:GetBuffById(buffId)
  if instance then
    local layerName = instance:GetBuffLayerName()
    layerCount = cBuff:GetBuffValue(layerName) or 0
  end
  local rate = layerCount * rateParam
  local randomSvc = self._world:GetService("RandomLogic")
  local r = randomSvc:LogicRand()
  return rate > r
end

_class("TTMyTurn", TriggerBase)
TTMyTurn = TTMyTurn

function TTMyTurn:IsSatisfied(notify)
  local e = self:GetOwnerEntity()
  if e:HasMonsterID() and notify:GetNotifyType() == NotifyType.MonsterTurnStart then
    return true
  end
  if (e:HasPetPstID() or e:HasTeam()) and notify:GetNotifyType() == NotifyType.PlayerTurnStart then
    return true
  end
  return false
end

_class("TTLayerCount", TriggerBase)
TTLayerCount = TTLayerCount

function TTLayerCount:IsSatisfied(notify)
  local buffId = self._x
  local maxLayerCount = self._y
  local e = self:GetOwnerEntity()
  local cBuff = e:BuffComponent()
  local layerCount = 0
  local instance = cBuff:GetBuffById(buffId)
  if instance then
    local layerName = instance:GetBuffLayerName()
    layerCount = cBuff:GetBuffValue(layerName) or 0
  end
  return maxLayerCount <= layerCount
end

_class("TTCompareLayerCount", TriggerBase)
TTCompareLayerCount = TTCompareLayerCount

function TTCompareLayerCount:IsSatisfied(notify)
  local compareFlag = self._x
  local buffId = self._y
  local count = self._z
  local e = self:GetOwnerEntity()
  if e:HasDeadMark() then
    return false
  end
  local cBuff = e:BuffComponent()
  local countParamType = self:GetTriggerParamByIndex(4)
  if countParamType and countParamType == 1 then
    local targetBuffID = self:GetTriggerParamByIndex(5)
    local instance = cBuff:GetBuffById(targetBuffID)
    if instance then
      local layerName = instance:GetBuffLayerName()
      count = cBuff:GetBuffValue(layerName) or 0
    end
  end
  local layerCount = 0
  local instance = cBuff:GetBuffById(buffId)
  if instance then
    local layerName = instance:GetBuffLayerName()
    layerCount = cBuff:GetBuffValue(layerName) or 0
  end
  local satisfied = false
  if compareFlag == ComparisonOperator.EQ then
    satisfied = layerCount == count
  elseif compareFlag == ComparisonOperator.NE then
    satisfied = layerCount ~= count
  elseif compareFlag == ComparisonOperator.GT then
    satisfied = count < layerCount
  elseif compareFlag == ComparisonOperator.GE then
    satisfied = count <= layerCount
  elseif compareFlag == ComparisonOperator.LT then
    satisfied = count > layerCount
  elseif compareFlag == ComparisonOperator.LE then
    satisfied = count >= layerCount
  end
  return satisfied
end

_class("TTCompareLayerChange", TriggerBase)
TTCompareLayerChange = TTCompareLayerChange

function TTCompareLayerChange:IsSatisfied(notify)
  local compareFlag = self._x
  local count = self._y
  local change = notify:GetChangeLayer()
  local satisfied = false
  if compareFlag == ComparisonOperator.EQ then
    satisfied = change == count
  elseif compareFlag == ComparisonOperator.NE then
    satisfied = change ~= count
  elseif compareFlag == ComparisonOperator.GT then
    satisfied = count < change
  elseif compareFlag == ComparisonOperator.GE then
    satisfied = count <= change
  elseif compareFlag == ComparisonOperator.LT then
    satisfied = count > change
  elseif compareFlag == ComparisonOperator.LE then
    satisfied = count >= change
  end
  return satisfied
end
