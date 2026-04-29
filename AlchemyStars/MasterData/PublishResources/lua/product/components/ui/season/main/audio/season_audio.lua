_class("SeasonAudioPlayer", Object)
SeasonAudioPlayer = SeasonAudioPlayer

function SeasonAudioPlayer:Constructor(playerID, distance, audioID, position, startRadiu, endRadiu, highVolume, lowVolume, isAnimationAudio, AnimAudioID)
  self.playerID = playerID
  self.distance = distance
  self.audioID = audioID
  self.position = position
  self.startRadiu = startRadiu
  self.endRadiu = endRadiu
  self.highVolume = highVolume
  self.lowVolume = lowVolume
  self.isAnimationAudio = isAnimationAudio ~= nil and isAnimationAudio or false
  self.AnimAudioID = AnimAudioID
end

_class("SeasonAudio", Object)
SeasonAudio = SeasonAudio

function SeasonAudio:Constructor()
  self._uiSeasonModule = GameGlobal.GetUIModule(SeasonModule)
  local seasonID = self._uiSeasonModule:GetSeasonID()
  self._cfgs = Cfg.cfg_season_map_audio({SeasonID = seasonID})
  self._voiceCfg = Cfg.cfg_season_map_player_voice[seasonID]
  self._seasonManager = self._uiSeasonModule:SeasonManager()
  self._player = self._seasonManager:SeasonPlayerManager():GetPlayer()
  self._audioPlayers = {}
  if self._cfgs then
    for _, cfg in pairs(self._cfgs) do
      local name = cfg.name
      local audioGO = UnityEngine.GameObject.Find(name)
      if audioGO then
        local position = audioGO.transform.position
        local startRadius = cfg.startRadius
        local endRadius = cfg.endRadius
        local highVolume = cfg.highVolume
        local lowVolume = cfg.lowVolume
        local isAnimationAudio = cfg.isAnimationAudio
        local audioID = cfg.audioID
        local AnimAudioID = cfg.AnimAudioID
        local audioPlayer = SeasonAudioPlayer:New(-1, 0, audioID, position, startRadius, endRadius, highVolume, lowVolume, isAnimationAudio, AnimAudioID)
        table.insert(self._audioPlayers, audioPlayer)
      end
    end
  end
  self._cameraTransform = self._seasonManager:SeasonCameraManager():SeasonCamera():Transform()
  local soundOn = 0 < LocalDB.GetInt("SoundVolumeOnKey", 1)
  local soundGlobal = Cfg.cfg_global.sound_volume.FloatValue
  self._sound_value = soundOn and LocalDB.GetInt("SoundVolumeKey", 100) / 100 * soundGlobal or 0
  self._stepTimer = 0
  self._stopAllAudio = false
  self._curVoice = nil
  self:_RequestSound()
  AudioHelperController.SetInnerGameSoundPlaySpeed(BattleConst.TimeSpeedList[1])
end

function SeasonAudio:OnAfterInit()
  self:_RequestEnvSound()
end

function SeasonAudio:Dispose()
  self:_ReleaseAllSound()
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
    self._event = nil
  end
  self._hasRequestEnvSound = nil
end

function SeasonAudio:Update(deltaTime)
  if self._hasRequestEnvSound then
    self:_PlayEnvSound()
  end
end

function SeasonAudio:_PlayEnvSound()
  local cameraPos = self._cameraTransform.position
  for k, v in ipairs(self._audioPlayers) do
    if not v.isAnimationAudio then
      v.distance = self:_GetPlaneDistance(v.position, cameraPos)
      self:_PlayRadiuSound(v)
    end
  end
  self._hasRequestEnvSound = true
end

function SeasonAudio:_PlayRadiuSound(player)
  local globalVolume = self._stopAllAudio and 0 or self._sound_value
  if player.distance < player.startRadiu and player.distance > player.endRadiu then
    if player.playerID and player.playerID ~= -1 then
      local volume = Mathf.Lerp(player.lowVolume, player.highVolume, (player.startRadiu - player.distance) / (player.startRadiu - player.endRadiu))
      AudioHelperController.SetInnerVolumeRuntime(player.playerID, volume * globalVolume)
    else
      player.playerID = AudioHelperController.PlayInnerGameSfx(player.audioID, true)
    end
  elseif player.distance < player.endRadiu then
    if player.playerID and player.playerID ~= -1 then
      AudioHelperController.SetInnerVolumeRuntime(player.playerID, player.highVolume * globalVolume)
    end
  else
    if player.playerID and player.playerID ~= -1 then
      AudioHelperController.SetInnerVolumeRuntime(player.playerID, CriAudioManager.Instance.SoundVolume)
      AudioHelperController.StopInnerGameSfx(player.playerID, player.audioID)
    end
    player.playerID = -1
  end
end

function SeasonAudio:_GetPlaneDistance(position1, position2)
  position1.y = 0
  position2.y = 0
  return Vector3.Distance(position1, position2)
end

function SeasonAudio:_RequestEnvSound()
  for k, v in ipairs(self._audioPlayers) do
    if v.isAnimationAudio then
      for key, value in pairs(v.AnimAudioID) do
        if value ~= -1 then
          AudioHelperController.RequestInnerGameSound(value)
        end
      end
    else
      AudioHelperController.RequestInnerGameSound(v.audioID)
    end
  end
  self._hasRequestEnvSound = true
