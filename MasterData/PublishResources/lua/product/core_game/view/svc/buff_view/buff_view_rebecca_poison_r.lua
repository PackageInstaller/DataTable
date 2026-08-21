_class("BuffViewAddRebeccaPoison", BuffViewBase)
BuffViewAddRebeccaPoison = BuffViewAddRebeccaPoison

function BuffViewAddRebeccaPoison:PlayView(TT)
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayDamageBuff(TT, self)
end
