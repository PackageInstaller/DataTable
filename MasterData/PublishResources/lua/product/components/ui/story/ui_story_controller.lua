_class("UIStoryController", UIController)
UIStoryController = UIStoryController

function UIStoryController:OnShow(uiParams)
  self._storyID = uiParams[1]
  Log.info("[story] start story ID:" .. tostring(self._storyID))
  GameGlobal.UAReportForceGuideEvent("StoryStart", {
    self._storyID
  })
  self._endCallback = uiParams[2]
  self._needCloseSelf = uiParams[3]
  self._revertBGM = uiParams[4] ~= false
  self._debugMode = uiParams[5]
  self._ignoreBreak = uiParams[6]
  self._skipToOptions = uiParams[7] ~= nil
  self._cancelHideButton = self:GetGameObject("CancelHideButton")
  self._cancelAutoButton = self:GetGameObject("CancelAutoButton")
  self._dialogReviewScrollView = self:GetUIComponent("UIDynamicScrollView", "ReviewPanel")
  self._autoStateGO = self:GetGameObject("AutoState")
  self._autoText = self:GetUIComponent("UILocalizationText", "AutoText")
  self._uiAtlas = self:GetAsset("UIStory.spriteatlas", LoadType.SpriteAtlas)
  self._buttonSpeedObj = self:GetGameObject("ButtonSpeed")
  self._buttonSpeedBG = self:GetUIComponent("Image", "ButtonSpeedBG")
  self._buttonSpeedText = self:GetUIComponent("UILocalizationText", "ButtonSpeedText")
  self._buttonSpeedIcon = self:GetUIComponent("Image", "ButtonSpeedIcon")
  self._buttonSpeedHideTimer = nil
  self._buttonSpeedCfg = {
    [1] = {
      icon = "plot_juqing_icon2"
    },
    [2] = {
      icon = "plot_juqing_icon3"
    },
    [4] = {
      icon = "plot_juqing_icon4"
    }
  }
  self._topBlackSide = self:GetGameObject("Top")
  self._bottomBlackSide = self:GetGameObject("Bottom")
  self._leftBlackSide = self:GetGameObject("Left")
  self._rightBlackSide = self:GetGameObject("Right")
  self._affinityWnd = self:GetGameObject("AffinityWnd")
  self._affinityPetHead = self:GetUIComponent("RawImageLoader", "Icon")
  self._petNameTxt = self:GetUIComponent("UILocalizationText", "PetName")
  self._affinityTxt = self:GetUIComponent("UILocalizationText", "Affinity")
  self._uiCanvasRect = self:GetUIComponent("RectTransform", "UICanvas")
  self._skipLock = true
  self._fullScreenAnchor = self:GetUIComponent("RectTransform", "FullScreenAnchor")
  local bands = ResolutionManager.BangWidth()
  Log.info("UIStoryController FullScreenAnchor " .. bands)
  self._fullScreenAnchor.sizeDelta = Vector2(bands * 2, 0)
  self._storyManager = StoryManager:New(self, self._storyID, self._revertBGM, self._ignoreBreak)
  self._dialogReviewScrollView:InitListView(0, function(scrollview, index)
    return self:_OnGetReviewDialogItem(scrollview, index)
  end)
  
  function self._dialogReviewScrollView.mOnDragingAction()
    self._reviewDragged = true
  end
  
  if self._debugMode then
    self._debugInfoRoot = self:GetGameObject("DebugInfoRoot")
    self._debugInfoRoot:SetActive(true)
    self._paragraphText = self:GetUIComponent("Text", "ParagraphText")
    self._sectionText = self:GetUIComponent("Text", "SectionText")
    self._timeText = self:GetUIComponent("Text", "TimeText")
    self._entityInfo = self:GetGameObject("EntityInfo")
  end
  self._storyManager:Init(self._debugMode, self._entityInfo)
  self._closed = false
  self._reviewDragged = false
  self._dialogSpeakerBGBlue = "plot_juqing_xian4"
  self._dialogSpeakerBGRed = "plot_juqing_xian5"
  self._skipLock = false
  if EditorGlobal.IsEditorMode() then
    EditorGlobal.SetStroyController(self)
    EditorGlobal.SetStroyManager(self._storyManager)
  end
  GameGlobal.UIStateManager():SetBlackSideVisible(false)
