_class("SeasonMapDaily", Object)
SeasonMapDaily = SeasonMapDaily

function SeasonMapDaily:Constructor(manager, compoentID, loader)
  self._seasonMapManager = manager
  local cfgs = Cfg.cfg_component_season_daily({ComponentID = compoentID})
  if cfgs then
    self._dailyComponentCfg = cfgs[1]
  else
    Log.warn("SeasonMapDaily cfg_component_season_daily error.")
  end
  self._state = SeasonDailyState.Lock
  self._isUnlock = true
  self._loader = loader
  self._eventPoints = {}
  self._resetPhase = SeasonResetPhase.None
  self._checkTime = 0
  self._serverInfoEmpty = false
  self._autoBinder = AutoEventBinder:New(GameGlobal.EventDispatcher())
  self._autoBinder:BindEvent(GameEventType.OnSeasonDailyReset, self, self._OnSeasonDailyReset)
end

function SeasonMapDaily:Update(deltaTime)
  for id, eventPoint in pairs(self._eventPoints) do
    eventPoint:Update(deltaTime)
  end
  self:_CheckReset(deltaTime)
end

function SeasonMapDaily:Dispose()
  for _, eventPoint in pairs(self._eventPoints) do
    eventPoint:Dispose()
  end
  table.clear(self._eventPoints)
  self._resetPhase = SeasonResetPhase.None
  self._autoBinder:UnBindAllEvents()
end

function SeasonMapDaily:AddEventPoint(cfgMission)
  if not cfgMission then
    return
  end
  local missionID = cfgMission.ID
  if self._eventPoints[missionID] then
    return
  end
  local cfgEventPoint = Cfg.cfg_season_map_eventpoint[missionID]
  if cfgEventPoint then
    local eventPoint = SeasonMapEventPointDaily:New(self, cfgMission, cfgEventPoint)
    if eventPoint:GetResName() then
      self._loader:LoadResource(eventPoint)
    else
      eventPoint:CreateVirtualPoint()
    end
    self._eventPoints[missionID] = eventPoint
  end
end

function SeasonMapDaily:GetEventPoint(id)
  return self._eventPoints[id]
end

function SeasonMapDaily:GetEventPoints()
  return self._eventPoints
end

function SeasonMapDaily:ComponentCfg()
  return self._dailyComponentCfg
end

function SeasonMapDaily:SetState(state)
  self._state = state
  self:SetUnlock(self._state == SeasonDailyState.Unlock)
end

function SeasonMapDaily:GetState()
  return self._state
end

function SeasonMapDaily:IsUnlock()
  return self._isUnlock
end

function SeasonMapDaily:SetUnlock(unlock)
  self._isUnlock = unlock
end

function SeasonMapDaily:GetServerInfoEmpty()
  return self._serverInfoEmpty
end

function SeasonMapDaily:CheckEventPointCondition(map)
  if self._isUnlock then
    for id, eventPoint in pairs(self._eventPoints) do
      local result, progress = eventPoint:CheckCondition(map)
      if result then
        eventPoint:PlayExpress(progress, SeasonExpressTriggerType.Passive)
      end
    end
  end
end

function SeasonMapDaily:GetEventPointsByType(eventPointType, force)
  local result
  for _, eventPoint in pairs(self._eventPoints) do
    if eventPoint:EventPointType() == eventPointType and (eventPoint:DiffAble() and eventPoint:ModeAble() or force) then
      result = result or {}
      table.insert(result, eventPoint)
    end
  end
  return result
end

function SeasonMapDaily:EventPointPlaying()
  for _, eventPoint in pairs(self._eventPoints) do
    local isPlaying, id = eventPoint:IsPlaying()
    if isPlaying then
      return isPlaying, id
    end
  end
  return false, nil
end

function SeasonMapDaily:GetAllPRIDs()
  local ids = {}
  for _, eventPoint in pairs(self._eventPoints) do
    table.insert(ids, eventPoint:PRID())
  end
  return ids
end

