require("_buff_result_base")
_class("BuffResultChargeGreyHP", BuffResultBase)
BuffResultChargeGreyHP = BuffResultChargeGreyHP

function BuffResultChargeGreyHP:Constructor(entityID, val, notifyType, runCount, changedVal, damageHP)
  self._entityID = entityID
  self._greyHPVal = val
  self._notifyType = notifyType
  self._runCount = runCount
  self._changedVal = changedVal
  self._damageHP = damageHP
end

function BuffResultChargeGreyHP:GetDamageHP()
  return self._damageHP
end

function BuffResultChargeGreyHP:GetChangedVal()
  return self._changedVal
end

function BuffResultChargeGreyHP:GetEntityID()
  return self._entityID
end

function BuffResultChargeGreyHP:GetGreyHPVal()
  return self._greyHPVal
end

function BuffResultChargeGreyHP:GetLogicRunCount()
  return self._runCount
end

function BuffResultChargeGreyHP:GetNotifyType()
  return self._notifyType
end
