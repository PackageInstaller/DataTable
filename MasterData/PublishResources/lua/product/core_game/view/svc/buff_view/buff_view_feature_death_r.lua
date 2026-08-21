_class("BuffViewFeatureDeath", BuffViewBase)
BuffViewFeatureDeath = BuffViewFeatureDeath

function BuffViewFeatureDeath:PlayView(TT)
  local entity = self._entity
  local result = self._buffResult
  if entity:HasMonsterID() then
    local sMonsterShowRender = self._world:GetService("MonsterShowRender")
    sMonsterShowRender:DoOneMonsterFeatureDead(TT, entity)
  elseif entity:HasTrapID() then
    local trapServiceRender = self._world:GetService("TrapRender")
    trapServiceRender:DestroyTrap(TT, entity)
  end
end

function BuffViewFeatureDeath:IsNotifyMatch(notify)
  return true
end
