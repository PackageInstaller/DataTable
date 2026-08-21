_class("UIHomeMovieStoryController", UIController)
UIHomeMovieStoryController = UIHomeMovieStoryController

function UIHomeMovieStoryController:OnShow(uiParams)
  self._storyID = uiParams[1]
  self._debugMode = uiParams[7]
  self:AttachEvent(GameEventType.CloseHomeStory, self.CloseHomeStory)
  if not self._storyID then
    self._storyID = 1
  end
  if self._debugMode then
    self._storyRoot = UnityEngine.GameObject.Find("HomeStoryRoot")
    self._storyRoot:SetActive(true)
    self._storyRoot.transform.localPosition = Vector3(0, 0, 0)
    self._storyRoot.transform.localScale = Vector3(1, 1, 1)
    self._storyRoot.transform.rotation = Quaternion.identity
    self._mainCameraGo = self._storyRoot.transform:Find("StoryMainCamera")
    self._mainCameraGo.gameObject:SetActive(true)
    self._modelRoot = self._storyRoot
  else
    local uiHomeModule = self:GetUIModule(HomelandModule)
    self._client = uiHomeModule:GetClient()
    self._eventMgr = self._client:HomeEventManager()
    self._mainCameraGo = self._eventMgr:GetStoryCamera()
    self._eventMgr:ShowStoryCamera(true)
    local fatherBuild = MoviePrepareData:GetInstance():GetFatherBuild()
    local pos = fatherBuild:Pos()
    local rot = Quaternion.Euler(0, fatherBuild:RotY(), 0)
    local scale = Vector3.one
    self._eventMgr:SetStoryRoot(pos, rot, scale)
    self._modelRoot = self._eventMgr:GetStoryRoot()
    self._client:BeginStory()
    local inputMgr = self._client:InputManager()
    inputMgr:OnModeChanged(HomelandMode.Story)
    local storyCtl = inputMgr:GetControllerStory()
    storyCtl:SetActive(false)
    self._client:CharacterManager():HideNpcs()
  end
  self._endCallback = uiParams[2]
  self._revertBGM = uiParams[3] ~= false
  self._ignoreBreak = uiParams[4]
  local isViewEnter = true
  self._openTease = uiParams[5]
  self._isRecord = uiParams[6]
  self._rootGameObject = self:GetGameObject("StoryRoot")
  self._dialogRootGameObject = self:GetGameObject("DialogRoot")
  self._buttonRootGameObject = self:GetGameObject("ButtonRoot")
  self._leftButtonRootGameObject = self:GetGameObject("LeftButtonRoot")
  self._maskTemplate = self:GetGameObject("MaskTemplate")
  self._cancelHideButton = self:GetGameObject("CancelHideButton")
  self._cancelAutoButton = self:GetGameObject("CancelAutoButton")
  self._uiAtlas = self:GetAsset("UIStory.spriteatlas", LoadType.SpriteAtlas)
  self._bgRoot = self:GetGameObject("bgRoot")
  self._topBlackSide = self:GetGameObject("Top")
  self._bottomBlackSide = self:GetGameObject("Bottom")
  self._leftBlackSide = self:GetGameObject("Left")
  self._rightBlackSide = self:GetGameObject("Right")
  self._affinityWnd = self:GetGameObject("AffinityWnd")
  self._affinityPetHead = self:GetUIComponent("RawImageLoader", "Icon")
  self._petNameTxt = self:GetUIComponent("UILocalizationText", "PetName")
  self._affinityTxt = self:GetUIComponent("UILocalizationText", "Affinity")
  self._uiCanvasRect = self:GetUIComponent("RectTransform", "UICanvas")
  self._CurStatusTex = self:GetUIComponent("UILocalizationText", "CurStatusTex")
  local statusText = self._isRecord and StringTable.Get("str_movie_story_replaying") or StringTable.Get("str_movie_story_making")
  self._CurStatusTex:SetText(statusText)
  self._RightUpAnchor = self:GetGameObject("RightUpAnchor")
  self._BGBlur = self:GetUIComponent("H3DUIBlurHelper", "BGBlur")
  self._teaseImageObj = self:GetGameObject("TeaseImage")
  self._teaseBody = self:GetUIComponent("RawImageLoader", "TeaseBody")
  if not self._openTease then
    self._teaseImageObj:SetActive(false)
  end
  self._anim = self:GetUIComponent("Animation", "anim")
  self._storyManager = HomeMovieStoryManager:New(self._storyID, self, self._mainCameraGo, self._rootGameObject, self._modelRoot, self._dialogRootGameObject, self._buttonRootGameObject, self._leftButtonRootGameObject, self._maskTemplate, self._uiAtlas, self._revertBGM, self._ignoreBreak, self._openTease, self._isRecord)
  if self._debugMode then
    self._debugInfoRoot = self:GetGameObject("DebugInfoRoot")
    if self._debugInfoRoot then
      self._debugInfoRoot:SetActive(true)
    end
    self._paragraphText = self:GetUIComponent("Text", "ParagraphText")
    self._sectionText = self:GetUIComponent("Text", "SectionText")
    self._timeText = self:GetUIComponent("Text", "TimeText")
    self._entityInfo = self:GetGameObject("EntityInfo")
  end
  self._storyManager:Init(self._debugMode, self._entityInfo, 500, isViewEnter)
  self._closed = false
  self._dialogSpeakerBGBlue = "plot_juqing_xian4"
  self._dialogSpeakerBGRed = "plot_juqing_xian5"
  if EditorGlobal.IsEditorMode() then
    EditorGlobal.SetStroyController(self)
    EditorGlobal.SetStroyManager(self._storyManager)
  end
  CutsceneManager.ExcuteCutsceneOut()
  GameGlobal.UIStateManager():SetBlackSideVisible(false)