end

function UIStoryController:OnUpdate(deltaTimeMS)
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

function UIStoryController:OnHide()
  self._storyManager:Destroy()
  self._storyManager = nil
  if self._tweenQueue then
    self._tweenQueue:Complete(false)
    self._tweenQueue = nil
  end
  local login_module = GameGlobal.GetModule(LoginModule)
  GameGlobal.UAReportForceGuideEvent("StoryEnd", {
    self._storyID
  })
end

function UIStoryController:SetBlackSideSize(width, height)
  self._topBlackSide:GetComponent("RectTransform").sizeDelta = Vector2(0, height)
  self._bottomBlackSide:GetComponent("RectTransform").sizeDelta = Vector2(0, height)
  self._topBlackSide:SetActive(0 < height)
  self._bottomBlackSide:SetActive(0 < height)
  self._leftBlackSide:GetComponent("RectTransform").sizeDelta = Vector2(width, 0)
  self._rightBlackSide:GetComponent("RectTransform").sizeDelta = Vector2(width, 0)
  self._leftBlackSide:SetActive(0 < width)
  self._rightBlackSide:SetActive(0 < width)
end

function UIStoryController:GetCanvasSize()
  return self._uiCanvasRect.sizeDelta.x, self._uiCanvasRect.sizeDelta.y
end

function UIStoryController:FillDebugInfo()
  self._paragraphText.text = self._storyManager:GetCurParagraphID()
  self._sectionText.text = self._storyManager:GetCurSectionIndex()
  self._timeText.text = string.format("%.1f", self._storyManager:GetCurrentTime())
end

function UIStoryController:_EndStory()
  Log.sys("关闭剧情界面")
  if self._needCloseSelf == nil or self._needCloseSelf == true then
    self:CloseDialog()
  end
  self._closed = true
  GameGlobal.UIStateManager():SetBlackSideVisible(true)
  if self._endCallback then
    self._endCallback()
  end
end

function UIStoryController:_OnGetReviewDialogItem(scrollview, index)
  local dialogRecord = self._storyManager:GetDialogRecord()
  local item = scrollview:NewListViewItem("ReviewContent")
  local luaIndex = index + 1
  if luaIndex <= #dialogRecord then
    local speakerName = dialogRecord[luaIndex][1]
    local content = dialogRecord[luaIndex][2]
    local voiceId = dialogRecord[luaIndex][5]
    local voice = item.transform:Find("Content/Voice").gameObject
    self:AddUICustomEventListener(UICustomUIEventListener.Get(voice), UIEvent.Click, function()
      if self._currentPlayingID then
        AudioHelperController.StopUIVoice(self._currentPlayingID)
      end
      self._currentPlayingID = nil
      if voiceId then
        self._currentPlayingID = AudioHelperController.PlayUIVoice(voiceId, false)
      end
    end)
    if voiceId then
      voice:SetActive(true)
    else
      voice:SetActive(false)
    end
    item.transform:Find("SpeakerPlaceHolder/Speaker"):GetComponent(typeof(UILocalizationText)):SetText(speakerName)
    item.transform:Find("Content"):GetComponent(typeof(UILocalizationText)):SetText(content)
    local speakerBG = item.transform:Find("SpeakerPlaceHolder/SpeakerBG").gameObject
    if string.len(speakerName) > 0 then
      speakerBG:SetActive(true)
      local speakerBGColor = dialogRecord[luaIndex][3]
      local isPlayer = dialogRecord[luaIndex][4]
      if isPlayer or speakerBGColor == "blue" then
        speakerBG:GetComponent("Image").sprite = self._uiAtlas:GetSprite(self._dialogSpeakerBGBlue)
      else
        speakerBG:GetComponent("Image").sprite = self._uiAtlas:GetSprite(self._dialogSpeakerBGRed)
      end
    else
      speakerBG:SetActive(false)
    end
    UIHelper.RefreshLayout(item:GetComponent("RectTransform"))
    return item
  else
    return nil
  end
