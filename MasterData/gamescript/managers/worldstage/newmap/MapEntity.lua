local SceneManager = CS.UnityEngine.SceneManagement.SceneManager
local MapEntity, Super = System.NewClass("MapEntity", Entity)

function MapEntity:ctor(stageData, cfgData, comp)
  Super.ctor(self)
  self.canClick = true
  self.model = MapModel.Instance
  self.model:Setup(stageData, cfgData)
  self.controller = MapController.Instance
  self.controller:Setup(self, self.model)
  self.stageData = stageData
  self.mapData = self.model:GetMapData()
  self.gearData = self.model:GetGearData()
  self.roleFOV = self.model:GetRoleFOV()
  self.owner = comp
  self.cfgData = cfgData
  self.innerRadius = 0.525
  self.outRadius = self.innerRadius / math.sqrt(3) * 2
  self.isShow = true
  self.isEnteredMap = false
  self.saveKey = CommonDefine.LocalSaveKeyCommon.StageExploreBgm
  self.mapBgmData = MobileFileDataManager.Instance:GetPlayerFileValue(self.saveKey)
end

function MapEntity:Awake()
  Super.Awake(self)
  self.co = nil
  self.scenePath = nil
  self.binder:BindEvent(EventMgr.Instance.MapMistRemove, System.fn(self, self.OnUpdateMistEvent))
end

function MapEntity:AppendFinishGeard(finishGears)
  local gearData = self.gearData
  for _, gear in pairs(finishGears or {}) do
    gear.isFinished = true
    table.insert(gearData, gear)
  end
end

function MapEntity:OnUpdateMistEvent(index, state)
  local triggerPoint = self.cfgData.Atmos
  if state and triggerPoint then
    local artEffectMgr = self.effectMgr
    for i = 1, #triggerPoint, 2 do
      local x = triggerPoint[i]
      local y = triggerPoint[i + 1]
      local idx = self:GetIdxByPos(x, y)
      if idx == index then
        artEffectMgr:ChangeAtmosphere()
      end
    end
  end
end

function MapEntity:GetWorldPosByGridPos(x, y)
  local worldPosX = (x - 1) * self.innerRadius * 2
  local worldPosY = (y - 1) * self.outRadius * 3 / 2
  if 1 == y % 2 then
    worldPosX = worldPosX + self.innerRadius
  end
  return worldPosX, worldPosY
end

function MapEntity:_ClearLoadingTask()
  if self.co == nil then
    return
  end
  TaskMgr.Instance:StopSleep(self.co)
  self.co = nil
end

function MapEntity:EnterMap(path, callback, firstFight)
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
      self.mapConfig = self.rootNode:GetComponent(typeof(CS.MapParamConfig))
      self.innerRadius = (1.0 + self:GetGridDist()) / 2
      self.outRadius = self.innerRadius / math.sqrt(3) * 2
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

function MapEntity:_initSceneNodes()
  self.rootNode = CS.UnityEngine.GameObject.Find("mapRoot")
  self:_checkBgNodeValid()
end

function MapEntity:_checkBgNodeValid()
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

function MapEntity:PreloadBattle()
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

function MapEntity:LeaveMap()
  self:PlayLeaveMapAudio()
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

function MapEntity:GetIdxByPos(posX, posY)
  local width = MapModel.Instance:GetMapWidth()
  local height = MapModel.Instance:GetMapHeight()
  if posX < 0 or posX > width then
    Logger.Error(string.format("MapEntity.GetIdxByPos param Error posX = %s", posX))
  end
  if posY < 0 or posY > height then
    Logger.Error(string.format("MapEntity.GetIdxByPos param Error posY = %s", posY))
  end
  do return MapModel.Instance.GetIdxByPos, MapModel.Instance, posX end
  return MapModel.Instance.GetIdxByPos, MapModel.Instance, posX, posY
end

function MapEntity:GetPosByIdx(idx)
  local posX, posY = MapModel.Instance:GetPosByIdx(idx)
  local width = self:GetMapWidth()
  assert(posX <= width and posX >= 1, "MapEntity.GetPosByIdx function Error")
  return posX, posY
end

function MapEntity:GetBgm()
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

function MapEntity:RandomBgm()
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

function MapEntity:GetDefaultMusic()
  local boxId = MainCopyDataUtils.GetDymicDifficultyId(self.stageData.stageId)
  local cfg = MainCopyDataUtils.GetStageConfig(boxId)
  local defaultMusic = cfg and cfg.DefaultMusic or nil
  defaultMusic = defaultMusic or self.cfgData.DefaultMusic
  return defaultMusic
