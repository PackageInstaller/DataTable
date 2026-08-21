_class("UIN25IdolStoryEntityDialog", StoryEntity)
UIN25IdolStoryEntityDialog = UIN25IdolStoryEntityDialog

function UIN25IdolStoryEntityDialog:Constructor(ID, gameObject, resRequest, storyManager)
  UIN25IdolStoryEntityDialog.super.Constructor(self, ID, gameObject, resRequest, storyManager)
  self._type = StoryEntityType.Dialog
  self.newName = ""
  self._splitChar = "|"
  self._defaultBreakTypeTime = 0.2
  self._contentEndingTime = 0.2
  self.uiCustomEventListener = UICustomUIEventListener:New()
  self:InitUIComponents(gameObject)
  self:InitData()
end

function UIN25IdolStoryEntityDialog:InitUIComponents(gameObject)
  self._dialogUIView = gameObject:GetComponent("UIView")
  self._contentBG = self._dialogUIView:GetGameObject("DialogBG")
  self._speakerGO = self._dialogUIView:GetGameObject("DialogSpeaker")
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
    self._optionBtns[i] = self._dialogUIView:GetUIComponent("Image", "opt" .. i .. "Btn")
  end
  self._optionBGs = {}
  for i = 1, 3 do
    self._optionBGs[i] = self._dialogUIView:GetUIComponent("Image", "opt" .. i .. "Btn")
  end
  self._optionTexts = {}
  for i = 1, 3 do
    self._optionTexts[i] = self._dialogUIView:GetUIComponent("UILocalizationText", "opt" .. i .. "Text")
  end
  self._optionCanClick = {}
  for i = 1, 3 do
    self._optionCanClick[i] = {}
    for j = 1, 2 do
      self._optionCanClick[i][j] = self._dialogUIView:GetGameObject("canClick" .. i .. j)
    end
  end
  self._optionParagraphIDDic = {}
  self._optionCantClickDic = {}
  self._optionAffinityData = {}
  self._optionThreeDData = {}
  self._optionEndingData = {}
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
  self.sp3 = self._dialogUIView:GetGameObject("sp3")
  self.sp4 = self._dialogUIView:GetGameObject("sp4")
  self.sp5 = self._dialogUIView:GetGameObject("sp5")
  self._addThreeDValue = self._dialogUIView:GetUIComponent("UILocalizationText", "AddThreeDValue")
  self._addThreeDView = self._dialogUIView:GetGameObject("AddThreeDView")
  self.texColor1 = Color(0.42745098039215684, 0.3137254901960784, 0.7647058823529411, 1)
  self.texColor2 = Color(0.788235294117647, 0.7647058823529411, 0.8313725490196079, 1)
end

function UIN25IdolStoryEntityDialog:Destroy()
  if self._resumeCallBack then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.AppResume, self._resumeCallBack)
  end
  self.uiCustomEventListener:RemoveAllCustomEventListener()
end

function UIN25IdolStoryEntityDialog:InitData()
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
  self._autoWaitTime = 1
  self._autoWaitOptionTime = 1
  self._optionsFadeInTimeConfig = 0.5
  self._colorPattern = "<color=#%x*"
end

