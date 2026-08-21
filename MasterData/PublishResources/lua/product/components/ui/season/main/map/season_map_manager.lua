_class("SeasonMapManager", Object)
SeasonMapManager = SeasonMapManager

function SeasonMapManager:Constructor()
  self._mapMinPoint = Vector2(-31.5, -4.5)
  self._mapMaxPoint = Vector2(4.5, 22.5)
  self._mapSize = self._mapMaxPoint - self._mapMinPoint
end

function SeasonMapManager:TransMapObjPos2D(posVec2)
  posVec2.x = (posVec2.x - self._mapMinPoint.x) / self._mapSize.x
  posVec2.y = (posVec2.y - self._mapMinPoint.y) / self._mapSize.y
  posVec2.x = 1 - Mathf.Clamp(posVec2.x, 0, 1)
  posVec2.y = 1 - Mathf.Clamp(posVec2.y, 0, 1)
  return posVec2
end

function SeasonMapManager:OnInit(seasonID, params)
  self._seasonID = seasonID
  self._params = params
  self._mapEventPointLoader = SeasonMapEventPointLoader:New(SeasonEventPointLoadType.Sync)
  self._zones = {}
  self._daily = {}
  self._task = {}
  self._unlockZoneIDs = {
    1,
    2,
    3,
    4
  }
  self._mapIDs = {1, 2}
  self._mapMode = SeasonMapMode.None
  self._loginModule = GameGlobal.GetModule(LoginModule)
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self._seasonModule = GameGlobal.GetModule(SeasonModule)
  self._uiSeasonModule = GameGlobal.GetUIModule(SeasonModule)
  self._seasonTaskModule = GameGlobal.GetModule(SeasonTaskModule)
  self._sceneManager = self._uiSeasonModule:SeasonManager():SeasonSceneManager()
  self._cameraManager = self._uiSeasonModule:SeasonManager():SeasonCameraManager()
  self._navManager = self._uiSeasonModule:SeasonManager():NavManager()
  local obj = self._seasonModule:GetCurSeasonObj()
  self._component = obj:GetComponent(ECCampaignSeasonComponentID.SEASON_MISSION)
  self._componentInfo = self._component:GetComponentInfo()
  self._componentID = self._component:GetComponentCfgId()
  self._isBackTrack = self._uiSeasonModule:IsBackTrack()
  self._navManager:Clear()
  self:_CalcDefaultMode()
  self:_CreateZones(self:_CalcUnLockZonesAndMapIDs())
  self:_CreateDaily()
  self:_CreateTask()
  self:_CalcNavArea()
  self._seasonMapEffect = SeasonMapEffect:New()
  self._seasonMapEffect:OnInit(self._seasonID, self._isBackTrack, self._componentID, self._componentInfo)
end

function SeasonMapManager:OnAfterInit()
  for id, zone in ipairs(self._zones) do
    zone:OnAfterInit()
  end
  self._seasonMapEffect:OnRefreshMapEffect()
end

function SeasonMapManager:Update(deltaTime)
  self._mapEventPointLoader:Update()
  for id, zone in ipairs(self._zones) do
    zone:Update(deltaTime)
  end
  self._daily:Update(deltaTime)
  self._task:Update(deltaTime)
end

function SeasonMapManager:Dispose()
  for zoneID, zone in pairs(self._zones) do
    zone:Dispose()
  end
  self._daily:Dispose()
  self._task:Dispose()
  table.clear(self._zones)
  table.clear(self._unlockZoneIDs)
  self._mapEventPointLoader:Dispose()
  self._mapEventPointLoader = nil
  if self._syncTask then
    GameGlobal.TaskManager():KillTask(self._syncTask)
    self._syncTask = nil
  end
  self._seasonMapEffect:Dispose()
end

function SeasonMapManager:Mode()
  return self._mapMode
end

function SeasonMapManager:GetParams()
  return self._params
end

function SeasonMapManager:Daily()
  return self._daily
end

function SeasonMapManager:Task()
  return self._task
end

function SeasonMapManager:UnlockZoneIDs()
  return self._unlockZoneIDs
end

function SeasonMapManager:GetStageInfo()
  return self._componentInfo.m_stage_info
end