end

function MapEntity:CacheBgmData()
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

function MapEntity:PlayBGM(evt)
  local event = evt or self:GetBgm()
  if event then
    AudioManager.Instance:PlayBGM(event)
  end
end

function MapEntity:StopBGM()
  AudioManager.Instance:StopBGM()
end

function MapEntity:PlayAwakerVoice(voiceId)
  if 0 == voiceId then
    return
  end
  local soundEventName = AwakerDataUtils.GetAwakerVoiceSound(voiceId)
  local duration = AudioManager.Instance:GetEventLength(soundEventName)
  EventMgr.Instance.ShowAwakerVoice:Dispatch(voiceId, nil, duration)
  AudioManager.Instance:PostSoundEvent(soundEventName)
end

function MapEntity:GetMapWidth()
  do return MapModel.Instance.GetMapWidth end
  return MapModel.Instance.GetMapWidth, MapModel.Instance
end

function MapEntity:GetMapHeight()
  do return MapModel.Instance.GetMapHeight end
  return MapModel.Instance.GetMapHeight, MapModel.Instance
end

function MapEntity:GetRolePos()
  do return MapModel.Instance.GetRolePos end
  return MapModel.Instance.GetRolePos, MapModel.Instance
end

function MapEntity:SetRolePos(x, y)
  MapModel.Instance:SetRolePos(x, y)
end

function MapEntity:GetFieldOfView(y, level)
  do return MapModel.Instance.GetFieldOfView, MapModel.Instance, y end
  return MapModel.Instance.GetFieldOfView, MapModel.Instance, y, level
end

function MapEntity:GetMapId()
  return self.mapData.id
end

function MapEntity:GetGearData()
  do return MapModel.Instance.GetGearData end
  return MapModel.Instance.GetGearData, MapModel.Instance
end

function MapEntity:GetGearDataByPos(x, y)
  do return MapModel.Instance.GetGearDataByPos, MapModel.Instance, x end
  return MapModel.Instance.GetGearDataByPos, MapModel.Instance, x, y
end

function MapEntity:SetGearFinished(x, y)
  MapModel.Instance:SetGearFinishedByPos(x, y)
end

function MapEntity:GetMistData()
  do return MapModel.Instance.GetMistData end
  return MapModel.Instance.GetMistData, MapModel.Instance
end

function MapEntity:GetMaterialTid(posX, posY)
  do return MapModel.Instance.GetMaterialTid, MapModel.Instance, posX end
  return MapModel.Instance.GetMaterialTid, MapModel.Instance, posX, posY
end

function MapEntity:GetUnitGridPath(posX, posY)
  do return MapModel.Instance.GetUnitGridPath, MapModel.Instance, posX end
  return MapModel.Instance.GetUnitGridPath, MapModel.Instance, posX, posY
end

local DefaultGridPath = "MUnit/MUnit_02/Grid/MUnit_Grid_M0001/MUnit_Grid_M0001.prefab"

function MapEntity:GetUnitGridDefaultPath()
  return MapModel.Instance:GetUnitGridDefaultPath() or DefaultGridPath
end

function MapEntity:InitComponent()
  self.effectMgr = self:AddComponent(MapArtEffectManager)
  self.terrainMgr = self:AddComponent(MapTerrainManager)
  self.mistMgr = self:AddComponent(MapMistManager)
  self.gearMgr = self:AddComponent(MapGearManager)
  self.cameraMgr = self:AddComponent(MapCameraManager)
  self.roleMgr = self:AddComponent(MapRoleManager)
  self.moveMgr = self:AddComponent(MapMoveManager)
  self.netMgr = self:AddComponent(MapNetEventManager)
  self.touchMgr = self:AddComponent(MapTouchManager)
  self.guideMgr = self:AddComponent(MapGuideManager)
  self._components:ForEach(function(comp)
    if comp.OnInit then
      comp:OnInit()
    end
  end)
end

