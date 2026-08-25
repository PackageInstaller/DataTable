local AMPlayer = CS.AMTimeline.AMPlayer
local SceneManager = CS.UnityEngine.SceneManagement.SceneManager
local T_CinemachineBrain = typeof(CS.Cinemachine.CinemachineBrain)
local UnityBattleSceneMgr = System.NewClass("UnityBattleSceneMgr")

function UnityBattleSceneMgr:ctor(battleScene, battleSceneCfg)
  self.battleScene = battleScene
  self.battleSceneCfg = battleSceneCfg
  self.timelineConfig = TimelineConfig()
  
  function CS.AMTimeline.AMPlayer.onAMLoadScene(sceneName)
    self.timelineLoadedScene = self.timelineLoadedScene or {}
    self.timelineLoadedScene[sceneName] = true
  end
  
  self.mainCamera = CS.UnityEngine.GameObject.Find("Main Camera")
  self.hideBattleSceneRef = 0
end

function UnityBattleSceneMgr.UnLoadAllBattleScenes()
  local sceneList = {}
  local sceneCount = SceneManager.sceneCount - 1
  for i = 0, sceneCount do
    table.insert(sceneList, SceneManager.GetSceneAt(i))
  end
  for i = 1, #sceneList do
    local scene = sceneList[i]
    if scene:IsValid() and scene.isLoaded and (string.find(scene.path, "Assets/ArtRes/BScene") or string.find(scene.path, "Assets/ArtRes/AScene") or string.find(scene.path, "Assets/ArtRes/PScene")) then
      pcall(ResLoadMgr.UnLoadScene, scene.path)
      pcall(SceneManager.UnloadSceneAsync, scene.path)
    end
  end
  Logger.ReportApusInfo("UnLoadAllBattleScenes")
end

function UnityBattleSceneMgr.UnLoadAllBattleResources()
  UnityBattleSceneMgr.DetachAllChildren("SceneRoot/BattleScene/SceneLayer")
  UnityBattleSceneMgr.DetachAllChildren("SceneRoot/BattleScene/UILayer")
  UnityBattleSceneMgr.DetachAllChildren("SceneRoot/BattleScene/BgLayer")
  local battleMgr = BattleManager.Instance
  if battleMgr and battleMgr.battleSceneLoader then
    battleMgr.battleSceneLoader:Clear()
    battleMgr.battleSceneLoader = nil
  end
  if battleMgr and battleMgr.battleSceneLoader then
    battleMgr.battleSceneLoader:Clear()
    battleMgr.battleSceneLoader = nil
  end
  BattleAssetPreloader.Instance:Clear()
end

function UnityBattleSceneMgr.DetachAllChildren(nodeName)
  local node = CS.UnityEngine.GameObject.Find(nodeName)
  if not node then
    return
  end
  local tf = node.transform
  local cnt = tf.childCount
  for i = cnt - 1, 0, -1 do
    local go = tf:GetChild(i).gameObject
    Destroy(go)
  end
end

function UnityBattleSceneMgr:IsCameraValid(cameraName)
  if self.unityBattleScene then
    do return self.unityBattleScene.IsCameraValid, self.unityBattleScene end
    return self.unityBattleScene.IsCameraValid, self.unityBattleScene, cameraName
  end
end

function UnityBattleSceneMgr:ChangeDefaultVMCamera()
  if self.unityBattleScene then
    self.unityBattleScene:ChangeDefaultCamera()
  end
  if self.superDimensionScene then
    self.superDimensionScene:ChangeDefaultCamera()
  end
  self:ResetVMCamera()
end

function UnityBattleSceneMgr:ResetVMCamera()
  local brain = self.mainCamera:GetComponent(T_CinemachineBrain)
  local defaultBlend
  if brain then
    defaultBlend = brain.m_DefaultBlend
    DestroyImmediate(brain)
  end
  brain = self.mainCamera:AddComponent(T_CinemachineBrain)
  if defaultBlend then
    brain.m_DefaultBlend = defaultBlend
  end
  brain:ManualUpdate()
end

function UnityBattleSceneMgr:ShowScene(showed)
  if showed then
    if self.hideBattleSceneRef <= 0 then
      Logger.Error("UnityBattleSceneMgr:ShowScene 错误，需要先隐藏才能触发显示=", debug.traceback())
    else
      self.hideBattleSceneRef = self.hideBattleSceneRef - 1
    end
    if 0 == self.hideBattleSceneRef then
      self:ShowAllUnityBattleScenes(true)
    end
  else
    self.hideBattleSceneRef = self.hideBattleSceneRef + 1
    if 1 == self.hideBattleSceneRef then
      self:ShowAllUnityBattleScenes(false)
    end
  end
end

function UnityBattleSceneMgr:HideSceneEffects()
  if self.unityBattleScene then
    self.unityBattleScene:HideSceneEffects()
  end
end

