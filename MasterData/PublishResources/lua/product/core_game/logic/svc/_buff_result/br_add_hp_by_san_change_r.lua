_class("BuffResultAddHPBySanChange", BuffResultBase)
BuffResultAddHPBySanChange = BuffResultAddHPBySanChange

function BuffResultAddHPBySanChange:Constructor(damageInfo, notify)
  self._damageInfo = damageInfo
  self._notify = notify
end

function BuffResultAddHPBySanChange:GetDamageInfo()
  return self._damageInfo
end

function BuffResultAddHPBySanChange:GetLogicNotify()
  return self._notify
end
