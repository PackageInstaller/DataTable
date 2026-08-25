local StageGroupType = CommonDefine.StageGroupType
local StageExitPanelManager, Super = System.NewClass("StageExitPanelManager", Manager)

function StageExitPanelManager:ctor()
  Super.ctor(self)
  self.panelOrCallbackQueue = {}
  self.lastUrl = nil
  self.isExitStage = false
  self.isEnabled = false
  self.stageGroupType2PushFuncDict = {
    [StageGroupType.Prologue] = System.fn(self, self.PushWhenMainCopyExit),
    [StageGroupType.MainCopy] = System.fn(self, self.PushWhenMainCopyExit),
    [StageGroupType.CommonTrial] = System.fn(self, self.PushWhenTrialExit),
    [StageGroupType.LimitTrial] = System.fn(self, self.PushWhenTrialExit),
    [StageGroupType.StarTrial] = System.fn(self, self.PushWhenTrialExit),
    [StageGroupType.AbyssChallenge] = System.fn(self, self.PushWhenAbyssChallengeExit),
    [StageGroupType.DailyChallenge] = System.fn(self, self.PushWhenDailyChallengeExit),
    [StageGroupType.MaterialCopy] = System.fn(self, self.PushWhenMaterialCopyExit),
    [StageGroupType.DisposableSchoolTower] = System.fn(self, self.PushWhenDisposableSchoolTowerExit),
    [StageGroupType.WeekBoss] = System.fn(self, self.PushWhenWeekBossExit),
    [StageGroupType.SmallSubplotNormal] = System.fn(self, self.PushWhenSubplotExit),
    [StageGroupType.SmallSubplotHard] = System.fn(self, self.PushWhenSubplotExit),
    [StageGroupType.SmallSubplotCrazy] = System.fn(self, self.PushWhenSubplotExit),
    [StageGroupType.LargeSubplotNormal] = System.fn(self, self.PushWhenSubplotExit),
    [StageGroupType.LargeSubplotHard] = System.fn(self, self.PushWhenSubplotExit),
    [StageGroupType.LargeSubplotCrazy] = System.fn(self, self.PushWhenSubplotExit),
    [StageGroupType.Vindicate] = System.fn(self, self.PushWhenVindicateExit),
    [StageGroupType.RailWay] = System.fn(self, self.PushWhenRailwayExit),
    [StageGroupType.BattleTeaching] = System.fn(self, self.PushWhenBattleTeachingExit)
  }
end

function StageExitPanelManager:Awake(binder)
  Super.Awake(self, binder)
  binder:BindEvent(EventMgr.Instance.ClosePanelEvent, System.fn(self, self.OnPanelClose))
  binder:BindEvent(EventMgr.Instance.OnExitScene, System.fn(self, self.OnExitScene))
  binder:BindEvent(EventMgr.Instance.OnEnterScene, System.fn(self, self.OnEnterScene))
end

function StageExitPanelManager:SetEnabled()
  self.isEnabled = true
end

function StageExitPanelManager:SetDisabled()
  self.isEnabled = false
end

function StageExitPanelManager:Clear()
  table.clear(self.panelOrCallbackQueue)
  self.lastUrl = nil
  self.isExitStage = false
  CopyBackJumpUtils.Reset()
end

function StageExitPanelManager:OnExitScene(oldScene, newScene)
  if newScene == CommonDefine.SceneType.Login then
    self:Clear()
    self:SetDisabled()
  else
    self:SetEnabled()
  end
end

function StageExitPanelManager:OnEnterScene(scene)
  if scene == CommonDefine.SceneType.Town then
    if #self.panelOrCallbackQueue > 0 then
      self:_ScheduleDeferredDequeue()
      return
    end
    self:Clear()
    self:SetDisabled()
  end
end

function StageExitPanelManager:PushStackJump()
  if not self.panelOrCallbackQueue or #self.panelOrCallbackQueue > 0 then
    return
  end
  CopyBackJumpUtils.Reset()
  local stageTid = WorldStageManager.Instance:GetCurStageId()
  local needStackJump = CopyBackJumpUtils.GetIsNeedStackJump()
  if needStackJump then
    print("----------[StageExitPanelManager]push stack", stageTid, debug.traceback())
    CopyBackJumpUtils.GetStartStackJumpFunc(stageTid)
  end
