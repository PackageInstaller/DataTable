local AVProVideoGUICtrl = class("AVProVideoGUICtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local PlayerData = require("GameCore.Data.PlayerData")
AVProVideoGUICtrl._mapNodeConfig = {
  PlayerVideo = {},
  cg_a = {
    sNodeName = "canvas_group_a",
    sComponentName = "CanvasGroup"
  },
  img_back = {sComponentName = "Image"},
  btnSkip = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Skip",
    sAction = "Skip"
  },
  cg_b = {
    sNodeName = "canvas_group_b",
    sComponentName = "CanvasGroup"
  },
  img_front = {sComponentName = "Image"}
}
AVProVideoGUICtrl._mapEventConfig = {
  CS2LUA_Video_FirstFrameReady = "OnEvent_VideoFirstFrameReady",
  CS2LUA_Video_Finished = "OnEvent_VideoFinished"
}

function AVProVideoGUICtrl:Awake()
  self.tbGamepadUINode = self:GetGamepadUINode()
  if not GamepadUIManager.GetInputState() then
    for _, v in pairs(self.tbGamepadUINode) do
      if v.sComponentName == "NaviButton" then
        NovaAPI.SetNaviButtonAction(v.mapNode, false)
      end
    end
  end
  self.sVideoFileName = ""
  self.bTrans = true
  self.nTransDuration = 0.2
  self.bFade = true
  self.nFadeDuration = 0.2
  self.bSkipable = true
  self.bEndTrans = true
  self.bEndFade = true
  local tbParam = self:GetPanelParam()
  self:SetParam(tbParam)
  self.nVideoDuration = 10
  self.timerVideo = nil
  self.nOffset = 0.2
end

function AVProVideoGUICtrl:SetParam(tbParam, bActive)
  if type(bActive) == "boolean" then
    self.gameObject:SetActive(bActive == true)
    self.bInAvg = true
    if self.bAddedInAvg ~= true then
      self.bAddedInAvg = true
      GamepadUIManager.AddGamepadUINode("AVG", self.tbGamepadUINode)
    end
  end
  if type(tbParam) == "table" then
    if type(tbParam[1]) == "string" and tbParam[1] ~= "" then
      self.sVideoFileName = tbParam[1]
    end
    if type(tbParam[2]) == "boolean" then
      self.bTrans = tbParam[2]
    end
    if type(tbParam[3]) == "number" then
      self.nTransDuration = tbParam[3]
    end
    if type(tbParam[4]) == "boolean" then
      self.bFade = tbParam[4]
    end
    if type(tbParam[5]) == "number" then
      self.nFadeDuration = tbParam[5]
    end
    if type(tbParam[6]) == "boolean" then
      self.bSkipable = tbParam[6]
    end
    if type(tbParam[7]) == "boolean" then
      self.bEndTrans = tbParam[7]
    else
      self.bEndTrans = self.bTrans
    end
    if type(tbParam[8]) == "boolean" then
      self.bEndFade = tbParam[8]
    else
      self.bEndFade = self.bFade
    end
    if type(tbParam[9]) == "number" then
      local nColor = tbParam[9]
      NovaAPI.SetImageColor(self._mapNode.img_front, nColor == 1 and Color.white or Color.black)
    end
  end
end

function AVProVideoGUICtrl:FadeIn()
  if self:GetPanelId() == PanelId.AvgEditor then
    return
  end
  if self:GetPanelId() == PanelId.AvgST and self.bInAvg ~= true then
    return
  end
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.cg_a, true)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cg_a, true)
  self._mapNode.btnSkip.gameObject:SetActive(false)
  if self.bTrans == true then
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.cg_a, 0)
    NovaAPI.SetCanvasGroupInteractable(self._mapNode.cg_b, true)
    NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cg_b, true)
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.cg_b, 0)
    NovaAPI.SetCanvasGroupDoFade(self._mapNode.cg_b, 1, self.nTransDuration, true)
    self:AddTimer(1, self.nTransDuration + self.nOffset, self.START, true, true, true)
  else
    self:START()
  end
end

function AVProVideoGUICtrl:START()
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cg_a, 1)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.cg_b, false)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cg_b, false)
  if self.bFade == true then
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.cg_b, 1)
    NovaAPI.SetCanvasGroupDoFade(self._mapNode.cg_b, 0, self.nFadeDuration, true)
  else
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.cg_b, 0)
  end
  local tbVideoFile, tbSoundTrack, tbSrtFile = self:ParseFileName()
  NovaAPI.PlayVideo(self._mapNode.PlayerVideo, tbVideoFile, tbSoundTrack, tbSrtFile)
end

function AVProVideoGUICtrl:OnEvent_VideoFirstFrameReady(nVideoDuration)
  NovaAPI.DispatchEventWithData("VIDEO_START")
  EventManager.Hit("VIDEO_START")
  self._mapNode.btnSkip.gameObject:SetActive(self.bSkipable == true)
  self.nVideoDuration = nVideoDuration
  if self.bEndFade == true then
    self.timerVideo = self:AddTimer(1, self.nVideoDuration - self.nFadeDuration - self.nOffset, self.DoFadeOut, true, true, true)
  end
end