end

function UIHomeMovieStoryController:OnUpdate(deltaTimeMS)
  if not self._storyManager then
    return
  end
  self._storyManager:Update(deltaTimeMS)
  if self._debugMode then
    self:FillDebugInfo()
  end
  if self._storyManager:IsEnd() and not self._closed then
    self:_EndStory()
  end
end

function UIHomeMovieStoryController:CloseHomeStory()
  if self._storyManager then
    self._storyManager:Destroy()
    self._storyManager = nil
  end
end

function UIHomeMovieStoryController:OnHide()
  if self._storyManager then
    self._storyManager:Destroy()
    self._storyManager = nil
  end
  self:DetachEvent(GameEventType.CloseHomeStory, self.CloseHomeStory)
  if self._tweenQueue then
    self._tweenQueue:Complete(false)
    self._tweenQueue = nil
  end
  local login_module = GameGlobal.GetModule(LoginModule)
  GameGlobal.UAReportForceGuideEvent("StoryEnd", {
    self._storyID
  })
  if self._3dModelTimer then
    GameGlobal.Timer():CancelEvent(self._3dModelTimer)
  end
  if self._FaceTimer then
    GameGlobal.Timer():CancelEvent(self._FaceTimer)
  end
  if not self._debugMode then
    self._eventMgr:StopStory(self._storyID)
  end
end

function UIHomeMovieStoryController:SetBlackSideSize(width, height)
  self._topBlackSide:GetComponent("RectTransform").sizeDelta = Vector2(0, height)
  self._bottomBlackSide:GetComponent("RectTransform").sizeDelta = Vector2(0, height)
  self._topBlackSide:SetActive(0 < height)
  self._bottomBlackSide:SetActive(0 < height)
  self._leftBlackSide:GetComponent("RectTransform").sizeDelta = Vector2(width, 0)
  self._rightBlackSide:GetComponent("RectTransform").sizeDelta = Vector2(width, 0)
  self._leftBlackSide:SetActive(0 < width)
  self._rightBlackSide:SetActive(0 < width)
end

function UIHomeMovieStoryController:GetCanvasSize()
  return self._uiCanvasRect.sizeDelta.x, self._uiCanvasRect.sizeDelta.y