end

function StageExitPanelManager:PushPanel(url, ...)
  print("---------[StageExitPanelManager]push panel", url, debug.traceback())
  self:PushStackJump()
  table.insert(self.panelOrCallbackQueue, {
    url = url,
    params = {
      ...
    },
    callback = nil
  })
end

function StageExitPanelManager:PushCallback(callback, afterUrl)
  print("----------[StageExitPanelManager]push callback", callback, afterUrl, debug.traceback())
  assert(callback and afterUrl, "PushCallback 需要传入 callback 和 afterUrl")
  self:PushStackJump()
  table.insert(self.panelOrCallbackQueue, {callback = callback, afterUrl = afterUrl})
end

function StageExitPanelManager:PushOnlyCallback(callback, afterUrl)
  print("----------[StageExitPanelManager]Push Only callback", debug.traceback())
  self:PushStackJump()
  table.insert(self.panelOrCallbackQueue, {
    callback = callback,
    isOnlyCallback = true,
    afterUrl = afterUrl
  })
end

function StageExitPanelManager:_ScheduleDeferredDequeue()
  if self._exitDeferredPending then
    return
  end
  self._exitDeferredPending = true
  TimerManager.Instance:CreateTimer(0.1, 0, nil, function()
    self._exitDeferredPending = nil
    if 0 == #self.panelOrCallbackQueue then
      self._exitDeferBattleRetries = 0
      return
    end
    if not self.isEnabled then
      return
    end
    if bg.IsInBattle() then
      self._exitDeferBattleRetries = (self._exitDeferBattleRetries or 0) + 1
      if self._exitDeferBattleRetries > 200 then
        self._exitDeferBattleRetries = 0
        return
      end
      self:_ScheduleDeferredDequeue()
      return
    end
    self._exitDeferBattleRetries = 0
    if not self.isExitStage then
      self.isExitStage = true
      if not SceneMgr.Instance:IsInTown() then
        SceneMgr.Instance:EnterNull()
      end
      UIAudioManager.Instance:SetMainSceneMusicState(true)
    end
    self:Dequeue()
  end)
end

