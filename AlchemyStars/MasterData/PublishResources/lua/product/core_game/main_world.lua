require("base_world")
_class("MainWorld", BaseWorld)
MainWorld = MainWorld

function MainWorld:Constructor(worldInfo)
  self._boardEntity = nil
  self._previewEntity = nil
  self._syncMode = worldInfo.syncMode
  self._matchType = worldInfo.matchType
  self._subMatchType = worldInfo.subMatchType
  self:RegisterMatchTypeProgressFunc()
  self:SetGameModeType()
  self._h3dTimer = H3DTimer:New(self)
  self._matchLogger = MatchLogger:New(self)
  self._detailMatchLogger = DetailMatchLogger:New(self)
  self._syncLogger = SyncLogger:New(self)
  self._dataLogger = DataLogger:New(self)
  self._skillScopeTargetSelector = SkillScopeTargetSelector:New(self)
  self._playerCommandHandler = PlayerCommandHandler:New(self)
  if GMCheat then
    self._gmCheater = GMCheat:New(self)
  end
  self.m_nHelpPetKey = worldInfo.m_nHelpPetKey
  self._logicSvcProvider = ServicesProvider:New()
  self._renderSvcProvider = ServicesProvider:New()
  self._shareSvcProvider = ServicesProvider:New()
  self._sepSvc = false
  self._affixList = worldInfo.affixList
  self._hardID = worldInfo.hardID
  self._currentTurn = GameTurnType.LocalPlayerTurn
  self._localHelpPetPstID = worldInfo:GetLocalHelpPetPstID()
  self._enlightenInfoDic = worldInfo.enlightenInfoDic
  self._linkLineType = worldInfo.linkLineType
end

function MainWorld:EnterWorld()
  MainWorld.super.EnterWorld(self)
end

function MainWorld:Dispose()
  MainWorld.super.Dispose(self)
end

function MainWorld:ExitWorld()
  MainWorld.super.ExitWorld(self)
end

function MainWorld:UpdateWorld(deltaTimeMS)
  MainWorld.super.UpdateWorld(self, deltaTimeMS)
end

