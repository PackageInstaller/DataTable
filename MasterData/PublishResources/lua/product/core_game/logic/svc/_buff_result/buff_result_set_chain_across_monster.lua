require("_buff_result_base")
_class("BuffResultSetChainAcrossMonster", BuffResultBase)
BuffResultSetChainAcrossMonster = BuffResultSetChainAcrossMonster

function BuffResultSetChainAcrossMonster:Constructor(remove, moveEffect)
  self._remove = remove
  self._moveEffect = moveEffect
end

function BuffResultSetChainAcrossMonster:GetRemove()
  return self._remove
end

function BuffResultSetChainAcrossMonster:GetMoveEffect()
  return self._moveEffect
end
