local DormMusicSelectDiscGridCtrl = class("DormMusicSelectDiscGridCtrl", BaseCtrl)
DormMusicSelectDiscGridCtrl._mapNodeConfig = {
  imgDiscIcon = {sComponentName = "Image"},
  txtMusicOnTitle1 = {sComponentName = "TMP_Text"},
  TMPName = {sComponentName = "TMP_Text"},
  IconMusicValue1 = {},
  txtMusicValue1 = {sComponentName = "TMP_Text"},
  rtNotPlay = {},
  btnSideAPlay = {},
  MusicProgessA = {},
  sliderA = {sComponentName = "Slider"},
  txtMusicValue2 = {sComponentName = "TMP_Text"},
  imgUseBg = {},
  goMusic = {},
  imgSlc = {},
  TMPUseTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_MusicSelect_CurMusicGridTitle"
  }
}
DormMusicSelectDiscGridCtrl._mapEventConfig = {}
DormMusicSelectDiscGridCtrl._mapRedDotConfig = {}

function DormMusicSelectDiscGridCtrl:Awake()
  self.timerCountDownA = nil
  self.nRemainTimeA = 0
end

function DormMusicSelectDiscGridCtrl:FadeIn()
end

function DormMusicSelectDiscGridCtrl:FadeOut()
end

function DormMusicSelectDiscGridCtrl:OnEnable()
end

function DormMusicSelectDiscGridCtrl:OnDisable()
end

function DormMusicSelectDiscGridCtrl:OnDestroy()
end

function DormMusicSelectDiscGridCtrl:OnRelease()
end

function DormMusicSelectDiscGridCtrl:Refresh(nDiscId, bCur, bPlay, nMusicTime)
  if self.timerCountDownA then
    self.timerCountDownA:Cancel()
    self.timerCountDownA = nil
  end
  self.nMusicFullTime = 0
  self.nDiscId = nDiscId
  
  local function SetDefaulIcon()
    self._mapNode.imgDiscIcon.gameObject:SetActive(false)
    self._mapNode.btnSideAPlay:SetActive(true)
  end
  
  if nDiscId == 0 then
    SetDefaulIcon()
    NovaAPI.SetTMPText(self._mapNode.txtMusicOnTitle1, ConfigTable.GetUIText("Dorm_Default_MusicName"))
    NovaAPI.SetTMPText(self._mapNode.TMPName, ConfigTable.GetUIText("Dorm_Default_MusicName"))
  else
    local mapDiscItemCfg = ConfigTable.GetData_Item(nDiscId)
    if mapDiscItemCfg ~= nil then
      self._mapNode.imgDiscIcon.gameObject:SetActive(true)
      self._mapNode.btnSideAPlay:SetActive(false)
      NovaAPI.SetTMPText(self._mapNode.txtMusicOnTitle1, mapDiscItemCfg.Title)
      NovaAPI.SetTMPText(self._mapNode.TMPName, mapDiscItemCfg.Title)
      self:SetPngSprite(self._mapNode.imgDiscIcon, mapDiscItemCfg.Icon .. AllEnum.OutfitIconSurfix.Item)
    else
      SetDefaulIcon()
      NovaAPI.SetTMPText(self._mapNode.txtMusicOnTitle1, "")
      NovaAPI.SetTMPText(self._mapNode.TMPName, "")
    end
  end
  self._mapNode.imgUseBg:SetActive(bCur)
  self._mapNode.MusicProgessA:SetActive(bPlay)
  self._mapNode.goMusic:SetActive(bPlay)
  self._mapNode.rtNotPlay:SetActive(not bPlay)
  if 0 < nDiscId then
    local mapIPCfg = ConfigTable.GetData("DiscIP", nDiscId)
    if mapIPCfg ~= nil then
      self.nLoopTime = mapIPCfg.VoLoop1
      self.nBeginTime = mapIPCfg.VoBegin1
      self.voFile = mapIPCfg.VoFile
      self.nFullTimeA = self.nBeginTime + self.nLoopTime
      self.nRemainTimeA = self.nFullTimeA - nMusicTime
      self._mapNode.txtMusicValue1.gameObject:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.txtMusicValue1, self:SecondsToClock(self.nFullTimeA))
    end
  else
    self.nLoopTime = 60
    self.nBeginTime = 5
    self.voFile = ""
    self.nFullTimeA = self.nBeginTime + self.nLoopTime
    self.nRemainTimeA = self.nFullTimeA - nMusicTime
    self._mapNode.txtMusicValue1.gameObject:SetActive(false)
  end
  if bPlay then
    self:SetTimerA()
  end
end

function DormMusicSelectDiscGridCtrl:SecondsToClock(seconds)
  seconds = math.floor(seconds)
  local minutes = math.floor(seconds / 60)
  local remainingSeconds = seconds % 60
  return string.format("%d:%02d", minutes, remainingSeconds)
end

function DormMusicSelectDiscGridCtrl:PlayMusic()
  self.nRemainTimeA = self.nFullTimeA
  self:SetTimerA()
end

function DormMusicSelectDiscGridCtrl:SetTimerA()
  if self.timerCountDownA then
    self.timerCountDownA:Cancel()
    self.timerCountDownA = nil
  end
  
  local function countdown()
    self.nRemainTimeA = self.nRemainTimeA - 0.034
    if self.nRemainTimeA >= 0 then
      NovaAPI.SetSliderValue(self._mapNode.sliderA, (self.nFullTimeA - self.nRemainTimeA) * 10)
    else
      local nSum = math.abs(self.nRemainTimeA)
      self.nRemainTimeA = self.nLoopTime - nSum
    end
    NovaAPI.SetTMPText(self._mapNode.txtMusicValue2, self:SecondsToClock(self.nFullTimeA - self.nRemainTimeA))
  end
  
  NovaAPI.SetSliderMaxValue(self._mapNode.sliderA, self.nFullTimeA * 10)
  self.timerCountDownA = self:AddTimer(0, 0.034, countdown, true, true, false)
  self._mapNode.MusicProgessA:SetActive(0 < self.nDiscId)
  self._mapNode.goMusic:SetActive(0 < self.nDiscId)
  self._mapNode.rtNotPlay:SetActive(self.nDiscId == 0)
  NovaAPI.SetTMPText(self._mapNode.txtMusicValue2, self:SecondsToClock(self.nFullTimeA - self.nRemainTimeA))
end

function DormMusicSelectDiscGridCtrl:StopPlay()
  if self.timerCountDownA then
    self.timerCountDownA:Cancel()
    self.timerCountDownA = nil
  end
  self._mapNode.MusicProgessA:SetActive(false)
  self._mapNode.goMusic:SetActive(false)
  self._mapNode.rtNotPlay:SetActive(true)
end

function DormMusicSelectDiscGridCtrl:SetSelect(bSelect)
  self._mapNode.imgSlc:SetActive(bSelect)
end

return DormMusicSelectDiscGridCtrl