function MainWorld:_Internal_CreateSystem()
  local systems = Systems:New()
  self.BW_Systems = systems
  local systemObjectList = {}
  local systemIndexList = {}
  local gamemode_config = GameModeConfig[GameModeType.CommonBaseMode]
  if not gamemode_config then
    local game_mode = self:GetGameMode()
    Log.fatal("wrong game mode :", game_mode)
    return
  end
  for _, systemList in pairs(gamemode_config.Systems) do
    for i = 1, #systemList do
      local system_config = systemList[i]
      local new_system = self:_CreateSystem(system_config)
      systemObjectList[system_config.Name] = new_system
      systemIndexList[#systemIndexList + 1] = system_config.Name
    end
  end
  if EDITOR then
    for i = 1, #gamemode_config.EditorSystems do
      local system_config = gamemode_config.EditorSystems[i]
      local new_system = self:_CreateSystem(system_config)
      systemObjectList[system_config.Name] = new_system
      systemIndexList[#systemIndexList + 1] = system_config.Name
    end
  end
  return systemObjectList, systemIndexList
end

function MainWorld:Internal_CreateSystems()
  local systemList, systemIndexList = self:_Internal_CreateSystem()
  local game_mode = self:GetGameMode()
  local gamemode_config = GameModeConfig[game_mode]
  if not gamemode_config then
    Log.fatal("wrong game mode :", game_mode)
    return
  end
  for _, gameModeSystemList in pairs(gamemode_config.Systems) do
    for i = 1, #gameModeSystemList do
      local system_config = gameModeSystemList[i]
      local new_system = self:_CreateSystem(system_config)
      if not table.icontains(systemList, system_config.Name) then
        systemIndexList[#systemIndexList + 1] = system_config.Name
      end
      systemList[system_config.Name] = new_system
    end
  end
  for i, name in ipairs(systemIndexList) do
    local new_system = systemList[name]
    if new_system then
      self.BW_Systems:Add(new_system)
    end
  end
end

function MainWorld:_CreateSystem(systemTypeConfig)
  local system_type = systemTypeConfig.Type
  local client_type = systemTypeConfig.ClientType
  local server_type = systemTypeConfig.ServerType
  local target_type, system
  local runPosition = self:GetRunningPosition()
  if client_type ~= nil and runPosition == WorldRunPostion.AtClient then
    target_type = client_type
  elseif server_type ~= nil and runPosition == WorldRunPostion.AtServer then
    target_type = server_type
  elseif SystemFilter:CheckSystem(system_type, runPosition) then
    target_type = system_type
  end
  if target_type ~= nil then
    system = Classes[target_type]:New(self)
  end
  return system
end

function MainWorld:Internal_CreateComponents()
  Log.fatal("Internal_CreateComponents")
  WorldAssembler.AssembleWorldComponentsBase(self)
  WorldAssembler.AssembleWorldComponents(self)
end

function MainWorld:Internal_CreateServicesBase()
  self.BW_Services = ServicesProvider:New()
  local game_mode = GameModeType.CommonBaseMode
  local gamemode_config = GameModeConfig[game_mode]
  if not gamemode_config then
    Log.debug("wrong game mode :", game_mode)
    return
  end
  for i = 1, #gamemode_config.Services do
    local service_config = gamemode_config.Services[i]
    local newService = self:_CreateService(service_config)
    if newService then
      self.BW_Services:AddService(service_config.Name, newService)
      if self._sepSvc then
        local svcRespType = ServiceFilter:GetServiceResponsibilityType(service_config.Name)
        if svcRespType == ResponsibilityType.Render then
          self._renderSvcProvider:AddService(service_config.Name, newService)
        elseif svcRespType == ResponsibilityType.Share then
          self._shareSvcProvider:AddService(service_config.Name, newService)
        else
          self._logicSvcProvider:AddService(service_config.Name, newService)
        end
      end
    end
  end
  if EDITOR and gamemode_config.EditorServices then
    for i = 1, #gamemode_config.EditorServices do
      local service_config = gamemode_config.EditorServices[i]
      local newService = self:_CreateService(service_config)
      if newService then
        self.BW_Services:AddService(service_config.Name, newService)
      end
    end
  end
end

function MainWorld:_CreateService(serviceTypeConfig)
  local service_type = serviceTypeConfig.Type
  local service_name = serviceTypeConfig.Name
  local newService
  local runPosition = self:GetRunningPosition()
  if ServiceFilter:CheckService(service_name, runPosition) then
    if service_name == "Network" then
      local networkMode = self.BW_WorldInfo.network_mode
      if networkMode == NetworkMode.StandAlone then
        service_type = serviceTypeConfig.ClientType
      else
        service_type = serviceTypeConfig.Type
      end
    elseif self:RunAtClient() and serviceTypeConfig.ClientType then
      service_type = serviceTypeConfig.ClientType
    elseif self:RunAtServer() and serviceTypeConfig.ServerType then
      service_type = serviceTypeConfig.ServerType
    end
    local pClass = Classes[service_type]
    if nil == pClass then
      Log.error("-----------Services:Error, Add Service = ", service_type)
    end
    newService = pClass:New(self)
  end
  return newService
end

function MainWorld:Internal_CreateServices()
  self:Internal_CreateServicesBase()
  local game_mode = self:GetGameMode()
  local gamemode_config = GameModeConfig[game_mode]
  if not gamemode_config then
    Log.debug("wrong game mode :", game_mode)
    return
  end
  for i = 1, #gamemode_config.Services do
    local service_config = gamemode_config.Services[i]
    local newService = self:_CreateService(service_config)
    if newService then
      self.BW_Services:AddService(service_config.Name, newService)
      if self._sepSvc then
        local svcRespType = ServiceFilter:GetServiceResponsibilityType(service_config.Type)
        if svcRespType == ResponsibilityType.Render then
          self._renderSvcProvider:AddService(service_config.Name, newService)
        elseif svcRespType == ResponsibilityType.Share then
          self._shareSvcProvider:AddService(service_config.Name, newService)
        else
          self._logicSvcProvider:AddService(service_config.Name, newService)
        end
      end
    end
  end
  if EDITOR and gamemode_config.EditorServices then
    for i = 1, #gamemode_config.EditorServices do
      local service_config = gamemode_config.EditorServices[i]
      local newService = self:_CreateService(service_config)
      if newService then
        self.BW_Services:AddService(service_config.Name, newService)
      end
    end
  end
  self.BW_Services:InitServices()
  self._shareSvcProvider:InitServices()
  self._logicSvcProvider:InitServices()
  self._renderSvcProvider:InitServices()
end

function MainWorld:GetEntityByID(entityID)
  return self._entities:Find(entityID)
end

function MainWorld:WorldHandleCommands(command_list)
  for i = 1, command_list:Size() do
    local cmd = command_list:GetAt(i)
    local e = self:GetEntityByID(cmd.EntityID)
    if e then
      e:ReceiveCommand(cmd)
    end
  end
end

function MainWorld:GetService(service_name)
  if EDITOR and CHECK_RENDER_ACCESS_LOGIC then
    local available = self:_CheckServiceAvailable(service_name)
    if available == false then
      return
    end
  end
  if self.BW_Services then
    return self.BW_Services:GetService(service_name)
  end
end

function MainWorld:GetLogicService(service_name)
  return self._logicSvcProvider:GetService(service_name)
end

function MainWorld:GetRenderService(service_name)
  return self._renderSvcProvider:GetService(service_name)
end

function MainWorld:GetShareService(service_name)
  return self._shareSvcProvider:GetService(service_name)
end

function MainWorld:SetBoardEntity(boardEntity)
  self._boardEntity = boardEntity
end

function MainWorld:GetBoardEntity()
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

function MainWorld:SetRenderBoardEntity(e)
  self._renderBoardEntity = e
end

function MainWorld:GetRenderBoardEntity()
  return self._renderBoardEntity
end

function MainWorld:SetPreviewEntity(entity)
  self._previewEntity = entity
end

function MainWorld:GetPreviewEntity()
  return self._previewEntity
end

function MainWorld:GetRunningPosition()
  return self._runningPosition
end

function MainWorld:RunAtServer()
  return self._runningPosition == WorldRunPostion.AtServer
end

function MainWorld:RunAtClient()
  return self._runningPosition == WorldRunPostion.AtClient
end

function MainWorld:EventDispatcher()
  Log.fatal("mainWorld has no event dispatcher")
  return nil
end

function MainWorld:IDGenerator()
  Log.fatal("mainWorld has no event dispatcher")
  return nil
end

function MainWorld:SubMatchType()
  return self._subMatchType
end

function MainWorld:LinkLineType()
  return self._linkLineType
end

function MainWorld:ChangeLinkLineType(linkLineType)
  self._linkLineType = linkLineType
end

function MainWorld:GetWorldTimer()
  return self._h3dTimer
end

function MainWorld:GetSyncMode()
  return self._syncMode
end

function MainWorld:GetMatchLogger()
  return self._matchLogger
end

function MainWorld:GetDetailMatchLogger()
  return self._detailMatchLogger
end

function MainWorld:GetSyncLogger()
  return self._syncLogger
end

function MainWorld:GetDataLogger()
  return self._dataLogger
end

function MainWorld:GetSkillScopeTargetSelector()
  return self._skillScopeTargetSelector
end

function MainWorld:GetPlayerCommandHandler()
  return self._playerCommandHandler
end

function MainWorld:GetAllPlayerEntity(teamEntity)
  local retEntityList = {}
  for i, v in ipairs(teamEntity:Team():GetTeamPetEntities()) do
    retEntityList[i] = v
  end
  table.insert(retEntityList, teamEntity)
  return retEntityList
end

function MainWorld:IsHaveHelpPet()
  return self.m_nHelpPetKey and self.m_nHelpPetKey > 0
end

function MainWorld:_CheckServiceAvailable(svcName)
  local debugInfo = debug.getinfo(3, "S")
  local filePath = debugInfo.short_src
  local respType = ServiceFilter:GetServiceResponsibilityType(svcName)
  if respType == ResponsibilityType.Logic then
    local renderIndex = string.find(filePath, "_r.lua")
    if renderIndex ~= nil then
      Log.exception("render file :", filePath, " call logic svc:", svcName, " ", Log.traceback())
      return false
    end
  end
  return true
end

function MainWorld:DestroyRenderEntity(renderEntity)
  self:DestroyEntity(renderEntity)
end

function MainWorld:IsDevelopEnv()
  return false
end

function MainWorld:GetHardID()
  return self._hardID
end

function MainWorld:GetGameTurn()
  return self._currentTurn
end

function MainWorld:ChangeGameTurn()
  if self:MatchType() == MatchType.MT_BlackFist then
    if self._currentTurn == GameTurnType.LocalPlayerTurn then
      self._currentTurn = GameTurnType.RemotePlayerTurn
    else
      self._currentTurn = GameTurnType.LocalPlayerTurn
    end
  end
end

function MainWorld:ReplaceSkillScopeType(scopeType)
  if self:MatchType() == MatchType.MT_BlackFist then
    local replace = PvPSkillScopeTable[scopeType]
    if replace then
      return replace
    end
  end
  return scopeType
end

function MainWorld:ReplaceSkillTarget(targetType)
  if self:MatchType() == MatchType.MT_BlackFist then
    local replace = PvPSkillTargetTable[targetType]
    if replace then
      return replace
    end
  end
  return targetType
end

function MainWorld:ReplaceBuffTarget(targetType)
  if self:MatchType() == MatchType.MT_BlackFist then
    local replace = PvPBuffTargetTable[targetType]
    if replace then
      return replace
    end
  end
  return targetType
end

function MainWorld:ReplaceAILogicPeriodType(aiPeriodType)
  if self:MatchType() == MatchType.MT_BlackFist then
    return AILogicPeriodType.RoundResult
  end
  return aiPeriodType
end

function MainWorld:ReplaceTrapRaceType(raceType)
  if self:MatchType() == MatchType.MT_BlackFist then
    local replace = PvpTrapRaceType[raceType]
    if replace then
      return replace
    end
  end
  return raceType
end

function MainWorld:ReplaceNotifyType(notifyType)
  if self:MatchType() == MatchType.MT_BlackFist then
    local replace = PvPNotifyTypeTable[notifyType]
    if replace then
      return replace
    end
  end
  return notifyType
end

function MainWorld:ReplaceSkillFormula(formulaID)
  return formulaID
end

function MainWorld:HandleGM(funcName, funcParam)
  if self._gmCheater then
    self._gmCheater[funcName](self._gmCheater, table.unpack(funcParam))
  end
end

function MainWorld:GetGMCheat()
  return self._gmCheater
end

function MainWorld:GetLocalHelpPetPstID()
  return self._localHelpPetPstID
end

function MainWorld:GetEnlightenInfoByType(type)
  return self._enlightenInfoDic[type]
end
