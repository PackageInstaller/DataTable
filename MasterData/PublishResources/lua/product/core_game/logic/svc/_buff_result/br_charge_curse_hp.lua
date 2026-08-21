require("_buff_result_base")
_class("BuffResultChargeCurseHP", BuffResultBase)
BuffResultChargeCurseHP = BuffResultChargeCurseHP

function BuffResultChargeCurseHP:Constructor(entityID, val, changedVal, showDamage, showDamageElementType)
  self._entityID = entityID
  self._curseHPVal = val
  self._changedVal = changedVal
  self._showDamage = showDamage
  self._showDamageElementType = showDamageElementType
end

function BuffResultChargeCurseHP:GetChangedVal()
  return self._changedVal
end

function BuffResultChargeCurseHP:GetEntityID()
  return self._entityID
end

function BuffResultChargeCurseHP:GetCurseHPVal()
  return self._curseHPVal
end

function BuffResultChargeCurseHP:GetShowDamage()
  return self._showDamage
end

function BuffResultChargeCurseHP:GetShowDamageElementType()
  return self._showDamageElementType
end
