LoadingType = {
  STATICPIC = 0,
  PROGRESS = 1,
  BOTTOM = 2
}
LoadingHandlerName = {
  Battle_Loading = "BattleLoadingHandler",
  Battle_Exit = "BattleExitLoadingHandler",
  Exit_Core_Game = "ExitCoreGameHandler",
  ReStart_Core_Game = "ReStartCoreGameHandler",
  Aircraft_Exit = "AircraftExitLoadingHandler",
  Aircraft_Room_Exit = "AircraftRoomExitLoadingHandler",
  Aircraft_Enter = "AircraftEnterLoadingHandler",
  Maze_Enter = "MazeEnterLoadingHandler",
  Maze_Exit = "MazeExitLoadingHandler",
  Res_Exit = "ResExitLoadingHandler",
  Shop_Enter = "ShopEnterLoadingHandler",
  DrawCard_Enter = "UIDrawCardLoadingEnter",
  DrawCard_Enter_UL = "UIDrawCardLoadingEnterUL",
  DrawCard_Exit = "UIDrawCardLoadingExit",
  Discovery_Enter = "UIDiscoveryLoadingEnterHandler",
  Cutscene_Enter = "CutsceneLoadingHandler",
  Cutscene_Exit = "CutsceneExitLoadingHandler",
  Aircraft2Drawcard = "AircraftToDrawcardLoading",
  Homeland_Enter = "HomelandEnterLoadingHandler",
  Homeland_Exit = "HomelandExitLoadingHandler",
  Season_Enter = "SeasonEnterLoadingHandler",
  Season_Exit = "SeasonExitLoadingHandler",
  CorGamePerformanceTest_Enter = "CoreGamePerformanceTestLoadingHandler",
  CorGamePerformanceTest_Exit = "CutsceneExitLoadingHandler",
  SeasonMaze_Enter = "SeasonMazeLoadingEnter",
  SeasonMaze_Exit = "SeasonMazeLoadingExit",
  SeasonMain_OnceMission_Enter = "SeasonMainOnceMissionEnter"
}
local EnterUILoadingHandler = {
  [LoadingHandlerName.Aircraft_Enter] = true,
  [LoadingHandlerName.Aircraft_Room_Exit] = true,
  [LoadingHandlerName.Aircraft_Exit] = true,
  [LoadingHandlerName.Maze_Enter] = true,
  [LoadingHandlerName.Maze_Exit] = true,
  [LoadingHandlerName.DrawCard_Enter] = true,
  [LoadingHandlerName.DrawCard_Exit] = true
}
_class("LoadingManager", Object)
local unpack = table.unpack
local LOADING_SCENE_NAME = "Loading.unity"

function LoadingManager:Constructor()
  self.loadingHandler = nil
  self.loadingHandlerName = nil
  self.targetLevelName = nil
  self.loadingParams = nil
  self._progressBar = LoadingProgressBar:New()
  self._isCoreGameLoading = false
  self._isLoading = false
  self._interruptCallback = nil
end

function LoadingManager:StartLoading(loadingHandlerName, targetLevelName, ...)
  self._isLoading = true
  self._interruptCallback = nil
  ResourceManager:GetInstance():SetSyncLoadNum(3)
  self.loadingHandlerName = loadingHandlerName
  if not self.loadingHandlerName then
    return
  end
  local loadingHandler = _createInstance(self.loadingHandlerName)
  if not loadingHandler then
    return
  end
  if not loadingHandler:IsChildOf("LoadingHandler") then
    Log.fatal("LoadingManager:StartLoading Fail,", self.loadingHandlerName, " is not inherited from LoadingHandler!")
    return
  end
  loadingHandler:SetProgressBar(self._progressBar)
  self.loadingHandler = loadingHandler
  self.targetLevelName = targetLevelName
  self.loadingParams = {
    ...
  }
  self._latestHandler = loadingHandlerName
  self:StartTask(LoadingManager.Load, self)
end

function LoadingManager:Update(deltaTimeMS)
end

function LoadingManager:Load(TT)
  Log.debug("[HomelandProfile] (LoadingManager:Load) StartLoadTask")
  local tik = os.clock()
  local pm = GameGlobal.GetModule(PetAudioModule)
  pm:StopAll()
  AudioHelperController.StopAllUIVoice()
  if GameGlobal.UIStateManager():CurUIStateType() == UIStateType.Invalid or self.loadingHandler:NeedSwitchState() then
    GameGlobal.UIStateManager():SwitchState(UIStateType.UICommonLoading, self.loadingHandler:LoadingType(), self.loadingHandler:LoadingID())
    while GameGlobal.UIStateManager():CurUIStateType() ~= UIStateType.UICommonLoading do
      YIELD(TT)
    end
  else
    local showTaskid = GameGlobal.UIStateManager():ShowDialog("UICommonLoading", self.loadingHandler:LoadingType(), self.loadingHandler:LoadingID())
    JOIN(TT, showTaskid)
  end
  Log.debug("[HomelandProfile] (LoadingManager:Load) ShowLoadingUI")
  self._progressBar:Reset()
  if self.targetLevelName then
    Log.debug("[HomelandProfile] (LoadingManager:Load) StartLoadLoadingScene -> " .. LOADING_SCENE_NAME)
    local req = ResourceManager:GetInstance():AsyncLoadAsset(TT, LOADING_SCENE_NAME, LoadType.Unity)
    req:Dispose()
    Log.debug("[HomelandProfile] (LoadingManager:Load) FinishLoadLoadingScene ->" .. LOADING_SCENE_NAME)
  end
  self.loadingHandler:PreLoadBeforeLoadLevel(TT, unpack(self.loadingParams, 1, table.maxn(self.loadingParams)))
  local sceneReq
  if self.targetLevelName then
    Log.debug("[HomelandProfile] (LoadingManager:Load) StartLoadHomelandScene -> ", self.targetLevelName)
    YIELD(TT)
    sceneReq = self.loadingHandler:LoadLevel(TT, self.targetLevelName)
    Log.debug("[HomelandProfile] (LoadingManager:Load) FinishLoadLoadingScene ->", self.targetLevelName)
  end
  Log.debug("[HomelandProfile] (LoadingManager:Load) StartPreLoadAfterLoadLevel")
  self.loadingHandler:PreLoadAfterLoadLevel(TT, unpack(self.loadingParams, 1, table.maxn(self.loadingParams)))
  Log.debug("[HomelandProfile] (LoadingManager:Load) FinishPreLoadAfterLoadLevel")
  GameGlobal.EventDispatcher():Dispatch(GameEventType.LoadLevelEnd, true)
  if self:IsEnterUI() then
    self._progressBar:Complete()
  end
  local tok = os.clock() - tik
  Log.prof("LoadingManager:Load(TT) use time=", tok * 1000)
  Log.debug("[HomelandProfile] (LoadingManager:Load) FinishLoad ->" .. tok * 1000)
