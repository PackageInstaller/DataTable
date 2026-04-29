_class("UIHomeStoryController", UIController)
UIHomeStoryController = UIHomeStoryController

function UIHomeStoryController:OnShow(uiParams)
  self._storyID = uiParams[1]
  self._debugMode = uiParams[5]
  self:AttachEvent(GameEventType.CloseHomeStory, self.CloseHomeStory)
  if not self._storyID then
    self._storyID = 1
  end
  if self._debugMode then
    self._storyRoot = UnityEngine.GameObject.Find("HomeStoryRoot")
    self._storyRoot:SetActive(true)
    self._storyRoot.transform.localPosition = Vector3(1, 1, 1)
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
    self._modelRoot = self._eventMgr:GetStoryRoot()
    self._client:BeginStory()
    local inputMgr = self._client:InputManager()
    inputMgr:OnModeChanged(HomelandMode.Story)
    local storyCtl = inputMgr:GetControllerStory()
    storyCtl:SetActive(false)
    self._client:CharacterManager():HideNpcs()
    local buildMgr = self._client:BuildManager()
    buildMgr:ActiveAllBuilding(false)
  end
  self._endCallback = uiParams[2]
  self._revertBGM = uiParams[4] ~= false
  self._ignoreBreak = uiParams[6]
  local isViewEnter = uiParams[7]
  self._rootGameObject = self:GetGameObject("StoryRoot")
  self._dialogRootGameObject = self:GetGameObject("DialogRoot")
  self._buttonRootGameObject = self:GetGameObject("ButtonRoot")
  self._leftButtonRootGameObject = self:GetGameObject("LeftButtonRoot")
  self._maskTemplate = self:GetGameObject("MaskTemplate")
  self._cancelHideButton = self:GetGameObject("CancelHideButton")
  self._cancelAutoButton = self:GetGameObject("CancelAutoButton")
  self._uiAtlas = self:GetAsset("UIStory.spriteatlas", LoadType.SpriteAtlas)
  self._topBlackSide = self:GetGameObject("Top")
  self._bottomBlackSide = self:GetGameObject("Bottom")
  self._leftBlackSide = self:GetGameObject("Left")
  self._rightBlackSide = self:GetGameObject("Right")
  self._affinityWnd = self:GetGameObject("AffinityWnd")
  self._affinityPetHead = self:GetUIComponent("RawImageLoader", "Icon")
  self._petNameTxt = self:GetUIComponent("UILocalizationText", "PetName")
  self._affinityTxt = self:GetUIComponent("UILocalizationText", "Affinity")
  self._uiCanvasRect = self:GetUIComponent("RectTransform", "UICanvas")
  self._storyManager = HomeStoryManager:New(self._storyID, self, self._mainCameraGo, self._rootGameObject, self._modelRoot, self._dialogRootGameObject, self._buttonRootGameObject, self._leftButtonRootGameObject, self._maskTemplate, self._uiAtlas, self._revertBGM, self._ignoreBreak)
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

function UIHomeStoryController:OnUpdate(deltaTimeMS)
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

function UIHomeStoryController:CloseHomeStory()
  if self._storyManager then
    self._storyManager:Destroy()
    self._storyManager = nil
  end
end

function UIHomeStoryController:OnHide()
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
  if not self._debugMode then
    self._eventMgr:StopStory(self._storyID)
  end
end

function UIHomeStoryController:SetBlackSideSize(width, height)
  self._topBlackSide:GetComponent("RectTransform").sizeDelta = Vector2(0, height)
  self._bottomBlackSide:GetComponent("RectTransform").sizeDelta = Vector2(0, height)
  self._topBlackSide:SetActive(0 < height)
  self._bottomBlackSide:SetActive(0 < height)
  self._leftBlackSide:GetComponent("RectTransform").sizeDelta = Vector2(width, 0)
  self._rightBlackSide:GetComponent("RectTransform").sizeDelta = Vector2(width, 0)
  self._leftBlackSide:SetActive(0 < width)
  self._rightBlackSide:SetActive(0 < width)
end

function UIHomeStoryController:GetCanvasSize()
  return self._uiCanvasRect.sizeDelta.x, self._uiCanvasRect.sizeDelta.y
end

function UIHomeStoryController:FillDebugInfo()
  if self._paragraphText and self._sectionText and self._timeText then
    self._paragraphText.text = self._storyManager:GetCurParagraphID()
    self._sectionText.text = self._storyManager:GetCurSectionIndex()
    self._timeText.text = string.format("%.1f", self._storyManager:GetCurrentTime())
  end
end

function UIHomeStoryController:_EndStory()
  if self._debugMode then
    self:_OnEndStory()
    self:CloseDialog()
  else
    self._closed = true
    CutsceneManager.ExcuteCutsceneIn(UIStateType.UIHomeStoryController, function()
      self._eventMgr:SetFinishStoryID(self._storyID)
      self:_OnEndStory()
      self:SwitchState(UIStateType.UIHomeland)
    end)
  end
end

function UIHomeStoryController:_OnEndStory()
  Log.sys("关闭剧情界面")
  self._closed = true
  GameGlobal.UIStateManager():SetBlackSideVisible(true)
  if self._endCallback then
    self._endCallback()
  end
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
    local buildMgr = self._client:BuildManager()
    buildMgr:ActiveAllBuilding(true)
  end
end

function UIHomeStoryController:ButtonHideOnClick(go)
  self._storyManager:HideUI(true)
  self._cancelHideButton:SetActive(true)
end

function UIHomeStoryController:CancelHideButtonOnClick(go)
  self._storyManager:HideUI(false)
  self._cancelHideButton:SetActive(false)
end

function UIHomeStoryController:ButtonReviewOnClick(go)
  local dialogRecord = self._storyManager:GetDialogRecord()
  GameGlobal.UIStateManager():ShowDialog("UIHomePetStoryReview", dialogRecord)
end

function UIHomeStoryController:ButtonAutoOnClick(go)
  self._storyManager:SetAuto(true)
  self._cancelAutoButton:SetActive(true)
end

function UIHomeStoryController:QuitButtonOnClick(go)
  self:_EndStory()
end

function UIHomeStoryController:CancelAutoButtonOnClick(go)
  self._storyManager:SetAuto(false)
  self._cancelAutoButton:SetActive(false)
end

function UIHomeStoryController:ShowAddAffinity(petID, affinity)
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
