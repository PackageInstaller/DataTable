_class("BuffLogicChangeAttackByDamage", BuffLogicBase)
BuffLogicChangeAttackByDamage = BuffLogicChangeAttackByDamage

function BuffLogicChangeAttackByDamage:Constructor(buffInstance, logicParam)
  self._percent = logicParam.percent or 1
  self._buffInstance._saveDamage = 0
end

function BuffLogicChangeAttackByDamage:DoLogic(notify)
  if not notify.GetDamageValue then
    return
  end
  local newDamage = notify:GetDamageValue()
  if not newDamage then
    return
  end
  if newDamage > self._buffInstance._saveDamage then
    self._buffInstance._saveDamage = newDamage
  end
  local change = math.floor(self._buffInstance._saveDamage * self._percent)
  if change ~= 0 then
    self._buffLogicService:ChangeBaseAttack(self._entity, self:GetBuffSeq(), ModifyBaseAttackType.AttackConstantFix, change)
    return true
  end
end

_class("BuffLogicRemoveChangeAttackByDamage", BuffLogicBase)
BuffLogicRemoveChangeAttackByDamage = BuffLogicRemoveChangeAttackByDamage

function BuffLogicRemoveChangeAttackByDamage:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveChangeAttackByDamage:DoLogic()
  self._buffInstance._saveDamage = 0
  self._buffLogicService:RemoveBaseAttack(self._entity, self:GetBuffSeq(), ModifyBaseAttackType.AttackConstantFix)
  return true
end
