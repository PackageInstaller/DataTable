_class("BuffResultResetMonsterWeak", BuffResultBase)
BuffResultResetMonsterWeak = BuffResultResetMonsterWeak

function BuffResultResetMonsterWeak:Constructor(weakResult)
  self._weakResult = weakResult
end

function BuffResultResetMonsterWeak:GetWeakResult()
  return self._weakResult
end
