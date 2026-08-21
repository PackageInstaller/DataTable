_class("BuffViewRemoveMonsterWeak", BuffViewBase)
BuffViewRemoveMonsterWeak = BuffViewRemoveMonsterWeak

function BuffViewRemoveMonsterWeak:PlayView(TT)
  local ownerEntity = self:Entity()
  if not ownerEntity then
    return
  end
  local monsterRSvc = self._world:GetService("MonsterShowRender")
  monsterRSvc:RemoveMonsterWeak(ownerEntity)
end
