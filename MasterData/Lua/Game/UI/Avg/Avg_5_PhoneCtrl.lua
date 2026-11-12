local Avg_5_PhoneCtrl = class("Avg_5_PhoneCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local CONST_WIDTH = 340
local CONST_GRID_WIDTH = 1022.9
local DEFAULT_AUTOPLAY_MIN_TIME = 1
local DEFAULT_AUTOPLAY_MAX_TIME = 2.5
local AUTO_PLAY_WAITING_VOIVE = 1
local max_chat_width = 708
local max_choice_width = 650
local choice_txt_diff = 22.06
local choice_img_diff = 20.22
local choice_selection_top = 26
local choice_selection_bottom = 28
local choice_selection_input = 116
local choice_selection_space = 12.5
local choice_head_offset = 15
local SelectType = {
  ThinkingGoOn = 1,
  PhoneGoOn = 2,
  ChoiceMsg = 3
}
Avg_5_PhoneCtrl._mapNodeConfig = {
  txtCalcHeight = {sComponentName = "TMP_Text"},
  rtCalcHeight = {
    sNodeName = "txtCalcHeight",
    sComponentName = "RectTransform"
  },
  txtMsgCalcHeight = {sComponentName = "TMP_Text"},
  rtMsgCalcHeight = {
    sNodeName = "txtMsgCalcHeight",
    sComponentName = "RectTransform"
  },
  layoutCalcHeight = {
    sNodeName = "txtCalcHeight",
    sComponentName = "LayoutElement"
  },
  imgBtnGoOn = {
    sNodeName = "btnPhoneGoOn",
    sComponentName = "Image"
  },
  btnGoOn = {
    sNodeName = "btnPhoneGoOn",
    sComponentName = "NaviButton",
    callback = "OnBtnClick_GoOn"
  },
  rtRoot = {
    sComponentName = "RectTransform"
  },
  canvasGroupRoot = {
    sNodeName = "rtRoot",
    sComponentName = "CanvasGroup"
  },
  rtInputRoot = {
    sComponentName = "RectTransform"
  },
  txtReply = {sComponentName = "TMP_Text"},
  txtReply_shadow = {sComponentName = "TMP_Text"},
  rtSvReply = {
    sNodeName = "svReply",
    sComponentName = "RectTransform"
  },
  imgCursor = {sComponentName = "Image"},
  loopSV = {
    sNodeName = "sv",
    sComponentName = "LoopScrollView"
  },
  Viewport_SV = {
    sComponentName = "Button",
    callback = "OnBtnClick_GoOn"
  },
  trContent = {sNodeName = "Content_SV", sComponentName = "Transform"},
  rtViewPort_SV = {
    sNodeName = "Viewport_SV",
    sComponentName = "RectTransform"
  },
  rtContent_SV = {
    sNodeName = "Content_SV",
    sComponentName = "RectTransform"
  },
  layoutContent_SV = {
    sNodeName = "Content_SV",
    sComponentName = "GridLayoutGroup"
  },
  imgMsgDetail = {
    sNodeName = "imgMsgDetail",
    sComponentName = "Image"
  },
  aniMsgDetail = {
    sNodeName = "rtImgMsgDetail",
    sComponentName = "Animator"
  },
  btnSnapShot = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_HideImgMsg"
  },
  txtSkip = {
    sNodeName = "txtNotice",
    sComponentName = "TMP_Text",
    sLanguageId = "Tips_Continue"
  },
  animMainRole = {
    sNodeName = "----main_role----",
    sComponentName = "Animator"
  },
  rtMainRole = {
    sNodeName = "----main_role----",
    sComponentName = "RectTransform"
  },
  trMainRole = {sNodeName = "goMainRole", sComponentName = "Transform"},
  rtmp_os = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  goMask = {sNodeName = "imgMask", sComponentName = "GameObject"},
  btnThinkingGoOn = {
    sNodeName = "btnThinkingGoOn",
    sComponentName = "NaviButton",
    callback = "OnBtnClick_ThinkingGoOn"
  },
  imgContactHead = {
    sNodeName = "imgHeadIcon",
    sComponentName = "Image"
  },
  txtCharName = {sComponentName = "TMP_Text"},
  txtSignature = {sComponentName = "TMP_Text"},
  goTitle = {},
  goBgRoot = {},
  GoChatList = {},
  PhoneRoot = {sComponentName = "Animator"},
  sv = {
    sComponentName = "GamepadScroll"
  },
  goTempLeftHead = {},
  goTempRightHead = {},
  goFixedHead = {sComponentName = "Transform"}
}
Avg_5_PhoneCtrl._mapEventConfig = {
  [EventId.AvgSetAutoPlay] = "OnEvent_AvgSetAutoPlay",
  [EventId.AvgShowHideTalkUI] = "OnEvent_AvgShowHideTalkUI",
  [EventId.AvgChoiceToReplyPhoneMessage] = "OnEvent_Reply",
  [EventId.AvgClearStage] = "OnEvent_ClearStage",
  [EventId.AvgVoiceDuration] = "OnEvent_AvgVoiceDuration",
  [EventId.AvgSpeedUp] = "OnEvent_AvgSpeedUp",
  GamepadUIChange = "OnEvent_GamepadUIChange",
  GamepadUIReopen = "OnEvent_Reopen"
}

function Avg_5_PhoneCtrl:Awake()
  self.tbGridData = {}
  local tweener = NovaAPI.ImageDoFade(self._mapNode.imgCursor, 0, 0.5, true)
  tweener:SetLoops(-1)
  self.tbMsgData = {}
  self.tbGridHeight = {}
  self.tbChoiceDecision = {}
  self.nPhoneOutPosY = -(1200 + Settings.CURRENT_CANVAS_FULL_RECT_HEIGHT) / 2
  self._mapNode.rtRoot.anchoredPosition = Vector2(0, self.nPhoneOutPosY)
  self._mapNode.rtInputRoot.anchoredPosition = Vector2(0, -108)
  self._mapNode.goTitle:SetActive(false)
  self.bIsAutoPlaying = false
  self.nAutoPlayWaiting = 3
  self.timerAutoPlayWaiting = nil
  self.colorHideReplyText = Color(0.1490196, 0.2588235, 0.4705882, 0)
  self.bPhoneThinking = false
  self.nAutoSelectionPlayWaiting = 0.5
  self:_SetBtnEnable(false)
  self.tbLogData = {}
  self._mapNode.goTempLeftHead.gameObject:SetActive(false)
  self._mapNode.goTempRightHead.gameObject:SetActive(false)
  self._mapNode.goFixedHead.gameObject:SetActive(false)
  self.sTxtLan = self._panel.sTxtLan or Settings.sCurrentTxtLanguage
end

function Avg_5_PhoneCtrl:OnEnable()
  self:AddGamepadUINode()
end

function Avg_5_PhoneCtrl:OnDisable()
  WwiseAudioMgr:WwiseVoice_StopInAVG()
  self.bNeedWaitVoiceFinish = false
end

function Avg_5_PhoneCtrl:_SetBtnEnable(bEnable)
  NovaAPI.SetImageRaycastTarget(self._mapNode.imgBtnGoOn, bEnable)
  self._mapNode.Viewport_SV.interactable = bEnable
  self._mapNode.btnGoOn.interactable = bEnable
  self._mapNode.btnGoOn.gameObject:SetActive(bEnable)
  EventManager.Hit(EventId.AvgLogBtnEnable, bEnable)
end

function Avg_5_PhoneCtrl:OnBtnClick_GoOn(btn)
  if self.bPlayingVoice then
    if self.bNeedWaitVoiceFinish then
      return
    end
    WwiseAudioMgr:WwiseVoice_StopInAVG()
    self.bPlayingVoice = false
    if self.voicePlayWaiting ~= nil then
      self.voicePlayWaiting:Cancel()
      self.voicePlayWaiting = nil
    end
  end
  self:_SetBtnEnable(false)
  self:ClearAllInputingMsg()
  if self.bIsAutoPlaying == true then
    self:_PauseTimerAutoPlayWaiting()
  end
  if self.bStartChoice == true then
    return
  end
  if self:GetPanelId() == PanelId.AvgST then
    self._panel:RUN()
  end
  EventManager.Hit(EventId.AvgShowNextPhoneMessage)
end

