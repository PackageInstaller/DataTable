require("_buff_result_base")
_class("BuffResultNumLockHP", BuffResultBase)
BuffResultNumLockHP = BuffResultNumLockHP

function BuffResultNumLockHP:Constructor(entityID, num)
  self._entityID = entityID
  self._num = num
end

function BuffResultNumLockHP:GetEntityID()
  return self._entityID
end

function BuffResultNumLockHP:GetNumLockHP()
  return self._num
end
