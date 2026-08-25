local DOTween = CS.DG.Tweening.DOTween
local MeshRenderer = typeof(CS.UnityEngine.MeshRenderer)
local SkinnedMeshRenderer = typeof(CS.UnityEngine.SkinnedMeshRenderer)
local Transform = typeof(CS.UnityEngine.Transform)
local BattleScene, Super = System.NewClass("BattleScene")
local DarkColor = CS.UnityEngine.Color(0.145, 0.145, 0.145, 1)

function BattleScene:ctor(battleId, uniqueSceneId)
  Super.ctor(self)
  ResGcMgr.Instance:SetInBattle(true)
  Logger.Info("#进入DbgBattleScene", battleId)
  bg.battleScene = self
  local DT = bg.DT
  self.binder = Vue.newBinder()
  self.binder.source = self
  self.binder:SetAssetTarget(self)
  self.roleList = {}
  self.tauntRoles = {}
  self.defaultTargetUid = {}
  self.activeAwaker = nil
  self.battleId = battleId
  self.battleCameraScheme = nil
  self.battleCfg = DT.BattleConfig[battleId]
  bg.mainCamera = CS.UnityEngine.Camera.main
  bg.uiCamera = CS.UnityEngine.GameObject.Find("UICamera"):GetComponent(typeof(CS.UnityEngine.Camera))
  local sceneID = uniqueSceneId or self.battleCfg.SceneID
  self.battleSceneCfg = DT.BattleSceneConfig[tonumber(sceneID)]
  if not self.battleSceneCfg then
    self.battleSceneCfg = DT.BattleSceneConfig[self.battleCfg.SceneID]
    assert(self.battleSceneCfg, string.format("BattleSceneCfg %s not found", self.battleCfg.SceneID))
  end
  local sceneRootNode = CS.UnityEngine.GameObject.Find("SceneRoot")
  self.rootNode = sceneRootNode.transform:Find("BattleScene")
  if nil == self.rootNode then
    local prefabBattleScene = ResLoadMgr.LoadAsset("GameBasePrefab/BattleScene.prefab", self)
    self.rootNode = CS.UnityEngine.GameObject.Instantiate(prefabBattleScene)
    self.rootNode.name = "BattleScene"
    self.rootNode.transform:SetParent(sceneRootNode.transform)
  end
  self.factoryLayer = self.rootNode.transform:Find("FactoryLayer")
  self.sceneLayer = self.rootNode.transform:Find("SceneLayer")
  self.sceneLayer.localScale = CS.UnityEngine.Vector3.one
  self.uiLayer = self.rootNode.transform:Find("UILayer")
  self.uiEffectLayer = self.rootNode.transform:Find("UIEffectLayer")
  self.binder:SetCanvasGroup(self.uiLayer, 0)
  local uiCanvas = self.uiLayer:GetComponent(typeof(CS.UnityEngine.Canvas))
  local uiEffCanvas = self.uiEffectLayer:GetComponent(typeof(CS.UnityEngine.Canvas))
  uiCanvas.worldCamera = bg.uiCamera
  uiEffCanvas.worldCamera = bg.uiCamera
  bg.battleRender.sfxMgr:SetRoot(self.factoryLayer)
  CS.UnityEngine.Input.multiTouchEnabled = false
  self._isApplyDepthFogEnabled = false
  self.battleSceneMgr = UnityBattleSceneMgr(self, self.battleSceneCfg)
  self.binder:BindEvent(EventMgr.Instance.CSSendEvent, System.fn(self, self.OnCSSendEvent))
  self.binder:BindEvent(EventMgr.Instance.CSSendEventStr, System.fn(self, self.OnCSSendEventStr))
  self.binder:BindEvent(EventMgr.Instance.PVPViewChange, System.fn(self, self.OnPVPViewChange))
  GlobalDispatcher:AddListener(NotifyId.OnWindowsResolutionChange, self._OnWindowsResolutionChange, self)
  bg.SendBattleEvent(rc.BattleEvent.BattleUIOpen, self.__name)
  BattleCardShotcutDragDropMgr.Instance:Dispose()
end

function BattleScene:LoadAudioBank()
  AudioManager.Instance:SetListenerOffsetPosition(0, 0, 0)
end

function BattleScene:Tick(deltaTime)
  for _, role in ipairs(self.roleList) do
    role:Tick(deltaTime)
  end
  BattleKeeperSkillAssetCache.Instance:Update()
end

function BattleScene:ChangeDefaultVMCamera(battleCameraScheme)
  self.battleCameraScheme = battleCameraScheme
  if self.battleSceneMgr then
    self.battleSceneMgr:ChangeDefaultVMCamera()
    if battleCameraScheme and self.battleSceneMgr:IsCameraValid(battleCameraScheme) then
      BattleCameraDataUtils.SaveCamera(battleCameraScheme)
    end
  end
end

