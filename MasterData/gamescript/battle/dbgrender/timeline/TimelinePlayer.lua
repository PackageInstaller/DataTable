local AMPlayer = CS.AMTimeline.AMPlayer
local EvtAMplayedFinished = AMPlayer.AMPlayerEvt_Stop
local AMPlayerEvt_EarlyTermination = AMPlayer.AMPlayerEvt_EarlyTermination
local EvtAMplayedStarted = AMPlayer.AMPlayerEvt_StartPlaying
local TimelinePlayer = System.NewClass("TimelinePlayer")

function TimelinePlayer:ctor(player)
  self.player = player
  self.videoPlayers = nil
end

function TimelinePlayer:Seek(seekTime)
  self.seekTime = seekTime
  return self
end

function TimelinePlayer:StopLooping()
  if self.amPlayer then
    self.amPlayer:StopLooping()
  end
  return self
end

function TimelinePlayer:IsPlaying()
  return self.amPlayer and self.isPlaying
end

function TimelinePlayer:SetLoopingTimes(times)
  if self.amPlayer then
    self.amPlayer:SetLoopingTimes(times or 0)
  end
  return self
end

function TimelinePlayer:GetDirector()
  if self.amPlayer then
    return self.amPlayer.director
  end
end

function TimelinePlayer:SetSpeed(gameSpeed)
  if self.amPlayer and not IsNil(self.amPlayer) then
    self.amPlayer:SetSpeed(gameSpeed)
  end
end

function TimelinePlayer:Play(config)
  Logger.Info("TimelinePlayer:Play", config.assetPath)
  if self.amPlayer then
    self.amPlayer:Stop()
    CS.UnityEngine.GameObject.Destroy(self.amPlayer)
  end
  self:StopAllVideoPlayers()
  self.amPlayer = self.player:AddComponent(typeof(AMPlayer))
  self:AddBindings()
  self.isPlaying = true
  self.isPlayedStop = false
  self:_ResumeGameSpeed()
  self.playingConfig = config
  local abortSignal = config.abortSignal
  local onComplete = config.onComplete
  local onEarlyTermination = config.onEarlyTermination
  local onEvent = config.onEvent
  local onStarted = config.onStarted
  if abortSignal then
    abortSignal:AddListener(System.fn(self, self.OnAbort))
  end
  if config.centerPosition then
    self.amPlayer:SetCenterPosition(config.centerPosition)
  end
  self.playbackSpeed = config.playbackSpeed or 1
  self.amPlayer:SetTargets(config.targets)
  self.amPlayer.useSmoothTime = config.useSmoothTime or false
  self.amPlayer:SetSpeed(config.playbackSpeed or 1)
  self.amPlayer:SetTarget(config.aceTarget and config.aceTarget.transform or nil)
  self.amPlayer:SetLoopingTimes(config.looping or 0)
  self.amPlayer:SetControlChildrenTargetIndex(config.controlChildrenTargetIndex or -1)
  self.amPlayer:Seek(config.seekTime or 0)
  self.amPlayer:SetLoadResSync(self.isSync)
  self.amPlayer:EnableEarlyTermination(config.onEarlyTermination ~= nil)
  if config.OnBeforePlay then
    config.OnBeforePlay()
  end
  local direction = TimelineConfig.CheckFinalDirection(config.assetPath, config.direction)
  self.amPlayer:Play(self.player, config.assetPath, direction, function(evtType)
    if evtType == EvtAMplayedFinished then
      TimelineTargetSlashController.Instance:Restore(self, false)
      self.isPlaying = false
      if abortSignal then
        abortSignal:RemoveListener(System.fn(self, self.OnAbort))
      end
      self:_ResumeGameSpeed()
      if onComplete then
        onComplete()
      end
    end
    if evtType == EvtAMplayedStarted and onStarted then
      onStarted()
    end
    if evtType == AMPlayerEvt_EarlyTermination and onEarlyTermination then
      onEarlyTermination()
    end
  end, function(evtId, evtParams, evtParams1)
    self:OnTLEvent(evtId, evtParams, evtParams1)
    if onEvent then
      onEvent(evtId, evtParams, evtParams1)
    end
  end)
  return self
end

function TimelinePlayer:AddBindings()
end

