local Avg_4_TalkCtrl = class("Avg_4_TalkCtrl", BaseCtrl)
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local ResType = GameResourceLoader.ResType
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local AUTO_PLAY_WAITING_DEFAULT = 3
local AUTO_PLAY_WAITING_VOICE = 0.1
Avg_4_TalkCtrl._mapNodeConfig = {
  trCameraAperture = {
    sNodeName = "CameraAperture",
    sComponentName = "Transform"
  },
  cg_CameraAperture = {
    sNodeName = "====CameraAperture====",
    sComponentName = "CanvasGroup"
  },
  btnClickToGoOn = {
    sComponentName = "Button",
    callback = "OnBtnClick_GoOn"
  },
  btnShortcutClickToGoOn = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_GoOn"
  },
  rubyTMP_ContentElement = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  rtRubyTMP = {
    sNodeName = "rubyTMP_ContentElement",
    sComponentName = "RectTransform"
  },
  canvasGroup_Talk = {
    sNodeName = "----Talk----",
    sComponentName = "CanvasGroup"
  },
  shake_Talk = {
    sNodeName = "----Talk----",
    sComponentName = "GameObject"
  },
  imgTalkNameBg = {sComponentName = "Image"},
  trWaiting_Talk = {
    sNodeName = "--Waiting_Talk--",
    sComponentName = "Transform"
  },
  rubyTmp_Talk = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  txtName_Talk = {sComponentName = "TMP_Text"},
  btnSvTalk = {
    sNodeName = "sv_Talk",
    sComponentName = "UIButton",
    callback = "OnBtnClick_GoOn"
  },
  sv_Talk = {
    sComponentName = "GamepadScroll"
  },
  imgThinkMask = {sComponentName = "Image"},
  canvasGroup_SayThink = {
    sNodeName = "----SayThink----",
    sComponentName = "CanvasGroup"
  },
  shake_SayThink = {
    sNodeName = "----SayThink----",
    sComponentName = "GameObject"
  },
  animSwitchSayThinkBg = {
    sNodeName = "----SayThink----",
    sComponentName = "Animator"
  },
  trWaiting_SayThink = {
    sNodeName = "--Waiting_SayThink--",
    sComponentName = "Transform"
  },
  rubyTmp_SayThink = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  btnSvSayThink = {
    sNodeName = "sv_SayThink",
    sComponentName = "UIButton",
    callback = "OnBtnClick_GoOn"
  },
  sv_SayThink = {
    sComponentName = "GamepadScroll"
  },
  rtHeadPos = {
    sComponentName = "RectTransform"
  },
  canvasGroup_Head = {
    sNodeName = "rtHeadPos",
    sComponentName = "CanvasGroup"
  },
  canvasGroup_Film = {
    sNodeName = "----Film----",
    sComponentName = "CanvasGroup"
  },
  rubyTmp_Film = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  canvasGroup_Dialog_1L = {
    sNodeName = "----Dialog_1L----",
    sComponentName = "CanvasGroup"
  },
  shake_Dialog_1L = {
    sNodeName = "----Dialog_1L----",
    sComponentName = "GameObject"
  },
  imgTalkNameBg_1L = {sComponentName = "Image"},
  trWaiting_Dialog_1L = {
    sNodeName = "--Waiting_Dialog_1L--",
    sComponentName = "Transform"
  },
  rubyTmp_1L = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  txtName_Dialog_1L = {sComponentName = "TMP_Text"},
  btnSvD1L = {
    sNodeName = "sv_Dialog_1L",
    sComponentName = "UIButton",
    callback = "OnBtnClick_GoOn"
  },
  sv_Dialog_1L = {
    sComponentName = "GamepadScroll"
  },
  canvasGroup_Dialog_1R = {
    sNodeName = "----Dialog_1R----",
    sComponentName = "CanvasGroup"
  },
  shake_Dialog_1R = {
    sNodeName = "----Dialog_1R----",
    sComponentName = "GameObject"
  },
  imgTalkNameBg_1R = {sComponentName = "Image"},
  trWaiting_Dialog_1R = {
    sNodeName = "--Waiting_Dialog_1R--",
    sComponentName = "Transform"
  },
  rubyTmp_1R = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  txtName_Dialog_1R = {sComponentName = "TMP_Text"},
  btnSvD1R = {
    sNodeName = "sv_Dialog_1R",
    sComponentName = "UIButton",
    callback = "OnBtnClick_GoOn"
  },
  sv_Dialog_1R = {
    sComponentName = "GamepadScroll"
  },
  canvasGroup_Dialog_2L = {
    sNodeName = "----Dialog_2L----",
    sComponentName = "CanvasGroup"
  },
  shake_Dialog_2L = {
    sNodeName = "----Dialog_2L----",
    sComponentName = "GameObject"
  },
  imgTalkNameBg_2L = {sComponentName = "Image"},
  trWaiting_Dialog_2L = {
    sNodeName = "--Waiting_Dialog_2L--",
    sComponentName = "Transform"
  },
  rubyTmp_2L = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  txtName_Dialog_2L = {sComponentName = "TMP_Text"},
  btnSvD2L = {
    sNodeName = "sv_Dialog_2L",
    sComponentName = "UIButton",
    callback = "OnBtnClick_GoOn"
  },
  sv_Dialog_2L = {
    sComponentName = "GamepadScroll"
  },
  canvasGroup_Dialog_2R = {
    sNodeName = "----Dialog_2R----",
    sComponentName = "CanvasGroup"
  },
  shake_Dialog_2R = {
    sNodeName = "----Dialog_2R----",
    sComponentName = "GameObject"
  },
  imgTalkNameBg_2R = {sComponentName = "Image"},
  trWaiting_Dialog_2R = {
    sNodeName = "--Waiting_Dialog_2R--",
    sComponentName = "Transform"
  },
  rubyTmp_2R = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  txtName_Dialog_2R = {sComponentName = "TMP_Text"},
  btnSvD2R = {
    sNodeName = "sv_Dialog_2R",
    sComponentName = "UIButton",
    callback = "OnBtnClick_GoOn"
  },
  sv_Dialog_2R = {
    sComponentName = "GamepadScroll"
  },
  canvasGroup_Center = {
    sNodeName = "----Center----",
    sComponentName = "CanvasGroup"
  },
  rubyTmp_Center = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  imgContentBg_Center = {},
  canvasGroup_CGTalk = {
    sNodeName = "----CGTalk----",
    sComponentName = "CanvasGroup"
  },
  imgContentLine = {},
  trWaiting_CGTalk = {
    sNodeName = "--Waiting_CGTalk--",
    sComponentName = "Transform"
  },
  rubyTmp_CGTalk = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  txtName_CGTalk = {sComponentName = "TMP_Text"},
  canvasGroup_FS = {
    sNodeName = "----FullScreen----",
    sComponentName = "CanvasGroup"
  },
  btnSvFS = {
    sNodeName = "svFS",
    sComponentName = "UIButton",
    callback = "OnBtnClick_GoOn"
  },
  svFS = {
    sComponentName = "GamepadScroll"
  },
  rtWaiting_FS = {
    sNodeName = "--Waiting_FS--",
    sComponentName = "RectTransform"
  },
  rubyTmp_FS = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  rubyTmp_FS_EndLine = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  rtEndLine = {
    sNodeName = "rubyTmp_FS_EndLine",
    sComponentName = "RectTransform"
  },
  rubyTmp_FS_Total = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  rtTotal = {
    sNodeName = "rubyTmp_FS_Total",
    sComponentName = "RectTransform"
  },
  rtWaiting = {
    sComponentName = "RectTransform"
  },
  rtWaiting_White = {
    sComponentName = "RectTransform"
  },
  animWaiting = {
    sNodeName = "goWaitingAnim",
    sComponentName = "Animator"
  },
  animWaiting_White = {
    sNodeName = "goWaitingAnim_White",
    sComponentName = "Animator"
  },
  goEmptyBottom = {},
  imgFullScreenBlockInput = {
    sNodeName = "full_screen_image_temp_block_btn",
    sComponentName = "Image"
  }
}
Avg_4_TalkCtrl._mapEventConfig = {
  [EventId.AvgSetAutoPlay] = "OnEvent_AvgSetAutoPlay",
  [EventId.AvgShowHideTalkUI] = "OnEvent_AvgShowHideTalkUI",
  [EventId.AvgClearTalk] = "OnEvent_ClearTalk",
  [EventId.AvgL2DAnimEvent_Start] = "OnL2DAnimEvent_RunNextCmd",
  [EventId.AvgL2DAnimEvent_Next] = "OnL2DAnimEvent_GoOn",
  [EventId.AvgL2DAnimEvent_End] = "OnL2DAnimEvent_BtnClick",
  [EventId.AvgL2DAnimEvent_Done] = "OnL2DAnimEvent_Done",
  [EventId.AvgVoiceDuration] = "OnEvent_AvgVoiceDuration",
  [EventId.AvgSpeedUp] = "OnEvent_AvgSpeedUp",
  GamepadUIChange = "OnEvent_GamepadUIChange",
  GamepadUIReopen = "OnEvent_Reopen",
  AVG_SetCameraAperture = "OnEvent_AVG_SetCameraAperture"
}

