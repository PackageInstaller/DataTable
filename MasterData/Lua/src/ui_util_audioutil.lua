local util = {}
util.EventNameNone = "none"

function util.playBgm(eventName, fadeTime)
  if string.isEmpty(eventName) or eventName == util.EventNameNone then
    return
  end
  C_AudioManager.PlayBackground(eventName, fadeTime or 0)
  util.currBgmEventName = eventName
end

function util.getCurrBgmName()
  return util.currBgmEventName
end

function util.pauseBgm(isPause)
  if isPause == nil then
    isPause = true
  end
  C_AudioManager.PauseBackground(isPause)
end

function util.stopBgm()
  C_AudioManager.StopBackground()
end

function util.setBgmVolume(volume)
end

function util.getBgmLength(eventName)
  return 0
end

function util.playSound(eventName, target, endCallBack, loadAsync, autoRelease)
  if string.isEmpty(eventName) or eventName == util.EventNameNone then
    return
  end
  if autoRelease == nil then
    autoRelease = true
  end
  if loadAsync == nil then
    loadAsync = true
  end
  local wrap = C_AudioManager.Play(eventName, target, endCallBack, loadAsync, autoRelease)
  print("Audio", eventName)
  return wrap
end

function util.playVoiceSound(eventName, target, loop, autoRelease)
  return util.playSound(eventName, target, loop, autoRelease)
end

function util.pauseSound(source, isPause)
  if not source or not source:IsValid() then
    return
  end
  if isPause then
    source:Pause()
  else
    source:Resume()
  end
end

function util.stopSound(source)
  if not source or not source:IsValid() then
    return
  end
  C_AudioManager.FreeSource(source)
end

function util.setSoundVolume(source, volume)
  if not source or not source:IsValid() then
    return
  end
  source:SetVolume(volume)
end

function util.getSoundLength(eventName)
  if string.isEmpty(eventName) or eventName == util.EventNameNone then
    return
  end
  return C_AudioManager.GetAudioLengthByPlayEventName(eventName)
end

function util.playSESound(soundKey)
  if string.isEmpty(soundKey) then
    return
  end
  local se_sounds = L_Config:getConfigDirectly("ui_sounds", soundKey)
  if se_sounds == nil then
    return
  end
  local file_name = se_sounds.value
  if file_name == nil then
    return
  end
  C_AudioManager.Play(file_name)
end

function util.setInterfaceState(switchState, pageName)
  if not string.isEmpty(pageName) then
    local inputCfg = L_ShortCutConst.inputMap[pageName]
    local audioInGameStatus = false
    if inputCfg then
      audioInGameStatus = inputCfg[3]
    end
    if audioInGameStatus ~= true then
      printf("InterfaceState", switchState, pageName)
      return C_GameAudioManager.SetInterfaceState(switchState)
    end
  else
    printf("InterfaceState", switchState, pageName)
    return C_GameAudioManager.SetInterfaceState(switchState)
  end
end

function util.backInterfaceState(switchState)
  return C_GameAudioManager.BackInterfaceState(switchState)
end

function util.getCategoryVolume(categoryName)
end

function util.setCategoryVolume(categoryName, volume)
  C_AudioManager.SetRTPCValue(categoryName, volume)
end

function util.pauseCategory(categoryName, isPause)
end

function util.isCategoryPaused(categoryName)
end

function util.setCategoryVolume_bgm(volume)
  util.setCategoryVolume("RTPC_System_Volume_Music", volume)
end

function util.setCategoryVolume_sound(volume)
  util.setCategoryVolume("RTPC_System_Volume_SFX_Interface", volume)
  util.setCategoryVolume("RTPC_System_Volume_SFX_World", volume)
end

function util.setCategoryVolume_voice(volume)
  util.setCategoryVolume("RTPC_System_Volume_VO", volume)
end

util.needReloadBankNames = {
  "System_General",
  "InGameBattleState"
}

function util.reloadBanks()
  for i, v in ipairs(util.needReloadBankNames) do
    if not string.isEmpty(v) then
      printf("reloadBanks", v)
      C_AudioManager.ReloadBank(v, false)
    end
  end
end

return util
