_class("BuffResultVampire", BuffResultBase)
BuffResultVampire = BuffResultVampire

function BuffResultVampire:Constructor(damageInfo)
  self._damageInfo = damageInfo
  self._isAddSan = false
end

function BuffResultVampire:GetDamageInfo()
  return self._damageInfo
end

function BuffResultVampire:SetOldSanValue(oldSan)
  self._oldSan = oldSan
end

function BuffResultVampire:SetModifySanValue(san)
  self._modifySan = san
end

function BuffResultVampire:SetNewSanValue(newSan)
  self._newSan = newSan
end

function BuffResultVampire:SetDebtValue(debt)
  self._debt = debt
end

function BuffResultVampire:SetModifyTimes(times)
  self._modifyTimes = times
end

function BuffResultVampire:SetAddSan(isAddSan)
  self._isAddSan = isAddSan
end

function BuffResultVampire:IsAddSan()
  return self._isAddSan
end

function BuffResultVampire:GetOldSanValue()
  return self._oldSan
end

function BuffResultVampire:GetNewSanValue()
  return self._newSan
end

function BuffResultVampire:GetModifySanValue()
  return self._modifySan
end

function BuffResultVampire:GetDebtValue()
  return self._debt
end

function BuffResultVampire:GetModifyTimes()
  return self._modifyTimes
end