function UnityBattleSceneMgr:TryShowUnityBattleScene(sceneHelper)
  if not sceneHelper then
    return
  end
  if self.hideBattleSceneRef > 0 then
    self:ShowUnityBattleScene(sceneHelper, false)
  else
    self:ShowUnityBattleScene(sceneHelper, true)
  end
end

function UnityBattleSceneMgr:ShowAllUnityBattleScenes(showed)
  self:ShowUnityBattleScene(self.unityBattleScene, showed)
  self:ShowUnityBattleScene(self.curTimelineBattleScene, showed)
  self:ShowUnityBattleScene(self.superDimensionScene, showed)
end

function UnityBattleSceneMgr:ShowUnityBattleScene(sceneHelper, showed)
  if not sceneHelper then
    return
  end
  sceneHelper:ShowScene(showed)
end

function UnityBattleSceneMgr:OnBattleSceneLoaded()
  self.unityBattleScene = UnityBattleSceneHelper(self.battleScene, self.battleSceneCfg.BattleScene)
  self.unityBattleScene:LoadSceneAsync(function()
    self.unityBattleScene:Show()
    self.unityBattleScene:BindToBattleScene()
    self:TryShowUnityBattleScene(self.unityBattleScene)
  end)
end

function UnityBattleSceneMgr:ActiveBattleScene(battleSceneHelper, scenePath, callabck)
  battleSceneHelper:LoadSceneAsync(function()
    if not self.unityBattleScene then
      local scene = SceneManager.GetSceneByPath(scenePath)
      if scene:IsValid() and scene.isLoaded then
        SceneManager.UnloadSceneAsync(scenePath)
      end
      return
    end
    if callabck then
      callabck()
    end
    self.unityBattleScene:Hide()
    self.unityBattleScene:EnableApplyDepthFog(false)
    battleSceneHelper:BindToBattleScene()
    battleSceneHelper:EnableApplyDepthFog(self.battleScene:IsApplyDepthFogEnable())
    battleSceneHelper:Show()
    self:TryShowUnityBattleScene(battleSceneHelper)
  end)
end

function UnityBattleSceneMgr:EnableApplyDepthFog(enable)
  if self.unityBattleScene then
    self.unityBattleScene:EnableApplyDepthFog(enable)
  end
end

function UnityBattleSceneMgr:ChangeBattleScene(scenePath, timelineUrl)
  if not scenePath or "None" == scenePath then
    self:ExitTimelineBattleScene()
    return function()
      if self.unityBattleScene then
        self.unityBattleScene:ApplyMianCameraToCMVMainPose(self.mainCamera)
      end
    end
  else
    self:CreateTimelineBattleScene(scenePath)
    self.timelineUrl = timelineUrl
    self:ActiveBattleScene(self.curTimelineBattleScene, scenePath)
    return function()
      if self.curTimelineBattleScene then
        self.curTimelineBattleScene:ApplyMianCameraToCMVMainPose(self.mainCamera)
      end
    end
  end
end

function UnityBattleSceneMgr:CreateTimelineBattleScene(scenePath)
  if self.curTimelineBattleScene and self.curTimelineBattleScene.assetPath == scenePath then
    return
  end
  self:DestroyTimelineBattleScene()
  self.curTimelineBattleScene = UnityBattleSceneHelper(self.battleScene, scenePath)
end

function UnityBattleSceneMgr:DestroyTimelineBattleScene()
  if self.curTimelineBattleScene then
    self.curTimelineBattleScene:Hide()
    self.curTimelineBattleScene:UnloadScene()
  end
  self.curTimelineBattleScene = nil
end

function UnityBattleSceneMgr:ExitTimelineBattleScene()
  if self.unityBattleScene then
    self.unityBattleScene:ActiveScene()
    self.unityBattleScene:Show()
    self.unityBattleScene:BindToBattleScene()
    self:TryShowUnityBattleScene(self.unityBattleScene)
  end
  self.timelineUrl = nil
  self:DestroyTimelineBattleScene()
end

function UnityBattleSceneMgr:StartExitTimelineBattleScene()
  if not self.timelineUrl then
    return
  end
  self.awaiterAnimFinished = Awaiter.Get()
  EventMgr.Instance.AnimAwaiterArise:Dispatch(self.awaiterAnimFinished, "ExitTimelineBattleScene")
  if not bg.battleScene:HasAwakerPlayingSkill() then
    self:ClearExitTimers()
    self:PlayExitTimeline()
    return
  end
  
  local function DelayExitBattleScene()
    if self.delayExitTimerId and not bg.battleScene:HasAwakerPlayingSkill() then
      self:ClearExitTimers()
      self:PlayExitTimeline()
    end
  end
  
  self.delayExitTimerId = TimerManager.Instance:CreateTimer(0.001, -1, DelayExitBattleScene, DelayExitBattleScene)
end

