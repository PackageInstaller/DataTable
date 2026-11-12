local DiscMusicCtrl = class("DiscMusicCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local LoopType = CS.DG.Tweening.LoopType
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
DiscMusicCtrl._mapNodeConfig = {
  imgMusicIcon = {sComponentName = "Image"},
  trIcon = {
    sNodeName = "imgMusicIcon",
    sComponentName = "Transform"
  },
  btnResetMusic = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ResetMusic"
  },
  btnSetMusic = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SetMusic"
  },
  goSetMusic = {},
  txtAlreadySetMusic = {
    sComponentName = "TMP_Text",
    sLanguageId = "Disc_AlreadyMainMusic"
  },
  txtSetMusic = {
    sComponentName = "TMP_Text",
    sLanguageId = "Disc_SetMainMusic"
  },
  goSideA = {},
  ScrollViewA = {sComponentName = "ScrollRect"},
  rtDiscDescBg = {
    sComponentName = "RectTransform"
  },
  ContentDiscDesc = {
    sComponentName = "RectTransform"
  },
  txtDiscDesc = {sComponentName = "TMP_Text"},
  rtSideABg = {
    sComponentName = "RectTransform"
  },
  btnMusic = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Music"
  },
  goMusicOff = {nCount = 2},
  goMusicOn = {nCount = 2},
  txtMusicOffTitle = {nCount = 2, sComponentName = "TMP_Text"},
  txtMusicOnTitle = {nCount = 2, sComponentName = "TMP_Text"},
  txtMusicTime = {nCount = 2, sComponentName = "TMP_Text"},
  MusicProgessA = {},
  sliderA = {
    sComponentName = "Slider",
    callback = "OnValueChanged_SliderA"
  },
  sliderDragA = {sNodeName = "sliderA", sComponentName = "SliderDrag"},
  txtMusicValue = {nCount = 2, sComponentName = "TMP_Text"},
  btnSideAPause = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SideAPause"
  },
  btnSideAPlay = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SideAPlay"
  },
  goSideB = {},
  txtSideBTitle = {sComponentName = "TMP_Text"},
  txtLiteraryTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Disc_Appendix_RecordTitle"
  },
  txtSideBDesc = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  ScrollViewSideB = {sComponentName = "ScrollRect"},
  btnRead = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Read"
  },
  txtBtnRead = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Disc_Appendix_Stroy"
  },
  goReadOff = {},
  goReadOn = {},
  txtReadLock = {sComponentName = "TMP_Text"},
  btnAvg = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Avg"
  },
  txtBtnAvg = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Disc_Appendix_AvgEntrance"
  },
  goAvgOff = {},
  goAvgOn = {},
  txtAvgLock = {sComponentName = "TMP_Text"},
  imgOn = {nCount = 2},
  imgOff = {nCount = 2},
  txtSideA = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Disc_Btn_SideAppendix"
  },
  txtSideB = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Disc_Btn_SideMusic"
  },
  btnSide = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Tab"
  },
  aniB = {sNodeName = "goSideB", sComponentName = "Animator"},
  aniLeft = {sNodeName = "--Left--", sComponentName = "Animator"},
  UIParticleNote = {},
  goMusicMask = {}
}
DiscMusicCtrl._mapEventConfig = {
  [EventId.TransAnimOutClear] = "OnEvent_TransAnimOutClear"
}

function DiscMusicCtrl:InitMusic()
  self.mapDisc = PlayerData.Disc:GetDiscById(self._panel.nId)
  self.mapCfg = ConfigTable.GetData("DiscIP", self._panel.nId)
  self.nMusicAIndex = 1
  self:ClearTimer()
  self:PlayMusicA(false)
end

function DiscMusicCtrl:Refresh()
  self.nCurTab = 1
  for i = 1, 2 do
    self._mapNode.imgOn[i]:SetActive(i == self.nCurTab)
    self._mapNode.imgOff[i]:SetActive(i ~= self.nCurTab)
  end
  self._mapNode.goSideA:SetActive(2 == self.nCurTab)
  self._mapNode.goSideB:SetActive(1 == self.nCurTab)
  local mapItem = ConfigTable.GetData_Item(self._panel.nId)
  if mapItem then
    self:SetPngSprite(self._mapNode.imgMusicIcon, mapItem.Icon)
  end
  local nBGMDisc = PlayerData.Disc:GetBGMDisc()
  self._mapNode.btnSetMusic.gameObject:SetActive(nBGMDisc ~= self._panel.nId)
  self._mapNode.goSetMusic.gameObject:SetActive(nBGMDisc == self._panel.nId)
  self:RefreshSideA()
  self:RefreshSideB()
  self:PlayInMusic()