function BattleScene:Dispose()
  BattleCardShotcutDragDropMgr.Instance:Dispose()
  if self.abortController then
    self.abortController:Abort()
  end
  GlobalDispatcher:RemoveListener(NotifyId.OnWindowsResolutionChange, self._OnWindowsResolutionChange, self)
  bg.SendBattleEvent(rc.BattleEvent.BattleSceneDispose, "start")
  CS.UnityEngine.Input.multiTouchEnabled = true
  if self.finishFlow then
    self.finishFlow:Dispose()
    self.finishFlow = nil
  end
  TimelineShaderGlobalController.Instance:Stop()
  UIManager.Instance:CloseByUrl(Urls.DbgBattlePanel)
  UIManager.Instance:CloseByUrl(Urls.FuncBattleCardDisplayPanel)
  UIManager.Instance:CloseByUrl(Urls.AlertToolTipsPanel)
  UIManager.Instance:CloseByUrl(Urls.AlertIconToolTipsPanel)
  if self.cameraComp then
    self.cameraComp:Dispose()
  end
  for _, role in ipairs(self.roleList) do
    xpcall(function()
      role:Dispose()
    end, debug.traceback)
  end
  self.binder:teardown()
  self.binder = nil
  bg.battleScene = nil
  DOTweenUtils.KillAllTweensByTarget(self)
  if self.SuperDimensionTimelinePlayer then
    self.SuperDimensionTimelinePlayer:Dispose()
    self.SuperDimensionTimelinePlayer = nil
  end
  PerformanceManager.Instance:EnablePostProcessing(false)
  ResLoadMgr.UnloadAssetByTarget(self)
  self:StopBattleBGM()
  self.battleSceneMgr:Dispose()
  self.battleSceneMgr = nil
  UnityBattleSceneMgr.UnLoadAllBattleScenes()
  CS.AMTimeline.AMResourcesCache.RemoveUnusedResources()
  bg.SendBattleEvent(rc.BattleEvent.BattleSceneDispose, "RemoveUnusedResources")
  print("BattleScene:Dispose Clear Pool")
  Pool.Clear()
  ResGcMgr.Instance:SetInBattle(false)
end

function BattleScene:SafeDispose()
  bg.battleScene = nil
  DOTweenUtils.KillAllTweensByTarget(self)
  ResLoadMgr.UnloadAssetByTarget(self)
  self:StopBattleBGM()
  self.battleSceneMgr:Dispose()
  self.battleSceneMgr = nil
  UnityBattleSceneMgr.UnLoadAllBattleScenes()
  CS.AMTimeline.AMResourcesCache.RemoveUnusedResources()
end

function BattleScene:Preload()
  BattleAwakerUltiSkillPainting.Preload(self.factoryLayer)
  BattleAwakerSuperUltiSkillPainting.Preload(self.factoryLayer)
  RoleFloatingText.Preload(self.factoryLayer)
end

function BattleScene:OnSceneLoaded()
  self.battleSceneMgr:OnBattleSceneLoaded()
  PerformanceManager.Instance:EnablePostProcessing(true)
  self:Preload()
  self:_ApplyBattleCameraAdaptation(false)
end

function BattleScene:OnStartBattle()
  self:ResetAllSlashProgressBeforeBattle()
  if bg.isPVE then
    UIManager.Instance:Show(Urls.DbgBattlePanel)
  elseif bg.isPVP then
    EmojiController.Instance:SetEnemyEmojiState(true)
    if bg.isReplay then
      UIManager.Instance:Reopen(Urls.PvPBattleOppsiteMainPanel)
    end
    UIManager.Instance:Reopen(Urls.PvPBattleMainPanel)
    if bg.isPVP_TRAIN then
      UIManager.Instance:Reopen(Urls.PvPBattleTrainPanel)
    end
  end
  for _, role in pairs(self.roleList or {}) do
    role:OnEnterBattle()
  end
  if self:IsSuperDimensionSchool() then
    self.SuperDimensionTimelinePlayer = SuperDimensionTimelinePlayer()
    self.SuperDimensionTimelinePlayer:Prepare()
  end
end

function BattleScene:ResetAllSlashProgressBeforeBattle()
  local sceneRootNode = CS.UnityEngine.GameObject.Find("SceneRoot")
  if not sceneRootNode then
    return
  end
  local rootTransform = sceneRootNode.transform
  local allTransforms = rootTransform:GetComponentsInChildren(Transform, true)
  local SlashProgressPropertyId = CS.UnityEngine.Shader.PropertyToID("_SlashProgress")
  if not allTransforms then
    return
  end
  for i = 0, allTransforms.Length - 1 do
    local phaseNode = allTransforms[i]
    if phaseNode and phaseNode.name == "Phase_1" then
      local meshRenderers = phaseNode:GetComponentsInChildren(MeshRenderer, true)
      if meshRenderers then
        for j = 0, meshRenderers.Length - 1 do
          local renderer = meshRenderers[j]
          if renderer and renderer.sharedMaterials then
            local mats = renderer.sharedMaterials
            for k = 0, mats.Length - 1 do
              local mat = mats[k]
              if mat and mat:HasProperty(SlashProgressPropertyId) then
                mat:SetFloat(SlashProgressPropertyId, 0)
              end
            end
          end
        end
      end
      local skinnedMeshRenderers = phaseNode:GetComponentsInChildren(SkinnedMeshRenderer, true)
      if skinnedMeshRenderers then
        for j = 0, skinnedMeshRenderers.Length - 1 do
          local renderer = skinnedMeshRenderers[j]
          if renderer and renderer.sharedMaterials then
            local mats = renderer.sharedMaterials
            for k = 0, mats.Length - 1 do
              local mat = mats[k]
              if mat and mat:HasProperty(SlashProgressPropertyId) then
                mat:SetFloat(SlashProgressPropertyId, 0)
              end
            end
          end
        end
      end
    end
  end
