require("home_story_entity")
_class("HomeMovieEntityDialog", HomeStoryEntity)
HomeMovieEntityDialog = HomeMovieEntityDialog

function HomeMovieEntityDialog:Constructor(ID, gameObject, resRequest, storyManager, uiController, openTease, isRecord)
  HomeMovieEntityDialog.super.Constructor(self, ID, gameObject, resRequest, storyManager)
  self._uiController = uiController
  self._openTease = openTease
  self._isRecord = isRecord
  self._type = HomeStoryEntityType.Dialog
  self.newName = ""
  self._splitChar = "|"
  self._defaultBreakTypeTime = 0.2
  self._contentEndingTime = 0.2
  self.uiCustomEventListener = UICustomUIEventListener:New()
  self:InitUIComponents(gameObject)
  self:InitData()
end

function HomeMovieEntityDialog:InitUIComponents(gameObject)
  local _dialogUIView = gameObject:GetComponent("UIView")
  self._customWidget = UICustomWidget:New()
  self._customWidget:Load(_dialogUIView, self._uiController)
  self._customWidget:SetName("HomeMovieDialogUIView")
  self._dialogUIView = self._customWidget
  self._canvas = self._uiController:GetUIComponent("Canvas", "UICanvas")
  self._contentBG1 = self._dialogUIView:GetUIComponent("Animation", "DialogBG1")
  self._contentBG2 = self._dialogUIView:GetUIComponent("Animation", "DialogBG2")
  self._anim = self._dialogUIView:GetUIComponent("Animation", "anim")
  self._dialogLayout1 = self._dialogUIView:GetGameObject("DialogLayout1")
  self._dialogLayout2 = self._dialogUIView:GetGameObject("DialogLayout2")
  self._teaseLayout = self._dialogUIView:GetGameObject("TeaseLayout")
  self._promptLayout = self._dialogUIView:GetGameObject("PromptLayout")
  self._speakerGOLeft = self._dialogUIView:GetGameObject("DialogSpeaker1")
  self._speakerGORight = self._dialogUIView:GetGameObject("DialogSpeaker2")
  self._contentTextLeft = self._dialogUIView:GetUIComponent("UIRichText", "Content1")
  self._contentTextRight = self._dialogUIView:GetUIComponent("UIRichText", "Content2")
  self._speakerTextLeft = self._dialogUIView:GetUIComponent("UILocalizationText", "SpeakerName1")
  self._speakerTextRight = self._dialogUIView:GetUIComponent("UILocalizationText", "SpeakerName2")
  self._dialogLayout1:SetActive(false)
  self._dialogLayout2:SetActive(false)
  self._endFlag = self._dialogUIView:GetGameObject("EndFlag")
  self._fullscreenBtn = self._dialogUIView:GetGameObject("FullScreenBtn")
  self._cancelAutoButton = self._dialogUIView:GetGameObject("CancelAutoButton")
  self._cancelHideButton = self._dialogUIView:GetGameObject("CancelHideButton")
  self._buttonReview = self._dialogUIView:GetGameObject("ButtonReview")
  self._buttonHide = self._dialogUIView:GetGameObject("ButtonHide")
  self._buttonAuto = self._dialogUIView:GetGameObject("ButtonAuto")
  self._dialogReviewScrollView = self._dialogUIView:GetUIComponent("UIDynamicScrollView", "ReviewPanel")
  self:AddListener()
  self._optRoot = self._dialogUIView:GetGameObject("Options")
  self._choosePool = self._dialogUIView:GetUIComponent("UISelectObjectPath", "choosePool")
  self._choosePoolObj = self._dialogUIView:GetGameObject("choosePool")
  self._3DView = self._dialogUIView:GetUIComponent("EmptyImage", "3DView")
  self._amazeIcon = self._dialogUIView:GetGameObject("AmazeIcon")
  self._bodyLeft = self._dialogUIView:GetUIComponent("RawImageLoader", "body1")
  self._bodyRight = self._dialogUIView:GetUIComponent("RawImageLoader", "body2")
  self._bodyRawImageLeft = self._dialogUIView:GetUIComponent("RawImage", "body1")
  self._bodyRawImageRight = self._dialogUIView:GetUIComponent("RawImage", "body2")
  self._teaseBody = self._dialogUIView:GetUIComponent("RawImageLoader", "body3")
  self._promptBody = self._dialogUIView:GetUIComponent("RawImageLoader", "body4")
  self._teaseBodyRawImage = self._dialogUIView:GetUIComponent("RawImage", "body3")
  self._promptBodyRawImage = self._dialogUIView:GetUIComponent("RawImage", "body4")
  self._teaseContentText = self._dialogUIView:GetUIComponent("UIRichText", "Content3")
  self._promptContentText = self._dialogUIView:GetUIComponent("UIRichText", "Content4")
  self._teaseBG1 = self._dialogUIView:GetGameObject("DialogBGType1")
  self._teaseBG2 = self._dialogUIView:GetGameObject("DialogBGType2")
  self._promptSpine = self._dialogUIView:GetUIComponent("SpineLoader", "promptSpine")
  self._OptionCountDown = self._dialogUIView:GetGameObject("OptionCountDown")
  self._OptionCountDownTex = self._dialogUIView:GetUIComponent("UILocalizationText", "OptionCountDownTex")
  self._OptionCountDownFill = self._dialogUIView:GetUIComponent("Image", "OptionCountDownFill")
  self._optionParagraphIDDic = {}
  self._optionPromptDic = {}
  self._curOptionRunIndex = 1
  self._singleTouchHandleFlag = false
  self._timerList = {}
  self._needShowDialogAnim = false
  self._shieldDialogNextEvent = false
  self._dialogSpeakerBGBlue = "plot_juqing_xian0"
  self._dialogSpeakerBGRed = "plot_juqing_xian1"
