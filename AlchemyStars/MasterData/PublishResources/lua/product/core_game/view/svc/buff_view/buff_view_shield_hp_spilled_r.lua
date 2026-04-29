_class("BuffViewAddHPShieldHpSpilled", BuffViewBase)
BuffViewAddHPShieldHpSpilled = BuffViewAddHPShieldHpSpilled

function BuffViewAddHPShieldHpSpilled:PlayView(TT)
  local seq = self:GetBuffResult():GetBuffSeq()
  local playBuffSvc = self._world:GetService("PlayBuff")
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local inst = teamEntity:BuffView():GetBuffViewInstance(seq)
  playBuffSvc:PlayAddBuff(TT, inst)
end