end

function BattleScene:IsSuperDimensionSchool()
  local playerRole = self:GetPlayerRole()
  local dimensionSlot = playerRole:GetProperty(bc.RoleProperty.dimension_slot) or 0
  if dimensionSlot > 0 then
    return true
  end
end

function BattleScene:OnBattleBegin()
end

function BattleScene:SetBattleUIVisible()
  self.binder:SetCanvasGroup(self.uiLayer, 1)
  self:UpdateRootHpAndRootIntentionPosition()
end

function BattleScene:HideBattleUI()
  self.binder:SetCanvasGroup(self.uiLayer, 0)
end

function BattleScene:OnBattleRecover()
  self.binder:SetCanvasGroup(self.uiLayer, 1)
  BattlePerformanceUtil.ShowBlackScreenGo()
  bg.SetIsDelayHideBlack(true)
end

function BattleScene:InitAudio()
  Logger.Info("BattleScene:InitAudio()")
  AudioManager.Instance:SetListenerOffsetMode(true)
  AudioManager.Instance:UpdateListenerPos()
  self:LoadAudioBank()
end

function BattleScene:OnBattleFinish(winCamp, battleFinishData, isShow)
  bg.battlePanel:OnBattleFinish(winCamp)
  if bg.isPVE then
    self.finishFlow = PVEFinishFlow():Start(winCamp, battleFinishData, isShow)
  elseif bg.isPVP then
    self.finishFlow = PVPFinishFlow():Start(winCamp, battleFinishData)
  end
end

function BattleScene:RestartBattle(isMunalRestart, skipStory)
  if not bg.battleRender then
    return
  end
  if bg.battleRender.recordMgr.isReceivedBattleWin then
    Logger.ReportApusInfo("已经收到战斗胜利消息，不让重开")
    return
  end
  if self.finishFlow then
    self.finishFlow:Dispose()
    self.finishFlow = nil
  end
  BattleManager.Instance:DisposeCurrentBattle()
  BattleManager.Instance:MarkRestartPending()
  UIManager.Instance:CloseAllExcept()
  TimerManager.Instance:CreateTimer(1, 0, nil, function()
    BattleManager.Instance:ClearRestartPending()
    if bg.battleRender then
      return
    end
    BattleManager.Instance:EnterBattle(bg.battleData, nil, isMunalRestart, skipStory)
  end)
  SettingManager.Instance:SetAutoFight(false)
end

function BattleScene:OnBattleFinishOverTime()
  if self.finishFlow then
    self.finishFlow:RunAll()
  end
end

function BattleScene:ClearPvP()
  UIManager.Instance:CloseAllExcept({
    Urls.PvPMatchPanel,
    Urls.MainPanel
  })
  local isReplay = bg.isReplay
  BattleManager.Instance:DisposeCurrentBattle()
  UnityBattleSceneMgr.UnLoadAllBattleResources()
  if bg.battleData.isLogin then
    SceneMgr.Instance:EnterLogin()
  elseif isReplay then
    SceneMgr.Instance:EnterNull()
  elseif PvPSettleDataUtils.IsGotoTown() then
    SceneMgr.Instance:EnterTown()
  else
    SceneMgr.Instance:EnterNull()
    UIManager.Instance:Reopen(Urls.MainPanelPVP)
  end
end

function BattleScene:GetChildBinder()
  local childBinder = self.binder:createChild()
  return childBinder
end

function BattleScene:GetUILayer()
  return self.uiLayer
end

function BattleScene:GetUIEffectLayer()
  return self.uiEffectLayer
end

function BattleScene:GetSfxAttachmentPointByName(name, camp)
  if "Ace" == name then
    do return self.GetSfxAttachmentPoint, self end
    return self.GetSfxAttachmentPoint, self, camp
  elseif "Sfx" == name then
    if camp == bc.BattleCamp.Camp1 then
      return self.camp1SfxPoint
    elseif camp == bc.BattleCamp.Camp2 then
      return self.camp2SfxPoint
    end
  elseif "root" == name then
    return self.rootNode.transform
  elseif "own" == name then
    return camp == bc.BattleCamp.Camp1 and self.camp1SfxPoint or self.camp2SfxPoint
  elseif "enemy" == name then
    return camp == bc.BattleCamp.Camp2 and self.camp1SfxPoint or self.camp2SfxPoint
  end
  return self.rootNode.transform
