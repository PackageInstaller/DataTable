local T_DisplayUGUI = typeof(CS.RenderHeads.Media.AVProVideo.DisplayUGUI)
local T_MediaPlayer = typeof(CS.RenderHeads.Media.AVProVideo.MediaPlayer)
local EventType = CS.RenderHeads.Media.AVProVideo.MediaPlayerEvent.EventType
local Event_ReadyToPlay = EventType.ReadyToPlay
local Event_Started = EventType.Started
local Event_Error = EventType.Error
local Event_FinishedPlaying = EventType.FinishedPlaying
local ErrCodeLoadFail = CS.RenderHeads.Media.AVProVideo.ErrorCode.LoadFailed
local ErrDecodeFailed = CS.RenderHeads.Media.AVProVideo.ErrorCode.DecodeFailed
local Matrix4x4_Identity = CS.UnityEngine.Matrix4x4.identity
local QualitySettings_activeColorSpace = CS.UnityEngine.QualitySettings.activeColorSpace
local ColorSpace_Linear = CS.UnityEngine.ColorSpace.Linear
local AVProVideoPlayer, Super = System.NewClass("AVProVideoPlayer")

function AVProVideoPlayer:ctor(mediaPlayerNode)
  Super.ctor(self)
  self.mediaPlayerNode = mediaPlayerNode
  self.looping = false
  self.length = 0
  self.preparedErrorEQFinished = true
  self._checkErrFrameCount = 0
  self.preparedCallback = nil
  self.finishedCallback = nil
  self.startedCallabck = nil
  self.startedCallabck = nil
  self._hasStarted = false
  self.videoPlayerDisplayUGUI = mediaPlayerNode:GetComponent(T_DisplayUGUI)
  self.mediaPlayer = mediaPlayerNode:GetComponent(T_MediaPlayer)
  if not self.mediaPlayer then
    self.mediaPlayer = mediaPlayerNode:GetComponentInChildren(T_MediaPlayer, true)
  end
  self.mediaPlayerNode:SetActive(false)
  self.mediaPlayer.AutoOpen = false
  self.mediaPlayer.AutoStart = false
  self.mediaPlayer.AudioMuted = true
  self.mediaPlayer.Events:AddListener(function(_, eventType, errCode)
    if eventType == Event_ReadyToPlay then
      self.isPreparing = false
      self.length = self.mediaPlayer.Info:GetDuration()
      self:_OnMediaPlayerOpenSuccessed()
    elseif eventType == Event_Started then
      if not self._hasStarted then
        self._hasStarted = true
        if self.startedCallabck then
          self.startedCallabck()
        end
      end
    elseif eventType == Event_Error then
      local errorCallabck = self.errorCallabck
      local isPrepareFail = errCode == ErrCodeLoadFail or errCode == ErrDecodeFailed
      if errorCallabck then
        errorCallabck(isPrepareFail)
      end
      if not isPrepareFail and self.preparedErrorEQFinished then
        self:_OnMediaPlayingFinishedCallabck(true)
      end
    elseif eventType == Event_FinishedPlaying then
      self:_OnMediaPlayingFinishedCallabck(false)
    end
  end)
  if self.videoPlayerDisplayUGUI then
    self.videoPlayerDisplayUGUI.enabled = false
  end
  self:SetLooping(false)
end

function AVProVideoPlayer:OpenMedia(videoUrl)
  self._hasStarted = false
  local isEmpty = string.isempty(videoUrl)
  if isEmpty then
    self.length = 0.001
    self.isPreparing = false
    self.mediaPath = nil
    self:_OnMediaPlayerOpenSuccessed()
    return
  end
  self.isPreparing = true
  videoUrl = videoUrl:replace("\\", "/")
  self.mediaPathType = StrUtils.GetMediaPathType(videoUrl)
  self.mediaPath = StrUtils.GetVideoUrl(videoUrl)
  self.mediaPlayerNode:SetActive(true)
  local openMediaResult = self.mediaPlayer:OpenMedia(self.mediaPathType, self.mediaPath, false)
  if not openMediaResult then
    local errorCallabck = self.errorCallabck
    if errorCallabck then
      errorCallabck(true)
    end
  end
end

function AVProVideoPlayer:SetLooping(looping)
  self.looping = looping
  self.mediaPlayer.Loop = looping
end

function AVProVideoPlayer:GetLength()
  if 0 ~= self.length then
    return self.length
  end
  do return self.mediaPlayer.Info.GetDuration end
  return self.mediaPlayer.Info.GetDuration, self.mediaPlayer.Info
end

function AVProVideoPlayer:SetPlaybackSpeed(speed)
  self.playbackSpeed = speed or 1
  if self.mediaPlayer then
    self.mediaPlayer.PlaybackRate = self.playbackSpeed
  end
end

function AVProVideoPlayer:Play()
  if string.isempty(self.mediaPath) then
    return
  end
  if self.mediaPlayerNode and not IsNil(self.mediaPlayerNode) then
    self.mediaPlayerNode:SetActive(true)
  end
  self.isPlayingVideo = true
  self._checkErrFrameCount = 0
  if self.videoPlayerDisplayUGUI then
    self.videoPlayerDisplayUGUI.enabled = true
  end
  LateUpdateBeat.Instance:Add(self.CheckIsPlayErr, self)
  self.mediaPlayer:Play()
end

function AVProVideoPlayer:CheckIsPlayErr()
  if not self.isPlayingVideo then
    return
  end
  if self.mediaPlayer and self.mediaPlayer.TextureProducer and self.mediaPlayer.TextureProducer:GetTexture() then
    LateUpdateBeat.Instance:Remove(self.CheckIsPlayErr, self)
    return
  end
  self._checkErrFrameCount = self._checkErrFrameCount + 1
  if self._checkErrFrameCount >= 5 then
    LateUpdateBeat.Instance:Remove(self.CheckIsPlayErr, self)
    if self.errorCallabck then
      self.errorCallabck(true)
    end
  end
