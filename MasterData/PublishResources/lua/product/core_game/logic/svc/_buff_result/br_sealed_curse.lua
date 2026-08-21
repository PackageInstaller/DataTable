_class("BuffResultSealedCurse", BuffResultBase)
BuffResultSealedCurse = BuffResultSealedCurse

function BuffResultSealedCurse:Constructor(buffSeq, isCursed)
  self._buffseq = buffSeq
  self._isCursed = isCursed
end

function BuffResultSealedCurse:IsCursed()
  return self._isCursed
end

function BuffResultSealedCurse:GetBuffSeq()
  return self._buffseq
end
