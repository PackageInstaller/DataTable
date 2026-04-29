_class("BuffResultSetDoubleChain", BuffResultBase)
BuffResultSetDoubleChain = BuffResultSetDoubleChain

function BuffResultSetDoubleChain:Constructor(chainSkillCount, rate)
  self._chainSkillCount = chainSkillCount
  self._rate = rate
end

function BuffResultSetDoubleChain:GetChainSkillCount()
  return self._chainSkillCount
end

function BuffResultSetDoubleChain:GetRate()
  return self._rate
end

_class("BuffResultResetDoubleChain", BuffResultBase)
BuffResultResetDoubleChain = BuffResultResetDoubleChain

function BuffResultResetDoubleChain:Constructor(chainSkillCount, rate)
  self._chainSkillCount = chainSkillCount
  self._rate = rate
end

function BuffResultResetDoubleChain:GetChainSkillCount()
  return self._chainSkillCount
end

function BuffResultResetDoubleChain:GetRate()
  return self._rate
end
