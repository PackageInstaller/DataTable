_class("BuffResultPSPAddHPByType", BuffResultBase)
BuffResultPSPAddHPByType = BuffResultPSPAddHPByType

function BuffResultPSPAddHPByType:Constructor(damageInfo, eid)
  self._damageInfo = damageInfo
  self._entityID = eid
end

function BuffResultPSPAddHPByType:GetDamageInfo()
  return self._damageInfo
end

function BuffResultPSPAddHPByType:GetEntityID()
  return self._entityID
end
