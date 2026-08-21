require("_buff_view_base_r")
_class("BuffViewRecoverFromGreyHP", BuffViewBase)
BuffViewRecoverFromGreyHP = BuffViewRecoverFromGreyHP

function BuffViewRecoverFromGreyHP:IsNotifyMatch(notify)
  return true
end

function BuffViewRecoverFromGreyHP:PlayView(TT)
  local damageInfo = self._buffResult:GetDamageInfo()
  local playDamageService = self._world:GetService("PlayDamage")
  playDamageService:AsyncUpdateHPAndDisplayDamage(self._entity, damageInfo)
  local result = self._buffResult
  local greyHPVal = result:GetFinalGreyHPVal()
  self._entity:ReplaceGreyHP(greyHPVal)
end