end

function UIHomeMovieStoryController:FillDebugInfo()
  if self._paragraphText and self._sectionText and self._timeText then
    self._paragraphText.text = self._storyManager:GetCurParagraphID()
    self._sectionText.text = self._storyManager:GetCurSectionIndex()
    self._timeText.text = string.format("%.1f", self._storyManager:GetCurrentTime())
  end
end

function UIHomeMovieStoryController:SetTeaseBodyImage(image)
  self._teaseBody:LoadImage(image)
end

function UIHomeMovieStoryController:SetTeaseHeadActive(active)
  if active then
    self._anim:Play("UIHomeMovieStoryController_in")
  else
    self._anim:Play("UIHomeMovieStoryController_out")
  end
end

function UIHomeMovieStoryController:ShowPetModel(petName, root)
  self._BGBlur.gameObject:SetActive(true)
  local cam = self._mainCameraGo:GetComponent("Camera")
  self._BGBlur.OwnerCamera = cam
  self._BGBlur:CleanRenderTexture()
  self._BGBlur:RefreshBlurTexture()
  self._3dModelTimer = GameGlobal.Timer():AddEvent(100, function()
    self._ui3DModule = self:CreateUI3DModule()
    self._ui3DModuleID = self:InitUI3DModule(self._ui3DModule, petName .. ".prefab")
    local ctrlCamera = GameGlobal.UIStateManager():GetControllerCamera("UIHomeMovieStoryController")
    ctrlCamera.clearFlags = UnityEngine.CameraClearFlags.Depth
    self:Show3DModule(self._ui3DModule, "UIHomeMovieOptionPetCamera.prefab", 45, root, self:GetDepth(), false, false, false)
    if not EditorGlobal.IsEditorMode() then
      self._originLightDir = self._client:SceneManager():GetCustomLightTransform()
      local tempTrans = UnityEngine.GameObject.Find("Envrionment").transform
      self._client:SceneManager():SetCustomLightTransform(tempTrans)
    end
    local petObj = self._ui3DModule.gameObject.transform:Find("ModelShow/ShowPlayer/Model/" .. petName).gameObject
    local rootTrans = petObj.transform:Find("Root")
    local root = rootTrans.gameObject
    local face_name = petName .. "_face"
    local face = GameObjectHelper.FindChild(petObj.transform, face_name)
    if face then
      local render = face.gameObject:GetComponent(typeof(UnityEngine.SkinnedMeshRenderer))
      if not render then
        Log.error("###[HomeStoryEntityModel] 面部表情节点上找不到SkinnedMeshRenderer：", face_name)
      else
        self._optPetFaceMat = render.material
      end
    else
      Log.error("###[HomeStoryEntityModel] 找不到面部表情节点：", face_name)
    end
    local animator = root:GetComponent(typeof(UnityEngine.Animator))
    if animator then
      UnityEngine.Object.Destroy(animator)
    end
    self._optPetAnim = root:AddComponent(typeof(UnityEngine.Animation))
    local petHomePrefab = HelperProxy:GetInstance():GetPetAnimatorControllerName(petName .. ".prefab", PetAnimatorControllerType.Homeland)
    if petHomePrefab then
      self._petHomelandAnimReq = ResourceManager:GetInstance():SyncLoadAsset(petHomePrefab, LoadType.GameObject)
      local homelandAnimation = self._petHomelandAnimReq.Obj:GetComponent("Animation")
      local clips = HelperProxy:GetInstance():GetAllAnimationClip(homelandAnimation)
      for i = 0, clips.Length - 1 do
        if clips[i] == nil then
          Log.error("Pet animation is null:", self._petID, ", index:", i)
        else
          self._optPetAnim:AddClip(clips[i], clips[i].name)
        end
      end
    end
    local petAircraftPrefab = HelperProxy:GetInstance():GetPetAnimatorControllerName(petName .. ".prefab", PetAnimatorControllerType.Aircraft)
    if petAircraftPrefab then
      self._petAircraftAnimReq = ResourceManager:GetInstance():SyncLoadAsset(petAircraftPrefab, LoadType.GameObject)
      local aircraftAnimation = self._petAircraftAnimReq.Obj:GetComponent("Animation")
      local clips = HelperProxy:GetInstance():GetAllAnimationClip(aircraftAnimation)
      for i = 0, clips.Length - 1 do
        if clips[i] == nil then
          Log.error("Pet animation is null:", self._petID, ", index:", i)
        else
          self._optPetAnim:AddClip(clips[i], clips[i].name)
        end
      end
    end
    self._optPetAnim:Play(HomelandPetAnimName.Stand)
    local petFaceCfg
    local cfg = Cfg.cfg_homeland_movie_pet_face({ID = petName})
    if not cfg then
      petFaceCfg = Cfg.cfg_homeland_movie_pet_face({ID = -1})[1]
    else
      petFaceCfg = cfg[1]
    end
    self._optPetFaceIdx = petFaceCfg.Amaze
    if self._optPetFaceMat then
      self._optPetFaceMat:SetInt("_Frame", 1)
    end
  end)
