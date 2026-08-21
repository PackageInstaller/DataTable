require("_buff_view_base_r")
_class("BuffViewRecoverFromGreyHPByLayer", BuffViewBase)
BuffViewRecoverFromGreyHPByLayer = BuffViewRecoverFromGreyHPByLayer

function BuffViewRecoverFromGreyHPByLayer:IsNotifyMatch(notify)
  return true
end

function BuffViewRecoverFromGreyHPByLayer:PlayView(TT)
  local damageInfo = self._buffResult:GetDamageInfo()
  local playDamageService = self._world:GetService("PlayDamage")
  playDamageService:AsyncUpdateHPAndDisplayDamage(self._entity, damageInfo)
  local result = self._buffResult
  local greyHPVal = result:GetFinalGreyHPVal()
  self._entity:ReplaceGreyHP(greyHPVal)
end