function Avg_5_PhoneCtrl:OnBtnClick_ThinkingGoOn(btn)
  self.bPhoneThinking = false
  self._mapNode.animMainRole:SetTrigger("tOut")
  self._mapNode.goMask:SetActive(false)
  self._mapNode.btnThinkingGoOn.gameObject:SetActive(false)
  self:_PlayPhoneHorizontalMove(false)
  self:_PlayPhoneScaleMove(false)
  self:OnBtnClick_GoOn()
end

function Avg_5_PhoneCtrl:OnBtnClick_ShowImgMsg(iconPath)
  self:SetPngSprite(self._mapNode.imgMsgDetail, iconPath)
  NovaAPI.SetImageNativeSize(self._mapNode.imgMsgDetail)
  self._mapNode.aniMsgDetail:Play("showMsg")
end

function Avg_5_PhoneCtrl:OnBtnClick_HideImgMsg()
  self._mapNode.aniMsgDetail:Play("hideMsg")
end

function Avg_5_PhoneCtrl:OnBtnClick_ChoiceMsg(index, choiceData)
  self:ClearSelect()
  self.bStartChoice = false
  for k, v in ipairs(self.tbMsgData[self.curContactsId]) do
    if v.type == 2 and v.msgData.groupID == choiceData.groupID then
      table.remove(self.tbMsgData[self.curContactsId], k)
      table.remove(self.tbGridHeight[self.curContactsId], k)
      break
    end
  end
  if self.tbChoiceDecision[self.curContactsId] == nil then
    self.tbChoiceDecision[self.curContactsId] = {}
  end
  for k, v in pairs(self.tbChoiceDecision[self.curContactsId]) do
    if v.groupID == choiceData.groupID then
      return
    end
  end
  local decisionData = {
    groupID = choiceData.groupID,
    choiceIndex = tostring(index)
  }
  table.insert(self.tbChoiceDecision[self.curContactsId], decisionData)
  if self:GetPanelId() == PanelId.AvgST then
    if choiceData.msgType == AllEnum.PhoneMsgType.ReplyMsg then
      self.tbLogData.nType = AllEnum.AvgLogType.PhoneMsgChoice
      self.tbLogData.sAvgId = nil
      self.tbLogData.sContent = ProcAvgTextContent(choiceData.choices[index], self._panel.nCurLanguageIdx)
      self.tbLogData.sVoice = nil
      EventManager.Hit(EventId.AvgMarkLog, self.tbLogData)
    end
    self._panel:SetPhoneMsgChoiceJumpTo(choiceData.groupID, index)
  end
  WwiseAudioMgr:PlaySound("ui_choice_click")
  EventManager.Hit(EventId.AvgSelectPhoneMsgChoice, choiceData.groupID, index)
end

function Avg_5_PhoneCtrl:_StartTimerAutoPlayWaiting()
  if self.bPlayingVoice or self.bStartChoice then
    return
  end
  if self.timerAutoPlayWaiting == nil then
    self.timerAutoPlayWaiting = self:AddTimer(1, self.nAutoPlayWaiting, "_AutoPlayTimerCallback", true, false, true)
  elseif self.nAutoPlayWaiting == self.nLastWaitingTime then
    self.timerAutoPlayWaiting:Reset()
  else
    self.timerAutoPlayWaiting:Cancel(false)
    self.timerAutoPlayWaiting = self:AddTimer(1, self.nAutoPlayWaiting, "_AutoPlayTimerCallback", true, false, true)
  end
  self.nLastWaitingTime = self.nAutoPlayWaiting
end

function Avg_5_PhoneCtrl:_PauseTimerAutoPlayWaiting()
  if self.timerAutoPlayWaiting ~= nil then
    self.timerAutoPlayWaiting:Pause()
  end
end

function Avg_5_PhoneCtrl:_AutoPlayTimerCallback(timer)
  if not self.bPhoneThinking then
    self:OnBtnClick_GoOn(self._mapNode.btnGoOn)
  else
    self:OnBtnClick_ThinkingGoOn()
  end
end

function Avg_5_PhoneCtrl:_SetAutoPlayState(bAuto)
  self.bIsAutoPlaying = bAuto
end

function Avg_5_PhoneCtrl:_SetNextTipActive(bActive)
  local trContent = self._mapNode.trContent
  local lastGrid
  for i = 1, trContent.childCount do
    local tr = trContent:GetChild(i - 1)
    if tr.gameObject.activeSelf == true then
      lastGrid = tr
    else
      break
    end
  end
  if lastGrid ~= nil then
    local goLeft = lastGrid:Find("goChatItem/goLeft/rtMsg/imgBg/imgNextTip").gameObject
    local goRight = lastGrid:Find("goChatItem/goRight/rtMsg/imgBg/imgNextTip").gameObject
    goLeft:SetActive(bActive)
    goRight:SetActive(bActive)
  end
end

function Avg_5_PhoneCtrl:OnEvent_AvgSetAutoPlay(bAuto, bByInit)
  self.bIsAutoPlaying = bAuto
  local sTrigger = "tManual"
  if self.bIsAutoPlaying == true then
    sTrigger = "tAuto"
  end
  if bByInit == true then
    return
  end
  if self.bIsActive ~= true then
    return
  end
  if self.bIsAutoPlaying == true then
    self:_StartTimerAutoPlayWaiting()
  else
    self:_PauseTimerAutoPlayWaiting()
  end
end

function Avg_5_PhoneCtrl:OnEvent_AvgShowHideTalkUI(bVisible)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroupRoot, bVisible == true and 1 or 0)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.canvasGroupRoot, bVisible)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.canvasGroupRoot, bVisible)
  self._mapNode.btnGoOn.transform.localScale = bVisible == true and Vector3.one or Vector3.zero
  NovaAPI.SetButtonInteractable(self._mapNode.btnGoOn, bVisible)
end

function Avg_5_PhoneCtrl:OnEvent_Reply(sReplyMsg)
  NovaAPI.SetTMPText(self._mapNode.txtReply, sReplyMsg)
  NovaAPI.SetTMPText(self._mapNode.txtReply_shadow, sReplyMsg)
  self._mapNode.txtReply:DOFade(1, 0.2):SetUpdate(true)
end

function Avg_5_PhoneCtrl:OnEvent_AvgVoiceDuration(time)
  if self:GetPanelId() == PanelId.AvgEditor then
    return
  end
  if self.bProcVoiceCallbackEvent ~= true then
    return
  end
  self.bProcVoiceCallbackEvent = false
  self.bPlayingVoice = true
  if self.voicePlayWaiting == nil then
    self.voicePlayWaiting = self:AddTimer(1, time, "_EndPlayTalkVoice", true, true, true)
  end
end

function Avg_5_PhoneCtrl:OnEvent_ClearStage()
  if self:GetPanelId() == PanelId.AvgEditor then
    return
  end
  self:_DelayHidePhone()
  self:SetPhone({1, 1})
end

function Avg_5_PhoneCtrl:OnEvent_AvgSpeedUp(nRate)
  if self:GetPanelId() ~= PanelId.AvgST then
    return
  end
  self:OnEvent_AvgSpeedUp_Timer(nRate)
  NovaAPI.SetAnimatorSpeed(self._mapNode.aniMsgDetail, nRate)
  NovaAPI.SetAnimatorSpeed(self._mapNode.animMainRole, nRate)
  NovaAPI.SetAnimatorSpeed(self._mapNode.PhoneRoot, nRate)
end

function Avg_5_PhoneCtrl:_CalcGridHeight(sContent)
  self._mapNode.layoutCalcHeight.enabled = false
  NovaAPI.SetTMPText(self._mapNode.txtCalcHeight, sContent)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtCalcHeight)
  if self._mapNode.rtCalcHeight.rect.width > max_chat_width then
    self._mapNode.layoutCalcHeight.enabled = true
    self._mapNode.layoutCalcHeight.preferredWidth = max_chat_width
  end
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtCalcHeight)
  local nH = self._mapNode.rtCalcHeight.rect.height + 56
  if nH < 104 then
    nH = 104
  end
  return nH
end

function Avg_5_PhoneCtrl:_CalcMsgGridHeight(sContent)
  self._mapNode.layoutCalcHeight.enabled = false
  NovaAPI.SetTMPText(self._mapNode.txtMsgCalcHeight, sContent)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtMsgCalcHeight)
  if self._mapNode.rtMsgCalcHeight.rect.width > max_chat_width then
    self._mapNode.layoutCalcHeight.enabled = true
    self._mapNode.layoutCalcHeight.preferredWidth = max_chat_width
  end
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtMsgCalcHeight)
  local nH = self._mapNode.rtMsgCalcHeight.rect.height + 40
  return nH
