_class("BuffLogicChangeAttackByDefenceChange", BuffLogicBase)
BuffLogicChangeAttackByDefenceChange = BuffLogicChangeAttackByDefenceChange

function BuffLogicChangeAttackByDefenceChange:Constructor(buffInstance, logicParam)
  self._percent = logicParam.percent or 1
end

function BuffLogicChangeAttackByDefenceChange:DoLogic()
  local attributesComponent = self._entity:Attributes()
  local totalDefence = attributesComponent:GetDefence()
  local baseDefence = attributesComponent:GetAttribute("Defense")
  local change = totalDefence - baseDefence
  if change ~= 0 then
    change = change * self._percent
    self._buffLogicService:ChangeBaseAttack(self._entity, self:GetBuffSeq(), ModifyBaseAttackType.AttackConstantFix, change)
    return true
  end
end

_class("BuffLogicRemoveChangeAttackByDefenceChange", BuffLogicBase)
BuffLogicRemoveChangeAttackByDefenceChange = BuffLogicRemoveChangeAttackByDefenceChange

function BuffLogicRemoveChangeAttackByDefenceChange:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveChangeAttackByDefenceChange:DoLogic()
  self._buffLogicService:RemoveBaseAttack(self._entity, self:GetBuffSeq(), ModifyBaseAttackType.AttackConstantFix)
  return true
end
