_class("BuffViewPSPAddHPByType", BuffViewBase)
BuffViewPSPAddHPByType = BuffViewPSPAddHPByType

function BuffViewPSPAddHPByType:Constructor()
end

function BuffViewPSPAddHPByType:PlayView(TT)
  local res = self._buffResult
  local damageInfo = res:GetDamageInfo()
  local entity = self._world:GetEntityByID(res:GetEntityID())
  YIELD(TT)
  local matAniComponent = entity:MaterialAnimationComponent()
  if matAniComponent then
    matAniComponent:PlayCure()
  end
  local playDamageSvc = self._world:GetService("PlayDamage")
  playDamageSvc:AsyncUpdateHPAndDisplayDamage(entity, damageInfo)
end
