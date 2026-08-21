_class("SeasonEnterLoadingHandler", LoadingHandler)
SeasonEnterLoadingHandler = SeasonEnterLoadingHandler

function SeasonEnterLoadingHandler:Constructor()
  GameGlobal.UIStateManager():Lock("SeasonEnterLoadingHandler")
  self._loginModule = GameGlobal.GetModule(LoginModule)
end

function SeasonEnterLoadingHandler:PreLoadBeforeLoadLevel()
end

function SeasonEnterLoadingHandler:PreLoadAfterLoadLevel(TT, ...)
  if not self:_CheckLoginState() then
    Log.error("当前客户端已退出登录，不再继续执行赛季loading", 1)
    self._canEnter = false
    return
  end
  local seasonModule = GameGlobal.GetModule(SeasonModule)
  if seasonModule:GetCurSeasonID() > 0 then
    self:_CacheRT(TT)
    LoadingHandler.PreLoadAfterLoadLevel(self, TT, ...)
    seasonModule:ForceRequestCurSeasonData(TT)
    local component = seasonModule:GetCurSeasonObj():GetComponent(ECCampaignSeasonComponentID.SEASON_MISSION)
    if component:ComponentIsOpen() then
      if not self:_CheckLoginState() then
        Log.error("当前客户端已退出登录，不再继续执行赛季loading", 2)
        self._canEnter = false
        return
      end
      self:Verify(TT, seasonModule)
      if not self:_CheckLoginState() then
        Log.error("当前客户端已退出登录，不再继续执行赛季loading", 3)
        self._canEnter = false
        return
      end
      self:GetSeasonTask(TT)
      if not self:_CheckLoginState() then
        Log.error("当前客户端已退出登录，不再继续执行赛季loading", 4)
        self._canEnter = false
        return
      end
      self:VerifyTask(TT)
      self._canEnter = true
      YIELD(TT)
    else
      Log.info("赛季关卡组件已关闭")
      ToastManager.ShowToast(StringTable.Get("str_activity_error_109"))
    end
  else
    Log.info("赛季已关闭")
    ToastManager.ShowToast(StringTable.Get("str_activity_error_109"))
  end
end

function SeasonEnterLoadingHandler:OnLoadingFinish(...)
  if self._canEnter then
    local loadingParams = {
      ...
    }
    local uimodule = GameGlobal.GetUIModule(SeasonModule)
    uimodule:EnterSeasonGame(loadingParams)
    if loadingParams and loadingParams[4] then
      local dialogName = loadingParams[4]
      GameGlobal.UIStateManager():SwitchStateWithDialogList(UISeasonHelper.CurSeasonSceneState(), dialogName)
    else
      GameGlobal.UIStateManager():SwitchState(UISeasonHelper.CurSeasonSceneState())
    end
  else
    Log.error("赛季不可进入 弹回到游戏主界面")
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
  end
  GameGlobal.UIStateManager():UnLock("SeasonEnterLoadingHandler")
end

function SeasonEnterLoadingHandler:NeedSwitchState()
  return true
end

function SeasonEnterLoadingHandler:_CacheRT(TT)
  local controller = GameGlobal.UIStateManager():GetController("UICommonLoading")
  if controller then
    controller:CacheRT(TT)
  end
end

function SeasonEnterLoadingHandler:Verify(TT, seasonModule)
  local errorInfo = {}
  if not seasonModule:GetLevelExpress() then
    local componentInfo = seasonModule:GetCurSeasonObj():GetComponentInfo(ECCampaignSeasonComponentID.SEASON_MISSION)
    local pass = componentInfo.m_pass_mission_info
    local map = componentInfo.m_stage_info
    if pass and table.count(pass) then
      for id, _ in pairs(pass) do
        local cfgMission = Cfg.cfg_season_mission[id]
        if cfgMission and cfgMission.IsFightLevel then
          local missionID = cfgMission.ID
          local progress = map[missionID]
          local cfgEventPoint = Cfg.cfg_season_map_eventpoint[missionID]
          if cfgEventPoint then
            if progress then
              local firstProgress = SeasonTool:GetInstance():GetProgressByExpressType(cfgEventPoint, SeasonExpressType.Level)
              if firstProgress and progress < firstProgress then
                local t = {}
                t.id = missionID
                t.progress = firstProgress
                table.insert(errorInfo, t)
              end
            else
              local firstProgress = SeasonTool:GetInstance():GetProgressByExpressType(cfgEventPoint, SeasonExpressType.Level)
              if firstProgress then
                local t = {}
                t.id = missionID
                t.progress = firstProgress
                table.insert(errorInfo, t)
              end
            end
          end
        end
      end
    end
    local count = #errorInfo
    if 0 < count then
      for _, value in pairs(errorInfo) do
        Log.debug("Season Verify !", value.id, value.progress)
        seasonModule:HandleSeasonClientStageData(TT, value.id, value.progress)
      end
    end
  end
end

function SeasonEnterLoadingHandler:GetSeasonTask(TT)
  if not self:_CheckLoginState() then
    Log.error("当前客户端已退出登录，不再继续执行赛季loading", 3)
    return
  end
  local seasonTaskModule = GameGlobal.GetModule(SeasonTaskModule)
  seasonTaskModule:ReqSeasonTaskInfoData(TT)
end

function SeasonEnterLoadingHandler:VerifyTask(TT)
  local seasonTaskModule = GameGlobal.GetModule(SeasonTaskModule)
  local subTaskID = seasonTaskModule:GetCurQuestId(seasonTaskModule:GetCurNode())
  if 0 < subTaskID then
    local questModule = GameGlobal.GetModule(QuestModule)
    local quest = questModule:GetQuest(subTaskID)
    if quest and quest:Status() ~= QuestStatus.QUEST_Taken then
      local num = 0
      local cfgMissions = Cfg.cfg_season_mission({QuestID = subTaskID})
      local map = seasonTaskModule:GetConditionMap()
      if cfgMissions and 0 < table.count(map) then
        for _, cfgMission in pairs(cfgMissions) do
          local cfg = Cfg.cfg_season_map_eventpoint[cfgMission.ID]
          if cfg and map[cfg.ID] then
            local isLast = SeasonTool:GetInstance():IsLastProgress(cfg, map[cfg.ID])
            if isLast then
              num = num + 1
            end
          end
        end
        if num > quest:QuestInfo().cur_progress and num <= quest:QuestInfo().total_progress then
          local deltaNum = num - quest:QuestInfo().cur_progress
          Log.debug("SeasonEnterLoadingHandler VerifyTask.", deltaNum)
          local res, rewards = questModule:HandleClientProcess(TT, subTaskID, deltaNum)
          if res:GetSucc() then
            Log.info("SeasonEnterLoadingHandler VerifyTask success.", deltaNum)
          end
        end
      end
    end
  end
end

function SeasonEnterLoadingHandler:LoadingID()
  local seasonModule = GameGlobal.GetModule(SeasonModule)
  local seasonID = seasonModule.uiModule:GetSeasonID()
  local cfg = Cfg.cfg_season_loading[seasonID]
  if cfg then
    local ids = cfg.loadingids
    return GameGlobal.LoadingManager():FilterAndRandomLoadingID(ids)
  end
  return nil
end

function SeasonEnterLoadingHandler:_CheckLoginState()
  return self._loginModule:IsLogin()
end
