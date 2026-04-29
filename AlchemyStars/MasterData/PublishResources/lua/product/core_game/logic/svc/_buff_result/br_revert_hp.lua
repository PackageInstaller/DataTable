_class("BuffResultSaveRevertHP", BuffResultBase)
BuffResultSaveRevertHP = BuffResultSaveRevertHP

function BuffResultSaveRevertHP:Constructor(savedHP)
  self._savedHP = savedHP
end

function BuffResultSaveRevertHP:GetSavedHP()
  return self._savedHP
end

_class("BuffResultDoRevertHP", BuffResultBase)
BuffResultDoRevertHP = BuffResultDoRevertHP

function BuffResultDoRevertHP:Constructor(damageInfo)
  self._damageInfo = damageInfo
end

function BuffResultDoRevertHP:GetDamageInfo()
  return self._damageInfo
end
