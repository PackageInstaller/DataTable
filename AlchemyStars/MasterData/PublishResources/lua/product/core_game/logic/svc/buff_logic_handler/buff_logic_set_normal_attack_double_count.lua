_class("BuffLogicSetNormalAttackDoubleCount", BuffLogicBase)
BuffLogicSetNormalAttackDoubleCount = BuffLogicSetNormalAttackDoubleCount

function BuffLogicSetNormalAttackDoubleCount:Constructor(buffInstance, logicParam)
  self._count = logicParam.count
end

function BuffLogicSetNormalAttackDoubleCount:DoLogic(notify)
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetBuffValue("NormalAttackDoubleCount", self._count)
end