function SeasonMapManager:_CalcUnLockZonesAndMapIDs()
  if self._isBackTrack then
    local backTrackID = self._uiSeasonModule:BackTrackID()
    local cfg = Cfg.cfg_season_map[backTrackID]
    if cfg then
      for _, zoneID in pairs(cfg.Zones) do
        table.insert(self._unlockZoneIDs, zoneID)
      end
      for _, mapID in pairs(cfg.OpenMapIDs) do
        table.insert(self._mapIDs, mapID)
      end
      return cfg.CloseMapID
    end
  else
    local closeID
    local map = self._componentInfo.m_stage_info
    if map then
      for eventPointID, curProgress in pairs(map) do
        Log.info("SeasonMapManager eventPointID, progress", eventPointID, curProgress)
        local cfgMission = Cfg.cfg_season_mission[eventPointID]
        if cfgMission then
          if cfgMission.ZoneUnLock then
            local count = #cfgMission.ZoneUnLock
            local zoneID = cfgMission.ZoneUnLock[count]
            for i = 1, count - 1 do
              local progress = cfgMission.ZoneUnLock[i]
              if curProgress == progress and not table.icontains(self._unlockZoneIDs, zoneID) then
                table.insert(self._unlockZoneIDs, zoneID)
              end
            end
          end
          if cfgMission.MapID then
            local openingID = cfgMission.MapID[1]
            closeID = cfgMission.MapID[2]
            table.insert(self._mapIDs, openingID)
          end
        end
      end
    end
    return closeID
  end
end

function SeasonMapManager:_CreateZones(closeID)
  if self._isBackTrack then
    local backTrackID = self._uiSeasonModule:BackTrackID()
    local cfgs = Cfg.cfg_season_mission({BackTrackID = backTrackID})
    if cfgs then
      for _, cfg in pairs(cfgs) do
        if cfg and cfg.ZoneID and self:IsNormal(cfg) then
          if not self._zones[cfg.ZoneID] then
            self._zones[cfg.ZoneID] = SeasonMapZone:New(cfg.ZoneID, self:IsUnLock(cfg.ZoneID), self._mapEventPointLoader)
          end
          self._zones[cfg.ZoneID]:AddEventPoint(cfg)
        end
      end
    end
  else
    local cfgs = Cfg.cfg_component_season({
      ComponentID = self._componentID
    })
    if cfgs then
      for _, cfg in pairs(cfgs) do
        local cfgMission = Cfg.cfg_season_mission[cfg.MissionID]
        if cfgMission and cfgMission.ZoneID then
          if not self._zones[cfgMission.ZoneID] then
            self._zones[cfgMission.ZoneID] = SeasonMapZone:New(cfgMission.ZoneID, self:IsUnLock(cfgMission.ZoneID), self._mapEventPointLoader)
          end
          self._zones[cfgMission.ZoneID]:AddEventPoint(cfgMission)
        end
      end
    end
  end
  self:_UnLockZone(self._unlockZoneIDs, true)
  self:_ChangeMap(nil, closeID)
end

function SeasonMapManager:IsNormal(cfg)
  return cfg.Type ~= SeasonEventPointType.DailyLevel and cfg.Type ~= SeasonEventPointType.Task
end

function SeasonMapManager:IsUnLock(zoneID)
  return table.icontains(self._unlockZoneIDs, zoneID)
end

function SeasonMapManager:_UnLockZone(zoneIDs, changeScene)
  local zoneMask = 0
  for _, zoneID in pairs(zoneIDs) do
    if self._zones[zoneID] then
      self._zones[zoneID]:SetUnlock(true)
    end
    zoneMask = zoneMask | 1 << zoneID - 1
  end
  if changeScene then
    self._sceneManager:UnLockZone(zoneMask, nil)
    self._cameraManager:UnLock(zoneMask, nil)
  end
  self:_CalcNavArea()
  Log.info("SeasonMapManager InitUnlockZone zoneMask.", zoneMask)
end

function SeasonMapManager:_ChangeMap(openingID, closeID)
  self._sceneManager:ChangeMap(self._mapIDs, openingID, closeID)
  Log.info("SeasonMapManager ChangeMap ids ", self._mapIDs)
end

function SeasonMapManager:ContainGroup(groupID)
  for zoneID, zone in pairs(self._zones) do
    local allEventPoints = zone:GetEventPoints()
    for key, eventPoint in pairs(allEventPoints) do
      if eventPoint:GroupID() == groupID then
        return true
      end
    end
  end
  return false
end