end

function Avg_5_PhoneCtrl:_CalcChoiceHeight(sContent)
  self._mapNode.layoutCalcHeight.enabled = false
  NovaAPI.SetTMPText(self._mapNode.txtCalcHeight, sContent)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtCalcHeight)
  if self._mapNode.rtCalcHeight.rect.width > max_choice_width then
    self._mapNode.layoutCalcHeight.enabled = true
    self._mapNode.layoutCalcHeight.preferredWidth = max_choice_width
  end
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtCalcHeight)
  local nH = self._mapNode.rtCalcHeight.rect.height + choice_txt_diff
  if nH < 67.15 then
    nH = 67.15
  end
  return nH
end

function Avg_5_PhoneCtrl:_CalcGridWidth(sContent)
  self._mapNode.layoutCalcHeight.enabled = false
  NovaAPI.SetTMPText(self._mapNode.txtCalcHeight, sContent)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtCalcHeight)
  local width = self._mapNode.rtCalcHeight.rect.width
  if width > max_chat_width then
    width = max_chat_width
  end
  return width
end

function Avg_5_PhoneCtrl:_CalcTextAnimDuration(sContent)
  local nCurLanguageIdx = self._panel.nCurLanguageIdx
  if nCurLanguageIdx == nil then
    nCurLanguageIdx = GetLanguageIndex(Settings.sCurrentTxtLanguage)
  end
  local nDuration = CalcTextAnimDuration(sContent, nCurLanguageIdx)
  nDuration = math.min(DEFAULT_AUTOPLAY_MAX_TIME, nDuration)
  nDuration = math.max(DEFAULT_AUTOPLAY_MIN_TIME, nDuration)
  return nDuration
end

function Avg_5_PhoneCtrl:_PlayPhoneInOutAnim(bIn)
  if bIn == true then
    self._mapNode.rtRoot.localScale = Vector3.one
    self._mapNode.rtMainRole.localScale = Vector3.one
    self._mapNode.rtRoot.anchoredPosition = Vector2(0, 0)
    self._mapNode.rtInputRoot.anchoredPosition = Vector2(0, -108)
    self._mapNode.PhoneRoot:Play("avg_5_phone_title_in")
    self._mapNode.goBgRoot:SetActive(true)
    self._mapNode.GoChatList:SetActive(true)
  else
    self._mapNode.PhoneRoot:Play("avg_5_phone_title_out")
    self:AddTimer(1, 0.6, "_DelayHidePhone", true, true, true)
    self._mapNode.goBgRoot:SetActive(false)
  end
end

function Avg_5_PhoneCtrl:_PlayPhoneHorizontalMove(bLeft)
  local nTargetPosX = 0
  if bLeft == true then
    nTargetPosX = -490
  end
  self._mapNode.rtRoot:DOAnchorPosX(nTargetPosX, 0.4):SetUpdate(true):SetEase(Ease.InOutQuad)
end

function Avg_5_PhoneCtrl:_PlayPhoneScaleMove(bSmall)
  local nTargetScale = 1
  if bSmall == true then
    nTargetScale = 0.8
  end
  self._mapNode.rtRoot:DOScale(nTargetScale, 0.4):SetUpdate(true):SetEase(Ease.InOutQuad)
end

function Avg_5_PhoneCtrl:_SetReplyInputField(bIn, nDelay)
  local nTargetPosY = -108
  if bIn == true then
    nTargetPosY = 0
    self._mapNode.rtSvReply.anchoredPosition = Vector2(0, 0)
    NovaAPI.SetTMPColor(self._mapNode.txtReply, self.colorHideReplyText)
    NovaAPI.SetTMPText(self._mapNode.txtReply, " ")
    NovaAPI.SetTMPText(self._mapNode.txtReply_shadow, " ")
  end
  if math.abs(self._mapNode.rtInputRoot.anchoredPosition.y - nTargetPosY) > 0.1 then
    local tw = self._mapNode.rtInputRoot:DOAnchorPosY(nTargetPosY, 0.3):SetUpdate(true):SetEase(Ease.OutQuad)
    if nDelay ~= nil and 0 < nDelay then
      tw:SetDelay(nDelay)
    end
    return 0.3
  else
    return 0
  end
end

function Avg_5_PhoneCtrl:_PlayReplyTextAnim(sContent)
  self._mapNode.rtSvReply.anchoredPosition = Vector2(0, 0)
  NovaAPI.SetTMPColor(self._mapNode.txtReply, self.colorHideReplyText)
  sContent = string.gsub(sContent, "\n", "")
  NovaAPI.SetTMPText(self._mapNode.txtReply, sContent)
  NovaAPI.SetTMPText(self._mapNode.txtReply_shadow, sContent)
  self._mapNode.txtReply:DOFade(1, 0.2):SetUpdate(true)
  self._mapNode.rtSvReply:DOAnchorPosY(50, 0.2):SetUpdate(true):SetEase(Ease.InQuad):SetDelay(0.7)
  return 1
end

function Avg_5_PhoneCtrl:_DelayHidePhone()
  self._mapNode.rtRoot.localScale = Vector3.zero
  self._mapNode.rtMainRole.localScale = Vector3.zero
end

function Avg_5_PhoneCtrl:_DelayShowThinkingBtn()
  self._mapNode.btnThinkingGoOn.gameObject:SetActive(true)
end

function Avg_5_PhoneCtrl:_EndPlayTalkVoice()
  if self.bPlayingVoice then
    self.bPlayingVoice = false
  end
  if self.bNeedWaitVoiceFinish then
    self.bNeedWaitVoiceFinish = false
  end
  if self.voicePlayWaiting ~= nil then
    self.voicePlayWaiting = nil
  end
  if self.bIsAutoPlaying then
    self:_StartTimerAutoPlayWaiting()
  end
end

local nTimes = 1

function Avg_5_PhoneCtrl:_RefreshLoopSV(timer)
  self.bIsFullPage = self:IsFullPage()
  self.bOnInitEx = true
  self._mapNode.loopSV:InitEx(self.tbGridHeight[self.curContactsId], self, self.OnRefreshGrid, nil, true)
  self.bOnInitEx = false
  self._mapNode.loopSV:SetScrollPos(0, 0.2 * nTimes)
  if not self.bShowInputingWaiting and not self.RecordMsg then
    self.timerDelayEnableBtn = self:AddTimer(1, 0.4 * nTimes, "_DelayEnableBtn", true, true, true)
    self:CheckNextMessage(1)
  end
end

function Avg_5_PhoneCtrl:_DelayEnableBtn(timer)
  self:_SetBtnEnable(true)
  if self.bIsAutoPlaying == true then
    self:_StartTimerAutoPlayWaiting()
  end
  if self.trTempHeadImg ~= nil and self.trTempHeadImgRoot ~= nil then
    self.trTempHeadImg:SetParent(self.trTempHeadImgRoot)
    self.trTempHeadImg = nil
    self.trTempHeadImgRoot = nil
  end
end

function Avg_5_PhoneCtrl:OnRefreshGrid(goGrid, gridIndex)
  local nDataIndex = gridIndex + 1
  local data = self.tbMsgData[self.curContactsId][nDataIndex]
  if data == nil then
    return
  end
  local goChat = goGrid.transform:Find("goChatItem")
  local goMiddle = goGrid.transform:Find("goMiddle")
  local goSelection = goGrid.transform:Find("goSelection")
  local goNextItemLeft = goGrid.transform:Find("goNextItemLeft")
  local goNextItemRight = goGrid.transform:Find("goNextItemRight")
  goChat.gameObject:SetActive(data.type == 1 and data.msgData[1] ~= AllEnum.PhoneMsgType.SystemMsg and data.msgData[1] ~= AllEnum.PhoneMsgType.InputingMsgLeft and data.msgData[1] ~= AllEnum.PhoneMsgType.InputingMsgRight)
  goMiddle.gameObject:SetActive(data.type == 1 and data.msgData[1] == AllEnum.PhoneMsgType.SystemMsg)
  goNextItemLeft.gameObject:SetActive(data.type == 1 and data.msgData[1] == AllEnum.PhoneMsgType.InputingMsgLeft)
  goNextItemRight.gameObject:SetActive(data.type == 1 and data.msgData[1] == AllEnum.PhoneMsgType.InputingMsgRight)
  goSelection.gameObject:SetActive(data.type == 2)
  if data.type == 1 then
    if data.msgData[1] == AllEnum.PhoneMsgType.SystemMsg then
      local txtMiddle = goMiddle:Find("txtMiddle"):GetComponent("TMP_Text")
      NovaAPI.SetTMPText(txtMiddle, data.msgData[3])
      local rtGrid = goGrid:GetComponent("RectTransform")
      local sizeDelta = rtGrid.sizeDelta
      sizeDelta.y = self.tbGridHeight[self.curContactsId][nDataIndex]
      rtGrid.sizeDelta = sizeDelta
    elseif data.msgData[1] == AllEnum.PhoneMsgType.InputingMsgLeft or data.msgData[1] == AllEnum.PhoneMsgType.InputingMsgRight then
      self:OnRefreshInputingGrid(goGrid, gridIndex)
    else
      self:OnRefreshCommonGrid(goGrid, nDataIndex)
    end
  else
    self:OnRefreshChoiceGrid(goGrid, nDataIndex)
  end
