local GameVideoPlayer, Super = System.NewClass("GameVideoPlayer")
local Matrix4x4_Identity = CS.UnityEngine.Matrix4x4.identity
local T_Graphic = typeof(CS.UnityEngine.UI.Graphic)
local BlackTexVideo = {
  "Slime_01_Normal.mp4",
  "Common_Switch_Rgb.mp4"
}

function GameVideoPlayer:ctor(mediaPlayerNode, bakMediaPlayerNode, forceUnityPlayer)
  Super.ctor(self)
  self.mediaPlayer = AVProVideoPlayer(mediaPlayerNode)
  self.mediaPlayer.preparedErrorEQFinished = false
  if bakMediaPlayerNode then
    self.bakMediaPlayer = UnityVideoPlayer(bakMediaPlayerNode)
    self.bakMediaPlayer.preparedErrorEQFinished = false
  else
    error("GameVideoPlayer 缺少 bak节点，请参考登录界面的bak，添加一个节点")
  end
  self.looping = false
  self.useBakMediaPlayer = false
  self.forceUnityPlayer = forceUnityPlayer
  self.length = 0
  self.preparedCallback = nil
  self.finishedCallback = nil
  self.startedCallabck = nil
  self._hasStarted = false
  self:SetCallbacks()
end

function GameVideoPlayer:SetCallbacks()
  if not self.mediaPlayer then
    return
  end
  if IsNil(self.mediaPlayer.mediaPlayerNode) then
    return
  end
  
  function self.mediaPlayer.preparedCallback(isSuccess)
    if isSuccess then
      self.isPreparing = false
      self.length = self.mediaPlayer:GetLength()
      print("[AVProVideoPlayer] video Open succcessed!!, path=", self.mediaPath)
      self:_OnMediaOpenedCallabck(true)
    end
  end
  
  function self.mediaPlayer.startedCallabck()
    Logger.Info(string.format("[PV-Trace] GVP.started which=AVPro hasStarted=%s path=%s wallT=%.3f", tostring(self._hasStarted), tostring(self.mediaPath), CS.UnityEngine.Time.realtimeSinceStartup))
    if self._hasStarted then
      return
    end
    self._hasStarted = true
    if self.startedCallabck then
      self.startedCallabck()
    end
  end
  
  function self.mediaPlayer.errorCallabck(isPrepareFail)
    if isPrepareFail or self.isPreparing then
      print("[AVProVideoPlayer]video Open failed，use bak, path=", self.mediaPath)
      GameVideoPlayer.forceUseBakMediaPlayer = true
      self:_OnMainMediaPlayerOpenError()
    end
  end
  
  function self.mediaPlayer.finishedCallback(isErrorOccu)
    self:_OnMediaPlayingFinishedCallabck(isErrorOccu)
  end
  
  if self.bakMediaPlayer then
    function self.bakMediaPlayer.preparedCallback(isSuccess)
      self.isPreparing = false
      
      self.length = self.bakMediaPlayer:GetLength()
      print("[AVProVideoPlayer]bak video Open succcessed, path=", self.mediaPath)
      self:_OnMediaOpenedCallabck(true)
    end
    
    function self.bakMediaPlayer.startedCallabck()
      Logger.Info(string.format("[PV-Trace] GVP.started which=Unity hasStarted=%s path=%s wallT=%.3f", tostring(self._hasStarted), tostring(self.mediaPath), CS.UnityEngine.Time.realtimeSinceStartup))
      if self._hasStarted then
        return
      end
      self._hasStarted = true
      if self.startedCallabck then
        self.startedCallabck()
      end
    end
    
    function self.bakMediaPlayer.errorCallabck()
      if self.isPreparing then
        print("[AVProVideoPlayer]bak video Open failed, path=", self.mediaPath)
        self:_OnMediaOpenedCallabck(false)
      else
        self:_OnMediaPlayingErrorCallabck()
      end
    end
    
    function self.bakMediaPlayer.finishedCallback(isErrorOccu)
      self:_OnMediaPlayingFinishedCallabck(isErrorOccu)
    end
  end
end

function GameVideoPlayer:OpenMedia(videoUrl)
  VideoPreparedQueue.Instance:OpenMedia(videoUrl, self)
end

