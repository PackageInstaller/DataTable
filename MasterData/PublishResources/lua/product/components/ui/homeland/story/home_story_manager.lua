_class("HomeStoryManager", Object)
HomeStoryManager = HomeStoryManager

function HomeStoryManager:Constructor(storyID, uiController, mainCameraGo, rootGameObject, modelRoot, dialogRootGameObject, buttonRootGameObject, leftButtonRootGameObject, maskTemplate, uiAtlas, revertBGM, ignoreBreak)
  self._UIHomeStoryController = uiController
  self._storyID = storyID
  self._rootGameObject = rootGameObject
  self._modelRoot = modelRoot
  self.RootRotation = self._modelRoot.transform.rotation
  self._dialogRootGameObject = dialogRootGameObject
  self._buttonRootGameObject = buttonRootGameObject
  self._leftButtonRootGameObject = leftButtonRootGameObject
  self._maskTemplate = maskTemplate
  self._mainCamera = mainCameraGo
  self._mainCameraTr = mainCameraGo.transform
  self._mainCameraTr.localPosition = Vector3(0, 0, 0)
  self._mainCameraTr.rotation = Quaternion.identity
  self._mainCameraTr.localScale = Vector3(1, 1, 1)
  self._uiAtlas = uiAtlas
  self._revertBGM = revertBGM
  self._ignoreBreak = ignoreBreak
  self._end = false
  self._storyConfig = nil
  self._animResList = {}
  self._storyBgmTrackController = HomeStoryBgmTrackController:New(self)
  self._storyCameraTrackController = HomeStoryCameraTrackController:New(self)
  self._canvasRect = rootGameObject.transform.parent.parent:GetComponent("RectTransform").rect
  self._storyEntityList = {}
  self._paragraphList = {}
  self._currentParagraphID = -1
  self._nextParagraphID = nil
  self._currentSectionIndex = 1
  self._currentTime = 0
  self._currentTrackData = {}
  self._hide = false
  self._auto = false
  self._dialogRecord = {}
  self._orgBgmPlaying = false
  self._orgBgm = nil
  self._orgBgmFadeTime = 0.5
  self._layerDic = SortedDictionary:New()
  self._layerDic:Insert(1, {})
  self._debugMode = false
  self._entityInfoTemplate = nil
  self._loopCameraShakeData = {
    running = false,
    shakeData = {},
    timer = 0,
    curDuration = 0,
    tweener = nil
  }
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstid = roleModule:GetPstId()
  self._localBreakParapraphMark = pstid .. "LOCAL_BREAK_PARAGRAPH_INDEX"
  self._BeSkipped = 0
  AudioHelperController.RequestUISound(CriAudioIDConst.SoundStoryClick)
  self._recovertStandList = {}
end

