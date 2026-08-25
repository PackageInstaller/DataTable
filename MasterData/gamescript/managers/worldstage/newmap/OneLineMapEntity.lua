local SceneManager = CS.UnityEngine.SceneManagement.SceneManager
local OneLineMapEntity, Super = System.NewClass("OneLineMapEntity", Entity)

function OneLineMapEntity:ctor(stageData, cfgData, comp)
  Super.ctor(self)
  self.isShow = true
  self.model = MapModel.Instance
  self.model:Setup(stageData, cfgData)
  self.controller = MapController.Instance
  self.controller:Setup(self, self.model)
  self.stageData = stageData
  self.mapData = self.model:GetMapData()
  self.gearData = self.model:GetGearData()
  self.owner = comp
  self.cfgData = cfgData
  self.isEnteredMap = false
  self.saveKey = CommonDefine.LocalSaveKeyCommon.StageExploreBgm
  self.mapBgmData = MobileFileDataManager.Instance:GetPlayerFileValue(self.saveKey)
end

function OneLineMapEntity:Awake()
  Super.Awake(self)
  self.co = nil
  self.scenePath = nil
  self.binder:BindEvent(EventMgr.Instance.MapMistRemove, System.fn(self, self.OnUpdateMistEvent))
end

function OneLineMapEntity:OnUpdateMistEvent(index, state)
end

function OneLineMapEntity:_ClearLoadingTask()
  if self.co == nil then
    return
  end
  TaskMgr.Instance:StopSleep(self.co)
  self.co = nil
end

function OneLineMapEntity:EnterMap(path, callback, firstFight)
  self:_ClearLoadingTask()
  self.co = SceneLoader.StartMapLoading(function()
    self.scenePath = path
    self:PreloadBattle()
    ResLoadMgr.LoadSceneAsync(path, CommonDefine.LoadSceneModeType.Additive, function()
      if self.destroyed or not self.scenePath then
        local scene = SceneManager.GetSceneByPath(path)
        if scene:IsValid() and scene.isLoaded then
          SceneManager.UnloadSceneAsync(path)
        end
        return
      end
      if not firstFight then
        UIManager.Instance:CloseByUrl(Urls.LoadingPanel)
        UIManager.Instance:Reopen(Urls.WorldStageOpeningAnim)
      end
      WorldStageManager.Instance.OpenWorldstageMainPanel(self.stageData.groupId, self.stageData.stageId)
      self:_ClearLoadingTask()
      local scene = SceneManager.GetSceneByPath(self.scenePath)
      SceneManager.SetActiveScene(scene)
      UnityBattleSceneMgr.UnLoadAllBattleScenes()
      UnityBattleSceneMgr.UnLoadAllBattleResources()
      self:_initSceneNodes()
      AudioManager.Instance:PostSoundEvent("Play_Explore_Start")
      local bgm = self:GetBgm()
      self:PlayBGM(bgm)
      if callback then
        callback()
      end
      self:InitComponent()
      self:OnEnterMap()
    end)
  end)
end

function OneLineMapEntity:_initSceneNodes()
  self.rootNode = CS.UnityEngine.GameObject.Find("mapRoot")
  self:_checkBgNodeValid()
end

function OneLineMapEntity:_checkBgNodeValid()
  if not self.bgNode then
    self.bgNode = CS.UnityEngine.GameObject.Find("Scenes")
  end
  if self.bgNode then
    local volume = self.bgNode.transform:Find("Volume")
    local seachTime = 0
    while self.bgNode and not volume and seachTime < 5 do
      Logger.Error("==仅Log===战斗场景没有成功卸载，这里执行保底操作")
      seachTime = seachTime + 1
      self.bgNode.gameObject:SetActive(false)
      self.bgNode = CS.UnityEngine.GameObject.Find("Scenes")
      volume = self.bgNode.transform:Find("Volume")
    end
  end
end

