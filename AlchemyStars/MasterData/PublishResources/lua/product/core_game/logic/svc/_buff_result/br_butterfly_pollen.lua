_class("BuffResultButterflyPollen", BuffResultBase)
BuffResultButterflyPollen = BuffResultButterflyPollen

function BuffResultButterflyPollen:SetRecoveryDamageInfo(damageInfo)
  self._recoveryDamageInfo = damageInfo
end

function BuffResultButterflyPollen:SetPoisonDamageInfo(damageInfo)
  self._poisonDamageInfo = damageInfo
end

function BuffResultButterflyPollen:GetRecoveryDamageInfo()
  return self._recoveryDamageInfo
end

function BuffResultButterflyPollen:GetPoisonDamageInfo()
  return self._poisonDamageInfo
end

function BuffResultButterflyPollen:GetDamageInfo()
  return self._poisonDamageInfo
end
