_class("BuffLogicSetBurnIncrease", BuffLogicBase)
BuffLogicSetBurnIncrease = BuffLogicSetBurnIncrease

function BuffLogicSetBurnIncrease:Constructor(buffInstance, logicParam)
  self._addValue = logicParam.addValue or 0
end

function BuffLogicSetBurnIncrease:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetBuffValue("BurnIncrease", 1 + self._addValue)
end

_class("BuffLogicResetBurnIncrease", BuffLogicBase)
BuffLogicResetBurnIncrease = BuffLogicResetBurnIncrease

function BuffLogicResetBurnIncrease:Constructor(buffInstance, logicParam)
end

function BuffLogicResetBurnIncrease:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetBuffValue("BurnIncrease", 1)
end
