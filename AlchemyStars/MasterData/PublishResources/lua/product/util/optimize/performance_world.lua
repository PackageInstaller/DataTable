require("base_world")
local PerformanceModeConfig = {
  Systems = {
    {
      Name = "Loading",
      Type = "LoadingSystem",
      ClientType = "ClientLoadingSystem_Render"
    },
    {
      Name = "HitbackSystem_Render",
      Type = "HitbackSystem_Render"
    },
    {
      Name = "GridMoveSystem_Render",
      Type = "GridMoveSystem_Render"
    },
    {
      Name = "AnimatorControllerSystem_Render",
      Type = "AnimatorControllerSystem_Render"
    }
  },
  UniqueComponents = {
    MainCameraComponent = {}
  },
  Services = {
    {
      Name = "Config",
      Type = "ConfigService"
    },
    {
      Name = "BoardRender",
      Type = "BoardServiceRender"
    },
    {
      Name = "Piece",
      Type = "PieceServiceRender"
    },
    {
      Name = "TransformRenderer",
      Type = "TransformServiceRenderer"
    },
    {
      Name = "Time",
      Type = "ClientTimeService"
    },
    {
      Name = "ResourcesPool",
      Type = "ResourcesPoolService"
    },
    {
      Name = "Resource",
      Type = "UnityResourceService"
    },
    {
      Name = "RenderEntity",
      Type = "RenderEntityService"
    },
    {
      Name = "Loading",
      Type = "LoadingServiceRender"
    },
    {
      Name = "Effect",
      Type = "EffectService"
    },
    {
      Name = "Camera",
      Type = "CameraService"
    },
    {
      Name = "Affix",
      Type = "AffixService"
    },
    {
      Name = "Talent",
      Type = "TalentService"
    },
    {
      Name = "LogicEntity",
      Type = "LogicEntityService"
    },
    {
      Name = "PerformanceListener",
      Type = "PerformanceListenerServiceRender"
    },
    {
      Name = "TrapRender",
      Type = "TrapServiceRender"
    },
    {
      Name = "RandomLogic",
      Type = "RandomServiceLogic"
    },
    {
      Name = "CreateMonsterPos",
      Type = "CreateMonsterPosService"
    },
    {
      Name = "UtilData",
      Type = "UtilDataServiceShare"
    },
    {
      Name = "BoardLogic",
      Type = "BoardServiceLogic"
    },
    {
      Name = "Maze",
      Type = "MazeService"
    },
    {
      Name = "BattleDamageStatisticsLogic",
      Type = "BattleDamageStatisticsServiceLogic"
    }
  }
}
_class("PerformanceWorld", BaseWorld)
PerformanceWorld = PerformanceWorld

function PerformanceWorld:Constructor(worldInfo)
  self._id = 0
  self._checkCrossSide = false
  local wEComponents = ComponentsLookup:New({})
  local wUniqueComponents = ComponentsLookup:New({})
  local wEMatchers = {}
  MatchPackInstaller:InstallEntityComponentsLookup(wEComponents)
  MatchPackInstaller:InstallUniqueComponentsLookup(wUniqueComponents)
  BasePackInstaller:InstallEntityMatchers(wEMatchers, wEComponents)
  CombatPackInstaller:InstallEntityMatchers(wEMatchers, wEComponents)
  self.BWCC_EMatchers = wEMatchers
  self.BW_UniqueComponentsEnum = wUniqueComponents
  self._matchType = MatchType.MT_Mission
  self.BW_WEComponentsEnum = wEComponents
end

function PerformanceWorld:GetCameraObj()
  return self._world._request.Obj
end

function PerformanceWorld:SetSceneGO(sceneGO)
  self._sceneGO = sceneGO
end

function PerformanceWorld:GetSceneGO()
  return self._sceneGO
end

function PerformanceWorld:GetRunningPosition()
  return WorldRunPostion.Performance
end

function PerformanceWorld:EventDispatcher()
  return GameGlobal.EventDispatcher()
end

function PerformanceWorld:GetService(service_name)
  if self.BW_Services then
    return self.BW_Services:GetService(service_name)
  end
end

function PerformanceWorld:Internal_CreateComponents()
  CutsceneWorldAssembler.AssembleCutsceneWorldComponentsBase(self)
  CutsceneWorldAssembler.AssembleCutsceneWorldComponents(self)
end

