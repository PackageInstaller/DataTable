_class("BuffViewAddBurn", BuffViewBase)
BuffViewAddBurn = BuffViewAddBurn

function BuffViewAddBurn:PlayView(TT)
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayDamageBuff(TT, self)
end