end

function BattleScene:GetSpawnPointsMap(camp)
  local isMyCamp = bg.battleDataCenter:IsMyCamp(camp)
  if 2 == bg.battleData.pvpDir then
    isMyCamp = not isMyCamp
  end
  return self.spawnPointMap[isMyCamp and bc.SpawnPointDir.LEFT or bc.SpawnPointDir.RIGHT]
end

function BattleScene:GetSpawnPoint(camp, pointIndex)
  local pointMap = self:GetSpawnPointsMap(camp)
  return pointMap and pointMap[pointIndex]
end

function BattleScene:GetSfxAttachmentPoint(camp)
  if camp == bc.BattleCamp.Camp1 then
    return self.camp1SfxPoint
  elseif camp == bc.BattleCamp.Camp2 then
    return self.camp2SfxPoint
  end
end

function BattleScene:GetSpawnPointOrder(camp, point)
  if camp == bc.BattleCamp.Camp1 then
    return self.spawnPointToOrder[bc.BattleCamp.Camp1][point]
  elseif camp == bc.BattleCamp.Camp2 then
    return self.spawnPointToOrder[bc.BattleCamp.Camp2][point]
  end
end

function BattleScene:UpdateRootHpAndRootIntentionPosition()
  for k, v in pairs(self.roleList or {}) do
    if v.statusUI then
      v.statusUI:UpdateRootHpAndRootIntentionPosition()
    end
  end
end

function BattleScene:UpdateAwakerPositionShift()
  if not self.roleList then
    return
  end
  local camNums = {}
  for _, v in pairs(self.roleList) do
    camNums[v.camp] = (camNums[v.camp] or 0) + (v.awakerNum or 0)
  end
  for _, v in pairs(self.roleList) do
    local awakerNum = camNums[v.camp] or 1
    for _, v1 in pairs(v.awakerList or {}) do
      v1.spineComp:SetPosition(awakerNum - 1)
    end
  end
end

function BattleScene:ClearBeforeStartTimeline()
end

function BattleScene:SetCurTimelinePlayer(awakerClinet)
  self.curTimelinePlayer = awakerClinet
end

function BattleScene:OnCSSendEvent(eventName, eventValue)
  if "BattleHideFriend" == eventName then
    local isHide = 1 == eventValue
    local curPlayerCamp = self:GetCurTimeLinePlayerCamp()
    self:BattleHideCamp(isHide, function(role)
      return role.camp == curPlayerCamp
    end)
  elseif "BattleHideEnemy" == eventName then
    local isHide = 1 == eventValue
    local curPlayerCamp = self:GetCurTimeLinePlayerCamp()
    self:BattleHideCamp(isHide, function(role, camp)
      return role.camp ~= curPlayerCamp
    end)
  elseif "BattleAwakerVisbleTLEnable" == eventName then
    self:BattleAwakerVisbleTLEnable()
  elseif "GlobalHideStateUI" == eventName then
    self:GlobalHideStateUI(eventValue)
  end
end

function BattleScene:OnCSSendEventStr(eventName, eventValue1, eventValue2)
  if "BattleUIControl" == eventName then
    self:BattleUIControl(eventValue1, eventValue2)
  end
end

function BattleScene:OnPVPViewChange(viewCamp, isOpposite)
  if not isOpposite then
    self.sceneLayer.localScale = CS.UnityEngine.Vector3(1, 1, 1)
  else
    self.sceneLayer.localScale = CS.UnityEngine.Vector3(-1, 1, 1)
  end
  self:UpdateRootHpAndRootIntentionPosition()
end

function BattleScene:BattleUIControl(eventValue1, eventValue2)
  local functionName = eventValue1
  local functionParam = eventValue2
  local func = BattleTimelineControlUtil[functionName]
  if func then
    func(functionParam)
  end
end

function BattleScene:GlobalHideStateUI(eventValue)
  local hideIntentionInt = eventValue % 10
  local hideBloodInt = eventValue - hideIntentionInt
  local bBloodVisible = hideBloodInt <= 0
  local bIntentionVisible = hideIntentionInt <= 0
  local roleList = bg.battleScene.roleList or {}
  for _, role in ipairs(roleList) do
    if role.statusUI then
      role.statusUI:SetBloodActive(bBloodVisible)
      role.statusUI:SetIntentionActive(bIntentionVisible)
    end
  end
end

function BattleScene:GetCurTimeLinePlayerCamp()
  local boutMgr = bg.battleRender and bg.battleRender.boutMgr or nil
  local camp = boutMgr and boutMgr:GetCamp() or bc.BattleCamp.Camp2
  return camp
end

function BattleScene:BattleHideCamp(isHide, compareCall)
  local bVisible = not isHide
  for _, role in ipairs(self.roleList) do
    local compareResult = compareCall(role)
    for _, awaker in ipairs(role.awakerList) do
      local isMatch = awaker ~= self.curTimelinePlayer and compareResult
      if isMatch then
        awaker:SetActive(bVisible)
      end
    end
    if compareResult and role.statusUI then
      role.statusUI:SetActiveWithIntention(bVisible)
    end
  end