function Avg_4_TalkCtrl:Awake()
  self.rootCanvasGroup = self.gameObject:GetComponent("CanvasGroup")
  self.sNone = ""
  self.sParagraphSignal = "==P=="
  self.sBreakSignal = "==B=="
  self.sWaitSignal = "==W=="
  self.sAutoParagraphSignal = "==A(.+)=="
  self.sCenterBgOff = "==Off=="
  self.nContentBgFadeDuration = 0.35
  self.nHeadInOutAnimDuration = 0.5
  self.nContentTextDelay_1 = 0.2
  self.nContentTextDelay_2 = 0.3
  self.bIsAutoPlaying = false
  self.twDOText = nil
  self.tbPage = nil
  self.nPageIndex = nil
  self.curCanvasGroup = nil
  self.curTMP = nil
  self.sPartialContent = self.sNone
  self.nClearType = 0
  self.timerAutoPlayWaiting = nil
  self.mapPresetShakeChar = nil
  self.mapPresetShakeTalk = nil
  self.bNeedWaitVoiceFinish = false
  self.bNeedPlayPageSound = false
  self.bForceDisableBtn_LogHide = false
  self.tbLogData = {}
  self:_SetAutoLineWrap(true)
end

function Avg_4_TalkCtrl:OnEnable()
  self:AddGamepadUINode()
end

function Avg_4_TalkCtrl:OnDisable()
  self.mapPresetShakeChar = nil
  self.mapPresetShakeTalk = nil
  if self.twDOText ~= nil then
    self.twDOText:Kill()
    self.twDOText = nil
  end
  if self.timerVoicePlayWaiting ~= nil then
    self.timerVoicePlayWaiting:Cancel()
    self.timerVoicePlayWaiting = nil
    WwiseAudioMgr:WwiseVoice_StopInAVG()
  end
  self.bNeedWaitVoiceFinish = false
end

function Avg_4_TalkCtrl:_LoadPresetShake()
  if self.mapPresetShakeChar == nil then
    self.mapPresetShakeChar = {}
    for _, data in ipairs(self._panel.tbAvgPreset.CharShakeType) do
      local sKey = data[1]
      self.mapPresetShakeChar[sKey] = data[2]
    end
  end
  if self.mapPresetShakeTalk == nil then
    self.mapPresetShakeTalk = {}
    for _, data in ipairs(self._panel.tbAvgPreset.BgShakeType) do
      local sKey = data[1]
      self.mapPresetShakeTalk[sKey] = data[2]
    end
  end
end

function Avg_4_TalkCtrl:_SetAutoLineWrap(bEnable)
  NovaAPI.SetTMP_AutoLineWrap(self._mapNode.rubyTmp_Talk, bEnable)
  NovaAPI.SetTMP_AutoLineWrap(self._mapNode.rubyTmp_SayThink, bEnable)
  NovaAPI.SetTMP_AutoLineWrap(self._mapNode.rubyTmp_1L, bEnable)
  NovaAPI.SetTMP_AutoLineWrap(self._mapNode.rubyTmp_1R, bEnable)
  NovaAPI.SetTMP_AutoLineWrap(self._mapNode.rubyTmp_2L, bEnable)
  NovaAPI.SetTMP_AutoLineWrap(self._mapNode.rubyTmp_2R, bEnable)
  NovaAPI.SetTMP_AutoLineWrap(self._mapNode.rubyTmp_Center, bEnable)
  NovaAPI.SetTMP_AutoLineWrap(self._mapNode.rubyTmp_CGTalk, bEnable)
  NovaAPI.SetTMP_AutoLineWrap(self._mapNode.rubyTmp_FS, bEnable)
end

function Avg_4_TalkCtrl:_CheckLogBtnForceDisable(sContent)
  if string.find(sContent, self.sBreakSignal) ~= nil then
    self.bForceDisableBtn_LogHide = true
  elseif string.find(sContent, self.sWaitSignal) ~= nil then
    self.bForceDisableBtn_LogHide = true
  elseif string.find(sContent, self.sAutoParagraphSignal) ~= nil then
    self.bForceDisableBtn_LogHide = true
  else
    self.bForceDisableBtn_LogHide = false
  end
end

function Avg_4_TalkCtrl:_StartTimerAutoPlayWaiting(nWaitTime)
  if self:GetPanelId() ~= PanelId.AvgST then
    return
  end
  if nWaitTime == nil then
    nWaitTime = AUTO_PLAY_WAITING_DEFAULT
  end
  if self.timerAutoPlayWaiting == nil then
    self.timerAutoPlayWaiting = self:AddTimer(1, nWaitTime, "_AutoPlayTimerCallback", true, false, true)
  else
    self.timerAutoPlayWaiting:Reset(nil, nWaitTime)
  end
end

function Avg_4_TalkCtrl:_PauseTimerAutoPlayWaiting()
  if self.timerAutoPlayWaiting ~= nil then
    self.timerAutoPlayWaiting:Pause()
  end
end

function Avg_4_TalkCtrl:_AutoPlayTimerCallback(_timer)
  self:OnBtnClick_GoOn(self._mapNode.btnClickToGoOn, true)
end

function Avg_4_TalkCtrl:_TempBlockInput()
  NovaAPI.SetImageRaycastTarget(self._mapNode.imgFullScreenBlockInput, true)
  
  local function func()
    NovaAPI.SetImageRaycastTarget(self._mapNode.imgFullScreenBlockInput, false)
  end
  
  self:AddTimer(1, 0.15, func, true, true, true)
end

function Avg_4_TalkCtrl:_SetBtnEnable(bEnable)
  if self.bInL2DTalk == true then
    bEnable = false
  end
  if bEnable == true then
    self:_TempBlockInput()
  end
  NovaAPI.SetButtonInteractable(self._mapNode.btnClickToGoOn, bEnable == true)
  NovaAPI.SetButtonInteractable(self._mapNode.btnShortcutClickToGoOn, bEnable == true)
  self._mapNode.btnClickToGoOn.gameObject:SetActive(bEnable)
  self._mapNode.btnShortcutClickToGoOn.gameObject:SetActive(bEnable)
  NovaAPI.SetCanvasGroupInteractable(self.rootCanvasGroup, bEnable == true)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self.rootCanvasGroup, bEnable == true)
  if bEnable and self._panel.sCurGamepadUI == "Talk" then
    GamepadUIManager.ClearSelectedUI()
    GamepadUIManager.SetSelectedUI(self._mapNode.btnShortcutClickToGoOn.gameObject)
  end
end