end

function Avg_5_PhoneCtrl:OnRefreshCommonGrid(goGrid, nDataIndex)
  local data = self:GetMsgDataByDataIndex(nDataIndex)
  local bReply = data[1] ~= AllEnum.PhoneMsgType.ReceiveMsg and data[1] ~= AllEnum.PhoneMsgType.ReceiveImgMsg
  local bImgMsg = data[1] == AllEnum.PhoneMsgType.ReceiveImgMsg or data[1] == AllEnum.PhoneMsgType.ReplyImgMsg
  local sAvgCharId = data[2]
  local sMsgContent = data[3]
  local bPlayed = data[4]
  local nH = self.tbGridHeight[self.curContactsId][nDataIndex]
  local imgType = data[5]
  local imgSize = data[6]
  local sVoiceName = data[7]
  self.bNeedWaitVoiceFinish = data[8]
  local rtGrid = goGrid:GetComponent("RectTransform")
  
  local function func_SetGrid(sPart, bActive)
    local go = rtGrid:Find(sPart).gameObject
    local goHead = rtGrid:Find(sPart .. "Head").gameObject
    if rtGrid:Find(sPart .. "Head/imgHeadBg/imgHead") == nil then
      return nil
    end
    local rtImgHeadBg = rtGrid:Find(sPart .. "Head/imgHeadBg"):GetComponent("RectTransform")
    local imgHead = rtGrid:Find(sPart .. "Head/imgHeadBg/imgHead"):GetComponent("Image")
    local rtImgHead = imgHead:GetComponent("RectTransform")
    local rtMsg = rtGrid:Find(sPart .. "/rtMsg"):GetComponent("RectTransform")
    local btnImg = rtGrid:Find(sPart .. "/rtMsg/imgBg"):GetComponent("Button")
    local txtMsg = rtGrid:Find(sPart .. "/rtMsg/txtContent"):GetComponent("TMP_Text")
    local rtTxtMsg = txtMsg:GetComponent("RectTransform")
    local rtImgMsg = rtGrid:Find(sPart .. "/rtMsg/imgMsg"):GetComponent("RectTransform")
    local btnImgMsg = rtImgMsg:GetComponent("Button")
    local imgImgMsg = rtImgMsg:GetComponent("Image")
    btnImg.gameObject:SetActive(not bImgMsg)
    txtMsg.gameObject:SetActive(not bImgMsg)
    imgImgMsg.gameObject:SetActive(bImgMsg)
    rtImgHeadBg.anchoredPosition = Vector2.zero
    local imgTempHead = self.trTempHeadImg.transform:Find("imgHeadBg/imgHead"):GetComponent("Image")
    self.nHeadAnimEndPosY = 0
    if bActive == true then
      local bHeadImgVisible = false
      local bHeadImgAnim = false
      if nDataIndex == #self.tbMsgData[self.curContactsId] and not self.RecordMsg then
        bHeadImgVisible = true
        if self.bOnInitEx == true and 1 < nDataIndex and self:IsSameMsgSender(nDataIndex) and self.bRevertHistoryMsg ~= true then
          bHeadImgVisible = false
          bHeadImgAnim = true
        end
      elseif not self:IsSameMsgSender(nDataIndex + 1) or self:GetMsgDataByDataIndex(nDataIndex + 1)[1] == AllEnum.PhoneMsgType.SystemMsg then
        bHeadImgVisible = true
      end
      go:SetActive(true)
      goHead:SetActive(true)
      self:SetAvgCharHeadIcon(imgHead, sAvgCharId, "002")
      rtImgHeadBg.gameObject:SetActive(bHeadImgVisible == true)
      if self.trTempHeadImg then
        self:SetAvgCharHeadIcon(imgTempHead, sAvgCharId, "002")
      end
      if bImgMsg then
        rtMsg.sizeDelta = Vector2(imgSize[1], imgSize[2])
        NovaAPI.SetImageRaycastTarget(imgImgMsg, imgType == 1)
        btnImgMsg.onClick:RemoveAllListeners()
        if imgType == 1 then
          sMsgContent = "Icon/AvgPhoneImageMsg/" .. sMsgContent
          btnImgMsg.onClick:AddListener(function()
            self:OnBtnClick_ShowImgMsg(sMsgContent)
          end)
        else
          sMsgContent = "Icon/AvgPhoneEmojiMsg/" .. sMsgContent
        end
        self:SetPngSprite(imgImgMsg, sMsgContent)
        rtImgMsg.localScale = Vector3(1, 1, 1)
      else
        btnImg.interactable = bHeadImgVisible == true
        local width = self:_CalcGridWidth(sMsgContent)
        rtTxtMsg.sizeDelta = Vector2(width, rtTxtMsg.sizeDelta.y)
        NovaAPI.SetTMPText(txtMsg, sMsgContent)
        rtMsg.sizeDelta = Vector2(width + 92, nH)
      end
      rtGrid.sizeDelta = Vector2(CONST_GRID_WIDTH, nH)
      local rtGo = go:GetComponent("RectTransform")
      rtGo.sizeDelta = Vector2(CONST_GRID_WIDTH, nH)
      if bHeadImgAnim then
        local trPreHead = self._mapNode.trContent:Find(tostring(nDataIndex - 1 - 1) .. "/" .. sPart .. "Head")
        if self.trTempHeadImg and trPreHead then
          local imgTempHeadBg = self.trTempHeadImg.transform:Find("imgHeadBg")
          imgTempHeadBg.transform.position = trPreHead.position
        end
        if self.bIsFullPage == true then
          self.nHeadAnimEndPosY = self._mapNode.goFixedHead.position.y
        else
          self.nHeadAnimEndPosY = rtImgHeadBg.transform.position.y
        end
      end
      return rtGo, rtMsg.transform, go:GetComponent("CanvasGroup"), rtImgHeadBg, bHeadImgAnim
    else
      go:SetActive(false)
      goHead:SetActive(false)
      NovaAPI.SetImageSpriteAsset(imgHead, nil)
      NovaAPI.SetTMPText(txtMsg, " ")
      rtMsg.sizeDelta = Vector2(344, 104)
      rtGrid.sizeDelta = Vector2(CONST_GRID_WIDTH, 104)
      return nil
    end
  end
  
  local sRootNodeName_On, sRootNodeName_Off
  self.trTempHeadImg = nil
  self._mapNode.goTempRightHead.gameObject:SetActive(false)
  self._mapNode.goTempLeftHead.gameObject:SetActive(false)
  if bReply == true then
    sRootNodeName_On = "goChatItem/goRight"
    sRootNodeName_Off = "goChatItem/goLeft"
    self.trTempHeadImg = self._mapNode.goTempRightHead
  else
    sRootNodeName_On = "goChatItem/goLeft"
    sRootNodeName_Off = "goChatItem/goRight"
    self.trTempHeadImg = self._mapNode.goTempLeftHead
  end
  func_SetGrid(sRootNodeName_Off, false)
  local rtAnimPos, trAnimScale, canvasGroup, rtImgHeadBg, bHeadImgAnim = func_SetGrid(sRootNodeName_On, true)
  if bPlayed ~= true and rtAnimPos ~= nil and trAnimScale ~= nil and canvasGroup ~= nil then
    self:GetMsgDataByDataIndex(nDataIndex)[4] = true
    local animTime = self.RecordMsg == true and 0 or nTimes
    rtAnimPos.anchoredPosition = Vector2(0, -50)
    rtAnimPos:DOAnchorPosY(0, 0.35 * animTime):SetUpdate(true):SetEase(Ease.OutCirc)
    NovaAPI.SetCanvasGroupAlpha(canvasGroup, 0)
    canvasGroup:DOFade(1, 0.3 * animTime):SetUpdate(true):SetEase(Ease.OutSine)
    if rtImgHeadBg ~= nil and self.trTempHeadImg ~= nil then
      if bHeadImgAnim then
        self.trTempHeadImg.gameObject:SetActive(true)
        local rtTempImgHeadBg = self.trTempHeadImg.transform:Find("imgHeadBg")
        local headTweener = rtTempImgHeadBg:DOMoveY(self.nHeadAnimEndPosY, 0.35 * animTime):SetUpdate(true):SetEase(Ease.OutQuad)
        
        local function _cb()
          if self.trTempHeadImg ~= nil then
            self.trTempHeadImg.gameObject:SetActive(false)
          end
          self.trTempHeadImg = nil
          if rtImgHeadBg ~= nil then
            rtImgHeadBg.gameObject:SetActive(true)
          end
        end
        
        headTweener.onComplete = dotween_callback_handler(self, _cb)
      elseif not self.bIsFullPage then
        local y = rtImgHeadBg.anchoredPosition.y
        rtImgHeadBg.anchoredPosition = Vector2(rtImgHeadBg.anchoredPosition.x, y - 50)
        rtImgHeadBg:DOAnchorPosY(y, 0.35 * animTime):SetUpdate(true):SetEase(Ease.OutCirc)
      end
    end
  end
  if nDataIndex == #self.tbGridHeight[self.curContactsId] then
    if sVoiceName ~= nil and sVoiceName ~= "" then
      self.bProcVoiceCallbackEvent = true
      WwiseAudioMgr:WwiseVoice_PlayInAVG(sVoiceName)
      self.nAutoPlayWaiting = AUTO_PLAY_WAITING_VOIVE
    else
      self.nAutoPlayWaiting = self:_CalcTextAnimDuration(sMsgContent)
    end
  end
