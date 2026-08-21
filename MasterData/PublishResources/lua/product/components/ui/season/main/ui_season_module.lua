_class("UISeasonModule", UIModule)
UISeasonModule = UISeasonModule

function UISeasonModule:Constructor()
  self._seasonManager = SeasonManager:New()
  self._backTrackID = nil
  self._seaonMainMap = {
    [8003] = UIStateType.UIS3Main,
    [8004] = UIStateType.UIS4Main
  }
  self:AttachEvent(GameEventType.AfterSeasonSceneUIShow, self._AfterSceneUIShow)
end

function UISeasonModule:Dispose()
  self.super.Dispose(self)
  if self._running then
    self._seasonManager:Dispose()
    self._running = false
  end
  self._backTrackID = nil
  self._talentBattleOut = nil
end

function UISeasonModule:EnterSeasonGame(params)
  self:ClearWaitShowBubbleCallbacks()
  local curSeasonID = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  self._levelDiffKey = GameGlobal.GetModule(RoleModule):GetPstId() .. "_" .. curSeasonID .. "_" .. "LevelDiff"
  self._seasonManager:Init(curSeasonID, params)
  self._seasonManager:AfterInit()
  self._running = true
end

function UISeasonModule:ExitSeasonGame(isBackTrack)
  local isExit = true
  if isBackTrack ~= nil then
    isExit = false
  end
  self._seasonManager:Dispose(isExit)
  self._levelDiffKey = nil
  self._running = false
end

function UISeasonModule:ExitSeasonToSeasonMain(seasonId)
  local state = self._seaonMainMap[seasonId]
  if not state then
    Log.error("UISeasonModule can't find uiState by seasonId ", seasonId)
    return
  end
  self:ExitSeasonToSeasonMain(seasonId)
end

function UISeasonModule:ExitSeasonTo(exitParam)
  if not self._running then
    Log.error("赛季已经退出", debug.traceback())
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SeasonLeaveToMain)
  GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Season_Exit, "UI", exitParam)
end

function UISeasonModule:SeasonBackTrack(backTrackID, param)
  self._enterSeaonParam = param
  if 0 < backTrackID then
    if not self._backTrackID then
      self:_SnapNormalSeasonData()
    end
    self._backTrackID = backTrackID
    self:ExitSeasonGame(true)
    local cfg = Cfg.cfg_season_map[backTrackID]
    if cfg and cfg.MapRes then
      self:_InitBackTrackData()
      GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Season_Enter, cfg.MapRes)
    end
  end
end

function UISeasonModule:GetEnterSeasonParam()
  return self._enterSeaonParam
end

function UISeasonModule:_SnapNormalSeasonData()
  Log.info("正常赛季快照数据.....")
  self._snapNormSeasonData = {}
  local unlockZones = self._seasonManager:SeasonMapManager():UnlockZoneIDs()
  local snapZones = {}
  for _, zoneID in pairs(unlockZones) do
    table.insert(snapZones, zoneID)
  end
  self._snapNormSeasonData.UnlockZoneIds = snapZones
end

function UISeasonModule:GetSnapNormalSeasonData(key)
  return self._snapNormSeasonData[key]
end

function UISeasonModule:_InitBackTrackData()
  self._allTrackEventMissionCfgs = {}
  self._allTrackEventPointStatus = {}
  self._allTrackPermanentMissionCfgs = {}
  local cfgs = Cfg.cfg_season_mission({
    BackTrackID = self._backTrackID
  })
  if cfgs then
    for _, cfg in pairs(cfgs) do
      self._allTrackEventMissionCfgs[cfg.ID] = cfg
      self._allTrackEventPointStatus[cfg.ID] = cfg.BackTrackProgress or 1
      if cfg.BackTrackPermanent then
        self._allTrackPermanentMissionCfgs[cfg.ID] = cfg
      end
    end
  end
  self:UpdateBackTrackEventpointData()
end

function UISeasonModule:GetTrackPermanentMissonCfgs()
  return self._allTrackPermanentMissionCfgs
end

function UISeasonModule:GetTrackEventpointStatus()
  return self._allTrackEventPointStatus
end

function UISeasonModule:UpdateBackTrackEventpointData()
  local taskModule = GameGlobal.GameLogic():GetModule(SeasonTaskModule)
  local pInfo = taskModule.client_quest_progress_info.eventpoint_info
  for k, v in pairs(pInfo) do
    local id = v.event_id
    local status = v.status
    if self._allTrackEventPointStatus[id] then
      self._allTrackEventPointStatus[id] = status
    end
  end
