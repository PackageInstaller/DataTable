_class("BuffViewAddBleedPlus", BuffViewBase)
BuffViewAddBleedPlus = BuffViewAddBleedPlus

function BuffViewAddBleedPlus:PlayView(TT)
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayDamageBuff(TT, self)
end
