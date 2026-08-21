_class("StoryEntityDialog", StoryEntity)
StoryEntityDialog = StoryEntityDialog

function StoryEntityDialog:Constructor(ID, gameObject, resRequest, storyManager)
  StoryEntityDialog.super.Constructor(self, ID, gameObject, resRequest, storyManager)
  self._type = StoryEntityType.Dialog
  self.newName = ""
  self._splitChar = "|"
  self._defaultBreakTypeTime = 0.2
  self._contentEndingTime = 0.2
  self.uiCustomEventListener = UICustomUIEventListener:New()
  self:InitUIComponents(gameObject)
  self:InitData()
end

function StoryEntityDialog:InitUIComponents(gameObject)
  self._dialogUIView = gameObject:GetComponent("UIView")
  self._contentBG = self._dialogUIView:GetUIComponent("Image", "DialogBG")
  self._speakerGO = self._dialogUIView:GetGameObject("DialogSpeaker")
  self._speakerBG1 = self._dialogUIView:GetUIComponent("Image", "DialogSpeakerBG1")
  self._speakerBG2 = self._dialogUIView:GetUIComponent("Image", "DialogSpeakerBG2")
  self._contentText = self._dialogUIView:GetUIComponent("UIRichText", "Content")
  self._speakerText = self._dialogUIView:GetUIComponent("UILocalizationText", "SpeakerName")
  self._endFlag = self._dialogUIView:GetGameObject("EndFlag")
  self._fullscreenBtn = self._dialogUIView:GetGameObject("FullScreenBtn")
  self._optRoot = self._dialogUIView:GetGameObject("Options")
  self._optMask = self._dialogUIView:GetGameObject("OptionMask")
  self._options = {}
  for i = 1, 3 do
    self._options[i] = self._dialogUIView:GetGameObject("Opt" .. i)
  end
  self._optionBtns = {}
  for i = 1, 3 do
    self._optionBtns[i] = self._dialogUIView:GetUIComponent("Button", "Opt" .. i)
  end
  self._optionBGs = {}
  for i = 1, 3 do
    self._optionBGs[i] = self._dialogUIView:GetUIComponent("Image", "opt" .. i .. "Btn")
  end
  self._optionPress = {}
  for i = 1, 3 do
    self._optionPress[i] = self._dialogUIView:GetGameObject("opt" .. i .. "BtnPress")
    self.uiCustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self._options[i]), UIEvent.Press, function(go)
      self._optionBGs[i].gameObject:SetActive(false)
      self._optionPress[i]:SetActive(true)
    end)
    self.uiCustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self._options[i]), UIEvent.Release, function(go)
      self._optionBGs[i].gameObject:SetActive(true)
      self._optionPress[i]:SetActive(false)
    end)
    self.uiCustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self._options[i]), UIEvent.Hovered, function(go)
      if UICustomUIEventListener.Get(self._options[i]).IsPressd then
        self._optionBGs[i].gameObject:SetActive(false)
        self._optionPress[i]:SetActive(true)
      end
    end)
    self.uiCustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self._options[i]), UIEvent.Unhovered, function(go)
      self._optionBGs[i].gameObject:SetActive(true)
      self._optionPress[i]:SetActive(false)
    end)
  end
  self._optionTexts = {}
  for i = 1, 3 do
    self._optionTexts[i] = self._dialogUIView:GetUIComponent("UILocalizationText", "opt" .. i .. "Text")
  end
  self._optionAffinity = {}
  for i = 1, 3 do
    self._optionAffinity[i] = self._dialogUIView:GetGameObject("affinity" .. i)
  end
  self._ropeFront1 = self._dialogUIView:GetUIComponent("Image", "RopeFront1")
  self._ropeBack1 = self._dialogUIView:GetUIComponent("Image", "RopeBack1")
  self._ropeBack2 = self._dialogUIView:GetUIComponent("Image", "RopeBack2")
  self._optionParagraphIDDic = {}
  self._optionAffinityData = {}
  self._threeOptPosList = {
    Vector3(-59, 217, 0),
    Vector3(-9.5, 58, 0),
    Vector3(37.5, -104, 0)
  }
  self._twoOptPosList = {
    Vector3(-58.5, 137.5, 0),
    Vector3(-9.5, -22, 0)
  }
  self._oneOptPos = {
    Vector3(-9.5, 54, 0)
  }
  self._OptPosList = {
    self._oneOptPos,
    self._twoOptPosList,
    self._threeOptPosList
  }
  self._dialogSpeakerBGBlue = "plot_juqing_xian0"
  self._dialogSpeakerBGRed = "plot_juqing_xian1"
  self._createName = {}
  self._createName.go = self._dialogUIView:GetGameObject("CreateName")
  self._createName.go:SetActive(false)
  self._createName.errorTxt = self._dialogUIView:GetUIComponent("UILocalizationText", "ErrorTxt")
  self._createName.inputField = self._dialogUIView:GetUIComponent("EmojiFilteredInputField", "InputField")
  self._createName.placeHolderGO = self._dialogUIView:GetGameObject("Placeholder")
  self._createName.placeHolderLZT = self._dialogUIView:GetUIComponent("UILocalizationText", "Placeholder")
  self._createName.inputDecorateGO = self._dialogUIView:GetGameObject("inputDecorate")
  self._etl = UICustomUIEventListener.Get(self._createName.inputField.gameObject)
  self.uiCustomEventListener:AddUICustomEventListener(self._etl, UIEvent.Press, function()
    if self._createName.inputField.touchScreenKeyboard then
      pcall(StoryEntityDialog.ActiveKeyboard, self, false)
    end
  end)
  self.uiCustomEventListener:AddUICustomEventListener(self._etl, UIEvent.Click, function()
    if string.len(self._createName.inputField.text) <= 0 then
      self._createName.placeHolderLZT.enabled = false
      self._createName.inputDecorateGO:SetActive(false)
    end
  end)
  self._createName.inputField.onValueChanged:AddListener(function()
    local s = self._createName.inputField.text
    if string.match(s, " ") then
      ToastManager.ShowToast(StringTable.Get("str_guide_ROLE_ERROR_CHANGE_NICK_INVALID"))
      s = string.gsub(s, " ", "")
    end
    self._createName.inputField.text = s
    if string.len(self._createName.inputField.text) > 0 then
      self._createName.placeHolderLZT.enabled = true
      self._createName.inputDecorateGO:SetActive(false)
    else
      self._createName.placeHolderLZT.enabled = true
      self._createName.inputDecorateGO:SetActive(true)
    end
  end)
  self._resumeCallBack = GameHelper:GetInstance():CreateCallback(self.OnAppResume, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.AppResume, self._resumeCallBack)