function UIN25IdolStoryEntityDialog:SectionStart(trackData)
  UIN25IdolStoryEntityDialog.super.SectionStart(self, trackData)
  self._speakerGO:SetActive(false)
  if self._currentTrackData.SpeakerNameStr then
    self._isPlayer = self._currentTrackData.SpeakerNameStr == "ui_story_name_you"
    self._speakerNameStr = StringTable.Get(self._currentTrackData.SpeakerNameStr)
    self._speakerNameStr = self:_DoEscape(self._speakerNameStr)
    self._speakerText:SetText(self._speakerNameStr)
    if self._isPlayer then
    else
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
    local optionData = self._currentTrackData.Options
    self._optionsCount = #self._options
    local optPosList = self._OptPosList[#optionData]
    local showAffinityIcon = not GameGlobal.GetModule(StoryModule):IsAdded(self._storyManager:GetCurStoryID(), self._storyManager:GetCurParagraphID(), self._storyManager:GetCurSectionIndex())
    self._optionAffinityData = {}
    self._optionThreeDData = {}
    self._optionEndingData = {}
    self._optionParagraphIDDic = {}
    self._optionCantClickDic = {}
    for i = 1, self._optionsCount do
      if optionData[i] then
        self._options[i]:SetActive(true)
        self._optionBtns[i].raycastTarget = false
        self._optionsStrList[i] = self:_DoEscape(StringTable.Get(optionData[i].Content))
        self._optionTexts[i]:SetText(self._optionsStrList[i])
        self._optionParagraphIDDic[i] = optionData[i].NextParagraphID
        self._optionCantClickDic[i] = self:GetBtnCantClick(optionData[i].CanClickCondition)
        local sp, color
        if not self._optionCantClickDic[i] then
          self._optionCanClick[i][1]:SetActive(true)
          self._optionCanClick[i][2]:SetActive(false)
          color = self.texColor1
        else
          self._optionCanClick[i][2]:SetActive(true)
          self._optionCanClick[i][1]:SetActive(false)
          color = self.texColor2
        end
        self._optionTexts[i].color = color
        if optionData[i].ThreeD or optionData[i].FinishEnding then
          if optionData[i].Affinity then
            self._optionAffinityData[i] = {
              PetID = optionData[i].PetID,
              Affinity = optionData[i].Affinity
            }
          elseif optionData[i].ThreeD then
            self._optionThreeDData[i] = true
          else
            if optionData[i].FinishEnding then
              self._optionEndingData[i] = optionData[i].FinishEnding
            else
            end
          end
        end
      else
        self._options[i]:SetActive(false)
      end
    end
  end
  if self._currentTrackData.AddThreeDView then
    Log.debug("###addview")
    if self._chooseAddThreeDInfo then
      self._addThreeDView:SetActive(true)
      Log.debug("###addviewinfo")
      local anim = self._addThreeDView:GetComponent("Animation")
      anim:Play()
      local value = self._chooseAddThreeDInfo.value
      self._addThreeDValue:SetText("+" .. value)
      local type = self._chooseAddThreeDInfo.type
      Log.debug("###addviewtype:", type)
      self.sp3:SetActive(type == IdolTrainType.IdolTrainType_Music)
      self.sp4:SetActive(type == IdolTrainType.IdolTrainType_Dance)
      self.sp5:SetActive(type == IdolTrainType.IdolTrainType_Perform)
      self._chooseAddThreeDInfo = nil
    end
  else
    self._addThreeDView:SetActive(false)
  end
  self._forceAutoDialog = self._storyManager:GetCurParagraph().ForceAutoDialog
end

function UIN25IdolStoryEntityDialog:_GetContentInfo(str)
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

function UIN25IdolStoryEntityDialog:_DoEscape(strContent)
  strContent = string.gsub(strContent, "$$", "$")
  local name = GameGlobal.GetModule(RoleModule):GetName()
  if string.isnullorempty(name) then
    name = StringTable.Get("str_guide_moren_name")
  end
  strContent = string.gsub(strContent, "PlayerName", name)
  return strContent
end

function UIN25IdolStoryEntityDialog:_GetColorMarkPos(str)
end

function UIN25IdolStoryEntityDialog:_TriggerKeyframe(keyframeData)
  self._dialogUIView:SetShow(true, self)
  self._showUI = true
  if self._hideUI then
    self._dialogUIView.gameObject:SetActive(false)
  end
  if keyframeData.ContentBGVisible ~= nil then
    self._contentBG:SetActive(keyframeData.ContentBGVisible)
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
  end
  if keyframeData.HideFullScreenBtn ~= nil then
    self._fullscreenBtn:SetActive(not keyframeData.HideFullScreenBtn)
  end
end

function UIN25IdolStoryEntityDialog:_UpdateAnimation(time)
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
        self._optionBtns[i].raycastTarget = true
        self._optionTexts[i]:SetText(self._optionsStrList[i])
      end
    end
    self._optionsFadeInColor.a = alpha
    local colorStr = string.format("%02x", math.floor(alpha * 255))
    for i = 1, self._optionsCount do
      self._optionBGs[i].color = self._optionsFadeInColor
      self._optionTexts[i].color = Color(self._optionTexts[i].color.r, self._optionTexts[i].color.g, self._optionTexts[i].color.b, alpha)
      local str = string.gsub(self._optionsStrList[i], self._colorPattern, function(s)
        return s .. colorStr
      end)
      self._optionTexts[i]:SetText(str)
    end
  end
  if self._contentShown and self._endClick then
    self._dialogUIView:SetShow(false, self)
    self._showUI = false
    return true
  else
    return false
  end
end

function UIN25IdolStoryEntityDialog:_DialogEnd()
  self._endClick = true
  if self._currentTrackData.VoiceRefID then
    self._storyManager:StopSound(self._currentTrackData.VoiceRefID)
  end
  self._storyManager:AddDialogRecord(self._speakerText.text, self._contentText.text, self._currentTrackData.SpeakerBGColor, self._isPlayer)
  if self._currentTrackData.Options then
    local playerName = self:_DoEscape(StringTable.Get("ui_story_name_you"))
    local optionContent = self._optionsStrList[self._selectedOptionIndex]
    local playerNameBG = "blue"
    self._storyManager:AddDialogRecord(playerName, optionContent, playerNameBG)
  end
end

function UIN25IdolStoryEntityDialog:FullScreenBtnOnClick()
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

function UIN25IdolStoryEntityDialog:SectionEnd()
  UIN25IdolStoryEntityDialog.super.SectionEnd(self)
  self._endClick = true
end

function UIN25IdolStoryEntityDialog:_ShowOption()
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

function UIN25IdolStoryEntityDialog:Opt1OnClick()
  self:_ChooseOption(1)
end

function UIN25IdolStoryEntityDialog:Opt2OnClick()
  self:_ChooseOption(2)
end

function UIN25IdolStoryEntityDialog:Opt3OnClick()
  self:_ChooseOption(3)
end

function UIN25IdolStoryEntityDialog:_ChooseOption(index)
  if self._inOptionsFadeIn then
    return
  end
  if self._optionCantClickDic[index] then
    local conditions = self._optionCantClickDic[index]
    local eventid = conditions[1]
    local cfg = Cfg.cfg_component_idol_event({EventId = eventid})[1]
    local petid = cfg.PetId
    local pet_cfg = Cfg.cfg_pet[petid]
    local petName = pet_cfg.Name
    local tips = StringTable.Get("str_n25_idol_y_story_cant_click_tips", StringTable.Get(petName))
    ToastManager.ShowToast(tips)
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.StoryChooseOption, index, self._storyManager)
  GameGlobal.UAReportForceGuideEvent("SotrySelect", {
    self._storyManager:GetCurStoryID(),
    self._storyManager:GetCurParagraphID(),
    self._storyManager:GetCurSectionIndex(),
    index
  })
  AudioHelperController.PlayRequestedUISound(CriAudioIDConst.SoundStoryClick)
  self._selectedOptionIndex = index
  self._storyManager:SetNextParagraphID(self._optionParagraphIDDic[index])
  self._optRoot:SetActive(false)
  self._optMask:SetActive(false)
  if self._auto then
    self._optRoot.transform:SetParent(self._dialogUIView.transform)
  end
  self._optionParagraphIDDic = {}
  self._optionCantClickDic = {}
  if self:GetOnlyReview() then
    self:_DialogEnd()
    return
  end
  if self._optionAffinityData[index] then
    GameGlobal.TaskManager():StartTask(self._ChooseOptionReq, self, index)
  elseif self._optionThreeDData[index] then
    self:ChooseOptionThreeDReq(index)
  elseif self._optionEndingData[index] then
    self:ChooseOptionFinishEndingReq(index)
  else
    self:_DialogEnd()
  end