end

function AVProVideoPlayer:Pause()
  if string.isempty(self.mediaPath) then
    return
  end
  self.mediaPlayer:Pause()
end

function AVProVideoPlayer:SetPosition(pos)
  if self.mediaPlayerNode and not IsNil(self.mediaPlayerNode) then
    self.mediaPlayerNode.transform.localPosition = pos
  end
end

function AVProVideoPlayer:SetAsLastSibling()
  if self.mediaPlayerNode and not IsNil(self.mediaPlayerNode) then
    self.mediaPlayerNode.transform:SetAsLastSibling()
  end
end

function AVProVideoPlayer:Rewind(pause)
  if string.isempty(self.mediaPath) then
    return
  end
  self.mediaPlayer:Rewind(pause)
end

function AVProVideoPlayer:SeekToLiveTime(time)
  if string.isempty(self.mediaPath) then
    return
  end
  self.mediaPlayer:SeekToLiveTime(time)
end

function AVProVideoPlayer:Seek(time)
  if string.isempty(self.mediaPath) then
    return
  end
  self.mediaPlayer.Control:Seek(time)
end

function AVProVideoPlayer:SeekFast(time)
  if string.isempty(self.mediaPath) then
    return
  end
  self.mediaPlayer.Control:SeekFast(time)
end

function AVProVideoPlayer:GetCurrentTime()
  if string.isempty(self.mediaPath) then
    return 0
  end
  do return self.mediaPlayer.Control.GetCurrentTime end
  return self.mediaPlayer.Control.GetCurrentTime, self.mediaPlayer.Control
end

function AVProVideoPlayer:GetTexture(idx)
  if string.isempty(self.mediaPath) then
    return
  end
  idx = idx or 0
  do return self.mediaPlayer.TextureProducer.GetTexture, self.mediaPlayer.TextureProducer end
  return self.mediaPlayer.TextureProducer.GetTexture, self.mediaPlayer.TextureProducer, idx
end

function AVProVideoPlayer:RequiresVerticalFlip()
  if string.isempty(self.mediaPath) then
    return false
  end
  if not self.mediaPlayer.TextureProducer then
    return false
  end
  do return self.mediaPlayer.TextureProducer.RequiresVerticalFlip end
  return self.mediaPlayer.TextureProducer.RequiresVerticalFlip, self.mediaPlayer.TextureProducer
end

function AVProVideoPlayer:UseGammaMaterial()
  if string.isempty(self.mediaPath) then
    return false
  end
  if not self.mediaPlayer.Info then
    return false
  end
  local playerSupportsLinear = self.mediaPlayer.Info:PlayerSupportsLinearColorSpace()
  if QualitySettings_activeColorSpace == ColorSpace_Linear and not playerSupportsLinear then
    return true
  end
  return false
end

function AVProVideoPlayer:IsSupportedYpCbCr()
  return false
end

function AVProVideoPlayer:GetYpCbCrTransform()
  if string.isempty(self.mediaPath) then
    return Matrix4x4_Identity
  end
  if not self.mediaPlayer.TextureProducer then
    return Matrix4x4_Identity
  end
  do return self.mediaPlayer.TextureProducer.GetYpCbCrTransform end
  return self.mediaPlayer.TextureProducer.GetYpCbCrTransform, self.mediaPlayer.TextureProducer
end

function AVProVideoPlayer:GetYpCbCrTexture()
  do return self.GetTexture, self end
  return self.GetTexture, self, 1
end

function AVProVideoPlayer:OnApplicationPause()
  if not IsNil(self.mediaPlayer) then
    self.mediaPlayer.enabled = false
  end
end

function AVProVideoPlayer:OnApplicationResume()
  if not IsNil(self.mediaPlayer) then
    self.mediaPlayer.enabled = true
  end
end

function AVProVideoPlayer:Stop()
  self._hasStarted = false
  self.isPreparing = false
  LateUpdateBeat.Instance:Remove(self.CheckIsPlayErr, self)
  self.length = 0
  if self.isPlayingVideo and not IsNil(self.mediaPlayer) then
    self.mediaPlayer:Stop()
    self.mediaPlayerNode:SetActive(false)
    if self.videoPlayerDisplayUGUI then
      self.videoPlayerDisplayUGUI.enabled = false
    end
  end
  self.isPlayingVideo = false
end

function AVProVideoPlayer:RemoveAllListeners()
  self.preparedCallback = nil
  self.startedCallabck = nil
  self.finishedCallback = nil
end

function AVProVideoPlayer:CloseMedia()
  self:Stop()
  self.isPreparing = false
  if self.mediaPath then
    self.mediaPath = nil
    if not IsNil(self.mediaPlayer) then
      self.mediaPlayer:CloseMedia()
    end
  end
end

function AVProVideoPlayer:Dispose()
  self:Stop()
  self:CloseMedia()
  self:RemoveAllListeners()
  if not IsNil(self.mediaPlayer) then
    self.mediaPlayer.Events:RemoveAllListeners()
  end
  self.mediaPlayerNode = nil
  self.mediaPlayer = nil
end

function AVProVideoPlayer:_OnMediaPlayerOpenSuccessed()
  local preparedCallback = self.preparedCallback
  if preparedCallback then
    preparedCallback(true)
  end
end

function AVProVideoPlayer:_OnMediaPlayingFinishedCallabck(errorOccued)
  local finishedCallback = self.finishedCallback
  self.finishedCallback = nil
  if finishedCallback then
    finishedCallback(errorOccued)
  end
end

return AVProVideoPlayer
