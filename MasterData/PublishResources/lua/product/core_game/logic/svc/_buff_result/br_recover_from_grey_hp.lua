require("_buff_result_base")
_class("BuffResultRecoverFromGreyHP", BuffResultBase)
BuffResultRecoverFromGreyHP = BuffResultRecoverFromGreyHP

function BuffResultRecoverFromGreyHP:Constructor(entityID, damageInfo, greyHPVal)
  self._entityID = entityID
  self._damageInfo = damageInfo
  self._finalGreyHPVal = greyHPVal
end

function BuffResultRecoverFromGreyHP:GetEntityID()
  return self._entityID
end

function BuffResultRecoverFromGreyHP:GetDamageInfo()
  return self._damageInfo
end

function BuffResultRecoverFromGreyHP:GetFinalGreyHPVal()
  return self._finalGreyHPVal
end
