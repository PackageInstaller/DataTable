_class("BuffViewAddBleed", BuffViewBase)
BuffViewAddBleed = BuffViewAddBleed

function BuffViewAddBleed:PlayView(TT)
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayDamageBuff(TT, self)
end