end

function DiscMusicCtrl:SwitchSide()
  self._mapNode.goSideA:SetActive(2 == self.nCurTab)
  self._mapNode.goSideB:SetActive(1 == self.nCurTab)
end

function DiscMusicCtrl:RefreshSideA()
  for i = 1, 2 do
    NovaAPI.SetTMPText(self._mapNode.txtMusicOnTitle[i], self.mapCfg["VoName" .. i])
    NovaAPI.SetTMPText(self._mapNode.txtMusicOffTitle[i], self.mapCfg["VoName" .. i])
    local sec = self.mapCfg["VoBegin" .. i] + self.mapCfg["VoLoop" .. i]
    local min = math.floor(sec / 60)
    local secSub = math.floor(sec - min * 60)
    local sTime = 0 < min and orderedFormat(ConfigTable.GetUIText("Disc_MusicTimeMin"), min) or ""
    if 0 < secSub then
      sTime = sTime .. orderedFormat(ConfigTable.GetUIText("Disc_MusicTimeSec"), secSub)
    end
    NovaAPI.SetTMPText(self._mapNode.txtMusicTime[i], sTime)
  end
  for i = 1, 2 do
    self._mapNode.goMusicOn[i]:SetActive(self.nMusicAIndex == i)
    self._mapNode.goMusicOff[i]:SetActive(self.nMusicAIndex ~= i)
  end
end

function DiscMusicCtrl:RefreshSideB()
  NovaAPI.SetTMPText(self._mapNode.txtSideBTitle, self.mapCfg.StoryName)
  local mapItem = ConfigTable.GetData_Item(self._panel.nId)
  if mapItem then
    NovaAPI.SetText_RubyTMP(self._mapNode.txtSideBDesc, mapItem.Literary)
  end
  NovaAPI.SetVerticalNormalizedPosition(self._mapNode.ScrollViewSideB, 1)
  self:RefreshStory()
  self:RefreshAvg()
end

function DiscMusicCtrl:RefreshStory()
  local nLimit = ConfigTable.GetConfigNumber("DiscStoryReadLimit")
  local bLimit = nLimit > self.mapDisc.nPhase
  self._mapNode.goReadOn:SetActive(not bLimit)
  self._mapNode.goReadOff:SetActive(bLimit)
  if bLimit then
    NovaAPI.SetTMPText(self._mapNode.txtReadLock, orderedFormat(ConfigTable.GetUIText("Disc_Btn_LockAppendix"), nLimit))
  end
end

function DiscMusicCtrl:RefreshAvg()
  local bHas = self.mapCfg.AvgId ~= "" and self.mapDisc.mapAvgReward.nId ~= nil
  self._mapNode.btnAvg.gameObject:SetActive(bHas)
  if not bHas then
    return
  end
  local nLimit = ConfigTable.GetConfigNumber("DiscAVGStoryReadLimit")
  local bLimit = nLimit > self.mapDisc.nPhase
  self._mapNode.goAvgOn:SetActive(not bLimit)
  self._mapNode.goAvgOff:SetActive(bLimit)
  if bLimit then
    NovaAPI.SetTMPText(self._mapNode.txtAvgLock, orderedFormat(ConfigTable.GetUIText("Disc_Btn_LockAppendix"), nLimit))
  end
end

function DiscMusicCtrl:ShowReward()
  local mapMsgData = self._panel.mapAvgRewardData
  local bHasReward = mapMsgData and mapMsgData.Props and #mapMsgData.Props > 0
  if bHasReward then
    UTILS.OpenReceiveByChangeInfo(mapMsgData)
  end
  self._panel.mapAvgRewardData = nil
end

function DiscMusicCtrl:PlayMusicAni()
  self._mapNode.aniLeft:Play("Music_in", 0, 0)
  if self.tweener == nil then
    self.tweener = self._mapNode.trIcon:DORotate(Vector3(0, 0, -360), 25, RotateMode.FastBeyond360)
    self.tweener:SetEase(Ease.Linear):SetLoops(-1, LoopType.Incremental):SetUpdate(true)
  else
    self.tweener:Play()
  end
end

function DiscMusicCtrl:StopMusicAni()
  self._mapNode.aniLeft:Play("Music_out", 0, 0)
  if self.tweener then
    self.tweener:Pause()
  end
end

function DiscMusicCtrl:PlayInMusic()
  WwiseAudioMgr:PostEvent("ui_outfit_audio_start")
  if not self._panel.bPause then
    self:PlayMusicAni()
  end
  self._mapNode.UIParticleNote:SetActive(true)
end

