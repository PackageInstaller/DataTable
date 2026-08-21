_class("StoryManager", Object)
StoryManager = StoryManager

function StoryManager:Constructor(uiStoryController, storyID, revertBGM, ignoreBreak)
  self._storyID = storyID
  self._rootGameObject = uiStoryController:GetGameObject("StoryRoot")
  self._topRootGameObject = uiStoryController:GetGameObject("StoryTopRoot")
  self._dialogRootGameObject = uiStoryController:GetGameObject("DialogRoot")
  self._buttonRootGameObject = uiStoryController:GetGameObject("ButtonRoot")
  self._leftButtonRootGameObject = uiStoryController:GetGameObject("LeftButtonRoot")
  self._maskTemplate = uiStoryController:GetGameObject("MaskTemplate")
  self._maskHorizontalTemplate = uiStoryController:GetGameObject("MaskHorizontalTemplate")
  self._spineSliceMaskTemplate = uiStoryController:GetGameObject("SpineSliceMaskTemplate")
  self._spineSliceHorizontalMaskTemplate = uiStoryController:GetGameObject("SpineSliceHorizontalMaskTemplate")
  self._SpineCircleMaskTemplate = uiStoryController:GetGameObject("SpineCircleMaskTemplate")
  self._uiAtlas = uiStoryController:GetAsset("UIStory.spriteatlas", LoadType.SpriteAtlas)
  self._revertBGM = revertBGM
  self._ignoreBreak = ignoreBreak
  self._end = false
  self._storyConfig = nil
  self._uiStoryController = uiStoryController
  self._storyBgmTrackController = StoryBgmTrackController:New(self)
  self._storyCameraTrackController = StoryCameraTrackController:New(self)
  self._canvasRect = self._rootGameObject.transform.parent.parent.parent:GetComponent("RectTransform").rect
  self._storyEntityList = {}
  self._paragraphList = {}
  self._currentParagraphID = -1
  self._nextParagraphID = nil
  self._currentSectionIndex = 1
  self._currentTime = 0
  self._currentTrackData = {}
  self._optionLoop = false
  self._loopOverParagraphID = -1
  self._optionLoopStartParagraphID = -1
  self._optionRecord = {}
  self._hide = false
  self._auto = false
  self._SrcTimeScale = UnityEngine.Time.timeScale
  self._CurTimeScale = UnityEngine.Time.timeScale
  self._dialogRecord = {}
  self._orgBgmPlaying = false
  self._orgBgm = nil
  self._orgBgmFadeTime = 0.5
  self._layerDic = SortedDictionary:New()
  self._layerDic:Insert(1, {})
  self._debugMode = false
  self._entityInfoTemplate = nil
  self._jumping = false
  self._dialogEntity = nil
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
  if storyID ~= 10010101 then
    self._localBreakParapraphMark = self._localBreakParapraphMark .. storyID
  end
  self._BeSkipped = 0
  AudioHelperController.RequestUISound(CriAudioIDConst.SoundStoryClick)
end

function StoryManager:Init(debugMode, entityInfoTemplate)
  self._startTime = os.time()
  if EditorGlobal.IsEditorMode() then
    self._storyConfig = EditorGlobal.GetEditorRunStoryConfig()
  else
    local storyConfigItem = Cfg.cfg_story[self._storyID]
    if storyConfigItem then
      local res, story = dofile(storyConfigItem.StoryScript)
      self._storyConfig = story
    end
  end
  if not self._storyConfig then
    Log.fatal("can not find story, id: " .. self._storyID)
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
    if 0 < breakIdx and self._breakParagraphIds[breakIdx] then
      self._currentParagraphID = self._breakParagraphIds[breakIdx]
    else
      self._currentParagraphID = self._storyConfig.StartParagraph
    end
  else
    self._currentParagraphID = self._storyConfig.StartParagraph
  end
  self._skipBlockIds = self._storyConfig.SkipBlockIDs
  if self._revertBGM then
    self._orgBgmPlaying = AudioHelperController.BGMPlayerIsPlaying()
    if self._orgBgmPlaying then
      self._orgBgm = AudioHelperController.GetCurrentBgm()
    end
  end
  self:_InitEntities()
  self:_InitParagraphs()
  self:_StartSection()
  if EditorGlobal.IsEditorMode() then
    TaskManager:GetInstance():StartTask(function(TT)
      YIELD(TT)
      local editorparam = EditorGlobal.GetEnterParam()
      self:_Seek(editorparam.ParagraphID, editorparam.SectionID)
    end)
  end
