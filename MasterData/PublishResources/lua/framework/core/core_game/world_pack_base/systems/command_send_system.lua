_class("CommandSendSystem", ReactiveSystem)
CommandSendSystem = CommandSendSystem

function CommandSendSystem:Constructor(world)
  self.world = world
  self.networkService = world.BW_Services.Network
end

function CommandSendSystem:GetTrigger(world)
  local group = world:GetGroup(world.BW_WEMatchers.CommandSender)
  local c = Collector:New({group}, {"Added"})
  return c
end

function CommandSendSystem:Filter(entity)
  return entity:HasCommandSender()
end

function CommandSendSystem:ExecuteEntities(entities)
  local network = self.networkService
  for i = 1, #entities do
    local e = entities[i]
    local sender = e:CommandSender()
    sender:PreHandleCommand()
    network:SendCommandsMessage(sender.SendQueue)
    sender.SendQueue:Clear()
  end
end