function UnityBattleSceneMgr:PlayExitTimeline()
  if not self.timelineUrl then
    return
  end
  self.timelineConfig:Reset()
  self.timelineConfig.assetPath = self.timelineUrl
  
  function self.timelineConfig.onComplete()
    if self.awaiterAnimFinished then
      self.awaiterAnimFinished:SetCompleted()
    end
    self:Temp_UnLoadSuperDimensionScene()
    self:UnLoadTimelineLoadScenes()
  end
  
  function self.timelineConfig.onEvent(eventId, eventParam)
    if not self.timelinePlayer then
      return
    end
    if eventId == rc.TimeLineEvent.SceneTransEvent then
      self:ExitTimelineBattleScene()
    elseif eventId == rc.TimeLineEvent.SceneControlEvent then
      self:ExitTimelineBattleScene()
    end
  end
  
  if not self.timelinePlayerGo then
    self.timelinePlayerGo = CS.UnityEngine.GameObject("SceneTransTimeline")
    CS.AMTimeline.AMDontDestroyOnLoad.Get(self.timelinePlayerGo)
    self.timelinePlayer = TimelinePlayer(self.timelinePlayerGo)
  end
  self.timelinePlayer:Stop()
  self.timelinePlayer:Play(self.timelineConfig)
end

function UnityBattleSceneMgr:ClearExitTimers()
  if self.delayExitTimerId then
    TimerManager.Instance:StopTimer(self.delayExitTimerId)
    self.delayExitTimerId = nil
  end
end

function UnityBattleSceneMgr:EnterDimensionScene(scenePath)
  self.timelineUrl = nil
  if not scenePath or "None" == scenePath then
    self:ExitDimensionScene()
    self:ResetVMCamera()
    bg.battleScene.cameraComp:PlayUniversalCycle()
    return function()
      if self.unityBattleScene then
        self.unityBattleScene:ApplyMianCameraToCMVMainPose(self.mainCamera)
      end
    end
  else
    self:CreateSuperDimension(scenePath)
    self:ActiveBattleScene(self.superDimensionScene, scenePath, function()
      self:DestroyTimelineBattleScene()
    end)
    AMPlayer.DisableSceneTrans = true
    self:ResetVMCamera()
    return function()
      if self.superDimensionScene then
        self.superDimensionScene:ApplyMianCameraToCMVMainPose(self.mainCamera)
      end
    end
  end
end

function UnityBattleSceneMgr:ExitDimensionScene()
  if self.unityBattleScene then
    self.unityBattleScene:ActiveScene()
    self.unityBattleScene:Show()
    self.unityBattleScene:BindToBattleScene()
    self:TryShowUnityBattleScene(self.unityBattleScene)
  end
  self.timelineUrl = nil
  self:DestroySuperDimension()
  AMPlayer.DisableSceneTrans = false
  BattleManager.Instance:ResetBattleQualitySetting()
end

function UnityBattleSceneMgr:CreateSuperDimension(scenePath)
  if self.superDimensionScene and self.superDimensionScene.assetPath == scenePath then
    return
  end
  self:DestroySuperDimension()
  self.superDimensionScene = UnityBattleSceneHelper(self.battleScene, scenePath)
end

function UnityBattleSceneMgr:DestroySuperDimension()
  if self.superDimensionScene then
    self.superDimensionScene:Hide()
    self.superDimensionScene:UnloadScene()
  end
  self.superDimensionScene = nil
end

function UnityBattleSceneMgr:Dispose()
  self.hideBattleSceneRef = 0
  if self.timelinePlayer then
    self.timelinePlayer:Stop()
    self.timelinePlayer = nil
  end
  if self.timelinePlayerGo then
    CS.UnityEngine.GameObject.Destroy(self.timelinePlayerGo)
    self.timelinePlayerGo = nil
  end
  self:DestroyTimelineBattleScene()
  self:DestroySuperDimension()
  self:Temp_UnLoadSuperDimensionScene()
  self:UnLoadTimelineLoadScenes()
  if self.unityBattleScene then
    self.unityBattleScene:UnloadScene()
    self.unityBattleScene = nil
  end
  UnityBattleSceneMgr.UnLoadAllBattleScenes()
  CS.AMTimeline.AMPlayer.onAMLoadScene = nil
  self.mainCamera = nil
end

function UnityBattleSceneMgr:Temp_UnLoadSuperDimensionScene()
end

function UnityBattleSceneMgr:UnLoadTimelineLoadScenes()
  if not self.timelineLoadedScene then
    return
  end
  for k, v in pairs(self.timelineLoadedScene) do
    local scenePath = k
    local scene = SceneManager.GetSceneByPath(scenePath)
    if scene and scene:IsValid() and scene.isLoaded then
      pcall(ResLoadMgr.UnLoadScene, scenePath)
      pcall(SceneManager.UnloadSceneAsync, scenePath)
    end
  end
  self.timelineLoadedScene = nil
end

return UnityBattleSceneMgr
