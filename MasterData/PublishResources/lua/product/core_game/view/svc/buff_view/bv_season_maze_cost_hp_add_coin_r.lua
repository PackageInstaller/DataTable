_class("BuffViewSMCostHPAddCoin", BuffViewBase)
BuffViewSMCostHPAddCoin = BuffViewSMCostHPAddCoin

function BuffViewSMCostHPAddCoin:PlayView(TT)
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayDamageBuff(TT, self)
end
