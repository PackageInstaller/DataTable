_class("BuffResultChangeSanValue", BuffResultBase)
BuffResultChangeSanValue = BuffResultChangeSanValue

function BuffResultChangeSanValue:Constructor(curSan, oldSan, realModifyValue, debtVal, modifyTimes, forceRefresh)
  self._curSan = curSan
  self._oldSan = oldSan
  self._realModifyValue = realModifyValue
  self._debtVal = debtVal
  self._modifyTimes = modifyTimes
  self._forceRefresh = forceRefresh
end

function BuffResultChangeSanValue:GetCurSan()
  return self._curSan
end

function BuffResultChangeSanValue:GetOldSan()
  return self._oldSan
end

function BuffResultChangeSanValue:GetRealModifyValue()
  return self._realModifyValue
end

function BuffResultChangeSanValue:GetDebtVal()
  return self._debtVal
end

function BuffResultChangeSanValue:GetModifyTimes()
  return self._modifyTimes
end

function BuffResultChangeSanValue:GetForceRefresh()
  return self._forceRefresh
end