end

function UIHomeMovieStoryController:PlayPetAmazedAnim()
  if self._optPetAnim then
    self._optPetAnim:Play(HomelandPetAnimName.Surprise)
    if self._optPetFaceMat then
      self._optPetFaceMat:SetInt("_Frame", self._optPetFaceIdx)
    end
    local state = self._optPetAnim:get_Item(HomelandPetAnimName.Surprise)
    if state then
      self._FaceTimer = GameGlobal.Timer():AddEvent(state.clip.length * 1000, function()
        self._optPetAnim:Play(HomelandPetAnimName.Stand)
        self._optPetFaceMat:SetInt("_Frame", 1)
      end)
    else
      Log.fatal("无法找到该角色的惊讶动画", self._optPetAnim)
    end
  end
end

function UIHomeMovieStoryController:HidePetModel()
  if self._FaceTimer then
    GameGlobal.Timer():CancelEvent(self._FaceTimer)
  end
  self._BGBlur.gameObject:SetActive(false)
  local ctrlCamera = GameGlobal.UIStateManager():GetControllerCamera("UIHomeMovieStoryController")
  ctrlCamera.clearFlags = UnityEngine.CameraClearFlags.Nothing
  self:Hide3DModule(self._ui3DModule)
  self:Dispose3DModule(self._ui3DModule, self._ui3DModuleID)
  if not EditorGlobal.IsEditorMode() and self._originLightDir then
    self._client:SceneManager():SetCustomLightTransform(self._originLightDir)
  end
end

function UIHomeMovieStoryController:QuitStory()
  AudioHelperController.PlayBGM(CriAudioIDConst.BGMEnterHomeland, AudioConstValue.BGMCrossFadeTime)
  CutsceneManager.ExcuteCutsceneIn(UIStateType.UIHomeMovieStoryController, function()
    self:_OnEndStory()
    self._eventMgr:ReSetStoryRoot()
    local mHomeland = GameGlobal.GetModule(HomelandModule)
    local mUIHomeland = mHomeland:GetUIModule()
    GameGlobal.TaskManager():StartTask(function(TT)
      mUIHomeland:EnterHomelandAfterMovieMaker(TT, self._isRecord, true)
      self._client:SceneManager():BuildNavMesh()
    end)
  end, true)
end

function UIHomeMovieStoryController:_EndStory()
  if self._debugMode then
    self:_OnEndStory()
    self:CloseDialog()
  else
    self._closed = true
    AudioHelperController.PlayBGM(CriAudioIDConst.BGMN17, AudioConstValue.BGMCrossFadeTime)
    CutsceneManager.ExcuteCutsceneIn(UIStateType.UIHomeMovieStoryController, function()
      self._eventMgr:SetFinishStoryID(self._storyID)
      self:_OnEndStory()
      self._eventMgr:ReSetStoryRoot()
      local mHomeland = GameGlobal.GetModule(HomelandModule)
      local mUIHomeland = mHomeland:GetUIModule()
      GameGlobal.TaskManager():StartTask(function(TT)
        mUIHomeland:EnterMovieResult(TT, self._isRecord)
        if self._endCallback then
          self._endCallback()
        end
      end)
    end, true)
  end
