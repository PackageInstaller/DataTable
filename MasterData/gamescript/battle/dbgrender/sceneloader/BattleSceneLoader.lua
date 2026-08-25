local BattleSceneLoader, Super = System.NewClass("BattleSceneLoader", SceneLoaderBase)
local speedId = CS.UnityEngine.Shader.PropertyToID("_SpeedA")
local MaterialPropertyBlock = CS.UnityEngine.MaterialPropertyBlock

function BattleSceneLoader:ctor(battleId, uniqueSceneId)
  self.battleId = battleId
  self.uniqueSceneId = uniqueSceneId
  self.battleCfg = DT.BattleConfig[battleId]
  self.curBattleSceneStatus = nil
  local sceneID = uniqueSceneId or self.battleCfg.SceneID
  self.battleSceneCfg = DT.BattleSceneConfig[tonumber(sceneID)]
  if not self.battleSceneCfg then
    self.battleSceneCfg = DT.BattleSceneConfig[self.battleCfg.SceneID]
    assert(self.battleSceneCfg, string.format("BattleSceneCfg %s not found", self.battleCfg.SceneID))
  end
  self._shaderWarmupKey = {}
end

function BattleSceneLoader:LoadBattleScene(playStoryId, onFinished)
  if self.isStartLoaded then
    return
  end
  self.isStartLoaded = true
  self.finishStoryId = playStoryId
  if not bg.isPVP then
    if not playStoryId and SceneMgr.Instance:IsInCopies() then
      self.timelinePath = CommonRes.TimelinePrepared.Common_Enter_Battle
      if WorldStageManager.Instance:IsOneLineMap() then
        self.timelinePath = CommonRes.TimelinePrepared.Common_Enter_Battle_OneLineCopy
      end
    elseif not bg.isRestart and not playStoryId and self.battleCfg.BattleType ~= bc.BattleType.Boss then
      self.timelinePath = CommonRes.TimelinePrepared.Common_Loading_Battle
    end
  end
  WaitingView.Instance:ShowOnce(self, WaitingView.Flag_BattleSceneLoading)
  self.onFinishedCallabck = onFinished
  self:PlayTimelineAnimation()
  local BattleManager = BattleManager.Instance
  if BattleManager.isRunInServer then
    self:StartLoadBattleScene()
  end
  self:PlayWorldStageMainPanelClosedAnim()
  self:_StartSafeTimer()
end

function BattleSceneLoader:StartLoadBattleScene()
  if self.isStartLoadBattleScene then
    return
  end
  self.isStartLoadBattleScene = true
  if bg.battleDataCenter.isInit or bg.isReplay then
    local resPaths = {}
    self:PrepareCommonAssets(resPaths)
    Super.StartLoadScene(self, self.battleSceneCfg.BattleScene, resPaths, function()
      self:OnResourcesLoadedFinished()
    end, false)
  else
    EventMgr.Instance.BattleData:RegisterEvent(System.fn(self, self.OnBattleDataReady))
    Super.StartLoadScene(self, self.battleSceneCfg.BattleScene, nil, function()
      self:OnBattleSceneLoaded()
    end, false)
  end
end

function BattleSceneLoader:PrepareCommonAssets(resPaths)
  local enterAnimPath = BattleSceneEntranceAnimation.GetAnimationPath()
  table.insert(resPaths, enterAnimPath)
  table.insert(resPaths, CommonRes.BattleCardSPAsset)
  table.insert(resPaths, CommonRes.Number2SPAsset)
  if bg.isPVP then
    if BattleManager.isRunInServer then
      table.insert(resPaths, CommonRes.PvPBattlePanelUrls)
    end
  else
    table.insert(resPaths, CommonRes.DbgBattlePanelUrls)
  end
end

