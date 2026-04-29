require("reactive_system")
_class("CommandReceiveSystem", ReactiveSystem)
CommandReceiveSystem = CommandReceiveSystem

function CommandReceiveSystem:Constructor(world)
  self.world = world
end

function CommandReceiveSystem:GetTrigger(world)
  local group = world:GetGroup(world.BW_WEMatchers.CommandReceiver)
  local c = Collector:New({group}, {"Added"})
  return c
end

function CommandReceiveSystem:Filter(entity)
  return entity:HasCommandReceiver()
end

function CommandReceiveSystem:ExecuteEntities(entities)
  for i = 1, #entities do
    local e = entities[i]
    e:CommandReceiver():Dispatch()
  end
end
