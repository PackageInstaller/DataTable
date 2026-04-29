_class("BuffLogicSetNormalAttackSeparateDouble", BuffLogicBase)
BuffLogicSetNormalAttackSeparateDouble = BuffLogicSetNormalAttackSeparateDouble

function BuffLogicSetNormalAttackSeparateDouble:Constructor(buffInstance, logicParam)
  self._count = logicParam.count
  self._skillID = logicParam.skillID
end

function BuffLogicSetNormalAttackSeparateDouble:DoLogic(notify)
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetBuffValue("NormalAttackSeparateDoubleCount", self._count)
  e:BuffComponent():SetBuffValue("NormalAttackSeparateDoubleSkillID", self._skillID)
end

_class("BuffLogicResetNormalAttackSeparateDouble", BuffLogicBase)
BuffLogicResetNormalAttackSeparateDouble = BuffLogicResetNormalAttackSeparateDouble

function BuffLogicResetNormalAttackSeparateDouble:Constructor(buffInstance, logicParam)
end

function BuffLogicResetNormalAttackSeparateDouble:DoLogic(notify)
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetBuffValue("NormalAttackSeparateDoubleCount", nil)
  e:BuffComponent():SetBuffValue("NormalAttackSeparateDoubleSkillID", nil)
end