function Avg_4_TalkCtrl:OnBtnClick_GoOn(btn, bOnTimer)
  if self:GetPanelId() ~= PanelId.AvgST then
    return
  end
  if self.bInL2DTalk ~= true and self.bNeedWaitVoiceFinish ~= true and self.timerVoicePlayWaiting ~= nil then
    self.timerVoicePlayWaiting:Cancel()
    self.timerVoicePlayWaiting = nil
  end
  if self.twDOText ~= nil then
    self.twDOText:Kill(true)
    self.twDOText = nil
    return
  end
  if self.bIsAutoPlaying == true and bOnTimer ~= true then
    self:_PauseTimerAutoPlayWaiting()
  end
  if self.tbPage == nil then
    return
  end
  local sType = self.tbPage[self.nPageIndex][2]
  if sType == "Subtitle" then
    self:_SetBtnEnable(false)
    if self.nClearType == 0 then
      self:_ClearTalk()
    end
    self:_PlayPageSound(self.bIsAutoPlaying == true and bOnTimer == true)
    self.tbPage = nil
    self.nPageIndex = nil
    WwiseAudioMgr:WwiseVoice_StopInAVG()
    self:_RunNextCmd()
  elseif sType == "Break" or sType == "Paragraph" then
    self:_ProcAlphaCombine(sType == "Paragraph")
    self:_SetWaitingVisible(false)
    if self.nPageIndex == #self.tbPage then
      self:_SetBtnEnable(false)
      self:_SetScrollable(false)
      if self.nClearType == 0 then
        self:_ClearTalk()
      end
      self:_PlayPageSound(self.bIsAutoPlaying == true and bOnTimer == true)
      self.tbPage = nil
      self.nPageIndex = nil
      self.sPartialContent = self.sNone
      NovaAPI.SetText_RubyTMP(self._mapNode.rubyTMP_ContentElement, self.sNone)
      self:_RunNextCmd()
    else
      self.nPageIndex = self.nPageIndex + 1
      self:_ProcParagraph()
    end
  end
end

function Avg_4_TalkCtrl:_PlayPageSound(bAuto)
  if self.bNeedPlayPageSound ~= true then
    return
  end
  if bAuto == true then
    WwiseAudioMgr:PlaySound("ui_dialog_auto")
  else
    WwiseAudioMgr:PlaySound("ui_dialog_click")
  end
end

function Avg_4_TalkCtrl:OnEvent_AvgSetAutoPlay(bAuto, bByInit)
  self.bIsAutoPlaying = bAuto
  local sTrigger = "tManual"
  if self.bIsAutoPlaying == true then
    sTrigger = "tAuto"
  end
  self._mapNode.animWaiting:SetTrigger(sTrigger)
  self._mapNode.animWaiting_White:SetTrigger(sTrigger)
  if bByInit == true then
    return
  end
  if self.bNeedWaitVoiceFinish == true then
    if self:_CheckTalkContentTextIsDone() ~= true then
      return
    end
    if self.timerVoicePlayWaiting == nil then
      if self.bIsAutoPlaying == true then
        self:_StartTimerAutoPlayWaiting()
      else
        self:_PauseTimerAutoPlayWaiting()
      end
    end
  elseif self.twDOText == nil and self.tbPage ~= nil then
    local sType = self.tbPage[self.nPageIndex][2]
    if sType == "Break" or sType == "Paragraph" or sType == "Subtitle" then
      if self.bIsAutoPlaying == true then
        if self.timerVoicePlayWaiting == nil then
          self:_StartTimerAutoPlayWaiting()
        end
      else
        self:_PauseTimerAutoPlayWaiting()
      end
    end
  end
end

function Avg_4_TalkCtrl:OnEvent_AvgShowHideTalkUI(bVisible)
  NovaAPI.SetCanvasGroupAlpha(self.rootCanvasGroup, bVisible == true and 1 or 1.0E-4)
  NovaAPI.SetCanvasGroupInteractable(self.rootCanvasGroup, bVisible == true)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self.rootCanvasGroup, bVisible == true)
  NovaAPI.SetButtonInteractable(self._mapNode.btnClickToGoOn, bVisible == true)
  NovaAPI.SetButtonInteractable(self._mapNode.btnShortcutClickToGoOn, bVisible == true)
  if bVisible and self._panel.sCurGamepadUI == "Talk" then
    GamepadUIManager.ClearSelectedUI()
    GamepadUIManager.SetSelectedUI(self._mapNode.btnShortcutClickToGoOn.gameObject)
  end
end

function Avg_4_TalkCtrl:OnEvent_ClearTalk()
  self:_ClearTalk()
  self:_SetBtnEnable(false)
end

function Avg_4_TalkCtrl:_ClearTalk()
  if self.twDOText ~= nil then
    self.twDOText:Kill()
    self.twDOText = nil
  end
  if self.curCanvasGroup == nil then
    return
  end
  local nDelayTime
  if self.curCanvasGroup == self._mapNode.canvasGroup_SayThink and NovaAPI.GetCanvasGroupAlpha(self._mapNode.canvasGroup_Head) > 0 then
    nDelayTime = self.nHeadInOutAnimDuration - self.nContentBgFadeDuration
  end
  NovaAPI.SetCanvasGroupInteractable(self.curCanvasGroup, false)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self.curCanvasGroup, false)
  local tw = self.curCanvasGroup:DOFade(0, self.nContentBgFadeDuration):SetUpdate(true):SetEase(Ease.InSine)
  if nDelayTime ~= nil then
    tw:SetDelay(nDelayTime)
  end
  self.curTMP = nil
  self.curCanvasGroup = nil
  NovaAPI.ImageDoFade(self._mapNode.imgThinkMask, 0, 0.1, true)
  NovaAPI.StopShakeEffect(self._mapNode.shake_Talk)
  NovaAPI.StopShakeEffect(self._mapNode.shake_SayThink)
  NovaAPI.StopShakeEffect(self._mapNode.shake_Dialog_1L)
  NovaAPI.StopShakeEffect(self._mapNode.shake_Dialog_1R)
  NovaAPI.StopShakeEffect(self._mapNode.shake_Dialog_2L)
  NovaAPI.StopShakeEffect(self._mapNode.shake_Dialog_2R)
  self:_SetWaitingVisible(false)
end

function Avg_4_TalkCtrl:OnL2DAnimEvent_RunNextCmd()
  self:_RunNextCmd(true)
end

function Avg_4_TalkCtrl:OnL2DAnimEvent_GoOn()
  if self.twDOText ~= nil then
    self.twDOText:Kill(true)
    self.twDOText = nil
  end
  self:SetGoOn()
end

function Avg_4_TalkCtrl:OnL2DAnimEvent_BtnClick()
  if self.twDOText ~= nil then
    self.twDOText:Kill(true)
    self.twDOText = nil
  end
  if type(self.tbPage) == "table" and self.nPageIndex == #self.tbPage and type(self.tbLogData) == "table" then
    EventManager.Hit(EventId.AvgMarkLog, self.tbLogData)
    self.tbLogData = nil
  end
  self:OnBtnClick_GoOn()
end

function Avg_4_TalkCtrl:OnL2DAnimEvent_Done()
  self.bInL2DTalk = false
  if self.twDOText ~= nil then
    self.twDOText:Kill(true)
    self.twDOText = nil
  end
  self:_SetBtnEnable(true)
  self:_SetWaitingVisible(true)
  if self.bIsAutoPlaying == true then
    self:_StartTimerAutoPlayWaiting()
  end
end

function Avg_4_TalkCtrl:OnEvent_AvgVoiceDuration(nDuration)
  if self:GetPanelId() == PanelId.AvgEditor then
    return
  end
  if self.bProcVoiceCallbackEvent ~= true then
    return
  end
  self.bProcVoiceCallbackEvent = false
  if self.bInL2DTalk == true then
    return
  end
  if self.timerVoicePlayWaiting ~= nil then
    self.timerVoicePlayWaiting:Cancel()
    self.timerVoicePlayWaiting = nil
    WwiseAudioMgr:WwiseVoice_StopInAVG()
  end
  self.timerVoicePlayWaiting = self:AddTimer(1, nDuration, "_EndPlayTalkVoice", true, true, true)
end