end

function BattleScene:BattleHideEnemy(isHide)
  local curPlayerCamp = self:GetCurTimeLinePlayerCamp()
  self:BattleHideCamp(isHide, function(role, camp)
    return role.camp ~= curPlayerCamp
  end)
end

function BattleScene:BattleHideFriend(isHide)
  local curPlayerCamp = self:GetCurTimeLinePlayerCamp()
  self:BattleHideCamp(isHide, function(role)
    return role.camp == curPlayerCamp
  end)
end

function BattleScene:BattleAwakerVisbleTLEnable()
  for _, role in ipairs(self.roleList) do
    for _, awaker in ipairs(role.awakerList) do
    end
  end
end

function BattleScene:GetRoleByUid(roleUid)
  for index, role in ipairs(self.roleList) do
    if role.uid == roleUid then
      return role
    end
  end
  return nil
end

function BattleScene:CreaterRole(roleData, spawnPoints)
  local role = self:GetRole(roleData.uid)
  if role then
    self:RemoveRole(roleData.uid)
  end
  local role = BattleRoleClient(roleData, spawnPoints)
  table.insert(self.roleList, role)
  return role
end

function BattleScene:SetPlayerRole(playerRole)
  self.playerRole = playerRole
end

function BattleScene:GetPlayerRole(campOrNil)
  if self.playerRole then
    return self.playerRole
  end
  local camp = campOrNil or bg.battleDataCenter:GetMyCamp()
  for _, role in ipairs(self.roleList) do
    if role.camp == camp and role.roleType == bc.RoleType.Player then
      return role
    end
  end
  return nil
end

function BattleScene:GetPlayerAwakerList()
  local playerRole = self:GetPlayerRole()
  if not playerRole then
    return {}
  end
  do return playerRole.GetAwakerList end
  return playerRole.GetAwakerList, playerRole
end

function BattleScene:GetRole(uidOrAwakerUid)
  for _, role in ipairs(self.roleList) do
    if role.uid == uidOrAwakerUid then
      return role
    end
  end
  return nil
end

function BattleScene:GetAwakerByUid(uid)
  for _, role in ipairs(self.roleList) do
    local awaker = role:GetAwakerByUid(uid)
    if awaker then
      return awaker
    end
    if role.uid == uid then
      local firstAwaker = role.awakerList[1]
      return firstAwaker
    end
  end
  return nil
end

function BattleScene:GetAllEntity()
  local list = {}
  for _, role in ipairs(self.roleList) do
    local awaker = role.awakerList[1]
    if awaker then
      table.insert(list, awaker)
    end
  end
  return list
end

function BattleScene:GetAwakerByTid(tid, camp)
  for _, role in ipairs(self.roleList) do
    for _, awaker in ipairs(role.awakerList or {}) do
      if awaker.tid == tid and awaker.camp == camp then
        return awaker
      end
    end
  end
  return nil
end

function BattleScene:GetPlayerRoleByCamp(camp)
  for _, role in ipairs(self.roleList) do
    if role.camp == camp and role.roleType == bc.RoleType.Player then
      return role
    end
  end
end

function BattleScene:GetAliveRoleListByCamp(camp)
  local list = {}
  for _, role in ipairs(self.roleList) do
    if role.camp == camp then
      table.insert(list, role)
    end
  end
  return list
end

function BattleScene:RemoveRole(roleUid)
  local role = self:GetRoleByUid(roleUid)
  if role then
    role:Dispose()
    for k, v in ipairs(self.roleList) do
      if v.uid == roleUid then
        table.remove(self.roleList, k)
      end
    end
  end
end

function BattleScene:SetActiveAwaker(awaker)
  self.activeAwaker = awaker
  if self._clearActiveAwakerTimer then
    bg.battleRender:UnperformWithDelay(self._clearActiveAwakerTimer)
  end
  if awaker then
    self._clearActiveAwakerTimer = bg.battleRender:PerformWithDelay(5, function()
      self.activeAwaker = nil
      self._clearActiveAwakerTimer = nil
    end)
  end
end

function BattleScene:CancelActiveAwaker(awaker)
  if self.activeAwaker == awaker then
    self.activeAwaker = nil
  end
end

function BattleScene:HasAwakerPlayingSkill()
  if self.activeAwaker and not self.activeAwaker.attackComplete then
    return true
  end
  if bg.isPVP then
    for _, role in pairs(self.roleList) do
      for _, awaker in ipairs(role.awakerList) do
        if not awaker.dead and awaker.fsmState == bc.AwakerFsmState.Attack then
          return true
        end
      end
    end
  end
end