end

function LoadingManager:Excute(value)
  ResourceManager:GetInstance():SetSyncLoadNum(0)
  self:onLoadingFinish()
end

function LoadingManager:StartTask(func, ...)
  TaskManager:GetInstance():StartTask(func, ...)
end

function LoadingManager:IsEnterUI()
  return EnterUILoadingHandler[self.loadingHandlerName]
end

function LoadingManager:IsLoading()
  return self._isLoading or self._isCoreGameLoading
end

function LoadingManager:Interrupt(cb)
  if not self:IsLoading() then
    Log.warn("not loading now,cant interrupt")
    return
  end
  if self._interruptCallback and not cb then
    Log.warn("cant set interrupt callback nil")
    return
  end
  if self._isCoreGameLoading then
    Log.debug("[Loading] 尝试打断局内loading")
  end
  if cb then
    GameGlobal.UIStateManager():Lock("WaitToInterruptLoading")
    GameGlobal.UIStateManager():ShowBusy(true)
    self._interruptCallback = cb
  end
end

function LoadingManager:CoreGameLoadingStart()
  self._isCoreGameLoading = true
end

function LoadingManager:CoreGameLoadingFinish()
  Log.debug("[Loading] 局内loading结束")
  self:onLoadingFinish()
  self._isCoreGameLoading = false
end

function LoadingManager:onLoadingFinish()
  self._isLoading = false
  if self._interruptCallback then
    local cb = self._interruptCallback
    self._interruptCallback = nil
    GameGlobal.UIStateManager():UnLock("WaitToInterruptLoading")
    GameGlobal.UIStateManager():ShowBusy(false)
    if self._isCoreGameLoading then
      Log.debug("[Loading] 执行局内打断回调")
    else
      Log.debug("[Loading] 执行普通打断回调")
    end
    cb()
    return
  end
  if self.loadingHandler then
    self.loadingHandler:LoadingFinish(unpack(self.loadingParams, 1, table.maxn(self.loadingParams)))
  end
  self.loadingHandler = nil
  self.loadingHandlerName = nil
  self.targetLevelName = nil
  self.loadingParams = nil
end

function LoadingManager:CacheRT(rt)
  self._rt = rt
end

function LoadingManager:GetRT()
  return self._rt
end

function LoadingManager:ReleaseRT()
  if self._rt then
    self._rt:Release()
    self._rt = nil
  end
end

function LoadingManager:FilterAndRandomLoadingID(ids)
  if not ids or not next(ids) then
    return nil
  end
  if #ids == 1 then
    return ids[1]
  end
  local now = GetSvrTimeNow()
  local results = {}
  local loginModule = GameGlobal.GetModule(LoginModule)
  for _, id in ipairs(ids) do
    local cfg = Cfg.cfg_loading[id]
    if not cfg then
      Log.exception("cfg_loading 中找不到配置:", id)
    end
    local startTime = math.mininteger
    local endTime = math.maxinteger
    if cfg.StartTime then
      startTime = loginModule:GetTimeStampByTimeStr(cfg.StartTime, cfg.TimeType)
    end
    if cfg.EndTime then
      endTime = loginModule:GetTimeStampByTimeStr(cfg.EndTime, cfg.TimeType)
    end
    if now >= startTime and now <= endTime then
      table.insert(results, id)
    end
  end
  if #results == 0 then
    Log.exception("没有符合条件的loading图 返回第一个")
    return ids[1]
  elseif #results == 1 then
    return results[1]
  else
    return results[math.random(1, #results)]
  end
end

_class("LoadingProgressBar", Object)
LoadingProgressBar = LoadingProgressBar

function LoadingProgressBar:Constructor()
  self._percent = 0
end

function LoadingProgressBar:SetProgress(progress)
  progress = Mathf.Clamp(progress, 0, 100)
  if progress < self._percent then
    Log.fatal("Loading progress error:", progress, "，current is ", self._percent)
    return
  elseif self._percent == progress then
    return
  end
  self._percent = progress
  GameGlobal.EventDispatcher():Dispatch(GameEventType.LoadingProgressChanged, self._percent)
end

function LoadingProgressBar:GetProgress()
  return self._percent
end

function LoadingProgressBar:Reset()
  self._percent = -1
  self:SetProgress(0)
end

function LoadingProgressBar:Complete()
  self:SetProgress(100)
end