end

function UISeasonModule:OnTrackEventpointDataChged(einfo)
  if not einfo or not self._allTrackEventPointStatus then
    return
  end
  self._allTrackEventPointStatus[einfo.event_id] = einfo.status
end

function UISeasonModule:BackToCurSeason(param)
  self:ClearBackTrack()
  self:ExitSeasonGame(true)
  self:EnterCurrentSeasonMainUI(param)
end

function UISeasonModule:Update(curTick)
  if self._running then
    self._seasonManager:Update(GameGlobal:GetInstance():GetDeltaTime())
  end
end

function UISeasonModule:SeasonManager()
  return self._seasonManager
end

function UISeasonModule:InSeasaonRunning()
  return self._running
end

function UISeasonModule:IsBackTrack()
  return self._backTrackID ~= nil
end

function UISeasonModule:BackTrackID()
  return self._backTrackID
end

function UISeasonModule:ClearBackTrack()
  self._backTrackID = nil
end

function UISeasonModule:GetSeasonID()
  if self._backTrackID then
    return self._backTrackID
  else
    return self:GetModule(SeasonModule):GetCurSeasonID()
  end
end

function UISeasonModule:GetLatestSeasonID()
  local id = -1
  for _, value in pairs(UISeasonID) do
    id = math.max(id, value)
  end
  return id
end

function UISeasonModule:EnterSeasonSystemUI()
  local seasonModule = self:GetModule(SeasonModule)
  if seasonModule:CheckExtMask(ESeasonExtInfo.SeasonFirstPlotReadState) then
    GameGlobal.UIStateManager():SwitchState(UIStateType.UISeasonExploreMainController)
  else
    TaskManager:GetInstance():StartTask(function(TT)
      local mask = seasonModule:AppendExtMaskData(ESeasonExtInfo.SeasonFirstPlotReadState)
      seasonModule:ReqCEventSeasonStory(TT, mask)
      local plotId = Cfg.cfg_global.season_system_first_plot.IntValue
      GameGlobal.UIStateManager():ShowDialog("UIStoryController", plotId, function()
        GameGlobal.UIStateManager():SwitchState(UIStateType.UISeasonExploreMainController)
      end)
    end)
  end
end

function UISeasonModule:OpenSeasonThemeUI(...)
  UISeasonHelper.ShowCurSeasonMainController(...)
end

function UISeasonModule:EnterCurrentSeasonMainUI(param)
  self._enterSeaonParam = param
  local seasonModule = self:GetModule(SeasonModule)
  local sample = seasonModule:GetCurSeasonSample()
  local svrTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
  if sample and sample:IsShow(svrTime) then
  else
    local tips = StringTable.Get("str_activity_error_109")
    ToastManager.ShowToast(tips)
    return
  end
  local cfg = Cfg.cfg_season_map[seasonModule:GetCurSeasonID()]
  if cfg and cfg.MapRes then
    GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Season_Enter, cfg.MapRes)
  end
end

function UISeasonModule:EnterExchangeShopSeasonTab()
  GameGlobal.UIStateManager():ShowDialog("UIShopController", 2, ShopMainTabType.Secret, MarketType.Shop_Season)
end

function UISeasonModule:GetCurrentSeasonLevelDiff()
  return LocalDB.GetInt(self._levelDiffKey, UISeasonLevelDiff.Hard)
end

function UISeasonModule:SetCurrentSeasonLevelDiff(diff)
  LocalDB.SetInt(self._levelDiffKey, diff)
  self._seasonManager:SwitchDiff(diff)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UISeasonOnLevelDiffChanged, diff)
end

function UISeasonModule:GetCollageData()
  if not self._seasonCollageData then
    self._seasonCollageData = UISeasonCollageData:New(GameGlobal.GetModule(SeasonModule):GetCurSeasonID())
  else
    local seasonID = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
    if seasonID ~= self._seasonCollageData:GetSeasonID() then
      self._seasonCollageData = UISeasonCollageData:New(GameGlobal.GetModule(SeasonModule):GetCurSeasonID())
    end
  end
  return self._seasonCollageData
end

function UISeasonModule:GetCurrentSeasonNew()
  return self:GetSeasonNew()
end

function UISeasonModule:GetCurrentSeasonRed()
  return self:GetSeasonRed()
end

local MainEnterKey = "UISeasonMainEnter"