function GameVideoPlayer:StartPrepared(videoUrl, extraPrepareFunc)
  self._hasStarted = false
  self.isPreparing = true
  self.useBakMediaPlayer = false
  self.mediaPath = videoUrl
  self.extraPrepareFunc = extraPrepareFunc
  local isEmpty = string.isempty(videoUrl)
  local withBlackTex = false
  if not isEmpty then
    for _, v in pairs(BlackTexVideo) do
      if string.find(videoUrl, v) then
        withBlackTex = true
        break
      end
    end
  end
  if isEmpty or withBlackTex then
    self.isPreparing = false
    self.mediaPath = nil
    self:_OnMediaOpenedCallabck(true)
    return
  end
  if GameVideoPlayer.forceUseBakMediaPlayer or self.forceUnityPlayer or SdkMgr.Instance:IsSimulator() then
    self:_OnMainMediaPlayerOpenError()
    return
  end
  self.mediaPlayer:OpenMedia(videoUrl)
end

function GameVideoPlayer:SetLooping(looping)
  self.looping = looping
  if self.mediaPlayer then
    self.mediaPlayer:SetLooping(looping)
  end
  if self.bakMediaPlayer then
    self.bakMediaPlayer:SetLooping(looping)
  end
end

function GameVideoPlayer:SetPlaybackSpeed(speed)
  self.playbackSpeed = speed or 1
  if self.mediaPlayer then
    self.mediaPlayer:SetPlaybackSpeed(self.playbackSpeed)
  end
  if self.bakMediaPlayer then
    self.bakMediaPlayer:SetPlaybackSpeed(self.playbackSpeed)
  end
end

function GameVideoPlayer:GetLength()
  if 0 ~= self.length then
    return self.length
  end
  if not self.useBakMediaPlayer then
    do return self.mediaPlayer.GetLength end
    return self.mediaPlayer.GetLength, self.mediaPlayer
  end
  if self.bakMediaPlayer then
    do return self.bakMediaPlayer.GetLength end
    return self.bakMediaPlayer.GetLength, self.bakMediaPlayer
  end
  return 0
end

function GameVideoPlayer:Play()
  self._isPaused = false
  if string.isempty(self.mediaPath) then
    return
  end
  if not self.useBakMediaPlayer then
    self.mediaPlayer:Play()
  elseif self.bakMediaPlayer then
    self.bakMediaPlayer:Play()
  end
  if AVProManager.Instance then
    AVProManager.Instance:OnActiveVideo(self)
  end
end

function GameVideoPlayer:Pause()
  self._isPaused = true
  if string.isempty(self.mediaPath) then
    return
  end
  if not self.useBakMediaPlayer then
    self.mediaPlayer:Pause()
    return
  end
  if self.bakMediaPlayer then
    self.bakMediaPlayer:Pause()
  end
end

function GameVideoPlayer:SetPosition(pos)
  if self.mediaPlayer then
    self.mediaPlayer:SetPosition(pos)
  end
  if self.bakMediaPlayer then
    self.bakMediaPlayer:SetPosition(pos)
  end
end

function GameVideoPlayer:SetAsLastSibling()
  if self.mediaPlayer then
    self.mediaPlayer:SetAsLastSibling()
  end
  if self.bakMediaPlayer then
    self.bakMediaPlayer:SetAsLastSibling()
  end
end

function GameVideoPlayer:Rewind(pause)
  if string.isempty(self.mediaPath) then
    return
  end
  if not self.useBakMediaPlayer then
    self.mediaPlayer:Rewind(pause)
  end
  if self.bakMediaPlayer then
    self.bakMediaPlayer:Rewind(pause)
  end
end

function GameVideoPlayer:SeekToLiveTime(time)
  if string.isempty(self.mediaPath) then
    return
  end
  if not self.useBakMediaPlayer then
    self.mediaPlayer:SeekToLiveTime(time)
  end
  if self.bakMediaPlayer then
    self.bakMediaPlayer:SeekToLiveTime(time)
  end
end

function GameVideoPlayer:Seek(time)
  if string.isempty(self.mediaPath) then
    return
  end
  if not self.useBakMediaPlayer then
    self.mediaPlayer:Seek(time)
  end
  if self.bakMediaPlayer then
    self.bakMediaPlayer:Seek(time)
  end
end

function GameVideoPlayer:SeekFast(time)
  if string.isempty(self.mediaPath) then
    return
  end
  if not self.useBakMediaPlayer then
    self.mediaPlayer:SeekFast(time)
  end
  if self.bakMediaPlayer then
    self.bakMediaPlayer:SeekFast(time)
  end
end

function GameVideoPlayer:GetCurrentTime()
  if string.isempty(self.mediaPath) then
    return 0
  end
  if not self.useBakMediaPlayer then
    do return self.mediaPlayer.GetCurrentTime end
    return self.mediaPlayer.GetCurrentTime, self.mediaPlayer
  end
  if self.bakMediaPlayer then
    do return self.bakMediaPlayer.GetCurrentTime end
    return self.bakMediaPlayer.GetCurrentTime, self.bakMediaPlayer
  end
end