end

function SeasonAudio:_RequestSound()
  AudioHelperController.RequestUISound(SeasonCriAudio.StepDefault)
  AudioHelperController.RequestUISound(SeasonCriAudio.StepMetal)
  AudioHelperController.RequestUISound(SeasonCriAudio.StepStone)
  AudioHelperController.RequestUISound(SeasonCriAudio.StepWater)
end

function SeasonAudio:_ReleaseAllSound()
  AudioHelperController.StopAllUIVoice()
  for k, v in ipairs(self._audioPlayers) do
    self:_ReleaseSound(v)
  end
  AudioHelperController.ReleaseUISoundById(SeasonCriAudio.StepDefault)
  AudioHelperController.ReleaseUISoundById(SeasonCriAudio.StepMetal)
  AudioHelperController.ReleaseUISoundById(SeasonCriAudio.StepStone)
  AudioHelperController.ReleaseUISoundById(SeasonCriAudio.StepWater)
end

function SeasonAudio:_ReleaseSound(player)
  if player.playerID and player.playerID ~= -1 then
    AudioHelperController.SetInnerVolumeRuntime(player.playerID, CriAudioManager.Instance.SoundVolume)
    AudioHelperController.StopInnerGameSfx(player.playerID, player.audioID)
  end
  table.clear(player)
end

function SeasonAudio:PlayStepSound(mapMaterial, deltaTime)
  if self._stopAllAudio then
    return
  end
  if self._stepTimer == 0 then
    if mapMaterial == SeasonMapMaterial.Default then
      AudioHelperController.PlayUISoundResource(SeasonCriAudio.StepDefault)
    elseif mapMaterial == SeasonMapMaterial.Metal then
      AudioHelperController.PlayUISoundResource(SeasonCriAudio.StepMetal)
    elseif mapMaterial == SeasonMapMaterial.Stone then
      AudioHelperController.PlayUISoundResource(SeasonCriAudio.StepStone)
    elseif mapMaterial == SeasonMapMaterial.Water then
      AudioHelperController.PlayUISoundResource(SeasonCriAudio.StepWater)
    end
  end
  if self._voiceCfg then
    local clock = self._voiceCfg.stepInterval * 1000
    self._stepTimer = self._stepTimer + deltaTime
    if clock < self._stepTimer then
      self._stepTimer = 0
    end
  end
end

function SeasonAudio:PlaySound(audio_id)
  AudioHelperController.PlayUISoundAutoRelease(audio_id)
end

function SeasonAudio:SetLizardVolume()
  if self._daxiyiPlayer and self._daxiyiPlayer.playerID ~= -1 then
    self._daxiyiPlayer.distance = self:_GetPlaneDistance(self._daxiyiPlayer.position, self._cameraTransform.position)
    self:_PlayRadiuSound(self._daxiyiPlayer)
  end
end

function SeasonAudio:PlayLizardAudio(curName)
  if self._daxiyiPlayer and self._daxiyiPlayer.playerID ~= -1 then
    AudioHelperController.StopInnerGameSfx(self._daxiyiPlayer.playerID, self._daxiyiPlayer.audioID)
    self._daxiyiPlayer.playerID = -1
  end
  for k, v in ipairs(self._audioPlayers) do
    if v.isAnimationAudio then
      for key, value in pairs(v.AnimAudioID) do
        if curName == key then
          self._daxiyiPlayer = v
          self._daxiyiPlayer.audioID = value
          break
        end
      end
    end
  end
  if self._daxiyiPlayer.audioID ~= -1 then
    self._daxiyiPlayer.playerID = AudioHelperController.PlayInnerGameSfx(self._daxiyiPlayer.audioID, false)
  else
    self._daxiyiPlayer = nil
  end
end

function SeasonAudio:PlayEventAudio(eventPointType)
  if eventPointType == SeasonEventPointType.MainLevel then
    AudioHelperController.PlayUISoundAutoRelease(SeasonCriAudio.Monster)
  elseif eventPointType == SeasonEventPointType.Box or eventPointType == SeasonEventPointType.SubBox then
    local box1Audio = self._voiceCfg.box1Audio[1]
    local delay = self._voiceCfg.box1Audio[2] * 1000
    AudioHelperController.PlayUISoundAutoRelease(SeasonCriAudio.Box)
    self._event = GameGlobal.Timer():AddEvent(delay, function()
      if not self._stopAllAudio then
        self:_PlayVoice(box1Audio)
      end
    end)
  end
end

function SeasonAudio:_PlayVoice(audioID)
  self:StopSeasonUIVoice()
  if not self._stopAllAudio then
    self._curVoice = AudioHelperController.PlayUIVoiceByAudioId(audioID)
  end
end

function SeasonAudio:StopSeasonUIVoice()
  if self._curVoice then
    AudioHelperController.StopUIVoice(self._curVoice)
  end
end

function SeasonAudio:StopSeasonSounds()
  self._stopAllAudio = true
  self:StopSeasonUIVoice()
  AudioHelperController.PauseBGM()
end

function SeasonAudio:ResumeSeasonSounds()
  self._stopAllAudio = false
  AudioHelperController.UnpauseBGM()
end

function SeasonAudio:PlayVoice(stop)
  self._stopAllAudio = stop
  if stop then
    self:StopSeasonUIVoice()
  end
end