function BattleSceneLoader:PlayTimelineAnimation()
  local BattleManager = BattleManager.Instance
  if not self.timelinePath then
    self:OnTimelineCompeleted()
    return
  end
  if not self.finishStoryId and SceneMgr.Instance:IsInCopies() then
    local mapRole = WorldStageManager.Instance:GetCurMapRole()
    if mapRole and not IsNil(mapRole.go) then
      self.animTimelinePlayer = MSceneTimelinePlayer(mapRole.go)
    else
      self.animTimelinePlayer = MSceneTimelinePlayer()
    end
  else
    self.animTimelinePlayer = MSceneTimelinePlayer()
  end
  self._timelineTimer = TimerManager.Instance:CreateTimer(5, 0, nil, function()
    self:StartLoadBattleScene()
    self:StopTimelineLoop()
    self:OnTimelineCompeleted()
  end)
  self.animTimelinePlayer:PlayTimeline(self.timelinePath, -1, function()
    self:OnTimelineCompeleted()
  end, function(eventId, eventParam)
    if not BattleManager.isRunInServer and eventId == rc.TimeLineEvent.StringEvent and "StartLoadBattleScene" == eventParam then
      self:StartLoadBattleScene()
    end
  end)
end

function BattleSceneLoader:OnTimelineCompeleted()
  self.isTimelineAnimFinished = true
  if self.finishStoryId then
    SceneMgr.Instance:ClosePermanentUIs()
  end
  if not BattleManager.Instance.isRunInServer and not self.timelinePath then
    self:StartLoadBattleScene()
  end
  self:CheckAllDone()
end

function BattleSceneLoader:StopTimelineLoop()
  if self.animTimelinePlayer and not self.aniTimeLineStop then
    self.animTimelinePlayer:StopLooping()
    self.aniTimeLineStop = true
  end
end

function BattleSceneLoader:OnResourcesLoadedFinished()
  self.isResourcesLoadedFinished = true
  self:StopTimelineLoop()
  self:CheckAllDone()
end

function BattleSceneLoader:OnBattleSceneLoaded()
  self.curBattleSceneStatus = UnitySceneStatus(self.scenepath)
  self.curBattleSceneStatus:Hide()
  self:OnBattleDataReady()
  local BattleManager = BattleManager.Instance
  if not BattleManager.isRunInServer and BattleManager.battleEngine.StartBattle then
    self.curBattleSceneStatus:Show()
    BattleManager.battleScene:OnSceneLoaded()
    BattleManager.Instance:ReqStartBattle()
  end
  if SettingManager.Instance:IsCloseBattleBgMovement() then
    self:CloseSceneBgMovement()
    self._closeScenceBgMoveTimer = TimerManager.Instance:CreateTimer(1, 0, nil, function()
      self._closeScenceBgMoveTimer = nil
      self:CloseSceneBgMovement()
    end)
  end
end

function BattleSceneLoader:CloseSceneBgMovement()
  local sceneGameObj = CS.UnityEngine.GameObject.Find("Scenes")
  if not sceneGameObj then
    return
  end
  local rendererList = sceneGameObj:GetComponentsInChildren(typeof(CS.UnityEngine.MeshRenderer))
  for i = 0, rendererList.Length - 1 do
    local renderer = rendererList[i]
    if renderer then
      local material = renderer.sharedMaterial
      if material and not IsNil(material) and material:HasProperty(speedId) then
        local mpb = MaterialPropertyBlock()
        mpb:SetFloat(speedId, 0)
        renderer:SetPropertyBlock(mpb)
      end
    end
  end
end

function BattleSceneLoader:OnBattleDataReady()
  if not (bg.battleDataCenter and bg.battleDataCenter.isInit) or not self.isSceneLoaded then
    return
  end
  EventMgr.Instance.BattleData:RemoveEvent(System.fn(self, self.OnBattleDataReady))
  self.assetsPath = {}
  self:PrepareCommonAssets(self.assetsPath)
  if self.assetsLoader then
    self.assetsLoader:Load(self.assetsPath, function()
      self:OnResourcesLoadedFinished()
    end)
  end
end

