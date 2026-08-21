require("_buff_result_base")
_class("BuffResultRecoverFromGreyHPByLayer", BuffResultBase)
BuffResultRecoverFromGreyHPByLayer = BuffResultRecoverFromGreyHPByLayer

function BuffResultRecoverFromGreyHPByLayer:Constructor(entityID, damageInfo, greyHPVal)
  self._entityID = entityID
  self._damageInfo = damageInfo
  self._finalGreyHPVal = greyHPVal
end

function BuffResultRecoverFromGreyHPByLayer:GetEntityID()
  return self._entityID
end

function BuffResultRecoverFromGreyHPByLayer:GetDamageInfo()
  return self._damageInfo
end

function BuffResultRecoverFromGreyHPByLayer:GetFinalGreyHPVal()
  return self._finalGreyHPVal
end
