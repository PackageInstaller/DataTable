local DOTween = CS.DG.Tweening.DOTween
local Vector2 = CS.UnityEngine.Vector2
local TextMeshProUGUI = CS.TMPro.TextMeshProUGUI
local TMPTypewriter = CS.TMPTypewriter
local TextContentExtraBottom = 10
local ContentTmpDefaultLineSpace = 3.27
local ContentTmpNotCnTwEnLineSpace = -27
local AsiaAreaChAppearSpeed = 0.05
local OtherAreaChAppearSpeed = 0.015
local AsiaAreaTmpSize = 42
local OtherAreaTmpSize = 34
local PlaySpeedToScaleDict = {
  [1] = 1,
  [2] = 3,
  [4] = 10
}
local ContentSliderStartTimeDict = {
  [1] = 3,
  [2] = 1.5,
  [4] = 1.5
}
local PlaySpeedToWriteDurationDict = {
  [1] = 1.5,
  [2] = 1.5,
  [4] = 1.5
}
local PlaySpeedToPauseTimeDict = {
  [1] = 0.5,
  [2] = 0.3,
  [4] = 0.1
}
local PlaySpeedToReadTimeDictDict = {
  [1] = 1.7,
  [2] = 1,
  [4] = 1
}
local AvgDialogTextComp, Super = System.NewClass("AvgDialogTextComp")

function AvgDialogTextComp:ctor(ui, binder, avgModel)
  Super.ctor(self)
  self:_InitViewData(ui, binder, avgModel)
end

function AvgDialogTextComp:_InitViewData(ui, binder, avgModel)
  self.ui = ui
  self.binder = binder
  self.avgModel = avgModel
  self._textWaitTimer = nil
  self._cancelShakeTimer = nil
  self._finalErrCodeTimer = nil
  self._contentSliderTimer = nil
  self._groupTextContentTF = self.ui.Group_Text_Content.transform
  self._curContent = ""
  self._curMaxCharCount = 0
  self._curShowContent = ""
  self._typeWriterDone = false
  self._textScrollDone = true
  self._isBanTypeWriter = false
  self._isTextToErrCode = false
  self._isPassContentSliderStartTime = false
  self._autoSlideTimer = nil
  self._autoSlideTimerList = {}
  self._scrollGen = 0
  self._shakeTmp = self.ui.Text_Content:GetComponent(typeof(CS.Z1Client.DynamicTMP))
  self._shakeTmp.enabled = true
  self._contentTmpComp = self.ui.Text_Content:GetComponent(typeof(TextMeshProUGUI))
  self._contentTmpComp.fontSize = self:_GetFontSize()
  self._contentTmpComp.lineSpacing = self:_GetTextLineSpace()
end

function AvgDialogTextComp:SetFastModeAndPlaySpeed(isFastMode, playSpeed, isAuto)
  self.isFastMode = Vue.ref(isFastMode)
  self.playSpeed = Vue.ref(playSpeed)
  self.isAuto = Vue.ref(isAuto)
end

function AvgDialogTextComp:ClearDialogText()
  self:_SetCurContent("")
  self.binder:SetText(self.ui.Text_Content, "")
end

function AvgDialogTextComp:SetDialogText(showText, isBanTypeWriter, captionDuration)
  self._isBanTypeWriter = isBanTypeWriter
  if self._isBanTypeWriter then
    self._captionDuration = captionDuration
  end
  self:_ShowNextDialogText(showText)
end

function AvgDialogTextComp:_SetCurContent(strVal)
  self._curContent = strVal
end

function AvgDialogTextComp:_UpdateCurMaxCharCount()
  local textInfo = self._contentTmpComp.textInfo
  local maxCharacterNum = textInfo and textInfo.characterCount or 0
  if 0 == maxCharacterNum then
    maxCharacterNum = #self._curContent / 2
  end
  self._curMaxCharCount = maxCharacterNum
end

function AvgDialogTextComp:_InitContentPos()
  self._groupTextContentTF.anchoredPosition = Vector2(0, 0)
end

function AvgDialogTextComp:_GetSliderEndPos()
  local lineHeight = self:_GetTextLineHeight()
  local extraLineCnt = self:_GetExtraLineCnt()
  do return math.max, 0 end
  return math.max, 0, extraLineCnt * lineHeight