function BattleSceneLoader:CheckAllDone()
  if not (self.isResourcesLoadedFinished and self.isTimelineAnimFinished) or not self.isSceneLoaded then
    return
  end
  if not ShadersWarmUpMgr.Instance:IsShaderWarmupFinish() then
    WaitingView.Instance:Show(self._shaderWarmupKey, WaitingView.Flag_WarmUpShaders)
    WaitingView.Instance:SetDelayShowTime(0)
    ShadersWarmUpMgr.Instance:SetShaderWarmupFinishCB(function()
      self:CheckAllDone()
    end)
    return
  end
  self:_ClearLoader()
  ResGcMgr.Instance:Gc()
  WaitingView.Instance:Hide(self, WaitingView.Flag_BattleSceneLoading)
  WaitingView.Instance:Hide(self._shaderWarmupKey, WaitingView.Flag_WarmUpShaders)
  if self.curBattleSceneStatus then
    self.curBattleSceneStatus:Show()
  end
  if self.onFinishedCallabck then
    self.onFinishedCallabck()
    self.onFinishedCallabck = nil
  end
end

function BattleSceneLoader:PlayWorldStageMainPanelClosedAnim()
  local window = UIManager.Instance:GetWindow(Urls.WorldStageMainPanel)
  if window and window.ui and window.ui.uiNode then
    local animCtrl = window.ui.uiNode:GetComponent(typeof(CS.Z1Client.UIAnimationController))
    animCtrl:PlayState("UI_Dbgcopy_Panel_Main_New_Close")
  end
end

function BattleSceneLoader:Clear()
  if self.animTimelinePlayer then
    self.animTimelinePlayer:Dispose()
    self.animTimelinePlayer = nil
  end
  if self._closeScenceBgMoveTimer then
    TimerManager.Instance:StopTimer(self._closeScenceBgMoveTimer)
    self._closeScenceBgMoveTimer = nil
  end
  self:_ClearLoader()
  self.isStartLoaded = false
  WaitingView.Instance:Hide(self, WaitingView.Flag_BattleSceneLoading)
  EventMgr.Instance.BattleData:RemoveEvent(System.fn(self, self.OnBattleDataReady))
  Super.Clear(self)
end

function BattleSceneLoader:_ClearLoader()
  if self._timelineTimer then
    TimerManager.Instance:StopTimer(self._timelineTimer)
    self._timelineTimer = nil
  end
  self:_StopSafeTimer()
  local blackScreenGo = CS.UnityEngine.GameObject.Find("BlackScreen(Clone)")
  if blackScreenGo then
    blackScreenGo:SetActive(false)
  end
end

function BattleSceneLoader:_StartSafeTimer()
  if self._safeTimer then
    return
  end
  self._safeTimer = TimerManager.Instance:CreateTimer(5, -1, function()
    self:_CheckLoadingStatus()
  end)
end

function BattleSceneLoader:_StopSafeTimer()
  if not self._safeTimer then
    return
  end
  TimerManager.Instance:StopTimer(self._safeTimer)
  self._safeTimer = nil
end

function BattleSceneLoader:_CheckLoadingStatus()
  if bg.isPVP and PvPSettleDataUtils.GetSettleData() then
    self:_StopSafeTimer()
    PvpController.Instance:OpenPvpSettlePanels()
    return
  end
  local WorldRecoveryManager = WorldRecoveryManager.Instance
  if WorldRecoveryManager:IsStageExpiredByServer() or WorldRecoveryManager:IsWaitingAbyssResetConfirm() then
    Logger.Info("[BattleSceneLoader] abyss reset in progress, stop StartBattle retry")
    self:_StopSafeTimer()
    return
  end
  if not bg.battleDataCenter or not bg.battleDataCenter.isInit then
    Logger.ReportApusInfo("BattleSceneLoader {isDataInit}", "false")
    local BattleManager = BattleManager.Instance
    if BattleManager.battleEngine then
      BattleManager.Instance:ReqStartBattle()
    end
    return
  end
  if not self.isResourcesLoadedFinished then
    Logger.ReportApusInfo("BattleSceneLoader {isResLoad}", "false")
    return
  end
  if not self.isSceneLoaded then
    Logger.ReportApusInfo("BattleSceneLoader {isSceneLoaded}", "false")
    return
  end
end

return BattleSceneLoader