end

function HomeMovieEntityDialog:AddListener()
  self.uiCustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self._fullscreenBtn), UIEvent.Click, function(go)
    self:FullScreenBtnOnClick(go)
  end)
  self.uiCustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self._cancelAutoButton), UIEvent.Click, function(go)
    self:CancelAutoButtonOnClick(go)
  end)
  self.uiCustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self._cancelHideButton), UIEvent.Click, function(go)
    self:CancelHideButtonOnClick(go)
  end)
  self.uiCustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self._buttonReview), UIEvent.Click, function(go)
    self:ButtonReviewOnClick(go)
  end)
  self.uiCustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self._buttonHide), UIEvent.Click, function(go)
    self:ButtonHideOnClick(go)
  end)
  self.uiCustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self._buttonAuto), UIEvent.Click, function(go)
    self:ButtonAutoOnClick(go)
  end)
end

function HomeMovieEntityDialog:Destroy()
  if self._countDownAudio then
    AudioHelperController.StopUISound(self._countDownAudio)
    self._countDownAudio = nil
  end
  for _, v in pairs(self._timerList) do
    if v then
      GameGlobal.Timer():CancelEvent(v)
    end
  end
  if self._resumeCallBack then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.AppResume, self._resumeCallBack)
  end
  self.uiCustomEventListener:RemoveAllCustomEventListener()
  if self._customWidget then
    self._customWidget:Dispose()
    self._customWidget = nil
  end
end

function HomeMovieEntityDialog:InitData()
  self._inSpeakerNameFadeIn = false
  self._speakerNameFadeInStartTime = 0
  self._speakerNameFadeInDuration = 0
  self._speakerNameFadeInColor = Color.New(1, 1, 1, 1)
  self._bodyFadeInColor = Color.New(1, 1, 1, 1)
  self._speakerNameStr = ""
  self._isPlayer = false
  self._contentStartShow = false
  self._contentShown = false
  self._inContentTyping = false
  self._typeClickEnd = false
  self._contentTypeTimeList = {}
  self._contentTypeStartTime = 0
  self._contentFadeInStartTime = 0
  self._contentTypeTime = 0
  self._selectedOptionIndex = 0
  self._contentStartShowTime = 0
  self._contentStr = ""
  self._wordTotalCount = 0
  self._curBreakIndex = 0
  self._endClick = false
  self._showUI = false
  self._hideUI = false
  self._auto = false
  self._autoWaitStartTime = 0
  self._optionShown = false
  self._forceAutoDialog = false
  self._forceWaitTime = {}
  self._autoWaitTime = 1
  self._autoWaitOptionTime = 1
  self._colorPattern = "<color=#%x*"
  self._optionsCountDownTime = 10
  self._shownPrompt = false
  self._shownTease = false
  self._shownOption = false
  self._curTeaseIdx = 1
  self._curTeaseData = {}
  if self._isRecord then
    self._curTeaseRunIndex = 1
    self._playBackData = MoviePrepareData:GetInstance():GetPlayBackData()
  end
end