end

function AvgDialogTextComp:_GetTextLineCnt()
  CS.UnityEngine.Canvas.ForceUpdateCanvases()
  self._contentTmpComp:ForceMeshUpdate()
  return self._contentTmpComp.textInfo.lineCount
end

function AvgDialogTextComp:_GetExtraLineCnt()
  return self:_GetTextLineCnt() - self:_GetMaxShowLineCnt()
end

function AvgDialogTextComp:_GetMaxShowLineCnt()
  local textLineCnt = self:_GetTextLineCnt()
  if textLineCnt > 2 then
    return 2
  end
  local scrollViewHeight = self.ui.ScrollView_Story.transform.sizeDelta.y
  local textLineTotalHeight = self:_GetTextLineTotalHeight()
  if scrollViewHeight < textLineTotalHeight - 4 then
    return 1
  end
  return 2
end

function AvgDialogTextComp:_GetTextLineSpace()
  local currTextLanguage = DataCenter.gameData.CurrTextLanguage
  local isWide = "CN" == currTextLanguage or "TW" == currTextLanguage or "EN" == currTextLanguage or "KR" == currTextLanguage
  return isWide and ContentTmpDefaultLineSpace or ContentTmpNotCnTwEnLineSpace
end

function AvgDialogTextComp:_GetTextLineTotalHeight()
  do return math.max, self._contentTmpComp.preferredHeight - TextContentExtraBottom end
  return math.max, self._contentTmpComp.preferredHeight - TextContentExtraBottom, self._contentTmpComp.textBounds.size.y
end

function AvgDialogTextComp:_GetTextLineHeight()
  local totalHeight = self:_GetTextLineTotalHeight()
  return totalHeight / self:_GetTextLineCnt()
end

function AvgDialogTextComp:_SetContentSlideDotween()
  local perLinePauseTime = self:GetContentSliderPauseTime()
  local perLineWriteDuration = self:GetPerLineWriteDuration()
  local lineHeight = self:_GetTextLineHeight()
  local extraLineCnt = self:_GetExtraLineCnt()
  for i = 1, extraLineCnt do
    local startTime = (i - 1) * (perLineWriteDuration + perLinePauseTime)
    local targetPos = i * lineHeight
    self._autoSlideTimerList[i] = self.binder:BindTimer(startTime, 0, nil, function()
      if not self.isAuto.value then
        self:_ClearAutoSlideTimer()
        return
      end
      self.contentSliderDotween = DOTween.To(function()
        return self._groupTextContentTF.anchoredPosition.y
      end, function(newV)
        self._groupTextContentTF.anchoredPosition = Vector2(0, newV)
      end, targetPos, perLineWriteDuration, self)
    end)
  end
  local totalDuration = extraLineCnt * (perLineWriteDuration + perLinePauseTime)
  self._autoSlideTimer = self.binder:BindTimer(totalDuration, 0, nil, function()
    self:_SetTextScrollDone(true)
  end)
end

function AvgDialogTextComp:_ClearAutoSlideTimer()
  for _, timer in pairs(self._autoSlideTimerList) do
    self.binder:StopTimer(timer)
  end
  self._autoSlideTimerList = {}
  self.binder:StopTimer(self._autoSlideTimer)
  self._autoSlideTimer = nil
  self:_ClearContentSlideDotween()
end

function AvgDialogTextComp:SlideToNextLine()
  if self._isBanTypeWriter then
    return
  end
  if not self:GetIsPassContentSliderStartTime() then
    self:_SetIsPassContentSliderStartTime(true)
  end
  local lineHeight = self:_GetTextLineHeight()
  local extraLineCnt = self:_GetExtraLineCnt()
  local curY = self._groupTextContentTF.anchoredPosition.y
  local endY = lineHeight * extraLineCnt
  if math.abs(curY - endY) < 10 then
    self:_SetTextScrollDone(true)
    return
  end
  if self:IsTextScrollDone() then
    return
  end
  if self.contentSliderDotween then
    return
  end
  local perLineWriteDuration = self:GetPerLineWriteDuration()
  local targetPos = lineHeight + curY
  self.contentSliderDotween = DOTween.To(function()
    return self._groupTextContentTF.anchoredPosition.y
  end, function(newV)
    self._groupTextContentTF.anchoredPosition = Vector2(0, newV)
  end, targetPos, perLineWriteDuration, self)
  local gen = self._scrollGen
  self.binder:BindTimer(perLineWriteDuration, 0, nil, function()
    if self._scrollGen ~= gen then
      return
    end
    self:_ClearContentSlideDotween()
    if not self:IsTextScrollDone() then
      local nowY = self._groupTextContentTF.anchoredPosition.y
      if math.abs(nowY - endY) < 10 then
        self:_SetTextScrollDone(true)
      end
    end
  end)
