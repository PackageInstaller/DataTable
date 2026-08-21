_class("BuffLogicComboIncreaseCritProb", BuffLogicBase)
BuffLogicComboIncreaseCritProb = BuffLogicComboIncreaseCritProb

function BuffLogicComboIncreaseCritProb:Constructor(buffInstance, logicParam)
  self._addValue = logicParam.addValue or 0
  self._maxValue = logicParam.maxValue or 0
end

function BuffLogicComboIncreaseCritProb:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetBuffValue("EachComboIncreaseCritProb", self._addValue)
  e:BuffComponent():SetBuffValue("ComboIncreaseCritProbMax", self._maxValue)
  return true
end

_class("BuffLogicComboIncreaseCritProbUndo", BuffLogicBase)
BuffLogicComboIncreaseCritProbUndo = BuffLogicComboIncreaseCritProbUndo

function BuffLogicComboIncreaseCritProbUndo:Constructor(buffInstance, logicParam)
end

function BuffLogicComboIncreaseCritProbUndo:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetBuffValue("EachComboIncreaseCritProb", 0)
  e:BuffComponent():SetBuffValue("ComboIncreaseCritProbMax", 0)
  return true
end
