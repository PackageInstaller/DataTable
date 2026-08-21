_class("SpawnSystem", ReactiveSystem)

function SpawnSystem:Constructor(world)
  self.world = world
end

function SpawnSystem:GetTrigger(world)
  local group = world:GetGroup(world.BW_WEMatchers.Spawn)
  local c = Collector:New({group}, {"Added"})
  return c
end

function SpawnSystem:Filter(entity)
  return entity:HasSpawn()
end

function SpawnSystem:ExecuteEntities(entities)
  local world = self.world
  for i = 1, #entities do
    local e = entities[i]
    local component = e:Spawn()
    local rule = component.SpawnRule
    rule:MakeSpawn(e, world)
    e:RemoveSpawn()
  end
end
