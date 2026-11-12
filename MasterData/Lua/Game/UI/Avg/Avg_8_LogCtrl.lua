local Avg_8_LogCtrl = class("Avg_8_LogCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local item_height_offset = {
  [AllEnum.AvgLogType.Talk] = {
    top = 53,
    bottom = 17.9,
    width = 1118
  },
  [AllEnum.AvgLogType.Choice] = {
    top = 53,
    bottom = 17.9,
    width = 1118
  },
  [AllEnum.AvgLogType.Voiceover] = {
    top = 9,
    bottom = 12,
    width = 1216
  },
  [AllEnum.AvgLogType.PhoneMsg] = {
    top = 60.7,
    bottom = 7,
    width = 1118
  },
  [AllEnum.AvgLogType.PhoneMsgChoice] = {
    top = 53,
    bottom = 17.9,
    width = 1118
  },
  [AllEnum.AvgLogType.Thought] = {
    top = 63,
    bottom = 8.5,
    width = 1118
  }
}
Avg_8_LogCtrl._mapNodeConfig = {
  imgBlurredBg = {},
  txtWindowTitle = {sComponentName = "TMP_Text"},
  txtCalcHeight = {sComponentName = "TMP_Text"},
  rtCalcHeight = {
    sNodeName = "txtCalcHeight",
    sComponentName = "RectTransform"
  },
  LoopSV = {
    sNodeName = "sv",
    sComponentName = "LoopScrollView"
  },
  goWindow = {},
  animWindow = {sNodeName = "goWindow", sComponentName = "Animator"},
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnClose2 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnShortcutClose = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Close"
  },
  sv = {
    sComponentName = "GamepadScroll",
    sAction = "Scroll"
  },
  ActionBar = {
    sCtrlName = "Game.UI.ActionBar.ActionBarCtrl"
  }
}
Avg_8_LogCtrl._mapEventConfig = {
  [EventId.AvgShowHideLog] = "OnEvent_AvgShowHideLog",
  [EventId.AvgMarkLog] = "OnEvent_AvgMarkLog",
  [EventId.AvgSkip] = "OnEvent_Skip",
  [EventId.AvgVoiceDuration] = "OnEvent_AvgVoiceDuration",
  [EventId.AvgSpeedUp] = "OnEvent_AvgSpeedUp"
}
local grid_item_width = 1288

function Avg_8_LogCtrl:ParseContent(sContent)
  sContent = string.gsub(sContent, "==B==", "")
  sContent = string.gsub(sContent, "==W==", "")
  local tbTempContent = string.split(sContent, "==P==")
  local sCombine = ""
  for i, sParagraphContent in ipairs(tbTempContent) do
    sCombine = sCombine .. string.gsub(sParagraphContent, "==A(.+)==", "")
  end
  sContent = sCombine
  sContent = ProcAvgTextContent(sContent, self._panel.nCurLanguageIdx)
  sContent = string.gsub(sContent, "</?[^r>/][^/r>]?[^>]*>", "")
  sContent = string.gsub(sContent, "<rotate[^>]*>", "")
  return sContent
end

function Avg_8_LogCtrl:CalLogItemHeight(nType, sContent)
  local tbOffset = item_height_offset[nType]
  local nWidth = tbOffset.width
  self._mapNode.rtCalcHeight.sizeDelta = Vector2(nWidth, self._mapNode.rtCalcHeight.rect.height)
  sContent = string.gsub(sContent, "</?[^>]+>", "")
  NovaAPI.SetText_RubyTMP(self._mapNode.txtCalcHeight, sContent)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtCalcHeight)
  local nHeight = self._mapNode.rtCalcHeight.rect.height + self.nTxtCalDiffValue
  if nil ~= tbOffset then
    nHeight = nHeight + tbOffset.top + tbOffset.bottom
  end
  return nHeight
end