function DiscMusicCtrl:PlayOutMusic()
  self:StopMusicAni()
  self._mapNode.UIParticleNote:SetActive(false)
end

function DiscMusicCtrl:PlayMusicA(bShow)
  self.nLoopTime = self.mapCfg["VoLoop" .. self.nMusicAIndex]
  self.nBeginTime = self.mapCfg["VoBegin" .. self.nMusicAIndex]
  self.nFullTimeA = self.nBeginTime + self.nLoopTime
  self.nRemainTimeA = self.nFullTimeA
  for i = 1, 2 do
    self._mapNode.goMusicOn[i]:SetActive(self.nMusicAIndex == i)
    self._mapNode.goMusicOff[i]:SetActive(self.nMusicAIndex ~= i)
  end
  NovaAPI.SetSliderMaxValue(self._mapNode.sliderA, self.nFullTimeA * 10)
  NovaAPI.SetSliderValue(self._mapNode.sliderA, 0)
  NovaAPI.SetTMPText(self._mapNode.txtMusicValue[1], self:SecondsToClock(0))
  NovaAPI.SetTMPText(self._mapNode.txtMusicValue[2], self:SecondsToClock(self.nFullTimeA))
  self._mapNode.btnSideAPause.gameObject:SetActive(true)
  self._mapNode.btnSideAPlay.gameObject:SetActive(false)
  if self._panel.bPause then
    self._panel.bPause = false
    WwiseAudioMgr:PostEvent("music_outfit_resume")
  end
  if bShow then
    self:PlayMusicAni()
  end
  if self.nMusicAIndex == 1 then
    WwiseAudioMgr:SetState("outfit", self.mapCfg.VoFile)
    WwiseAudioMgr:SetState("Disc", "discMain")
    WwiseAudioMgr:SeekOnEvent("music_outfit", 0)
  else
    WwiseAudioMgr:SetState("outfit", self.mapCfg.VoFile)
    WwiseAudioMgr:SetState("Disc", "discVictory")
    WwiseAudioMgr:SeekOnEvent("music_outfit", 0)
  end
  self:SetTimerA()
end

function DiscMusicCtrl:SetTimerA()
  if self.timerCountDownA then
    self.timerCountDownA:Reset()
    return
  end
  
  local function countdown()
    self.nRemainTimeA = self.nRemainTimeA - 0.034
    if self.nRemainTimeA >= 0 then
      NovaAPI.SetSliderValue(self._mapNode.sliderA, (self.nFullTimeA - self.nRemainTimeA) * 10)
    else
      self.nRemainTimeA = self.nLoopTime
    end
  end
  
  self.timerCountDownA = self:AddTimer(0, 0.034, countdown, true, true, false)
end

function DiscMusicCtrl:SecondsToClock(seconds)
  seconds = math.floor(seconds)
  local minutes = math.floor(seconds / 60)
  local remainingSeconds = seconds % 60
  return string.format("%d:%02d", minutes, remainingSeconds)
end

function DiscMusicCtrl:BindSlider()
  self.handler = ui_handler(self, self.OnEndDrag_SliderA, self._mapNode.sliderDragA)
  self._mapNode.sliderDragA.onEndDrag:AddListener(self.handler)
  self.handler2 = ui_handler(self, self.OnStartDrag_SliderA, self._mapNode.sliderDragA)
  self._mapNode.sliderDragA.onStartDrag:AddListener(self.handler2)
end

function DiscMusicCtrl:UnbindSlider()
  self._mapNode.sliderDragA.onEndDrag:RemoveListener(self.handler)
  self._mapNode.sliderDragA.onStartDrag:RemoveListener(self.handler2)
end

function DiscMusicCtrl:ClearTimer()
  if self.timerCountDownA ~= nil then
    self.timerCountDownA:Cancel()
  end
  self.timerCountDownA = nil
end

function DiscMusicCtrl:Awake()
end

function DiscMusicCtrl:OnEnable()
  self:BindSlider()
end

function DiscMusicCtrl:OnDisable()
  self:UnbindSlider()
  if self.tweener then
    self.tweener:Kill()
    self.tweener = nil
  end
  self:ClearTimer()
end

function DiscMusicCtrl:OnDestroy()
end

function DiscMusicCtrl:OnBtnClick_Read()
  local nLimit = ConfigTable.GetConfigNumber("DiscStoryReadLimit")
  local bLimit = nLimit > self.mapDisc.nPhase
  if bLimit then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Disc_StoryLimitTip"))
  else
    EventManager.Hit("OpenDiscStory", self.mapDisc, self.mapCfg)
  end
end

