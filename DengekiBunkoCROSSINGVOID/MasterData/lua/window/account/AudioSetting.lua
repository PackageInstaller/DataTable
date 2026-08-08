local WU, DB, REF = require("Common/WindowUtil")(this)
local S = require("Common/Singleton")
local U = require("Common/Util")
local m_configDataManager = S:Get("ConfigDataManager")

function Awake()
  GetSettingVolume()
  CS.EventDelegate.Add(REF.BgmSlider.UISlider.onChange, OnAudioSettingChange)
  CS.EventDelegate.Add(REF.SfxSlider.UISlider.onChange, OnAudioSettingChange)
  REF.SfxSlider.UISlider.onDragFinished = PlaySampleSound
end

function GetSettingVolume()
  local preferences = m_configDataManager.GetPreferences()
  REF.BgmSlider.UISlider.value = preferences.audioSetting.bgmVolume
  REF.SfxSlider.UISlider.value = preferences.audioSetting.sfxVolume
end

function OnAudioSettingChange()
  local preferences = m_configDataManager.GetPreferences()
  preferences.audioSetting = {
    bgmVolume = REF.BgmSlider.UISlider.value,
    sfxVolume = REF.SfxSlider.UISlider.value
  }
  m_configDataManager.SetPreferences(preferences)
end

function PlaySampleSound()
  CS.SoundManager.Instance:PlaySound("Sound/system/s_System_OK")
end
