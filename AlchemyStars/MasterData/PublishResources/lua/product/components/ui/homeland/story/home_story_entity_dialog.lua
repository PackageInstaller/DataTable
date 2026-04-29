_class("HomeStoryEntityDialog", HomeStoryEntity)
HomeStoryEntityDialog = HomeStoryEntityDialog

function HomeStoryEntityDialog:Constructor(ID, gameObject, resRequest, storyManager, uiController)
  HomeStoryEntityDialog.super.Constructor(self, ID, gameObject, resRequest, storyManager)
  self._uiController = uiController
  self._type = HomeStoryEntityType.Dialog
  self.newName = ""
  self._splitChar = "|"
  self._defaultBreakTypeTime = 0.2
  self._contentEndingTime = 0.2
  self.uiCustomEventListener = UICustomUIEventListener:New()
  self:InitUIComponents(gameObject)
  self:InitData()
end

function HomeStoryEntityDialog:InitUIComponents(gameObject)
  local _dialogUIView = gameObject:GetComponent("UIView")
  self._customWidget = UICustomWidget:New()
  self._customWidget:Load(_dialogUIView, self._uiController)
  self._customWidget:SetName("HomeStoryDialogUIView")
  self._dialogUIView = self._customWidget
  self._canvas = self._uiController:GetUIComponent("Canvas", "UICanvas")
  self._contentBG1 = self._dialogUIView:GetUIComponent("Animation", "DialogBG1")
  self._contentBG2 = self._dialogUIView:GetUIComponent("Animation", "DialogBG2")
  self._dialogLayout1 = self._dialogUIView:GetGameObject("DialogLayout1")
  self._dialogLayout2 = self._dialogUIView:GetGameObject("DialogLayout2")
  self._speakerGOLeft = self._dialogUIView:GetGameObject("DialogSpeaker1")
  self._speakerGORight = self._dialogUIView:GetGameObject("DialogSpeaker2")
  self._contentTextLeft = self._dialogUIView:GetUIComponent("UIRichText", "Content1")
  self._contentTextRight = self._dialogUIView:GetUIComponent("UIRichText", "Content2")
  self._speakerTextLeft = self._dialogUIView:GetUIComponent("UILocalizedTMP", "SpeakerName1")
  self._speakerTextRight = self._dialogUIView:GetUIComponent("UILocalizedTMP", "SpeakerName2")
  self._matReq1 = UIWidgetHelper.SetLocalizedTMPMaterial(self._dialogUIView, "SpeakerName1", "UIHomeStorySpeakerName.mat", self._matReq1)
  self._matReq2 = UIWidgetHelper.SetLocalizedTMPMaterial(self._dialogUIView, "SpeakerName2", "UIHomeStorySpeakerName.mat", self._matReq2)
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
  self._bodyLeft = self._dialogUIView:GetUIComponent("RawImageLoader", "body1")
  self._bodyRight = self._dialogUIView:GetUIComponent("RawImageLoader", "body2")
  self._bodyRawImageLeft = self._dialogUIView:GetUIComponent("RawImage", "body1")
  self._bodyRawImageRight = self._dialogUIView:GetUIComponent("RawImage", "body2")
  self._optionParagraphIDDic = {}
  self._dialogSpeakerBGBlue = "plot_juqing_xian0"
  self._dialogSpeakerBGRed = "plot_juqing_xian1"
end

function HomeStoryEntityDialog:AddListener()
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

function HomeStoryEntityDialog:Destroy()
  if self._resumeCallBack then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.AppResume, self._resumeCallBack)
  end
  self.uiCustomEventListener:RemoveAllCustomEventListener()
  if self._customWidget then
    self._customWidget:Dispose()
    self._customWidget = nil
  end
  self._matReq1 = UIWidgetHelper.DisposeLocalizedTMPMaterial(self._matReq1)
  self._matReq2 = UIWidgetHelper.DisposeLocalizedTMPMaterial(self._matReq2)
end

function HomeStoryEntityDialog:InitData()
  self._inSpeakerNameFadeIn = false
  self._speakerNameFadeInStartTime = 0
  self._speakerNameFadeInDuration = 0
  self._speakerNameFadeInColor = Color.New(0.27058823529411763, 0.2627450980392157, 0.2627450980392157, 1)
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
end

function HomeStoryEntityDialog:SectionStart(trackData)
  HomeStoryEntityDialog.super.SectionStart(self, trackData)
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
end

function HomeStoryEntityDialog:ShowChoose()
  if self._currentTrackData.Options ~= nil then
    local optionData = self._currentTrackData.Options
    for i = 1, #optionData do
      local _data = optionData[i]
      self._optionParagraphIDDic[i] = _data.NextParagraphID
    end
    local count = #optionData
    self._choosePool:SpawnObjects("UIHomeStoryChooseItem", count)
    local pools = self._choosePool:GetAllSpawnList()
    for i = 1, #pools do
      local item = pools[i]
      local txt = StringTable.Get(optionData[i].Content)
      item:SetData(i, txt, function(idx)
        self:ChooseItemClick(idx)
      end)
    end
  end
