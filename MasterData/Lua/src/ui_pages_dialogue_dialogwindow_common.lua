local page = class("dialogWindow_Common", G_UIPageBase)
local disableClick = false
local DialogTextState = {
  NONE = 0,
  TYPING = 1,
  WAIT_FOR_CLICK = 2,
  ENDING = 3
}
local TextData = {
  showType = nil,
  fadeInTime = nil,
  fadeOutTime = nil,
  clickNext = nil,
  writerInterval = nil,
  showSkip = nil,
  messages = nil,
  onclosed = nil
}

function page.bind()
  return {
    blackMaskActive = false,
    skipButtonActive = true,
    buttonsActive = true,
    arrowActive = false,
    speakerActive = false,
    normalTextUI = false,
    subtitleUI = false,
    subtitleText = "",
    dialogWriterPlayText = nil,
    dialogWriterTimeInterval = 0.05,
    dialogWriterCmd = 0,
    contentText = "",
    speakerText = "",
    speakerRect = C_Vector2(250, 43),
    blackTextUI = false,
    blackWriterPlayText = nil,
    blackWriterTimeInterval = 0.05,
    blackWriterCmd = 0,
    oldNotepadPos = C_Vector2(10, -48),
    oldNotepadTextUI = false,
    oldNotepadPlayText = "",
    oldNotepadNameText = "",
    oldNotepadNameTextActive = false,
    oldNotepadHaveNameIcon = false,
    oldNotepadNoNameIcon = false,
    oldNotepadNoNamePlaceholder = false,
    writedSubtitleTextUI = false,
    writedSubtitlePlayText = nil,
    writedSubtitleTimeInterval = 0.05,
    writedSubtitleWriterCmd = 0,
    bgPath = "",
    bgActive = false,
    picturePath = "",
    framePicturePath = "",
    cutinPicturePath1 = "",
    cutinPicturePath2 = "",
    cutinText = "",
    cutinActive = false,
    videoActive = false,
    tachieItems = {
      moduleName = "pages/dialogue/dialogTachieView"
    },
    globalMaskActive = false,
    illustrationActive = false
  }
end

function page:escHandle()
end

function page.methods()
  return {
    dragBegin = function(self, pos)
      disableClick = true
    end,
    drag = function(self, pos)
    end,
    dragEnd = function(self, pos)
    end,
    skipOnClick = function(self)
      if self.textData then
        self:showNextText()
      end
    end,
    nextDialogueClick = function(self)
      if disableClick == true then
        disableClick = false
        return
      end
      if self.textData then
        self:onMainClick()
      end
    end,
    autoOn = function(self)
    end,
    autoOff = function(self)
    end,
    onLogClick = function(self)
      self:onLogClick()
    end,
    onHideClick = function(self)
    end,
    onDialogWriterPlayComplete = function(self)
      self:onWriteComplete()
    end,
    onBlackWriterPlayComplete = function(self)
      self:onWriteComplete()
    end,
    onSubtitleWriterPlayComplete = function(self)
      self:onWriteComplete()
    end
  }
end

function page:ctor()
  page.super.ctor(self)
end

function page:preOpen(options)
  options = options or {}
  self._isClosed = false
  self.bind.bgPath = ""
  self.bind.globalMaskActive = false
  C_LBlurStack.SetBlurRadius(0)
end

function page:show()
  C_LBlurStack.SetBlurRadius(0)
end

function page:close(options)
  self._isClosed = true
end

function page:closeSelf()
  L_UI:close(self.pageName)
end

function page:setSkipState(isActive)
  local AlphaPercent = isActive and 1 or 0.3
  self.bindComponents.ButtonSkipIcon.color = CS.UnityEngine.Color(1, 1, 1, AlphaPercent)
  self.bindComponents.ButtonSkip.color = CS.UnityEngine.Color(1, 1, 1, AlphaPercent)
end

function page:setTextData(textData, endCallback)
  self.textData = textData
  self._endCallback = endCallback
  self._textState = DialogTextState.NONE
  self._messageIndex = 0
  self._messageDuration = nil
  self._messageDurationTimer = nil
  self._messageTimeEnd = false
  self:showNextText()
end

