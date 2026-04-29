_class("BuffViewAddPoison", BuffViewBase)
BuffViewAddPoison = BuffViewAddPoison

function BuffViewAddPoison:PlayView(TT)
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayDamageBuff(TT, self)
  local recoverDamageInfos = self._buffResult:GetRecoverDamageInfo()
  local playDamageService = self._world:GetService("PlayDamage")
  for i, recoverDamageInfo in ipairs(recoverDamageInfos) do
    local playerEntity = self._world:GetEntityByID(recoverDamageInfo:GetTargetEntityID())
    playDamageService:AsyncUpdateHPAndDisplayDamage(playerEntity, recoverDamageInfo)
  end
end