function SeasonMapManager:OnEventPointProgressChange(eventPointID, progress)
  local map = self._seasonTaskModule:GetConditionMap(self._componentInfo.m_stage_info)
  local cfgMission = Cfg.cfg_season_mission[eventPointID]
  if cfgMission.ZoneUnLock then
    local count = #cfgMission.ZoneUnLock
    local zoneID = cfgMission.ZoneUnLock[count]
    for i = 1, count - 1 do
      local progress = cfgMission.ZoneUnLock[i]
      if map[cfgMission.ID] and map[cfgMission.ID] == progress and not table.icontains(self._unlockZoneIDs, zoneID) then
        table.insert(self._unlockZoneIDs, zoneID)
        self:_UnLockZone(self._unlockZoneIDs, false)
        Log.info("SeasonMapManager OnEventPointProgressChange zone unlock, ", zoneID)
      end
    end
  end
  if cfgMission.MapID then
    local openingID = cfgMission.MapID[1]
    local closeID = cfgMission.MapID[2]
    table.insert(self._mapIDs, openingID)
    self:_ChangeMap(openingID, closeID)
    Log.info("SeasonMapManager OnEventPointProgressChange add map, ", openingID)
  end
  self:CalcDailyState()
  for zoneID, zone in pairs(self._zones) do
    zone:CheckEventPointCondition(map)
  end
  self._daily:CheckEventPointCondition(map)
  self._task:CheckEventPointCondition(map)
  self._uiSeasonModule:SeasonManager():SeasonUIManager():Refresh()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnEventPointProgressChange, eventPointID, progress)
  self._seasonMapEffect:OnRefreshMapEffect()
end

function SeasonMapManager:GetEventPoint(id)
  for zoneID, zone in pairs(self._zones) do
    local eventPoint = zone:GetEventPoint(id)
    if eventPoint then
      return eventPoint, zoneID
    end
  end
  local eventPoint = self._daily:GetEventPoint(id)
  if eventPoint then
    return eventPoint, nil
  end
  eventPoint = self._task:GetEventPoint(id)
  if eventPoint then
    return eventPoint, nil
  end
  return nil, nil
end

function SeasonMapManager:GetEventPointsByType(eventPointType, force)
  local allEventPoints = {}
  if eventPointType == SeasonEventPointType.DailyLevel then
    if self._daily:IsUnlock() or force then
      local eventPoints_daily = self._daily:GetEventPointsByType(eventPointType, force)
      if eventPoints_daily then
        for i = 1, #eventPoints_daily do
          table.insert(allEventPoints, eventPoints_daily[i])
        end
      end
    end
  elseif eventPointType == SeasonEventPointType.Task then
    if self._task:IsUnlock() or force then
      local eventPoints_task = self._task:GetEventPointsByType(eventPointType, force)
      if eventPoints_task then
        for i = 1, #eventPoints_task do
          table.insert(allEventPoints, eventPoints_task[i])
        end
      end
    end
  else
    for zoneID, zone in pairs(self._zones) do
      if zone:IsUnlock() or force then
        local eventPoints_zone = zone:GetEventPointsByType(eventPointType, force)
        if eventPoints_zone then
          for i = 1, #eventPoints_zone do
            table.insert(allEventPoints, eventPoints_zone[i])
          end
        end
      end
    end
  end
  return allEventPoints
end

function SeasonMapManager:SwitchDiff(diff)
  for _, zone in pairs(self._zones) do
    if zone:IsUnlock() then
      zone:SwitchDiff(diff)
    end
  end
end

function SeasonMapManager:EventPointPlaying()
  for zoneID, zone in pairs(self._zones) do
    local isPlaying, id = zone:EventPointPlaying()
    if isPlaying then
      Log.debug("SeasonMapManager Zone EventPointPlaying.", id)
      return true
    end
  end
  local isPlaying, id = self._daily:EventPointPlaying()
  if isPlaying then
    Log.debug("SeasonMapManager Daily EventPointPlaying.", id)
    return true
  end
  isPlaying, id = self._task:EventPointPlaying()
  if isPlaying then
    Log.debug("SeasonMapManager Task EventPointPlaying.", id)
    return true
  end
  return false
end

function SeasonMapManager:_CreateDaily()
  self._daily = SeasonMapDaily:New(self, self._componentID, self._mapEventPointLoader)
  if not self._isBackTrack then
    self:CalcDailyState()
    local cfgs = Cfg.cfg_component_season({
      ComponentID = self._componentID
    })
    if cfgs then
      for _, cfg in pairs(cfgs) do
        local cfgMission = Cfg.cfg_season_mission[cfg.MissionID]
        if cfgMission and cfgMission.Type == SeasonEventPointType.DailyLevel then
          self._daily:AddEventPoint(cfgMission)
        end
      end
    end
    self._daily:TrySyncPRIDs(nil)
  end
end

