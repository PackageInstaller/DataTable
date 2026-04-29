_class("BuffResultCalcScope", BuffResultBase)
BuffResultCalcScope = BuffResultCalcScope

function BuffResultCalcScope:Constructor(scopeResult)
  self.scopeResult = scopeResult
end

function BuffResultCalcScope:GetScopeResult()
  return self.scopeResult
end