function Avg_4_TalkCtrl:_EndPlayTalkVoice(_timer)
  self.timerVoicePlayWaiting = nil
  if self:_CheckTalkContentTextIsDone() ~= true then
    return
  elseif self.bNeedWaitVoiceFinish == true then
    if self.bSubtitle == true then
      self:_SubtitleDone(nil, AUTO_PLAY_WAITING_VOICE)
    elseif self.bExParagraph == true then
      self:_ParagraphDoneEx()
    else
      self:_ParagraphDone(AUTO_PLAY_WAITING_VOICE)
    end
  elseif self.bIsAutoPlaying == true then
    self:_StartTimerAutoPlayWaiting(AUTO_PLAY_WAITING_VOICE)
  end
end

function Avg_4_TalkCtrl:OnEvent_AvgSpeedUp(nRate)
  if self:GetPanelId() ~= PanelId.AvgST then
    return
  end
  self:OnEvent_AvgSpeedUp_Timer(nRate)
  NovaAPI.SetAnimatorSpeed(self._mapNode.animSwitchSayThinkBg, nRate)
  NovaAPI.SetAnimatorSpeed(self._mapNode.animWaiting, nRate)
  NovaAPI.SetAnimatorSpeed(self._mapNode.animWaiting_White, nRate)
end

function Avg_4_TalkCtrl:_SwitchSayThink(nType, bReset)
  if nType == 1 or nType == 2 then
    if self.nCurSayThink == nType then
      return
    end
    local sColor = nType == 1 and "#132C47" or "#F1F4F6"
    NovaAPI.SetTextColor_RubyTMP(self._mapNode.rubyTmp_SayThink, sColor)
    local sTriggerName
    if nType == 1 then
      sTriggerName = "tPlayToSay"
      if bReset == true then
        sTriggerName = "tSetToSay"
      end
    elseif nType == 2 then
      sTriggerName = "tPlayToThink"
      if bReset == true then
        sTriggerName = "tSetToThink"
      end
    end
    self._mapNode.animSwitchSayThinkBg:SetTrigger(sTriggerName)
    self.nCurSayThink = nType
  end
end

function Avg_4_TalkCtrl:_PlayHeadInOutAnim(nType)
  if nType == 0 then
    return
  end
  local tbHeadAnimData = {
    {
      0,
      1,
      -78,
      -78,
      "OutSine"
    },
    {
      1,
      1,
      -178,
      -78,
      "OutBack"
    },
    {
      1,
      0,
      -78,
      -78,
      "InSine"
    },
    {
      1,
      1,
      -78,
      -178,
      "InBack"
    }
  }
  local data = tbHeadAnimData[nType]
  local nAlpha_From = data[1]
  local nAlpha_To = data[2]
  local nPosY_From = data[3]
  local nPosY_To = data[4]
  local sEaseType = data[5]
  self._mapNode.canvasGroup_Head:DOKill()
  self._mapNode.rtHeadPos:DOKill()
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup_Head, nAlpha_From)
  self._mapNode.rtHeadPos.anchoredPosition = Vector2(-9, nPosY_From)
  if nAlpha_From ~= nAlpha_To then
    self._mapNode.canvasGroup_Head:DOFade(nAlpha_To, self.nHeadInOutAnimDuration):SetUpdate(true):SetEase(Ease[sEaseType])
  end
  if nPosY_From ~= nPosY_To then
    self._mapNode.rtHeadPos:DOAnchorPosY(nPosY_To, self.nHeadInOutAnimDuration):SetUpdate(true):SetEase(Ease[sEaseType])
  end
end

function Avg_4_TalkCtrl:_SwitchWaitingRoot(trParent)
  local rt = self._mapNode.rtWaiting
  if self.bWhite ~= nil then
    rt = self._mapNode.rtWaiting_White
  end
  rt:SetParent(trParent)
  rt.anchoredPosition = Vector2.zero
end

function Avg_4_TalkCtrl:_SetWaitingVisible(bVisible)
  if self.bInL2DTalk == true then
    bVisible = false
  end
  local rt = self._mapNode.rtWaiting
  if self.bWhite ~= nil then
    rt = self._mapNode.rtWaiting_White
  end
  rt.localScale = bVisible == true and Vector3.one or Vector3.zero
  EventManager.Hit(EventId.AvgLogBtnEnable, bVisible == true)
  if bVisible == true and type(self.tbPage) == "table" and self.nPageIndex == #self.tbPage and type(self.tbLogData) == "table" then
    EventManager.Hit(EventId.AvgMarkLog, self.tbLogData)
    self.tbLogData = nil
  end
end

function Avg_4_TalkCtrl:_ResetWaitingPos()
  local nX, nY, bCanScroll = 0, 0, false
  if type(self.tbPage) == "table" and type(self.nPageIndex) == "number" then
    local tbPageData = self.tbPage[self.nPageIndex]
    if type(tbPageData) == "table" then
      local sContent = tbPageData[1]
      local sType = tbPageData[2]
      if type(sContent) == "string" and sContent ~= "" and sType == "Paragraph" then
        local nSVFS_Width, nSVGS_Height = 1570, 519
        local tbSplit = string.split(sContent, "\n")
        local nLen = #tbSplit
        local sEndLineContent = tbSplit[nLen]
        NovaAPI.SetText_RubyTMP(self._mapNode.rubyTmp_FS_EndLine, sEndLineContent)
        LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtEndLine)
        nX = NovaAPI.AvgCalcTMPLastWordPos(self._mapNode.rubyTmp_FS_EndLine)
        if string.find(sEndLineContent, "<align=\"right\">") ~= nil then
          nX = nSVFS_Width
        elseif string.find(sEndLineContent, "<align=\"center\">") ~= nil then
          nX = (nSVFS_Width + nX) / 2
        end
        local sTotalContent = NovaAPI.GetText_RubyTMP(self._mapNode.rubyTmp_FS)
        NovaAPI.SetText_RubyTMP(self._mapNode.rubyTmp_FS_Total, sTotalContent)
        LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtTotal)
        nY = self._mapNode.rtTotal.rect.height
        bCanScroll = nSVGS_Height < nY
        if nSVGS_Height >= nY then
          nY = nSVGS_Height - nY
        else
          nY = 0
        end
      end
    end
  end
  self:_SetScrollable(bCanScroll)
  self._mapNode.rtWaiting_FS.anchoredPosition = Vector2(nX, nY)
end

function Avg_4_TalkCtrl:_SetScrollable(bEnable)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.canvasGroup_FS, bEnable == true)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.canvasGroup_FS, bEnable == true)
end

function Avg_4_TalkCtrl:_ProcParagraph(nDelayTime)
  if self.twDOText ~= nil then
    self.twDOText:Kill(false)
    self.twDOText = nil
  end
  local tbPageData = self.tbPage[self.nPageIndex]
  local sContent = tbPageData[1]
  local sType = tbPageData[2]
  self:_SetScrollable(false)
  NovaAPI.SetText_RubyTMP(self._mapNode.rubyTMP_ContentElement, self.sNone)
  if string.find(sContent, self.sAutoParagraphSignal) ~= nil then
    sContent = string.gsub(sContent, "<alpha=#FF>", self.sNone)
    local nDuration = tonumber(string.match(sContent, self.sAutoParagraphSignal))
    sContent = string.gsub(sContent, self.sAutoParagraphSignal, self.sNone)
    self.tbPage[self.nPageIndex][1] = sContent
    self.sContent = sContent
    self._mapNode.rtRubyTMP.anchoredPosition = Vector2(0, 2000)
    self.twDOText = DOTween.Sequence()
    local tw = self._mapNode.rtRubyTMP:DOAnchorPosX(255, 0.5):SetUpdate(true)
    tw.onUpdate = dotween_callback_handler(self, self._JointContentEx)
    self.twDOText:Append(tw)
    if 0 < nDuration then
      self.bExParagraph = true
      self.twDOText:AppendInterval(nDuration)
      self.twDOText:AppendCallback(dotween_callback_handler(self, self._ParagraphDoneEx))
    else
      self.twDOText:AppendInterval(nDuration * -1)
      self.twDOText:AppendCallback(dotween_callback_handler(self, self._ParagraphDone))
    end
    self.twDOText:SetUpdate(true)
  else
    self:_SetBtnEnable(true)
    self.twDOText = NovaAPI.DOText_RubyTMP(self._mapNode.rubyTMP_ContentElement, sContent, CalcTextAnimDuration(sContent, self._panel.nCurLanguageIdx))
    if self.twDOText ~= nil then
      self.twDOText:SetUpdate(true)
      self.twDOText.onUpdate = dotween_callback_handler(self, self._JointContent)
      self.twDOText.onComplete = dotween_callback_handler(self, self._ParagraphDone)
      if type(nDelayTime) == "number" then
        self.twDOText:SetDelay(nDelayTime)
      end
    elseif type(nDelayTime) == "number" then
      self.twDOText = TweenExtensions.DOWait(nDelayTime):SetUpdate(true)
      self.twDOText.onComplete = dotween_callback_handler(self, self._ParagraphDone)
    else
      self:_ParagraphDone()
    end
  end
