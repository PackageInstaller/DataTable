local SettingsSoundCtrl = class("SettingsSoundCtrl", BaseCtrl)
local UIGameSystemSetup = CS.UIGameSystemSetup
local WwiseManger = CS.WwiseAudioManager
SettingsSoundCtrl._mapNodeConfig = {
  txtPageTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Sound"
  },
  txtSound = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Sound_Title"
  },
  Music_Btn = {sNodeName = "Music_Btn", sComponentName = "Button"},
  Music_Slider = {
    sComponentName = "Slider",
    callback = "OnMusicSliderValueChange"
  },
  MusicFill = {sComponentName = "Image"},
  MusicHandle = {sComponentName = "Image"},
  Music_Value = {sComponentName = "TMP_Text"},
  Effect_Btn = {sNodeName = "Effect_Btn", sComponentName = "Button"},
  Effect_Slider = {
    sComponentName = "Slider",
    callback = "OnEffectSliderValueChange"
  },
  EffectFill = {sComponentName = "Image"},
  EffectHandle = {sComponentName = "Image"},
  Effect_Value = {sComponentName = "TMP_Text"},
  Voice_Btn = {sNodeName = "Voice_Btn", sComponentName = "Button"},
  Voice_Slider = {
    sComponentName = "Slider",
    callback = "OnVoiceSliderValueChange"
  },
  VoiceFill = {sComponentName = "Image"},
  VoiceHandle = {sComponentName = "Image"},
  Voice_Value = {sComponentName = "TMP_Text"},
  Music = {
    sCtrlName = "Game.UI.Settings.OptionSwitchCtrl"
  },
  Effect = {
    sCtrlName = "Game.UI.Settings.OptionSwitchCtrl"
  },
  Voice = {
    sCtrlName = "Game.UI.Settings.OptionSwitchCtrl"
  },
  MuteInBackground = {
    sCtrlName = "Game.UI.Settings.OptionSwitchCtrl"
  }
}
SettingsSoundCtrl._mapEventConfig = {}

function SettingsSoundCtrl:RefreshText()
  self._mapNode.Music:SetText(ConfigTable.GetUIText("Settings_Sound_Music"))
  self._mapNode.Effect:SetText(ConfigTable.GetUIText("Settings_Sound_Sfx"))
  self._mapNode.Voice:SetText(ConfigTable.GetUIText("Settings_Sound_Voice"))
  self._mapNode.MuteInBackground:SetText(ConfigTable.GetUIText("Settings_Sound_MuteOnMinimize"))
end

function SettingsSoundCtrl:Init()
  if self.bInit then
    return
  end
  self.bInit = true
  self:LoadSetting()
end

function SettingsSoundCtrl:Quit()
  if not self.bInit then
    return
  end
end

function SettingsSoundCtrl:LoadSetting()
  self.musicValue = self._panel:LoadLocalData("NumMusic")
  self.openMusic = self._panel:LoadLocalData("OpenMusic")
  self._mapNode.Music:Init(function()
    self.openMusic = not self.openMusic
    self:RefreshMusicSlider()
    WwiseManger.Instance.m_playMusic = self.openMusic
  end, self.openMusic)
  self:RefreshMusicSlider()
  self.effectValue = self._panel:LoadLocalData("NumSfx")
  self.openEffect = self._panel:LoadLocalData("OpenSfx")
  self._mapNode.Effect:Init(function()
    self.openEffect = not self.openEffect
    self:RefreshEffectSlider()
    WwiseManger.Instance.m_playSfx = self.openEffect
  end, self.openEffect)
  self:RefreshEffectSlider()
  self.voiceValue = self._panel:LoadLocalData("NumChar")
  self.openVoice = self._panel:LoadLocalData("OpenChar")
  self._mapNode.Voice:Init(function()
    self.openVoice = not self.openVoice
    self:RefreshVoiceSlider()
    WwiseManger.Instance.m_voice = self.openVoice
  end, self.openVoice)
  self.bMuteInBackground = self._panel:LoadLocalData("WwiseMuteInBackground")
  local curPlatform = CS.ClientManager.Instance.Platform
  local bIsPC = curPlatform == "windows" or curPlatform == "mac"
  local goVoiceLine = self._mapNode.Voice.gameObject.transform:Find("line")
  goVoiceLine.gameObject:SetActive(bIsPC)
  self._mapNode.MuteInBackground.gameObject:SetActive(bIsPC)
  self._mapNode.MuteInBackground:Init(function()
    self.bMuteInBackground = not self.bMuteInBackground
    WwiseManger.Instance.bMuteInBackground = self.bMuteInBackground
  end, self.bMuteInBackground)
  self:RefreshVoiceSlider()
