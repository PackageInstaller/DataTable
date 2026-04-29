require("_buff_result_base")
_class("BuffResultChangeAttributeBasedOnDamage", BuffResultBase)
BuffResultChangeAttributeBasedOnDamage = BuffResultChangeAttributeBasedOnDamage

function BuffResultChangeAttributeBasedOnDamage:Constructor(entityID, damageInfo, maxHPResult)
  self._entityID = entityID
  self._damageInfo = damageInfo
  self._maxHPResult = maxHPResult
end

function BuffResultChangeAttributeBasedOnDamage:GetEntityID()
  return self._entityID
end

function BuffResultChangeAttributeBasedOnDamage:GetDamageInfo()
  return self._damageInfo
end

function BuffResultChangeAttributeBasedOnDamage:GetMaxHPResult()
  return self._maxHPResult
end
