local T_VideoPlayer = typeof(CS.UnityEngine.Video.VideoPlayer)
local T_RawImage = typeof(CS.UnityEngine.UI.RawImage)
local Matrix4x4_Identity = CS.UnityEngine.Matrix4x4.identity
local UnityVideoPlayer, Super = System.NewClass("UnityVideoPlayer")

function UnityVideoPlayer:ctor(playerNode)
  Super.ctor(self)
  self.playerNode = playerNode
  self.looping = false
  self.length = 0
  self.preparedErrorEQFinished = true
  self.preparedCallback = nil
  self.finishedCallback = nil
  self.startedCallabck = nil
  self.errorCallabck = nil
  self.targetRawImage = playerNode:GetComponent(T_RawImage)
  self.videoPlayer = playerNode:GetComponent(T_VideoPlayer)
  if not self.videoPlayer then
    self.videoPlayer = playerNode:GetComponentInChildren(T_VideoPlayer, true)
  end
  self.playerNode:SetActive(false)
  self.videoPlayer.playOnAwake = false
  
  local function onVideoPrepareCompleted()
    if not self.isPreparing then
      return
    end
    self.isPreparing = false
    self.length = self.videoPlayer.length
    local preparedCallback = self.preparedCallback
    if preparedCallback then
      preparedCallback(true)
    end
  end
  
  local function onVideoPlayedStarted()
    if self.targetRawImage then
      self.targetRawImage.texture = self.videoPlayer.texture
      self.targetRawImage.enabled = true
    end
    local startedCallabck = self.startedCallabck
    if startedCallabck then
      startedCallabck()
    end
  end
  
  local function onVideoLoopPointReached()
    local finishedCallback = self.finishedCallback
    if finishedCallback then
      finishedCallback(false)
    end
  end
  
  local function onVideoErrorReceived()
    local errorCallabck = self.errorCallabck
    if errorCallabck then
      errorCallabck()
    end
    if self.preparedErrorEQFinished then
      local finishedCallback = self.finishedCallback
      if finishedCallback then
        finishedCallback(true)
      end
    end
  end
  
  self.innerVideoPrepareCompleted = onVideoPrepareCompleted
  self.innerVideoPlayedStarted = onVideoPlayedStarted
  self.innerVideoLoopPointReached = onVideoLoopPointReached
  self.innerVideoErrorReceived = onVideoErrorReceived
  self.videoPlayer:prepareCompleted("+", onVideoPrepareCompleted)
  self.videoPlayer:started("+", onVideoPlayedStarted)
  self.videoPlayer:loopPointReached("+", onVideoLoopPointReached)
  self.videoPlayer:errorReceived("+", onVideoErrorReceived)
  if self.targetRawImage then
    self.targetRawImage.enabled = false
  end
  self:SetLooping(false)
end

function UnityVideoPlayer:OpenMedia(videoUrl)
  if string.isempty(videoUrl) or "Black" == videoUrl or string.find(videoUrl, "Slime_01_Normal.mp4") then
    self.length = 0.001
    self.isPreparing = false
    self.mediaPath = nil
    if self.preparedCallback then
      self.preparedCallback(true)
    end
    return
  end
  self.isPreparing = true
  videoUrl = videoUrl:replace("\\", "/")
  self.mediaPath = StrUtils.GetVideoUrl(videoUrl)
  self.videoPlayer.url = self.mediaPath
  self.playerNode:SetActive(true)
  self.videoPlayer:Prepare()
end

function UnityVideoPlayer:SetLooping(looping)
  self.looping = looping
  self.videoPlayer.isLooping = looping
end

function UnityVideoPlayer:GetLength()
  if 0 ~= self.length then
    return self.length
  end
  return self.videoPlayer and self.videoPlayer.length or 0
end

function UnityVideoPlayer:SetPlaybackSpeed(speed)
  self.playbackSpeed = speed or 1
  if not IsNil(self.videoPlayer) then
    self.videoPlayer.playbackSpeed = self.playbackSpeed
  end
end

