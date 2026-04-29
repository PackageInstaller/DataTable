_class("BuffViewButterflyPollen", BuffViewBase)
BuffViewButterflyPollen = BuffViewButterflyPollen

function BuffViewButterflyPollen:PlayView(TT)
  local poisonDamageInfo = self._buffResult:GetPoisonDamageInfo()
  if poisonDamageInfo then
    local playBuffSvc = self._world:GetService("PlayBuff")
    playBuffSvc:PlayDamageBuff(TT, self)
  end
  local recoveryDamageInfo = self._buffResult:GetRecoveryDamageInfo()
  if recoveryDamageInfo then
    local playDamageService = self._world:GetService("PlayDamage")
    playDamageService:AsyncUpdateHPAndDisplayDamage(self._entity, recoveryDamageInfo)
  end
end
