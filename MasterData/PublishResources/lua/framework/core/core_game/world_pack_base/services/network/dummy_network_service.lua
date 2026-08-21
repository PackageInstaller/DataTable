require("i_network_service")
_class("DummyNetworkService", INetworkService)
DummyNetworkService = DummyNetworkService

function DummyNetworkService:Constructor(world)
  self.world = world
end

function DummyNetworkService:SetDummyServer(dummyServer)
  self.DummyServer = dummyServer
end

function DummyNetworkService:ReceiveMessage(recMsg)
  local world = self.world
  if world.WorldHandleCommands and recMsg.Commands then
    world:WorldHandleCommands(recMsg.Commands)
  end
end

function DummyNetworkService:SendMessage(sendMsg)
  self:ReceiveMessage(sendMsg)
end

function DummyNetworkService:SendCommandsMessage(commands)
  if commands:Size() == 0 then
    return
  end
  local sendMsg = DummyNetworkMessages_SyncCommands:New()
  for i = 1, commands:Size() do
    local cmd = commands:GetAt(i)
    sendMsg:AddCommand(cmd)
  end
  if self.world.SyncWork ~= nil then
    sendMsg.SyncFrame = self.world.SyncWork:CurrFrame()
  end
  self:SendMessage(sendMsg)
end

_class("DummyNetworkMessages_SyncCommands", Object)

function DummyNetworkMessages_SyncCommands:Constructor()
  self.Commands = ArrayList:New()
  self.CLSID = 0
end

function DummyNetworkMessages_SyncCommands:AddCommand(cmd)
  self.Commands:PushBack(cmd)
end
