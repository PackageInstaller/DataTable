_class("BuffLogicPSPModifyMaxHPByType", BuffLogicBase)
BuffLogicPSPModifyMaxHPByType = BuffLogicPSPModifyMaxHPByType

function BuffLogicPSPModifyMaxHPByType:Constructor(buffInstance, logicParam)
  self._mulValue = logicParam.mulValue or 0
  self._modifyType = logicParam.modifyType
  self._display = logicParam.display or 1
  self._notAddHP = logicParam.notAddHP or 0
end

function BuffLogicPSPModifyMaxHPByType:DoLogic(notify)
  local entity = self._entity
  if entity:HasPetPstID() and self._world:MatchType(GetMatchTypeType.SeasonMazeWorldBoss) ~= MatchType.MT_SeasonMaze then
    entity = entity:Pet():GetOwnerTeamEntity()
  end
  local curHp = entity:Attributes():GetCurrentHP()
  local curMaxHP = entity:Attributes():CalcMaxHp()
  if not curHp then
    return
  end
  if entity:Attributes():GetCurrentHP() == 0 then
    return
  end
  local battleSvc = self._world:GetService("Battle")
  local count = battleSvc:GetCountByModifyType(self._modifyType)
  if not count then
    return
  end
  local damageSvc = self._world:GetService("CalcDamage")
  local attributeEntity = self._entity
  local baseMaxHP = attributeEntity:Attributes():GetAttribute("MaxHP")
  local addValue = math.floor(baseMaxHP * self._mulValue * count + 0.5)
  local curModifyVal = self._buffLogicService:GetModifyValueByID(entity, "MaxHPConstantFix", self:GetBuffSeq())
  addValue = addValue + curModifyVal
  local ret = damageSvc:AddTargetMaxHP(entity:GetID(), addValue, self:GetBuffSeq())
  local newMaxHP = entity:Attributes():CalcMaxHp()
  local addRedHP = math.floor(newMaxHP * curHp / curMaxHP - curHp + 0.5)
  local damageInfo = DamageInfo:New(addRedHP, DamageType.Recover)
  if self._notAddHP ~= 1 then
    damageSvc:AddTargetHP(entity:GetID(), damageInfo)
  end
  local buffResult = BuffResultAddHPMax:New(entity:GetID(), damageInfo, ret, self._displayDamage, self._notAddHP)
  return buffResult
end