function UISeasonModule:GetSeasonNew()
  local new = false
  local sample = self:GetModule(SeasonModule):GetCurSeasonSample()
  local svrTime = self:GetModule(SvrTimeModule):GetServerTime() * 0.001
  if sample and sample:IsShow(svrTime) then
    if not UISeasonHelper.IsMissionCptClosed(sample) then
      local seasonid = sample.id
      local roleModule = GameGlobal.GetModule(RoleModule)
      local pstid = roleModule:GetPstId()
      local key = MainEnterKey .. seasonid .. pstid
      local val = LocalDB.GetInt(key, 0)
      if val == 0 then
        new = true
      end
    end
    if not new then
      local talentNew = UISeasonHelper.TalentTreeNew(sample)
      if talentNew then
        new = true
      end
    end
    if not new then
      local TradeNew = UISeasonHelper.TradeGameNew(sample)
      if TradeNew then
        new = true
      end
    end
    if not new then
      local seasonMazeNew = UISeasonHelper.SeasonMazeNew(sample)
      if seasonMazeNew then
        new = true
      end
    end
  end
  return new
end

function UISeasonModule:SetSeasonNew()
  local sample = self:GetModule(SeasonModule):GetCurSeasonSample()
  local svrTime = self:GetModule(SvrTimeModule):GetServerTime() * 0.001
  if sample and sample:IsShow(svrTime) then
    local seasonid = sample.id
    local roleModule = GameGlobal.GetModule(RoleModule)
    local pstid = roleModule:GetPstId()
    local key = MainEnterKey .. seasonid .. pstid
    LocalDB.SetInt(key, 1)
  end
end

function UISeasonModule:GetGoBtnKey()
  local seasonid = 0
  local curid = self:GetSeasonID()
  if curid then
    seasonid = curid
  end
  return seasonid .. "GoBtnKey"
end

function UISeasonModule:GetSeasonRed()
  local red = false
  local sample = self:GetModule(SeasonModule):GetCurSeasonSample()
  local svrTime = self:GetModule(SvrTimeModule):GetServerTime() * 0.001
  if sample and sample:IsShow(svrTime) then
    red = sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_SEASONQUEST_REWARD)
    if not red and not UISeasonHelper.IsMissionCptClosed(sample) then
      local lastTime = UISeasonLocalDBHelper.SeasonBtn_Get(self:GetGoBtnKey(), "Red")
      local mapRed = HelperProxy:IsCrossDayTo(lastTime)
      local itemRed = false
      local seasonModule = GameGlobal.GetModule(SeasonModule)
      local seasonid = seasonModule:GetCurSeasonID()
      if seasonid then
        local cfg = Cfg.cfg_season_campaign_client[seasonid]
        if cfg then
          local itemid = cfg.ItemID
          local itemModule = GameGlobal.GetModule(ItemModule)
          local itemCount = itemModule:GetItemCount(itemid)
          if 0 < itemCount then
            itemRed = true
          end
        end
      end
      red = mapRed and itemRed
    end
    red = red or GameGlobal.GameLogic():GetModule(SeasonTaskModule):TaskListRed()
    red = red or UISeasonHelper.TalentTreeRed(sample)
    red = red or UISeasonHelper.TradeGameRed(sample)
    red = red or UISeasonHelper.SeasonMazeRed(sample)
  end
  return red
end

function UISeasonModule:AppendWaitShowBubbleCallback(callback)
  if not self._waitShowBubbleCallbacks then
    self._waitShowBubbleCallbacks = {}
  end
  table.insert(self._waitShowBubbleCallbacks, callback)
end

function UISeasonModule:EraseFirstWaitShowBubbleCallback()
  if not self._waitShowBubbleCallbacks then
    self._waitShowBubbleCallbacks = {}
  end
  table.remove(self._waitShowBubbleCallbacks, 1)
end

function UISeasonModule:ClearWaitShowBubbleCallbacks()
  self._waitShowBubbleCallbacks = {}
end

function UISeasonModule:GetWaitShowBubbleCallbacks()
  return self._waitShowBubbleCallbacks
end

function UISeasonModule:SetTalentTreeLineSelectMission(id, info_cur_id)
  self._talentTreeLineSelectMissionID = id
  self._info_cur_id = info_cur_id
end

function UISeasonModule:GetTalentTreeLineSelectMission()
  return self._talentTreeLineSelectMissionID, self._info_cur_id
end

function UISeasonModule:GetTalentTreeSkillClientTag()
  return self._talentTreeClick
end

function UISeasonModule:SetTalentTreeSkillClientTag(val)
  self._talentTreeClick = val
end

function UISeasonModule:GetTalentTreeTreeClientTag()
  return self._talentTreeLine
end