end

function StoryEntityDialog:Destroy()
  if self._resumeCallBack then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.AppResume, self._resumeCallBack)
  end
  self:StopPlayAudio()
  self.uiCustomEventListener:RemoveAllCustomEventListener()
end

function StoryEntityDialog:GetOptions()
  if not self._currentTrackData.Options.OptionLoop then
    return self._currentTrackData.Options
  else
    return self._storyManager:GetOptionData(self._currentTrackData.Options, self._currentTrackData.DialogContentStr)
  end
end

function StoryEntityDialog:InitData()
  self._inSpeakerNameFadeIn = false
  self._speakerNameFadeInStartTime = 0
  self._speakerNameFadeInDuration = 0
  self._speakerNameFadeInColor = Color.New(1, 1, 1, 1)
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
  self._inOptionsFadeIn = false
  self._optionsFadeInStartTime = 0
  self._optionsFadeInDuration = 0
  self._optionsFadeInColor = Color.New(1, 1, 1, 1)
  self._optionsCount = 1
  self._optionsStrList = {
    "",
    "",
    ""
  }
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
  self._audioPlayCallbacks = {}
  self._audioPlayingCallbacks = {}
  self._autoWaitTime = 1
  self._autoWaitOptionTime = 1
  self._optionsFadeInTimeConfig = 0.5
  self._colorPattern = "<color=#%x*"
end