function UnityVideoPlayer:Play()
  if string.isempty(self.mediaPath) then
    return
  end
  if not IsNil(self.playerNode) then
    self.playerNode:SetActive(true)
  end
  if not IsNil(self.videoPlayer) then
    self.videoPlayer:Play()
  end
end

function UnityVideoPlayer:Pause()
  if string.isempty(self.mediaPath) then
    return
  end
  if not IsNil(self.videoPlayer) then
    self.videoPlayer:Pause()
  end
end

function UnityVideoPlayer:SetPosition(pos)
  if not IsNil(self.playerNode) then
    self.playerNode.transform.localPosition = pos
  end
end

function UnityVideoPlayer:SetAsLastSibling()
  if self.playerNode then
    self.playerNode.transform:SetAsLastSibling()
  end
end

function UnityVideoPlayer:Rewind()
end

function UnityVideoPlayer:SeekToLiveTime(time)
  self:Seek(time)
end

function UnityVideoPlayer:Seek(time)
  if string.isempty(self.mediaPath) then
    return
  end
  if self.videoPlayer then
    local timeReference = self.videoPlayer.timeReference
    self.videoPlayer.timeReference = 2
    self.videoPlayer.externalReferenceTime = time
    self.videoPlayer.timeReference = timeReference
  end
end

function UnityVideoPlayer:SeekFast(time)
  self:Seek(time)
end

function UnityVideoPlayer:GetCurrentTime()
  if string.isempty(self.mediaPath) then
    return 0
  end
  if self.videoPlayer.activeSelf then
    return self.videoPlayer.time
  end
  return 0
end

function UnityVideoPlayer:GetTexture()
  if string.isempty(self.mediaPath) then
    return
  end
  if self.videoPlayer then
    return self.videoPlayer.texture
  end
end

function UnityVideoPlayer:IsSupportedYpCbCr()
  return false
end

function UnityVideoPlayer:RequiresVerticalFlip()
  return false
end

function UnityVideoPlayer:UseGammaMaterial()
  return false
end

function UnityVideoPlayer:GetYpCbCrTransform()
  return Matrix4x4_Identity
end

function UnityVideoPlayer:GetYpCbCrTexture()
  do return self.GetTexture end
  return self.GetTexture, self
end

function UnityVideoPlayer:Stop()
  self.isPreparing = false
  self.length = 0
  if not IsNil(self.videoPlayer) then
    self.videoPlayer:Stop()
    self.playerNode:SetActive(false)
    if self.targetRawImage then
      self.targetRawImage.enabled = false
      self.targetRawImage.texture = nil
    end
  end
end

function UnityVideoPlayer:OnApplicationPause()
  self:Pause()
end

function UnityVideoPlayer:OnApplicationResume()
  self:Play()
end

function UnityVideoPlayer:RemoveAllListeners()
  self.preparedCallback = nil
  self.finishedCallback = nil
  self.startedCallabck = nil
  self.errorCallabck = nil
end

function UnityVideoPlayer:CloseMedia()
  self:Stop()
  self.isPreparing = false
  self.mediaPath = nil
end

function UnityVideoPlayer:Dispose()
  self:Stop()
  self:CloseMedia()
  self:RemoveAllListeners()
  if not IsNil(self.videoPlayer) then
    if self.innerVideoPrepareCompleted then
      self.videoPlayer:prepareCompleted("-", self.innerVideoPrepareCompleted)
    end
    if self.innerVideoPlayedStarted then
      self.videoPlayer:started("-", self.innerVideoPlayedStarted)
    end
    if self.innerVideoLoopPointReached then
      self.videoPlayer:loopPointReached("-", self.innerVideoLoopPointReached)
    end
    if self.innerVideoErrorReceived then
      self.videoPlayer:errorReceived("-", self.innerVideoErrorReceived)
    end
  end
  self.videoPlayer = nil
  self.playerNode = nil
  self.innerVideoPrepareCompleted = nil
  self.innerVideoPlayedStarted = nil
  self.innerVideoLoopPointReached = nil
  self.innerVideoErrorReceived = nil
  self:RemoveAllListeners()
end

return UnityVideoPlayer
