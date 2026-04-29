require("base_world")
_class("CutsceneWorld", BaseWorld)
CutsceneWorld = CutsceneWorld

function CutsceneWorld:Constructor(worldInfo)
  self._id = 0
end

function CutsceneWorld:GetRunningPosition()
  return WorldRunPostion.Cutscene
end

function CutsceneWorld:GetService(service_name)
  if self.BW_Services then
    return self.BW_Services:GetService(service_name)
  end
end

function CutsceneWorld:Internal_CreateComponents()
  CutsceneWorldAssembler.AssembleCutsceneWorldComponentsBase(self)
  CutsceneWorldAssembler.AssembleCutsceneWorldComponents(self)
end

function CutsceneWorld:Internal_CreateSystems()
  self.BW_Systems = Systems:New()
  local systemList = {}
  local systemIndexList = {}
  local gamemode_config = CutsceneModeConfig
  for i = 1, #gamemode_config.Systems do
    local system_config = gamemode_config.Systems[i]
    local system_type = system_config.Type
    local new_system = Classes[system_type]:New(self)
    self.BW_Systems:Add(new_system)
  end
end

function CutsceneWorld:Internal_CreateServices()
  self.BW_Services = ServicesProvider:New()
  local gamemode_config = CutsceneModeConfig
  for i = 1, #gamemode_config.Services do
    local service_config = gamemode_config.Services[i]
    local newService = self:_CreateCutsceneService(service_config)
    if newService then
      self.BW_Services:AddService(service_config.Name, newService)
    end
  end
  self.BW_Services:InitServices()
end

function CutsceneWorld:_CreateCutsceneService(serviceTypeConfig)
  local service_type = serviceTypeConfig.Type
  local service_name = serviceTypeConfig.Name
  local newService
  local pClass = Classes[service_type]
  if nil == pClass then
    Log.error("-----------Services:Error, Add Service = ", service_type)
  end
  newService = pClass:New(self)
  return newService
end

function CutsceneWorld:IDGenerator()
  return GameGlobal.GameEventListenerIDGenerator()
end

function CutsceneWorld:UpdateWorld(deltaTimeMS)
  CutsceneWorld.super.UpdateWorld(self, deltaTimeMS)
end

function CutsceneWorld:GetWorldTimer()
  return GameGlobal.Timer()
end

function CutsceneWorld:IsDevelopEnv()
  return Log.loglevel < ELogLevel.None
end

function CutsceneWorld:SetEntityIdByEntityConfigId(entity, entityConfigId)
  self._id = self._id + 1
  entity:SetID(self._id)
  self._entities:Insert(self._id, entity)
end

function CutsceneWorld:SetRenderBoardEntity(e)
  self._renderBoardEntity = e
end

function CutsceneWorld:GetRenderBoardEntity()
  return self._renderBoardEntity
end