function GameVideoPlayer:GetTexture(idx)
  if string.isempty(self.mediaPath) then
    return
  end
  idx = idx or 0
  if not self.useBakMediaPlayer then
    do return self.mediaPlayer.GetTexture, self.mediaPlayer end
    return self.mediaPlayer.GetTexture, self.mediaPlayer, idx
  end
  if self.bakMediaPlayer then
    do return self.bakMediaPlayer.GetTexture, self.bakMediaPlayer end
    return self.bakMediaPlayer.GetTexture, self.bakMediaPlayer, idx
  end
end

function GameVideoPlayer:RequiresVerticalFlip()
  if string.isempty(self.mediaPath) then
    return false
  end
  if not self.useBakMediaPlayer then
    do return self.mediaPlayer.RequiresVerticalFlip end
    return self.mediaPlayer.RequiresVerticalFlip, self.mediaPlayer
  end
  if self.bakMediaPlayer then
    do return self.bakMediaPlayer.RequiresVerticalFlip end
    return self.bakMediaPlayer.RequiresVerticalFlip, self.bakMediaPlayer
  end
end

function GameVideoPlayer:UseGammaMaterial()
  if string.isempty(self.mediaPath) then
    return false
  end
  if not self.useBakMediaPlayer then
    do return self.mediaPlayer.UseGammaMaterial end
    return self.mediaPlayer.UseGammaMaterial, self.mediaPlayer
  end
  if self.bakMediaPlayer then
    do return self.bakMediaPlayer.UseGammaMaterial end
    return self.bakMediaPlayer.UseGammaMaterial, self.bakMediaPlayer
  end
  return false
end

function GameVideoPlayer:IsSupportedYpCbCr()
  if string.isempty(self.mediaPath) then
    return false
  end
  if not self.useBakMediaPlayer then
    do return self.mediaPlayer.IsSupportedYpCbCr end
    return self.mediaPlayer.IsSupportedYpCbCr, self.mediaPlayer
  end
  if self.bakMediaPlayer then
    do return self.bakMediaPlayer.IsSupportedYpCbCr end
    return self.bakMediaPlayer.IsSupportedYpCbCr, self.bakMediaPlayer
  end
end

function GameVideoPlayer:GetYpCbCrTransform()
  if string.isempty(self.mediaPath) then
    return Matrix4x4_Identity
  end
  if not self.useBakMediaPlayer then
    do return self.mediaPlayer.GetYpCbCrTransform end
    return self.mediaPlayer.GetYpCbCrTransform, self.mediaPlayer
  end
  if self.bakMediaPlayer then
    do return self.bakMediaPlayer.GetYpCbCrTransform end
    return self.bakMediaPlayer.GetYpCbCrTransform, self.bakMediaPlayer
  end
  return Matrix4x4_Identity
end

function GameVideoPlayer:GetYpCbCrTexture()
  do return self.GetTexture, self end
  return self.GetTexture, self, 1
end

function GameVideoPlayer:Stop()
  self._hasStarted = false
  VideoPreparedQueue.Instance:CloseMedia(self)
  self.isPreparing = false
  self._isPaused = false
  self.length = 0
  if self.mediaPlayer then
    self.mediaPlayer:Stop()
  end
  if self.bakMediaPlayer then
    self.bakMediaPlayer:Stop()
  end
  if AVProManager.Instance then
    AVProManager.Instance:OnDeactiveVideo(self)
  end
end

function GameVideoPlayer:RemoveAllListeners()
  self.extraPrepareFunc = nil
  self.preparedCallback = nil
  self.startedCallabck = nil
  self.finishedCallback = nil
end

function GameVideoPlayer:CloseMedia()
  self:_KillFadeTweens()
  self:Stop()
  self.isPreparing = false
  self:RemoveAllListeners()
  if self.mediaPath then
    self.mediaPath = nil
    if self.mediaPlayer then
      self.mediaPlayer:CloseMedia()
    end
    if self.bakMediaPlayer then
      self.bakMediaPlayer:CloseMedia()
    end
  end
end

function GameVideoPlayer:Dispose()
  self._disposed = true
  self:_KillFadeTweens()
  self:Stop()
  self:CloseMedia()
  if self.mediaPlayer then
    self.mediaPlayer:Dispose()
  end
  if self.bakMediaPlayer then
    self.bakMediaPlayer:Dispose()
  end
  self.mediaPlayer = nil
  self.bakMediaPlayer = nil
end

function GameVideoPlayer:_OnMainMediaPlayerOpenError()
  if not self.mediaPlayer then
    return
  end
  self.mediaPlayer:CloseMedia()
  if not self.bakMediaPlayer then
    self:_OnMediaOpenedCallabck(false)
    return
  end
  if not self.useBakMediaPlayer then
    self.useBakMediaPlayer = true
    self.bakMediaPlayer:OpenMedia(self.mediaPath)
  end