function OneLineMapEntity:PreloadBattle()
  local awakerInfos = self.stageData.role.awakerInfos
  local sceneRootNode = CS.UnityEngine.GameObject.Find("SceneRoot")
  local battleSceneRoot = sceneRootNode.transform:Find("BattleScene")
  if nil == battleSceneRoot then
    local prefabBattleScene = ResLoadMgr.LoadAsset("GameBasePrefab/BattleScene.prefab", self)
    local battleSceneRootNode = CS.UnityEngine.GameObject.Instantiate(prefabBattleScene)
    battleSceneRootNode.name = "BattleScene"
    battleSceneRoot = battleSceneRootNode.transform
    battleSceneRoot:SetParent(sceneRootNode.transform)
  end
  local battleFactoryLayer = battleSceneRoot:Find("FactoryLayer")
  for _, awakerInfo in ipairs(awakerInfos) do
    BattleAwakerClient.Preload(self, awakerInfo.tid, bc.RoleType.Awaker, battleFactoryLayer)
  end
  BattleAwakerUltiSkillPainting.Preload(battleFactoryLayer)
  BattleAwakerSuperUltiSkillPainting.Preload(battleFactoryLayer)
  RoleFloatingText.Preload(battleFactoryLayer)
end

function OneLineMapEntity:LeaveMap()
  self:CacheBgmData()
  self:StopBGM()
  self:Destroy()
  Pool.Clear()
  ResLoadMgr.UnloadAssetByTarget(self)
  if self.scenePath then
    ResLoadMgr.UnLoadScene(self.scenePath)
    self.scenePath = nil
  end
end

function OneLineMapEntity:GetIdxByPos(posX, posY)
  local width = self.model:GetMapWidth()
  local height = self.model:GetMapHeight()
  if posX < 0 or posX > width then
    Logger.Error(string.format("OneLineMapEntity.GetIdxByPos param Error posX = %s", posX))
  end
  if posY < 0 or posY > height then
    Logger.Error(string.format("OneLineMapEntity.GetIdxByPos param Error posY = %s", posY))
  end
  do return self.model.GetIdxByPos, self.model, posX end
  return self.model.GetIdxByPos, self.model, posX, posY
end

function OneLineMapEntity:GetPosByIdx(idx)
  local posX, posY = self.model:GetPosByIdx(idx)
  local width = self:GetMapWidth()
  assert(posX <= width and posX >= 1, "OneLineMapEntity.GetPosByIdx function Error")
  return posX, posY
end

function OneLineMapEntity:GetBgm()
  if not self.mapBgmData then
    self.mapBgmData = {}
    local randomBgm = self:RandomBgm()
    local bgmData = {}
    bgmData.newBgm = randomBgm
    bgmData.oldBgm = nil
    self.mapBgmData[self.cfgData.ID] = bgmData
    MobileFileDataManager.Instance:SetPlayerFileValue(self.saveKey, self.mapBgmData, true)
    return randomBgm
  end
  if self.mapBgmData and self.mapBgmData[self.cfgData.ID] and self.mapBgmData[self.cfgData.ID].newBgm then
    if table.contains(self.cfgData.DefaultMusic, self.mapBgmData[self.cfgData.ID].newBgm) then
      return self.mapBgmData[self.cfgData.ID].newBgm
    else
      do return self.RandomBgm end
      return self.RandomBgm, self, self.mapBgmData[self.cfgData.ID].newBgm, self.cfgData.ID, self.saveKey, self.mapBgmData, true
    end
  end
  local randomBgm = self:RandomBgm()
  local bgmData = {}
  bgmData.newBgm = randomBgm
  self.mapBgmData[self.cfgData.ID] = bgmData
  MobileFileDataManager.Instance:SetPlayerFileValue(self.saveKey, self.mapBgmData, true)
  return randomBgm
end