end

function Avg_5_PhoneCtrl:OnRefreshChoiceGrid(goGrid, nDataIndex)
  local data = self:GetMsgDataByDataIndex(nDataIndex)
  local rootRect = goGrid.transform:Find("goSelection")
  local rtRootRect = rootRect:GetComponent("RectTransform")
  local imgHead = rootRect:Find("imgRightBg/imgRightHeadIcon"):GetComponent("Image")
  local sAvgCharId = data.sAvgCharId
  self:SetAvgCharHeadIcon(imgHead, AdjustMainRoleAvgCharId(sAvgCharId), "002")
  local goTxtSelection = rootRect:Find("goSelectionList/goTxtSelection")
  local goImgSelection = rootRect:Find("goSelectionList/goImgSelection")
  goTxtSelection.gameObject:SetActive(data.msgType == AllEnum.PhoneMsgType.ReplyMsg)
  goImgSelection.gameObject:SetActive(data.msgType ~= AllEnum.PhoneMsgType.ReplyMsg)
  local goRoot = data.msgType == AllEnum.PhoneMsgType.ReplyMsg and goTxtSelection or goImgSelection
  local nChoiceH = 0
  self:ClearSelect()
  for i = 1, 3 do
    local goSelection = goRoot:Find("goSelection" .. i)
    if i > #data.choices then
      goSelection.gameObject:SetActive(false)
    else
      goSelection.gameObject:SetActive(true)
      local btnSelection = goSelection:Find("btnSelection"):GetComponent("NaviButton")
      btnSelection.onClick:RemoveAllListeners()
      btnSelection.onClick:AddListener(function()
        self:OnBtnClick_ChoiceMsg(i, data)
      end)
      btnSelection.onSelect:RemoveAllListeners()
      btnSelection.onSelect:AddListener(function()
        self:OnBtnSelect_ChoiceMsg(btnSelection, i)
      end)
      self:SetSelectBtnObj(i, btnSelection)
      if data.msgType == AllEnum.PhoneMsgType.ReplyMsg then
        local txtSelection = btnSelection.transform:Find("AnimRoot/txtSelection"):GetComponent("TMP_Text")
        local rtTxtSelection = btnSelection.transform:Find("AnimRoot/txtSelection"):GetComponent("RectTransform")
        local rtImgBg = btnSelection.transform:Find("AnimRoot/imgBg"):GetComponent("RectTransform")
        local rtSelection = goSelection:GetComponent("RectTransform")
        local sContent = ProcAvgTextContent(data.choices[i], self._panel.nCurLanguageIdx)
        NovaAPI.SetTMPText(txtSelection, sContent)
        local nHeight = self:_CalcChoiceHeight(sContent)
        rtTxtSelection.sizeDelta = Vector2(rtTxtSelection.sizeDelta.x, nHeight)
        rtImgBg.sizeDelta = Vector2(rtImgBg.sizeDelta.x, nHeight + choice_img_diff)
        rtSelection.sizeDelta = Vector2(rtSelection.sizeDelta.x, nHeight + choice_img_diff)
        nChoiceH = nChoiceH + nHeight + choice_img_diff
      else
        do
          local imgSelection = btnSelection.transform:Find("AnimRoot/imgSelection"):GetComponent("Image")
          local rtImg = imgSelection:GetComponent("RectTransform")
          local path = data.msgType == AllEnum.PhoneMsgType.ReplyImgMsg and "Icon/AvgPhoneImageMsg/" .. data.choices[i] or "Icon/AvgPhoneEmojiMsg/" .. data.choices[i]
          self:SetPngSprite(imgSelection, path)
          if data.msgType == AllEnum.PhoneMsgType.ReplyImgMsg then
            local rectWidth = NovaAPI.GetImageSpriteWidth(imgSelection)
            local rectHeight = NovaAPI.GetImageSpriteHeight(imgSelection)
            local ratio = rectWidth / rectHeight
            if rectWidth > rectHeight then
              rtImg.sizeDelta = Vector2(200, 200 / ratio)
            else
              local ratio = rectHeight / rectWidth
              rtImg.sizeDelta = Vector2(200 * ratio, 200)
            end
          else
            rtImg.sizeDelta = Vector2(200, 200)
          end
        end
      end
    end
  end
  if self:GetPanelId() == PanelId.AvgST then
    if data.msgType == AllEnum.PhoneMsgType.ReplyMsg and next(self.tbSelectBtnObj) then
      GamepadUIManager.SetNavigation(self.tbSelectBtnObj, false)
    elseif (data.msgType == AllEnum.PhoneMsgType.ReplyImgMsg or data.msgType == AllEnum.PhoneMsgType.ReplyEmoji) and next(self.tbSelectBtnObj) then
      GamepadUIManager.SetNavigation(self.tbSelectBtnObj, true)
    end
  end
  self:SelectUI()
  local goHead = rootRect:Find("imgRightBg"):GetComponent("RectTransform")
  local headPos = goHead.anchoredPosition
  if data.msgType == AllEnum.PhoneMsgType.ReplyMsg then
    nChoiceH = nChoiceH + choice_selection_space * (#data.choices - 1) + choice_selection_top + choice_selection_bottom + choice_selection_input + choice_head_offset
    rtRootRect.sizeDelta = Vector2(rtRootRect.sizeDelta.x, nChoiceH)
    headPos.y = 0
  else
    headPos.y = -choice_head_offset
  end
  goHead.anchoredPosition = headPos
  self.bStartChoice = true
end

function Avg_5_PhoneCtrl:OnRefreshInputingGrid(goGrid, gridIndex)
  local rtGrid = goGrid:GetComponent("RectTransform")
  rtGrid.sizeDelta = Vector2(rtGrid.sizeDelta.x, 104)
  self.bShowInputingWaiting = true
end

function Avg_5_PhoneCtrl:IsFullPage()
  local height = 0
  for i = 1, #self.tbGridHeight[self.curContactsId] - 1 do
    height = height + self.tbGridHeight[self.curContactsId][i]
  end
  height = height + self._mapNode.layoutContent_SV.padding.top
  height = height + self._mapNode.layoutContent_SV.padding.bottom
  height = height + self._mapNode.layoutContent_SV.spacing.y * (#self.tbGridHeight[self.curContactsId] - 2)
  return height >= self._mapNode.rtViewPort_SV.rect.height
end

function Avg_5_PhoneCtrl:IsSameMsgSender(nDataIndex)
  local tbCurData = self:GetMsgDataByDataIndex(nDataIndex)
  local tbLastData = self:GetMsgDataByDataIndex(nDataIndex - 1)
  if tbCurData ~= nil and tbLastData ~= nil and tbCurData[2] == tbLastData[2] then
    local bReply = tbCurData[1] ~= AllEnum.PhoneMsgType.ReceiveMsg and tbCurData[1] ~= AllEnum.PhoneMsgType.ReceiveImgMsg
    local bLastReply = tbLastData[1] ~= AllEnum.PhoneMsgType.ReceiveMsg and tbLastData[1] ~= AllEnum.PhoneMsgType.ReceiveImgMsg
    if bReply ~= bLastReply then
      return false
    end
    return true
  else
    return false
  end
end

function Avg_5_PhoneCtrl:GetMsgDataByDataIndex(nDataIndex)
  local data = self.tbMsgData[self.curContactsId]
  if data[nDataIndex] ~= nil then
    return data[nDataIndex].msgData
  end
end

function Avg_5_PhoneCtrl:ResetPhoneMsgData()
  self:ClearAllInputingMsg()
  if self.timerAutoPlayWaiting ~= nil then
    self.timerAutoPlayWaiting:Cancel()
    self.timerAutoPlayWaiting = nil
  end
  if self.tbMsgData[self.curContactsId] ~= nil then
    self.tbMsgData[self.curContactsId] = {}
  end
  if self.tbGridHeight[self.curContactsId] ~= nil then
    self.tbGridHeight[self.curContactsId] = {}
  end
  if self.tbChoiceDecision[self.curContactsId] ~= nil then
    self.tbChoiceDecision[self.curContactsId] = {}
  end
  self.bStartChoice = false
  self.bPlayingVoice = false
  self._mapNode.goTempLeftHead.gameObject:SetActive(false)
  self._mapNode.goTempRightHead.gameObject:SetActive(false)
  self:_SetBtnEnable(false)
  if self.timerDelayEnableBtn ~= nil then
    self.timerDelayEnableBtn:Cancel(false)
    self.timerDelayEnableBtn = nil
  end
  if self.timerSetMsg ~= nil then
    self.timerSetMsg:Cancel(false)
    self.timerSetMsg = nil
  end
end

function Avg_5_PhoneCtrl:CheckNextMessage(index)
  if self:GetPanelId() == PanelId.AvgST then
    local nextData = self._panel:GetNextProcFunc(index)
    local state = self:GetNextDataState(nextData)
    if state < 0 then
      self:ShowNextInputingPhoneMsg(state)
    elseif state == 0 then
      index = index + 1
      self:CheckNextMessage(index)
    end
  end
end

function Avg_5_PhoneCtrl:ShowNextInputingPhoneMsg(state)
  if self.inputtingTimer ~= nil then
    self.inputtingTimer:Cancel()
    self.inputtingTimer = nil
  end
  local sFunc = ""
  if state == -1 then
    sFunc = "SetPhoneInputingMsgLeft"
  elseif state == -2 then
    sFunc = "SetPhoneInputingMsgRight"
  end
  self.inputtingTimer = self:AddTimer(1, 0.4 * nTimes, sFunc, true, true, true)
end

function Avg_5_PhoneCtrl:GetNextDataState(mapConfig)
  if mapConfig == nil then
    return 1
  end
  local tbParam = mapConfig.param
  if tbParam == nil then
    return 1
  end
  if mapConfig.cmd == "SetPhoneMsg" then
    if self.bInChoiceMsg then
      return 0
    end
    local nMsgType = tbParam[1]
    if nMsgType == AllEnum.PhoneMsgType.ReceiveMsg or nMsgType == AllEnum.PhoneMsgType.ReceiveImgMsg then
      return -1
    elseif nMsgType == AllEnum.PhoneMsgType.ReplyMsg or nMsgType == AllEnum.PhoneMsgType.ReplyImgMsg then
      return -2
    else
      return 0
    end
  elseif mapConfig.cmd == "SetPhoneMsgChoiceEnd" then
    self.bInChoiceMsg = false
    return 0
  elseif mapConfig.cmd == "SetPhoneMsgChoiceJumpTo" then
    if self.tbChoiceDecision[self.curContactsId] == nil then
      return 1
    end
    local groupID = tbParam[1]
    local index = tbParam[2]
    for k, v in ipairs(self.tbChoiceDecision[self.curContactsId]) do
      local sGroupID = v.groupID
      local nChoiceIndex = v.choiceIndex
      if nChoiceIndex ~= nil and sGroupID ~= nil and sGroupID == groupID then
        if nChoiceIndex == index then
          return 1
        elseif nChoiceIndex ~= index then
          self.bInChoiceMsg = true
          return 0
        end
      end
    end
    return 1
  elseif mapConfig.cmd == "SetPhoneMsgChoiceBegin" then
    self.nAutoPlayWaiting = self.nAutoSelectionPlayWaiting
    return 1
  else
    return 1
  end
  return 1
end

function Avg_5_PhoneCtrl:ClearAllInputingMsg()
  if self.inputtingTimer ~= nil then
    self.inputtingTimer:Cancel()
    self.inputtingTimer = nil
  end
  self.bShowInputingWaiting = false
  if self.tbMsgData[self.curContactsId] == nil or self.tbGridHeight[self.curContactsId] == nil then
    return
  end
  for i = #self.tbMsgData[self.curContactsId], 1, -1 do
    local data = self.tbMsgData[self.curContactsId][i]
    if data.type == 1 and (data.msgData[1] == AllEnum.PhoneMsgType.InputingMsgLeft or data.msgData[1] == AllEnum.PhoneMsgType.InputingMsgRight) then
      table.remove(self.tbMsgData[self.curContactsId], i)
      table.remove(self.tbGridHeight[self.curContactsId], i)
    end
  end
end

function Avg_5_PhoneCtrl:SetPhone(tbParam)
  local nMoveType = tbParam[1]
  local bClearHistoryMsg = tbParam[2] == 0
  local sContactsId = tbParam[3]
  if nMoveType == 0 then
    self:ResetGamepadUI()
  end
  if nMoveType == 1 then
    self.bIsActive = false
  else
    self.bIsActive = true
  end
  if bClearHistoryMsg == true then
    if self.curContactsId ~= nil then
      self.tbMsgData[self.curContactsId] = {}
      self.tbGridHeight[self.curContactsId] = {}
    end
    delChildren(self._mapNode.trContent)
  end
  local nDuration = 0
  local recordedMsg = self.RecordMsg
  self.RecordMsg = false
  if nMoveType == 0 then
    self:SetPhoneContacts(sContactsId)
    if recordedMsg then
      self:AddTimer(1, 0.1, function()
        self:_PlayPhoneInOutAnim(true)
      end, true, true, true)
      nDuration = 1.1
    else
      self:_PlayPhoneInOutAnim(true)
      nDuration = 1
    end
  elseif nMoveType == 1 then
    self:_PlayPhoneInOutAnim(false)
    nDuration = 0.6
  elseif nMoveType == 2 then
    self:_PlayPhoneHorizontalMove(true)
    self:_SetReplyInputField(true)
    nDuration = 0
  elseif nMoveType == 3 then
    self:_PlayPhoneHorizontalMove(false)
    nDuration = 0.4
  elseif nMoveType == 4 then
    self:SetPhoneContacts(sContactsId)
    self.RecordMsg = true
  end
  return nDuration
end

function Avg_5_PhoneCtrl:SetPhoneMsg(tbParam, bWaitRefresh, nProcess)
  self:SetSelectType(SelectType.PhoneGoOn)
  self:SelectUI()
  if self.tbMsgData[self.curContactsId] ~= nil then
    for k, v in ipairs(self.tbMsgData[self.curContactsId]) do
      if nProcess ~= nil and v.nProcess ~= nil and v.nProcess == nProcess then
        if bWaitRefresh ~= true then
          self:_RefreshLoopSV()
        end
        return
      end
    end
  end
  local nMsgType = tbParam[1]
  local sAvgCharId = tbParam[2]
  sAvgCharId = AdjustMainRoleAvgCharId(sAvgCharId)
  local sMsgContent = tbParam[3]
  if nMsgType == 0 or nMsgType == 1 or nMsgType == 2 or nMsgType == 5 then
    sMsgContent = ProcAvgTextContentFallback(self.sTxtLan, self._panel.sVoLan, self._panel.bIsPlayerMale, tbParam[3], tbParam[7], tbParam[8], tbParam[9])
    sMsgContent = ProcAvgTextContent(sMsgContent, self._panel.nCurLanguageIdx)
  end
  local nImgType = tonumber(tbParam[4])
  local imgSize = {}
  if nMsgType == AllEnum.PhoneMsgType.ReceiveImgMsg or nMsgType == AllEnum.PhoneMsgType.ReplyImgMsg then
    local path = nImgType == 1 and "Icon/AvgPhoneImageMsg/" .. sMsgContent or "Icon/AvgPhoneEmojiMsg/" .. sMsgContent
    local sprite = self:GetPngSprite(path)
    imgSize[2] = nImgType == 1 and CONST_WIDTH / sprite.rect.width * sprite.rect.height or sprite.rect.height
    imgSize[1] = nImgType == 1 and CONST_WIDTH or sprite.rect.width
  end
  local voiceName = tbParam[5]
  local isCanSkip = tbParam[6]
  if self.tbMsgData[self.curContactsId] == nil then
    self.tbMsgData[self.curContactsId] = {}
  end
  local data = {
    type = 1,
    msgData = {
      nMsgType,
      sAvgCharId,
      sMsgContent,
      false,
      nImgType,
      imgSize,
      voiceName,
      isCanSkip
    },
    nProcess = nProcess
  }
  table.insert(self.tbMsgData[self.curContactsId], data)
  if self.tbGridHeight[self.curContactsId] == nil then
    self.tbGridHeight[self.curContactsId] = {}
  end
  if nMsgType <= 2 then
    table.insert(self.tbGridHeight[self.curContactsId], self:_CalcGridHeight(sMsgContent))
  elseif nMsgType == AllEnum.PhoneMsgType.SystemMsg then
    local nHeight = self:_CalcMsgGridHeight(sMsgContent)
    table.insert(self.tbGridHeight[self.curContactsId], nHeight)
  else
    table.insert(self.tbGridHeight[self.curContactsId], imgSize[2])
  end
  local nDelayTime = 0
  if nMsgType == AllEnum.PhoneMsgType.ReplyChoiceMgs then
    self:_SetReplyInputField(false, 0.5)
    nDelayTime = 0.5
  end
  if not bWaitRefresh or bWaitRefresh == nil then
    if 0 < nDelayTime then
      self.timerSetMsg = self:AddTimer(1, nDelayTime, "_RefreshLoopSV", true, true, true)
    else
      self:_RefreshLoopSV()
    end
  end
  if not bWaitRefresh and (voiceName == nil or voiceName == "") then
    if nMsgType ~= AllEnum.PhoneMsgType.ReceiveMsg and nMsgType ~= AllEnum.PhoneMsgType.ReceiveImgMsg and nMsgType ~= AllEnum.PhoneMsgType.SystemMsg then
      WwiseAudioMgr:PostEvent("ui_cellphone_message_out")
    elseif nMsgType == AllEnum.PhoneMsgType.SystemMsg then
      WwiseAudioMgr:PostEvent("ui_cellphone_message_pop")
    else
      WwiseAudioMgr:PostEvent("ui_cellphone_message_in")
    end
  end
  if nMsgType == AllEnum.PhoneMsgType.ReceiveMsg or nMsgType == AllEnum.PhoneMsgType.ReplyMsg or nMsgType == AllEnum.PhoneMsgType.ReplyChoiceMgs then
    self.tbLogData.nType = AllEnum.AvgLogType.PhoneMsg
    if nMsgType == AllEnum.PhoneMsgType.ReceiveMsg then
      self.tbLogData.sAvgId = sAvgCharId
    else
      self.tbLogData.sAvgId = AdjustMainRoleAvgCharId(sAvgCharId)
    end
    self.tbLogData.sContent = sMsgContent
    self.tbLogData.sVoice = voiceName
    EventManager.Hit(EventId.AvgMarkLog, self.tbLogData)
  elseif nMsgType == AllEnum.PhoneMsgType.SystemMsg then
    self.tbLogData.nType = AllEnum.AvgLogType.Voiceover
    self.tbLogData.sAvgId = nil
    self.tbLogData.sContent = sMsgContent
    self.tbLogData.sVoice = voiceName
    EventManager.Hit(EventId.AvgMarkLog, self.tbLogData)
  end
  if self.RecordMsg then
    return 0
  end
  return -1
end

function Avg_5_PhoneCtrl:SetPhoneThinking(tbParam)
  self:SetSelectType(SelectType.ThinkingGoOn)
  self:SelectUI()
  self.bPhoneThinking = true
  self._mapNode.animMainRole:SetTrigger("tIn")
  self._mapNode.goMask:SetActive(true)
  local sBody = tbParam[1]
  local sFace = tbParam[2]
  local sEmoji = tbParam[3]
  local sContentOS = tbParam[4]
  if self._panel.bIsPlayerMale == true and tbParam[5] ~= nil and tbParam[5] ~= "" then
    sContentOS = tbParam[5]
  end
  sContentOS = ProcAvgTextContent(sContentOS, self._panel.nCurLanguageIdx)
  local nTextAnimDuration = self:_CalcTextAnimDuration(sContentOS)
  local twDOText = NovaAPI.DOText_RubyTMP(self._mapNode.rtmp_os, sContentOS, nTextAnimDuration)
  twDOText:SetUpdate(true)
  self:AddTimer(1, nTextAnimDuration, "_DelayShowThinkingBtn", true, true, true)
  EventManager.Hit(EventId.AvgChoiceMainRoleOS_In, self._mapNode.trMainRole, sBody, sFace, sEmoji)
  self:_PlayPhoneHorizontalMove(true)
  self:_PlayPhoneScaleMove(true)
  self:_SetBtnEnable(false)
  return -1
end

function Avg_5_PhoneCtrl:SetPhoneContacts(sContactsId)
  if sContactsId == nil then
    if self.curContactsId == nil then
      self.curContactsId = #self.tbMsgData + 1
    end
    self._mapNode.goTitle:SetActive(false)
    return
  end
  self.curContactsId = sContactsId
  local constactData = self._panel:GetAvgContactsData(tonumber(sContactsId))
  if constactData == nil then
    if self.curContactsId == nil then
      self.curContactsId = #self.tbMsgData + 1
    end
    self._mapNode.goTitle:SetActive(false)
    return
  end
  self._mapNode.goTitle:SetActive(constactData ~= sContactsId)
  if constactData ~= sContactsId then
    local sIcon = Avg_ProcContactsIcon_M_F(constactData.icon)
    sIcon = string.gsub(sIcon, AllEnum.CharHeadIconSurfix.S, "")
    self:SetPngSprite(self._mapNode.imgContactHead, sIcon, AllEnum.CharHeadIconSurfix.S)
    NovaAPI.SetTMPText(self._mapNode.txtCharName, ProcAvgTextContent(constactData.name, self._panel.nCurLanguageIdx))
    NovaAPI.SetTMPText(self._mapNode.txtSignature, constactData.signature)
  end
end

function Avg_5_PhoneCtrl:SetPhoneMsgChoiceBegin(tbParam, bWaitRefresh, nProcess)
  EventManager.Hit(EventId.AvgAllMenuBtnEnable, false)
  self:SetSelectType(SelectType.ChoiceMsg)
  if self.tbMsgData[self.curContactsId] ~= nil then
    for k, v in ipairs(self.tbMsgData[self.curContactsId]) do
      if nProcess ~= nil and v.nProcess ~= nil and v.nProcess == nProcess then
        if bWaitRefresh ~= true then
          self:_RefreshLoopSV()
        end
        return
      end
    end
  end
  local sGroupId = tbParam[1]
  local tbChoices = {}
  local nOffset = self._panel.bIsPlayerMale == true and 3 or 0
  for i = 2, 4 do
    local sChoiceContent = tbParam[i + nOffset]
    if sChoiceContent == nil or sChoiceContent == "" then
      sChoiceContent = tbParam[i]
    end
    if sChoiceContent ~= nil and sChoiceContent ~= "" then
      table.insert(tbChoices, sChoiceContent)
    end
  end
  local nMsgType = AllEnum.PhoneMsgType.ReplyMsg
  if 0 < #tbChoices then
    if IsStartsWith(tbChoices[1], "emoji_") then
      nMsgType = AllEnum.PhoneMsgType.ReplyEmoji
    elseif IsStartsWith(tbChoices[1], "pic_") then
      nMsgType = AllEnum.PhoneMsgType.ReplyImgMsg
    end
  end
  local sAvgCharId = (tbParam[8] == nil or tbParam[8] == "") and AdjustMainRoleAvgCharId() or tbParam[8]
  local data = {
    type = 2,
    msgData = {
      groupID = sGroupId,
      msgType = nMsgType,
      choices = tbChoices,
      sAvgCharId = sAvgCharId
    },
    nProcess = nProcess
  }
  if self.tbMsgData[self.curContactsId] == nil then
    self.tbMsgData[self.curContactsId] = {}
  end
  if self.tbGridHeight[self.curContactsId] == nil then
    self.tbGridHeight[self.curContactsId] = {}
  end
  table.insert(self.tbMsgData[self.curContactsId], data)
  if nMsgType == AllEnum.PhoneMsgType.ReplyMsg then
    local nHeight = choice_selection_top + choice_selection_bottom + choice_selection_input + choice_head_offset
    for _, v in ipairs(tbChoices) do
      nHeight = nHeight + self:_CalcChoiceHeight(v) + choice_img_diff
    end
    nHeight = nHeight + choice_selection_space * (#tbChoices - 1)
    table.insert(self.tbGridHeight[self.curContactsId], nHeight)
  else
    table.insert(self.tbGridHeight[self.curContactsId], 461)
  end
  if not bWaitRefresh or bWaitRefresh == nil then
    self:_RefreshLoopSV()
  end
  NovaAPI.SetScreenSleepTimeout(false)
  return -1
end

function Avg_5_PhoneCtrl:SetPhoneMsgChoiceJumpTo(tbParam)
  EventManager.Hit(EventId.AvgAllMenuBtnEnable, true)
  local groupID = tonumber(tbParam[1])
  local index = tonumber(tbParam[2])
  if self.tbChoiceDecision[self.curContactsId] == nil then
    return 0
  end
  for k, v in ipairs(self.tbChoiceDecision[self.curContactsId]) do
    local nGroupID = tonumber(v.groupID)
    local nChoiceIndex = tonumber(v.choiceIndex)
    if nGroupID == groupID then
      if nChoiceIndex == index then
        return 0
      else
        if self:GetPanelId() == PanelId.AvgST then
          self._panel:SetPhoneMsgChoiceEnd(groupID)
          return 0
        end
        EventManager.Hit(EventId.AvgSetToPhoneMsgChoiceEnd, groupID, self.bIsAutoPlaying)
      end
    end
  end
  EventManager.Hit("AvgCheckAutoOnOff")
  return -1
end

function Avg_5_PhoneCtrl:SetPhoneMsgChoiceEnd(tbParam)
  local groupID = tbParam[1]
  EventManager.Hit(EventId.AvgSetToPhoneMsgChoiceEnd, groupID, self.bIsAutoPlaying)
  return 0
end

function Avg_5_PhoneCtrl:SetHistoryPhoneMsg(tbMsgData, tbSelectionData)
  if tbSelectionData ~= nil then
    self.tbChoiceDecision[self.curContactsId] = tbSelectionData
  end
  for k, v in ipairs(tbMsgData) do
    if v.cmd == "SetPhoneMsg" then
      self:SetPhoneMsg(v.param, true, v.process)
    elseif v.cmd == "SetPhoneMsgChoiceBegin" then
      self:SetPhoneMsgChoiceBegin(v.param, true, v.process)
    end
  end
  self.bRevertHistoryMsg = true
  self:_RefreshLoopSV(0)
  self.bRevertHistoryMsg = false
end

function Avg_5_PhoneCtrl:SetPhoneInputingMsgLeft()
  local data = {
    type = 1,
    msgData = {
      AllEnum.PhoneMsgType.InputingMsgLeft
    }
  }
  table.insert(self.tbMsgData[self.curContactsId], data)
  table.insert(self.tbGridHeight[self.curContactsId], 104)
  self:_RefreshLoopSV()
  self.inputtingTimer = nil
end

function Avg_5_PhoneCtrl:SetPhoneInputingMsgRight()
  local data = {
    type = 1,
    msgData = {
      AllEnum.PhoneMsgType.InputingMsgRight
    }
  }
  table.insert(self.tbMsgData[self.curContactsId], data)
  table.insert(self.tbGridHeight[self.curContactsId], 104)
  self:_RefreshLoopSV()
  self.inputtingTimer = nil
end

function Avg_5_PhoneCtrl:AddGamepadUINode()
  if self:GetPanelId() ~= PanelId.AvgST then
    return
  end
  GamepadUIManager.AddGamepadUINode("AVG", self:GetGamepadUINode())
end

function Avg_5_PhoneCtrl:OnBtnSelect_ChoiceMsg(btn, nIndex)
  if self:GetPanelId() ~= PanelId.AvgST then
    return
  end
  if self.nSelectIndex == nIndex then
    return
  end
  for k, v in ipairs(self.tbSelectBtnObj) do
    local goSelect = v.gameObject.transform:Find("AnimRoot/goSelect").gameObject
    if k == nIndex then
      if GamepadUIManager.GetCurUIType() ~= AllEnum.GamepadUIType.Other and GamepadUIManager.GetCurUIType() ~= AllEnum.GamepadUIType.Mouse then
        goSelect:SetActive(true)
      else
        goSelect:SetActive(false)
      end
    elseif k == self.nSelectIndex then
      goSelect:SetActive(false)
    end
  end
  self.nSelectIndex = nIndex
end

function Avg_5_PhoneCtrl:SetSelectBtnObj(nIndex, btnObj)
  if self:GetPanelId() ~= PanelId.AvgST then
    return
  end
  if next(self.tbSelectBtnObj) == nil then
    self.nSelectIndex = nIndex
  end
  table.insert(self.tbSelectBtnObj, btnObj)
end

function Avg_5_PhoneCtrl:SetSelectType(nType)
  if self:GetPanelId() ~= PanelId.AvgST then
    return
  end
  self.nSelectType = nType
  self.tbSelectBtnObj = {}
  self.nSelectIndex = 0
end

function Avg_5_PhoneCtrl:ClearSelect()
  if self:GetPanelId() ~= PanelId.AvgST then
    return
  end
  GamepadUIManager.ClearSelectedUI()
  self.nSelectIndex = 0
  self.tbSelectBtnObj = {}
end

function Avg_5_PhoneCtrl:SelectUI()
  if self:GetPanelId() ~= PanelId.AvgST then
    return
  end
  if self.nSelectType == SelectType.ChoiceMsg then
    local nUIType = GamepadUIManager.GetCurUIType()
    if nUIType ~= AllEnum.GamepadUIType.Other and nUIType ~= AllEnum.GamepadUIType.Mouse then
      if self.nSelectIndex and self.nSelectIndex ~= 0 then
        self.tbSelectBtnObj[self.nSelectIndex].gameObject.transform:Find("AnimRoot/goSelect").gameObject:SetActive(true)
        GamepadUIManager.SetSelectedUI(self.tbSelectBtnObj[self.nSelectIndex].gameObject)
      end
    else
      for k, _ in ipairs(self.tbSelectBtnObj) do
        self.tbSelectBtnObj[k].gameObject.transform:Find("AnimRoot/goSelect").gameObject:SetActive(false)
      end
    end
  elseif self.nSelectType == SelectType.PhoneGoOn then
    GamepadUIManager.SetSelectedUI(self._mapNode.btnGoOn.gameObject)
  elseif self.nSelectType == SelectType.ThinkingGoOn then
    GamepadUIManager.SetSelectedUI(self._mapNode.btnThinkingGoOn.gameObject)
  end
end

function Avg_5_PhoneCtrl:ResetGamepadUI()
  if self:GetPanelId() ~= PanelId.AvgST then
    return
  end
  self._panel.sCurGamepadUI = "Phone"
  GamepadUIManager.ClearSelectedUI()
  self.tbSelectBtnObj = {}
  self.nSelectIndex = 0
  self.nSelectType = SelectType.PhoneGoOn
  local tbConfig = {
    {
      sAction = "Scroll",
      sLang = "ActionBar_Scroll"
    }
  }
  EventManager.Hit(EventId.AvgRefreshActionBar, tbConfig)
end

function Avg_5_PhoneCtrl:OnEvent_GamepadUIChange(sName, nBeforeType, nAfterType)
  if self:GetPanelId() ~= PanelId.AvgST then
    return
  end
  if sName ~= "AVG" or self._panel.sCurGamepadUI ~= "Phone" then
    return
  end
  self:SelectUI()
end

function Avg_5_PhoneCtrl:OnEvent_Reopen(sName)
  if self:GetPanelId() ~= PanelId.AvgST then
    return
  end
  if sName ~= "AVG" or self._panel.sCurGamepadUI ~= "Phone" then
    return
  end
  self:SelectUI()
end

return Avg_5_PhoneCtrl
