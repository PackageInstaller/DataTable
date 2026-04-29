_class("MonsterViewAddSystem_Render", ReactiveSystem)
MonsterViewAddSystem_Render = MonsterViewAddSystem_Render

function MonsterViewAddSystem_Render:Constructor(world)
  self._world = world
end

function MonsterViewAddSystem_Render:GetTrigger(world)
  local group = world:GetGroup(world.BW_WEMatchers.View)
  local c = Collector:New({group}, {"Added"})
  return c
end

function MonsterViewAddSystem_Render:Filter(entity)
  if entity:HasGhost() or entity:HasGuideGhost() then
    return false
  end
  return entity:HasMonsterID()
end

function MonsterViewAddSystem_Render:ExecuteEntities(entities)
  for i = 1, #entities do
    self:OnMonsterViewAdded(entities[i])
  end
end

function MonsterViewAddSystem_Render:OnMonsterViewAdded(monsterEntity)
end
