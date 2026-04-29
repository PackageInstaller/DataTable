_class("BuffResultDecreaseMaxHP", BuffResultBase)
BuffResultDecreaseMaxHP = BuffResultDecreaseMaxHP

function BuffResultDecreaseMaxHP:Constructor(eid, damageInfo, maxHPResult)
  self._eid = eid
  self._damageInfo = damageInfo
  self._maxHPResult = maxHPResult
end

function BuffResultDecreaseMaxHP:GetDamageInfo()
  return self._damageInfo
end

function BuffResultDecreaseMaxHP:GetEntityID()
  return self._eid
end

function BuffResultDecreaseMaxHP:GetMaxHPResult()
  return self._maxHPResult
end