function TimelinePlayer:AddBindingGameObject(name, go)
  if self.amPlayer then
    self.amPlayer:AddBindingGameObject(name, go)
  end
end

function TimelinePlayer:ClearBindingGameObject()
  if self.amPlayer then
    self.amPlayer:ClearBindingGameObject()
  end
end

function TimelinePlayer:Pause()
  if self.amPlayer then
    self.amPlayer:Pause()
  end
  self:PauseVideoPlayers()
end

function TimelinePlayer:Resume()
  if self.amPlayer then
    self.amPlayer:Resume()
  end
  self:ResumeVideoPlayers()
end

function TimelinePlayer:Stop()
  if not self.isPlaying then
    return
  end
  TimelineTargetSlashController.Instance:Restore(self, true)
  self:_ResumeGameSpeed()
  self.isPlaying = false
  self:StopAllVideoPlayers()
  if self.playingConfig and self.playingConfig.abortSignal then
    self.playingConfig.abortSignal:RemoveListener(System.fn(self, self.OnAbort))
  end
  if not IsNil(self.amPlayer) then
    self.amPlayer:Stop()
    self.amPlayer.enabled = false
  end
  self.playingConfig = nil
end

function TimelinePlayer:_ResumeGameSpeed()
  if self.isBanSpeedUp then
    self.isBanSpeedUp = false
    bg.BanSpeedCount = bg.BanSpeedCount - 1
    if bg.battlePanel and bg.BanSpeedCount <= 0 and bg.battlePanel.ResumeGameSpeedAfterTL then
      bg.battlePanel:ResumeGameSpeedAfterTL()
    end
  end
end

function TimelinePlayer:OnAbort()
  self:Stop()
end

function TimelinePlayer:Dispose()
  TimelineTargetSlashController.Instance:Restore(self, true)
  self:_ResumeGameSpeed()
  self:StopAllVideoPlayers()
  local amPlayer = self.amPlayer
  self.amPlayer = nil
  self.isPlaying = false
  self:ClearBindingGameObject()
  if not IsNil(amPlayer) then
    amPlayer:Stop()
    amPlayer.enabled = false
    CS.UnityEngine.GameObject.Destroy(amPlayer)
  end
  self.player = nil
end

function TimelinePlayer:OnTLEvent(eventId, eventParam)
  Logger.Info("OnTLEvent", eventId, eventParam)
  if not self.amPlayer then
    return
  end
  if eventId == rc.TimeLineEvent.WWiseEvent then
    AudioManager.Instance:PostSoundEvent(eventParam)
  elseif eventId == rc.TimeLineEvent.HideUI then
    if bg.battlePanel then
      bg.battlePanel:HideUI(true)
    end
  elseif eventId == rc.TimeLineEvent.ShowUI then
    if bg.battlePanel then
      bg.battlePanel:HideUI(false)
    end
  elseif eventId == rc.TimeLineEvent.MainVMCamera then
    if bg.battleScene then
      bg.battleScene:ChangeDefaultVMCamera(eventParam)
    end
  elseif eventId == rc.TimeLineEvent.PrepareVideos then
    self:ParareVideoPlayer(eventParam)
  elseif eventId == rc.TimeLineEvent.PlayVideo then
    self:PlayVideoPlayer(eventParam)
  elseif eventId == rc.TimeLineEvent.StopVideo then
    self:StopVideoPlayer(eventParam)
  elseif eventId == rc.TimeLineEvent.ShowAwakerPaintingById then
    if bg.battleScene then
      local awakerId = tonumber(eventParam)
      bg.battleScene:ShowAwakerPaintingById(awakerId)
    end
  elseif eventId == rc.TimeLineEvent.HideSchoolTable then
    if bg.battleScene then
      bg.battleScene:HideSchoolTable()
    end
  elseif eventId == rc.TimeLineEvent.ShowSchoolTable then
    if bg.battleScene then
      bg.battleScene:ShowSchoolTable()
    end
  elseif eventId == rc.TimeLineEvent.BanSpeedUp then
    self.isBanSpeedUp = true
    bg.BanSpeedCount = bg.BanSpeedCount + 1
    if bg.battleRender then
      bg.battleRender.gameSpeed = 1
    end
    if self.amPlayer then
      self.amPlayer:SetSpeed(1)
    end
    self:UpdateVideoPlaybackSpeed()
  elseif eventId == rc.TimeLineEvent.ShaderGlobal then
    TimelineShaderGlobalController.Instance:Start(eventParam)
  elseif eventId == rc.TimeLineEvent.TargetSlashProgress then
    TimelineTargetSlashController.Instance:Start(self, eventParam)
  end
