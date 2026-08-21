_class("BuffViewAddPoisonByAttack", BuffViewBase)
BuffViewAddPoisonByAttack = BuffViewAddPoisonByAttack

function BuffViewAddPoisonByAttack:PlayView(TT)
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayDamageBuff(TT, self)
end