end

function UIHomeMovieStoryController:_OnEndStory()
  Log.sys("关闭剧情界面")
  self._closed = true
  GameGlobal.UIStateManager():SetBlackSideVisible(true)
  if self._debugMode then
  else
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnHomeStoryFinish, self._storyID)
    self._client:EndStory()
    self._eventMgr:ShowStoryCamera(false)
    local inputMgr = self._client:InputManager()
    local storyCtl = inputMgr:GetControllerStory()
    storyCtl:SetActive(true)
    inputMgr:OnModeChanged(HomelandMode.Normal)
    self._client:CharacterManager():RevertNpcs()
  end
end

function UIHomeMovieStoryController:ButtonHideOnClick(go)
  self._storyManager:HideUI(true)
  self._cancelHideButton:SetActive(true)
  self._bgRoot:SetActive(false)
  self._RightUpAnchor:SetActive(false)
end

function UIHomeMovieStoryController:CancelHideButtonOnClick(go)
  self._storyManager:HideUI(false)
  self._cancelHideButton:SetActive(false)
  self._bgRoot:SetActive(true)
  self._RightUpAnchor:SetActive(true)
end

function UIHomeMovieStoryController:ButtonReviewOnClick(go)
  local dialogRecord = self._storyManager:GetDialogRecord()
  GameGlobal.UIStateManager():ShowDialog("UIHomePetStoryReview", dialogRecord)
end

function UIHomeMovieStoryController:ButtonAutoOnClick(go)
  self._storyManager:SetAuto(true)
  self._cancelAutoButton:SetActive(true)
end

function UIHomeMovieStoryController:QuitButtonOnClick(go)
  local title
  local desc = self._isRecord and StringTable.Get("str_movie_story_replay_back_tips") or StringTable.Get("str_movie_story_back_tips")
  local leftBtn = {
    StringTable.Get("str_common_cancel"),
    function(param)
    end
  }
  local rightBtn = {
    StringTable.Get("str_common_ok"),
    function()
      self:QuitStory()
    end
  }
  self:ShowDialog("UIHomelandMessageBox", title, desc, leftBtn, rightBtn, true)
end

function UIHomeMovieStoryController:CancelAutoButtonOnClick(go)
  self._storyManager:SetAuto(false)
  self._cancelAutoButton:SetActive(false)
end

function UIHomeMovieStoryController:ShowAddAffinity(petID, affinity)
  Log.fatal("宝宝:" .. petID .. " +" .. affinity)
  local pet = self:GetModule(PetModule):GetPetByTemplateId(petID)
  if not pet then
    Log.fatal("[story] missing pet info, tplid:" .. petID)
    return
  end
  self._affinityPetHead:LoadImage(pet:GetPetHead(PetSkinEffectPath.HEAD_ICON_STORY))
  self._petNameTxt:SetText(StringTable.Get(pet:GetPetName()))
  self._affinityTxt:SetText(StringTable.Get("str_story_add_affinity", affinity))
  self._affinityWnd:SetActive(true)
  if self._tweenQueue then
    self._tweenQueue:Complete(false)
    self._tweenQueue = nil
  end
  self._tweenQueue = DG.Tweening.DOTween.Sequence()
  self._tweenQueue:Append(self._affinityWnd.transform:DOLocalMoveX(-498, 0.2))
  self._tweenQueue:AppendInterval(3)
  self._tweenQueue:Append(self._affinityWnd.transform:DOLocalMoveX(498, 0.2)):AppendCallback(function()
    self._affinityWnd:SetActive(false)
    self._tweenQueue = nil
  end)
end
