require("story_entity")
_class("N28StoryEntityAVGDialog", StoryEntity)
N28StoryEntityAVGDialog = N28StoryEntityAVGDialog

function N28StoryEntityAVGDialog:Constructor(ID, gameObject, resRequest, storyManager)
  N28StoryEntityAVGDialog.super.Constructor(self, ID, gameObject, resRequest, storyManager)
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN28AVGData()
  self._type = StoryEntityType.AVGDialog
  self.newName = ""
  self._splitChar = "|"
  self._defaultBreakTypeTime = 0.2
  self._contentEndingTime = 0.2
  self:InitUIComponents(gameObject)
  self:InitData()
  self._playedIn = false
end

function N28StoryEntityAVGDialog:InitUIComponents(gameObject)
  self._dialogUIView = gameObject:GetComponent("UIView")
  self._contentBG = self._dialogUIView:GetGameObject("DialogBG")
  self._speakerGO = self._dialogUIView:GetGameObject("DialogSpeaker")
  self._contentText = self._dialogUIView:GetUIComponent("UIRichText", "Content")
  self._speakerText = self._dialogUIView:GetUIComponent("UILocalizationText", "SpeakerName")
  self.txtSpeakerName = self._dialogUIView:GetUIComponent("UILocalizationText", "txtSpeakerName")
  self._endFlag = self._dialogUIView:GetGameObject("EndFlag")
  self._fullscreenBtn = self._dialogUIView:GetGameObject("FullScreenBtn")
  self._dialogSpeakerBGBlue = "plot_juqing_xian0"
  self._dialogSpeakerBGRed = "plot_juqing_xian1"
  self._anim = self._dialogUIView:GetUIComponent("Animation", "anim")
  self._dialogBg = self._dialogUIView:GetUIComponent("CanvasGroup", "DialogBG")
  self._dialogLayout = self._dialogUIView:GetUIComponent("CanvasGroup", "DialogLayout")
end

function N28StoryEntityAVGDialog:Destroy()
  if self._playAnimationTask then
    GameGlobal.TaskManager():KillTask(self._playAnimationTask)
    self._playAnimationTask = nil
  end
  self._playedIn = false
  GameGlobal.UIStateManager():UnLock("N28StoryEntityAVGDialog_PlayAnimationIn")
  GameGlobal.UIStateManager():UnLock("N28StoryEntityAVGDialog_PlayAnimationOut")
end

function N28StoryEntityAVGDialog:InitData()
  self._inSpeakerNameFadeIn = false
  self._speakerNameFadeInStartTime = 0
  self._speakerNameFadeInDuration = 0
  self._speakerNameFadeInColor = Color.New(0.3647, 0.3686, 0.4117, 1)
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
  self._contentStartShowTime = 0
  self._contentStr = ""
  self._wordTotalCount = 0
  self._curBreakIndex = 0
  self._endClick = false
  self._showUI = false
  self._hideUI = false
  self._autoBtnList = {}
  self._auto = false
  self._autoWaitStartTime = 0
  self._eventShown = false
  self._forceAutoDialog = false
  self._forceWaitTime = {}
  self._autoWaitTime = 1
  self._autoWaitOptionTime = 1
  self._optionsFadeInTimeConfig = 0.5
  self._colorPattern = "<color=#%x*"
end

function N28StoryEntityAVGDialog:SectionStart(trackData)
  N28StoryEntityAVGDialog.super.SectionStart(self, trackData)
  self._speakerGO:SetActive(false)
  if self._currentTrackData.SpeakerNameStr then
    self._isPlayer = self._currentTrackData.SpeakerNameStr == "ui_story_name_you"
    self._speakerNameStr = StringTable.Get(self._currentTrackData.SpeakerNameStr)
    self._speakerNameStr = self:_DoEscape(self._speakerNameStr)
    self._speakerText:SetText(self._speakerNameStr)
    self.txtSpeakerName:SetText(self._speakerNameStr)
  else
    self._speakerText:SetText("")
    self.txtSpeakerName:SetText("")
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
  self.txtSpeakerName.color = transparent
  self._endFlag:SetActive(false)
  self._inContentEnding = false
  self._endClick = false
  self._autoWaitStartTime = 0
  self._eventShown = false
  self._fullscreenBtn.transform.position = self._storyManager:GetStoryUIRoot().transform.parent.position
  self._forceAutoDialog = self._storyManager:GetCurParagraph().ForceAutoDialog
end

function N28StoryEntityAVGDialog:_GetContentInfo(str)
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