end

function StoryManager:SetNextParagraphID(ID)
  self._nextParagraphID = ID
end

function StoryManager:AddSelectOptionID(currentTrackData, optionId)
  if currentTrackData.Options.OptionLoop == nil then
    return
  end
  if self._optionRecord[currentTrackData.DialogContentStr] == nil then
    self._optionRecord[currentTrackData.DialogContentStr] = {}
    self._optionLoopStartParagraphID = self._currentParagraphID
  end
  self._optionRecord[currentTrackData.DialogContentStr][optionId] = optionId
  if currentTrackData.Options and currentTrackData.Options.OptionLoop then
    self._optionLoop = true
  end
end

function StoryManager:GetOptionData(options, dialogContentStr)
  if not options.OptionLoop then
    return options
  end
  if self._optionRecord[dialogContentStr] == nil then
    return options
  end
  local currentOpitons = {}
  for index, option in ipairs(options) do
    if not self._optionRecord[dialogContentStr][index] then
      option.optionIndex = index
      table.insert(currentOpitons, option)
    end
  end
  return currentOpitons
end

function StoryManager:CheckOptionLoopOver(options, dialogContentStr)
  if self._optionRecord[dialogContentStr] == nil then
    return
  end
  local optionRCont = 0
  for _, _ in pairs(self._optionRecord[dialogContentStr]) do
    optionRCont = optionRCont + 1
  end
  if optionRCont == #options then
    self._optionLoop = false
    self._optionRecord = {}
  end
end

function StoryManager:GetCurrentTime()
  return self._currentTime
end

function StoryManager:GetStoryUIRoot()
  return self._rootGameObject
end

function StoryManager:GetCanvasRect()
  return self._canvasRect
end

function StoryManager:GetStoryDialogUIRoot()
  return self._dialogRootGameObject
end

function StoryManager:GetMaskTemplate()
  return self._maskTemplate
end

function StoryManager:GetMaskHorizontalTemplate()
  return self._maskHorizontalTemplate
end

function StoryManager:GetSpineSliceMaskTemplate()
  return self._spineSliceMaskTemplate
end

function StoryManager:GetSpineSliceHorizontalMaskTemplate()
  return self._spineSliceHorizontalMaskTemplate
end

function StoryManager:GetSpineCircleMaskTemplate()
  return self._SpineCircleMaskTemplate
end

function StoryManager:GetUIAtlas()
  return self._uiAtlas
end

function StoryManager:PlaySound(entityID)
  local soundEntity = self._storyEntityList[entityID]
  if soundEntity and soundEntity:GetEntityType() == StoryEntityType.Sound then
    soundEntity:PlaySound()
  end
end

function StoryManager:StopSound(entityID)
  local soundEntity = self._storyEntityList[entityID]
  if soundEntity and soundEntity:GetEntityType() == StoryEntityType.Sound then
    soundEntity:StopSound()
  end
end

function StoryManager:PlayBgm(entityID, bgmFadeTime)
  local soundEntity = self._storyEntityList[entityID]
  if soundEntity and soundEntity:GetEntityType() == StoryEntityType.Sound then
    soundEntity:PlayBgm(bgmFadeTime)
  end
end

function StoryManager:SetSpeakState(entityID, speaking)
  local spineEntity = self._storyEntityList[entityID]
  if spineEntity and spineEntity:GetEntityType() == StoryEntityType.Spine then
    spineEntity:SetSpeak(speaking)
  end