function UISeasonModule:SetTalentTreeTreeClientTag(val)
  self._talentTreeLine = val
end

function UISeasonModule:SaveFinishLineMissionList(id)
  Log.debug("###[UISeasonModule] SaveFinishLineMissionList start save , id:", id)
  local openid = GameGlobal.GetModule(RoleModule):GetPstId()
  local currSeasonID = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  local key = "TalentTreeFinishMission" .. currSeasonID .. openid
  local saveList = self:GetSaveFinishLineMissionList()
  local saveStr
  if saveList then
    saveStr = ""
    for i = 1, #saveList do
      local num = saveList[i]
      if num == id then
        Log.debug("###[UISeasonModule] SaveFinishLineMissionList save id is saved , return !")
        return
      end
      local str = tostring(num)
      saveStr = saveStr .. str
      if i ~= #saveList then
        saveStr = saveStr .. ","
      end
    end
    saveStr = saveStr .. "," .. tostring(id)
  else
    saveStr = tostring(id)
  end
  Log.debug("###[UISeasonModule] SaveFinishLineMissionList save end , val:", saveStr)
  LocalDB.SetString(key, saveStr)
end

function UISeasonModule:GetSaveFinishLineMissionList()
  Log.debug("###[UISeasonModule] SaveFinishLineMissionList start get client val")
  local openid = GameGlobal.GetModule(RoleModule):GetPstId()
  local currSeasonID = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  local key = "TalentTreeFinishMission" .. currSeasonID .. openid
  local val = LocalDB.GetString(key, "")
  if string.isnullorempty(val) then
    Log.debug("###[UISeasonModule] SaveFinishLineMissionList not client val , return !")
    return nil
  end
  local list = {}
  local strList = string.split(val, ",")
  for i = 1, #strList do
    local num = strList[i]
    table.insert(list, num)
  end
  return list
end

function UISeasonModule:SavePassLineMissionList(id)
  Log.debug("###[UISeasonModule] SavePassLineMissionList start save , id:", id)
  local openid = GameGlobal.GetModule(RoleModule):GetPstId()
  local currSeasonID = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  local key = "TalentTreePassMission" .. currSeasonID .. openid
  local saveList = self:GetSavePassLineMissionList()
  local saveStr
  if saveList then
    saveStr = ""
    for i = 1, #saveList do
      local num = saveList[i]
      if num == id then
        Log.debug("###[UISeasonModule] SavePassLineMissionList save id is saved , return !")
        return
      end
      local str = tostring(num)
      saveStr = saveStr .. str
      if i ~= #saveList then
        saveStr = saveStr .. ","
      end
    end
    saveStr = saveStr .. "," .. tostring(id)
  else
    saveStr = tostring(id)
  end
  Log.debug("###[UISeasonModule] SavePassLineMissionList save end , val:", saveStr)
  LocalDB.SetString(key, saveStr)
end

function UISeasonModule:GetSavePassLineMissionList()
  Log.debug("###[UISeasonModule] SavePassLineMissionList start get client val")
  local openid = GameGlobal.GetModule(RoleModule):GetPstId()
  local currSeasonID = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  local key = "TalentTreePassMission" .. currSeasonID .. openid
  local val = LocalDB.GetString(key, "")
  if string.isnullorempty(val) then
    Log.debug("###[UISeasonModule] SavePassLineMissionList not client val , return !")
    return nil
  end
  local list = {}
  local strList = string.split(val, ",")
  for i = 1, #strList do
    local num = strList[i]
    table.insert(list, num)
  end
  return list
end

function UISeasonModule:SetTalentTreeBattleOut(val)
  self._talentBattleOut = val
end

function UISeasonModule:GetTalentTreeBattleOut()
  local val = self._talentBattleOut
  self._talentBattleOut = false
  return val
end

function UISeasonModule:SetDefaultDialog(dialog, ...)
  Log.debug("设置赛季默认退局ui:", dialog)
  self._defaultDialog = dialog
  self._dialogParam = {
    ...
  }
end

function UISeasonModule:_AfterSceneUIShow()
  if self._defaultDialog then
    Log.debug("打开赛季退局默认ui:", self._defaultDialog)
    GameGlobal.UIStateManager():ShowDialog(self._defaultDialog, table.unpack(self._dialogParam))
    self._defaultDialog = nil
    self._dialogParam = nil
  end
end

function UISeasonModule:GetCurOnceMissionUI()
  local currSeasonID = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  if 8006 <= currSeasonID then
    return "UISeasonOnceMissionController"
  else
    return "UISeasonOnceMission"
  end
end