function HomeMovieEntityDialog:SectionStart(trackData)
  HomeMovieEntityDialog.super.SectionStart(self, trackData)
  self._dialogLayout1:SetActive(false)
  self._dialogLayout2:SetActive(false)
  local body, speakerText, contentText
  if self._currentTrackData.DialogDir == 1 then
    body = self._bodyLeft
    speakerText = self._speakerTextLeft
    contentText = self._contentTextLeft
  else
    body = self._bodyRight
    speakerText = self._speakerTextRight
    contentText = self._contentTextRight
  end
  if self._currentTrackData.SpeakerNameStr then
    self._isPlayer = self._currentTrackData.SpeakerNameStr == "ui_story_name_you"
    self._speakerNameStr = StringTable.Get(self._currentTrackData.SpeakerNameStr)
    self._speakerNameStr = self:_DoEscape(self._speakerNameStr)
    speakerText:SetText(self._speakerNameStr)
  else
    speakerText:SetText("")
  end
  self._contentStr = StringTable.Get(self._currentTrackData.DialogContentStr)
  self._contentStr = self:_DoEscape(self._contentStr)
  self._contentStr, self._breakIndexList, self._wordTotalCount, self._hideTextAnim = self:_GetContentInfo(self._contentStr)
  if self._currentTrackData.ContentAlignment then
    if self._currentTrackData.ContentAlignment == 1 then
      contentText.alignment = UnityEngine.TextAnchor.UpperLeft
    elseif self._currentTrackData.ContentAlignment == 2 then
      contentText.alignment = UnityEngine.TextAnchor.UpperCenter
    elseif self._currentTrackData.ContentAlignment == 3 then
      contentText.alignment = UnityEngine.TextAnchor.UpperRight
    elseif self._currentTrackData.ContentAlignment == 4 then
      contentText.alignment = UnityEngine.TextAnchor.MiddleLeft
    elseif self._currentTrackData.ContentAlignment == 5 then
      contentText.alignment = UnityEngine.TextAnchor.MiddleCenter
    elseif self._currentTrackData.ContentAlignment == 6 then
      contentText.alignment = UnityEngine.TextAnchor.MiddleRight
    elseif self._currentTrackData.ContentAlignment == 7 then
      contentText.alignment = UnityEngine.TextAnchor.LowerLeft
    elseif self._currentTrackData.ContentAlignment == 8 then
      contentText.alignment = UnityEngine.TextAnchor.LowerCenter
    elseif self._currentTrackData.ContentAlignment == 9 then
      contentText.alignment = UnityEngine.TextAnchor.LowerRight
    elseif self._currentTrackData.DialogDir == 1 then
      contentText.alignment = UnityEngine.TextAnchor.MiddleCenter
    else
      contentText.alignment = UnityEngine.TextAnchor.MiddleCenter
    end
  elseif self._currentTrackData.DialogDir == 1 then
    contentText.alignment = UnityEngine.TextAnchor.MiddleCenter
  else
    contentText.alignment = UnityEngine.TextAnchor.MiddleCenter
  end
  contentText:SetText(self._contentStr)
  self._richText = contentText
  self._contentStartShow = false
  self._contentShown = false
  self._contentTypeStartTime = 0
  if self._currentTrackData.Body then
    body.gameObject:SetActive(true)
    body:LoadImage(self._currentTrackData.Body)
  else
    body.gameObject:SetActive(false)
  end
  local transparent = Color.New(1, 1, 1, 0)
  speakerText.color = transparent
  self:ActiveEndFlag(false)
  self._inContentEnding = false
  self._endClick = false
  self._autoWaitStartTime = 0
  self._fullscreenBtn.transform.position = self._storyManager:GetStoryUIRoot().transform.parent.position
  self._optionShown = false
  self._forceAutoDialog = self._storyManager:GetCurParagraph().ForceAutoDialog
  self:ShowChoose()
  self._uiController:SetTeaseBodyImage("base_icon_1021002_norm")
end

function HomeMovieEntityDialog:ShowChoose()
  if self._currentTrackData.Options ~= nil then
    local optionData = self._currentTrackData.Options
    for i = 1, #optionData do
      local _data = optionData[i]
      self._optionParagraphIDDic[i] = _data.NextParagraphID
      if _data.Prompt then
        self._optionPromptDic[i] = {}
        self._optionPromptDic[i].Content = _data.Prompt.Content
        self._optionPromptDic[i].Layer = _data.Prompt.Layer or 1
        self._optionPromptDic[i].Spine = _data.Prompt.Spine
      end
    end
    local movieID = MoviePrepareData:GetInstance():GetMovieId()
    local optionHistory
    if EditorGlobal.IsEditorMode() then
      optionHistory = {}
    else
      optionHistory = MovieDataManager:GetInstance():GetMovieHistoryOptionDataByID(movieID)
    end
    local selectList, optionFitList
    for id, list in pairs(optionHistory) do
      local cfg = Cfg.cfg_homeland_movice_item({ID = id})
      if cfg[1].OptionID == self._currentTrackData.OptionID then
        optionFitList = cfg[1].SelectList
        selectList = list
      end
    end
    local count = #optionData
    self._choosePool:SpawnObjects("UIHomeMovieStoryChooseItem", count)
    local pools = self._choosePool:GetAllSpawnList()
    for i = 1, #pools do
      local item = pools[i]
      local txt = StringTable.Get(optionData[i].Content)
      local fit
      if selectList then
        for _, v in pairs(selectList) do
          if v == i then
            fit = optionFitList[v][2]
          end
        end
      end
      item:SetData(i, txt, fit, function(idx)
        self:ChooseItemClick(idx)
      end)
      item:GetGameObject():SetActive(false)
    end
  end