function N28StoryEntityAVGDialog:_DoEscape(strContent)
  strContent = string.gsub(strContent, "$$", "$")
  local name = GameGlobal.GetModule(RoleModule):GetName()
  if string.isnullorempty(name) then
    name = StringTable.Get("str_guide_moren_name")
  end
  strContent = string.gsub(strContent, "PlayerName", name)
  return strContent
end

function N28StoryEntityAVGDialog:_TriggerKeyframe(keyframeData)
  self._dialogUIView:SetShow(true, self)
  if not self._playedIn then
    if self._playAnimationTask then
      GameGlobal.TaskManager():KillTask(self._playAnimationTask)
      self._playAnimationTask = nil
    end
    GameGlobal.UIStateManager():Lock("N28StoryEntityAVGDialog_PlayAnimationIn")
    self._playAnimationTask = GameGlobal.TaskManager():StartTask(function(TT)
      self:_SetCanvasGroupAlpha(0)
      self._playedIn = true
      YIELD(TT)
      self._anim:Play("uieff_UIN28AVGStoryDialog_Dialog_in")
      self:_SetCanvasGroupAlpha(1)
      YIELD(TT, 767)
      self._anim:Play("uieff_UIN28AVGStoryDialog_star_01")
      GameGlobal.UIStateManager():UnLock("N28StoryEntityAVGDialog_PlayAnimationIn")
    end, self)
  elseif not self._anim:IsPlaying("uieff_UIN28AVGStoryDialog_Dialog_in") then
    self._anim:Play("uieff_UIN28AVGStoryDialog_star_01")
  end
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
      self.txtSpeakerName.color = self._speakerNameFadeInColor
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
  if keyframeData.ShowCreateName then
    local roleModule = GameGlobal.GetModule(RoleModule)
    if string.isnullorempty(roleModule:GetName()) then
      GameGlobal.ReportCustomEvent("CreateRole", "SetRoleNameView")
      GameGlobal.UAReportForceGuideEvent("SetNameWindowShow")
    end
  end
  if keyframeData.HideFullScreenBtn ~= nil then
    self._fullscreenBtn:SetActive(not keyframeData.HideFullScreenBtn)
  end
end

function N28StoryEntityAVGDialog:_UpdateAnimation(time)
  if not self._showUI then
    return false
  end
  if self._inSpeakerNameFadeIn then
    local alpha = (time - self._speakerNameFadeInStartTime) / self._speakerNameFadeInDuration
    if 1 <= alpha then
      alpha = 1
      self._inSpeakerNameFadeIn = false
      self._speakerText:SetText(self._speakerNameStr)
      self.txtSpeakerName:SetText(self._speakerNameStr)
    end
    self._speakerNameFadeInColor.a = alpha
    self._speakerText.color = self._speakerNameFadeInColor
    self.txtSpeakerName.color = self._speakerNameFadeInColor
    local colorStr = string.format("%02x", math.floor(alpha * 255))
    local str = string.gsub(self._speakerNameStr, self._colorPattern, function(s)
      return s .. colorStr
    end)
    self._speakerText:SetText(str)
    self.txtSpeakerName:SetText(str)
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
      if self._currentTrackData.Options == nil and self._currentTrackData.Events == nil then
        if time - self._autoWaitStartTime >= self._autoWaitTime then
          self:_DialogEnd()
        end
      elseif time - self._autoWaitStartTime >= self._autoWaitOptionTime and not self._eventShown then
        self:_CheckAVGEvent()
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
      end
    end
    self._optionsFadeInColor.a = alpha
    local colorStr = string.format("%02x", math.floor(alpha * 255))
    for i = 1, self._optionsCount do
      local str = string.gsub(self._optionsStrList[i], self._colorPattern, function(s)
        return s .. colorStr
      end)
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

function N28StoryEntityAVGDialog:_DialogEnd()
  self._endClick = true
  if self._currentTrackData.VoiceRefID then
    self._storyManager:StopSound(self._currentTrackData.VoiceRefID)
  end
  self._storyManager:AddDialogRecord(self._speakerText.text, self._contentText.text, self._currentTrackData.SpeakerBGColor, self._isPlayer)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AVGOnDialogEnd)
end

function N28StoryEntityAVGDialog:FullScreenBtnOnClick()
  if self._endClick or self._forceAutoDialog or not self._contentStartShow then
    return
  end
  if self._auto then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AVGStopAutoState)
  end
  if self._contentShown then
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundStoryClick)
    self:_CheckAVGEvent()
  elseif self._inContentTyping then
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundStoryClick)
    self._typeClickEnd = true
  else
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundStoryClick)
    self._contentTypeStartTime = self._storyManager:GetCurrentTime()
    self._inContentTyping = true
    self._endFlag:SetActive(false)
  end