end

function AvgDialogTextComp:GetTypeWriterChAppearSpeed()
  return self:_IsAsiaLanguage() and AsiaAreaChAppearSpeed or OtherAreaChAppearSpeed
end

function AvgDialogTextComp:_GetFontSize()
  return self:_IsAsiaLanguage() and AsiaAreaTmpSize or OtherAreaTmpSize
end

function AvgDialogTextComp:GetContentSliderPauseTime()
  if self.isFastMode.value then
    return 0.15
  end
  return PlaySpeedToPauseTimeDict[self.playSpeed.value]
end

function AvgDialogTextComp:GetContentSliderStartTime()
  if self.isFastMode.value then
    return 1.5
  end
  return ContentSliderStartTimeDict[self.playSpeed.value]
end

function AvgDialogTextComp:GetPerLineWriteDuration()
  if self.isFastMode.value then
    return 1.5
  end
  return PlaySpeedToWriteDurationDict[self.playSpeed.value]
end

function AvgDialogTextComp:GetScale()
  if self.isFastMode.value then
    return 10
  end
  return PlaySpeedToScaleDict[self.playSpeed.value]
end

function AvgDialogTextComp:_GetWaitToReadTime()
  if self.isFastMode.value then
    return 1
  end
  if not self.isAuto.value then
    return 0.3
  end
  return PlaySpeedToReadTimeDictDict[self.playSpeed.value]
end

function AvgDialogTextComp:_SetTextScrollDone(isDone)
  self._textScrollDone = isDone
  if isDone then
    self:PrintTextDone()
  end
end

function AvgDialogTextComp:IsTextScrollDone()
  return self._textScrollDone
end

function AvgDialogTextComp:_SetTypeWriterDone(isDone)
  self._typeWriterDone = isDone
  if isDone then
    self:PrintTextDone()
  end
end

function AvgDialogTextComp:_ClearContentSlideDotween()
  if self.contentSliderDotween then
    self.contentSliderDotween:Kill(false)
    self.contentSliderDotween = nil
  end
end

function AvgDialogTextComp:_StopTextTimers()
  if self._textWaitTimer then
    self.binder:StopTimer(self._textWaitTimer)
    self._textWaitTimer = nil
  end
  if self._cancelShakeTimer then
    self.binder:StopTimer(self._cancelShakeTimer)
    self._cancelShakeTimer = nil
  end
  if self._finalErrCodeTimer then
    self.binder:StopTimer(self._finalErrCodeTimer)
    self._finalErrCodeTimer = nil
  end
  self:_ClearContentSliderTimer()
  self:_ClearTextToErrCode()
end

function AvgDialogTextComp:_ClearContentSliderTimer()
  if self._contentSliderTimer then
    self.binder:StopTimer(self._contentSliderTimer)
    self._contentSliderTimer = nil
  end
end

function AvgDialogTextComp:IsPrinting()
  local isWriterDone = self.compTMPTypewriter and self.compTMPTypewriter.enabled and not self.compTMPTypewriter:IsDone()
  return isWriterDone
end

function AvgDialogTextComp:IsWaitToRead()
  return self._textWaitTimer
end

function AvgDialogTextComp:_IsAsiaLanguage()
  local currTextLanguage = DataCenter.gameData.CurrTextLanguage
  do return table.contains, {
    "CN",
    "TW",
    "JP",
    "KR"
  } end
  return table.contains, {
    "CN",
    "TW",
    "JP",
    "KR"
  }, currTextLanguage, "TW", "JP", "KR"
end

