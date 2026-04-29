_class("BuffViewAddHPByLayerMark", BuffViewBase)
BuffViewAddHPByLayerMark = BuffViewAddHPByLayerMark

function BuffViewAddHPByLayerMark:Constructor()
end

function BuffViewAddHPByLayerMark:PlayView(TT)
  local res = self._buffResult
  local damageInfo = res:GetDamageInfo()
  local entity = self._world:GetEntityByID(res:GetEntityID())
  YIELD(TT)
  local materialAnimationComponent = entity:MaterialAnimationComponent()
  if materialAnimationComponent then
    materialAnimationComponent:PlayCure()
  end
  local playDamageService = self._world:GetService("PlayDamage")
  playDamageService:AsyncUpdateHPAndDisplayDamage(entity, damageInfo)
end