function HomeStoryManager:Init(debugMode, entityInfoTemplate, yieldTime, isViewEnter)
  local storyConfigItem
  self._startTime = os.time()
  if EditorGlobal.IsEditorMode() then
    self._storyConfig = EditorGlobal.GetEditorRunStoryConfig()
    local editorStoryID = self._storyConfig.ID
    local tmp_cfgs = Cfg.cfg_homeland_event({StoryID = editorStoryID})
    if tmp_cfgs and table.count(tmp_cfgs) > 0 then
      storyConfigItem = tmp_cfgs[1]
    end
  elseif isViewEnter then
    local cfg = Cfg.cfg_home_story[self._storyID]
    local res, story = dofile(cfg.StoryScript)
    self._storyConfig = story
  else
    storyConfigItem = Cfg.cfg_homeland_event[self._storyID]
    if storyConfigItem then
      local cfg_home_story = Cfg.cfg_home_story[storyConfigItem.StoryID]
      local res, story = dofile(cfg_home_story.StoryScript)
      self._storyConfig = story
    end
  end
  if not self._storyConfig then
    Log.fatal("###[HomeStoryManager] can not find story, id: " .. self._storyID)
    self._end = true
    return
  end
  self._debugMode = debugMode
  self._entityInfoTemplate = entityInfoTemplate
  if not self._ignoreBreak then
    self._breakParagraphIds = self._storyConfig.breakParagraphIds
  end
  if self._breakParagraphIds then
    local breakIdx = LocalDB.GetInt(self._localBreakParapraphMark, 0)
    if 0 < breakIdx then
      self._currentParagraphID = self._breakParagraphIds[breakIdx]
    else
      self._currentParagraphID = self._storyConfig.StartParagraph
    end
  else
    self._currentParagraphID = self._storyConfig.StartParagraph
  end
  if self._revertBGM then
    self._orgBgmPlaying = AudioHelperController.BGMPlayerIsPlaying()
    if self._orgBgmPlaying then
      self._orgBgm = AudioHelperController.GetCurrentBgm()
    end
  end
  local playerPos
  if storyConfigItem and storyConfigItem.StoryRootPos then
    playerPos = Vector3(storyConfigItem.StoryRootPos[1], storyConfigItem.StoryRootPos[2], storyConfigItem.StoryRootPos[3])
  else
    playerPos = Vector3(0, 0, 0)
  end
  local playerRot
  if storyConfigItem and storyConfigItem.StoryRootRot then
    playerRot = Quaternion.Euler(Vector3(storyConfigItem.StoryRootRot[1], storyConfigItem.StoryRootRot[2], storyConfigItem.StoryRootRot[3]))
  else
    playerRot = Quaternion.identity
  end
  self._modelRoot.transform.position = playerPos
  self._modelRoot.transform.rotation = playerRot
  self:_InitEntities()
  self:_InitParagraphs()
  if yieldTime and 0 < yieldTime and false then
    GameGlobal.UIStateManager():Lock("HomeStoryManager_yieldTime")
    GameGlobal.Timer():AddEvent(yieldTime, function()
      GameGlobal.UIStateManager():UnLock("HomeStoryManager_yieldTime")
      self:_StartSection()
    end)
  else
    self:_StartSection()
  end
  if EditorGlobal.IsEditorMode() then
    local editorparam = EditorGlobal.GetEnterParam()
    self:_Seek(editorparam.ParagraphID, editorparam.SectionID)
  end
  local findName = "[H3DRenderSetting]"
  local findGo = UnityEngine.GameObject.Find(findName)
  if findGo then
    local h3dSetting = findGo:GetComponent(typeof(H3DRenderSetting))
    if h3dSetting then
      h3dSetting.enabled = false
      h3dSetting.enabled = true
    end
  end
end

function HomeStoryManager:SetNextParagraphID(ID)
  self._nextParagraphID = ID
end

function HomeStoryManager:GetCurrentTime()
  return self._currentTime
end

function HomeStoryManager:GetStoryUIRoot()
  return self._rootGameObject
end

function HomeStoryManager:GetCanvasRect()
  return self._canvasRect
end

function HomeStoryManager:GetStoryDialogUIRoot()
  return self._dialogRootGameObject
end

function HomeStoryManager:GetMaskTemplate()
  return self._maskTemplate
end

function HomeStoryManager:GetUIAtlas()
  return self._uiAtlas
end

function HomeStoryManager:PlaySound(entityID)
  local soundEntity = self._storyEntityList[entityID]
  if soundEntity and soundEntity:GetEntityType() == HomeStoryEntityType.Sound then
    soundEntity:PlaySound()
  end
end

function HomeStoryManager:StopSound(entityID)
  local soundEntity = self._storyEntityList[entityID]
  if soundEntity and soundEntity:GetEntityType() == HomeStoryEntityType.Sound then
    soundEntity:StopSound()
  end
end

function HomeStoryManager:PlayBgm(entityID, bgmFadeTime)
  local soundEntity = self._storyEntityList[entityID]
  if soundEntity and soundEntity:GetEntityType() == HomeStoryEntityType.Sound then
    soundEntity:PlayBgm(bgmFadeTime)
  end
end

function HomeStoryManager:GetEntity(id)
  local entity = self._storyEntityList[id]
  if entity then
    return entity
  end
end

function HomeStoryManager:GetEntityGo(id)
  local entity = self._storyEntityList[id]
  if entity then
    return entity:GetEntityGo()
  end