function StageExitPanelManager:Dequeue()
  print("------------------[StageExitPanelManager]pop stack cur count", #self.panelOrCallbackQueue, debug.traceback())
  if bg.IsInBattle() then
    self:_ScheduleDeferredDequeue()
    return
  end
  local len = #self.panelOrCallbackQueue
  if 0 == len then
    self:FinishExitPanelQueue()
    return
  end
  if CopyBackJumpUtils.startStackJumpFunc then
    CopyBackJumpUtils.startStackJumpFunc()
  end
  local info = table.remove(self.panelOrCallbackQueue, 1)
  print("------------------[StageExitPanelManager]pop stack info", table.tostring(info))
  self.lastUrl = info.url or info.afterUrl
  xpcall(function()
    if info.url then
      print("[StageExitPanelManager]info url", info.url)
      UIManager.Instance:Reopen(info.url, table.unpack(info.params or {}))
    end
    if info.callback then
      print("--------------exec callback isOnlyCallback:", info.isOnlyCallback)
      if info.isOnlyCallback and info.isGotoTown and not CopyBackJumpUtils.needStackJump then
        SceneMgr.Instance:EnterTown()
      end
      info.callback()
    end
  end, debug.traceback)
end

function StageExitPanelManager:OnStageExit()
  if not self.isEnabled then
    return
  end
  self.isExitStage = true
  if not SceneMgr.Instance:IsInTown() then
    SceneMgr.Instance:EnterNull()
  end
  UIAudioManager.Instance:SetMainSceneMusicState(true)
  self:Dequeue()
end

function StageExitPanelManager:FinishExitPanelQueue()
  print("-------------finish exit panel stack")
  self.isExitStage = false
  if not CopyBackJumpUtils.needStackJump then
    SceneMgr.Instance:EnterTown(true)
    if not UIManager.Instance:GetWindow(Urls.MainPanel) then
      UIManager.Instance:Reopen(Urls.MainPanel)
    end
  end
end

function StageExitPanelManager:OnPanelClose(url)
  if not self.isExitStage then
    return
  end
  if url == self.lastUrl then
    self:Dequeue()
  end
  if not CopyBackJumpUtils.needStackJump then
    self:EnterTownAfterUIClose(url)
  end
  if self.lastUrl then
    local panel = UIManager.Instance:GetWindow(self.lastUrl)
    if panel then
      panel.closeWithoutAnim = true
    end
  end
end

function StageExitPanelManager:EnterTownAfterUIClose(url)
  local enterTownUrls = {
    Urls.SocialPlayerInfoPanel,
    Urls.ActivityMainPanel,
    Urls.DungeonsMainView,
    Urls.CopyMainChapterView,
    Urls.DungeonMaterialView,
    Urls.DungeonsTrinketView,
    Urls.SchoolTowerView,
    Urls.DailyChallengeView,
    Urls.WeekBossView,
    Urls.AbyssView,
    Urls.TaskMainView
  }
  if SceneMgr.Instance:IsNullScene() and table.contains(enterTownUrls, url) then
    SceneMgr.Instance:EnterTown()
  end
end

function StageExitPanelManager:PushWhenWorldStageRecover(stageTid)
  print("-----------------push when world stage recover", stageTid, debug.traceback())
  local stageGroupType = StageCfgUtils.GetStageGroupType(stageTid)
  if CopyBackJumpUtils.startStackJumpFunc then
    CopyBackJumpUtils.startStackJumpFunc()
  end
  local pushFunc = self.stageGroupType2PushFuncDict[stageGroupType]
  if pushFunc then
    pushFunc(stageTid)
    return
  end
  self:PushWhenActivityChallengeExit(stageTid)
end

function StageExitPanelManager:PushWhenMainCopyExit(stageTid)
  StageExitPanelManager.Instance:PushOnlyCallback(function()
    local stageGroupTid = CopyDataUtils.GetStageGroupId(stageTid)
    if not UIManager.Instance.GetWindow(Urls.MainPanel) then
      UIManager.Instance:Reopen(Urls.MainPanel)
    end
    if PlayerDataUtils.IsFirstTimeOpenNextStageChapter() then
      return
    end
    local cb = CopyController.Instance:GetBattleFinishJumper(stageGroupTid)
    if cb then
      cb()
    end
  end, false)
end

function StageExitPanelManager:PushWhenSubplotExit(stageTid, activityTid)
  local stageGroupId = CopyDataUtils.GetStageGroupId(stageTid)
  print("---------[StageExitPanelManager]PushWhenSubplotExit aa", stageTid, stageGroupId, debug.traceback())
  if stageGroupId then
    print("---------[StageExitPanelManager]PushWhenSubplotExit bb", stageTid, stageGroupId, debug.traceback())
    local exitCallback = CopyController.Instance:GetBattleFinishJumper(stageGroupId, activityTid)
    StageExitPanelManager.Instance:PushOnlyCallback(function()
      if exitCallback then
        exitCallback()
      end
    end, true)
  end
end

function StageExitPanelManager:PushWhenVindicateExit(stageTid)
  local stageGroupId = CopyDataUtils.GetStageGroupId(stageTid)
  if stageGroupId then
    local exitCallback = CopyController.Instance:GetBattleFinishJumper(stageGroupId)
    StageExitPanelManager.Instance:PushOnlyCallback(function()
      if exitCallback then
        exitCallback()
      end
      CopyVindicateModel.Instance:SetSelectStageTid(stageTid)
    end, true)
  end
end

function StageExitPanelManager:PushWhenRailwayExit(stageTid)
  local stageGroupTid = StageCfgUtils.GetCfgField("BelongGroup", stageTid)
  if stageGroupTid ~= DT.GetOriginalConstant("RailWayStageGroupTid") then
    return
  end
  local effectingActivityTid = ActivityCfgUtils.GetActivityTidByActivityType(ActivityDefine.ActivityType.RailWayActivity)
  StageExitPanelManager.Instance:PushPanel(Urls.RailWayMainView)
  if ActivityManager.Instance:IsActivityFinishedByTid(effectingActivityTid) then
    StageExitPanelManager.Instance:PushPanel(Urls.ActivityPermanentsPanel)
  end
end

function StageExitPanelManager:PushWhenTrialExit(stageTid)
  local effectingActivityTid
  local displayActivityTidMap = ActivityManager.Instance.model.displayTidMap
  for activityTid, _ in pairs(displayActivityTidMap) do
    local activityCfg = ActivityCfgUtils.GetCfg(activityTid)
    if not activityCfg then
    elseif activityCfg.ActivityType ~= ActivityDefine.ActivityType.AwakerTrial then
    elseif activityCfg.ActivityPara1[1] == stageTid then
      effectingActivityTid = activityTid
      break
    end
  end
  if effectingActivityTid then
    self:PushWhenActivityTrialExit(effectingActivityTid)
  else
    self:PushWhenDungeonTrialExit(stageTid)
  end
end

function StageExitPanelManager:PushWhenActivityTrialExit(activityTid)
  StageExitPanelManager.Instance:PushCallback(function()
    ActivityDataUtils.OpenActivityMainPanel(activityTid)
  end, Urls.ActivityMainPanel)
end

function StageExitPanelManager:PushWhenDungeonTrialExit(stageTid)
  local trialType = StageCfgUtils.GetTrailTypeByStageTid(stageTid)
  StageExitPanelManager.Instance:PushCallback(function()
    UIManager.Instance:Reopen(Urls.TaskMainView, CommonDefine.TaskPage.AwakerTrial, function()
      local panel = UIManager.Instance:GetWindow(Urls.FreeTrialView)
      panel:SetDefaultStageId(trialType, stageTid)
    end)
  end, Urls.DungeonsMainView)
end

function StageExitPanelManager:PushWhenAbyssChallengeExit(stageTid)
  if WorldRecoveryManager.Instance:IsWaitingAbyssResetConfirm() or WorldRecoveryManager.Instance:IsStageExpiredByServer() then
    Logger.Info("[AbyssReset] PushWhenAbyssChallengeExit skip abyss UI, stageTid=%s", tostring(stageTid))
    return
  end
  local stageGroupTid = StageCfgUtils.GetCfgField("BelongGroup", stageTid)
  if ActivityManager.Instance:HasOpeningAbyssActivity() then
    StageExitPanelManager.Instance:PushCallback(function()
      local jumperCallback = AbyssController.Instance:GetBattleFinishJumper(stageGroupTid)
      if jumperCallback then
        jumperCallback()
      end
    end, Urls.AbyssChallengeView)
  end
  StageExitPanelManager.Instance:PushPanel(Urls.AbyssView)
end

function StageExitPanelManager:PushWhenDailyChallengeExit(stageTid)
  StageExitPanelManager.Instance:PushPanel(Urls.DailyChallengeView)
end

function StageExitPanelManager:PushWhenBattleTeachingExit(stageTid)
  StageExitPanelManager.Instance:PushPanel(Urls.TaskMainView, CommonDefine.TaskPage.BattleTeaching)
end

function StageExitPanelManager:PushWhenMaterialCopyExit(stageTid)
  local stageGroupTid = StageCfgUtils.GetCfgField("BelongGroup", stageTid)
  local stageGroupType = StageCfgUtils.GetStageGroupType(stageTid)
  StageExitPanelManager.Instance:PushCallback(function()
    DungeonMaterialModel.Instance:ResetStageGroupId()
    DungeonMaterialModel.Instance:SetStageGroupType(stageGroupType)
    DungeonMaterialModel.Instance:SetStageGroupId(stageGroupTid)
    
    local function openSubView()
      UIManager.Instance:Reopen(Urls.DungeonMaterailSubView, stageTid)
    end
    
    local stageList = CopyDataUtils.GetStageList(stageGroupTid)
    if not stageList or not table.next(stageList) then
      CopyDataUtils.ReqCopyData(nil, stageGroupTid)
    end
    openSubView()
  end, Urls.DungeonMaterailSubView)
  local entryPage = CommonDefine.DBGEntryPage.MaterialPanel
  if stageGroupType == CommonDefine.StageGroupType.TrinketCopy then
    entryPage = CommonDefine.DBGEntryPage.TrinketPanel
  end
  StageExitPanelManager.Instance:PushPanel(Urls.DungeonsMainView, entryPage)
end

function StageExitPanelManager:PushWhenDisposableSchoolTowerExit(stageTid)
  local stageGroupTid = StageCfgUtils.GetCfgField("BelongGroup", stageTid)
  StageExitPanelManager.Instance:PushPanel(Urls.SchoolTowerDetailView, stageGroupTid, stageTid)
  StageExitPanelManager.Instance:PushPanel(Urls.DungeonsMainView, CommonDefine.DBGEntryPage.SchoolTowerPanel)
end

function StageExitPanelManager:PushWhenWeekBossExit(stageTid)
  local stageGroupTid = StageCfgUtils.GetCfgField("BelongGroup", stageTid)
  StageExitPanelManager.Instance:PushPanel(Urls.DungeonWeekBossSubPanel, stageGroupTid, WeekBossExtModel.Instance.featureId, WeekBossExtModel.Instance.stageType, CommonDefine.DBGEntryPage.WeekBossPanel)
  StageExitPanelManager.Instance:PushPanel(Urls.DungeonsMainView, CommonDefine.DBGEntryPage.WeekBossPanel)
end

function StageExitPanelManager:PushWhenActivityChallengeExit(stageTid)
  local stageGroupTid = StageCfgUtils.GetCfgField("BelongGroup", stageTid)
  local stageGroupType = StageCfgUtils.GetStageGroupType(stageTid)
  local effectingActivityTid, effectingActivityCfg
  local displayActivityTidMap = ActivityManager.Instance.model.displayTidMap
  for activityTid, _ in pairs(displayActivityTidMap) do
    local activityCfg = ActivityCfgUtils.GetCfg(activityTid)
    if not activityCfg then
    else
      if activityCfg.ActivityType == ActivityDefine.ActivityType.TwoAnniversaryWorldBossActivity and table.contains(activityCfg.ActivityPara1, stageGroupTid) then
        effectingActivityTid = activityTid
        effectingActivityCfg = activityCfg
        break
      end
      if activityCfg.ActivityType == ActivityDefine.ActivityType.TwoAndAHalfAnniversaryRAIDActiviity and table.contains(activityCfg.ActivityPara1, stageGroupTid) then
        effectingActivityTid = activityTid
        effectingActivityCfg = activityCfg
        break
      end
      if activityCfg.ActivityPara1[1] == stageGroupType then
        effectingActivityTid = activityTid
        effectingActivityCfg = activityCfg
        break
      end
    end
  end
  if effectingActivityTid then
    if not ActivityManager.Instance:IsActivityOpenedByTid(effectingActivityTid) then
      return
    end
    if not ActivityManager.Instance:IsActivityFinishedByTid(effectingActivityTid) then
      local stageGroupTid2TaskTidMap = ActivityCfgUtils.GetStageTaskMap(effectingActivityTid)
      local extraData = table.clone(effectingActivityCfg)
      extraData.taskId = stageGroupTid2TaskTidMap[stageGroupTid]
      CopyDataUtils.ReqCopyData(nil, stageGroupTid, nil, true)
      StageExitPanelManager.Instance:PushPanel(Urls.ActivityChallengePanel, stageGroupTid, effectingActivityTid, stageTid, extraData)
    end
    StageExitPanelManager.Instance:PushPanel(Urls.ActivityMainPanel, {
      targetActivityTid = effectingActivityTid,
      params = {audioPlay = true}
    })
  end
end

return StageExitPanelManager