end

function HomeStoryEntityDialog:ChooseItemClick(idx)
  local optionData = self._currentTrackData.Options
  local _data = optionData[idx]
  self:_ChooseOption(idx)
end

function HomeStoryEntityDialog:_GetContentInfo(str)
  local plainStr = string.gsub(str, "<size=%d*>", "")
  plainStr = string.gsub(plainStr, "</size>", "")
  plainStr = string.gsub(plainStr, "<color=#%x*>", "")
  plainStr = string.gsub(plainStr, "</color>", "")
  plainStr = string.gsub(plainStr, "<sprite.*/>", "a")
  local finalStr = string.gsub(str, self._splitChar, "")
  local breakIndexList = {}
  local charCount = 0
  for uchar in string.gmatch(plainStr, "[%z\001-\127Â-ô][€-¿]*") do
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

function HomeStoryEntityDialog:CheckHideTextAnim(str)
  local hide = HelperProxy:GetInstance():CheckTextIncludeImg(str)
  return hide
end

function HomeStoryEntityDialog:_DoEscape(strContent)
  strContent = string.gsub(strContent, "$$", "$")
  local name = GameGlobal.GetModule(RoleModule):GetName()
  if string.isnullorempty(name) then
    name = StringTable.Get("str_guide_moren_name")
  end
  strContent = string.gsub(strContent, "PlayerName", name)
  return strContent
end

function HomeStoryEntityDialog:_GetColorMarkPos(str)
end

function HomeStoryEntityDialog:_TriggerKeyframe(keyframeData)
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
end

function HomeStoryEntityDialog:_UpdateAnimation(time)
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
          self:_DialogEnd()
        end
      elseif time - self._autoWaitStartTime >= self._autoWaitOptionTime and not self._optionShown then
        self:_ShowOption()
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

function HomeStoryEntityDialog:_DialogEnd()
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
  if self._currentTrackData.Options then
    local playerName = self:_DoEscape(StringTable.Get("ui_story_name_you"))
    local optionContent = self._currentTrackData.Options[self._selectedOptionIndex].Content
    self._storyManager:AddDialogRecord(playerName, optionContent, true, nil)
  end
end

function HomeStoryEntityDialog:FullScreenBtnOnClick()
  if self._endClick or self._forceAutoDialog or not self._contentStartShow then
    return
  end
  if self._contentShown then
    AudioHelperController.PlayRequestedUISound(CriAudioIDConst.SoundStoryClick)
    self:_ShowOption()
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

function HomeStoryEntityDialog:ActiveEndFlag(active)
  self._endFlag:SetActive(active)
end

function HomeStoryEntityDialog:CancelHideButtonOnClcik()
  self._storyManager:HideUI(false)
  self._cancelHideButton:SetActive(false)
end

function HomeStoryEntityDialog:ButtonHideOnClick(go)
  self._storyManager:HideUI(true)
  self._cancelHideButton:SetActive(true)
end

function HomeStoryEntityDialog:CancelAutoButtonOnClick()
  self._storyManager:SetAuto(false)
  self._cancelAutoButton:SetActive(false)
end

function HomeStoryEntityDialog:ButtonAutoOnClick()
  self._storyManager:SetAuto(true)
  self._cancelAutoButton:SetActive(true)
end

function HomeStoryEntityDialog:ButtonReviewOnClick(go)
  self._dialogReviewScrollView.gameObject:SetActive(true)
  local dialogRecord = self._storyManager:GetDialogRecord()
  self._dialogReviewScrollView:SetListItemCount(#dialogRecord, true)
  self._dialogReviewScrollView:MovePanelToItemIndex(#dialogRecord - 1, 0)
end

function HomeStoryEntityDialog:SectionEnd()
  HomeStoryEntityDialog.super.SectionEnd(self)
  self._endClick = true
end

function HomeStoryEntityDialog:_ShowOption()
  if self._currentTrackData.Options == nil then
    self:_DialogEnd()
  else
    self._optRoot:SetActive(true)
    if self._auto or self._forceAutoDialog then
    end
  end
end

function HomeStoryEntityDialog:_ChooseOption(index)
  AudioHelperController.PlayRequestedUISound(CriAudioIDConst.SoundStoryClick)
  self._selectedOptionIndex = index
  self._storyManager:SetNextParagraphID(self._optionParagraphIDDic[index])
  self._optRoot:SetActive(false)
  if self._auto then
  end
  self._optionParagraphIDDic = {}
  self:_DialogEnd()
end

function HomeStoryEntityDialog:HideUI(hide)
  self._hideUI = hide
  self._dialogUIView:GetGameObject():SetActive(self._showUI and not hide)
end

function HomeStoryEntityDialog:SetAuto(auto)
  self._auto = auto
  self._autoWaitStartTime = 0
end
