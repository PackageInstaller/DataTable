_class("BuffResultCostHPBySanChangeDebt", BuffResultBase)
BuffResultCostHPBySanChangeDebt = BuffResultCostHPBySanChangeDebt

function BuffResultCostHPBySanChangeDebt:Constructor(damageInfo, notify)
  self._damageInfo = damageInfo
  self._notify = notify
end

function BuffResultCostHPBySanChangeDebt:GetDamageInfo()
  return self._damageInfo
end

function BuffResultCostHPBySanChangeDebt:GetLogicNotify()
  return self._notify
end
