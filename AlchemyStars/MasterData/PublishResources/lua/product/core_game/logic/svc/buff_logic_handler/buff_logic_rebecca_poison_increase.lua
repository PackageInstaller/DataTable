_class("BuffLogicSetRebeccaPoisonIncrease", BuffLogicBase)
BuffLogicSetRebeccaPoisonIncrease = BuffLogicSetRebeccaPoisonIncrease

function BuffLogicSetRebeccaPoisonIncrease:Constructor(buffInstance, logicParam)
  self._addValue = logicParam.addValue or 0
end

function BuffLogicSetRebeccaPoisonIncrease:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetBuffValue("RebeccaPoisonIncrease", 1 + self._addValue)
end

_class("BuffLogicResetRebeccaPoisonIncrease", BuffLogicBase)
BuffLogicResetRebeccaPoisonIncrease = BuffLogicResetRebeccaPoisonIncrease

function BuffLogicResetRebeccaPoisonIncrease:Constructor(buffInstance, logicParam)
end

function BuffLogicResetRebeccaPoisonIncrease:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetBuffValue("RebeccaPoisonIncrease", 1)
end