function StoryEntityDialog:SectionStart(trackData)
  StoryEntityDialog.super.SectionStart(self, trackData)
  self._speakerGO:SetActive(false)
  if self._currentTrackData.SpeakerNameStr then
    self._isPlayer = self._currentTrackData.SpeakerNameStr == "ui_story_name_you"
    self._speakerNameStr = StringTable.Get(self._currentTrackData.SpeakerNameStr)
    self._speakerNameStr = self:_DoEscape(self._speakerNameStr)
    self._speakerText:SetText(self._speakerNameStr)
    if self._isPlayer or self._currentTrackData.SpeakerBGColor == "blue" then
      self._speakerBG1.sprite = self._storyManager:GetUIAtlas():GetSprite(self._dialogSpeakerBGBlue)
      self._speakerBG2.sprite = self._storyManager:GetUIAtlas():GetSprite(self._dialogSpeakerBGBlue)
    else
      self._speakerBG1.sprite = self._storyManager:GetUIAtlas():GetSprite(self._dialogSpeakerBGRed)
      self._speakerBG2.sprite = self._storyManager:GetUIAtlas():GetSprite(self._dialogSpeakerBGRed)
    end
  else
    self._speakerText:SetText("")
  end
  self._contentText.gameObject:SetActive(false)
  self._contentStr = StringTable.Get(self._currentTrackData.DialogContentStr)
  self._contentStr = self:_DoEscape(self._contentStr)
  self._contentStr, self._breakIndexList, self._wordTotalCount = self:_GetContentInfo(self._contentStr)
  self._contentText:SetText(self._contentStr)
  self._contentStartShow = false
  self._contentShown = false
  self._contentTypeStartTime = 0
  local transparent = Color.New(1, 1, 1, 0)
  self._speakerBG1.color = transparent
  self._speakerBG2.color = transparent
  self._speakerText.color = transparent
  self._endFlag:SetActive(false)
  self._inContentEnding = false
  self._endClick = false
  self._autoWaitStartTime = 0
  self._optionShown = false
  self._fullscreenBtn.transform.position = self._storyManager:GetStoryUIRoot().transform.parent.position
  if self._currentTrackData.Options ~= nil then
    self._optRoot.transform.position = self._storyManager:GetStoryUIRoot().transform.parent.position
    self._optMask.transform.position = self._storyManager:GetStoryUIRoot().transform.parent.position
    local optionData = self:GetOptions()
    self._optionsCount = #self._options
    local optPosList = self._OptPosList[#optionData]
    local showAffinityIcon = not GameGlobal.GetModule(StoryModule):IsAdded(self._storyManager:GetCurStoryID(), self._storyManager:GetCurParagraphID(), self._storyManager:GetCurSectionIndex())
    for i = 1, self._optionsCount do
      if optionData[i] then
        self._options[i]:SetActive(true)
        self._options[i].transform.localPosition = optPosList[i]
        self._optionBtns[i].interactable = false
        self._optionsStrList[i] = self:_DoEscape(StringTable.Get(optionData[i].Content))
        self._optionTexts[i]:SetText(self._optionsStrList[i])
        self._optionParagraphIDDic[i] = optionData[i].NextParagraphID
        if showAffinityIcon and optionData[i].PetID and optionData[i].Affinity then
          self._optionAffinity[i]:SetActive(true)
          self._optionAffinityData[i] = {
            PetID = optionData[i].PetID,
            Affinity = optionData[i].Affinity
          }
        else
          self._optionAffinity[i]:SetActive(false)
        end
      else
        self._options[i]:SetActive(false)
      end
    end
    self._ropeFront1.gameObject:SetActive(1 < #optionData)
    self._ropeBack1.gameObject:SetActive(1 < #optionData)
    self._ropeBack2.gameObject:SetActive(2 < #optionData)
  end
  if self._currentTrackData.CreateName then
    self._createName.go.transform.position = self._storyManager:GetStoryUIRoot().transform.parent.position
  end
  self._forceAutoDialog = self._storyManager:GetCurParagraph().ForceAutoDialog
end

function StoryEntityDialog:_GetContentInfo(str)
  if str == nil then
    local list = {}
    list[1] = 1
    return "", list, 0
  end
  local plainStr = string.gsub(str, "<size=%d*>", "")
  plainStr = string.gsub(plainStr, "</size>", "")
  plainStr = string.gsub(plainStr, "<color=#%x*>", "")
  plainStr = string.gsub(plainStr, "</color>", "")
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
  return finalStr, breakIndexList, charCount
end

function StoryEntityDialog:_DoEscape(strContent)
  if strContent == nil then
    strContent = ""
    return
  end
  strContent = string.gsub(strContent, "$$", "$")
  local name = GameGlobal.GetModule(RoleModule):GetName()
  if string.isnullorempty(name) then
    name = StringTable.Get("str_guide_moren_name")
  end
  strContent = string.gsub(strContent, "PlayerName", name)
  return strContent
end

function StoryEntityDialog:_GetColorMarkPos(str)
end

function StoryEntityDialog:_TriggerKeyframe(keyframeData)
  self._dialogUIView:SetShow(true, self)
  self._showUI = true
  if self._hideUI then
    self._dialogUIView.gameObject:SetActive(false)
  end
  if keyframeData.ContentBGVisible ~= nil then
    self._contentBG.gameObject:SetActive(keyframeData.ContentBGVisible)
  end
  if keyframeData.ShowSpeakerName then
    self._speakerGO:SetActive(true)
    local showSpeakerNameTime = keyframeData.ShowSpeakerName
    if 0 < showSpeakerNameTime then
      self._inSpeakerNameFadeIn = true
      self._speakerNameFadeInStartTime = keyframeData.Time
      self._speakerNameFadeInDuration = showSpeakerNameTime
    else
      self._speakerNameFadeInColor.a = 1
      self._speakerBG1.color = self._speakerNameFadeInColor
      self._speakerBG2.color = self._speakerNameFadeInColor
      self._speakerText.color = self._speakerNameFadeInColor
    end
  end
  if keyframeData.ShowContent then
    self._contentStartShow = true
    self._contentText.gameObject:SetActive(true)
    self._contentTypeTimeList = keyframeData.TypeTimeList or {}
    self._curBreakIndex = 0
    self._inContentTyping = true
    self._contentTypeStartTime = keyframeData.Time
    self._contentTypeTime = keyframeData.ShowContent * self._breakIndexList[1]
    self._contentText.ShowCharCount = 0
    if self._currentTrackData.VoiceRefID then
      self._storyManager:PlaySound(self._currentTrackData.VoiceRefID)
    end
    if self._currentTrackData.SpeakerRefID then
      self._storyManager:SetSpeakState(self._currentTrackData.SpeakerRefID, true)
    end
    if self._forceAutoDialog then
      self._forceWaitTime = keyframeData.ForceWaitTimeList or {}
    end
    self:PlayAudio(self._currentTrackData.DialogContentStr)
  end
  if keyframeData.ShowCreateName then
    local roleModule = GameGlobal.GetModule(RoleModule)
    if string.isnullorempty(roleModule:GetName()) then
      GameGlobal.ReportCustomEvent("CreateRole", "SetRoleNameView")
      GameGlobal.UAReportForceGuideEvent("SetNameWindowShow")
      self._createName.go:SetActive(true)
    end
  end
  if keyframeData.HideFullScreenBtn ~= nil then
    self._fullscreenBtn:SetActive(not keyframeData.HideFullScreenBtn)
  end
end

function StoryEntityDialog:_UpdateAnimation(time)
  if not self._showUI then
    return false
  end
  if self._inSpeakerNameFadeIn then
    local alpha = (time - self._speakerNameFadeInStartTime) / self._speakerNameFadeInDuration
    if 1 <= alpha then
      alpha = 1
      self._inSpeakerNameFadeIn = false
      self._speakerText:SetText(self._speakerNameStr)
    end
    self._speakerNameFadeInColor.a = alpha
    self._speakerBG1.color = self._speakerNameFadeInColor
    self._speakerBG2.color = self._speakerNameFadeInColor
    self._speakerText.color = self._speakerNameFadeInColor
    local colorStr = string.format("%02x", math.floor(alpha * 255))
    local str = string.gsub(self._speakerNameStr, self._colorPattern, function(s)
      return s .. colorStr
    end)
    self._speakerText:SetText(str)
  end
  if self._inContentTyping then
    if self._inContentEnding then
      if time - self._contentEndStartTime > self._contentEndingTime then
        self._inContentTyping = false
        self._contentShown = true
        self._endFlag:SetActive(true)
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
      self._contentText.ShowCharCount = wordCount
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
      self._endFlag:SetActive(false)
    end
  end
  if self._inOptionsFadeIn then
    if self._optionsFadeInStartTime == 0 then
      self._optionsFadeInStartTime = time
    end
    local alpha = (time - self._optionsFadeInStartTime) / self._optionsFadeInDuration
    if 1 <= alpha then
      alpha = 1
      self._inOptionsFadeIn = false
      for i = 1, self._optionsCount do
        self._optionBtns[i].interactable = true
        self._optionTexts[i]:SetText(self._optionsStrList[i])
      end
    end
    self._optionsFadeInColor.a = alpha
    local colorStr = string.format("%02x", math.floor(alpha * 255))
    for i = 1, self._optionsCount do
      self._optionBGs[i].color = self._optionsFadeInColor
      self._optionTexts[i].color = self._optionsFadeInColor
      local str = string.gsub(self._optionsStrList[i], self._colorPattern, function(s)
        return s .. colorStr
      end)
      self._optionTexts[i]:SetText(str)
    end
    if #self:GetOptions() == 2 then
      self._ropeFront1.color = self._optionsFadeInColor
      self._ropeBack1.color = self._optionsFadeInColor
    elseif #self:GetOptions() == 3 then
      self._ropeFront1.color = self._optionsFadeInColor
      self._ropeBack1.color = self._optionsFadeInColor
      self._ropeBack2.color = self._optionsFadeInColor
    end
  end
  self.playAudio = true
  if self.playAudio then
    local playing
    if self._currentPlayingID then
      playing = AudioHelperController.CheckUIVoicePlaying(self._currentPlayingID)
    end
    if playing then
      self.playAudio = true
    else
      self.playAudio = false
    end
    if not self._auto and not self._forceAutoDialog and self._endClick then
      self.playAudio = false
    end
  end
  if 120 < time then
    self.playAudio = false
  end
  if self._contentShown and self._endClick and not self.playAudio then
    self._dialogUIView:SetShow(false, self)
    self._showUI = false
    return true
  else
    return false
  end
end

function StoryEntityDialog:_DialogEnd()
  self._endClick = true
  if self._currentTrackData.VoiceRefID then
    self._storyManager:StopSound(self._currentTrackData.VoiceRefID)
  end
  self._storyManager:AddDialogRecord(self._speakerText.text, self._contentText.text, self._currentTrackData.SpeakerBGColor, self._isPlayer, self.VoiceID)
  if self._currentTrackData.Options then
    local playerName = self:_DoEscape(StringTable.Get("ui_story_name_you"))
    local optionContent = self._optionsStrList[self._selectedOptionIndex]
    local playerNameBG = "blue"
    self._storyManager:AddDialogRecord(playerName, optionContent, playerNameBG)
  end
end

function StoryEntityDialog:PlayAudio(str)
  local Cfgs = Cfg.cfg_adx2_audio({StoryStr = str})
  self.VoiceID = nil
  if Cfgs then
    self.VoiceID = Cfgs[1].ID
  end
  self:StopPlayAudio()
  for _, callback in ipairs(self._audioPlayCallbacks) do
    self._audioPlayingCallbacks[#self._audioPlayingCallbacks + 1] = callback
    callback(true)
  end
  self._audioPlayCallbacks = {}
  if self.VoiceID then
    self._currentPlayingID = AudioHelperController.PlayUIVoice(self.VoiceID, false)
    AudioHelperController.SetUIVoicePlaySpeed(UnityEngine.Time.timeScale)
    local voiceLength = AudioHelperController.GetPlayingVoiceSecLength(self._currentPlayingID)
    voiceLength = voiceLength <= 0 and 1 or voiceLength
    self._voiceEndEvent = GameGlobal.Timer():AddEvent(voiceLength * 1000, function()
      self:OnAudioStop()
      self._voiceEndEvent = nil
    end)
  end
end

function StoryEntityDialog:StopPlayAudio()
  if self._currentPlayingID then
    AudioHelperController.StopUIVoice(self._currentPlayingID)
  end
  self._currentPlayingID = nil
  if self._voiceEndEvent then
    GameGlobal.Timer():CancelEvent(self._voiceEndEvent)
    self._voiceEndEvent = nil
  end
  self:OnAudioStop()
end

function StoryEntityDialog:OnAudioStop()
  for _, callback in ipairs(self._audioPlayingCallbacks) do
    callback(false)
  end
  self._audioPlayingCallbacks = {}
end

function StoryEntityDialog:AddAudioPlayCallback(callback)
  self._audioPlayCallbacks[#self._audioPlayCallbacks + 1] = callback
end

function StoryEntityDialog:FullScreenBtnOnClick()
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
    self._endFlag:SetActive(false)
  end
end

function StoryEntityDialog:SectionEnd()
  StoryEntityDialog.super.SectionEnd(self)
  self._endClick = true
end

function StoryEntityDialog:_ShowOption()
  if self._currentTrackData.Options == nil then
    self:_DialogEnd()
  else
    self._inOptionsFadeIn = true
    self._optionsFadeInDuration = self._optionsFadeInTimeConfig
    self._optionsFadeInStartTime = 0
    self._optRoot:SetActive(true)
    self._optMask:SetActive(true)
    if self._auto or self._forceAutoDialog then
      self._optRoot.transform:SetParent(self._storyManager:GetStoryUIRoot().transform.parent.parent)
    end
  end
end

function StoryEntityDialog:Opt1OnClick()
  self:_ChooseOption(1)
end

function StoryEntityDialog:Opt2OnClick()
  self:_ChooseOption(2)
end

function StoryEntityDialog:Opt3OnClick()
  self:_ChooseOption(3)
end

function StoryEntityDialog:_ChooseOption(index)
  if self._inOptionsFadeIn then
    return
  end
  local optionData = self._storyManager:GetOptionData(self._currentTrackData.Options, self._currentTrackData.DialogContentStr)
  local selectIndex = optionData[index].optionIndex or index
  GameGlobal.EventDispatcher():Dispatch(GameEventType.StoryChooseOption, selectIndex, self._storyManager)
  GameGlobal.UAReportForceGuideEvent("SotrySelect", {
    self._storyManager:GetCurStoryID(),
    self._storyManager:GetCurParagraphID(),
    self._storyManager:GetCurSectionIndex(),
    selectIndex
  })
  AudioHelperController.PlayRequestedUISound(CriAudioIDConst.SoundStoryClick)
  self._selectedOptionIndex = index
  self._storyManager:AddSelectOptionID(self._currentTrackData, selectIndex)
  self._storyManager:CheckOptionLoopOver(self._currentTrackData.Options, self._currentTrackData.DialogContentStr)
  self._storyManager:SetNextParagraphID(self._optionParagraphIDDic[index])
  self._optRoot:SetActive(false)
  self._optMask:SetActive(false)
  if self._auto then
    self._optRoot.transform:SetParent(self._dialogUIView.transform)
  end
  self._optionParagraphIDDic = {}
  if self._optionAffinityData[selectIndex] then
    GameGlobal.TaskManager():StartTask(self._ChooseOptionReq, self, selectIndex)
  else
    self:_DialogEnd()
  end
end

function StoryEntityDialog:_ChooseOptionReq(TT, index)
  GameGlobal.UIStateManager():Lock("StoryEntityDialog:_ChooseOptionReq")
  local res = GameGlobal.GetModule(StoryModule):ReqAddMsg(TT, self._storyManager:GetCurStoryID(), self._storyManager:GetCurParagraphID(), self._storyManager:GetCurSectionIndex(), index)
  if res:GetSucc() then
    GameGlobal.UIStateManager():CallUIMethod("UIStoryController", "ShowAddAffinity", self._optionAffinityData[index].PetID, self._optionAffinityData[index].Affinity)
  else
    Log.fatal("[Story] error when choose option with affinity increasement, storyID:" .. self._storyManager:GetCurStoryID() .. " paragraphID:" .. self._storyManager:GetCurParagraphID() .. " sectionID:" .. self._storyManager:GetCurSectionIndex() .. " option index:" .. index .. " error code:" .. res:GetResult())
  end
  self:_DialogEnd()
  GameGlobal.UIStateManager():UnLock("StoryEntityDialog:_ChooseOptionReq")
end

function StoryEntityDialog:HideUI(hide)
  self._hideUI = hide
  if hide then
    self._optMask.transform:SetParent(self._dialogUIView.transform.parent)
  else
    self._optMask.transform:SetParent(self._dialogUIView.transform)
    self._optMask.transform:SetSiblingIndex(self._optRoot.transform:GetSiblingIndex())
  end
  self._dialogUIView.gameObject:SetActive(self._showUI and not hide)
end

function StoryEntityDialog:SetAuto(auto)
  self._auto = auto
  self._autoWaitStartTime = 0
  local status, err = pcall(function()
    if self._optRoot.activeSelf then
      if auto then
        self._optRoot.transform:SetParent(self._storyManager:GetStoryUIRoot().transform.parent.parent)
      else
        self._optRoot.transform:SetParent(self._dialogUIView.transform)
      end
    end
  end)
end

function StoryEntityDialog:CheckCreateNameError()
  if string.isnullorempty(self._createName.inputField.text) then
    ToastManager.ShowToast(StringTable.Get("str_guide_create_no_name"))
    return true
  end
  self.newName = self._createName.inputField.text
  if HelperProxy:GetInstance():GetCharLength(self.newName) > 14 then
    ToastManager.ShowToast(StringTable.Get("str_guide_ROLE_ERROR_CHANGE_NICK_LIMIT"))
    return true
  end
  return false
end

function StoryEntityDialog:BtnCreateNameOnClick(go)
  GameGlobal.UAReportForceGuideEvent("SetNameClick")
  if self._currentTrackData and self._currentTrackData.CreateName then
    if self:CheckCreateNameError() then
      GameGlobal.UAReportForceGuideEvent("SetNameFail", {
        ROLE_RESULT_CODE.ROLE_ERROR_CHANGE_NICK_LIMIT
      })
      return
    end
    TaskManager:GetInstance():StartTask(function(TT)
      local roleModule = GameGlobal.GetModule(RoleModule)
      GameGlobal.UIStateManager():Lock("StoryEntityDialog:BtnCreateNameOnClick")
      local res = roleModule:RequestChangeName(TT, self.newName)
      GameGlobal.UIStateManager():UnLock("StoryEntityDialog:BtnCreateNameOnClick")
      if res:GetSucc() then
        roleModule:SetName(self.newName)
        self._storyManager:SetNextParagraphID(self._currentTrackData.CreateName.NextParagraphID)
        self._createName.go:SetActive(false)
        self:_DialogEnd()
        GameGlobal.ReportCustomEvent("CreateRole", "SetRoleName")
        GameGlobal.UAReportForceGuideEvent("SetNameSucc")
        GameGlobal.UAReportChannelEvent("tutorial_start", {})
      else
        local errorCode = res.m_result
        GameGlobal.UAReportForceGuideEvent("SetNameFail", {errorCode})
        if errorCode == ROLE_RESULT_CODE.ROLE_ERROR_CHANGE_NICK_INVALID then
          ToastManager.ShowToast(StringTable.Get("str_guide_ROLE_ERROR_CHANGE_NICK_INVALID"))
        elseif errorCode == ROLE_RESULT_CODE.ROLE_ERROR_CHANGE_NICK_LIMIT then
          ToastManager.ShowToast(StringTable.Get("str_guide_ROLE_ERROR_CHANGE_NICK_LIMIT"))
        elseif errorCode == ROLE_RESULT_CODE.ROLE_ERROR_DIRTY_NICK then
          ToastManager.ShowToast(StringTable.Get("str_guide_ROLE_ERROR_DIRTY_NICK"))
        elseif errorCode == ROLE_RESULT_CODE.ROLE_ERROR_CHANGE_NICK_REPEAT then
          ToastManager.ShowToast(StringTable.Get("str_guide_ROLE_ERROR_CHANGE_NICK_REPEAT"))
        elseif errorCode == ROLE_RESULT_CODE.ROLE_ERROR_CHANGE_NICK_SPE then
          ToastManager.ShowToast(StringTable.Get("str_guide_ROLE_ERROR_CHANGE_NICK_SPE"))
        elseif errorCode == ROLE_RESULT_CODE.ROLE_ERROR_DUPLICATE_NICK then
          ToastManager.ShowToast(StringTable.Get("str_guide_ROLE_ERROR_DUPLICATE_NICK"))
        end
      end
    end)
  end
end

function StoryEntityDialog:OnAppResume()
  if self._createName.inputField.touchScreenKeyboard then
    pcall(StoryEntityDialog.ActiveKeyboard, self, true)
  end
end

function StoryEntityDialog:ActiveKeyboard(active)
  self._createName.inputField.touchScreenKeyboard.active = active
end