end

function HomeStoryManager:GetEntityPos(entityID)
  local soundEntity = self._storyEntityList[entityID]
  if soundEntity and soundEntity:GetEntityType() == HomeStoryEntityType.Model then
    return soundEntity:Pos()
  end
end

function HomeStoryManager:ActiveEntity(entityID, active)
  local entity = self._storyEntityList[entityID]
  if entity and entity:GetEntityType() == HomeStoryEntityType.Model then
    entity:SetActive(active)
  end
end

function HomeStoryManager:SetEntityPos(entityID, pos)
  local entity = self._storyEntityList[entityID]
  if entity and entity:GetEntityType() == HomeStoryEntityType.Model then
    entity:SetPos(pos)
  end
end

function HomeStoryManager:GetEntityHeadPos(entityID)
  local soundEntity = self._storyEntityList[entityID]
  if soundEntity and soundEntity:GetEntityType() == HomeStoryEntityType.Model then
    return soundEntity:HeadPos()
  end
end

function HomeStoryManager:SetSpeakState(entityID, speaking)
  local spineEntity = self._storyEntityList[entityID]
  if spineEntity and spineEntity:GetEntityType() == HomeStoryEntityType.Spine then
    spineEntity:SetSpeak(speaking)
  end
end

function HomeStoryManager:AddDialogRecord(speaker, content, isPlayer, icon, tips)
  self._dialogRecord[#self._dialogRecord + 1] = {
    speaker,
    content,
    isPlayer,
    icon,
    tips
  }
end

function HomeStoryManager:GetDialogRecord()
  return self._dialogRecord
end