function OneLineMapEntity:RandomBgm()
  local DefaultMusicList = self:GetDefaultMusic()
  if #DefaultMusicList < 2 then
    return DefaultMusicList[1]
  end
  if not self.mapBgmData[self.cfgData.ID] then
    self.mapBgmData[self.cfgData.ID] = {}
  end
  if self.mapBgmData and self.mapBgmData[self.cfgData.ID].oldBgm then
    local randomBgm = DefaultMusicList[math.random(1, #DefaultMusicList)]
    while randomBgm == self.mapBgmData[self.cfgData.ID].oldBgm do
      randomBgm = DefaultMusicList[math.random(1, #DefaultMusicList)]
    end
    return randomBgm
  else
    return DefaultMusicList[math.random(1, #DefaultMusicList)]
  end
end

function OneLineMapEntity:GetDefaultMusic()
  local boxId = MainCopyDataUtils.GetDymicDifficultyId(self.stageData.stageId)
  local cfg = MainCopyDataUtils.GetStageConfig(boxId)
  local defaultMusic = cfg and cfg.DefaultMusic or nil
  defaultMusic = defaultMusic or self.cfgData.DefaultMusic
  return defaultMusic
end

function OneLineMapEntity:CacheBgmData()
  if not (self.mapBgmData and self.cfgData) or not self.cfgData.ID then
    return
  end
  if not self.mapBgmData[self.cfgData.ID] then
    return
  end
  if self.mapBgmData and self.mapBgmData[self.cfgData.ID].newBgm then
    self.mapBgmData[self.cfgData.ID].oldBgm = self.mapBgmData[self.cfgData.ID].newBgm
    self.mapBgmData[self.cfgData.ID].newBgm = nil
  end
  MobileFileDataManager.Instance:SetPlayerFileValue(self.saveKey, self.mapBgmData, true)
end

function OneLineMapEntity:PlayBGM(evt)
  local event = evt or self:GetBgm()
  if event then
    AudioManager.Instance:PlayBGM(event)
  end
end

function OneLineMapEntity:StopBGM()
  AudioManager.Instance:StopBGM()
end

function OneLineMapEntity:PlayAwakerVoice(voiceId)
  if 0 == voiceId then
    return
  end
  local soundEventName = AwakerDataUtils.GetAwakerVoiceSound(voiceId)
  local duration = AudioManager.Instance:GetEventLength(soundEventName)
  EventMgr.Instance.ShowAwakerVoice:Dispatch(voiceId, nil, duration)
  AudioManager.Instance:PostSoundEvent(soundEventName)
end

function OneLineMapEntity:GetMapWidth()
  do return self.model.GetMapWidth end
  return self.model.GetMapWidth, self.model
end

function OneLineMapEntity:GetMapHeight()
  do return self.model.GetMapHeight end
  return self.model.GetMapHeight, self.model
end

function OneLineMapEntity:GetRolePos()
  do return self.model.GetRolePos end
  return self.model.GetRolePos, self.model
end

function OneLineMapEntity:SetRolePos(x, y)
  self.model:SetRolePos(x, y)
end

function OneLineMapEntity:GetFieldOfView(y, level)
  do return self.model.GetFieldOfView, self.model, y end
  return self.model.GetFieldOfView, self.model, y, level
end

function OneLineMapEntity:GetMapId()
  return nil
end

function OneLineMapEntity:GetGearData()
  do return self.model.GetGearData end
  return self.model.GetGearData, self.model
end

function OneLineMapEntity:GetGearDataByPos(x, y)
  do return self.model.GetGearDataByPos, self.model, x end
  return self.model.GetGearDataByPos, self.model, x, y
end

function OneLineMapEntity:SetGearFinished(x, y)
  self.model:SetGearFinishedByPos(x, y)
end

function OneLineMapEntity:GetMistData()
  do return self.model.GetMistData end
  return self.model.GetMistData, self.model
end

function OneLineMapEntity:GetMaterialTid(posX, posY)
  do return self.model.GetMaterialTid, self.model, posX end
  return self.model.GetMaterialTid, self.model, posX, posY
end

function OneLineMapEntity:GetUnitGridPath(posX, posY)
  do return self.model.GetUnitGridPath, self.model, posX end
  return self.model.GetUnitGridPath, self.model, posX, posY
end

local DefaultGridPath = "MUnit/MUnit_02/Grid/MUnit_Grid_M0001/MUnit_Grid_M0001.prefab"

function OneLineMapEntity:GetUnitGridDefaultPath()
  return self.model:GetUnitGridDefaultPath() or DefaultGridPath
end

function OneLineMapEntity:InitComponent()
  self.effectMgr = self:AddComponent(MapArtEffectManager)
  self.onelineMgr = self:AddComponent(MapOneLineManager)
  self.cameraMgr = self:AddComponent(MapCameraManager)
  self._components:ForEach(function(comp)
    if comp.OnInit then
      comp:OnInit()
    end
  end)
end

function OneLineMapEntity:OnEnterMap()
  if not self.isShow then
    return
  end
  SceneMgr.Instance:ClosePermanentUIs()
  self.isEnteredMap = true
  self:BindMapQuality()
  local effectManager = self.effectMgr
  if WorldRecoveryManager.Instance:IsRecovery() then
    effectManager:ResetAtmosphere()
    if not UIManager.Instance:GetWindow(Urls.WorldStageMainPanel) then
      WorldStageManager.Instance.OpenWorldstageMainPanel(self.stageData.groupId, self.stageData.stageId)
    end
    effectManager:PlayStageEnterAnim(function()
      if UIManager.Instance:GetWindow(Urls.WorldStageOpeningAnim) then
        local animPanel = UIManager.Instance:GetWindow(Urls.WorldStageOpeningAnim)
        if animPanel and animPanel.ui and animPanel.ui.uiNode then
          local childBinder = self.binder:createChild(self.binder)
          childBinder:AddClickMask(childBinder, animPanel.ui.uiNode)
          self.binder:BindTimer(0.2, 0, nil, function()
            childBinder:teardown()
            self:OnEnterMapFinish()
          end)
        end
      else
        self:OnEnterMapFinish()
      end
    end)
  elseif self.isShow then
    UIManager.Instance:CloseByUrl(Urls.WorldStageMainPanel)
    if not UIManager.Instance:GetWindow(Urls.WorldStageMainPanel) then
      WorldStageManager.Instance.OpenWorldstageMainPanel(self.stageData.groupId, self.stageData.stageId)
    end
    effectManager:PlayStageEnterAnim(function()
      if not self.binder then
        return
      end
      UIManager.Instance:CloseByUrl(Urls.WorldStageOpeningAnim)
      UIManager.Instance:GetWindow(Urls.WorldStageMainPanel)
      self.binder:BindTimer(0.1, 0, nil, function()
        self:OnEnterMapFinish()
      end)
      UIManager.Instance:Reopen(Urls.WorldStageEnterPanel)
    end)
  else
    self:OnEnterMapFinish()
  end
end

function OneLineMapEntity:OnEnterMapFinish()
  if not UIManager.Instance:GetWindow(Urls.WorldStageMainPanel) then
    WorldStageManager.Instance.OpenWorldstageMainPanel(self.stageData.groupId, self.stageData.stageId)
  end
  self.onelineMgr:OnAfterEnter()
  EventMgr.Instance.MapEnterFinished:Dispatch()
  SceneMgr.Instance:SetOpenUIQueueEnabled(true)
end

function OneLineMapEntity:BindMapQuality()
  local LocalKeyCommon = CommonDefine.LocalSaveKeyCommon
  local bloomSetVal = MobileFileDataManager.Instance:GetCommFileValue(LocalKeyCommon.SystemSetting .. CommonDefine.SettingUniqueName.Bloom .. "_val")
  SettingManager.Instance:SetBloom(nil, bloomSetVal)
  local depthSetVal = MobileFileDataManager.Instance:GetCommFileValue(LocalKeyCommon.SystemSetting .. CommonDefine.SettingUniqueName.DepthOfField .. "_val")
  SettingManager.Instance:SetDepthOfField(nil, depthSetVal)
  local chromaticSetVal = MobileFileDataManager.Instance:GetCommFileValue(LocalKeyCommon.SystemSetting .. CommonDefine.SettingUniqueName.ChromaticAberration .. "_val")
  SettingManager.Instance:SetChromaticAberration(nil, chromaticSetVal)
  local outlineSetVal = MobileFileDataManager.Instance:GetCommFileValue(LocalKeyCommon.SystemSetting .. CommonDefine.SettingUniqueName.Outline .. "_val")
  ApplicationUtils.SetOutlineEnable(outlineSetVal)
  SettingManager.Instance:ResetSceneEffects()
  local artEffectMgr = self.effectMgr
  self.binder:BindToRaw(function(_, new)
    if new == CommonDefine.PerformanceLevel.Level3 then
      artEffectMgr:SetDepthOfFieldState(true)
    else
      artEffectMgr:SetDepthOfFieldState(false)
    end
  end, function()
    return DataCenter.playerData.performanceLevel
  end)
end

function OneLineMapEntity:GetStepCount()
  return self.stageData.stats.StepCount
end

function OneLineMapEntity:Hide()
  if self.bgNode then
    self.bgNode:SetActive(false)
  end
  if self.rootNode then
    self.rootNode:SetActive(false)
  end
  self:StopBGM()
  self._components:ForEach(function(comp)
    if comp.OnHide then
      comp:OnHide()
    end
  end)
  self.isShow = false
end

function OneLineMapEntity:Show()
  if self.co then
    return
  end
  if self.bgNode then
    self.bgNode:SetActive(true)
  end
  if self.rootNode then
    self.rootNode:SetActive(true)
  end
  local bgm = self:GetBgm()
  self:PlayBGM(bgm)
  self._components:ForEach(function(comp)
    if comp.OnShow then
      comp:OnShow()
    end
  end)
  self.isShow = true
  local scene = SceneManager.GetSceneByPath(self.scenePath)
  if scene then
    SceneManager.SetActiveScene(scene)
    local effectManager = self.effectMgr
    effectManager:ResetAtmosphere()
  end
  UnityBattleSceneMgr.UnLoadAllBattleScenes()
  UnityBattleSceneMgr.UnLoadAllBattleResources()
  if not self.isEnteredMap then
    self:OnEnterMap()
  else
    SceneMgr.Instance:ClosePermanentUIs()
    if self.isRefreshAfterShowMap then
      self:UpdateCurMist()
    end
    self:SetRefreshMistAfterShowMap(false)
  end
end

function OneLineMapEntity:SetRefreshMistAfterShowMap(isRefreshAfterShowMap)
  self.isRefreshAfterShowMap = isRefreshAfterShowMap
end

function OneLineMapEntity:IsOneLineMap()
  return true
end

function OneLineMapEntity:UpdateCurMist()
end

function OneLineMapEntity:AddGearToTerrain(gear)
end

function OneLineMapEntity:SetClickState(state)
  self.canClick = state
end

function OneLineMapEntity:GetClickState()
  return self.canClick
end

function OneLineMapEntity:GetMoveGridTime()
  do return DT.GetConstant, "GridMoveTime" end
  return DT.GetConstant, "GridMoveTime", 0.5
end

function OneLineMapEntity:GetAllTerrain()
end

function OneLineMapEntity:GetGridDist()
  return self.mapConfig.GridPadding
end

function OneLineMapEntity:GetMistOpenTime()
  return self.mapConfig.playMistAfterMove
end

function OneLineMapEntity:GetGridUpTime()
  do return DT.GetConstant, "GridUpDelay" end
  return DT.GetConstant, "GridUpDelay", 0.5
end

function OneLineMapEntity:GetMistOpenSpeed()
  return self.mapConfig.playMistSpeed
end

function OneLineMapEntity:GetGapTime()
  return self.mapConfig.playUpGapTime
end

function OneLineMapEntity:GetSinkTime()
  return self.mapConfig.playGridSinkAfterMove
end

function OneLineMapEntity:GetSceneOpeningTexturePath()
  local boxId = MainCopyDataUtils.GetDymicDifficultyId(self.stageData.stageId)
  local cfg = MainCopyDataUtils.GetStageConfig(boxId)
  local mat = cfg and cfg.SceneEnterMat or nil
  if not mat then
    return self.cfgData.SceneEnterMat
  else
    return mat
  end
end

function OneLineMapEntity:Destroy()
  Super.Destroy(self)
  TimerManager.Instance:StopTimer(self._endAnimTimer)
  TimerManager.Instance:StopTimer(self._resetCanTouchTimer)
  if self.controller then
    self.controller:ResetMap(self)
  end
  if self.model then
    self.model:OnReset()
  end
  self.controller = nil
  self.model = nil
end

return OneLineMapEntity
