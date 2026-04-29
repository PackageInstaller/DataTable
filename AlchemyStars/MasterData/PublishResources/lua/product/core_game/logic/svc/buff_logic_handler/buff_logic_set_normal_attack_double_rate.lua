_class("BuffLogicSetNormalAttackDoubleRate", BuffLogicBase)
BuffLogicSetNormalAttackDoubleRate = BuffLogicSetNormalAttackDoubleRate

function BuffLogicSetNormalAttackDoubleRate:Constructor(buffInstance, logicParam)
  self._baseRate = logicParam.baseRate or 0
  self._eachMoveIncreaseRate = logicParam.eachMoveIncreaseRate or 0
end

function BuffLogicSetNormalAttackDoubleRate:DoLogic(notify)
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetBuffValue("NormalAttackDoubleBaseRate", self._baseRate)
  e:BuffComponent():SetBuffValue("NormalAttackDoubleEachMoveIncreaseRate", self._eachMoveIncreaseRate)
end