end

function UIN25IdolStoryEntityDialog:ChooseOptionFinishEndingReq(index)
  local ccIsShow = GameGlobal.UIStateManager():IsShow("UIN25IdolConcert")
  if not ccIsShow then
    self:_DialogEnd()
    return
  end
  local id = self._optionEndingData[index]
  GameGlobal.UIStateManager():CallUIMethod("UIN25IdolConcert", "FinishEnding", id, function(succ, res)
    if succ then
      self:_DialogEnd()
    else
      Log.fatal("[Story] error when choose option with fans increasement add threed, storyID:" .. self._storyManager:GetCurStoryID() .. " paragraphID:" .. self._storyManager:GetCurParagraphID() .. " sectionID:" .. self._storyManager:GetCurSectionIndex() .. " option index:" .. index .. " error code:" .. res:GetResult())
    end
  end)
end

function UIN25IdolStoryEntityDialog:GetOnlyReview()
  local onlyReview = GameGlobal.UIStateManager():CallUIMethod("UIN25IdolStoryController", "GetOnlyReview")
  return onlyReview
end

function UIN25IdolStoryEntityDialog:ChooseOptionThreeDReq(index)
  local apIsShow = GameGlobal.UIStateManager():IsShow("UIN25IdolApController")
  if not apIsShow then
    self:_DialogEnd()
    return
  end
  GameGlobal.UIStateManager():CallUIMethod("UIN25IdolApController", "AddThreeD", index, function(succ, Type, Value, res)
    if succ then
      self._chooseAddThreeDInfo = {type = Type, value = Value}
      self:_DialogEnd()
    else
      Log.fatal("[Story] error when choose option with fans increasement add threed, storyID:" .. self._storyManager:GetCurStoryID() .. " paragraphID:" .. self._storyManager:GetCurParagraphID() .. " sectionID:" .. self._storyManager:GetCurSectionIndex() .. " option index:" .. index .. " error code:" .. res:GetResult())
    end
  end)
