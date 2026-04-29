_class("BuffViewAddExplode", BuffViewBase)
BuffViewAddExplode = BuffViewAddExplode

function BuffViewAddExplode:IsNotifyMatch(notify)
  local combo = self._world:GetService("RenderBattle"):GetComboNum()
  Log.debug("BuffViewAddExplode:IsNotifyMatch() show combo=", combo, " view combo=", self._buffResult.combo)
  return combo >= self._buffResult:GetCombo()
end

function BuffViewAddExplode:PlayView(TT, notify)
  local effectService = self._world:GetService("Effect")
  local effectID = self:ViewParams().ExecEffectID
  effectService:CreateEffect(effectID, notify:GetDefenderEntity())
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayDamageBuff(TT, self)
end
