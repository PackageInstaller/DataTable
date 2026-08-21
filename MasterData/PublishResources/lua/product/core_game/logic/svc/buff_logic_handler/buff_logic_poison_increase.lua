_class("BuffLogicSetPoisonIncrease", BuffLogicBase)
BuffLogicSetPoisonIncrease = BuffLogicSetPoisonIncrease

function BuffLogicSetPoisonIncrease:Constructor(buffInstance, logicParam)
  self._addValue = logicParam.addValue or 0
end

function BuffLogicSetPoisonIncrease:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetBuffValue("PoisonIncrease", 1 + self._addValue)
end

_class("BuffLogicResetPoisonIncrease", BuffLogicBase)
BuffLogicResetPoisonIncrease = BuffLogicResetPoisonIncrease

function BuffLogicResetPoisonIncrease:Constructor(buffInstance, logicParam)
end

function BuffLogicResetPoisonIncrease:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetBuffValue("PoisonIncrease", 1)
end