end

function GameVideoPlayer:_OnMediaOpenedCallabck(successed)
  if self.extraPrepareFunc then
    self.extraPrepareFunc()
    self.extraPrepareFunc = nil
  end
  local preparedCallback = self.preparedCallback
  if preparedCallback then
    preparedCallback(successed)
  end
end

function GameVideoPlayer:_OnMediaPlayingErrorCallabck()
  if self.extraPrepareFunc then
    self.extraPrepareFunc()
    self.extraPrepareFunc = nil
  end
  self:_OnMediaPlayingFinishedCallabck(true)
end

function GameVideoPlayer:_OnMediaPlayingFinishedCallabck(errorOccued)
  local finishedCallback = self.finishedCallback
  if finishedCallback then
    finishedCallback(errorOccued)
  end
  self:SetCallbacks()
end

function GameVideoPlayer:OnApplicationPause()
  if self._isPaused then
    return
  end
  if string.isempty(self.mediaPath) then
    return
  end
  if not self.useBakMediaPlayer then
    self.mediaPlayer:OnApplicationPause()
  end
  if self.bakMediaPlayer then
    self.bakMediaPlayer:OnApplicationPause()
  end
end

function GameVideoPlayer:OnApplicationResume()
  if self._isPaused then
    return
  end
  if string.isempty(self.mediaPath) then
    return
  end
  if not self.useBakMediaPlayer then
    self.mediaPlayer:OnApplicationResume()
  end
  if self.bakMediaPlayer then
    self.bakMediaPlayer:OnApplicationResume()
  end
end

function GameVideoPlayer:FadeOut(duration, onComplete)
  self:_StartFade(0, duration, onComplete)
end

function GameVideoPlayer:FadeIn(duration, onComplete)
  self:_StartFade(1, duration, onComplete)
end

function GameVideoPlayer:_StartFade(targetAlpha, duration, onComplete)
  self:_KillFadeTweens()
  if self._disposed then
    return
  end
  self._fadeCompleteCallback = onComplete
  self._fadeTween = self:_StartNodeFade(self:_GetCurrentRenderNode(), targetAlpha, duration)
  if not self._fadeTween then
    self:_OnFadeComplete()
  end
end

function GameVideoPlayer:_GetCurrentRenderNode()
  if self.useBakMediaPlayer then
    do return self._GetBakRenderNode end
    return self._GetBakRenderNode, self
  end
  do return self._GetMainRenderNode end
  return self._GetMainRenderNode, self
end

function GameVideoPlayer:_GetMainRenderNode()
  if self.mediaPlayer and not IsNil(self.mediaPlayer.mediaPlayerNode) then
    return self.mediaPlayer.mediaPlayerNode
  end
  return nil
end

function GameVideoPlayer:_GetBakRenderNode()
  if self.bakMediaPlayer and not IsNil(self.bakMediaPlayer.playerNode) then
    return self.bakMediaPlayer.playerNode
  end
  return nil
end

function GameVideoPlayer:_StartNodeFade(node, targetAlpha, duration)
  if not node or IsNil(node) or not node.activeSelf then
    return nil
  end
  local graphic = node:GetComponent(T_Graphic)
  if IsNil(graphic) then
    return nil
  end
  do return graphic:DOFade(targetAlpha, duration).OnComplete, (graphic:DOFade(targetAlpha, duration)) end
  return graphic:DOFade(targetAlpha, duration).OnComplete, graphic:DOFade(targetAlpha, duration), function()
    self:_OnFadeComplete()
  end, duration
end

function GameVideoPlayer:_OnFadeComplete()
  self._fadeTween = nil
  local callback = self._fadeCompleteCallback
  self._fadeCompleteCallback = nil
  if self._disposed then
    return
  end
  if callback then
    callback()
  end
end

function GameVideoPlayer:_KillFadeTweens()
  if self._fadeTween then
    self._fadeTween:Kill()
    self._fadeTween = nil
  end
  self._fadeCompleteCallback = nil
  self:_RestoreNodeFadeColor(self:_GetMainRenderNode())
  self:_RestoreNodeFadeColor(self:_GetBakRenderNode())
end

function GameVideoPlayer:_RestoreNodeFadeColor(node)
  if not node or IsNil(node) then
    return
  end
  local graphic = node:GetComponent(T_Graphic)
  if not IsNil(graphic) then
    local color = graphic.color
    graphic.color = CS.UnityEngine.Color(color.r, color.g, color.b, 1)
  end
end

return GameVideoPlayer
