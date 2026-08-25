local T_TextMeshProUGUI = typeof(CS.TMPro.TextMeshProUGUI)
local TMPTypewriter = CS.TMPTypewriter
local T_DynamicTMP = typeof(CS.Z1Client.DynamicTMP)
local AvgTextComp, Super = System.NewClass("AvgTextComp")

function AvgTextComp:ctor(binder, textGameObj, finishIcon)
  Super.ctor(self)
  self.binder = binder
  self.textGameObj = textGameObj
  self.finishIcon = finishIcon
  self.contentTmpComp = self.textGameObj:GetComponent(T_TextMeshProUGUI)
  self.shakeTmp = textGameObj:GetComponent(T_DynamicTMP)
  self.curContent = ""
  self.curMaxCharCount = 0
  self.onTextPrintDown = nil
end

function AvgTextComp:Awake()
end

function AvgTextComp:ClearDialogText()
  self.curContent = ""
  TMPTypewriter.StopTyping(self.contentTmpComp.gameObject)
  self.binder:SetText(self.textGameObj, "")
  self:StopTextTimers()
end

function AvgTextComp:SetDialogText(showText, isAddQuote)
  showText = LT.Text(showText)
  self.curContent = showText
  if self.finishIcon then
    self.finishIcon:SetActive(false)
  end
  self:StopTextTimers()
  self.isTextToErrCode = string.find(showText, "<Change>", 0, true)
  local content = StrUtils.ReplaceAvgContent(showText)
  content = StrUtils.SetWordEffectStr(content)
  content = LT.ReplaceUnicodeSpace(content)
  content = string.replace(content, "<Change>", "", true)
  if isAddQuote then
    content = "「" .. content .. "」"
  end
  self.binder:SetText(self.textGameObj, "")
  self.binder:SetRawText(self.textGameObj, content)
  if self.shakeTmp then
    self.shakeTmp:CheckShakeRange()
    self.textGameObj:SetActive(false)
    self.textGameObj:SetActive(true)
    self.shakeTmp.enableShake = true
    self.cancelShakeTimer = self.binder:BindTimer(1, 0, nil, function()
      self.cancelShakeTimer = nil
      self.shakeTmp.enableShake = false
      self.contentTmpComp:ForceMeshUpdate()
    end)
  end
  local textInfo = self.contentTmpComp.textInfo
  local maxCharacterNum = textInfo and textInfo.characterCount or 0
  if 0 == maxCharacterNum then
    maxCharacterNum = #content / 2
  end
  self.curMaxCharCount = maxCharacterNum
  self.compTMPTypewriter = TMPTypewriter.Get(self.contentTmpComp.gameObject)
  self.compTMPTypewriter.chAppearSpeed = tonumber(DT.GetConstant("AvgDialog_OneWordTime")) or 0.05
  self.compTMPTypewriter.chFadeInSpeed = 0.5
  self.compTMPTypewriter.showErrCode = self.isTextToErrCode ~= nil and self.isTextToErrCode ~= false
  self.compTMPTypewriter.chAppearPace = self:GetScale()
  
  function self.compTMPTypewriter.onAppearedFinished()
    self:PrintTextDone()
  end
  
  self.compTMPTypewriter:StartPrinting()
end

function AvgTextComp:StopTyping()
  if self:IsPrinting() then
    self.compTMPTypewriter:ToEnd(true)
  else
    self:PrintTextDone()
  end
end

function AvgTextComp:GetScale()
  return 1
end

function AvgTextComp:IsPrinting()
  return self.compTMPTypewriter and self.compTMPTypewriter.enabled and not self.compTMPTypewriter:IsDone()
end

function AvgTextComp:IsWaitToRead()
  return self.textWaitTimer
end

function AvgTextComp:PrintTextDone()
  if self.finishIcon then
    self.finishIcon:SetActive(true)
  end
  self.timeOfPrintDown = CS.Framework.TimeUtil.GetRealtimeSinceStartup()
  self.binder:StopTimer(self.finalErrCodeTimer)
  local waitToRead = tonumber(DT.GetConstant("AvgDialog_ClickWaitToRead", false)) or 0.1
  if self.isTextToErrCode then
    waitToRead = waitToRead + 1
    self.compTMPTypewriter:ShowOrgString()
    self:ShowFinalErrCode()
  end
  self.textWaitTimer = self.binder:BindTimer(waitToRead, 0, nil, function()
    self.textWaitTimer = nil
  end)
end

function AvgTextComp:ShowFinalErrCode()
  local textCount = self.curMaxCharCount
  local emojAndTextCount = {
    {"1", 2},
    {"2", 4},
    {"3", 6},
    {"4", 8}
  }
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
  self.finalErrCodeTimer = self.binder:BindTimer(1 / fps, loopCount, function()
    local str = ""
    for index, indexStr in ipairs(errorCodeList) do
      local indexList = errorCodeIndexList[index]
      local frame = table.remove(indexList, 1) or 0
      if frame then
        str = string.format("%s%s", str, string.format("<sprite=\"UI_Story_Confuse_Effect%s\" index=%s>", indexStr, frame))
      end
    end
    self.contentTmpComp.text = str
  end)
end

function AvgTextComp:StopTextTimers()
  if self.textWaitTimer then
    self.binder:StopTimer(self.textWaitTimer)
  end
  if self.cancelShakeTimer then
    self.binder:StopTimer(self.cancelShakeTimer)
  end
  if self.finalErrCodeTimer then
    self.binder:StopTimer(self.finalErrCodeTimer)
  end
end

return AvgTextComp
