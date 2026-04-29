_class("BuffViewDamageByTargetMoveDis", BuffViewBase)
BuffViewDamageByTargetMoveDis = BuffViewDamageByTargetMoveDis

function BuffViewDamageByTargetMoveDis:PlayView(TT)
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayDamageBuff(TT, self)
end