end

function StoryManager:AddDialogRecord(speaker, content, speakerBG, isPlayer, voiceID)
  self._dialogRecord[#self._dialogRecord + 1] = {
    speaker,
    content,
    speakerBG,
    isPlayer,
    voiceID
  }
end

function StoryManager:GetDialogRecord()
  return self._dialogRecord
end

function StoryManager:InitLayerInfo(trans)
  local layerTable = self._layerDic:Find(1)
  layerTable[#layerTable + 1] = trans
end

function StoryManager:SetLayer(trans, layer)
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

function StoryManager:_resetLayers()
  local layerDic = self._layerDic
  for i = 1, layerDic:Size() do
    local layerTable = layerDic:GetAt(i)
    for j = 1, #layerTable do
      layerTable[j]:SetAsLastSibling()
    end
  end
end

function StoryManager:_InitEntities()
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

function StoryManager:_InitParagraphs()
  self._paragraphList = self._storyConfig.Paragraphs
  local paragraph = self._paragraphList[self._currentParagraphID]
  if not paragraph then
    Log.fatal("不存在ID为" .. self._currentParagraphID .. "的剧情段落,剧情结束")
    self._end = true
    return
  end
  if paragraph.NextParagraphID then
    self:SetNextParagraphID(paragraph.NextParagraphID)
  end
end

function StoryManager:_CreateStoryEntity(ID, type, resourceName, entityConfig)
  local request, gameObject
  if type ~= "Sound" and type ~= "PostProcessing" and type ~= "CrackMask" and type ~= "Usme" and type ~= "BgVedio" then
    request = ResourceManager:GetInstance():SyncLoadAsset(resourceName, LoadType.GameObject)
    if request then
      gameObject = request.Obj
      if type == "Dialog" or type == "AVGDialog" or type == "N28AVGDialog" or type == "IdolDialog" then
        gameObject.transform:SetParent(self._dialogRootGameObject.transform, false)
      elseif entityConfig.Root == "Top" then
        if entityConfig.Anchor then
          gameObject.transform:SetParent(self._topRootGameObject.transform:Find(entityConfig.Anchor .. "Anchor"), false)
        else
          gameObject.transform:SetParent(self._topRootGameObject.transform, false)
        end
      else
        gameObject.transform:SetParent(self._rootGameObject.transform, false)
      end
    else
      self._end = true
      return
    end
  elseif type == "Usme" or type == "BgVedio" then
    request = ResourceManager:GetInstance():SyncLoadAsset("StoryVideoItem.prefab", LoadType.GameObject)
    if request then
      gameObject = request.Obj
      if type == "Usme" then
        self._centerAnchor2GameObject = self._uiStoryController:GetGameObject("CenterAnchor2")
        gameObject.transform:SetParent(self._centerAnchor2GameObject.transform, false)
      end
      if type == "BgVedio" then
        gameObject.transform:SetParent(self._rootGameObject.transform, false)
      end
    else
      self._end = true
      return
    end
  end
  local storyEntity
  if type == "Dialog" then
    storyEntity = StoryEntityDialog:New(ID, gameObject, request, self)
    self._dialogEntity = storyEntity
  elseif type == "AVGDialog" then
    storyEntity = StoryEntityAVGDialog:New(ID, gameObject, request, self)
  elseif type == "N28AVGDialog" then
    storyEntity = N28StoryEntityAVGDialog:New(ID, gameObject, request, self)
  elseif type == "IdolDialog" then
    storyEntity = UIN25IdolStoryEntityDialog:New(ID, gameObject, request, self)
  elseif type == "Spine" then
    storyEntity = StoryEntitySpine:New(ID, gameObject, request, self, entityConfig)
  elseif type == "SpineSlice" then
    storyEntity = StoryEntitySpineSlice:New(ID, gameObject, request, self, entityConfig)
  elseif type == "SpineSliceHorizontal" then
    storyEntity = StoryEntitySpineSliceHorizontal:New(ID, gameObject, request, self, entityConfig)
  elseif type == "Picture" then
    storyEntity = StoryEntityPicture:New(ID, gameObject, request, self, entityConfig)
  elseif type == "Effect" then
    storyEntity = StoryEntityEffect:New(ID, gameObject, request, self)
  elseif type == "Text" then
    storyEntity = StoryEntityText:New(ID, gameObject, request, self)
  elseif type == "Sound" then
    storyEntity = StoryEntitySound:New(ID, resourceName, self)
  elseif type == "PostProcessing" then
    storyEntity = StoryEntityPostProcessing:New(ID, resourceName, self)
  elseif type == "SpineSliceEdge" then
    storyEntity = StoryEntitySpineSliceEdge:New(ID, gameObject, request, self, entityConfig)
  elseif type == "PictureSliceEdge" then
    storyEntity = StoryEntityPictureEdge:New(ID, gameObject, request, self, entityConfig)
  elseif type == "PictureSliceHorizontalEdge" then
    storyEntity = StoryEntityPictureHorizontalEdge:New(ID, gameObject, request, self, entityConfig)
  elseif type == "CrackMask" then
    storyEntity = StoryEntityCrackMask:New(ID, self)
  elseif type == "SpineCircleEdge" then
    storyEntity = StoryEntitySpineCircleEdge:New(ID, gameObject, request, self, entityConfig)
  elseif type == "SpotLight" then
    storyEntity = StoryEntitySpotLight:New(ID, gameObject, request, self, entityConfig)
  elseif type == "Sprite" then
    storyEntity = StoryEntitySprite:New(ID, gameObject, request, self, entityConfig)
  elseif type == "Usme" then
    storyEntity = StoryEntityVedioUsme:New(ID, gameObject, request, self, entityConfig, resourceName)
  elseif type == "BgVedio" then
    storyEntity = StoryEntityBgVedio:New(ID, gameObject, request, self, entityConfig, resourceName)
  end
  return storyEntity
end

function StoryManager:_StartSection()
  local paragraph = self._paragraphList[self._currentParagraphID]
  if not paragraph then
    Log.fatal("不存在ID为" .. self._currentParagraphID .. "的剧情段落,剧情结束")
    self._end = true
    return
  end
  local section = paragraph.Sections[self._currentSectionIndex]
  if not section then
    Log.fatal("剧情段落'" .. self._currentParagraphID .. "'中不存在序号为" .. self._currentSectionIndex .. "的小节,剧情结束")
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
        if track.Options and track.Options.LoopOverParagraphID ~= nil then
          self._loopOverParagraphID = track.Options.LoopOverParagraphID
        end
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

function StoryManager:GetUIRootButtonObject()
  return self._buttonRootGameObject
end

function StoryManager:_EndSection()
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

function StoryManager:_UpdateTracks()
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

function StoryManager:IsEnd()
  return self._end
end

function StoryManager:Update(delteTimeMS)
  if self._end then
    return
  end
  self._currentTime = self._currentTime + delteTimeMS / 1000
  local sectionEnd = self:_UpdateTracks()
  if sectionEnd then
    self:_EndSection()
    self._currentSectionIndex = self._currentSectionIndex + 1
    local curParagraph = self._paragraphList[self._currentParagraphID]
    if curParagraph and curParagraph.Sections and curParagraph.Sections[self._currentSectionIndex] then
      self:_StartSection()
      self._currentTime = 0
      self:_UpdateTracks()
    else
      if 0 < self._optionLoopStartParagraphID and self._currentParagraphID ~= self._optionLoopStartParagraphID then
        if self._optionLoop then
          self._nextParagraphID = self._optionLoopStartParagraphID
        else
          self._nextParagraphID = self._loopOverParagraphID
          self._optionLoopStartParagraphID = -1
          self._loopOverParagraphID = -1
        end
      end
      if not self._nextParagraphID or self._nextParagraphID == self._currentParagraphID then
        self._end = true
      else
        self._currentParagraphID = self._nextParagraphID
        if self._breakParagraphIds then
          local breakIdx = table.ikey(self._breakParagraphIds, self._currentParagraphID)
          if breakIdx then
            LocalDB.SetInt(self._localBreakParapraphMark, breakIdx)
          end
        end
        if 0 < self._optionLoopStartParagraphID and self._currentParagraphID == self._optionLoopStartParagraphID then
          local loopParagraph = self._paragraphList[self._currentParagraphID]
          self._currentSectionIndex = #loopParagraph.Sections
        else
          self._currentSectionIndex = 1
        end
        self._currentTime = 0
        self:_StartSection()
        self:_UpdateTracks()
      end
    end
  end
  self:_UpdateLoopCameraShake(delteTimeMS / 1000)
end

function StoryManager:StartLoopShake(shakeData)
  self._loopCameraShakeData.running = true
  local duration = shakeData.Duration
  if shakeData.HandHeld == true then
    duration = (math.random() * 0.6 + 0.6) * duration
  end
  self._rootGameObject.transform:DOKill()
  self._loopCameraShakeData.shakeData = shakeData
  self._loopCameraShakeData.timer = 0
  self._loopCameraShakeData.curDuration = duration
  self._loopCameraShakeData.tweener = self._rootGameObject.transform:DOShakePosition(duration, Vector3(self._loopCameraShakeData.shakeData.Strength[1], self._loopCameraShakeData.shakeData.Strength[2], 0), self._loopCameraShakeData.shakeData.Vibrato, self._loopCameraShakeData.shakeData.RandomNess, false, self._loopCameraShakeData.shakeData.FadeOut)
end

function StoryManager:StopLoopShake(shakeData)
  if not self._loopCameraShakeData.running then
    return
  end
  self._loopCameraShakeData.running = false
  self._rootGameObject.transform:DOKill()
  self._rootGameObject.transform.localPosition = Vector3(0, 0, 0)
  if shakeData and shakeData.FadeOut then
    self._rootGameObject.transform:DOShakePosition(shakeData.Duration, Vector3(self._loopCameraShakeData.shakeData.Strength[1], self._loopCameraShakeData.shakeData.Strength[2], 0), self._loopCameraShakeData.shakeData.Vibrato, self._loopCameraShakeData.shakeData.RandomNess, false, true)
  end
  self._loopCameraShakeData = {}
end

function StoryManager:_UpdateLoopCameraShake(deltaTime)
  if not self._loopCameraShakeData.running then
    return
  end
  self._loopCameraShakeData.timer = self._loopCameraShakeData.timer + deltaTime
  if self._loopCameraShakeData.timer > self._loopCameraShakeData.curDuration then
    local duration = self._loopCameraShakeData.shakeData.Duration
    if self._loopCameraShakeData.shakeData.HandHeld == true then
      duration = (math.random() * 0.6 + 0.6) * duration
    end
    self._rootGameObject.transform:DOKill()
    self._loopCameraShakeData.timer = 0
    self._loopCameraShakeData.curDuration = duration
    self._loopCameraShakeData.tweener = self._rootGameObject.transform:DOShakePosition(duration, Vector3(self._loopCameraShakeData.shakeData.Strength[1], self._loopCameraShakeData.shakeData.Strength[2], 0), self._loopCameraShakeData.shakeData.Vibrato, self._loopCameraShakeData.shakeData.RandomNess, false, self._loopCameraShakeData.shakeData.FadeOut)
  end
end

function StoryManager:AddAudioPlayCallback(callback)
  if self._dialogEntity then
    self._dialogEntity:AddAudioPlayCallback(callback)
  end
end

function StoryManager:Destroy()
  UnityEngine.Time.timeScale = self._SrcTimeScale
  AudioHelperController.SetUISoundPlaySpeed(UnityEngine.Time.timeScale)
  AudioHelperController.SetUIVoicePlaySpeed(UnityEngine.Time.timeScale)
  local costSecond = os.time() - self._startTime
  TaskManager:GetInstance():StartTask(function(TT)
    GameGlobal.GetModule(RoleModule):OnEndStory(TT, self._storyID, self._currentParagraphID, self._currentSectionIndex, self._BeSkipped, costSecond)
  end, self)
  Log.sys("剧情资源销毁")
  for _, storyEntity in pairs(self._storyEntityList) do
    storyEntity:Destroy()
  end
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

function StoryManager:SkipParagraph()
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
  elseif self._skipBlockIds then
    local blocked = false
    for _, id in ipairs(self._skipBlockIds) do
      if id > self._currentParagraphID then
        self._currentParagraphID = id
        self._skipGaragraph = true
        self._currentSectionIndex = 0
        self._currentTime = 0
        blocked = true
        break
      end
    end
    if not blocked then
      self._skipGaragraph = false
      self:SkipStory()
    end
  else
    self._skipGaragraph = false
    self:SkipStory()
  end
end

function StoryManager:SkipStory()
  TaskManager:GetInstance():StartTask(function(TT)
    GameGlobal.GetModule(RoleModule):OnSkipStory(TT, self._storyID)
  end, self)
  self._BeSkipped = 1
  self._end = true
  self:StopLoopShake(nil)
end

function StoryManager:HideUI(hide)
  self._hide = hide
  self._buttonRootGameObject:SetActive(not hide)
  for index, storyEntity in ipairs(self._storyEntityList) do
    local entityType = storyEntity:GetEntityType()
    if entityType == StoryEntityType.Dialog then
      storyEntity:HideUI(hide)
    elseif entityType == StoryEntityType.AVGDialog then
      storyEntity:HideUI(hide)
    end
  end
end

function StoryManager:SetSpeed(uiRefreshCB, state)
  local rate = math.floor(self._CurTimeScale / self._SrcTimeScale)
  if state == 1 then
    self._CurTimeScale = self._SrcTimeScale * self:GetSpeedDB()
  elseif state == 2 then
    self:SetSpeedDB(rate)
    self._CurTimeScale = self._SrcTimeScale
  else
    self._CurTimeScale = self._CurTimeScale * 2
    self._CurTimeScale = self._CurTimeScale > 4 and 1 or self._CurTimeScale
  end
  UnityEngine.Time.timeScale = self._CurTimeScale
  AudioHelperController.SetUISoundPlaySpeed(UnityEngine.Time.timeScale)
  AudioHelperController.SetUIVoicePlaySpeed(UnityEngine.Time.timeScale)
  if uiRefreshCB then
    rate = math.floor(self._CurTimeScale / self._SrcTimeScale)
    uiRefreshCB(rate)
  end
end

function StoryManager:GetSpeedDB()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. "StoryManagerSpeed"
  return LocalDB.GetInt(key, 1)
end

function StoryManager:SetSpeedDB(value)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. "StoryManagerSpeed"
  local new = LocalDB.SetInt(key, value)
end

function StoryManager:SetAuto(auto, id)
  self._auto = auto
  for index, storyEntity in ipairs(self._storyEntityList) do
    local entityType = storyEntity:GetEntityType()
    if entityType == StoryEntityType.Dialog then
      storyEntity:SetAuto(auto)
    elseif entityType == StoryEntityType.AVGDialog then
      storyEntity:SetAuto(auto, id)
    end
  end
end

function StoryManager:GetAuto()
  return self._auto
end

function StoryManager:GetCurStoryID()
  return self._storyID
end

function StoryManager:GetCurParagraphID()
  return self._currentParagraphID
end

function StoryManager:GetCurParagraph()
  return self._paragraphList[self._currentParagraphID]
end

function StoryManager:GetCurSectionIndex()
  return self._currentSectionIndex
end

function StoryManager:GetCurrentTime()
  return self._currentTime
end

function StoryManager:GetCurLanguageStr()
  if not self._curLanguageStr then
    local lan = Localization.GetCurLanguage()
    if type(lan) ~= "string" then
      lan = lan:ToString()
    end
    self._curLanguageStr = lan
  end
  return self._curLanguageStr
end

function StoryManager:GetStoryEntity(entityID)
  return self._storyEntityList[entityID]
end

function StoryManager:SetUIBlackSideSize(width, height)
  if GameGlobal.UIStateManager():IsShow("UIStoryController") then
    GameGlobal.UIStateManager():CallUIMethod("UIStoryController", "SetBlackSideSize", width, height)
  elseif GameGlobal.UIStateManager():IsShow("UIN20AVGStory") then
    GameGlobal.UIStateManager():CallUIMethod("UIN20AVGStory", "SetBlackSideSize", width, height)
  elseif GameGlobal.UIStateManager():IsShow("UIN28AVGStory") then
    GameGlobal.UIStateManager():CallUIMethod("UIN28AVGStory", "SetBlackSideSize", width, height)
  elseif GameGlobal.UIStateManager():IsShow("UIN25IdolStoryController") then
    GameGlobal.UIStateManager():CallUIMethod("UIN25IdolStoryController", "SetBlackSideSize", width, height)
  else
    Log.fatal("[Story] 没有处于显示状态的剧情界面")
  end
end

function StoryManager:GetUICanvasSize()
  if GameGlobal.UIStateManager():IsShow("UIStoryController") then
    return GameGlobal.UIStateManager():CallUIMethod("UIStoryController", "GetCanvasSize")
  elseif GameGlobal.UIStateManager():IsShow("UIN20AVGStory") then
    return GameGlobal.UIStateManager():CallUIMethod("UIN20AVGStory", "GetCanvasSize")
  elseif GameGlobal.UIStateManager():IsShow("UIN25IdolStoryController") then
    return GameGlobal.UIStateManager():CallUIMethod("UIN25IdolStoryController", "GetCanvasSize")
  elseif GameGlobal.UIStateManager():IsShow("UIN28AVGStory") then
    return GameGlobal.UIStateManager():CallUIMethod("UIN28AVGStory", "GetCanvasSize")
  else
    Log.fatal("[Story] 没有处于显示状态的剧情界面")
  end
end

function StoryManager:JumpTo(paragraphID, sectionID)
  local frameTime = 33.333333333333336
  local oriAuto = self._auto
  self:SetAuto(true)
  self._jumping = true
  local dialogRet
  while (paragraphID ~= self._currentParagraphID or sectionID ~= self._currentSectionIndex) and not self._forceStop do
    self:Update(frameTime)
    if self._end then
      break
    end
    local dialogEntity = self:GetDialogEntity(self._currentParagraphID, self._currentSectionIndex)
    if dialogEntity and dialogEntity._currentTrackData.Options then
      dialogRet = dialogEntity
      break
    end
    if dialogEntity and dialogEntity._currentTrackData.ShowEvidence then
      dialogRet = dialogEntity
      break
    end
  end
  self._jumping = false
  self:SetAuto(oriAuto)
  return dialogRet
end

function StoryManager:ForceJumpStop(flag)
  self._forceStop = flag
end

function StoryManager:IsJumping()
  return self._jumping
end

function StoryManager:GetDialogEntity(paragraphID, sectionID)
  local paragraph = self._paragraphList[paragraphID]
  if paragraph ~= nil then
    local section = paragraph.Sections[sectionID]
    if section ~= nil then
      for _, track in ipairs(section) do
        if track.RefEntityID then
          local entity = self._storyEntityList[track.RefEntityID]
          local entityType = entity:GetEntityType()
          if entityType == StoryEntityType.Dialog or entityType == StoryEntityType.AVGDialog then
            return entity
          end
        end
      end
    end
  end
end
