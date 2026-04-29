require("_buff_result_base")
_class("BuffResultSetChainAcrossSelectMonster", BuffResultBase)
BuffResultSetChainAcrossSelectMonster = BuffResultSetChainAcrossSelectMonster

function BuffResultSetChainAcrossSelectMonster:Constructor(remove, entityID)
  self._remove = remove
  self._entityID = entityID
end

function BuffResultSetChainAcrossSelectMonster:GetRemove()
  return self._remove
end

function BuffResultSetChainAcrossSelectMonster:GetEntityID()
  return self._entityID
end