function PerformanceWorld:Internal_CreateSystems()
  self.BW_Systems = Systems:New()
  local systemList = {}
  local systemIndexList = {}
  local gamemode_config = PerformanceModeConfig
  for i = 1, #gamemode_config.Systems do
    local system_config = gamemode_config.Systems[i]
    local system_type = system_config.Type
    local new_system = Classes[system_type]:New(self)
    self.BW_Systems:Add(new_system)
  end
end

function PerformanceWorld:Internal_CreateServices()
  self.BW_Services = ServicesProvider:New()
  local gamemode_config = PerformanceModeConfig
  for i = 1, #gamemode_config.Services do
    local service_config = gamemode_config.Services[i]
    local newService = self:_CreateCutsceneService(service_config)
    if newService then
      self.BW_Services:AddService(service_config.Name, newService)
    end
  end
  self.BW_Services:InitServices()
end

function PerformanceWorld:_CreateCutsceneService(serviceTypeConfig)
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

function PerformanceWorld:IDGenerator()
  return GameGlobal.GameEventListenerIDGenerator()
end

function PerformanceWorld:UpdateWorld(deltaTimeMS)
  PerformanceWorld.super.UpdateWorld(self, deltaTimeMS)
end

function PerformanceWorld:GetWorldTimer()
  return GameGlobal.Timer()
end

function PerformanceWorld:IsDevelopEnv()
  return Log.loglevel < ELogLevel.None
end

function PerformanceWorld:SetEntityIdByEntityConfigId(entity, entityConfigId)
  self._id = self._id + 1
  entity:SetID(self._id)
  self._entities:Insert(self._id, entity)
end

function PerformanceWorld:SetRenderBoardEntity(e)
  self._renderBoardEntity = e
end

function PerformanceWorld:GetRenderBoardEntity()
  return self._renderBoardEntity
end

function PerformanceWorld:Internal_CreateComponents()
  WorldAssembler.AssembleWorldComponents(self, PerformanceModeConfig)
end

function PerformanceWorld:GetBoardEntity()
  if EDITOR and CHECK_RENDER_ACCESS_LOGIC then
    local debugInfo = debug.getinfo(2, "S")
    local filePath = debugInfo.short_src
    local renderIndex = string.find(filePath, "_r.lua")
    if renderIndex ~= nil then
      Log.exception("render file :", filePath, " call GetBoardEntity() ", Log.traceback())
      return nil
    end
  end
  return self._boardEntity
end

function PerformanceWorld:GameFSM()
  if EDITOR and CHECK_RENDER_ACCESS_LOGIC then
    local debugInfo = debug.getinfo(2, "S")
    local filePath = debugInfo.short_src
    local renderIndex = string.find(filePath, "_r.lua")
    if renderIndex ~= nil then
      Log.exception("render file :", filePath, " call GameFSM() ", Log.traceback())
      return nil
    end
  end
  return self:GetUniqueComponent(self.BW_UniqueComponentsEnum.GameFSM)
end

function PerformanceWorld:HasGameFSM()
  return self:GetUniqueComponent(self.BW_UniqueComponentsEnum.GameFSM) ~= nil
end

function PerformanceWorld:AddGameFSM()
  local index = self.BW_UniqueComponentsEnum.GameFSM
  local component = GameFSMComponent:New(self)
  component:Initialize()
  self:SetUniqueComponent(index, component)
end

function PerformanceWorld:RemoveGameFSM()
  if self:HasGameFSM() then
    self:SetUniqueComponent(self.BW_UniqueComponentsEnum.GameFSM, nil)
  end
end

function PerformanceWorld:MainCamera()
  return self:GetUniqueComponent(self.BW_UniqueComponentsEnum.MainCamera)
end

function PerformanceWorld:HasMainCamera()
  return self:GetUniqueComponent(self.BW_UniqueComponentsEnum.MainCamera) ~= nil
end

function PerformanceWorld:AddMainCamera()
  local index = self.BW_UniqueComponentsEnum.MainCamera
  local component = MainCameraComponent:New(self)
  component:Initialize()
  self:SetUniqueComponent(index, component)
end

function PerformanceWorld:RemoveMainCamera()
  if self:HasMainCamera() then
    self:SetUniqueComponent(self.BW_UniqueComponentsEnum.MainCamera, nil)
  end
end

function PerformanceWorld:MatchType()
  return self._matchType
end

function PerformanceWorld:SetBoardEntity(boardEntity)
  self._boardEntity = boardEntity
end