end

function UIStoryController:ButtonHideOnClick(go)
  self._storyManager:HideUI(true)
  self._buttonSpeedObjActive = self._buttonSpeedObj.activeSelf
  self._buttonSpeedObj:SetActive(false)
  self._cancelHideButton:SetActive(true)
  if self._autoState then
    self:PauseAuto()
  end
end

function UIStoryController:CancelHideButtonOnClick(go)
  self._storyManager:HideUI(false)
  self._buttonSpeedObj:SetActive(self._buttonSpeedObjActive)
  self._cancelHideButton:SetActive(false)
  if self._autoState then
    self:ResumeAuto()
  end
end

function UIStoryController:ButtonReviewOnClick(go)
  GameGlobal.UAReportForceGuideEvent("StoryReplay", {
    self._storyID,
    self._storyManager:GetCurParagraphID(),
    self._storyManager:GetCurSectionIndex()
  })
  self._dialogReviewScrollView.gameObject:SetActive(true)
  local dialogRecord = self._storyManager:GetDialogRecord()
  self._dialogReviewScrollView:SetListItemCount(#dialogRecord, true)
  self._dialogReviewScrollView:MovePanelToItemIndex(#dialogRecord - 1, 0)
  if self._autoState then
    self:PauseAuto()
  end
end

function UIStoryController:ReviewPanelOnClick()
  if self._reviewDragged then
    self._reviewDragged = false
  else
    if self._currentPlayingID then
      AudioHelperController.StopUIVoice(self._currentPlayingID)
    end
    self._dialogReviewScrollView.gameObject:SetActive(false)
    if self._autoState then
      self:ResumeAuto()
    end
  end
end

function UIStoryController:RestartHideBtnTimer()
  if self._buttonSpeedHideTimer then
    GameGlobal.TaskManager():KillTask(self._buttonSpeedHideTimer)
    self._buttonSpeedHideTimer = nil
  end
  local targetTime = GameGlobal:GetInstance():GetCurrentUnscaledTime() + 2000
  self._buttonSpeedHideTimer = self:StartTask(function(TT)
    while GameGlobal:GetInstance():GetCurrentUnscaledTime() < targetTime do
      YIELD(TT)
    end
    self._storyManager:GetUIRootButtonObject():SetActive(false)
    self._buttonSpeedObj:SetActive(false)
    GameGlobal.TaskManager():KillTask(self._buttonSpeedHideTimer)
    self._buttonSpeedHideTimer = nil
  end)
end

function UIStoryController:CancelHideBtnTimer()
  if self._buttonSpeedHideTimer then
    GameGlobal.TaskManager():KillTask(self._buttonSpeedHideTimer)
    self._buttonSpeedHideTimer = nil
  end
end

function UIStoryController:ButtonSpeedOnClick()
  self._storyManager:SetSpeed(function(rate)
    self._buttonSpeedText:SetText(rate .. " X")
    self._buttonSpeedIcon.sprite = self._uiAtlas:GetSprite(self._buttonSpeedCfg[rate].icon)
  end, 3)
end

function UIStoryController:ButtonAutoOnClick(go)
  local newAuto = not self._storyManager:GetAuto()
  if newAuto then
    local login_module = GameGlobal.GetModule(LoginModule)
    if login_module:IsInFirstStory() then
      GameGlobal.ReportCustomEvent("CreateRole", "AutoPlayBtn")
    end
    GameGlobal.UAReportForceGuideEvent("StoryAuto", {
      self._storyID,
      self._storyManager:GetCurParagraphID(),
      self._storyManager:GetCurSectionIndex()
    })
    self._buttonSpeedObj:SetActive(true)
    self._storyManager:SetAuto(true)
    self._cancelAutoButton:SetActive(true)
    self._autoStateGO:SetActive(true)
    self._autoText.color = Color.black
    self._storyManager:SetSpeed(function(rate)
      self._buttonSpeedText:SetText(rate .. " X")
      self._buttonSpeedIcon.sprite = self._uiAtlas:GetSprite(self._buttonSpeedCfg[rate].icon)
    end, 1)
  else
    self:StopAuto()
  end
  self._autoState = newAuto
end

function UIStoryController:StopAuto()
  GameGlobal.UAReportForceGuideEvent("StoryCancelAuto", {
    self._storyID,
    self._storyManager:GetCurParagraphID(),
    self._storyManager:GetCurSectionIndex()
  })
  self._storyManager:SetSpeed(nil, 2)
  self._buttonSpeedObj:SetActive(false)
  self._storyManager:SetAuto(false)
  self._cancelAutoButton:SetActive(false)
  self._storyManager:GetUIRootButtonObject():SetActive(true)
  self._autoStateGO:SetActive(false)
  self._autoText.color = Color.white
end

function UIStoryController:PauseAuto()
  self._storyManager:SetSpeed(nil, 2)
  self._storyManager:SetAuto(false)
end

function UIStoryController:ResumeAuto()
  self._storyManager:SetAuto(true)
  self._storyManager:SetSpeed(function(rate)
    self._buttonSpeedText:SetText(rate .. " X")
    self._buttonSpeedIcon.sprite = self._uiAtlas:GetSprite(self._buttonSpeedCfg[rate].icon)
  end, 1)
end

function UIStoryController:CancelAutoButtonOnClick(go)
  self:StopAuto()
end

function UIStoryController:SetSkipToOptions(skipToOptions)
  self._skipToOptions = skipToOptions
end

function UIStoryController:ButtonSkipOnClick(go)
  if self._skipLock then
    return
  end
  if self._skipToOptions then
    self.key = "JumpStoryNextOptions"
    GameGlobal.UIStateManager():Lock(self.key)
    local lastParagraphId, lastSectionIdx = -1, -1
    local dialogRet = self._storyManager:JumpTo(lastParagraphId, lastSectionIdx)
    if dialogRet then
      dialogRet:FullScreenBtnOnClick()
    end
    GameGlobal.UIStateManager():UnLock(self.key)
    return
  end
  local skip_confirm_str_id = "str_story_skip_confirm"
  if not self:GetModule(StoryModule):IsFinish(self._storyID) then
    skip_confirm_str_id = "str_story_skip_affinity_confirm"
  end
  self._skipLock = true
  local login_module = GameGlobal.GetModule(LoginModule)
  if login_module:IsInFirstStory() then
    GameGlobal.ReportCustomEvent("CreateRole", "SkipAnimBtn")
  end
  GameGlobal.UAReportForceGuideEvent("StorySkip", {
    self._storyID,
    self._storyManager:GetCurParagraphID(),
    self._storyManager:GetCurSectionIndex()
  })
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get(skip_confirm_str_id), function()
    Log.sys("开始跳过剧情")
    if not self._storyManager then
      Log.warn("storyManager在确认跳过前已被置空")
      Log.sys("结束跳过剧情")
      return
    end
    if self._autoState then
      self:ResumeAuto()
    end
    self._storyManager:SkipParagraph()
    self._skipLock = false
    Log.sys("结束跳过剧情")
  end, nil, function()
    if self._autoState then
      self:ResumeAuto()
    end
    self._skipLock = false
  end)
  if self._autoState then
    self:PauseAuto()
  end
end

function UIStoryController:ShowAddAffinity(petID, affinity)
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