function MapEntity:OnEnterMap()
  if not self.isShow then
    return
  end
  SceneMgr.Instance:ClosePermanentUIs()
  self.isEnteredMap = true
  self:BindMapQuality()
  self:LoadSceneEffects()
  self:PlayEnterMapAudio()
  local pos = self:GetRolePos()
  local roleMgr = self.roleMgr
  local netMgr = self.netMgr
  local effectManager = self.effectMgr
  local guideManager = self.guideMgr
  local isRecover = WorldRecoveryManager.Instance:IsRecovery()
  if isRecover then
    roleMgr:SetRolePos(pos.x, pos.y)
    roleMgr:SetMist(pos.x, pos.y)
    effectManager:ResetAtmosphere()
    self.terrainMgr:UpdateClickTip(pos.x, pos.y)
    if UIManager.Instance:GetWindow(Urls.WorldStageOpeningAnim) then
      local animPanel = UIManager.Instance:GetWindow(Urls.WorldStageOpeningAnim)
      if animPanel and animPanel.ui and animPanel.ui.uiNode then
        local childBinder = self.binder:createChild(self.binder)
        childBinder:AddClickMask(childBinder, animPanel.ui.uiNode)
        self.binder:BindTimer(0.2, 0, nil, function()
          childBinder:teardown()
          EventMgr.Instance.MapEnterFinished:Dispatch()
        end)
      end
    end
    netMgr:OnAfterEnter()
    SceneMgr.Instance:SetOpenUIQueueEnabled(true)
    self.binder:BindTimer(1, 0, nil, function()
      guideManager:TriggerEnter()
    end)
    effectManager:PlayOnEnter(pos.x, pos.y, self.roleFOV, roleMgr:GetRole(), 0.5, 0)
  else
    roleMgr.role.go:SetActive(false)
    local touchMgr = self.touchMgr
    touchMgr:SetCanTouch(false)
    if self.isShow then
      UIManager.Instance:CloseByUrl(Urls.WorldStageMainPanel)
      effectManager:PlayStageEnterAnim(function()
        UIManager.Instance:CloseByUrl(Urls.WorldStageOpeningAnim)
        roleMgr:SetRolePos(pos.x, pos.y)
        local role = roleMgr:GetRole()
        local startTime = 1
        local interTime = self:GetGapTime()
        local cameraMgr = self.cameraMgr
        if not cameraMgr then
          return
        end
        cameraMgr:InitDragCameraPos()
        netMgr:OnAfterEnter()
        effectManager:PlayOnEnter(pos.x, pos.y, self.roleFOV, role, startTime, interTime, function()
          if not UIManager.Instance:GetWindow(Urls.WorldStageMainPanel) then
            WorldStageManager.Instance.OpenWorldstageMainPanel(self.stageData.groupId, self.stageData.stageId)
          end
          UIManager.Instance:Reopen(Urls.WorldStageEnterPanel, function()
          end)
          self._endAnimTimer = TimerManager.Instance:CreateTimer(0.1, 0, nil, function()
            guideManager:TriggerEnter()
            SceneMgr.Instance:SetOpenUIQueueEnabled(true)
            EventMgr.Instance.MapEnterFinished:Dispatch()
          end)
          self._resetCanTouchTimer = TimerManager.Instance:CreateTimer(0.2, 0, nil, function()
            touchMgr:SetCanTouch(true)
          end)
        end)
      end)
    else
      netMgr:OnAfterEnter()
      SceneMgr.Instance:SetOpenUIQueueEnabled(true)
      EventMgr.Instance.MapEnterFinished:Dispatch()
    end
  end
end

function MapEntity:BindMapQuality()
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

function MapEntity:GetStepCount()
  return self.stageData.stats.StepCount
end

function MapEntity:IsOneLineMap()
  return false
end

function MapEntity:PlayEnterMapAudio()
  local mapId = self:GetMapId()
  local mapCfg = DT.Map[mapId]
  local mapSceneVxIdGroup = mapCfg.data_list[1] and mapCfg.data_list[1].Effect or {}
  for _, val in pairs(mapSceneVxIdGroup) do
    local enterAudioEvent = DT.MapSceneVX[val] and DT.MapSceneVX[val].EnterAudioEvent or nil
    if enterAudioEvent then
      for i = 1, #enterAudioEvent do
        AudioManager.Instance:PostSoundEvent(enterAudioEvent[i])
      end
    end
  end
end

function MapEntity:PlayLeaveMapAudio()
  local mapId = self:GetMapId()
  local mapCfg = DT.Map[mapId]
  local mapSceneVxIdGroup = mapCfg.data_list[1] and mapCfg.data_list[1].Effect or {}
  for _, val in pairs(mapSceneVxIdGroup) do
    local leaveAudioEvent = DT.MapSceneVX[val] and DT.MapSceneVX[val].LeaveAudioEvent or nil
    if leaveAudioEvent then
      for i = 1, #leaveAudioEvent do
        AudioManager.Instance:PostSoundEvent(leaveAudioEvent[i])
      end
    end
  end
