require("base_world")
_class("TestWorld", BaseWorld)

function TestWorld:Internal_CreateSystems()
  local systems = Systems:New()
  self.BW_Systems = systems
  systems:Add(InitializeWorldSystem:New(self))
  systems:Add(UnityInputSystem:New(self))
  systems:Add(CommandSendSystem:New(self))
  systems:Add(CommandReceiveSystem:New(self))
  systems:Add(MovementSystem:New(self))
  systems:Add(SpawnSystem:New(self))
  systems:Add(MainFSMSystem:New(self))
end

function TestWorld:Internal_CreateComponents()
  self:AddSpawnMng(FixedPointsSpawnMng:New({
    [1] = Vector3(-1, 0, -4),
    [2] = Vector3(1, 0, -4),
    [3] = Vector3(0, 0, -4)
  }))
end

function TestWorld:Internal_CreateServices()
  self.BW_Services = {
    Resource = UnityResourceService:New(),
    Network = DummyNetworkService:New(self)
  }
end

function TestWorld:GetEntityByID(entityID)
  return self._entities:Find(entityID)
end

function TestWorld:WorldHandleCommands(command_list)
  for i = 1, command_list:Size() do
    local cmd = command_list:GetAt(i)
    local e = self:GetEntityByID(cmd.EntityID)
    e:ReceiveCommand(cmd)
  end
end