end

function UIN25IdolStoryEntityDialog:_ChooseOptionReq(TT, index)
  GameGlobal.UIStateManager():Lock("UIN25IdolStoryEntityDialog:_ChooseOptionReq")
  local res = GameGlobal.GetModule(StoryModule):ReqAddMsg(TT, self._storyManager:GetCurStoryID(), self._storyManager:GetCurParagraphID(), self._storyManager:GetCurSectionIndex(), index)
  if res:GetSucc() then
    GameGlobal.UIStateManager():CallUIMethod("UIStoryController", "ShowAddAffinity", self._optionAffinityData[index].PetID, self._optionAffinityData[index].Affinity)
  else
    Log.fatal("[Story] error when choose option with affinity increasement, storyID:" .. self._storyManager:GetCurStoryID() .. " paragraphID:" .. self._storyManager:GetCurParagraphID() .. " sectionID:" .. self._storyManager:GetCurSectionIndex() .. " option index:" .. index .. " error code:" .. res:GetResult())
  end
  self:_DialogEnd()
  GameGlobal.UIStateManager():UnLock("UIN25IdolStoryEntityDialog:_ChooseOptionReq")
end

function UIN25IdolStoryEntityDialog:HideUI(hide)
  self._hideUI = hide
  if hide then
    self._optMask.transform:SetParent(self._dialogUIView.transform.parent)
  else
    self._optMask.transform:SetParent(self._dialogUIView.transform)
    self._optMask.transform:SetSiblingIndex(self._optRoot.transform:GetSiblingIndex())
  end
  self._dialogUIView.gameObject:SetActive(self._showUI and not hide)
end

function UIN25IdolStoryEntityDialog:SetAuto(auto)
  self._auto = auto
  self._autoWaitStartTime = 0
  if self._optRoot.activeSelf then
    if auto then
      self._optRoot.transform:SetParent(self._storyManager:GetStoryUIRoot().transform.parent.parent)
    else
      self._optRoot.transform:SetParent(self._dialogUIView.transform)
    end
  end
end

function UIN25IdolStoryEntityDialog:GetBtnCantClick(condition)
  if EditorGlobal.IsEditorMode() then
    return false
  end
  if not condition then
    return false
  end
  local cant
  local apIsShow = GameGlobal.UIStateManager():IsShow("UIN25IdolApController")
  if apIsShow then
    cant = GameGlobal.UIStateManager():CallUIMethod("UIN25IdolApController", "CheckOptionCantClick", condition)
  else
    cant = GameGlobal.UIStateManager():CallUIMethod("UIN25IdolConcert", "CheckOptionCantClick", condition)
  end
  if cant then
    return condition
  end
  return false
end