end

function MapEntity:LoadSceneEffects()
  local mapId = self:GetMapId()
  local mapCfg = DT.Map[mapId]
  local mapSceneVxIdGroup = mapCfg.data_list[1] and mapCfg.data_list[1].Effect or {}
  self.sceneEffect = CS.UnityEngine.Camera.main.transform:Find("SceneEffects_M")
  if self.sceneEffect then
    for _, val in pairs(mapSceneVxIdGroup) do
      local effectPath = DT.MapSceneVX[val] and DT.MapSceneVX[val].Effect or nil
      if effectPath then
        local prefab = self.binder:LoadAsset(effectPath)
        local sceneEffectObj = self.binder:Instantiate(prefab, self.sceneEffect)
        sceneEffectObj.transform.position = self.sceneEffect.position
      end
    end
    Logger.Debug("LoadSceneEffects Done!")
  end
end

function MapEntity:Hide()
  if self.bgNode then
    self.bgNode:SetActive(false)
  end
  if self.rootNode then
    self.rootNode:SetActive(false)
  end
  self:PlayLeaveMapAudio()
  self:StopBGM()
  self._components:ForEach(function(comp)
    if comp.OnHide then
      comp:OnHide()
    end
  end)
  self.isShow = false
end

function MapEntity:Show()
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
    self:PlayEnterMapAudio()
    SceneMgr.Instance:ClosePermanentUIs()
    if self.isRefreshAfterShowMap then
      self:UpdateCurMist()
    end
    self:SetRefreshMistAfterShowMap(false)
  end
  local mapNetMgr = self.netMgr
  mapNetMgr:CheckReconnectData()
end

function MapEntity:SetRefreshMistAfterShowMap(isRefreshAfterShowMap)
  self.isRefreshAfterShowMap = isRefreshAfterShowMap
end

function MapEntity:UpdateCurMist()
  self.roleMgr:UpdateRoleMist()
end

function MapEntity:AddGearToTerrain(gear)
  local x, y = gear:GetGridPos()
  local terrain = self.terrainMgr:GetTerrainByPos(x, y)
  if terrain then
    terrain:SetGear(gear)
  end
end

function MapEntity:SetClickState(state)
  self.canClick = state
end

function MapEntity:GetClickState()
  return self.canClick
end

function MapEntity:GetMoveGridTime()
  do return DT.GetConstant, "GridMoveTime" end
  return DT.GetConstant, "GridMoveTime", 0.5
end

function MapEntity:GetAllTerrain()
  do return self.terrainMgr.GetAllTerrain end
  return self.terrainMgr.GetAllTerrain, self.terrainMgr
end

function MapEntity:GetGridDist()
  return self.mapConfig.GridPadding
end

function MapEntity:GetMistOpenTime()
  return self.mapConfig.playMistAfterMove
end

function MapEntity:GetGridUpTime()
  do return DT.GetConstant, "GridUpDelay" end
  return DT.GetConstant, "GridUpDelay", 0.5
end

function MapEntity:GetMistOpenSpeed()
  return self.mapConfig.playMistSpeed
end

function MapEntity:GetGapTime()
  return self.mapConfig.playUpGapTime
end

function MapEntity:GetSinkTime()
  return self.mapConfig.playGridSinkAfterMove
end

function MapEntity:GetSceneOpeningTexturePath()
  local boxId = MainCopyDataUtils.GetDymicDifficultyId(self.stageData.stageId)
  local cfg = MainCopyDataUtils.GetStageConfig(boxId)
  local mat = cfg and cfg.SceneEnterMat or nil
  if not mat then
    return self.cfgData.SceneEnterMat
  else
    return mat
  end
end

function MapEntity:Destroy()
  Super.Destroy(self)
  TimerManager.Instance:StopTimer(self._endAnimTimer)
  TimerManager.Instance:StopTimer(self._resetCanTouchTimer)
  self.effectMgr = nil
  self.terrainMgr = nil
  self.mistMgr = nil
  self.gearMgr = nil
  self.cameraMgr = nil
  self.roleMgr = nil
  self.netMgr = nil
  self.touchMgr = nil
  self.guideMgr = nil
  MapController.Instance:ResetMap(self)
  MapModel.Instance:OnReset()
  self.controller = nil
end

return MapEntity