function AvgDialogTextComp:_ShowNextDialogText(showText)
  if not self.ui.Text_Content.activeInHierarchy then
    self.binder:BindTimer(0.05, 0, nil, function()
      self:SetDialogText(showText, self._isBanTypeWriter, self._captionDuration)
    end)
    return
  end
  self._isTextToErrCode = string.find(showText, "<Change>", 0, true)
  showText = StrUtils.ReplaceAvgContent(showText)
  showText = string.replace(showText, "<Change>", "", true)
  self.binder:SetText(self.ui.Text_Content, showText)
  self._contentTmpComp:ForceMeshUpdate()
  local textLineCnt = self:_GetTextLineCnt()
  if textLineCnt > 10 then
    self.binder:SetText(self.ui.Text_Content, "")
    FrameWaiter.OnNextFrame(function()
      self:SetDialogText(showText, self._isBanTypeWriter, self._captionDuration)
    end, 1)
    return
  end
  self:_SetCurContent(showText)
  self:_HideNextIcon()
  self:_StopTextTimers()
  self:_ShakeContent()
  self:_UpdateCurMaxCharCount()
  self:_InitContentPos()
  showText = self._contentTmpComp.text
  self._curShowContent = showText
  if self._isBanTypeWriter then
    self._contentTmpComp.maxVisibleCharacters = 9999
    self:PausePrinting()
    self:_MoveContentToEndPos(self._captionDuration)
    self:StopTyping()
    return
  end
  self:StartPrinting()
end

function AvgDialogTextComp:PausePrinting()
  TMPTypewriter.StopTyping(self._contentTmpComp.gameObject)
end

function AvgDialogTextComp:StartPrinting()
  self._scrollGen = (self._scrollGen or 0) + 1
  self:_SetTextScrollDone(false)
  self:_SetTypeWriterDone(false)
  self:_SetIsPassContentSliderStartTime(false)
  self:_ClearContentSlideDotween()
  self:_ClearAutoSlideTimer()
  self:_ClearTextToErrCode()
  local textLineCnt = self:_GetTextLineCnt()
  local needScroll = textLineCnt > self:_GetMaxShowLineCnt()
  if not needScroll then
    self:_SetTextScrollDone(true)
  end
  self.compTMPTypewriter = TMPTypewriter.Get(self._contentTmpComp.gameObject)
  self.compTMPTypewriter.chAppearSpeed = self:GetTypeWriterChAppearSpeed()
  self.compTMPTypewriter.chFadeInSpeed = 0.5
  self.compTMPTypewriter.showErrCode = false
  self.compTMPTypewriter.chAppearPace = self:GetScale()
  
  function self.compTMPTypewriter.onAppearedFinished()
    self:_SetTypeWriterDone(true)
  end
  
  self.compTMPTypewriter:StartPrinting()
  self._contentSliderTimer = self.binder:BindTimer(self:GetContentSliderStartTime(), 0, nil, function()
    self:_SetIsPassContentSliderStartTime(true)
    if needScroll and self:IsAutoSlide() then
      self:StartContentSlide()
    end
  end)
  if self._isTextToErrCode then
    self:ShowTextToErrCode()
  end
end

function AvgDialogTextComp:_ClearTextToErrCode()
  if self._isTextToErrCodeTimer then
    self.binder:StopTimer(self._isTextToErrCodeTimer)
    self._isTextToErrCodeTimer = nil
  end
end

function AvgDialogTextComp:ShowTextToErrCode()
  self:_ClearTextToErrCode()
  local totalIndex = utf8.len(self._curShowContent)
  local curCount = 1
  local waitReadCount = 10
  self._isTextToErrCodeTimer = self.binder:BindTimer(0.05, -1, function()
    local maxReplaceCount = 8
    local errText = StrUtils.ReplaceToErrCode(self._curShowContent, curCount, maxReplaceCount)
    self._contentTmpComp.text = errText
    curCount = curCount + 1
    if curCount > totalIndex + waitReadCount then
      self:_ClearTextToErrCode()
      self:PrintTextDone()
    end
  end)
end

function AvgDialogTextComp:StartContentSlide()
  if self.contentSliderDotween then
    return
  end
  self:_SetContentSlideDotween()
end

