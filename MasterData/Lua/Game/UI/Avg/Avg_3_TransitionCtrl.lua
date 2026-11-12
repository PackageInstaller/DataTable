local Avg_3_TransitionCtrl = class("Avg_3_TransitionCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
Avg_3_TransitionCtrl._mapNodeConfig = {
  AVProVideoGUI = {},
  rtFilmMode = {
    sNodeName = "----film_mode----",
    sComponentName = "RectTransform"
  },
  rtUpMask = {
    sNodeName = "imgUpMask",
    sComponentName = "RectTransform"
  },
  rtDownMask = {
    sNodeName = "imgDownMask",
    sComponentName = "RectTransform"
  },
  imgCurtain = {sComponentName = "Image"},
  eft = {
    sNodeName = "imgCurtain",
    sComponentName = "UIEffectAndTransition"
  },
  tbAvgTrans = {nCount = 6, sNodeName = "AvgTrans_"},
  tbAvgTransAnim = {
    nCount = 6,
    sNodeName = "AvgTrans_",
    sComponentName = "Animator"
  },
  goWordTrans = {},
  animWordTrans = {
    sNodeName = "goWordTrans",
    sComponentName = "Animator"
  },
  tmpWordTrans_L = {sComponentName = "TMP_Text"},
  tmpWordTrans_R = {sComponentName = "TMP_Text"}
}
Avg_3_TransitionCtrl._mapEventConfig = {
  [EventId.AvgClearStage] = "OnEvent_Clear",
  [EventId.AvgSpeedUp] = "OnEvent_AvgSpeedUp"
}

function Avg_3_TransitionCtrl:Awake()
  self.nFilmHeight = 0
  self.canvas = self.gameObject:GetComponent("Canvas")
end

function Avg_3_TransitionCtrl:OnEnable()
  if self:GetPanelId() == PanelId.AvgST then
    if self.AVProVideoGUICtrl ~= nil then
      self:UnbindCtrlByNode(self.AVProVideoGUICtrl)
      self.AVProVideoGUICtrl = nil
    end
    self.AVProVideoGUICtrl = self:BindCtrlByNode(self._mapNode.AVProVideoGUI, "Game.UI.AVProVideo.AVProVideoGUICtrl")
  end
end

function Avg_3_TransitionCtrl:OnDisable()
  if self:GetPanelId() == PanelId.AvgST and self.AVProVideoGUICtrl ~= nil then
    self:UnbindCtrlByNode(self.AVProVideoGUICtrl)
    self.AVProVideoGUICtrl = nil
  end
end

function Avg_3_TransitionCtrl:OnEvent_Clear()
  if self:GetPanelId() == PanelId.AvgEditor then
    return
  end
  self:SetFilm({
    1,
    "Linear",
    0,
    false
  })
  for i = 0, 4 do
    self:SetTrans({
      1,
      i,
      "0",
      "Linear",
      false,
      false,
      0,
      false,
      "default"
    })
  end
end

function Avg_3_TransitionCtrl:OnEvent_AvgSpeedUp(nRate)
  if self:GetPanelId() ~= PanelId.AvgST then
    return
  end
  self:OnEvent_AvgSpeedUp_Timer(nRate)
  for index, value in ipairs(self._mapNode.tbAvgTransAnim) do
    NovaAPI.SetAnimatorSpeed(value, nRate)
  end
  NovaAPI.SetAnimatorSpeed(self._mapNode.animWordTrans, nRate)
end

function Avg_3_TransitionCtrl:_CalcFilmBlackEdgeHeight()
  if self.nFilmHeight <= 0 then
    local nPercent = (1 - 808 / Settings.DESIGN_SCREEN_RESOLUTION_HEIGHT) / 2
    self.nFilmHeight = self._mapNode.rtFilmMode.rect.height * nPercent
  end
end

function Avg_3_TransitionCtrl:_LoadPreset_Transition()
  if self.mapPresetTransition == nil then
    self.mapPresetTransition = {}
    for i, v in ipairs(self._panel.tbAvgPreset.Transition) do
      local sKeyName = v[1]
      local tbData = v[2]
      self.mapPresetTransition[sKeyName] = tbData
    end
  end
end

function Avg_3_TransitionCtrl:_SetUIEffectAndTransition(sKeyName)
  if sKeyName == nil then
    sKeyName = "default"
  end
  local tbEftData = self.mapPresetTransition[sKeyName]
  if tbEftData == nil then
    tbEftData = self.mapPresetTransition.default
  end
  NovaAPI.SetUIEffectAndTransition(self._mapNode.eft, tbEftData[1], tbEftData[2], tbEftData[3])
  local sName = tbEftData[4]
  return sName
end

function Avg_3_TransitionCtrl:SetFilm(tbParam)
  self:_CalcFilmBlackEdgeHeight()
  local bIn = tbParam[1]
  local sEaseType = tbParam[2]
  local nDuration = tbParam[3]
  local bWait = tbParam[4]
  if bIn == 0 then
    self._mapNode.rtFilmMode.gameObject:SetActive(true)
  end
  local v2Start = bIn == 0 and Vector2.zero or Vector2(0, self.nFilmHeight)
  local v2End = bIn == 0 and Vector2(0, self.nFilmHeight) or Vector2.zero
  self._mapNode.rtUpMask.sizeDelta = v2Start
  self._mapNode.rtDownMask.sizeDelta = v2Start
  self._mapNode.rtUpMask:DOSizeDelta(v2End, nDuration):SetUpdate(true):SetEase(Ease[sEaseType])
  local tweener = self._mapNode.rtDownMask:DOSizeDelta(v2End, nDuration):SetUpdate(true):SetEase(Ease[sEaseType])
  if bIn ~= 0 then
    local function _cb()
      self._mapNode.rtFilmMode.gameObject:SetActive(false)
    end
    
    tweener.onComplete = dotween_callback_handler(self, _cb)
  end
  if bWait == true and 0 < nDuration then
    return nDuration
  else
    return 0
  end
end

function Avg_3_TransitionCtrl:SetTrans(tbParam)
  self:_LoadPreset_Transition()
  local nCloseOpen = tbParam[1]
  local nStyle = tbParam[2]
  local sEftName = tbParam[3]
  local sEaseType = tbParam[4]
  local bClearAllChar = tbParam[5]
  local bClearAllTalk = tbParam[6]
  local nDuration = tbParam[7]
  local bWait = tbParam[8]
  local sKeyName = tbParam[9]
  local nDurationForCameraAperture = nDuration
  local nColorRGB = 0
  if nStyle == 1 then
    nColorRGB = 1
  end
  if nStyle == 0 or nStyle == 1 then
    for i, v in ipairs(self._mapNode.tbAvgTrans) do
      v:SetActive(false)
    end
    local tweener
    if sEftName == "0" then
      self._mapNode.eft.enabled = false
      if nCloseOpen == 0 then
        self._mapNode.imgCurtain.gameObject:SetActive(true)
        if 0 < nDuration then
          NovaAPI.SetImageColor(self._mapNode.imgCurtain, Color(nColorRGB, nColorRGB, nColorRGB, 0))
          tweener = NovaAPI.ImageDoColor(self._mapNode.imgCurtain, Color(nColorRGB, nColorRGB, nColorRGB, 1), nDuration, false)
        else
          NovaAPI.SetImageColor(self._mapNode.imgCurtain, Color(nColorRGB, nColorRGB, nColorRGB, 1))
        end
      elseif 0 < nDuration then
        NovaAPI.SetImageColor(self._mapNode.imgCurtain, Color(nColorRGB, nColorRGB, nColorRGB, 1))
        tweener = NovaAPI.ImageDoColor(self._mapNode.imgCurtain, Color(nColorRGB, nColorRGB, nColorRGB, 0), nDuration, false)
      else
        NovaAPI.SetImageColor(self._mapNode.imgCurtain, Color(nColorRGB, nColorRGB, nColorRGB, 0))
      end
    else
      self._mapNode.eft.enabled = true
      local sEftPngName = self:_SetUIEffectAndTransition(sKeyName)
      if sEftPngName ~= nil and sEftPngName ~= "" then
        sEftName = sEftPngName
      end
      NovaAPI.SetImageColor(self._mapNode.imgCurtain, Color(nColorRGB, nColorRGB, nColorRGB, 1))
      self._mapNode.eft.transitionTexture = self:GetAvgStageEffect(sEftName)
      if nCloseOpen == 0 then
        self._mapNode.imgCurtain.gameObject:SetActive(true)
        if 0 < nDuration then
          self._mapNode.eft.effectFactorTr = 1
          tweener = self._mapNode.eft:DOEffectAndTransitionFade(0, nDuration)
        else
          self._mapNode.eft.effectFactorTr = 0
        end
      elseif 0 < nDuration then
        self._mapNode.eft.effectFactorTr = 0
        tweener = self._mapNode.eft:DOEffectAndTransitionFade(1, nDuration)
      else
        self._mapNode.eft.effectFactorTr = 1
      end
    end
    if tweener ~= nil then
      tweener:SetUpdate(true)
      tweener:SetEase(Ease[sEaseType])
    end
    if nCloseOpen ~= 0 then
      if tweener ~= nil then
        local function _cb()
          self._mapNode.eft.transitionTexture = nil
          
          self._mapNode.eft.enabled = false
          self._mapNode.imgCurtain.gameObject:SetActive(false)
        end
        
        tweener.onComplete = dotween_callback_handler(self, _cb)
      else
        self._mapNode.eft.transitionTexture = nil
        self._mapNode.eft.enabled = false
        self._mapNode.imgCurtain.gameObject:SetActive(false)
      end
    end
  else
    nStyle = nStyle - 1
    self._mapNode.imgCurtain.gameObject:SetActive(false)
    for i, v in ipairs(self._mapNode.tbAvgTrans) do
      v:SetActive(nStyle == i)
    end
    local sTriggerName = "tIn"
    local tbData = {
      [1] = {
        [0] = 0.6,
        [1] = 0.267
      },
      [2] = {
        [0] = 0.5,
        [1] = 0.4
      },
      [3] = {
        [0] = 1.167,
        [1] = 0.8
      },
      [4] = {
        [0] = 0.267,
        [1] = 0.4
      },
      [5] = {
        [0] = 0.767,
        [1] = 0.7
      },
      [6] = {
        [0] = 0.4,
        [1] = 0.5
      }
    }
    if nCloseOpen ~= 0 then
      sTriggerName = "tOut"
    end
    self._mapNode.tbAvgTransAnim[nStyle]:SetTrigger(sTriggerName)
    nDuration = tbData[nStyle][nCloseOpen]
    bWait = true
  end
  if 0 < nDuration then
    self:AddTimer(1, nDuration, "_Done", true, true, true, {bClearAllChar, nCloseOpen})
  else
    self:_Done(nil, {bClearAllChar, nCloseOpen})
  end
  if bClearAllTalk == true then
    EventManager.Hit(EventId.AvgClearTalk)
  end
  EventManager.Hit("AVG_SetCameraAperture", nCloseOpen, nDurationForCameraAperture, bWait)
  if bWait == true and 0 < nDuration then
    return nDuration
  else
    return 0
  end
end

function Avg_3_TransitionCtrl:_Done(timer, tbParam)
  if tbParam == nil then
    return
  end
  local bClearAllChar = tbParam[1]
  local nCloseOpen = tbParam[2]
  if bClearAllChar == true then
    EventManager.Hit(EventId.AvgClearAllChar)
  end
  if nCloseOpen ~= 0 then
    for i, v in ipairs(self._mapNode.tbAvgTrans) do
      v:SetActive(false)
    end
  end
end

function Avg_3_TransitionCtrl:SetWordTrans(tbParam)
  local sContent = tbParam[1]
  local nDuration = tbParam[2]
  local bWait = tbParam[3]
  sContent = ProcAvgTextContent(sContent, self._panel.nCurLanguageIdx)
  NovaAPI.SetTMPText(self._mapNode.tmpWordTrans_L, sContent)
  NovaAPI.SetTMPText(self._mapNode.tmpWordTrans_R, sContent)
  self._mapNode.goWordTrans:SetActive(true)
  local nAnimLen = NovaAPI.GetAnimClipLength(self._mapNode.animWordTrans, {
    "wordTrans_in"
  })
  if nDuration <= 0 then
    nDuration = nAnimLen
  end
  self._mapNode.animWordTrans:Play("wordTrans_in")
  self:AddTimer(1, nAnimLen, "_WordTransDone", true, true, true)
  local tbLogData = {}
  tbLogData.nType = AllEnum.AvgLogType.Voiceover
  tbLogData.sAvgId = "0"
  tbLogData.sVoice = ""
  tbLogData.sContent = sContent
  EventManager.Hit(EventId.AvgMarkLog, tbLogData)
  if bWait == true and 0 < nDuration then
    return nDuration
  else
    return 0
  end
end

function Avg_3_TransitionCtrl:_WordTransDone()
  self._mapNode.goWordTrans:SetActive(false)
end

function Avg_3_TransitionCtrl:PlayVideo(tbParam)
  EventManager.Hit(EventId.AvgResetSpeed, true)
  EventManager.Hit(EventId.AvgAllMenuBtnEnable, false)
  EventManager.Hit(EventId.AvgClearTalk)
  EventManager.Hit(EventId.AvgClearAllChar)
  EventManager.Hit(EventId.AvgClearStage)
  WwiseAudioMgr:WwiseVoice_StopInAVG()
  GamepadUIManager.ClearSelectedUI()
  WwiseAudioMgr:PostEvent("avg_track1_stop")
  WwiseAudioMgr:PostEvent("avg_track2_stop")
  WwiseAudioMgr:PostEvent("avg_sfx_all_stop")
  self.nCurOrder = NovaAPI.GetCanvasSortingOrder(self.canvas)
  NovaAPI.SetCanvasSortingOrder(self.canvas, AllEnum.UI_SORTING_ORDER.ProVideo)
  if self.tbTransForVideo == nil then
    self.tbTransForVideo = {}
  end
  self.tbTransForVideo[1] = 0
  self.tbTransForVideo[2] = tbParam[1]
  self.tbTransForVideo[3] = tbParam[2]
  self.tbTransForVideo[4] = tbParam[3]
  self.tbTransForVideo[9] = tbParam[4]
  self.tbTransForVideo[5] = tbParam[5]
  self.tbTransForVideo[6] = tbParam[6]
  self.tbTransForVideo[7] = tbParam[7]
  self.tbTransForVideo[8] = true
  local nDuration = self:SetTrans(self.tbTransForVideo)
  self:AddTimer(1, nDuration, "_PlayVideoStart", true, true, true, tbParam[8])
  return -1
end

function Avg_3_TransitionCtrl:_PlayVideoStart(timer, sVideoResName)
  if type(self.tbTransForVideo) == "table" and #self.tbTransForVideo > 0 and self.tbTransForVideo[1] == 0 then
    EventManager.Add("VIDEO_START", self, self.OnEvent_VideoStart)
    EventManager.Add("VIDEO_FINISHED", self, self.OnEvent_VideoFinished)
    local nColor = self.tbTransForVideo[2] == 1 and 1 or 0
    self.AVProVideoGUICtrl:SetParam({
      sVideoResName,
      false,
      0,
      true,
      0.2,
      true,
      false,
      true,
      nColor
    }, true)
    self.AVProVideoGUICtrl:FadeIn()
  end
end

function Avg_3_TransitionCtrl:OnEvent_VideoStart()
  EventManager.Remove("VIDEO_START", self, self.OnEvent_VideoStart)
  if type(self.tbTransForVideo) == "table" and #self.tbTransForVideo > 0 and self.tbTransForVideo[1] == 0 then
    self.tbTransForVideo[1] = 1
    self.tbTransForVideo[5] = false
    self.tbTransForVideo[6] = false
    self:SetTrans(self.tbTransForVideo)
  end
end

function Avg_3_TransitionCtrl:OnEvent_VideoFinished()
  EventManager.Remove("VIDEO_FINISHED", self, self.OnEvent_VideoFinished)
  if type(self.tbTransForVideo) == "table" and #self.tbTransForVideo > 0 then
    self.tbTransForVideo[1] = 0
    local nDuration = self:SetTrans(self.tbTransForVideo)
    self:AddTimer(1, nDuration, "_PlayVideoEnd", true, true, true)
  end
end

function Avg_3_TransitionCtrl:_PlayVideoEnd()
  if type(self.tbTransForVideo) == "table" and #self.tbTransForVideo > 0 and self.tbTransForVideo[1] == 0 then
    self.AVProVideoGUICtrl:SetParam(nil, false)
    self.tbTransForVideo[1] = 1
    local nDuration = self:SetTrans(self.tbTransForVideo)
    self:AddTimer(1, nDuration, "_GoOn", true, true, true)
    if self:GetPanelId() == PanelId.AvgST then
      self._panel:RUN()
    end
  end
end

function Avg_3_TransitionCtrl:_GoOn()
  self.tbTransForVideo = nil
  NovaAPI.SetCanvasSortingOrder(self.canvas, self.nCurOrder)
  EventManager.Hit(EventId.AvgResetSpeed, false)
  EventManager.Hit(EventId.AvgAllMenuBtnEnable, true)
end

function Avg_3_TransitionCtrl:RestoreAll(bActive, tbHistoryData)
  self:_CalcFilmBlackEdgeHeight()
  self.gameObject:SetActive(bActive)
  local nFilmIn = tbHistoryData.nFilmIn
  local v2End = nFilmIn == 0 and Vector2(0, self.nFilmHeight) or Vector2.zero
  self._mapNode.rtUpMask.sizeDelta = v2End
  self._mapNode.rtDownMask.sizeDelta = v2End
  self._mapNode.rtFilmMode.gameObject:SetActive(nFilmIn == 0)
  local bTransIn = tbHistoryData.bTransIn
  local nTransStyle = tbHistoryData.nTransStyle
  self._mapNode.eft.transitionTexture = nil
  if bTransIn == 0 then
    if nTransStyle == 0 or nTransStyle == 1 then
      self._mapNode.imgCurtain.gameObject:SetActive(true)
      self._mapNode.eft.enabled = true
      NovaAPI.SetImageColor(self._mapNode.imgCurtain, Color(nTransStyle, nTransStyle, nTransStyle, 1))
      self._mapNode.eft.effectFactorTr = 0
    else
      self._mapNode.imgCurtain.gameObject:SetActive(false)
      self._mapNode.eft.enabled = false
      self._mapNode.eft.effectFactorTr = 1
      nTransStyle = nTransStyle - 1
      for i, v in ipairs(self._mapNode.tbAvgTrans) do
        v:SetActive(nTransStyle == i)
        if nTransStyle == i then
          self._mapNode.tbAvgTransAnim[i]:CrossFade("Base Layer.in", 0, -1, 1, 0)
        end
      end
    end
  else
    self._mapNode.imgCurtain.gameObject:SetActive(false)
    self._mapNode.eft.enabled = false
    NovaAPI.SetImageColor(self._mapNode.imgCurtain, Color.black)
    self._mapNode.eft.effectFactorTr = 1
    for i, v in ipairs(self._mapNode.tbAvgTrans) do
      v:SetActive(false)
    end
  end
  if bActive == false then
    self.nFilmHeight = 0
  end
end

return Avg_3_TransitionCtrl