end

function Avg_4_TalkCtrl:_JointContent()
  if self.curTMP ~= nil then
    NovaAPI.SetText_RubyTMP(self.curTMP, self.sPartialContent, self._mapNode.rubyTMP_ContentElement)
  end
end

function Avg_4_TalkCtrl:_ParagraphDone(n)
  self.twDOText = nil
  if self.bNeedWaitVoiceFinish == true and self.timerVoicePlayWaiting ~= nil then
    self:_SetBtnEnable(false)
    self:_SetScrollable(false)
    return
  end
  if self.tbPage == nil then
    return
  end
  local sType = self.tbPage[self.nPageIndex][2]
  self:_SetWaitingVisible(self.nPageIndex == #self.tbPage or sType == "Paragraph")
  self:_SetBtnEnable(sType == "Break" or sType == "Paragraph")
  if sType == "Wait" then
    self:_ProcAlphaCombine(false)
    self:_RunNextCmd()
  else
    if self.nCurTalkType == 10 and sType == "Paragraph" then
      self:_ResetWaitingPos()
    end
    if self.bIsAutoPlaying == true and self.bInL2DTalk ~= true and self.timerVoicePlayWaiting == nil then
      if n == nil then
        n = AUTO_PLAY_WAITING_DEFAULT
      end
      self:_StartTimerAutoPlayWaiting(n)
    end
  end
end

function Avg_4_TalkCtrl:_JointContentEx()
  if self.curTMP == nil then
    return
  end
  local sContent = self.sContent
  local sAlpha = string.format("<alpha=#%.2x>", math.floor(self._mapNode.rtRubyTMP.anchoredPosition.x))
  local mapReplacePair = {}
  for src in string.gmatch(sContent, "<color=#%x%x%x%x%x%x>") do
    mapReplacePair[src] = src .. sAlpha
  end
  for k, v in pairs(mapReplacePair) do
    sContent = string.gsub(sContent, k, v)
  end
  sContent = string.gsub(sContent, "</color>", "</color>" .. sAlpha)
  sContent = string.gsub(sContent, "</r>", "</r>" .. sAlpha)
  sContent = sAlpha .. sContent
  NovaAPI.SetText_RubyTMP(self._mapNode.rubyTMP_ContentElement, sContent)
  NovaAPI.SetText_RubyTMP(self.curTMP, self.sPartialContent, self._mapNode.rubyTMP_ContentElement)
end

function Avg_4_TalkCtrl:_ParagraphDoneEx()
  self.twDOText = nil
  if self.bNeedWaitVoiceFinish == true and self.timerVoicePlayWaiting ~= nil then
    return
  end
  self.bExParagraph = nil
  self:OnBtnClick_GoOn()
end

function Avg_4_TalkCtrl:_RunNextCmd(bForceByL2DAnimEvent)
  if self.bInL2DTalk == true and bForceByL2DAnimEvent ~= true then
    return
  end
  if self:GetPanelId() == PanelId.AvgST then
    self._panel:RUN()
  end
end

function Avg_4_TalkCtrl:_SubtitleDone(_timer, n)
  self.timerSubtitle = nil
  if self.bExParagraph == true then
    self.bExParagraph = nil
    self:OnBtnClick_GoOn()
    return
  end
  if self.bNeedWaitVoiceFinish == true and self.timerVoicePlayWaiting ~= nil then
    self:_SetBtnEnable(false)
    return
  end
  self:_SetBtnEnable(true)
  if self.bIsAutoPlaying == true and self.timerVoicePlayWaiting == nil then
    if n == nil then
      n = AUTO_PLAY_WAITING_DEFAULT
    end
    self:_StartTimerAutoPlayWaiting(n)
  end
end

function Avg_4_TalkCtrl:_ProcAlphaCombine(bAlpha)
  local sCurPageContent = self.tbPage[self.nPageIndex][1]
  if bAlpha == true then
    sCurPageContent = string.gsub(sCurPageContent, "<alpha=#FF>", self.sNone)
    local sAlpha = "<alpha=#7F>"
    local mapReplacePair = {}
    for src in string.gmatch(sCurPageContent, "<color=#%x%x%x%x%x%x>") do
      mapReplacePair[src] = src .. sAlpha
    end
    for k, v in pairs(mapReplacePair) do
      sCurPageContent = string.gsub(sCurPageContent, k, v)
    end
    sCurPageContent = string.gsub(sCurPageContent, "</color>", "</color>" .. sAlpha)
    sCurPageContent = string.gsub(sCurPageContent, "</r>", "</r>" .. sAlpha)
    sCurPageContent = sAlpha .. sCurPageContent
  end
  self.sPartialContent = self.sPartialContent .. sCurPageContent
end

function Avg_4_TalkCtrl:_ProcRubyPos(sContent)
  local mapRubyPos = {}
  for sFullRubyText in string.gmatch(sContent, "<r=.->.-</r>") do
    local sBaseText = string.gsub(sFullRubyText, "<r=.->", self.sNone)
    sBaseText = string.gsub(sBaseText, "</r>", self.sNone)
    local sRubyText = string.gsub(sFullRubyText, sBaseText, self.sNone)
    sRubyText = string.gsub(sRubyText, "</r>", self.sNone)
    sRubyText = string.gsub(sRubyText, "<r=", self.sNone)
    sRubyText = string.gsub(sRubyText, ">", self.sNone)
    local a, b = 0, 0
    local bSucc, nRPos1, nRPos2 = NovaAPI.GetRubyPos(self.curTMP, sBaseText, sRubyText, a, b)
    local sRpos = string.format("<rpos1=%f><rpos2=%f>", nRPos1, nRPos2)
    local sReplace = string.format("<r=%s>%s%s</r>", sRubyText, sRpos, sBaseText)
    mapRubyPos[sFullRubyText] = sReplace
    printLog(string.format("base:%s,ruby:%s,replace:%s", sBaseText, sRubyText, sReplace))
  end
  for k, v in pairs(mapRubyPos) do
    sContent = string.gsub(sContent, k, v)
  end
  return sContent
end

function Avg_4_TalkCtrl:_Ignore_PBW(sContent)
  sContent = string.gsub(sContent, self.sParagraphSignal, self.sNone)
  sContent = string.gsub(sContent, self.sBreakSignal, self.sNone)
  sContent = string.gsub(sContent, self.sWaitSignal, self.sNone)
  sContent = string.gsub(sContent, self.sAutoParagraphSignal, self.sNone)
  return sContent
end

function Avg_4_TalkCtrl:_ProcTmpPosY(sContent, bIsAsideTalk)
  if self.curTMP == nil or sContent == nil then
    return
  end
  local rtTmp = self.curTMP.gameObject:GetComponent("RectTransform")
  local nPosY = 90
  if bIsAsideTalk ~= true then
    local tb = string.split(sContent, "\n")
    if tb ~= nil and string.find(tb[1], "<r=") ~= nil then
      nPosY = 83
    end
  end
  rtTmp.anchoredPosition = Vector2(-632, nPosY)
end

function Avg_4_TalkCtrl:_CheckTalkContentTextIsDone()
  if self.bSubtitle == true then
    return self.timerSubtitle == nil
  end
  if self.twDOText ~= nil then
    return false
  end
  if type(self.tbPage) ~= "table" or type(self.nPageIndex) ~= "number" then
    return true
  end
  if type(self.tbPage[self.nPageIndex]) ~= "table" then
    return true
  end
  return self.nPageIndex == #self.tbPage or self.tbPage[self.nPageIndex][2] == "Paragraph"
end

function Avg_4_TalkCtrl:SetTalk(tbParam)
  local nType = tbParam[1]
  local sAvgCharId = tbParam[2]
  sAvgCharId = AdjustMainRoleAvgCharId(sAvgCharId)
  local sContent = ProcAvgTextContentFallback(self._panel.sTxtLan, self._panel.sVoLan, self._panel.bIsPlayerMale, tbParam[3], tbParam[7], tbParam[8], tbParam[9])
  self:_CheckLogBtnForceDisable(sContent)
  if string.find(sContent, self.sAutoParagraphSignal) ~= nil and nType ~= 8 and nType ~= 10 then
    sContent = "error: AutoParagraphSignal"
  end
  sContent = ProcAvgTextContent(sContent, self._panel.nCurLanguageIdx)
  local bMarkInLog = true
  if string.sub(sContent, 1, 12) == "_NOT_IN_LOG_" then
    sContent = string.gsub(sContent, "_NOT_IN_LOG_", "")
    bMarkInLog = false
  end
  if nType == 8 then
    local bCenterBgActive = string.find(sContent, self.sCenterBgOff) == nil
    self._mapNode.imgContentBg_Center:SetActive(bCenterBgActive)
    if bCenterBgActive ~= nil then
      sContent = string.gsub(sContent, self.sCenterBgOff, self.sNone)
    end
  end
  self.nClearType = tbParam[4]
  local sVoiceName = tbParam[5]
  self.bNeedWaitVoiceFinish = tbParam[6]
  local txtName, imgNameBg, canvasGroup, trWaitingParent, nDelayTime, bFixTmpPosY
  self.curTMP = nil
  self.bWhite = nil
  nDelayTime = self.nContentTextDelay_1
  self.bNeedPlayPageSound = false
  self.tbLogData = {}
  self.tbLogData.nType = AllEnum.AvgLogType.Talk
  self.tbLogData.sAvgId = sAvgCharId
  self.tbLogData.sVoice = sVoiceName
  self.tbLogData.sContent = sContent
  if nType == 0 then
    txtName = self._mapNode.txtName_Talk
    imgNameBg = self._mapNode.imgTalkNameBg
    canvasGroup = self._mapNode.canvasGroup_Talk
    self.curTMP = self._mapNode.rubyTmp_Talk
    trWaitingParent = self._mapNode.trWaiting_Talk
    bFixTmpPosY = true
  elseif nType == 1 or nType == 2 then
    canvasGroup = self._mapNode.canvasGroup_SayThink
    self.curTMP = self._mapNode.rubyTmp_SayThink
    trWaitingParent = self._mapNode.trWaiting_SayThink
    nDelayTime = self.nContentTextDelay_2
    if nType == 2 then
      self.tbLogData.nType = AllEnum.AvgLogType.Thought
    end
    self.tbLogData.sAvgId = sAvgCharId
  elseif nType == 3 then
    canvasGroup = self._mapNode.canvasGroup_Film
    self.curTMP = self._mapNode.rubyTmp_Film
    trWaitingParent = self.gameObject.transform
    self.bNeedPlayPageSound = true
  elseif nType == 4 then
    txtName = self._mapNode.txtName_Dialog_1L
    imgNameBg = self._mapNode.imgTalkNameBg_1L
    canvasGroup = self._mapNode.canvasGroup_Dialog_1L
    self.curTMP = self._mapNode.rubyTmp_1L
    trWaitingParent = self._mapNode.trWaiting_Dialog_1L
  elseif nType == 5 then
    txtName = self._mapNode.txtName_Dialog_1R
    imgNameBg = self._mapNode.imgTalkNameBg_1R
    canvasGroup = self._mapNode.canvasGroup_Dialog_1R
    self.curTMP = self._mapNode.rubyTmp_1R
    trWaitingParent = self._mapNode.trWaiting_Dialog_1R
  elseif nType == 6 then
    txtName = self._mapNode.txtName_Dialog_2L
    imgNameBg = self._mapNode.imgTalkNameBg_2L
    canvasGroup = self._mapNode.canvasGroup_Dialog_2L
    self.curTMP = self._mapNode.rubyTmp_2L
    trWaitingParent = self._mapNode.trWaiting_Dialog_2L
  elseif nType == 7 then
    txtName = self._mapNode.txtName_Dialog_2R
    imgNameBg = self._mapNode.imgTalkNameBg_2R
    canvasGroup = self._mapNode.canvasGroup_Dialog_2R
    self.curTMP = self._mapNode.rubyTmp_2R
    trWaitingParent = self._mapNode.trWaiting_Dialog_2R
  elseif nType == 8 then
    canvasGroup = self._mapNode.canvasGroup_Center
    self.curTMP = self._mapNode.rubyTmp_Center
    trWaitingParent = self.gameObject.transform
    self.tbLogData.nType = AllEnum.AvgLogType.Voiceover
  elseif nType == 9 then
    txtName = self._mapNode.txtName_CGTalk
    canvasGroup = self._mapNode.canvasGroup_CGTalk
    self.curTMP = self._mapNode.rubyTmp_CGTalk
    trWaitingParent = self._mapNode.trWaiting_CGTalk
    self.bWhite = true
  elseif nType == 10 then
    canvasGroup = self._mapNode.canvasGroup_FS
    self.curTMP = self._mapNode.rubyTmp_FS
    trWaitingParent = self._mapNode.rtWaiting_FS.transform
    self.bWhite = true
    self.tbLogData.nType = AllEnum.AvgLogType.Voiceover
  elseif nType == 11 then
    txtName = self._mapNode.txtName_CGTalk
    canvasGroup = self._mapNode.canvasGroup_CGTalk
    self.curTMP = self._mapNode.rubyTmp_CGTalk
    trWaitingParent = self._mapNode.trWaiting_CGTalk
    self.bInL2DTalk = true
    self.bWhite = true
  end
  canvasGroup.transform:SetAsLastSibling()
  self:ResetGamepadUI()
  self.nCurTalkType = nType
  if self.curCanvasGroup ~= nil and self.curCanvasGroup ~= canvasGroup then
    self.curCanvasGroup:DOFade(0, self.nContentBgFadeDuration):SetUpdate(true):SetEase(Ease.InSine)
    NovaAPI.SetCanvasGroupInteractable(self.curCanvasGroup, false)
    NovaAPI.SetCanvasGroupBlocksRaycasts(self.curCanvasGroup, false)
    self.curCanvasGroup = nil
  end
  if self.curCanvasGroup == nil then
    self.curCanvasGroup = canvasGroup
    self.curCanvasGroup:DOFade(1, self.nContentBgFadeDuration):SetUpdate(true):SetEase(Ease.OutSine)
    if nType == 1 or nType == 2 then
      self:_SwitchSayThink(nType, true)
    end
    NovaAPI.SetCanvasGroupInteractable(self.curCanvasGroup, true)
    NovaAPI.SetCanvasGroupBlocksRaycasts(self.curCanvasGroup, true)
  elseif nType == 1 or nType == 2 then
    self:_SwitchSayThink(nType, false)
  end
  self:_SwitchWaitingRoot(trWaitingParent)
  self:_SetWaitingVisible(false)
  if nType == 0 or nType == 3 or nType == 4 or nType == 5 or nType == 6 or nType == 7 or nType == 9 or nType == 11 then
    local sName, sColor = self._panel:GetAvgCharName(sAvgCharId)
    local bVisible = true
    if sAvgCharId == "0" then
      bVisible = false
      self.tbLogData.nType = AllEnum.AvgLogType.Voiceover
    end
    if sAvgCharId == "1" then
      sName = self._panel.sPlayerNickName
      self.tbLogData.sAvgId = AdjustMainRoleAvgCharId("avg3_100")
    end
    if txtName ~= nil then
      NovaAPI.SetTMPText(txtName, sName)
      if imgNameBg ~= nil then
        imgNameBg.gameObject:SetActive(bVisible)
      end
      if bVisible == true then
        local _b, _color = ColorUtility.TryParseHtmlString(sColor)
        if imgNameBg ~= nil then
          NovaAPI.SetImageColor(imgNameBg, _color)
        end
      end
    end
    if nType == 3 and sName ~= self.sNone then
      sContent = string.format("%s：%s", sName, sContent)
    end
  end
  if self:GetPanelId() == PanelId.AvgEditor then
    sContent = self:_Ignore_PBW(sContent)
    NovaAPI.SetText_RubyTMP(self.curTMP, sContent)
    return -1
  end
  NovaAPI.SetText_RubyTMP(self.curTMP, self.sNone)
  self.tbPage = {}
  self.bSubtitle = nType == 3 or nType == 8
  if nType == 3 or nType == 8 then
    local nDuration = CalcTextAnimDuration(sContent, self._panel.nCurLanguageIdx)
    self.bExParagraph = string.find(sContent, self.sAutoParagraphSignal) ~= nil
    if self.bExParagraph == true then
      nDuration = tonumber(string.match(sContent, self.sAutoParagraphSignal))
      sContent = string.gsub(sContent, self.sAutoParagraphSignal, self.sNone)
    end
    table.insert(self.tbPage, {sContent, "Subtitle"})
    self.nPageIndex = 1
    NovaAPI.SetText_RubyTMP(self.curTMP, sContent)
    self.timerSubtitle = self:AddTimer(1, nDuration, "_SubtitleDone", true, true, true)
    if bMarkInLog == true then
      EventManager.Hit(EventId.AvgMarkLog, self.tbLogData)
      self.tbLogData = nil
    end
  else
    if bFixTmpPosY == true then
      self:_ProcTmpPosY(sContent, sAvgCharId == "0")
    end
    local tb_P = string.split(sContent, self.sParagraphSignal)
    local nNumP = 0
    if tb_P ~= nil then
      nNumP = #tb_P
    end
    local sType
    for nIndexP = 1, nNumP do
      local sContentP = ""
      if tb_P ~= nil then
        sContentP = tb_P[nIndexP]
      end
      local tb_B = string.split(sContentP, self.sBreakSignal)
      local nNumB = 0
      if tb_B ~= nil then
        nNumB = #tb_B
      end
      for nIndexB = 1, nNumB do
        local sContentB = ""
        if tb_B ~= nil then
          sContentB = tb_B[nIndexB]
        end
        local tb_W = string.split(sContentB, self.sWaitSignal)
        local nNumW = 0
        if tb_W ~= nil then
          nNumW = #tb_W
        end
        for nIndexW = 1, nNumW do
          local sContentW = ""
          if tb_W ~= nil then
            sContentW = tb_W[nIndexW]
          end
          if 1 < nNumW and nIndexW < nNumW then
            sType = "Wait"
          elseif 1 < nNumB and nIndexB < nNumB then
            sType = "Break"
          else
            sType = "Paragraph"
          end
          if nType == 10 then
            sContentW = "<alpha=#FF>" .. sContentW
          end
          table.insert(self.tbPage, {sContentW, sType})
        end
      end
    end
    self.sPartialContent = self.sNone
    self.nPageIndex = 1
    self:_ProcParagraph(nDelayTime)
  end
  if type(sVoiceName) == "string" and sVoiceName ~= "" then
    self.bProcVoiceCallbackEvent = true
    WwiseAudioMgr:WwiseVoice_PlayInAVG(sVoiceName)
  end
  if bMarkInLog == true then
  else
    self.tbLogData = nil
  end
  return -1
end

function Avg_4_TalkCtrl:SetTalkShake(tbParam)
  self:_LoadPresetShake()
  local nTarget = tbParam[1]
  local sShakeType = tbParam[2]
  local nDuration = tbParam[3]
  local bWait = tbParam[4]
  local shakeTarget
  if nTarget == 0 then
    shakeTarget = self._mapNode.shake_Talk
  elseif nTarget == 1 then
    shakeTarget = self._mapNode.shake_SayThink
  elseif nTarget == 2 then
    shakeTarget = self._mapNode.shake_Dialog_1L
  elseif nTarget == 3 then
    shakeTarget = self._mapNode.shake_Dialog_1R
  elseif nTarget == 4 then
    shakeTarget = self._mapNode.shake_Dialog_2L
  elseif nTarget == 5 then
    shakeTarget = self._mapNode.shake_Dialog_2R
  end
  if shakeTarget ~= nil and sShakeType ~= nil and sShakeType ~= "none" then
    local tb = self.mapPresetShakeTalk[sShakeType]
    if type(tb) == "table" then
      NovaAPI.DoShakeEffect(shakeTarget, tb[1], tb[2], tb[3])
    else
      NovaAPI.StopShakeEffect(shakeTarget)
    end
  end
  if bWait == true and 0 < nDuration then
    return nDuration
  else
    return 0
  end
end

function Avg_4_TalkCtrl:SetGoOn(tbParam)
  if self.tbPage ~= nil and self.tbPage[self.nPageIndex][2] == "Wait" then
    self.nPageIndex = self.nPageIndex + 1
    self:_ProcParagraph()
    self:ResetGamepadUI()
  end
  return -1
end

function Avg_4_TalkCtrl:SetMainRoleTalk(tbParam)
  local nAnimType = tbParam[1]
  local nMaskVisible = tbParam[2]
  local sBody = tbParam[6]
  local sFace = tbParam[3]
  local sEmoji = tbParam[4]
  local sShakeType = tbParam[5]
  local nDuration = tbParam[7]
  local bWait = tbParam[8]
  local sAvgCharId = tbParam[9]
  if sAvgCharId == nil then
    sAvgCharId = "avg3_100"
  end
  self:ResetGamepadUI()
  self:_PlayHeadInOutAnim(nAnimType)
  local nMaskAlpha_End = 0.5
  if nMaskVisible == 0 then
    nMaskAlpha_End = 0
  end
  if NovaAPI.GetImageColor(self._mapNode.imgThinkMask).a ~= nMaskAlpha_End then
    local tw = NovaAPI.ImageDoFade(self._mapNode.imgThinkMask, nMaskAlpha_End, 0.25, true)
    if nAnimType == 3 then
      tw:SetDelay(self.nHeadInOutAnimDuration - self.nContentBgFadeDuration)
    end
  end
  if nAnimType == 0 then
    EventManager.Hit(EventId.AvgMainRoleTalk_Switch, sAvgCharId, sBody, sFace)
  elseif nAnimType == 1 or nAnimType == 2 then
    EventManager.Hit(EventId.AvgMainRoleTalk_Set, self._mapNode.rtHeadPos, sAvgCharId, sBody, sFace)
  elseif nAnimType == 3 or nAnimType == 4 then
    EventManager.Hit(EventId.AvgMainRoleTalk_Reset, sAvgCharId, self.nHeadInOutAnimDuration)
  end
  EventManager.Hit(EventId.AvgMainRoleTalk_SetEmoji, sAvgCharId, sEmoji, true)
  EventManager.Hit(EventId.AvgMainRoleTalk_Shake, sAvgCharId, sShakeType)
  if bWait == true and 0 < nDuration then
    return nDuration
  else
    return 0
  end
end

function Avg_4_TalkCtrl:SetCameraAperture(tbParam)
  local bVisible = tbParam[1]
  if bVisible == true then
    self._mapNode.trCameraAperture.localScale = Vector3.one
  else
    self._mapNode.trCameraAperture.localScale = Vector3.zero
  end
  return 0
end

function Avg_4_TalkCtrl:OnEvent_AVG_SetCameraAperture(nCloseOpen, nDuration, bWait)
  local nTarget = 0
  if nCloseOpen == 0 then
    nTarget = 0
  else
    nTarget = 1
  end
  if bWait == true and 0 < nDuration then
    NovaAPI.SetCanvasGroupDoFade(self._mapNode.cg_CameraAperture, nTarget, nDuration, true)
  else
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.cg_CameraAperture, nTarget)
  end
