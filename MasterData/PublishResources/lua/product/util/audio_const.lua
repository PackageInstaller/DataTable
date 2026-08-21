AudioConstValue = {
  BGMCrossFadeTime = 0.5,
  AuroralTimeMixerGroupName = "AisacControl_music",
  AuroralTimeMixerValue = 0.5,
  DefaultMixerValue = 0
}
_enum("AudioConstValue", AudioConstValue)
_class("AudioHelper", Object)
AudioHelper = AudioHelper

function AudioHelper.GetAudioResName(configID)
  local config = Cfg.cfg_audio[configID]
  if config then
    return config.ResName
  else
    Log.fatal("can not find audio source by ID: " .. tostring(configID))
    return ""
  end
end

function AudioHelper.RequestAndPlayUIVoiceAutoRelease(audioID)
  if not audioID then
    Log.fatal("attempt to play UIVoice with nil AudioID")
    return
  end
  local config = Cfg.cfg_audio[audioID]
  if config then
    return AudioManager.Instance:RequestAndPlayUIVoiceAutoRelease(config.ResName)
  else
    Log.fatal("can not find audio source by ID: " .. tostring(audioID))
  end
  return -1
end

function AudioHelper.PlayUISoundAutoRelease(audioID)
  if not audioID then
    Log.fatal("attempt to play UIVoice with nil AudioID")
    return
  end
  local config = Cfg.cfg_audio[audioID]
  if config then
    return AudioManager.Instance:PlayUISoundAutoRelease(config.ResName)
  else
    Log.fatal("can not find audio source by ID: " .. tostring(audioID))
  end
  return -1
end

function AudioHelper.PlayUISoundAutoReleaseBylevelId(levelId)
  if not levelId then
    Log.fatal("AudioHelper.PlayUISoundAutoReleaseBylevelId attempt to play UIVoice with nil levelId")
  end
  local audioID_cfg = Cfg.cfg_global["audio_wave_warning_" .. levelId]
  local audioID = CriAudioIDConst.SoundUIBossAlarm
  if not audioID_cfg then
    audioID = Cfg.cfg_global.audio_wave_warning_default.IntValue
    if not audioID then
      return -1
    end
  end
  return AudioHelperController.PlayUISoundAutoRelease(audioID)
end

function AudioHelper.RequestUISound(audioID)
  if not audioID then
    Log.fatal("attempt to request UIVoice with nil AudioID")
    return
  end
  local config = Cfg.cfg_audio[audioID]
  if config then
    return AudioManager.Instance:RequestUISound(config.ResName)
  else
    Log.fatal("can not find audio source by ID: " .. tostring(audioID))
  end
  return -1
end

function AudioHelper.GetConfigName(audioID)
  if not audioID then
    Log.fatal("attempt to request UIVoice with nil AudioID")
    return ""
  end
  local config = Cfg.cfg_audio[audioID]
  if config then
    return config.ResName
  else
    Log.fatal("can not find audio source by ID: " .. tostring(audioID))
  end
  return ""
end

function AudioHelper.RequestUISoundSync(audioID)
  if not audioID then
    Log.fatal("attempt to request UIVoice with nil AudioID")
    return ""
  end
  local config = Cfg.cfg_audio[audioID]
  if config then
    return AudioManager.Instance:RequestUISoundSync(config.ResName)
  else
    Log.fatal("can not find audio source by ID: " .. tostring(audioID))
  end
  return -1
end

function AudioHelper.PlayRequestedUISound(audioID)
  if not audioID then
    Log.fatal("attempt to play UIVoice with nil AudioID")
    return ""
  end
  local config = Cfg.cfg_audio[audioID]
  if config then
    return AudioManager.Instance:PlayUISound(config.ResName)
  else
    Log.fatal("can not find audio source by ID: " .. tostring(audioID))
  end
  return -1
end

function AudioHelper.ReleaseUISound(audioID)
  if not audioID then
    Log.fatal("attempt to release UIVoice with nil AudioID")
    return ""
  end
  local config = Cfg.cfg_audio[audioID]
  if config then
    return AudioManager.Instance:ReleaseUISound(config.ResName)
  else
    Log.fatal("can not find audio source by ID: " .. tostring(audioID))
  end
  return -1
end

function AudioHelper.CacheCommonUISound()
  Log.info("[Audio] Cache common sound")
  if not AudioHelper._commonSoundList then
    AudioHelper._commonSoundList = {
      CriAudioIDConst.SoundCancel,
      CriAudioIDConst.SoundSwitch,
      CriAudioIDConst.SoundSlide,
      CriAudioIDConst.SoundAddUp,
      CriAudioIDConst.SoundUISlideStory
    }
  end
  local soundList = AudioHelper._commonSoundList
  for i = 1, #soundList do
    local config = Cfg.cfg_audio[soundList[i]]
    if config then
      return AudioManager.Instance:RequestUISound(config.ResName)
    end
  end
end

function AudioHelper.UnloadCommonUISound()
  Log.info("[Audio] Unload common sound")
  if not AudioHelper._commonSoundList then
    Log.info("[Audio] No common sound list")
    return
  end
  local soundList = AudioHelper._commonSoundList
  for i = 1, #soundList do
    local config = Cfg.cfg_audio[soundList[i]]
    if config then
      return AudioManager.Instance:ReleaseUISound(config.ResName)
    end
  end
end