end

function HomeMovieEntityDialog:ChooseItemClick(idx)
  if self._singleTouchHandleFlag then
    return
  end
  self._singleTouchHandleFlag = true
  if self._countdownTimer then
    GameGlobal.Timer():CancelEvent(self._countdownTimer)
    self._countdownTimer = nil
  end
  if self._countDownAudio then
    AudioHelperController.StopUISound(self._countDownAudio)
    self._countDownAudio = nil
  end
  self._OptionCountDown:SetActive(false)
  MovieDataManager:GetInstance():InsertOptionsData(self._curOptionFitScoreList.ID, idx)
  Log.debug("[HomeMovieEntityDialog::InsertOptionsData]", self._curOptionFitScoreList.ID, idx)
  self:_ChooseOption(idx)
end

function HomeMovieEntityDialog:_GetContentInfo(str)
  local plainStr = string.gsub(str, "<size=%d*>", "")
  plainStr = string.gsub(plainStr, "</size>", "")
  plainStr = string.gsub(plainStr, "<color=#%x*>", "")
  plainStr = string.gsub(plainStr, "</color>", "")
  plainStr = string.gsub(plainStr, "<sprite.*/>", "a")
  local finalStr = string.gsub(str, self._splitChar, "")
  local breakIndexList = {}
  local charCount = 0
  for uchar in string.gmatch(plainStr, "[%z\001-\127�-�][�-�]*") do
    if uchar == self._splitChar then
      breakIndexList[#breakIndexList + 1] = charCount
    else
      charCount = charCount + 1
    end
  end
  breakIndexList[#breakIndexList + 1] = charCount
  local hideTextAnim = self:CheckHideTextAnim(str)
  return finalStr, breakIndexList, charCount, hideTextAnim
end

function HomeMovieEntityDialog:CheckHideTextAnim(str)
  local hide = HelperProxy:GetInstance():CheckTextIncludeImg(str)
  return hide
end

function HomeMovieEntityDialog:_DoEscape(strContent)
  strContent = string.gsub(strContent, "$$", "$")
  local name = GameGlobal.GetModule(RoleModule):GetName()
  if string.isnullorempty(name) then
    name = StringTable.Get("str_guide_moren_name")
  end
  strContent = string.gsub(strContent, "PlayerName", name)
  return strContent
end

function HomeMovieEntityDialog:_GetColorMarkPos(str)
end

function HomeMovieEntityDialog:_TriggerKeyframe(keyframeData)
  self._dialogUIView:GetGameObject():SetActive(true)
  self._showUI = true
  if self._hideUI then
    self._dialogUIView:GetGameObject():SetActive(false)
  end
  local speakerGo, speakerText, bodyRawImage, contentText, contentBg, contentGo
  if self._currentTrackData.DialogDir == 1 then
    speakerGo = self._speakerGOLeft
    speakerText = self._speakerTextLeft
    bodyRawImage = self._bodyRawImageLeft
    contentText = self._contentTextLeft
    contentBg = self._contentBG1
    contentGo = self._dialogLayout1
  else
    speakerGo = self._speakerGORight
    speakerText = self._speakerTextRight
    bodyRawImage = self._bodyRawImageRight
    contentText = self._contentTextRight
    contentBg = self._contentBG2
    contentGo = self._dialogLayout2
  end
  if keyframeData.ContentBGVisible ~= nil then
    local showC = 0
    if self._hideTextAnim then
      showC = -1
    end
    contentText.ShowCharCount = showC
    contentGo:SetActive(true)
    local anim
    if keyframeData.ContentBGVisible == true then
      anim = "story_home_content_bg_anim_in"
    else
      anim = "story_home_content_bg_anim_out"
    end
    if contentBg then
      contentBg:Play(anim)
    end
  end
  if keyframeData.ShowSpeakerName then
    speakerGo:SetActive(true)
    local showSpeakerNameTime = keyframeData.ShowSpeakerName
    if 0 < showSpeakerNameTime then
      self._inSpeakerNameFadeIn = true
      self._speakerNameFadeInStartTime = keyframeData.Time
      self._speakerNameFadeInDuration = showSpeakerNameTime
    else
      self._speakerNameFadeInColor.a = 1
      speakerText.color = self._speakerNameFadeInColor
    end
  end
  if keyframeData.BodyAlpha then
    local showBodyAlphaTime = keyframeData.BodyAlpha
    if 0 < showBodyAlphaTime then
      self._inBodyFadeIn = true
      self._bodyFadeInStartTime = keyframeData.Time
      self._bodyFadeInDuration = showBodyAlphaTime
    else
      self._bodyFadeInColor.a = 1
      bodyRawImage.color = self._bodyFadeInColor
    end
  end
  if keyframeData.ShowContent then
    self._contentStartShow = true
    self._contentTypeTimeList = keyframeData.TypeTimeList or {}
    self._curBreakIndex = 0
    self._inContentTyping = true
    self._contentTypeStartTime = keyframeData.Time
    self._contentTypeTime = keyframeData.ShowContent * self._breakIndexList[1]
    local showC = 0
    if self._hideTextAnim then
      showC = -1
    end
    contentText.ShowCharCount = showC
    if self._currentTrackData.VoiceRefID then
      self._storyManager:PlaySound(self._currentTrackData.VoiceRefID)
    end
    if self._currentTrackData.SpeakerRefID then
      self._storyManager:SetSpeakState(self._currentTrackData.SpeakerRefID, true)
    end
    if self._forceAutoDialog then
      self._forceWaitTime = keyframeData.ForceWaitTimeList or {}
    end
  end
  if keyframeData.HideFullScreenBtn ~= nil then
    self._fullscreenBtn:SetActive(not keyframeData.HideFullScreenBtn)
  end
  if self._needShowDialogAnim then
    self._needShowDialogAnim = false
    self._anim:Play("UIHomeMovieStoryDialog_all")
  end
end

function HomeMovieEntityDialog:_UpdateAnimation(time)
  if not self._showUI then
    return false
  end
  local speakerText, bodyRawImage, contentText
  if self._currentTrackData.DialogDir == 1 then
    speakerText = self._speakerTextLeft
    bodyRawImage = self._bodyRawImageLeft
    contentText = self._contentTextLeft
  else
    speakerText = self._speakerTextRight
    bodyRawImage = self._bodyRawImageRight
    contentText = self._contentTextRight
  end
  if self._inSpeakerNameFadeIn then
    local alpha = (time - self._speakerNameFadeInStartTime) / self._speakerNameFadeInDuration
    if 1 <= alpha then
      alpha = 1
      self._inSpeakerNameFadeIn = false
      speakerText:SetText(self._speakerNameStr)
    end
    self._speakerNameFadeInColor.a = alpha
    speakerText.color = self._speakerNameFadeInColor
    local colorStr = string.format("%02x", math.floor(alpha * 255))
    local str = string.gsub(self._speakerNameStr, self._colorPattern, function(s)
      return s .. colorStr
    end)
    speakerText:SetText(str)
  end
  if self._inBodyFadeIn then
    local alpha = (time - self._bodyFadeInStartTime) / self._bodyFadeInDuration
    if 1 <= alpha then
      alpha = 1
      self._inBodyFadeIn = false
    end
    self._bodyFadeInColor.a = alpha
    bodyRawImage.color = self._bodyFadeInColor
  end
  if self._inContentTyping then
    if self._inContentEnding then
      if time - self._contentEndStartTime > self._contentEndingTime then
        self._inContentTyping = false
        self._contentShown = true
        self:ActiveEndFlag(true)
      end
    else
      self._autoWaitStartTime = 0
      local breakPercent = 1
      if 0 < self._contentTypeTime and not self._typeClickEnd then
        breakPercent = (time - self._contentTypeStartTime) / self._contentTypeTime
        if 1 < breakPercent then
          breakPercent = 1
        end
      end
      self._typeClickEnd = false
      local wordCount = -1
      if self._curBreakIndex == 0 then
        wordCount = math.floor(breakPercent * self._breakIndexList[self._curBreakIndex + 1])
      else
        wordCount = math.floor(lmathext.lerp(self._breakIndexList[self._curBreakIndex], self._breakIndexList[self._curBreakIndex + 1], breakPercent))
      end
      local showC = wordCount
      if self._hideTextAnim then
        showC = -1
      end
      contentText.ShowCharCount = showC
      if breakPercent == 1 then
        self._curBreakIndex = self._curBreakIndex + 1
        if self._curBreakIndex >= #self._breakIndexList then
          self._inContentEnding = true
          self._contentEndStartTime = time
        else
          self._inContentTyping = false
          self._contentTypeTime = (self._contentTypeTimeList[self._curBreakIndex] or self._defaultBreakTypeTime) * (self._breakIndexList[self._curBreakIndex + 1] - self._breakIndexList[self._curBreakIndex])
        end
      end
    end
  end
  if self._contentStartShow and (self._auto or self._forceAutoDialog) and not self._endClick then
    if (self._contentShown or not self._inContentTyping) and self._autoWaitStartTime == 0 then
      self._autoWaitStartTime = time
      if self._forceAutoDialog then
        self._autoWaitTime = self._forceWaitTime[self._curBreakIndex]
      elseif self._curBreakIndex == 1 then
        self._autoWaitTime = 1 + self._breakIndexList[self._curBreakIndex] * 0.075
      else
        self._autoWaitTime = 1 + (self._breakIndexList[self._curBreakIndex] - self._breakIndexList[self._curBreakIndex - 1]) * 0.075
      end
    end
    if self._contentShown then
      if self._currentTrackData.Options == nil then
        if time - self._autoWaitStartTime >= self._autoWaitTime then
          self:FullScreenBtnOnClick()
        end
      elseif time - self._autoWaitStartTime >= self._autoWaitOptionTime and not self._optionShown then
        self:FullScreenBtnOnClick()
        self._optionShown = true
      end
    elseif not self._inContentTyping and time - self._autoWaitStartTime >= self._autoWaitTime then
      self._contentTypeStartTime = self._storyManager:GetCurrentTime()
      self._inContentTyping = true
      self:ActiveEndFlag(false)
    end
  end
  if self._contentShown and self._endClick then
    self._dialogUIView:GetGameObject():SetActive(false)
    self._showUI = false
    return true
  else
    return false
  end
end

function HomeMovieEntityDialog:_DialogEnd()
  self._endClick = true
  if self._currentTrackData.VoiceRefID then
    self._storyManager:StopSound(self._currentTrackData.VoiceRefID)
  end
  local contentText, speakerText
  if self._currentTrackData.DialogDir == 1 then
    contentText = self._contentTextLeft
    speakerText = self._speakerTextLeft
  else
    contentText = self._contentTextRight
    speakerText = self._speakerTextRight
  end
  self._storyManager:AddDialogRecord(speakerText.text, contentText.text, self._isPlayer, self._currentTrackData.Body)
end

function HomeMovieEntityDialog:FullScreenBtnOnClick()
  if not (not self._endClick and not self._forceAutoDialog and self._contentStartShow) or self._shieldDialogNextEvent then
    return
  end
  self._uiController:SetTeaseBodyImage(self._currentTrackData.ResidentTeaseBody or "base_icon_1021002_norm")
  if self._shownPrompt or self._shownTease then
    self:HandlePromptOrTease()
    return
  end
  if self._contentShown then
    AudioHelperController.PlayRequestedUISound(CriAudioIDConst.SoundStoryClick)
    self:_HandleDialogTail()
  elseif self._inContentTyping then
    AudioHelperController.PlayRequestedUISound(CriAudioIDConst.SoundStoryClick)
    self._typeClickEnd = true
  else
    AudioHelperController.PlayRequestedUISound(CriAudioIDConst.SoundStoryClick)
    self._contentTypeStartTime = self._storyManager:GetCurrentTime()
    self._inContentTyping = true
    self:ActiveEndFlag(false)
  end
end

function HomeMovieEntityDialog:ActiveEndFlag(active)
  self._endFlag:SetActive(active)
end

function HomeMovieEntityDialog:CancelHideButtonOnClcik()
  self._storyManager:HideUI(false)
  self._cancelHideButton:SetActive(false)
end

function HomeMovieEntityDialog:ButtonHideOnClick(go)
  self._storyManager:HideUI(true)
  self._cancelHideButton:SetActive(true)
end

function HomeMovieEntityDialog:CancelAutoButtonOnClick()
  self._storyManager:SetAuto(false)
  self._cancelAutoButton:SetActive(false)
end

function HomeMovieEntityDialog:ButtonAutoOnClick()
  self._storyManager:SetAuto(true)
  self._cancelAutoButton:SetActive(true)
end

function HomeMovieEntityDialog:ButtonReviewOnClick(go)
  self._dialogReviewScrollView.gameObject:SetActive(true)
  local dialogRecord = self._storyManager:GetDialogRecord()
  self._dialogReviewScrollView:SetListItemCount(#dialogRecord, true)
  self._dialogReviewScrollView:MovePanelToItemIndex(#dialogRecord - 1, 0)
end

function HomeMovieEntityDialog:SectionEnd()
  HomeMovieEntityDialog.super.SectionEnd(self)
  self._endClick = true
end

function HomeMovieEntityDialog:_HandleDialogTail()
  if self._currentTrackData.Options == nil then
    self:Tease()
  else
    if self._shownOption then
      return
    end
    if self._isRecord then
      local cfg = Cfg.cfg_homeland_movice_item({
        OptionID = self._currentTrackData.OptionID
      })
      local idx = self._playBackData.chose_option[cfg[1].ID]
      self._storyManager:SetNextParagraphID(self._optionParagraphIDDic[idx])
      self._curOptionRunIndex = self._curOptionRunIndex + 1
      self:Tease()
    else
      self._shownOption = true
      self._anim:Play("UIHomeMovieStoryDialog_shou")
      self._uiController:SetTeaseHeadActive(false)
      local timer = GameGlobal.Timer():AddEvent(500, function()
        self._optRoot:SetActive(true)
        local trans = self._choosePoolObj.transform
        for i = 0, trans.childCount - 1 do
          local timer2 = GameGlobal.Timer():AddEvent((i + 1) * 100, function()
            trans:GetChild(i).gameObject:SetActive(true)
          end)
          table.insert(self._timerList, timer2)
        end
        self:ActiveEndFlag(false)
        local petID = self._currentTrackData.OptionPetID or 1600101
        self._uiController:ShowPetModel(petID, self._3DView)
        self._curOptionFitScoreList = MovieDataManager:GetInstance():GetMovieOptionFitScoreList(self._currentTrackData.OptionID)
        self:CountDownOptions()
      end)
      table.insert(self._timerList, timer)
    end
  end
end

function HomeMovieEntityDialog:_ChooseOption(index)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundStoryClick)
  self._selectedOptionIndex = index
  self._storyManager:SetNextParagraphID(self._optionParagraphIDDic[index])
  local trans = self._choosePoolObj.transform
  for i = 0, trans.childCount - 1 do
    local anim = trans:GetChild(i).gameObject:GetComponent("Animation")
    if i ~= index - 1 then
      anim:Play("UIHomeMovieStoryDialog_xiaoshi")
    else
      anim:Play("UIHomeMovieStoryDialog_xuanzhong")
    end
  end
  local timer = GameGlobal.Timer():AddEvent(1000, function()
    self._shownOption = false
    self._optRoot:SetActive(false)
    self._optionParagraphIDDic = {}
    self:Prompt(self._optionPromptDic[index])
    self._singleTouchHandleFlag = false
  end)
  table.insert(self._timerList, timer)
  if self._auto then
  end
end

function HomeMovieEntityDialog:_EditorChooseOption(index)
  self._selectedOptionIndex = index
  self._storyManager:SetNextParagraphID(self._optionParagraphIDDic[index])
  local trans = self._choosePoolObj.transform
  for i = 0, trans.childCount - 1 do
    local anim = trans:GetChild(i).gameObject:GetComponent("Animation")
    if i ~= index - 1 then
      anim:Play("UIHomeMovieStoryDialog_xiaoshi")
    else
      anim:Play("UIHomeMovieStoryDialog_xuanzhong")
    end
  end
  self._shownOption = false
  self._optRoot:SetActive(false)
  self._optionParagraphIDDic = {}
  self._singleTouchHandleFlag = false
  self:_DialogEnd()
end

function HomeMovieEntityDialog:CountDownOptions()
  self._OptionCountDownFill.fillAmount = 1
  self._OptionCountDownTex:SetText(self._optionsCountDownTime)
  AudioHelperController.RequestUISoundSync(CriAudioIDConst.HomelandAudioSearchTreasure)
  self._countDownAudio = AudioHelperController.PlayRequestedUISound(CriAudioIDConst.HomelandAudioSearchTreasure)
  local curTime = self._optionsCountDownTime
  self._OptionCountDownFill:DOFillAmount(0, 10):SetEase(DG.Tweening.Ease.Linear)
  self._countdownTimer = GameGlobal.Timer():AddEventTimes(1000, 10, function()
    curTime = curTime - 1
    self._OptionCountDownTex:SetText(curTime)
    if curTime == 0 then
      self._OptionCountDown:SetActive(false)
      local idx = 1
      local fit = 2
      for _, v in pairs(self._curOptionFitScoreList.SelectList) do
        if fit > v[2] then
          fit = v[2]
          idx = v[1]
        end
      end
      self:ChooseItemClick(idx)
    end
  end)
  table.insert(self._timerList, self._countdownTimer)
  self._OptionCountDown:SetActive(true)
end

function HomeMovieEntityDialog:Tease()
  if self._currentTrackData.Teases and self._openTease then
    local len = #self._currentTrackData.Teases
    local idx
    if self._isRecord then
      idx = self._playBackData.random_chat[self._curTeaseIdx]
      self._curTeaseIdx = self._curTeaseIdx + 1
    else
      local r = math.random(1, len)
      MovieDataManager:GetInstance():InsertTeaseData(r)
      idx = r
    end
    self._curTeaseData = self._currentTrackData.Teases[idx]
    if not self._curTeaseData then
      Log.debug("HomeMovieEntityDialog:Tease，self._curTeaseData为空，请检查是否开启吐槽或数据存在问题")
      self._curTeaseData = {}
    end
    self._curTeaseIdx = 1
    self._shownTease = true
  else
    self:_DialogEnd()
  end
end

function HomeMovieEntityDialog:_ShowNextTease()
  if self._curTeaseIdx > #self._curTeaseData then
    self._teaseLayout:SetActive(false)
    self._shownTease = false
    self._teaseBody:LoadImage("base_icon_1021002_angry")
    self:_DialogEnd()
    return
  end
  local tease = self._curTeaseData[self._curTeaseIdx]
  self._teaseBody:LoadImage(tease.Body)
  self._teaseContentText:SetText(StringTable.Get(tease.TeaseStr))
  if tease.TeaseType == 1 then
    self._anim:Play("UIHomeMovieStoryDialog_doua")
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N8DefaultClick)
  else
    self._anim:Play("UIHomeMovieStoryDialog_doub")
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N8DefaultClick)
    self._audioTimer = GameGlobal.Timer():AddEventTimes(300, 1, function()
      AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N8DefaultClick)
    end)
    table.insert(self._timerList, self._audioTimer)
  end
  self._teaseBG1:SetActive(tease.TeaseType == 1)
  self._teaseBG2:SetActive(tease.TeaseType == 2)
  self._teaseLayout:SetActive(true)
  self._curTeaseIdx = self._curTeaseIdx + 1
  if not EditorGlobal.IsEditorMode() then
    self._shieldDialogNextEvent = true
    local timer = GameGlobal.Timer():AddEvent(1000, function()
      self._shieldDialogNextEvent = false
    end)
  end
  table.insert(self._timerList, timer)