function page:showNextText()
  self._messageIndex = self._messageIndex + 1
  self:stopMessageDurationTimer()
  if self._messageIndex > #self.textData.messages then
    self:doEnd()
    return
  end
  local message = self.textData.messages[self._messageIndex]
  if not message then
    self:showNextText()
    return
  end
  local contentStr, speakerStr, duration = message.content, message.speaker, message.duration
  if not contentStr or contentStr == "" then
    self:showNextText()
    return
  end
  self._messageDuration = duration
  self._messageTimeEnd = false
  if not self.textData.clickNext and self._messageDuration and self._messageDuration > 0 then
    self._messageDurationTimer = Timer.new(handler(self, self.onMessageDurationTimerEnd), self._messageDuration, 1)
    self._messageDurationTimer:start()
  end
  self.bind.arrowActive = false
  self.bind.blackTextUI = false
  self.bind.normalTextUI = false
  self.bind.subtitleUI = false
  self.bind.oldNotepadTextUI = false
  self.bind.writedSubtitleTextUI = false
  self._textState = DialogTextState.NONE
  local showType = self.textData.showType
  local writerInterval = self.textData.writerInterval
  if writerInterval == nil then
    writerInterval = 0.05
  elseif writerInterval < 0.001 then
    writerInterval = 0.001
  end
  self.bind.skipButtonActive = self.textData.showSkip ~= false
  if showType == 0 then
    self.bind.normalTextUI = true
    if not string.isEmpty(speakerStr) then
      self.bind.speakerText = speakerStr
      self.bind.speakerActive = true
    else
      self.bind.speakerActive = false
    end
    self.bind.dialogWriterPlayText = contentStr
    self.bind.dialogWriterTimeInterval = writerInterval
    self._textState = DialogTextState.TYPING
  elseif showType == 1 then
    self.bind.blackTextUI = true
    self.bind.blackWriterPlayText = contentStr
    self.bind.blackWriterTimeInterval = writerInterval
    self._textState = DialogTextState.TYPING
  elseif showType == 4 then
    self.bind.subtitleUI = true
    self.bind.subtitleText = contentStr
    self._textState = DialogTextState.WAIT_FOR_CLICK
    if not self.textData.clickNext and not self._messageDurationTimer then
      self:showNextText()
    end
  elseif showType == 5 then
    self.bind.oldNotepadTextUI = true
    self.bind.oldNotepadPlayText = contentStr
    self._textState = DialogTextState.WAIT_FOR_CLICK
    local haveSpeaker = not string.isEmpty(speakerStr)
    self.bind.oldNotepadNameTextActive = haveSpeaker
    if haveSpeaker then
      self.bind.oldNotepadNameText = speakerStr
      self.bind.oldNotepadPos = self.bindComponents.OldNotePadNoNamePos.anchoredPosition
    else
      self.bind.oldNotepadPos = self.bindComponents.OldNotePadHaveNamePos.anchoredPosition
    end
    self.bind.oldNotepadHaveNameIcon = haveSpeaker
    self.bind.oldNotepadNoNameIcon = not haveSpeaker
    self.bind.oldNotepadNoNamePlaceholder = not haveSpeaker
    if not self.textData.clickNext and not self._messageDurationTimer then
      self:showNextText()
    end
  elseif showType == 6 then
    self.bind.writedSubtitleTextUI = true
    self.bind.writedSubtitlePlayText = contentStr
    self.bind.writedSubtitleTimeInterval = writerInterval
    self._textState = DialogTextState.TYPING
  else
    warn("dialogWindow_Common", "未知类型", showType)
    self:showNextText()
  end
  if 0 >= self.textData.writerInterval then
    self:finishWriterImmidiately()
  end
end

function page:doEnd()
  self:stopMessageDurationTimer()
  self.textData = nil
  local callback = self._endCallback
  self._endCallback = nil
  if callback then
    callback()
  end
end

function page:onWriteComplete()
  if not self.textData then
    return
  end
  self._textState = DialogTextState.WAIT_FOR_CLICK
  if not self.textData.clickNext and (self._messageTimeEnd or self._messageDurationTimer == nil) then
    self:showNextText()
  end
end

function page:finishWriterImmidiately()
  if self.bind.blackTextUI then
    self.bind.blackWriterCmd = C_LTextTypeWriter.Cmd_ShowText
  elseif self.bind.writedSubtitleTextUI then
    self.bind.writedSubtitleWriterCmd = C_LTextTypeWriter.Cmd_ShowText
  else
    self.bind.dialogWriterCmd = C_LTextTypeWriter.Cmd_ShowText
  end
  self._textState = DialogTextState.WAIT_FOR_CLICK
end

function page:onMainClick()
  if self._textState == DialogTextState.TYPING then
    self:finishWriterImmidiately()
    return
  end
  if self._textState == DialogTextState.WAIT_FOR_CLICK and self.textData.clickNext then
    self:showNextText()
    return
  end
end

function page:onLogClick()
end

function page:onMessageDurationTimerEnd()
  self:stopMessageDurationTimer()
  self._messageTimeEnd = true
  if self._textState == DialogTextState.WAIT_FOR_CLICK then
    self:showNextText()
  end
end

function page:stopMessageDurationTimer()
  if self._messageDurationTimer then
    self._messageDurationTimer:stop()
    self._messageDurationTimer = nil
  end
end

return page