end

function SettingsSoundCtrl:SaveSetting()
  self._panel:SaveLocalData("OpenMusic", self.openMusic)
  self._panel:SaveLocalData("NumMusic", self.musicValue)
  self._panel:SaveLocalData("OpenSfx", self.openEffect)
  self._panel:SaveLocalData("NumSfx", self.effectValue)
  self._panel:SaveLocalData("OpenChar", self.openVoice)
  self._panel:SaveLocalData("NumChar", self.voiceValue)
  if not NovaAPI.IsMobilePlatform() then
    self._panel:SaveLocalData("WwiseMuteInBackground", self.bMuteInBackground)
  end
end

function SettingsSoundCtrl:Awake()
  self.bInit = false
  self:RefreshText()
end

function SettingsSoundCtrl:OnEnable()
end

function SettingsSoundCtrl:OnDisable()
  if not self.bInit then
    return
  end
  self:SaveSetting()
end

function SettingsSoundCtrl:OnDestroy()
end

function SettingsSoundCtrl:RefreshMusicSlider()
  self._mapNode.Music_Btn.interactable = self.openMusic
  NovaAPI.SetSliderInteractable(self._mapNode.Music_Slider, self.openMusic)
  NovaAPI.SetSliderValue(self._mapNode.Music_Slider, self.musicValue)
  NovaAPI.SetTMPText(self._mapNode.Music_Value, self.musicValue)
end

function SettingsSoundCtrl:OnMusicSliderValueChange(_, value)
  local curValue, _ = math.modf(value)
  self.musicValue = curValue
  NovaAPI.SetTMPText(self._mapNode.Music_Value, self.musicValue)
  WwiseManger.Instance.MusicVolume = curValue / 10
end

function SettingsSoundCtrl:RefreshEffectSlider()
  self._mapNode.Effect_Btn.interactable = self.openEffect
  NovaAPI.SetSliderInteractable(self._mapNode.Effect_Slider, self.openEffect)
  NovaAPI.SetSliderValue(self._mapNode.Effect_Slider, self.effectValue)
  NovaAPI.SetTMPText(self._mapNode.Effect_Value, self.effectValue)
end

function SettingsSoundCtrl:OnEffectSliderValueChange(_, value)
  local curValue, _ = math.modf(value)
  self.effectValue = curValue
  NovaAPI.SetTMPText(self._mapNode.Effect_Value, self.effectValue)
  WwiseManger.Instance.SfxVolume = curValue / 10
end

function SettingsSoundCtrl:RefreshVoiceSlider()
  self._mapNode.Voice_Btn.interactable = self.openVoice
  NovaAPI.SetSliderInteractable(self._mapNode.Voice_Slider, self.openVoice)
  NovaAPI.SetSliderValue(self._mapNode.Voice_Slider, self.voiceValue)
  NovaAPI.SetTMPText(self._mapNode.Voice_Value, self.voiceValue)
end

function SettingsSoundCtrl:OnVoiceSliderValueChange(_, value)
  local curValue, _ = math.modf(value)
  self.voiceValue = curValue
  NovaAPI.SetTMPText(self._mapNode.Voice_Value, self.voiceValue)
  WwiseManger.Instance.VoiceVolume = curValue / 10
end

return SettingsSoundCtrl
