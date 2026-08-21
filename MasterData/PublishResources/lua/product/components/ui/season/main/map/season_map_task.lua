_class("SeasonMapTask", Object)
SeasonMapTask = SeasonMapTask

function SeasonMapTask:Constructor(manager, module, loader)
  self._seasonMapManager = manager
  self._seasonTaskModule = module
  self._questModule = GameGlobal.GetModule(QuestModule)
  self._uiSeasonModule = GameGlobal.GetUIModule(SeasonModule)
  self._seasonCameraManager = self._uiSeasonModule:SeasonManager():SeasonCameraManager()
  self._seasonCamera = self._seasonCameraManager:SeasonCamera()
  self._isUnlock = true
  self._loader = loader
  self._eventPoints = {}
  self._focusEventPoints = {}
  self._focus = false
  self._resetPhase = SeasonResetPhase.None
  self._checkTime = 0
  self._autoBinder = AutoEventBinder:New(GameGlobal.EventDispatcher())
  self._autoBinder:BindEvent(GameEventType.OnSeasonTaskReset, self, self._OnSeasonTaskReset)
  self._autoBinder:BindEvent(GameEventType.OnSeasonSubTaskRefresh, self, self._OnSeasonSubTaskRefresh)
end

function SeasonMapTask:Update(deltaTime)
  for id, eventPoint in pairs(self._eventPoints) do
    eventPoint:Update(deltaTime)
  end
  if self._focus and self:_CheckCurFoucsDone() then
    table.remove(self._focusEventPoints, 1)
    self:_FocusNext()
  end
  self:_CheckReset(deltaTime)
end

function SeasonMapTask:Dispose()
  for _, eventPoint in pairs(self._eventPoints) do
    eventPoint:Dispose()
  end
  self._focus = false
  table.clear(self._eventPoints)
  table.clear(self._focusEventPoints)
  self._resetPhase = SeasonResetPhase.None
  self._autoBinder:UnBindAllEvents()
end

function SeasonMapTask:AddEventPoint(cfgMission)
  if not cfgMission then
    return
  end
  local missionID = cfgMission.ID
  if self._eventPoints[missionID] then
    return
  end
  local cfgEventPoint = Cfg.cfg_season_map_eventpoint[missionID]
  if cfgEventPoint then
    local eventPoint = SeasonMapEventPointTask:New(self, cfgMission, cfgEventPoint)
    if eventPoint:GetResName() then
      self._loader:LoadResource(eventPoint)
    else
      eventPoint:CreateVirtualPoint()
    end
    self._eventPoints[missionID] = eventPoint
  end
end

function SeasonMapTask:GetEventPoint(id)
  return self._eventPoints[id]
end

function SeasonMapTask:GetEventPoints()
  return self._eventPoints
end

function SeasonMapTask:IsUnlock()
  return self._isUnlock
end

function SeasonMapTask:SetUnlock(unlock)
  self._isUnlock = unlock
end

function SeasonMapTask:CheckEventPointCondition(map)
  if self._isUnlock then
    map = self._seasonTaskModule:GetConditionMap(self._seasonMapManager:GetStageInfo())
    for id, eventPoint in pairs(self._eventPoints) do
      local result, progress = eventPoint:CheckCondition(map)
      if result then
        eventPoint:PlayExpress(progress, SeasonExpressTriggerType.Passive)
      end
    end
  end
end

function SeasonMapTask:GetEventPointsByType(eventPointType, force)
  local result
  for _, eventPoint in pairs(self._eventPoints) do
    if eventPoint:EventPointType() == eventPointType and (eventPoint:DiffAble() and eventPoint:ModeAble() or force) then
      result = result or {}
      table.insert(result, eventPoint)
    end
  end
  return result
end

function SeasonMapTask:EventPointPlaying()
  for _, eventPoint in pairs(self._eventPoints) do
    local isPlaying, id = eventPoint:IsPlaying()
    if isPlaying then
      return isPlaying, id
    end
  end
  return false, nil
