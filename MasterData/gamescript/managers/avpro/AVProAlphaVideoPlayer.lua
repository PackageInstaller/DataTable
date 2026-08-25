local ColorMapPropertyTagId = CS.UnityEngine.Shader.PropertyToID("_MainTex")
local AlphaMapPropertyTagId = CS.UnityEngine.Shader.PropertyToID("_VideoAlphaMap")
local AlphaPropertyTagId = CS.UnityEngine.Shader.PropertyToID("_VideoAlpha")
local ColorTexFlipVerticalTagId = CS.UnityEngine.Shader.PropertyToID("_TexFlipVertical")
local AlphaTexFlipVerticalTagId = CS.UnityEngine.Shader.PropertyToID("_AlphaFlipVertical")
local TexApplyGammaTagId = CS.UnityEngine.Shader.PropertyToID("_TexApplyGamma")
local AlphaApplyGamma = CS.UnityEngine.Shader.PropertyToID("_AlphaApplyGamma")
local PropYpCbCrTransform = CS.UnityEngine.Shader.PropertyToID("_YpCbCrTransform")
local PropChromaTex = CS.UnityEngine.Shader.PropertyToID("_ChromaTex")
local CSTime = CS.UnityEngine.Time
local MaxSmoothTime = 0.03333333333333333
local CsTexture2D = typeof(CS.UnityEngine.Texture2D)
local T_RawImage = typeof(CS.UnityEngine.UI.RawImage)
local isSupportedYpCbCr = false
local AVProAlphaVideoPlayer, Super = System.NewClass("AVProAlphaVideoPlayer")

function AVProAlphaVideoPlayer:ctor(mediaPlayer, bakMediaPlayer, alphaMediaPlayer, bakAlphaMediaPlayer)
  Super.ctor(self)
  self.textureProducer = GameVideoPlayer(mediaPlayer, bakMediaPlayer)
  self.textureAlphaProducer = GameVideoPlayer(alphaMediaPlayer, bakAlphaMediaPlayer)
  self.length = 0
  self.maxSeekTime = 0
  self.timeCount = 0
  self.alpha = 1
  self.useSmoothTime = true
  self.isPrepareFinished = false
  self.preparedCallback = nil
  self.finishedCallback = nil
  self.startedCallabck = nil
  self.useSeekTime = false
  self.autoPlayedOnPrepared = true
  self.playbackSpeed = 1
  self.forceUnityPlayer = false
end

function AVProAlphaVideoPlayer:SetForceUnityPlayer(forceUnityPlayer)
  self.forceUnityPlayer = forceUnityPlayer
  self.textureProducer.forceUnityPlayer = forceUnityPlayer
  self.textureAlphaProducer.forceUnityPlayer = forceUnityPlayer
end

function AVProAlphaVideoPlayer:OpenMedia(videoUrl, alphaVideoUrl)
  self.timeCount = 0
  self.alpha = 1
  self.isTweenIn = false
  self.isTweenOut = false
  self.videoUrl = videoUrl
  self.alphaVideoUrl = alphaVideoUrl
  self.isPrepareFinished = false
  local isColoredPrepared, isAlphaPrepared = false
  
  local function checkPrepared()
    self.isPrepareFinished = isColoredPrepared and isAlphaPrepared or false
    if self.preparedCallback and self.isPrepareFinished then
      self.preparedCallback()
    end
    if self.isPrepareFinished then
      if self.autoPlayedOnPrepared then
        self:Play()
      else
        self:Pause()
      end
    end
  end
  
  function self.textureProducer.preparedCallback()
    isColoredPrepared = true
    self.textureAlphaProducer:OpenMedia(alphaVideoUrl)
    checkPrepared()
  end
  
  function self.textureAlphaProducer.preparedCallback()
    isAlphaPrepared = true
    checkPrepared()
  end
  
  function self.textureProducer.finishedCallback()
    if self.finishedCallback then
      self.finishedCallback()
    end
  end
  
  self.textureProducer:OpenMedia(videoUrl)
  LateUpdateBeat.Instance:Add(self.Update, self)
end

function AVProAlphaVideoPlayer:SetLooping(looping)
  self.looping = looping
  self.textureProducer:SetLooping(looping)
  self.textureAlphaProducer:SetLooping(looping)
end

function AVProAlphaVideoPlayer:IsLooping()
  return self.looping
end

