require("_buff_view_base_r")
_class("BuffViewRecoverByMaxHPAndClearGreyHP", BuffViewBase)
BuffViewRecoverByMaxHPAndClearGreyHP = BuffViewRecoverByMaxHPAndClearGreyHP

function BuffViewRecoverByMaxHPAndClearGreyHP:IsNotifyMatch(notify)
  return true
end

function BuffViewRecoverByMaxHPAndClearGreyHP:PlayView(TT)
  local result = self._buffResult
  local damageInfo = result:GetDamageInfo()
  local playDamageService = self._world:GetService("PlayDamage")
  playDamageService:AsyncUpdateHPAndDisplayDamage(self._entity, damageInfo)
  self._entity:ReplaceGreyHP(0)
end