end

function Avg_4_TalkCtrl:RestoreAll(bActive, tbHistoryData)
  self.gameObject.transform.localScale = bActive == true and Vector3.one or Vector3.zero
  if bActive == false then
    self.mapPresetShakeChar = nil
    self.mapPresetShakeTalk = nil
  end
  self:_SetBtnEnable(false)
  self:_SetWaitingVisible(false)
  self.curCanvasGroup = nil
  self.curTMP = nil
  self.bWhite = nil
  self.tbPage = nil
  self.sPartialContent = self.sNone
  self.nPageIndex = nil
  NovaAPI.SetText_RubyTMP(self._mapNode.rubyTMP_ContentElement, self.sNone)
  local nType = tbHistoryData.nType
  local sAvgCharId = tbHistoryData.sAvgCharId
  local sContent = tbHistoryData.sContent
  local nClearType = tbHistoryData.nClearType
  local sBody = tbHistoryData.sBody
  local sFace = tbHistoryData.sFace
  local sEmoji = tbHistoryData.sEmoji
  local nMaskVisible = tbHistoryData.nMaskVisible
  local colorMask = NovaAPI.GetImageColor(self._mapNode.imgThinkMask)
  local nAlpha = 0
  if nMaskVisible == 1 then
    nAlpha = 0.5
  end
  NovaAPI.SetImageColor(self._mapNode.imgThinkMask, Color(colorMask.r, colorMask.g, colorMask.b, nAlpha))
  if sBody ~= nil and sFace ~= nil and (sAvgCharId == "avg3_100" or sAvgCharId == "avg3_101" or sAvgCharId == "avg4_999") then
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup_Head, 1)
    EventManager.Hit(EventId.AvgMainRoleTalk_Set, self._mapNode.rtHeadPos, sAvgCharId, sBody, sFace)
    self._mapNode.rtHeadPos.anchoredPosition = Vector2(-9, -78)
  else
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup_Head, 0)
    EventManager.Hit(EventId.AvgMainRoleTalk_Reset, sAvgCharId, 0)
    self._mapNode.rtHeadPos.anchoredPosition = Vector2(-9, -178)
  end
  EventManager.Hit(EventId.AvgMainRoleTalk_SetEmoji, sAvgCharId, sEmoji, false)
  if nType == -1 then
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup_Talk, 0)
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup_SayThink, 0)
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup_Film, 0)
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup_Dialog_1L, 0)
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup_Dialog_1R, 0)
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup_Dialog_2L, 0)
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup_Dialog_2R, 0)
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup_Center, 0)
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup_CGTalk, 0)
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup_FS, 0)
    return
  end
  if sContent ~= self.sNone then
    sContent = ProcAvgTextContent(sContent, self._panel.nCurLanguageIdx)
    sContent = self:_Ignore_PBW(sContent)
    local txtName, imgNameBg
    local sName, sColor = self._panel:GetAvgCharName(sAvgCharId)
    if nType == 0 then
      self.curCanvasGroup = self._mapNode.canvasGroup_Talk
      self.curTMP = self._mapNode.rubyTmp_Talk
      txtName = self._mapNode.txtName_Talk
      imgNameBg = self._mapNode.imgTalkNameBg
    elseif nType == 1 or nType == 2 then
      self.curCanvasGroup = self._mapNode.canvasGroup_SayThink
      self.curTMP = self._mapNode.rubyTmp_SayThink
      self:_SwitchSayThink(nType, true)
    elseif nType == 3 then
      self.curCanvasGroup = self._mapNode.canvasGroup_Film
      self.curTMP = self._mapNode.rubyTmp_Film
      if sName ~= self.sNone then
        sContent = string.format("%s：%s", sName, sContent)
      end
    elseif nType == 4 then
      self.curCanvasGroup = self._mapNode.canvasGroup_Dialog_1L
      self.curTMP = self._mapNode.rubyTmp_1L
      txtName = self._mapNode.txtName_Dialog_1L
      imgNameBg = self._mapNode.imgTalkNameBg_1L
    elseif nType == 5 then
      self.curCanvasGroup = self._mapNode.canvasGroup_Dialog_1R
      self.curTMP = self._mapNode.rubyTmp_1R
      txtName = self._mapNode.txtName_Dialog_1R
      imgNameBg = self._mapNode.imgTalkNameBg_1R
    elseif nType == 6 then
      self.curCanvasGroup = self._mapNode.canvasGroup_Dialog_2L
      self.curTMP = self._mapNode.rubyTmp_2L
      txtName = self._mapNode.txtName_Dialog_2L
      imgNameBg = self._mapNode.imgTalkNameBg_2L
    elseif nType == 7 then
      self.curCanvasGroup = self._mapNode.canvasGroup_Dialog_2R
      self.curTMP = self._mapNode.rubyTmp_2R
      txtName = self._mapNode.txtName_Dialog_2R
      imgNameBg = self._mapNode.imgTalkNameBg_2R
    elseif nType == 8 then
      self.curCanvasGroup = self._mapNode.canvasGroup_Center
      self.curTMP = self._mapNode.rubyTmp_Center
    elseif nType == 9 then
      txtName = self._mapNode.txtName_CGTalk
      self.curCanvasGroup = self._mapNode.canvasGroup_CGTalk
      self.curTMP = self._mapNode.rubyTmp_CGTalk
    elseif nType == 10 then
      self.curCanvasGroup = self._mapNode.canvasGroup_FS
      self.curTMP = self._mapNode.rubyTmp_FS
    end
    NovaAPI.SetCanvasGroupAlpha(self.curCanvasGroup, 1)
    NovaAPI.SetText_RubyTMP(self.curTMP, sContent)
    if txtName ~= nil then
      local bVisible = true
      if sAvgCharId == "0" then
        bVisible = false
      end
      if sAvgCharId == "1" then
        sName = self._panel.sPlayerNickName
      end
      if txtName ~= nil then
        NovaAPI.SetTMPText(txtName, sName)
        if imgNameBg ~= nil then
          imgNameBg.gameObject:SetActive(bVisible)
        end
        if bVisible == true then
          local _b, _color = ColorUtility.TryParseHtmlString(sColor)
          if imgNameBg ~= nil then
            NovaAPI.SetImageColor(imgNameBg, _color)
          end
        end
      end
    end
  end