function BattleScene:SwitchLight(isOn)
  if self.isLightOn == isOn then
    return
  end
  if self.amibentColorTweener then
    self.amibentColorTweener:Kill(true)
    self.amibentColorTweener = nil
    self.fogStrengthTweener:Kill(true)
    self.fogStrengthTweener = nil
  end
  local targetColor = DarkColor
  if isOn then
    targetColor = self.initAmbientColor
  end
  self.isLightOn = isOn
  local color = CS.UnityEngine.RenderSettings.ambientLight
  local duration = 0.05
  if not isOn then
    duration = 0.1
  end
  self.amibentColorTweener = DOTween.To(function()
    return color
  end, function(v)
    color = v
    CS.UnityEngine.RenderSettings.ambientLight = v
  end, targetColor, duration, self):OnComplete(function()
    self.amibentColorTweener = nil
  end)
  local fogStrength = 0
  local targetFogStrength = 1
  if not isOn then
    fogStrength = 1
    targetFogStrength = 0
  end
  self.fogStrengthTweener = DOTween.To(function()
    return fogStrength
  end, function(v)
    fogStrength = v
    CS.UnityEngine.RenderSettings.fogColor = fogStrength * self.initFogColor
  end, targetFogStrength, duration, self):OnComplete(function()
    self.fogStrengthTweener = nil
  end)
end

function BattleScene:PlaySfx(sfxConfigId, attachment, comp, castRoleUid)
  local position = attachment.position
  local parent = self.sceneLayer
  bg.battleRender.sfxMgr:CreateSfx(sfxConfigId, parent, position, false, nil, nil, 1, castRoleUid)
  BattleAudioUtil.PlaySfxAudio(sfxConfigId, comp)
end

function BattleScene:GetRandomAwaker()
  local indexList = {}
  for index, role in ipairs(self.roleList) do
    if role.roleType == bc.RoleType.Awaker then
      table.insert(indexList, index)
    end
  end
  local num = #indexList > 0 and math.random(1, #indexList) or 0
  local awaker = num > 0 and self.roleList[indexList[num]]:GetRandomAwaker()
  return awaker
end

function BattleScene:PlayRandomStartVoice()
  if IntroductionDataUtils.IsFinish() and bg.isPVE then
    local awaker = self:GetRandomAwaker()
    if awaker then
      awaker:PlayActionVoice(2000)
    end
  end
end

function BattleScene:PlayRandomVictoryVoice()
  local awaker = self:GetRandomAwaker()
  if awaker then
    awaker:PlayVictoryVoice()
  end
end

function BattleScene:GetRoleByTid(roleTid)
  for index, role in ipairs(self.roleList) do
    if role.tid == roleTid then
      return role
    end
  end
  return nil
end

function BattleScene:GetRoleListByCamp(camp, isExcluePlayer)
  local roleList = {}
  local isExcluePlayer = System.ToBool(isExcluePlayer, true)
  for _, role in ipairs(self.roleList) do
    if role.camp == camp then
      local isExclude = isExcluePlayer and role.roleType == bc.RoleType.Player
      if not isExclude then
        table.insert(roleList, role)
      end
    end
  end
  return roleList
end

function BattleScene:GetAliveRoleListByCamp(camp)
  local roleList = {}
  for index, role in ipairs(self.roleList) do
    if role.camp == camp and role:CheckIsRealDead() == false then
      table.insert(roleList, role)
    end
  end
  return roleList
end

function BattleScene:GetAliveAwakerList()
  local roleList = {}
  for index, role in ipairs(self.roleList) do
    if role:CheckIsRealDead() == false and role.roleType == bc.RoleType.Awaker then
      table.insert(roleList, role)
    end
  end
  return roleList
end

function BattleScene:GetAliveAwakerListByCamp(camp)
  local roleList = {}
  for index, role in ipairs(self.roleList) do
    if role.camp == camp and role:CheckIsRealDead() == false and role.roleType == bc.RoleType.Awaker then
      table.insert(roleList, role)
    end
  end
  return roleList
end

