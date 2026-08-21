_class("BuffLogicPSPChangeAtkByBaseDefence", BuffLogicBase)
BuffLogicPSPChangeAtkByBaseDefence = BuffLogicPSPChangeAtkByBaseDefence

function BuffLogicPSPChangeAtkByBaseDefence:Constructor(buffInstance, logicParam)
  self._rate = logicParam.rate or 0
end

function BuffLogicPSPChangeAtkByBaseDefence:DoLogic()
  local entity = self._buffInstance:Entity()
  local comp = entity:Attributes()
  if not comp then
    return false
  end
  local baseDefence = comp:GetAttribute("Defense")
  local addValue = math.floor(self._rate * baseDefence + 0.5)
  local curModifyVal = self._buffLogicService:GetModifyValueByID(entity, "AttackConstantFix", self:GetBuffSeq())
  addValue = addValue + curModifyVal
  self._buffLogicService:ChangeBaseAttack(entity, self:GetBuffSeq(), ModifyBaseAttackType.AttackConstantFix, addValue)
end

function BuffLogicPSPChangeAtkByBaseDefence:DoOverlap(logicParam)
  return self:DoLogic()
end

_class("BuffLogicUndoPSPChangeAtkByBaseDefence", BuffLogicBase)
BuffLogicUndoPSPChangeAtkByBaseDefence = BuffLogicUndoPSPChangeAtkByBaseDefence

function BuffLogicUndoPSPChangeAtkByBaseDefence:Constructor(buffInstance, logicParam)
end

function BuffLogicUndoPSPChangeAtkByBaseDefence:DoLogic()
  local e = self._buffInstance:Entity()
  self._buffLogicService:RemoveBaseAttack(e, self:GetBuffSeq(), ModifyBaseAttackType.AttackConstantFix)
end