function SeasonMapDaily:TrySyncPRIDs(SuccCallBack)
  local seasonModule = GameGlobal.GetModule(SeasonModule)
  local componentInfo = seasonModule:GetCurSeasonObj():GetComponentInfo(ECCampaignSeasonComponentID.SEASON_MISSION)
  local serverInfo = componentInfo.m_daily_info.m_save_info
  local change = false
  local ids = {}
  if table.count(serverInfo) <= 0 then
    self._serverInfoEmpty = true
  end
  for _, eventPoint in pairs(self._eventPoints) do
    change = change or serverInfo[eventPoint:GetID()] ~= eventPoint:PRID()
    ids[eventPoint:GetID()] = eventPoint:PRID()
  end
  if change then
    Log.info("SeasonMapDaily TrySyncRPIDs.")
    GameGlobal.UIStateManager():Lock("SeasonMapDailyTrySyncRPIDs")
    TaskManager:GetInstance():StartTask(function(TT)
      local res = GameGlobal.GetModule(SeasonModule):HandleSeasonPointClientData(TT, ids)
      if res:GetSucc() and SuccCallBack then
        SuccCallBack()
      end
      GameGlobal.UIStateManager():UnLock("SeasonMapDailyTrySyncRPIDs")
    end, self)
  else
    Log.info("SeasonMapDaily no change.")
  end
end

function SeasonMapDaily:MoveToEventPoint()
  if self._state == SeasonDailyState.Unlock then
    local uiSeasonModule = GameGlobal.GetUIModule(SeasonModule)
    local player = uiSeasonModule:SeasonManager():SeasonPlayerManager():GetPlayer()
    local position = player:RealPosition()
    local minDistance = 0
    local targetEventPoint
    for _, eventPoint in pairs(self._eventPoints) do
      local distance = Vector3.Distance(position, eventPoint:Position())
      if not targetEventPoint then
        minDistance = distance
        targetEventPoint = eventPoint
      elseif distance < minDistance then
        minDistance = distance
        targetEventPoint = eventPoint
      end
    end
    if targetEventPoint then
      uiSeasonModule:SeasonManager():AutoMoveToEventPoint(targetEventPoint:GetID())
    end
  end
end

function SeasonMapDaily:_OnSeasonDailyReset()
  self._checkTime = 0
  if self._seasonMapManager:EventPointPlaying() then
    self._resetPhase = SeasonResetPhase.Waiting
  else
    self:Reset()
  end
end

function SeasonMapDaily:Reset()
  self._resetPhase = SeasonResetPhase.Reseting
  for _, eventPoint in pairs(self._eventPoints) do
    local cfg = eventPoint:GetEventPointCfg()
    eventPoint:RandomPR(cfg.PRP)
  end
  self:TrySyncPRIDs(function()
    for _, eventPoint in pairs(self._eventPoints) do
      eventPoint:ResetPR()
    end
    self._resetPhase = SeasonResetPhase.Success
    self._seasonMapManager:CalcDailyState()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSeasonDailyResetSucc)
    ToastManager.ShowToast(StringTable.Get(self._dailyComponentCfg.RefreshText))
    Log.info("SeasonMapDaily Reset success.")
  end)
end

function SeasonMapDaily:_CheckReset(deltaTime)
  if self._resetPhase == SeasonResetPhase.Waiting then
    self._checkTime = self._checkTime + deltaTime
    if self._checkTime >= 5000 then
      self._checkTime = 0
      if not self._seasonMapManager:EventPointPlaying() then
        self:Reset()
      end
    end
  end
end

function SeasonMapDaily:SwitchMapMode(mapMode)
  for _, eventPoint in pairs(self._eventPoints) do
    if eventPoint:IsUnlock() then
      eventPoint:SwitchMapMode(mapMode)
    end
  end
end

function SeasonMapDaily:TryResumeExpress()
  for _, eventPoint in pairs(self._eventPoints) do
    if eventPoint:IsUnlock() then
      eventPoint:TryResumeExpress()
    end
  end
end