end

function TimelinePlayer:UpdateVideoPlaybackSpeed()
  if self.videoPlayers then
    for _, videoPlayer in pairs(self.videoPlayers) do
      videoPlayer:SetPlaybackSpeed(self.isBanSpeedUp and 1 or self.playbackSpeed)
    end
  end
end

function TimelinePlayer:SetTrackPlayMode(mode)
  self.trackPlayMode = mode
end

function TimelinePlayer:SetLoadResSync(isSync)
  self.isSync = isSync
end

function TimelinePlayer:GetAMObject(name)
  if self.amPlayer then
    do return self.amPlayer.GetAMObject, self.amPlayer end
    return self.amPlayer.GetAMObject, self.amPlayer, name
  end
end

function TimelinePlayer:GetBindingGameObject(name)
  if self.amPlayer then
    do return self.amPlayer.GetBindingGameObject, self.amPlayer end
    return self.amPlayer.GetBindingGameObject, self.amPlayer, name
  end
end

function TimelinePlayer:ParareVideoPlayer(videoParams)
  if not self.isPlaying then
    return
  end
  self.videoPlayers = self.videoPlayers or {}
  if not self.videoPlayers[videoParams] then
    self.videoPlayers[videoParams] = TimelineVideoPlayer(videoParams, self)
    self.videoPlayers[videoParams]:OpenMedia()
    self.videoPlayers[videoParams]:SetPlaybackSpeed(self.isBanSpeedUp and 1 or self.playbackSpeed)
  end
end

function TimelinePlayer:PlayVideoPlayer(videoParams)
  if not self.isPlaying then
    return
  end
  self.videoPlayers = self.videoPlayers or {}
  if not self.videoPlayers[videoParams] then
    self.videoPlayers[videoParams] = TimelineVideoPlayer(videoParams, self)
    self.videoPlayers[videoParams]:SetAutoPlayedOnPrepared(true)
    self.videoPlayers[videoParams]:OpenMedia()
    self.videoPlayers[videoParams]:SetPlaybackSpeed(self.isBanSpeedUp and 1 or self.playbackSpeed)
  else
    self.videoPlayers[videoParams]:PlayVideo()
  end
end

function TimelinePlayer:StopVideoPlayer(videoParams)
  if self.videoPlayers and self.videoPlayers[videoParams] then
    self.videoPlayers[videoParams]:StopVideo()
  end
end

function TimelinePlayer:PauseVideoPlayers()
  if not self.isPlaying or not self.videoPlayers then
    return
  end
  for k, v in pairs(self.videoPlayers) do
    v:SetPlaybackSpeed(0)
  end
end

function TimelinePlayer:SeekVideoTime(time)
  if not self.isPlaying or not self.videoPlayers then
    return
  end
  for k, v in pairs(self.videoPlayers) do
    v:Seek(time)
  end
end

function TimelinePlayer:ResumeVideoPlayers()
  if not self.isPlaying or not self.videoPlayers then
    return
  end
  for k, v in pairs(self.videoPlayers) do
    v:SetPlaybackSpeed(self.isBanSpeedUp and 1 or self.playbackSpeed)
  end
end

function TimelinePlayer:StopAllVideoPlayers()
  if self.videoPlayers then
    for _, v in pairs(self.videoPlayers) do
      v:StopVideo()
    end
    self.videoPlayers = nil
  end
end

function TimelinePlayer:HideVideoPlayers()
  if self.videoPlayers then
    for _, v in pairs(self.videoPlayers) do
      v:HideVideoGameObject()
    end
  end
end

function TimelinePlayer:ShowVideoPlayers()
  if self.videoPlayers then
    for _, v in pairs(self.videoPlayers) do
      v:ShowVideoGameObject()
    end
  end
end

return TimelinePlayer