end

function HomeMovieEntityDialog:Prompt(prompt)
  if prompt == nil then
    self:Tease()
  else
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1GameSuccess)
    self._anim:Play("UIHomeMovieStoryDialog_tici")
    self._amazeIcon:SetActive(true)
    self._uiController:PlayPetAmazedAnim()
    self._promptContentText:SetText(StringTable.Get(prompt.Content))
    self._promptLayout:SetActive(true)
    self._shownPrompt = true
    self._shieldDialogNextEvent = true
    local timer = GameGlobal.Timer():AddEvent(2000, function()
      self._shieldDialogNextEvent = false
      self._optionShown = false
    end)
    table.insert(self._timerList, timer)
  end
end

function HomeMovieEntityDialog:HandlePromptOrTease()
  if self._shownPrompt then
    if self._singleTouchHandleFlag then
      return
    end
    self._singleTouchHandleFlag = true
    self._anim:Play("UIHomeMovieStoryDialog_tici_out")
    local timer = GameGlobal.Timer():AddEvent(1000, function()
      self._singleTouchHandleFlag = false
      self._promptLayout:SetActive(false)
      self._shownPrompt = false
      self._uiController:SetTeaseHeadActive(true)
      self._uiController:HidePetModel()
      self._amazeIcon:SetActive(false)
      self._needShowDialogAnim = true
      self:Tease()
    end)
    table.insert(self._timerList, timer)
  end
  if self._shownTease then
    self:_ShowNextTease()
  end
end

function HomeMovieEntityDialog:HideUI(hide)
  self._hideUI = hide
  self._dialogUIView:GetGameObject():SetActive(self._showUI and not hide)
end

function HomeMovieEntityDialog:SetAuto(auto)
  self._auto = auto
  self._autoWaitStartTime = 0
end