function AVProAlphaVideoPlayer:SetPlaybackSpeed(speed)
  self.playbackSpeed = speed or 1
  self.textureProducer:SetPlaybackSpeed(self.playbackSpeed)
  self.textureAlphaProducer:SetPlaybackSpeed(self.playbackSpeed)
end

function AVProAlphaVideoPlayer:SetUseSmoothTime(useSmoothTime)
  self.useSmoothTime = useSmoothTime
end

function AVProAlphaVideoPlayer:SetLength(length)
  self.length = length or 0
end

function AVProAlphaVideoPlayer:GetLength()
  if 0 == self.length then
    if not string.isempty(self.textureProducer.mediaPath) then
      self.length = self.textureProducer:GetLength()
    elseif not string.isempty(self.textureAlphaProducer.mediaPath) then
      self.length = self.textureAlphaProducer:GetLength()
    end
  end
  return self.length
end

function AVProAlphaVideoPlayer:Play()
  self.textureProducer:Play()
  self.textureAlphaProducer:Play()
end

function AVProAlphaVideoPlayer:Pause()
  self.textureProducer:Pause()
  self.textureAlphaProducer:Pause()
end

function AVProAlphaVideoPlayer:Seek(time)
  if self.maxSeekTime > 0 then
    time = math.min(time, self.maxSeekTime)
  end
  self.textureProducer:Seek(time)
  self.textureAlphaProducer:Seek(time)
end

function AVProAlphaVideoPlayer:SeekToLiveTime(time)
  if self.maxSeekTime > 0 then
    time = math.min(time, self.maxSeekTime)
  end
  self.textureProducer:SeekToLiveTime(time)
  self.textureAlphaProducer:SeekToLiveTime(time)
end

function AVProAlphaVideoPlayer:SeekFast(time)
  if self.maxSeekTime > 0 then
    time = math.min(time, self.maxSeekTime)
  end
  self.textureProducer:SeekFast(time)
  self.textureAlphaProducer:SeekFast(time)
end

function AVProAlphaVideoPlayer:SetMaxSeekTime(time)
  self.maxSeekTime = time or 0
end

function AVProAlphaVideoPlayer:SetRenderer(renderer)
  self.renderer = renderer
  self.renderer.enabled = false
end

function AVProAlphaVideoPlayer:SetRawImage(renderRawImage)
  self.renderRawImage = renderRawImage:GetComponent(T_RawImage)
  self.renderRawImage.enabled = false
end

function AVProAlphaVideoPlayer:Stop()
  local material = self:GetMaterial()
  if material then
    material:SetTexture(AlphaMapPropertyTagId, CsTexture2D.whiteTexture)
    local blackTexture = AVProManager.Instance:GetBlackTexture()
    material:SetTexture(ColorMapPropertyTagId, blackTexture)
  end
  if not IsNil(self.renderRawImage) then
    self.renderRawImage.texture = nil
    self.renderRawImage.enabled = false
  end
  if not IsNil(self.renderer) then
    self.renderer.enabled = false
  end
  self.textureProducer:Stop()
  self.textureAlphaProducer:Stop()
end

function AVProAlphaVideoPlayer:RemoveAllListeners()
  self.preparedCallback = nil
  self.startedCallabck = nil
  self.finishedCallback = nil
end

function AVProAlphaVideoPlayer:CloseMedia()
  self:Stop()
  self:RemoveAllListeners()
  self.isPrepareFinished = false
  self.textureProducer:CloseMedia()
  self.textureAlphaProducer:CloseMedia()
  LateUpdateBeat.Instance:Remove(self.Update, self)
end

function AVProAlphaVideoPlayer:Dispose()
  self:CloseMedia()
  self.isPrepareFinished = false
  self.renderRawImage = nil
  self.renderer = nil
  self.textureProducer:Dispose()
  self.textureAlphaProducer:Dispose()
end

function AVProAlphaVideoPlayer:SetAlpha(alpha)
  self.alpha = alpha
  self.isTweenIn = false
  self.isTweenOut = false
  self:UpdateMaterials()
end

function AVProAlphaVideoPlayer:TweenIn()
  self.alpha = 0
  self.isTweenIn = true
  self.isTweenOut = false
  self:UpdateMaterials()
end

function AVProAlphaVideoPlayer:TweenOut()
  self.alpha = 1
  self.isTweenIn = false
  self.isTweenOut = true
  self:UpdateMaterials()
end