function Avg_8_LogCtrl:ShowLogList()
  self._mapNode.LoopSV.gameObject:SetActive(#self.tbAvgLog > 0)
  if #self.tbAvgLog > 0 then
    for k, v in ipairs(self.tbAvgLog) do
      local nHeight = self:CalLogItemHeight(v.nType, v.sContent)
      self.tbGridHeight[k] = nHeight
    end
    self._mapNode.LoopSV:InitEx(self.tbGridHeight, self, self.OnRefreshGrid, nil, true)
    self._mapNode.LoopSV:SetScrollPos(0)
  end
end

function Avg_8_LogCtrl:OnRefreshGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local rtGrid = goGrid:GetComponent("RectTransform")
  local logData = self.tbAvgLog[nIndex]
  local nType = logData.nType
  local goLogItem = rtGrid:Find("goLogItem"):GetComponent("RectTransform")
  self.tbAvgLogGrid[nIndex] = goLogItem
  local rtTalk = goLogItem:Find("goTalk"):GetComponent("RectTransform")
  local rtChoice = goLogItem:Find("goChoice"):GetComponent("RectTransform")
  local rtVoiceover = goLogItem:Find("goVoiceover"):GetComponent("RectTransform")
  local rtMessage = goLogItem:Find("goMessage"):GetComponent("RectTransform")
  local rtMessageChoice = goLogItem:Find("goMessageChoice"):GetComponent("RectTransform")
  local rtThought = goLogItem:Find("goThought"):GetComponent("RectTransform")
  local btnPlayVoice = goLogItem:Find("btnPlayVoice"):GetComponent("UIButton")
  local imgPlay = goLogItem:Find("btnPlayVoice/AnimRoot/imgPlay")
  local imgPause = goLogItem:Find("btnPlayVoice/AnimRoot/imgPause")
  local rtPlayVoice = goLogItem:Find("btnPlayVoice"):GetComponent("RectTransform")
  local func_Handler = ui_handler(self, function()
    if WwiseAudioMgr.VoiceVolume <= 0 or not WwiseAudioMgr.m_voice then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Sound_Voice_Closed"))
      return
    end
    self:OnBtnClick_PlayVoice(btnPlayVoice, nIndex)
  end, btnPlayVoice.gameObject, nIndex)
  btnPlayVoice.onClick:RemoveAllListeners()
  btnPlayVoice.onClick:AddListener(func_Handler)
  rtPlayVoice.localPosition = Vector3(rtPlayVoice.localPosition.x, 0, 0)
  local bCurVoicePlay = self.curPlayIndex ~= nil and self.curPlayIndex == nIndex
  imgPlay.gameObject:SetActive(not bCurVoicePlay)
  imgPause.gameObject:SetActive(bCurVoicePlay)
  local rtItem
  if nType == AllEnum.AvgLogType.Talk then
    rtItem = rtTalk
  elseif nType == AllEnum.AvgLogType.Choice then
    rtItem = rtChoice
  elseif nType == AllEnum.AvgLogType.Voiceover then
    rtItem = rtVoiceover
  elseif nType == AllEnum.AvgLogType.PhoneMsg then
    rtItem = rtMessage
  elseif nType == AllEnum.AvgLogType.PhoneMsgChoice then
    rtItem = rtMessageChoice
  elseif nType == AllEnum.AvgLogType.Thought then
    rtItem = rtThought
  end
  rtTalk.gameObject:SetActive(nType == AllEnum.AvgLogType.Talk)
  rtChoice.gameObject:SetActive(nType == AllEnum.AvgLogType.Choice)
  rtVoiceover.gameObject:SetActive(nType == AllEnum.AvgLogType.Voiceover)
  rtMessage.gameObject:SetActive(nType == AllEnum.AvgLogType.PhoneMsg)
  rtMessageChoice.gameObject:SetActive(nType == AllEnum.AvgLogType.PhoneMsgChoice)
  rtThought.gameObject:SetActive(nType == AllEnum.AvgLogType.Thought)
  btnPlayVoice.gameObject:SetActive(logData.sVoice ~= nil and logData.sVoice ~= "")
  local txtTitle, txtContent
  if nType == AllEnum.AvgLogType.Talk then
    txtTitle = rtTalk:Find("txtCharName")
    txtContent = rtTalk:Find("txtTalkContent")
  elseif nType == AllEnum.AvgLogType.Choice then
    txtTitle = rtChoice:Find("txtChoiceTitle")
    txtContent = rtChoice:Find("txtChoiceContent")
  elseif nType == AllEnum.AvgLogType.Voiceover then
    txtContent = rtVoiceover:Find("txtVoiceover")
  elseif nType == AllEnum.AvgLogType.PhoneMsg then
    txtTitle = rtMessage:Find("imgMessage/txtMessageName")
    txtContent = rtMessage:Find("txtMessageContent")
  elseif nType == AllEnum.AvgLogType.PhoneMsgChoice then
    txtTitle = rtMessageChoice:Find("imgMessage/txtMessageName")
    txtContent = rtMessageChoice:Find("txtChoiceContent")
  elseif nType == AllEnum.AvgLogType.Thought then
    txtTitle = rtThought:Find("txtThoughtName")
    txtContent = rtThought:Find("txtThoughtContent")
  end
  if nil ~= txtTitle then
    txtTitle = txtTitle:GetComponent("RubyTextMeshProUGUI")
    NovaAPI.SetText_RubyTMP(txtTitle, logData.sLogTitle)
  end
  if nil ~= txtContent then
    txtContent = txtContent:GetComponent("RubyTextMeshProUGUI")
    NovaAPI.SetText_RubyTMP(txtContent, logData.sContent)
  end
  local nHeight = self.tbGridHeight[nIndex]
  if nil ~= rtItem then
    rtItem.sizeDelta = Vector2(grid_item_width, nHeight)
  end
  rtGrid.sizeDelta = Vector2(grid_item_width, self.tbGridHeight[nIndex])
end

function Avg_8_LogCtrl:StopVoice()
  if self.voiceTimer ~= nil then
    self.voiceTimer:Cancel()
    self.voiceTimer = nil
  end
end

function Avg_8_LogCtrl:ResetAvgLog()
  self.tbAvgLog = {}
end

function Avg_8_LogCtrl:Awake()
  local AvgUIText = require(GetAvgLuaRequireRoot(self._panel.nCurLanguageIdx) .. "Preset/AvgUIText")
  self.nTxtCalDiffValue = 15.5
  self.tbAvgLog = {}
  self.tbAvgLogGrid = {}
  self.tbGridHeight = {}
  self._mapNode.goWindow:SetActive(false)
  self._mapNode.imgBlurredBg.gameObject:SetActive(false)
  local nLanguageIndex = self._panel.nCurLanguageIdx
  NovaAPI.SetTMPText(self._mapNode.txtWindowTitle, AvgUIText.AVG_Log_Title)
  self.tbGamepadUINode = self:GetGamepadUINode()
end

function Avg_8_LogCtrl:OnEnable()
  local tbConfig = {
    {
      sAction = "Back",
      sLang = "ActionBar_Back"
    }
  }
  self._mapNode.ActionBar:InitActionBar(tbConfig)
end

function Avg_8_LogCtrl:OnDisable()
end

function Avg_8_LogCtrl:OnDestroy()
  self:ResetAvgLog()
end

function Avg_8_LogCtrl:OnBtnClick_Close()
  if self.curPlayIndex ~= nil then
    WwiseAudioMgr:WwiseVoice_StopInAVG()
    self.curPlayIndex = nil
  end
  self:StopVoice()
  EventManager.Hit(EventId.AvgShowHideLog, false)
end

function Avg_8_LogCtrl:OnBtnClick_PlayVoice(btn, nIndex)
  if self.curPlayIndex ~= nil then
    local imgCurPlay = self.tbAvgLogGrid[self.curPlayIndex].transform:Find("btnPlayVoice/AnimRoot/imgPlay")
    local imgCurPause = self.tbAvgLogGrid[self.curPlayIndex].transform:Find("btnPlayVoice/AnimRoot/imgPause")
    imgCurPlay.gameObject:SetActive(true)
    imgCurPause.gameObject:SetActive(false)
    WwiseAudioMgr:WwiseVoice_StopInAVG()
    self:StopVoice()
  end
  local imgPlay = btn.transform:Find("AnimRoot/imgPlay")
  local imgPause = btn.transform:Find("AnimRoot/imgPause")
  if self.curPlayIndex ~= nIndex then
    local logData = self.tbAvgLog[nIndex]
    if nil ~= logData and "" ~= logData.sVoice then
      WwiseAudioMgr:WwiseVoice_PlayInAVG(logData.sVoice)
    end
    self.curPlayIndex = nIndex
    imgPlay.gameObject:SetActive(false)
    imgPause.gameObject:SetActive(true)
  else
    self.curPlayIndex = nil
  end
end

function Avg_8_LogCtrl:OnEvent_AvgMarkLog(tbParam)
  local nLanguageIndex = self._panel.nCurLanguageIdx
  local nLogType = tbParam.nType
  local sContent = self:ParseContent(tbParam.sContent)
  local sTitle = ""
  local sAvgId = tbParam.sAvgId or ""
  local sVoice = tbParam.sVoice or ""
  if sAvgId == "avg3_100" or sAvgId == "avg3_101" or sAvgId == "" then
    sTitle = self._panel.sPlayerNickName
  else
    sTitle = self._panel:GetAvgCharName(AdjustMainRoleAvgCharId(sAvgId))
  end
  local AvgUIText = require(GetAvgLuaRequireRoot(self._panel.nCurLanguageIdx) .. "Preset/AvgUIText")
  if nLogType == AllEnum.AvgLogType.Choice then
    sTitle = string.format(AvgUIText.AVG_Log_Choice_Title, sTitle)
  elseif nLogType == AllEnum.AvgLogType.PhoneMsgChoice then
    sTitle = string.format(AvgUIText.AVG_Log_Choice_Title, sTitle)
  elseif nLogType == AllEnum.AvgLogType.Thought then
    sTitle = string.format(AvgUIText.AVG_Log_Thought_Title, sTitle)
  end
  local logData = {
    nType = nLogType,
    sLogTitle = sTitle,
    sContent = sContent,
    sVoice = sVoice
  }
  table.insert(self.tbAvgLog, logData)
end

function Avg_8_LogCtrl:OnEvent_Skip()
  self:ResetAvgLog()
end

function Avg_8_LogCtrl:OnEvent_AvgShowHideLog(bShow)
  if bShow then
    self._mapNode.goWindow.gameObject:SetActive(false)
    self._mapNode.imgBlurredBg.gameObject:SetActive(true)
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      self._mapNode.goWindow.gameObject:SetActive(true)
      self._mapNode.animWindow:Play("t_window_04_t_in")
      self:ShowLogList()
    end
    
    cs_coroutine.start(wait)
    GamepadUIManager.EnableGamepadUI("Avg_8_LogCtrl", self.tbGamepadUINode, nil, true)
  else
    self._mapNode.imgBlurredBg.gameObject:SetActive(false)
    local nAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.animWindow, {
      "t_window_04_t_out"
    })
    self._mapNode.animWindow:Play("t_window_04_t_out")
    self:AddTimer(1, nAnimTime, function()
      self._mapNode.goWindow.gameObject:SetActive(false)
      GamepadUIManager.DisableGamepadUI("Avg_8_LogCtrl")
    end, true, true, true)
  end
end

function Avg_8_LogCtrl:OnEvent_AvgVoiceDuration(nDuration)
  if self.curPlayIndex ~= nil then
    self.voiceTimer = self:AddTimer(1, nDuration, function()
      local imgPlay = self.tbAvgLogGrid[self.curPlayIndex].transform:Find("btnPlayVoice/AnimRoot/imgPlay")
      local imgPause = self.tbAvgLogGrid[self.curPlayIndex].transform:Find("btnPlayVoice/AnimRoot/imgPause")
      imgPlay.gameObject:SetActive(true)
      imgPause.gameObject:SetActive(false)
      self.curPlayIndex = nil
      self.voiceTimer = nil
    end, true, true, true)
  end
end

function Avg_8_LogCtrl:OnEvent_AvgSpeedUp(nRate)
  if self:GetPanelId() ~= PanelId.AvgST then
    return
  end
  self:OnEvent_AvgSpeedUp_Timer(nRate)
  NovaAPI.SetAnimatorSpeed(self._mapNode.animWindow, nRate)
end

return Avg_8_LogCtrl