end

function N28StoryEntityAVGDialog:SectionEnd()
  N28StoryEntityAVGDialog.super.SectionEnd(self)
  self._endClick = true
end

function N28StoryEntityAVGDialog:_ShowOption()
  if self._currentTrackData.Options == nil then
    self:_DialogEnd()
  else
    self._eventShown = true
    self._inOptionsFadeIn = true
    self._optionsFadeInDuration = self._optionsFadeInTimeConfig
    self._optionsFadeInStartTime = 0
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AVGShowOption)
  end
end

function N28StoryEntityAVGDialog:_CheckAVGEvent()
  if self._currentTrackData.Events == nil then
    self:_ShowOption()
  else
    self._eventShown = true
    self.curHandleEventidx = 0
    self:DoNextAVGEvent()
  end
end

function N28StoryEntityAVGDialog:GetEviencePhaseEvent(id)
  local cfg = self.data:GetCfgAvgPhase()
  for _, v in pairs(cfg) do
    if v.EventID == id then
      return v
    end
  end
  return nil
end

function N28StoryEntityAVGDialog:DoNextAVGEvent()
  self.curHandleEventidx = self.curHandleEventidx + 1
  local ev = self._currentTrackData.Events[self.curHandleEventidx]
  if ev == nil then
    self:_DialogEnd()
    return
  end
  local event = self:GetEviencePhaseEvent(ev.ID)
  if event then
    if event.Type == N28StateAVGEvent.AddEvidence then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.AVGGainEvidence, event, self)
    elseif event.Type == N28StateAVGEvent.DeleteEvidence then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.AVGGainEvidence, event, self)
    elseif event.Type == N28StateAVGEvent.ShowEvidence then
      local trackData = self._currentTrackData.ShowEvidence
      if trackData then
        if not self._anim:IsPlaying("uieff_UIN28AVGStoryDialog_Dialog_out") then
          if self._playAnimationTask then
            GameGlobal.TaskManager():KillTask(self._playAnimationTask)
            self._playAnimationTask = nil
          end
          GameGlobal.UIStateManager():Lock("N28StoryEntityAVGDialog_PlayAnimationOut")
          self._playAnimationTask = GameGlobal.TaskManager():StartTask(function(TT)
            self._anim:Play("uieff_UIN28AVGStoryDialog_Dialog_out")
            YIELD(TT, 500)
            GameGlobal.EventDispatcher():Dispatch(GameEventType.AVGShowEvdience, event, trackData, self)
            self._playedIn = false
            GameGlobal.UIStateManager():UnLock("N28StoryEntityAVGDialog_PlayAnimationOut")
          end, self)
        end
      else
        Log.error("There is no ShowEvidence data but has event! ", ev.ID)
        self:DoNextAVGEvent()
      end
    elseif event.Type == N28StateAVGEvent.HideEvidenceBook then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.AVGHideEvdienceBook, event, self)
      self:DoNextAVGEvent()
    else
      Log.error("N28StoryEntityAVGDialog error, event type not exist - ", ev.ID, event.Type)
      self:DoNextAVGEvent()
    end
  else
    Log.error("N28StoryEntityAVGDialog error, eventid not exist - ", ev.ID)
    self:DoNextAVGEvent()
  end
end

function N28StoryEntityAVGDialog:HideUI(hide)
  self._hideUI = hide
  self._dialogUIView.gameObject:SetActive(self._showUI and not hide)
end

function N28StoryEntityAVGDialog:SetAuto(auto, id)
  id = id or 0
  self._autoBtnList[id] = auto
  if auto then
    self._auto = auto
  else
    local re = false
    for _, v in pairs(self._autoBtnList) do
      re = re or v
    end
    self._auto = re
  end
  self._autoWaitStartTime = 0
end

function N28StoryEntityAVGDialog:GetAuto(id)
  id = id or 0
  return self._autoBtnList[id]
end

function N28StoryEntityAVGDialog:_SetCanvasGroupAlpha(alpha)
  self._dialogBg.alpha = alpha
  self._dialogLayout.alpha = alpha
end

local N28StateAVGEvent = {
  AddEvidence = 1,
  DeleteEvidence = 2,
  ShowEvidence = 3,
  HideEvidenceBook = 4
}
_enum("N28StateAVGEvent", N28StateAVGEvent)