end

function SeasonMapTask:SwitchMapMode(mapMode)
  for _, eventPoint in pairs(self._eventPoints) do
    if eventPoint:IsUnlock() then
      eventPoint:SwitchMapMode(mapMode)
    end
  end
end

function SeasonMapTask:TrySyncQuestNum(TT, questID)
  local res, rewards = self._questModule:HandleClientProcess(TT, questID, 1)
  if res:GetSucc() then
    local cfg = Cfg.cfg_quest[questID]
    if rewards and cfg.NoShowRewards ~= true then
      UISeasonHelper.ShowUIGetRewards(rewards)
    end
    Log.info("SeasonMapTask TrySyncQuestNum success.")
  end
end

function SeasonMapTask:_OnSeasonTaskReset()
  self:_Refresh()
  Log.info("SeasonMapTask OnSeasonTaskReset.")
end

function SeasonMapTask:_OnSeasonSubTaskRefresh()
  self:_Refresh()
  Log.info("SeasonMapTask OnSeasonSubTaskRefresh.")
end

function SeasonMapTask:_Refresh()
  self._checkTime = 0
  if self._seasonMapManager:EventPointPlaying() or self._focus then
    self._resetPhase = SeasonResetPhase.Waiting
  else
    self:_OnRefresh()
  end
end

function SeasonMapTask:_OnRefresh()
  self._focus = false
  table.clear(self._focusEventPoints)
  for id, eventPoint in pairs(self._eventPoints) do
    eventPoint:Dispose()
  end
  table.clear(self._eventPoints)
  self._seasonMapManager:CreateSubTaskEventPoints()
  self._resetPhase = SeasonResetPhase.Success
  self._uiSeasonModule:SeasonManager():SeasonUIManager():Refresh()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSeasonTaskRefreshed)
end

function SeasonMapTask:_CheckReset(deltaTime)
  if self._resetPhase == SeasonResetPhase.Waiting then
    self._checkTime = self._checkTime + deltaTime
    if self._checkTime >= 5000 then
      self._checkTime = 0
      if not self._seasonMapManager:EventPointPlaying() then
        self:_OnRefresh()
      end
    end
  end
end

function SeasonMapTask:FocusTasks()
  self._focus = false
  table.clear(self._focusEventPoints)
  for id, eventPoint in pairs(self._eventPoints) do
    if not eventPoint:IsFinish() then
      table.insert(self._focusEventPoints, eventPoint)
    end
  end
  table.sort(self._focusEventPoints, function(a, b)
    return a:GetID() > b:GetID()
  end)
  self:_FocusNext()
end

function SeasonMapTask:_FocusNext()
  if #self._focusEventPoints > 0 then
    local eventPoint = self._focusEventPoints[1]
    if eventPoint:GetEventPointCfg().TaskAutoNavi == 1 then
      self._uiSeasonModule:SeasonManager():AutoMoveToEventPoint(eventPoint:GetID())
    else
      self._seasonCamera:Focus(eventPoint:Position())
    end
    self._focus = true
  else
    self._focus = false
  end
end

function SeasonMapTask:_CheckCurFoucsDone()
  return self._seasonCamera:FocusDone()
end

function SeasonMapTask:TryResumeExpress()
  for _, eventPoint in pairs(self._eventPoints) do
    if eventPoint:IsUnlock() then
      eventPoint:TryResumeExpress()
    end
  end
end

function SeasonMapTask:BrowseTask()
  local backTrackID
  for _, eventPoint in pairs(self._eventPoints) do
    if eventPoint:GetMissionCfg().BackTrackID ~= self._uiSeasonModule:GetSeasonID() and self._uiSeasonModule:GetSeasonID() > 0 then
      backTrackID = eventPoint:GetMissionCfg().BackTrackID
      break
    end
  end
  if backTrackID then
    GameGlobal.UIStateManager():ShowDialog("UISeasonBackTrackPop", backTrackID)
  else
    self:FocusTasks()
  end
end
