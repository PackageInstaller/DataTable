_class("RealNetworkService", Object)

function RealNetworkService:Constructor(world)
  self._world = world
  self._match_module = GameGlobal.GetModule(MatchModule)
  self._match_module:SetNetworkService(self)
end

function RealNetworkService:ReceiveMessage(recMsg)
  local world = self._world
  if world.WorldHandleCommands and recMsg.Commands then
    world:WorldHandleCommands(recMsg.Commands)
  end
end