function AvgDialogTextComp:_ShakeContent()
  self._shakeTmp:CheckShakeRange()
  self.ui.Text_Content:SetActive(false)
  self.ui.Text_Content:SetActive(true)
  self._shakeTmp.enableShake = true
  self._cancelShakeTimer = self.binder:BindTimer(1, 0, nil, function()
    self._cancelShakeTimer = nil
    self._shakeTmp.enableShake = false
    self._contentTmpComp:ForceMeshUpdate()
  end)
end

function AvgDialogTextComp:_HideNextIcon()
  if self.ui.Image_Next_Icon then
    self.ui.Image_Next_Icon:SetActive(false)
  end
end

function AvgDialogTextComp:_MoveContentToEndPos(moveDuration)
  moveDuration = moveDuration or 0.5
  self:_ClearContentSlideDotween()
  DOTween.To(function()
    return self._groupTextContentTF.anchoredPosition.y
  end, function(newV)
    self._groupTextContentTF.anchoredPosition = Vector2(0, newV)
  end, self:_GetSliderEndPos(), moveDuration, self)
  self.binder:BindTimer(moveDuration, 0, nil, function()
    self:_SetTextScrollDone(true)
  end)
end

function AvgDialogTextComp:IsAutoSlide()
  return self.isAuto.value or self.isFastMode.value
end

function AvgDialogTextComp:StopTyping()
  if self:IsPrinting() then
    self.compTMPTypewriter:ToEnd(true)
  else
    self:PrintTextDone()
  end
end

function AvgDialogTextComp:PrintTextDone()
  if not self._typeWriterDone or not self._textScrollDone then
    return
  end
  if self._isTextToErrCodeTimer then
    return
  end
  self.avgModel:FinishAction(CommonDefine.AvgAction.ShowDialogText)
  if self.ui.Image_Next_Icon then
    self.ui.Image_Next_Icon:SetActive(true)
  end
  self.timeOfPrintDown = CS.Framework.TimeUtil.GetRealtimeSinceStartup()
  self.binder:StopTimer(self._finalErrCodeTimer)
  local waitToRead = self:_GetWaitToReadTime()
  if self._isTextToErrCode then
    waitToRead = waitToRead + 1
    self.compTMPTypewriter:ShowOrgString()
    self:ShowFinalErrCode()
  end
  self._textWaitTimer = self.binder:BindTimer(waitToRead, 0, nil, function()
    self._textWaitTimer = nil
  end)
end

function AvgDialogTextComp:ShowFinalErrCode()
  local textCount = self._curMaxCharCount
  local emojAndTextCount = {
    {"1", 2},
    {"2", 4},
    {"3", 6},
    {"4", 8}
  }
  if DataCenter.gameData.CurrTextLanguage ~= cd.Lang.CN and DataCenter.gameData.CurrTextLanguage ~= cd.Lang.TW then
    emojAndTextCount = {
      {"1", 4},
      {"2", 8},
      {"3", 12},
      {"4", 16}
    }
  end
  local errorCodeList = {}
  while textCount > 0 do
    local errCode, count = table.unpack(emojAndTextCount[math.random(1, #emojAndTextCount)])
    table.insert(errorCodeList, errCode)
    textCount = textCount - count
  end
  local errorCodeIndexList = {}
  for index, _ in ipairs(errorCodeList) do
    local indexList = {
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      0
    }
    local loopFrame = math.random(2, 4)
    for i = 2, loopFrame do
      table.insert(indexList, 1, i)
    end
    errorCodeIndexList[index] = indexList
  end
  local fps = 22
  local loopCount = 15
  self._finalErrCodeTimer = self.binder:BindTimer(1 / fps, loopCount, function()
    self:_ClearTextToErrCode()
    local str = ""
    for index, indexStr in ipairs(errorCodeList) do
      local indexList = errorCodeIndexList[index]
      local frame = table.remove(indexList, 1) or 0
      if frame then
        str = string.format("%s%s", str, string.format("<sprite=\"UI_Story_Confuse_Effect%s\" index=%s>", indexStr, frame))
      end
    end
    self._contentTmpComp.text = str
  end)
end

function AvgDialogTextComp:_SetIsPassContentSliderStartTime(isPass)
  self._isPassContentSliderStartTime = isPass
end

function AvgDialogTextComp:GetIsPassContentSliderStartTime()
  return self._isPassContentSliderStartTime
end

return AvgDialogTextComp