function SeasonMapManager:CalcDailyState()
  local cfg = self._daily:ComponentCfg()
  if cfg then
    local curTime = self._svrTimeModule:GetServerTime() * 0.001
    local unlockTime = self._loginModule:GetTimeStampByTimeStr(cfg.UnlockTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
    local closeTime = self._loginModule:GetTimeStampByTimeStr(cfg.CloseTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
    if curTime < unlockTime or curTime >= closeTime then
      self._daily:SetState(SeasonDailyState.Time)
      return
    end
    local passInfo = self._componentInfo.m_pass_mission_info[cfg.NeedMission]
    if not passInfo then
      self._daily:SetState(SeasonDailyState.Mission)
      return
    end
    local progress = self._componentInfo.m_daily_info.m_progress
    if progress > cfg.MaxReward then
      self._daily:SetState(SeasonDailyState.MaxReward)
      return
    end
    self._daily:SetState(SeasonDailyState.Unlock)
  else
    self._daily:SetState(SeasonDailyState.Lock)
  end
end

function SeasonMapManager:SwitchMapMode(mapMode, callBack)
  local cfg = Cfg.cfg_season_map[self._seasonID]
  if cfg then
    local conditionStr
    if cfg.ModeUnlock then
      conditionStr = cfg.ModeUnlock[mapMode]
    end
    if not string.isnullorempty(conditionStr) and not self._seasonModule:CheckCondition(conditionStr, self._componentInfo.m_stage_info) then
      mapMode = self._mapMode
    end
    if self._mapMode ~= mapMode then
      self._mapMode = mapMode
      self:_SyncMode(function()
        self:_OnSwitchMode()
        if callBack then
          callBack()
        end
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSeasonModeChanged, self._mapMode)
        self._uiSeasonModule:SeasonManager():SeasonUIManager():Refresh()
      end)
    end
  end
end

function SeasonMapManager:_OnSwitchMode()
  self._uiSeasonModule:SeasonManager():SeasonPlayerManager():GetPlayer():SwitchModel(self._mapMode)
  for _, zone in pairs(self._zones) do
    if zone:IsUnlock() then
      zone:SwitchMapMode(self._mapMode)
    end
  end
  self._daily:SwitchMapMode(self._mapMode)
  self._task:SwitchMapMode(self._mapMode)
end

function SeasonMapManager:_CalcDefaultMode()
  local key = tonumber(self._seasonModule:GetCurSeasonID() .. SeasonKey.Mode)
  local recordMode = self._componentInfo.m_client_info.ext[key]
  if recordMode then
    self._mapMode = recordMode
  else
    local cfg = Cfg.cfg_season_map[self._seasonID]
    if cfg then
      self._mapMode = cfg.Mode
      self:_SyncMode(nil)
    end
  end
end

function SeasonMapManager:_SyncMode(callBack)
  local key = tonumber(self._seasonModule:GetCurSeasonID() .. SeasonKey.Mode)
  local info = {}
  info[key] = self._mapMode
  self._uiSeasonModule:SeasonManager():Lock("SyncMode")
  self._syncTask = GameGlobal.TaskManager():StartTask(function(TT)
    local req = self._seasonModule:HandleSeasonClientDataExt(TT, info)
    if req:GetSucc() then
      if callBack then
        callBack()
      end
      Log.info("SeasonMapManager sync mode success.", self._mapMode)
    end
    self._uiSeasonModule:SeasonManager():UnLock("SyncMode")
  end, self)
end

function SeasonMapManager:_CreateTask()
  self._task = SeasonMapTask:New(self, self._seasonTaskModule, self._mapEventPointLoader)
  self:CreateSubTaskEventPoints()
end

function SeasonMapManager:_CalcNavArea()
  local mask = SeasonNavArea.Walkable
  for k, zoneId in pairs(self._unlockZoneIDs) do
    if zoneId == 1 then
      mask = mask | SeasonNavArea.SeasonZone1
    elseif zoneId == 2 then
      mask = mask | SeasonNavArea.SeasonZone2
    elseif zoneId == 3 then
      mask = mask | SeasonNavArea.SeasonZone3
    elseif zoneId == 4 then
      mask = mask | SeasonNavArea.SeasonZone4
    elseif zoneId == 5 then
      mask = mask | SeasonNavArea.SeasonZone5
    elseif zoneId == 6 then
      mask = mask | SeasonNavArea.SeasonZone6
    end
  end
  self._navManager:SetAreaMask(mask)
end

function SeasonMapManager:CreateSubTaskEventPoints()
  local subTaskID = self._seasonTaskModule:GetCurQuestId(self._seasonTaskModule:GetCurNode())
  if 0 < subTaskID then
    local cfgMissions = Cfg.cfg_season_mission({QuestID = subTaskID})
    if cfgMissions then
      for _, cfgMission in pairs(cfgMissions) do
        if cfgMission.Type == SeasonEventPointType.Task then
          self._task:AddEventPoint(cfgMission)
        end
      end
    end
  end
end

function SeasonMapManager:TryResumeExpress()
  for zoneID, zone in pairs(self._zones) do
    zone:TryResumeExpress()
  end
  self._daily:TryResumeExpress()
  self._task:TryResumeExpress()
end

function SeasonMapManager:BrowseTask()
  self._task:BrowseTask()
end