function AVProVideoGUICtrl:DoFadeOut()
  self._mapNode.btnSkip.gameObject:SetActive(false)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.cg_b, true)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cg_b, true)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cg_b, 0)
  NovaAPI.SetCanvasGroupDoFade(self._mapNode.cg_b, 1, self.nFadeDuration, true)
  self.timerVideo = nil
end

function AVProVideoGUICtrl:OnEvent_VideoFinished(bIsSkip)
  self._mapNode.btnSkip.gameObject:SetActive(false)
  NovaAPI.DispatchEventWithData("VIDEO_FINISHED", nil, bIsSkip == true)
  if bIsSkip == true then
    self.bEndTrans = true
    self.nTransDuration = self.nTransDuration > 0 and self.nTransDuration or 0.2
    self.bEndFade = true
    self.nFadeDuration = 0.2
    if self.timerVideo ~= nil then
      self.timerVideo:Cancel(true)
    else
      self:DoFadeOut()
    end
    self:AddTimer(1, self.nFadeDuration, self.DoTransOut, true, true, true)
  else
    self:DoTransOut()
  end
end

function AVProVideoGUICtrl:DoTransOut()
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.cg_a, false)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cg_a, false)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cg_a, 0)
  NovaAPI.DispatchEventWithData("CLOSE_VIDEO")
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.cg_b, true)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cg_b, true)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cg_b, 1)
  if self.bInAvg == true then
    EventManager.Hit("VIDEO_FINISHED")
  elseif self.bEndTrans == true then
    NovaAPI.SetCanvasGroupDoFade(self._mapNode.cg_b, 0, self.nTransDuration, true)
    self:AddTimer(1, self.nTransDuration + self.nOffset, self.END, true, true, true)
  else
    self:END()
  end
end

function AVProVideoGUICtrl:END()
  EventManager.Hit(EventId.ClosePanel, PanelId.ProVideoGUI)
  EventManager.Hit("VIDEO_END")
end

function AVProVideoGUICtrl:OnBtnClick_Skip()
  if self.timerVideo ~= nil then
    self.timerVideo:Pause(true)
  end
  NovaAPI.DispatchEventWithData("Pause_Video")
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = ConfigTable.GetUIText("Video_SkipTip"),
    callbackConfirm = function()
      self._mapNode.btnSkip.gameObject:SetActive(false)
      NovaAPI.DispatchEventWithData("Jump_Video")
    end,
    callbackCancel = function()
      if self.timerVideo ~= nil then
        self.timerVideo:Pause(false)
      end
      NovaAPI.DispatchEventWithData("Resume_Video")
    end
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function AVProVideoGUICtrl:ParseFileName()
  local sBaseName = self.sVideoFileName
  local curTxtLan = Settings.sCurrentTxtLanguage
  local curVoLan = Settings.sCurrentVoLanguage
  local EnumLan = AllEnum.Language
  local sGenderSurfix = PlayerData.Base:GetPlayerSex() == true and "_MP" or "_FP"
  local sVoTag = curVoLan == EnumLan.CN and "CNVA" or "JPVA"
  local sLanSurfix = ""
  if curTxtLan == EnumLan.CN then
    sLanSurfix = "_CN"
  elseif curTxtLan == EnumLan.EN then
    sLanSurfix = "_EN"
  elseif curTxtLan == EnumLan.JP then
    sLanSurfix = "_JP"
  elseif curTxtLan == EnumLan.KR then
    sLanSurfix = "_KR"
  elseif curTxtLan == EnumLan.TW then
    sLanSurfix = "_TW"
  end
  local tbVideoFileNameOrder = {
    [1] = sBaseName .. sGenderSurfix .. sLanSurfix .. ".mp4",
    [2] = sBaseName .. sGenderSurfix .. ".mp4",
    [3] = sBaseName .. sLanSurfix .. ".mp4",
    [4] = sBaseName .. ".mp4"
  }
  local sTrackIdx_JP_Female = "0"
  local sTrackIdx_CN_Female = "1"
  local sTrackIdx_JP_Male = "2"
  local sTracnIdx_CN_Male = "3"
  local tbSoundTrackNameOrder = {}
  if curVoLan == EnumLan.CN then
    if PlayerData.Base:GetPlayerSex() == true then
      tbSoundTrackNameOrder[1] = sTracnIdx_CN_Male
      tbSoundTrackNameOrder[2] = sTrackIdx_CN_Female
    else
      tbSoundTrackNameOrder[1] = sTrackIdx_CN_Female
    end
  elseif curVoLan == EnumLan.JP then
    if PlayerData.Base:GetPlayerSex() == true then
      tbSoundTrackNameOrder[1] = sTrackIdx_JP_Male
      tbSoundTrackNameOrder[2] = sTrackIdx_JP_Female
    else
      tbSoundTrackNameOrder[1] = sTrackIdx_JP_Female
    end
  end
  local tbSrtFileNameOrder = {
    [1] = sBaseName .. "_" .. sVoTag .. sGenderSurfix .. sLanSurfix .. ".srt",
    [2] = sBaseName .. "_" .. sVoTag .. "_FP" .. sLanSurfix .. ".srt",
    [3] = sBaseName .. sLanSurfix .. ".srt"
  }
  return tbVideoFileNameOrder, tbSoundTrackNameOrder, tbSrtFileNameOrder
end

return AVProVideoGUICtrl