function DiscMusicCtrl:OnBtnClick_Avg()
  local nLimit = ConfigTable.GetConfigNumber("DiscAVGStoryReadLimit")
  local bLimit = nLimit > self.mapDisc.nPhase
  if bLimit then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Disc_AvgLimitTip"))
  else
    local function callback()
      if not self.mapDisc.bAvgRead then
        local function cbSuc(mapMsgData)
          self._panel.bGetAvgReward = true
          
          self._panel.mapAvgRewardData = mapMsgData
          self._panel.bAvg = false
          EventManager.Hit(EventId.ClosePanel, PanelId.PureAvgStory)
        end
        
        PlayerData.Disc:SendDiscReadRewardReceiveReq(self._panel.nId, AllEnum.DiscReadType.DiscAvg, cbSuc)
      else
        self._panel.bAvg = false
        EventManager.Hit(EventId.ClosePanel, PanelId.PureAvgStory)
      end
    end
    
    self._panel.bAvg = true
    local mapData = {
      nType = AllEnum.StoryAvgType.Plot,
      sAvgId = self.mapCfg.AvgId,
      nNodeId = nil,
      callback = callback
    }
    EventManager.Hit(EventId.OpenPanel, PanelId.PureAvgStory, mapData)
  end
end

function DiscMusicCtrl:OnBtnClick_ResetMusic()
  local function callback()
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      
      bPositive = true,
      sContent = ConfigTable.GetUIText("Disc_ResetMusicSuc")
    })
    self._mapNode.btnSetMusic.gameObject:SetActive(true)
    self._mapNode.goSetMusic.gameObject:SetActive(false)
  end
  
  PlayerData.Disc:SendPlayerMusicSetReq(0, callback)
end

function DiscMusicCtrl:OnBtnClick_SetMusic()
  local function callback()
    self._mapNode.btnSetMusic.gameObject:SetActive(false)
    
    self._mapNode.goSetMusic.gameObject:SetActive(true)
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      bPositive = true,
      sContent = ConfigTable.GetUIText("Disc_SetMusicSuc")
    })
  end
  
  PlayerData.Disc:SendPlayerMusicSetReq(self._panel.nId, callback)
end

function DiscMusicCtrl:OnBtnClick_Tab(btn, nIndex)
  if nIndex == self.nCurTab then
    return
  end
  for i = 1, 2 do
    self._mapNode.imgOn[i]:SetActive(i == nIndex)
    self._mapNode.imgOff[i]:SetActive(i ~= nIndex)
  end
  self.nCurTab = nIndex
  self:SwitchSide()
end

function DiscMusicCtrl:OnBtnClick_Music(btn, nIndex)
  if self.nMusicAIndex == nIndex then
    return
  end
  self.nMusicAIndex = nIndex
  self:PlayMusicA(true)
end

function DiscMusicCtrl:OnValueChanged_SliderA(_, value)
  NovaAPI.SetTMPText(self._mapNode.txtMusicValue[1], self:SecondsToClock(math.floor(value / 10)))
end

function DiscMusicCtrl:OnStartDrag_SliderA()
  self.timerCountDownA:Pause(true)
end

function DiscMusicCtrl:OnEndDrag_SliderA(_, value)
  WwiseAudioMgr:SeekOnEvent_Position("music_outfit", value * 100)
  self.nRemainTimeA = self.nFullTimeA - value / 10
  self.timerCountDownA:Pause(false)
  self._mapNode.btnSideAPause.gameObject:SetActive(true)
  self._mapNode.btnSideAPlay.gameObject:SetActive(false)
  if self._panel.bPause then
    self._panel.bPause = false
    WwiseAudioMgr:PostEvent("music_outfit_resume")
    self:PlayMusicAni()
  end
end

function DiscMusicCtrl:OnBtnClick_SideAPause()
  self._mapNode.btnSideAPause.gameObject:SetActive(false)
  self._mapNode.btnSideAPlay.gameObject:SetActive(true)
  WwiseAudioMgr:PostEvent("music_outfit_pause")
  self.timerCountDownA:Pause(true)
  self:StopMusicAni()
  self._panel.bPause = true
end

function DiscMusicCtrl:OnBtnClick_SideAPlay()
  self._mapNode.btnSideAPause.gameObject:SetActive(true)
  self._mapNode.btnSideAPlay.gameObject:SetActive(false)
  WwiseAudioMgr:PostEvent("music_outfit_resume")
  self.timerCountDownA:Pause(false)
  self:PlayMusicAni()
  self._panel.bPause = false
end

function DiscMusicCtrl:OnEvent_TransAnimOutClear(...)
  if self._panel.bGetAvgReward then
    self:ShowReward()
    self._panel.bGetAvgReward = false
  end
end

return DiscMusicCtrl
