_class("BuffLogicSetMonsterAbsorb", BuffLogicBase)
BuffLogicSetMonsterAbsorb = BuffLogicSetMonsterAbsorb

function BuffLogicSetMonsterAbsorb:Constructor(buffInstance, logicParam)
  self._changeValueList = logicParam.changeValueList or {}
  self._buffInstance._effectList = logicParam.effectList or {}
  self._additionValue = logicParam.additionValue or 0
end

function BuffLogicSetMonsterAbsorb:DoLogic()
  local addValue = 0
  local ownerEntity = self:GetEntity()
  local attributesComponent = ownerEntity:Attributes()
  if attributesComponent then
    local curHP = attributesComponent:GetCurrentHP()
    local maxHP = attributesComponent:CalcMaxHp()
    addValue = self._additionValue * (1 - curHP / maxHP)
  end
  for k, paramType in ipairs(self._buffInstance._effectList) do
    local newValue = self._changeValueList[k] or -1
    newValue = newValue + addValue
    self._buffLogicService:ChangeMonsterSkillAbsorb(self._entity, self:GetBuffSeq(), paramType, newValue)
  end
end

_class("BuffLogicRemoveMonsterAbsorb", BuffLogicBase)
BuffLogicRemoveMonsterAbsorb = BuffLogicRemoveMonsterAbsorb

function BuffLogicRemoveMonsterAbsorb:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveMonsterAbsorb:DoLogic()
  local e = self._buffInstance:Entity()
  for k, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:RemoveMonsterSkillAbsorb(self._entity, self:GetBuffSeq(), paramType)
  end
end