end

function Avg_4_TalkCtrl:AddGamepadUINode()
  GamepadUIManager.AddGamepadUINode("AVG", self:GetGamepadUINode())
end

function Avg_4_TalkCtrl:ResetGamepadUI()
  self._panel.sCurGamepadUI = "Talk"
  GamepadUIManager.ClearSelectedUI()
  GamepadUIManager.SetSelectedUI(self._mapNode.btnShortcutClickToGoOn.gameObject)
  local tbConfig = {
    {
      sAction = "Confirm",
      sLang = "ActionBar_NextDialogue"
    }
  }
  EventManager.Hit(EventId.AvgRefreshActionBar, tbConfig)
end

function Avg_4_TalkCtrl:OnEvent_GamepadUIChange(sName, nBeforeType, nAfterType)
  if sName ~= "AVG" then
    return
  end
  if self._panel.sCurGamepadUI ~= "Talk" then
    return
  end
  GamepadUIManager.ClearSelectedUI()
  GamepadUIManager.SetSelectedUI(self._mapNode.btnShortcutClickToGoOn.gameObject)
end

function Avg_4_TalkCtrl:OnEvent_Reopen(sName)
  if sName ~= "AVG" or self._panel.sCurGamepadUI ~= "Talk" then
    return
  end
  GamepadUIManager.SetSelectedUI(self._mapNode.btnShortcutClickToGoOn.gameObject)
end

return Avg_4_TalkCtrl
