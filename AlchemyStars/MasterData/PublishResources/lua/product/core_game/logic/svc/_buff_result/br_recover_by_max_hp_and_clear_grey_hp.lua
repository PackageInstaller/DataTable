require("_buff_result_base")
_class("BuffResultRecoverByMaxHPAndClearGreyHP", BuffResultBase)
BuffResultRecoverByMaxHPAndClearGreyHP = BuffResultRecoverByMaxHPAndClearGreyHP

function BuffResultRecoverByMaxHPAndClearGreyHP:Constructor(entityID, damageInfo)
  self._entityID = entityID
  self._damageInfo = damageInfo
end

function BuffResultRecoverByMaxHPAndClearGreyHP:GetEntityID()
  return self._entityID
end

function BuffResultRecoverByMaxHPAndClearGreyHP:GetDamageInfo()
  return self._damageInfo
end
