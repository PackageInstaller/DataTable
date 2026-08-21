_class("BuffLogicSetDoubleChain", BuffLogicBase)
BuffLogicSetDoubleChain = BuffLogicSetDoubleChain

function BuffLogicSetDoubleChain:Constructor(buffInstance, logicParam)
  self._chainSkillCount = logicParam.chainSkillCount
  self._rate = logicParam.rate
end

function BuffLogicSetDoubleChain:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetBuffValue("ChainSkillCount", self._chainSkillCount)
  e:BuffComponent():SetBuffValue("DoubleChainRate", self._rate)
  local buffResult = BuffResultSetDoubleChain:New(self._chainSkillCount, self._rate)
  return buffResult
end

_class("BuffLogicResetDoubleChain", BuffLogicBase)
BuffLogicResetDoubleChain = BuffLogicResetDoubleChain

function BuffLogicResetDoubleChain:Constructor(buffInstance, logicParam)
  self._chainSkillCount = logicParam.chainSkillCount
end

function BuffLogicResetDoubleChain:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetBuffValue("ChainSkillCount", 1)
  e:BuffComponent():SetBuffValue("DoubleChainRate", 1)
  local buffResult = BuffResultResetDoubleChain:New(1, 1)
  return buffResult
end
