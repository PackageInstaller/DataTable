_class("BuffResultSetNormalAttackDirEff", BuffResultBase)
BuffResultSetNormalAttackDirEff = BuffResultSetNormalAttackDirEff

function BuffResultSetNormalAttackDirEff:Constructor(effectDirList, animName, waitTime, remove, effectID, curRoundHadSave)
  self._effectDirList = effectDirList
  self._animName = animName
  self._waitTime = waitTime
  self._remove = remove
  self._effectID = effectID
  self._curRoundHadSave = curRoundHadSave
end

function BuffResultSetNormalAttackDirEff:GetEffectDirList()
  return self._effectDirList
end

function BuffResultSetNormalAttackDirEff:GetAnimName()
  return self._animName
end

function BuffResultSetNormalAttackDirEff:GetWaitTime()
  return self._waitTime
end

function BuffResultSetNormalAttackDirEff:GetRemove()
  return self._remove
end

function BuffResultSetNormalAttackDirEff:GetEffectID()
  return self._effectID
end

function BuffResultSetNormalAttackDirEff:GetCurRoundHadSave()
  return self._curRoundHadSave
end