function HomeStoryManager:InitLayerInfo(trans)
  local layerTable = self._layerDic:Find(1)
  layerTable[#layerTable + 1] = trans
end

function HomeStoryManager:SetLayer(trans, layer)
  local layerDic = self._layerDic
  for i = 1, layerDic:Size() do
    local layerTable = layerDic:GetAt(i)
    table.removev(layerTable, trans)
  end
  local layerTable = self._layerDic:Find(layer)
  if layerTable == nil then
    layerTable = {}
    self._layerDic:Insert(layer, layerTable)
  end
  layerTable[#layerTable + 1] = trans
  self:_resetLayers()
end

function HomeStoryManager:_resetLayers()
  local layerDic = self._layerDic
  for i = 1, layerDic:Size() do
    local layerTable = layerDic:GetAt(i)
    for j = 1, #layerTable do
      layerTable[j]:SetAsLastSibling()
    end
  end
end

function HomeStoryManager:_InitEntities()
  local entityConfig = self._storyConfig.Entities
  if not entityConfig then
    return
  end
  for _, entity in ipairs(entityConfig) do
    local storyEntity = self:_CreateStoryEntity(entity.EntityID, entity.Type, entity.Resource, entity)
    if storyEntity then
      self._storyEntityList[storyEntity:GetID()] = storyEntity
    else
      self._end = true
      return
    end
  end
end

function HomeStoryManager:_InitParagraphs()
  self._paragraphList = self._storyConfig.Paragraphs
  local paragraph = self._paragraphList[self._currentParagraphID]
  if not paragraph then
    Log.fatal("###[HomeStoryManager] 不存在ID为" .. self._currentParagraphID .. "的剧情段落,剧情结束")
    self._end = true
    return
  end
  if paragraph.NextParagraphID then
    self:SetNextParagraphID(paragraph.NextParagraphID)
  end
end

function HomeStoryManager:_CreateStoryEntity(ID, type, resourceName, entityConfig)
  local request, gameObject, skinid
  if type == "Effect" or type == "Dialog" or type == "Model" or type == "CameraVC" or type == "Picture" then
    if type == "Model" then
      request, gameObject, skinid = self:LoadModel(entityConfig)
      if request then
        gameObject.transform:SetParent(self._modelRoot.transform, false)
      else
        self._end = true
        return
      end
    else
      request = ResourceManager:GetInstance():SyncLoadAsset(resourceName, LoadType.GameObject)
      if request then
        gameObject = request.Obj
        if type == "Dialog" then
          gameObject.transform:SetParent(self._dialogRootGameObject.transform, false)
        elseif type == "CameraVC" then
          gameObject.transform:SetParent(self._modelRoot.transform, false)
        else
          gameObject.transform:SetParent(self._rootGameObject.transform, false)
        end
      else
        self._end = true
        return
      end
    end
  end
  local storyEntity
  if type == "Dialog" then
    storyEntity = HomeStoryEntityDialog:New(ID, gameObject, request, self, self._UIHomeStoryController)
  elseif type == "Effect" then
    storyEntity = HomeStoryEntityEffect:New(ID, gameObject, request, self)
  elseif type == "Sound" then
    storyEntity = HomeStoryEntitySound:New(ID, resourceName, self)
  elseif type == "PostProcessing" then
    storyEntity = HomeStoryEntityPostProcessing:New(ID, resourceName, self)
  elseif type == "Model" then
    storyEntity = HomeStoryEntityModel:New(ID, gameObject, request, self, entityConfig, self._modelRoot.transform, skinid)
  elseif type == "Picture" then
    storyEntity = HomeStoryEntityPicture:New(ID, gameObject, request, self, entityConfig)
  elseif type == "CameraVC" then
    storyEntity = HomeStoryEntityCameraVC:New(ID, gameObject, request, self, entityConfig)
  end
  return storyEntity
end

function HomeStoryManager:DisposeAnimRes()
  if self._animResList and #self._animResList > 0 then
    for i = 1, #self._animResList do
      self._animResList[i]:Dispose()
    end
  end
  self._animResList = nil
end

function HomeStoryManager:LoadModel(cfg)
  local resName, request, go, skinid
  if cfg.SubType == "Pet" then
    local petid = cfg.PetID
    if petid and not self._debugMode then
      local pet = GameGlobal.GetModule(PetModule):GetPetByTemplateId(petid)
      if pet then
        resName = pet:GetPetPrefab()
      else
        resName = cfg.Resource
        petid = string.gsub(resName, ".prefab", "")
      end
    else
      resName = cfg.Resource
      petid = string.gsub(resName, ".prefab", "")
    end
    skinid = string.gsub(resName, ".prefab", "")
    request = ResourceManager:GetInstance():SyncLoadAsset(resName, LoadType.GameObject)
    if request then
      go = request.Obj
    end
    local root = go.transform:Find("Root").gameObject
    local animator = root:GetComponent(typeof(UnityEngine.Animator))
    UnityEngine.Object.Destroy(animator)
    local animation = root:AddComponent(typeof(UnityEngine.Animation))
    local _aircraftAnimName = HelperProxy:GetInstance():GetPetAnimatorControllerName(resName, PetAnimatorControllerType.Aircraft)
    local _homelandAnimName = HelperProxy:GetInstance():GetPetAnimatorControllerName(resName, PetAnimatorControllerType.Homeland)
    local homelandStoryAnimName = HelperProxy:GetInstance():GetPetAnimatorControllerName(resName, PetAnimatorControllerType.HomelandStory)
    local airReq = ResourceManager:GetInstance():SyncLoadAsset(_aircraftAnimName, LoadType.GameObject)
    local homeReq = ResourceManager:GetInstance():SyncLoadAsset(_homelandAnimName, LoadType.GameObject)
    local homeStoryReq = ResourceManager:GetInstance():SyncLoadAsset(homelandStoryAnimName, LoadType.GameObject)
    if airReq then
      local airAnim = airReq.Obj:GetComponent(typeof(UnityEngine.Animation))
      if airAnim then
        local clips_air = HelperProxy:GetInstance():GetAllAnimationClip(airAnim)
        for i = 0, clips_air.Length - 1 do
          if clips_air[i] == nil then
            Log.exception("###[HomeStoryManager] Pet animation is null:", petid, ", index:", i)
          else
            animation:AddClip(clips_air[i], clips_air[i].name)
          end
        end
        animation.clip = airAnim.clip
      end
    end
    if homeReq then
      local homeAnim = homeReq.Obj:GetComponent(typeof(UnityEngine.Animation))
      if homeAnim then
        local clips_home = HelperProxy:GetInstance():GetAllAnimationClip(homeAnim)
        for i = 0, clips_home.Length - 1 do
          if clips_home[i] == nil then
            Log.exception("###[HomeStoryManager] Pet animation is null:", petid, ", index:", i)
          else
            animation:AddClip(clips_home[i], clips_home[i].name)
          end
        end
      end
    end
    if homeStoryReq then
      local homeStoryAnim = homeStoryReq.Obj:GetComponent(typeof(UnityEngine.Animation))
      if homeStoryAnim then
        local clips_home = HelperProxy:GetInstance():GetAllAnimationClip(homeStoryAnim)
        for i = 0, clips_home.Length - 1 do
          if clips_home[i] == nil then
            Log.exception("###[HomeStoryManager] Pet animation is null:", petid, ", index:", i)
          else
            animation:AddClip(clips_home[i], clips_home[i].name)
          end
        end
      end
    end
    animation:Play(HomelandPetAnimName.Stand)
    if airReq then
      table.insert(self._animResList, airReq)
    end
    if homeReq then
      table.insert(self._animResList, homeReq)
    end
    if homeStoryReq then
      table.insert(self._animResList, homeStoryReq)
    end
    local rootTr = root.transform
    for i = 0, rootTr.childCount - 1 do
      local child = rootTr:GetChild(i)
      if string.find(child.name, "weapon") then
        child.gameObject:SetActive(false)
      end
    end
  elseif cfg.SubType == "Player" then
    resName = cfg.Resource
    request = ResourceManager:GetInstance():SyncLoadAsset(resName, LoadType.GameObject)
    if request then
      go = request.Obj
    end
    local _name = string.gsub(resName, ".prefab", "")
    skinid = string.gsub(resName, ".prefab", "")
    local _aniResReq = ResourceManager:GetInstance():SyncLoadAsset(_name .. "_battle.prefab", LoadType.GameObject)
    local anim = _aniResReq.Obj:GetComponent(typeof(UnityEngine.Animator))
    local animator = go:GetComponentInChildren(typeof(UnityEngine.Animator))
    animator.runtimeAnimatorController = anim.runtimeAnimatorController
    if _aniResReq then
      table.insert(self._animResList, _aniResReq)
    end
  elseif cfg.SubType == "Other" then
    resName = cfg.Resource
    request = ResourceManager:GetInstance():SyncLoadAsset(resName, LoadType.GameObject)
    if request then
      go = request.Obj
    end
  elseif cfg.SubType == "NPC" then
    resName = cfg.Resource
    request = ResourceManager:GetInstance():SyncLoadAsset(resName, LoadType.GameObject)
    if request then
      go = request.Obj
    end
    local root = go.transform:Find("Root").gameObject
    local rootTr = root.transform
    for i = 0, rootTr.childCount - 1 do
      local child = rootTr:GetChild(i)
      if string.find(child.name, "weapon") then
        child.gameObject:SetActive(false)
      end
    end
  else
    resName = cfg.Resource
    request = ResourceManager:GetInstance():SyncLoadAsset(resName, LoadType.GameObject)
    if request then
      go = request.Obj
    end
  end
  if not request then
    Log.error("###[HomeStoryManager] cfg find asset name : ", resName)
  end
  return request, go, skinid
end

function HomeStoryManager:_StartSection()
  local paragraph = self._paragraphList[self._currentParagraphID]
  if not paragraph then
    Log.fatal("###[HomeStoryManager] 不存在ID为" .. self._currentParagraphID .. "的剧情段落,剧情结束")
    self._end = true
    return
  end
  local section = paragraph.Sections[self._currentSectionIndex]
  if not section then
    Log.fatal("###[HomeStoryManager] 剧情段落'" .. self._currentParagraphID .. "'中不存在序号为" .. self._currentSectionIndex .. "的小节,剧情结束")
    self._end = true
    return
  end
  if paragraph.ForceAutoDialog then
    self._leftButtonRootGameObject:SetActive(false)
  else
    self._leftButtonRootGameObject:SetActive(true)
  end
  for trackID, track in ipairs(section) do
    self._currentTrackData[track] = false
    if track.RefEntityID then
      local storyEntity = self._storyEntityList[track.RefEntityID]
      if storyEntity then
        storyEntity:SectionStart(track)
        if self._debugMode and self._entityInfoTemplate and storyEntity._gameObject then
          local entityDebugInfo = storyEntity._gameObject.transform:Find("EntityInfo")
          if not entityDebugInfo then
            entityDebugInfo = UnityEngine.GameObject.Instantiate(self._entityInfoTemplate, storyEntity._gameObject.transform)
            entityDebugInfo.transform.localPosition = Vector3(-120, 40, 0)
            entityDebugInfo:SetActive(true)
          end
          entityDebugInfo.transform:Find("EntityIDText"):GetComponent("Text").text = "EntityID:" .. storyEntity._ID
          entityDebugInfo.transform:Find("TrackIDText"):GetComponent("Text").text = "TrackID:" .. trackID
        end
      end
    elseif track.BgmTrack then
      self._storyBgmTrackController:SectionStart(track)
    elseif track.CameraTrack then
      self._storyCameraTrackController:SectionStart(track)
    end
  end
  if section.NextParagraphID then
    self:SetNextParagraphID(section.NextParagraphID)
  end
  if section.ButtonVisible ~= nil then
    self._buttonRootGameObject:SetActive(section.ButtonVisible and not self._auto and not self._hide)
  end
end

function HomeStoryManager:_EndSection()
  for track, _ in pairs(self._currentTrackData) do
    self._currentTrackData[track] = true
    if track.RefEntityID then
      local storyEntity = self._storyEntityList[track.RefEntityID]
      if storyEntity then
        storyEntity:SectionEnd()
      end
    elseif track.BgmTrack then
      self._storyBgmTrackController:SectionEnd()
    elseif track.CameraTrack then
      self._storyCameraTrackController:SectionEnd()
    end
  end
end

function HomeStoryManager:_UpdateTracks()
  if self._skipGaragraph then
    self._skipGaragraph = false
    return true
  end
  local allTrackEnd = true
  for track, trackEnd in pairs(self._currentTrackData) do
    if not trackEnd then
      if track.RefEntityID then
        local storyEntity = self._storyEntityList[track.RefEntityID]
        local trackEnd = true
        if storyEntity then
          trackEnd = storyEntity:Update(self._currentTime)
        end
        self._currentTrackData[track] = trackEnd
        if not trackEnd then
          allTrackEnd = trackEnd
        end
      elseif track.BgmTrack then
        self._storyBgmTrackController:Update(self._currentTime)
      elseif track.CameraTrack then
        local cameraTrackEnd = self._storyCameraTrackController:Update(self._currentTime)
        if not cameraTrackEnd then
          allTrackEnd = cameraTrackEnd
        end
      end
    end
  end
  return allTrackEnd
end

function HomeStoryManager:IsEnd()
  return self._end
end

function HomeStoryManager:Update(delteTimeMS)
  if self._end then
    return
  end
  self._currentTime = self._currentTime + delteTimeMS / 1000
  local sectionEnd = self:_UpdateTracks()
  if sectionEnd then
    self:_EndSection()
    self._currentSectionIndex = self._currentSectionIndex + 1
    if self._paragraphList[self._currentParagraphID].Sections[self._currentSectionIndex] then
      self:_StartSection()
      self._currentTime = 0
      self:_UpdateTracks()
    elseif not self._nextParagraphID or self._nextParagraphID == self._currentParagraphID then
      self._end = true
    else
      self._currentParagraphID = self._nextParagraphID
      if self._breakParagraphIds then
        local breakIdx = table.ikey(self._breakParagraphIds, self._currentParagraphID)
        if breakIdx then
          LocalDB.SetInt(self._localBreakParapraphMark, breakIdx)
        end
      end
      self._currentSectionIndex = 1
      self._currentTime = 0
      self:_StartSection()
      self:_UpdateTracks()
    end
  end
  self:_UpdateLoopCameraShake(delteTimeMS / 1000)
  self:_UpdateCameraPathAndFov(delteTimeMS / 1000)
end

function HomeStoryManager:RemoveRecoverStandEntity(entityid)
  Log.debug("###[recover stand] 移除entity:", entityid)
  if self._recovertStandList[entityid] then
    local hadEvent = self._recovertStandList[entityid]
    GameGlobal.Timer():CancelEvent(hadEvent)
    self._recovertStandList[entityid] = nil
    Log.debug("###[recover stand] 移除成功")
  end
end

function HomeStoryManager:AddRecoverStandEntity(length, entityid)
  Log.debug("###[recover stand] 添加entity:", entityid)
  if self._recovertStandList[entityid] then
    local hadEvent = self._recovertStandList[entityid]
    GameGlobal.Timer():CancelEvent(hadEvent)
    hadEvent = nil
    Log.debug("###[recover stand] 已经存在，移除成功")
  end
  local event = GameGlobal.Timer():AddEvent(length, function(entityid)
    self:RecoverStand(entityid)
  end, entityid)
  self._recovertStandList[entityid] = event
  Log.debug("###[recover stand] 添加成功")
end

function HomeStoryManager:RecoverStand(entityid)
  Log.debug("###[recover stand] 回调entity:", entityid)
  self._recovertStandList[entityid] = nil
  local entity = self._storyEntityList[entityid]
  local go = entity:GetEntityGo()
  local animCmp = go:GetComponentInChildren(typeof(UnityEngine.Animation))
  if animCmp then
    animCmp:CrossFade("stand", 0.2)
  end
end

function HomeStoryManager:StartLoopShake(shakeData)
  self._loopCameraShakeData.running = true
  local duration = shakeData.Duration
  if shakeData.HandHeld == true then
    duration = (math.random() * 0.6 + 0.6) * duration
  end
  self._cameraTr:DOKill()
  self._loopCameraShakeData.shakeData = shakeData
  self._loopCameraShakeData.timer = 0
  self._loopCameraShakeData.curDuration = duration
  self._loopCameraShakeData.tweener = self._cameraTr:DOShakePosition(duration, Vector3(self._loopCameraShakeData.shakeData.Strength[1], self._loopCameraShakeData.shakeData.Strength[2], self._loopCameraShakeData.shakeData.Strength[3]), self._loopCameraShakeData.shakeData.Vibrato, self._loopCameraShakeData.shakeData.RandomNess, false, self._loopCameraShakeData.shakeData.FadeOut)
end

function HomeStoryManager:StopLoopShake(shakeData)
  if not self._loopCameraShakeData.running then
    return
  end
  self._loopCameraShakeData.running = false
  self._cameraTr:DOKill()
  self._cameraTr.localPosition = Vector3(0, 0, 0)
  if shakeData and shakeData.FadeOut then
    self._cameraTr:DOShakePosition(shakeData.Duration, Vector3(self._loopCameraShakeData.shakeData.Strength[1], self._loopCameraShakeData.shakeData.Strength[2], self._loopCameraShakeData.shakeData.Strength[3]), self._loopCameraShakeData.shakeData.Vibrato, self._loopCameraShakeData.shakeData.RandomNess, false, true)
  end
  self._loopCameraShakeData = {}
end

function HomeStoryManager:_UpdateLoopCameraShake(deltaTime)
  if not self._loopCameraShakeData.running then
    return
  end
  self._loopCameraShakeData.timer = self._loopCameraShakeData.timer + deltaTime
  if self._loopCameraShakeData.timer > self._loopCameraShakeData.curDuration then
    local duration = self._loopCameraShakeData.shakeData.Duration
    if self._loopCameraShakeData.shakeData.HandHeld == true then
      duration = (math.random() * 0.6 + 0.6) * duration
    end
    self._cameraTr:DOKill()
    self._loopCameraShakeData.timer = 0
    self._loopCameraShakeData.curDuration = duration
    self._loopCameraShakeData.tweener = self._cameraTr:DOShakePosition(duration, Vector3(self._loopCameraShakeData.shakeData.Strength[1], self._loopCameraShakeData.shakeData.Strength[2], self._loopCameraShakeData.shakeData.Strength[3]), self._loopCameraShakeData.shakeData.Vibrato, self._loopCameraShakeData.shakeData.RandomNess, false, self._loopCameraShakeData.shakeData.FadeOut)
  end
end

function HomeStoryManager:_UpdateCameraPathAndFov(deltaTime)
  if self._storyCameraTrackController then
    self._storyCameraTrackController:OnUpdate(deltaTime)
  end
end

function HomeStoryManager:Destroy()
  if self._recovertStandList then
    for key, event in pairs(self._recovertStandList) do
      GameGlobal.Timer():CancelEvent(event)
    end
  end
  if self._debugMode then
  else
    local costSecond = os.time() - self._startTime
    TaskManager:GetInstance():StartTask(function(TT)
      GameGlobal.GetModule(RoleModule):OnEndStory(TT, self._storyID, self._currentParagraphID, self._currentSectionIndex, self._BeSkipped, costSecond)
    end, self)
  end
  Log.sys("###[HomeStoryManager] 剧情资源销毁")
  for _, storyEntity in pairs(self._storyEntityList) do
    storyEntity:Destroy()
  end
  self:DisposeAnimRes()
  if self._revertBGM then
    if self._orgBgmPlaying then
      AudioHelperController.PlayBGM(self._orgBgm, self._orgBgmFadeTime)
    else
      AudioHelperController.StopBGM()
    end
  end
  self._layerDic:Clear()
  self:StopLoopShake(nil)
  AudioHelperController.ReleaseUISoundById(CriAudioIDConst.SoundStoryClick)
end

function HomeStoryManager:SkipParagraph()
  if self._breakParagraphIds then
    local breakIdx = LocalDB.GetInt(self._localBreakParapraphMark)
    if self._breakParagraphIds[breakIdx + 1] then
      self._skipGaragraph = true
      self._currentParagraphID = self._breakParagraphIds[breakIdx + 1]
      LocalDB.SetInt(self._localBreakParapraphMark, breakIdx + 1)
      self._currentSectionIndex = 0
      self._currentTime = 0
    else
      self._skipGaragraph = false
      self:SkipStory()
    end
  else
    self._skipGaragraph = false
    self:SkipStory()
  end
end

function HomeStoryManager:SkipStory()
  if self._debugMode then
  else
    TaskManager:GetInstance():StartTask(function(TT)
      GameGlobal.GetModule(RoleModule):OnSkipStory(TT, self._storyID)
    end, self)
  end
  self._BeSkipped = 1
  self._end = true
  self:StopLoopShake(nil)
end

function HomeStoryManager:HideUI(hide)
  self._hide = hide
  self._buttonRootGameObject:SetActive(not hide)
  for index, storyEntity in ipairs(self._storyEntityList) do
    if storyEntity:GetEntityType() == HomeStoryEntityType.Dialog then
      storyEntity:HideUI(hide)
    end
  end
end

function HomeStoryManager:SetAuto(auto)
  self._auto = auto
  self._buttonRootGameObject:SetActive(not auto)
  for index, storyEntity in ipairs(self._storyEntityList) do
    if storyEntity:GetEntityType() == HomeStoryEntityType.Dialog then
      storyEntity:SetAuto(auto)
    end
  end
end

function HomeStoryManager:GetCurStoryID()
  return self._storyID
end

function HomeStoryManager:GetCurParagraphID()
  return self._currentParagraphID
end

function HomeStoryManager:GetCurParagraph()
  return self._paragraphList[self._currentParagraphID]
end

function HomeStoryManager:GetCurSectionIndex()
  return self._currentSectionIndex
end

function HomeStoryManager:GetCurrentTime()
  return self._currentTime
end

function HomeStoryManager:GetCurLanguageStr()
  if not self._curLanguageStr then
    local lan = Localization.GetCurLanguage()
    if type(lan) ~= "string" then
      lan = lan:ToString()
    end
    self._curLanguageStr = lan
  end
  return self._curLanguageStr
end

function HomeStoryManager:GetStoryCamera()
  return self._mainCameraTr
end