function BattleScene:GetAliveRandomAwakerByCamp(camp)
  local roleList = self:GetAliveAwakerListByCamp(camp)
  if not roleList or not table.next(roleList) then
    return nil
  end
  local targetIdx = math.random(1, #roleList)
  return roleList[targetIdx]
end

function BattleScene:GetAllAwakerList()
  local roleList = {}
  for index, role in ipairs(self.roleList) do
    if role.roleType == bc.RoleType.Awaker then
      table.insert(roleList, role)
    end
  end
  return roleList
end

function BattleScene:GetAwakerListByCamp(camp)
  local roleList = {}
  for index, role in ipairs(self.roleList) do
    if role.camp == camp and role.roleType == bc.RoleType.Awaker then
      table.insert(roleList, role)
    end
  end
  return roleList
end

function BattleScene:GetRoleListByTag(roleTypeTag, aliveTag, campTag)
  local rst = {}
  for index, role in ipairs(self.roleList) do
    if role.roleType ~= roleTypeTag then
    else
      local aliveMatch = self:Judgement_Alive(role, aliveTag)
      local campMatch = self:Judgement_Camp(role, campTag)
      if aliveMatch and campMatch then
        table.insert(rst, role)
      end
    end
  end
  return rst
end

function BattleScene:Judgement_Alive(role, aliveTag)
  local isDead = role:CheckIsRealDead()
  if isDead and aliveTag == bc.PVPTargetTag.AliveOnly then
    return false
  end
  if not isDead and aliveTag == bc.PVPTargetTag.DeathOnly then
    return false
  end
  return true
end

function BattleScene:Judgement_Camp(role, camp)
  if not camp or camp == bc.BattleCamp.None then
    return true
  end
  return role.camp == camp
end

function BattleScene:PlayAttackVoice(cardTid, castUid)
  Logger.Debug("[PlayAttackVoice] cardTid: %s", tostring(cardTid))
  local role = self:GetRoleByUid(castUid)
  local awaker = role and role:GetRandomAwaker()
  local DT = bg.DT
  if awaker and DT.Item[cardTid] and DT.Item[cardTid].CardTypes == bc.CardType.Attack then
    awaker:PlayAttackVoice(500)
  end
end

function BattleScene:SetTauntRole(roleUid, isTaunt)
  if not isTaunt or 0 == isTaunt then
    isTaunt = nil
  end
  self.tauntRoles[roleUid] = isTaunt
end

function BattleScene:GetTauntRoles()
  return self.tauntRoles
end

function BattleScene:GetTauntRoleByCamp(camp)
  for idx, role in pairs(self.roleList) do
    if role.camp ~= camp or role.roleType ~= bc.RoleType.Awaker or role:CheckIsRealDead() then
    else
      local stateList = bg.battleDataCenter.stateData:GetStateListByOwner(role.uid)
      for _, state in pairs(stateList) do
        if self:CheckIsTauntState(state.stateId) then
          return role
        end
      end
    end
  end
  return nil
end

function BattleScene:CheckIsTauntState(stateId)
  local stageCfg = DT.State[stateId]
  for propertyName in pairs(stageCfg.ExistProperty or {}) do
    if propertyName == bc.BattleProperty.taunt then
      return true
    end
  end
  return false
end

function BattleScene:CheckIsSneakState(stateId)
  local stageCfg = DT.State[stateId]
  for propertyName in pairs(stageCfg.ExistProperty or {}) do
    if propertyName == bc.BattleProperty.sneak then
      return true
    end
  end
  return false
end

function BattleScene:GetSneakRoleByCamp(camp)
  for idx, role in pairs(self.roleList) do
    if role.camp ~= camp or role.roleType ~= bc.RoleType.Awaker or role:CheckIsRealDead() then
    else
      local stateList = bg.battleDataCenter.stateData:GetStateListByOwner(role.uid)
      for _, state in pairs(stateList) do
        if self:CheckIsSneakState(state.stateId) then
          return role
        end
      end
    end
  end
  return nil
end

function BattleScene:HasSneakState(role)
  if not role or role:CheckIsRealDead() then
    return false
  end
  local stateList = bg.battleDataCenter.stateData:GetStateListByOwner(role.uid)
  for _, state in pairs(stateList) do
    if self:CheckIsSneakState(state.stateId) then
      return true
    end
  end
  return false
end

function BattleScene:SetDeafultTarget(roleUid, targetUid)
  self.defaultTargetUid[roleUid] = targetUid
end

function BattleScene:GetDefaultTarget(roleUid)
  do return self.GetRoleByUid, self end
  return self.GetRoleByUid, self, self.defaultTargetUid[roleUid]
end

function BattleScene:IsPlayingSuperDimensionTimeline()
  return self.SuperDimensionTimelinePlayer and self.SuperDimensionTimelinePlayer:IsPlaying()
end

function BattleScene:PlaySuperDimensionTimeline()
  if not self.SuperDimensionTimelinePlayer then
    self.SuperDimensionTimelinePlayer = SuperDimensionTimelinePlayer()
  end
  self.SuperDimensionTimelinePlayer:StartSuperDimension()
end

function BattleScene:StopPlayingSuperDimensionTimeline()
  if self.SuperDimensionTimelinePlayer then
    self.SuperDimensionTimelinePlayer:StopPlaySuperDimension()
  end
end

function BattleScene:ChangeDimensionScene(isExtraBout)
  if isExtraBout then
  end
end

function BattleScene:PlayBattleBGM()
  if self.battleCfg.BattleType == "PVP" then
    return
  end
  if self.battleCfg.EnterAudioEvent then
    Logger.Info("BattleScene:PlayBattleBGM()")
    for index, event in ipairs(self.battleCfg.EnterAudioEvent) do
      AudioManager.Instance:PostSoundEvent(event)
    end
  else
    Logger.ReportApusInfo("AUDIO_LOG_EVENT {battleConfigID}", self.battleCfg.ID)
    Logger.Warn("战斗BGM不存在")
  end
  if self.battleSceneCfg and self.battleSceneCfg.EnterAudioEvent then
    Logger.Info("BattleScene:PlayBattleSceneBGM()")
    for index, event in ipairs(self.battleSceneCfg.EnterAudioEvent) do
      AudioManager.Instance:PostSoundEvent(event)
    end
  end
end

function BattleScene:StopBattleBGM()
  if self._hasStopedBgm then
    return
  end
  self._hasStopedBgm = true
  if self.battleCfg and self.battleCfg.LeaveAudioEvent then
    for _, event in pairs(self.battleCfg.LeaveAudioEvent) do
      AudioManager.Instance:PostSoundEvent(event)
    end
  end
  if self.battleSceneCfg and self.battleSceneCfg.LeaveAudioEvent then
    for _, event in pairs(self.battleSceneCfg.LeaveAudioEvent) do
      AudioManager.Instance:PostSoundEvent(event)
    end
  end
end

function BattleScene:EnableApplyDepthFog(enable)
  if self._isApplyDepthFogEnabled == enable then
    return
  end
  self._isApplyDepthFogEnabled = enable
  for _, role in ipairs(self.roleList) do
    local awaker = role.awakerList[1]
    if awaker and awaker.spineComp then
      awaker.spineComp:EnableApplyDepthFog(enable)
    end
  end
  self.battleSceneMgr:EnableApplyDepthFog(enable)
end

function BattleScene:IsApplyDepthFogEnable()
  return self._isApplyDepthFogEnabled
end

function BattleScene:EnterDimensionScene(scenePath)
  do return self.battleSceneMgr.EnterDimensionScene, self.battleSceneMgr end
  return self.battleSceneMgr.EnterDimensionScene, self.battleSceneMgr, scenePath
end

function BattleScene:ChangeBattleScene(scenePath, timelineUrl)
  do return self.battleSceneMgr.ChangeBattleScene, self.battleSceneMgr, scenePath end
  return self.battleSceneMgr.ChangeBattleScene, self.battleSceneMgr, scenePath, timelineUrl
end

function BattleScene:ShowScene(showed, isSuperDimension)
  if self.battleSceneMgr then
    self.battleSceneMgr:ShowScene(showed)
  end
  if not isSuperDimension then
    self:ShowDimensionVideo(showed)
  end
end

function BattleScene:HideSceneEffects()
  if self.battleSceneMgr then
    self.battleSceneMgr:HideSceneEffects()
  end
end

function BattleScene:ShowDimensionVideo(showed)
  local superDimensionTimelinePlayer = self.SuperDimensionTimelinePlayer
  if superDimensionTimelinePlayer then
    superDimensionTimelinePlayer:ShowSuperDimension(showed)
    local superDimensVideo = superDimensionTimelinePlayer.superDimensVideo
    if superDimensVideo then
      superDimensVideo:SetVisible(showed)
    end
  end
end

function BattleScene:ShowAwakerPaintingById(awakerId, skillName)
  if not self.abortController then
    self.abortController = AbortController()
  end
  bg.battleDataCenter:SetOpMode(rc.OpMode.Inspect)
  BattleAwakerUltiSkillPainting.PlayByAwakerId(awakerId, skillName, function()
    if bg.battleDataCenter then
      bg.battleDataCenter:SetOpMode(rc.OpMode.Play)
    end
  end, self.abortController.signal)
end

function BattleScene:GetBattleId()
  return self.battleId
end

function BattleScene:PauseUniversalCycle()
  if self.cameraComp then
    self.cameraComp:PauseUniversalCycle()
  end
end

function BattleScene:ResumeUniversalCycle()
  if self.cameraComp then
    self.cameraComp:ResumeUniversalCycle()
  end
end

function BattleScene:ShowSchoolTable()
  if not self.refCountHideSchoolTable then
    return
  end
  self.refCountHideSchoolTable = self.refCountHideSchoolTable - 1
  if self.refCountHideSchoolTable > 0 then
    return
  end
  self.refCountHideSchoolTable = 0
  for _, role in ipairs(self.roleList) do
    if role.statusUI and role.statusUI.bloodUI and role.statusUI.bloodUI.ui and role.statusUI.bloodUI.ui.Parent_School then
      role.statusUI.bloodUI.ui.Parent_School:SetActive(true)
    end
  end
end

function BattleScene:HideSchoolTable()
  self.refCountHideSchoolTable = self.refCountHideSchoolTable or 0
  self.refCountHideSchoolTable = self.refCountHideSchoolTable + 1
  if 1 ~= self.refCountHideSchoolTable then
    return
  end
  for _, role in ipairs(self.roleList) do
    if role.statusUI and role.statusUI.bloodUI and role.statusUI.bloodUI.ui and role.statusUI.bloodUI.ui.Parent_School then
      role.statusUI.bloodUI.ui.Parent_School:SetActive(false)
    end
  end
end

function BattleScene:_OnWindowsResolutionChange()
  self:_ApplyBattleCameraAdaptation(true)
end

function BattleScene:_ApplyBattleCameraAdaptation(forceApply)
  if ApplicationUtils.IsWindows() or ApplicationUtils.IsEditor() then
    AdaptiveManager.Instance:ApplyBattleCameraAdaptation(forceApply)
  end
end

return BattleScene