function AVProAlphaVideoPlayer:Update()
  local isRawImageAlive = not IsNil(self.renderRawImage)
  local isRendererAlive = not IsNil(self.renderer)
  if not self.isPrepareFinished or (not isRawImageAlive or not self.renderRawImage.gameObject.activeSelf) and (not isRendererAlive or not self.renderer.gameObject.activeSelf) then
    return
  end
  if self.useSeekTime then
    local deltaTime
    if self.useSmoothTime then
      deltaTime = math.min(CSTime.smoothDeltaTime, MaxSmoothTime)
    else
      deltaTime = CSTime.deltaTime
    end
    self.timeCount = self.timeCount + deltaTime
    if self.looping then
      local length = self:GetLength()
      if length > 0 and length < self.timeCount then
        self.timeCount = self.timeCount - length
      end
    end
    self:Seek(self.timeCount)
  end
  self:UpdateTweenIn()
  self:UpdateTweenOut()
  self:UpdateMaterials()
end

function AVProAlphaVideoPlayer:GetMaterial()
  local material
  if not IsNil(self.renderRawImage) then
    material = self.renderRawImage.material
  elseif not IsNil(self.renderer) then
    material = self.renderer.material
  end
  return material
end

function AVProAlphaVideoPlayer:UpdateMaterials()
  if self.isDisappeared then
    return
  end
  local material = self:GetMaterial()
  if not material then
    return
  end
  local isRawImageAlive = not IsNil(self.renderRawImage)
  local isRendererAlive = not IsNil(self.renderer)
  local texAlpha = self.textureAlphaProducer:GetTexture()
  local texColor = self.textureProducer:GetTexture()
  if texColor then
    material:SetTexture(ColorMapPropertyTagId, texColor)
    if isRawImageAlive then
      self.renderRawImage.texture = texColor
    end
  else
    local blackTexture = AVProManager.Instance:GetBlackTexture()
    material:SetTexture(ColorMapPropertyTagId, blackTexture)
    if isRawImageAlive then
      self.renderRawImage.texture = blackTexture
    end
  end
  if texAlpha then
    material:SetTexture(AlphaMapPropertyTagId, texAlpha)
  elseif self.alphaVideoUrl and #self.alphaVideoUrl > 0 then
    local blackTexture = AVProManager.Instance:GetBlackTexture()
    material:SetTexture(AlphaMapPropertyTagId, blackTexture)
  else
    material:SetTexture(AlphaMapPropertyTagId, CsTexture2D.whiteTexture)
  end
  if isRawImageAlive and not self.renderRawImage.enabled then
    self.renderRawImage.enabled = true
  end
  if isRendererAlive and not self.renderer.enabled then
    self.renderer.enabled = true
  end
  local isSp = self.textureProducer:IsSupportedYpCbCr()
  material:SetFloat(ColorTexFlipVerticalTagId, self.textureProducer:RequiresVerticalFlip() and 1 or -1)
  material:SetFloat(AlphaTexFlipVerticalTagId, self.textureAlphaProducer:RequiresVerticalFlip() and 1 or -1)
  material:SetFloat(TexApplyGammaTagId, self.textureProducer:UseGammaMaterial() and 1 or 0)
  material:SetFloat(AlphaApplyGamma, 0)
  material:SetFloat(AlphaPropertyTagId, self.alpha)
  if isSp and isSupportedYpCbCr then
    material:EnableKeyword("USE_YPCBCR")
    material:SetMatrix(PropYpCbCrTransform, self.textureProducer:GetYpCbCrTransform())
    material:SetTexture(PropChromaTex, self.textureProducer:GetYpCbCrTexture())
  else
    material:DisableKeyword("USE_YPCBCR")
  end
end

function AVProAlphaVideoPlayer:UpdateTweenIn()
  if self.isTweenIn then
    self.alpha = self.alpha + CSTime.deltaTime * 2.0
    if self.alpha >= 1 then
      self.alpha = 1
      self.isTweenIn = false
    end
  end
end

function AVProAlphaVideoPlayer:UpdateTweenOut()
  if self.isTweenOut then
    self.alpha = self.alpha - CSTime.deltaTime * 2.0
    if self.alpha <= 0 then
      self.alpha = 0
      self.isDisappeared = true
      self.isTweenOut = false
      if not IsNil(self.renderRawImage) then
        self.renderRawImage.enabled = false
      end
      if not IsNil(self.renderer) then
        self.renderer.enabled = false
      end
    end
  end
end

return AVProAlphaVideoPlayer
