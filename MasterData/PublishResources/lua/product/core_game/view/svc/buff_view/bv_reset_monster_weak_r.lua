_class("BuffViewResetMonsterWeak", BuffViewBase)
BuffViewResetMonsterWeak = BuffViewResetMonsterWeak

function BuffViewResetMonsterWeak:PlayView(TT)
  local ownerEntity = self:Entity()
  local monsterRSvc = self._world:GetService("MonsterShowRender")
  monsterRSvc:RemoveMonsterWeak(ownerEntity)
  local buffResult = self._buffResult
  monsterRSvc:ShowMonsterWeak(ownerEntity, buffResult:GetWeakResult())
end
