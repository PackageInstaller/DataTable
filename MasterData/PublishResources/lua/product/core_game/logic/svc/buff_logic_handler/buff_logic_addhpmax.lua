AddHPMaxFromType = {OwnerEntity = 1, NotifyEntity = 2}
_class("BuffLogicAddHPMax", BuffLogicBase)
BuffLogicAddHPMax = BuffLogicAddHPMax

function BuffLogicAddHPMax:Constructor(buffInstance, logicParam)
  self._mulValue = logicParam.mulValue or 0
  self._addValue = logicParam.addValue or 0
  self._addHPMaxFromType = logicParam.addHPMaxFromType or AddHPMaxFromType.OwnerEntity
  self._addLimit = logicParam.addLimit or nil
  self._totalAddLimit = logicParam.totalAddLimit
  self._displayDamage = logicParam.displayDamage or 1
  self._notAddHP = logicParam.notAddHP or 0
  buffInstance.__AddHPMax_AddValue = 0
end

function BuffLogicAddHPMax:DoLogic(notify)
  local entity = self._buffInstance:Entity()
  local matchType = self._world:MatchType()
  if matchType ~= MatchType.MT_Maze and self._world:MatchType(GetMatchTypeType.SeasonMazeWorldBoss) ~= MatchType.MT_SeasonMaze and entity:HasPetPstID() then
    entity = entity:Pet():GetOwnerTeamEntity()
  end
  local curHp = entity:Attributes():GetCurrentHP()
  if not curHp then
    return
  end
  if entity:Attributes():GetCurrentHP() == 0 then
    return
  end
  local calcDamage = self._world:GetService("CalcDamage")
  local attributeEntity
  if self._addHPMaxFromType == AddHPMaxFromType.OwnerEntity then
    attributeEntity = entity
  elseif self._addHPMaxFromType == AddHPMaxFromType.NotifyEntity then
    attributeEntity = notify:GetNotifyEntity()
  end
  local baseMaxHp = attributeEntity:Attributes():CalcMaxHp()
  local add_value = math.floor(baseMaxHp * self._mulValue + self._addValue + 0.5)
  if self._addLimit then
    local ownerMaxHp = entity:Attributes():CalcMaxHp()
    add_value = math.min(add_value, math.floor(ownerMaxHp * self._addLimit))
  end
  if self._totalAddLimit then
    local curAddHpMax = self._buffComponent:GetBuffValue("AddHPMaxTotalLimit") or 0
    if curAddHpMax + add_value > math.floor(baseMaxHp * self._totalAddLimit + 0.5) then
      add_value = math.floor(baseMaxHp * self._totalAddLimit - curAddHpMax + 0.5)
    end
    self._buffComponent:AddBuffValue("AddHPMaxTotalLimit", add_value)
  end
  self._buffInstance.__AddHPMax_AddValue = self._buffInstance.__AddHPMax_AddValue + add_value
  local ret = calcDamage:AddTargetMaxHP(entity:GetID(), self._buffInstance.__AddHPMax_AddValue, self:GetBuffSeq())
  local damageInfo = DamageInfo:New(add_value, DamageType.Recover)
  if self._notAddHP ~= 1 then
    calcDamage:AddTargetHP(entity:GetID(), damageInfo)
  end
  local buffResult = BuffResultAddHPMax:New(entity:GetID(), damageInfo, ret, self._displayDamage, self._notAddHP)
  return buffResult
end
