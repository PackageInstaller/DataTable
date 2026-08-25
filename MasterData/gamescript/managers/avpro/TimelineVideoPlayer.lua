local TimelineVideoPlayer, Super = System.NewClass("TimelineVideoPlayer")
local VideoGoPath = CommonRes.TimelineVideoPath
local UIVideoGoPath = CommonRes.TimelineUIVideoPath
local T_Renderer = typeof(CS.UnityEngine.Renderer)
local T_RawImage = typeof(CS.UnityEngine.UI.RawImage)
local mainCam = CS.UnityEngine.Camera.main
local Canvas = CS.UnityEngine.Canvas
local Video_Size = CS.UnityEngine.Vector2(2340, 1080)
local VEC_AnchorMinMax = CS.UnityEngine.Vector2(0.5, 0.5)
local T_PlayableDirector = typeof(CS.UnityEngine.Playables.PlayableDirector)
local T_UIScreenSpaceMask = typeof(CS.UIScreenSpaceMask)
local ScreenSpaceMaskWorldCornersId = CS.UnityEngine.Shader.PropertyToID("_ScreenSpaceMaskWorldCorners")
local ScreenSpaceMasksId = CS.UnityEngine.Shader.PropertyToID("_ScreenSpaceMask")

function TimelineVideoPlayer:ctor(videoParams, timelinePlayer)
  self.timelinePlayer = timelinePlayer
  local video_params = string.split(videoParams, "#")
  self.colorVideoPath = video_params[1]
  self.alphaVideoPath = video_params[2]
  self.videoScaleMode = tonumber(video_params[3])
  self.orientedZOffset = tonumber(video_params[4])
  self.scale = tonumber(video_params[5] or 1)
  self.isLooping = 1 == tonumber(video_params[6])
  self.isUIVideo = 1 == tonumber(video_params[7])
  self.uiParentNode = video_params[8]
  self.uiSibIndex = tonumber(video_params[9] or 0)
  self.screenSpaceMaskFrame = tonumber(video_params[10] or 0)
  self.screenSpaceMaskNodePath = video_params[11]
  self.sortingLayer = tonumber(video_params[12] or 0)
  self.sortingOrder = tonumber(video_params[13] or 0)
  if not self.isUIVideo then
    local videoGoAsset = ResLoadMgr.LoadAsset(VideoGoPath, self)
    self.videoGameObj = Instantiate(videoGoAsset)
    self.videoGameObj.name = "TimelineVideo"
  else
    local videoGoAsset = ResLoadMgr.LoadAsset(UIVideoGoPath, self)
    self.videoGameObj = Instantiate(videoGoAsset)
    self.videoGameObj.name = "TimelineVideoForUI"
  end
  self.videoGameObj:SetActive(false)
  self.videoGameObjTrans = self.videoGameObj.transform
  self.videoPlayer = AVProAlphaVideoPlayer(self.videoGameObj.transform:Find("color").gameObject, self.videoGameObj.transform:Find("color_bak").gameObject, self.videoGameObj.transform:Find("alpha").gameObject, self.videoGameObj.transform:Find("alpha_bak").gameObject)
  local rendererCom = self.videoGameObj:GetComponent(T_Renderer)
  if rendererCom and 0 ~= self.sortingLayer then
    rendererCom.sortingLayerID = self.sortingLayer
  end
  if rendererCom and 0 ~= self.sortingOrder then
    rendererCom.sortingOrder = self.sortingOrder
  end
  if not self.isUIVideo then
    self.videoPlayer:SetRenderer(rendererCom)
  else
    self.videoPlayer:SetRawImage(self.videoGameObj:GetComponent(T_RawImage))
  end
  self.videoPlayer.autoPlayedOnPrepared = false
  self.videoPlayer:SetLooping(self.isLooping)
  
  function self.cameraShakeFunc()
    self:LateUpdate()
  end
  
  if self.alphaVideoPath and 0 == #self.alphaVideoPath then
    self.alphaVideoPath = nil
  end
  Canvas.willRenderCanvases("+", self.cameraShakeFunc)
  self:_UpdateUIVideo()
end

function TimelineVideoPlayer:SetAutoPlayedOnPrepared(autoPlayedOnPrepared)
  if self.videoPlayer then
    self.videoPlayer.autoPlayedOnPrepared = autoPlayedOnPrepared
    if autoPlayedOnPrepared then
      self.startPlayVideoTime = self:_GetTimeWithTimeline()
    end
  end
end

function TimelineVideoPlayer:OpenMedia()
  if self.isOpened then
    return
  end
  local isPaused = self.timelinePlayer and self.timelinePlayer.pauseWhilePreparingVideo
  if isPaused then
    self.timelinePlayer:Pause(isPaused)
  end
  self.videoGameObj:SetActive(true)
  
  function self.videoPlayer.preparedCallback()
    self.isOpened = true
    if isPaused then
      self.timelinePlayer:Resume()
    end
    if not self.isDestroyed then
      if not self.videoPlayer.autoPlayedOnPrepared then
        self.videoGameObj:SetActive(false)
      end
    else
      self:_AdjustVideoTimeWithTimeline()
    end
  end
  
  function self.videoPlayer.finishedCallback()
    if self.videoPlayer then
      self.videoGameObj:SetActive(false)
      self.videoPlayer:Dispose()
      self.videoPlayer = nil
    end
  end
  
  self.videoPlayer:OpenMedia(self.colorVideoPath, self.alphaVideoPath)
end

function TimelineVideoPlayer:PlayVideo()
  self.videoGameObj:SetActive(true)
  if self.isOpened then
    self.videoPlayer:Play()
  else
    self:SetAutoPlayedOnPrepared(true)
  end
end

function TimelineVideoPlayer:_GetTimeWithTimeline()
  local directorGo = self.timelinePlayer:GetDirector()
  if not directorGo then
    return 0
  end
  local director = directorGo:GetComponent(T_PlayableDirector)
  if not director then
    return 0
  end
  return director.time
end

function TimelineVideoPlayer:_AdjustVideoTimeWithTimeline()
  if not self.startPlayVideoTime then
    return
  end
  local timelineTime = self:_GetTimeWithTimeline()
  self.videoPlayer:SeekFast(math.max(0, timelineTime - self.startPlayVideoTime))
end

function TimelineVideoPlayer:Seek(time)
  if self.videoPlayer then
    self.videoPlayer:SeekFast(time)
  end
end

function TimelineVideoPlayer:SetPlaybackSpeed(speed)
  self.playbackSpeed = speed or 1
  if self.videoPlayer then
    self.videoPlayer:SetPlaybackSpeed(self.playbackSpeed)
  end
end

function TimelineVideoPlayer:HideVideoGameObject()
  if IsNil(self.videoGameObjTrans) then
    return
  end
  self._isHideVideoGameObj = true
  self.videoGameObjTrans.position = CS.UnityEngine.Vector3(9999, 9999, 0)
end

function TimelineVideoPlayer:ShowVideoGameObject()
  if IsNil(self.videoGameObjTrans) then
    return
  end
  self._isHideVideoGameObj = false
  if self.isUIVideo then
    self:_UpdateUIVideo()
  end
end

function TimelineVideoPlayer:StopVideo()
  self:Dispose()
end

function TimelineVideoPlayer:LateUpdate()
  if self.isDestroyed or self._isHideVideoGameObj then
    return
  end
  if not self.timelinePlayer or IsNil(self.timelinePlayer.player) then
    return
  end
  if 0 == self.videoScaleMode then
    self:_UpdateTransform()
  elseif 1 == self.videoScaleMode then
    self:_ApplyScale(self.scale)
  end
  self:_ApplyScreenSpaceMask()
end

function TimelineVideoPlayer:_ApplyScreenSpaceMask()
  if not self.isUIVideo then
    return
  end
  if not self.videoPlayer then
    return
  end
  local renderRawImage = self.videoPlayer.renderRawImage
  if IsNil(renderRawImage) or not renderRawImage.materialForRendering then
    return
  end
  if IsNil(self.screenSpaceMask) then
    renderRawImage.materialForRendering:DisableKeyword("_ENABLE_SCREENSPACE_MASK")
    return
  end
  local directorGo = self.timelinePlayer:GetDirector()
  if not directorGo then
    renderRawImage.materialForRendering:DisableKeyword("_ENABLE_SCREENSPACE_MASK")
    return
  end
  local director = directorGo:GetComponent(T_PlayableDirector)
  if not director then
    renderRawImage.materialForRendering:DisableKeyword("_ENABLE_SCREENSPACE_MASK")
    return
  end
  if director.time >= self.screenSpaceMaskFrame / 60 then
    renderRawImage.materialForRendering:EnableKeyword("_ENABLE_SCREENSPACE_MASK")
    renderRawImage.materialForRendering:SetTexture(ScreenSpaceMasksId, self.screenSpaceMask:GetMask())
    renderRawImage.materialForRendering:SetVector(ScreenSpaceMaskWorldCornersId, self.screenSpaceMask:GetWorldConners())
  else
    renderRawImage.materialForRendering:DisableKeyword("_ENABLE_SCREENSPACE_MASK")
  end
end

function TimelineVideoPlayer:_UpdateUIVideo()
  if self.isUIVideo then
    local parentObj = self.timelinePlayer:GetAMObject(self.uiParentNode)
    parentObj = parentObj or self.timelinePlayer:GetBindingGameObject(self.uiParentNode)
    if parentObj then
      self.videoGameObjTrans:SetParent(parentObj.gameObject.transform, false)
      self.videoGameObjTrans.anchorMin = VEC_AnchorMinMax
      self.videoGameObjTrans.anchorMax = VEC_AnchorMinMax
      self.videoGameObjTrans:SetSiblingIndex(self.uiSibIndex)
      CS.Framework.TransformUtil.SetLocalScale(self.videoGameObjTrans, 1, 1, 1)
      CS.Framework.TransformUtil.SetLocalPos(self.videoGameObjTrans, 0, 0, 0)
      CS.Framework.TransformUtil.SetLocalEulerAngles(self.videoGameObjTrans, 0, 0, 0)
      self.videoGameObjTrans.sizeDelta = Video_Size
    end
    if self.screenSpaceMaskFrame > 0 and self.screenSpaceMaskNodePath then
      local screenSpaceMaskNode = self.timelinePlayer:GetAMObject(self.screenSpaceMaskNodePath)
      if screenSpaceMaskNode then
        self.screenSpaceMask = screenSpaceMaskNode.gameObject:GetComponent(T_UIScreenSpaceMask)
      end
    end
  end
end

function TimelineVideoPlayer:_UpdateTransform()
  local cameraWorldPos = mainCam.cameraToWorldMatrix:GetColumn(3)
  local worldForward = -mainCam.cameraToWorldMatrix:GetColumn(2)
  local objTrans = self.videoGameObjTrans
  local zPos = mainCam.nearClipPlane + self.orientedZOffset
  local posx = cameraWorldPos.x + worldForward.x * zPos
  local posy = cameraWorldPos.y + worldForward.y * zPos
  local posz = cameraWorldPos.z + worldForward.z * zPos
  local ex, ey, ez = CS.Framework.TransformUtil.GetEulerAngles(mainCam.transform, nil, nil, nil)
  local scale = math.tan(mainCam.fieldOfView * math.pi / 180 * 0.5) * zPos * 2.0
  CS.Framework.TransformUtil.SetPos(objTrans, posx, posy, posz)
  CS.Framework.TransformUtil.SetEulerAngles(objTrans, ex, ey, ez)
  self:_ApplyScale(scale)
end

function TimelineVideoPlayer:_ApplyScale(scale)
  local sx, sy, sz = CS.Framework.TransformUtil.GetLocalScale(mainCam.transform, nil, nil, nil)
  local signX = self:_Sign(sx)
  local signY = self:_Sign(sy)
  local signZ = self:_Sign(sz)
  local aspect = 2.1666666666666665
  local scaleX = math.max(aspect, mainCam.aspect) * scale
  CS.Framework.TransformUtil.SetLocalScale(self.videoGameObjTrans, scaleX * signX, scale * signY, signZ)
end

function TimelineVideoPlayer:_Sign(val)
  if val > 0 then
    return 1
  elseif val < 0 then
    return -1
  end
  return 0
end

function TimelineVideoPlayer:Dispose()
  if self.isDestroyed then
    return
  end
  self.isOpened = false
  self.isDestroyed = true
  if self.cameraShakeFunc then
    Canvas.willRenderCanvases("-", self.cameraShakeFunc)
    self.cameraShakeFunc = nil
  end
  if self.videoPlayer then
    self.videoPlayer:Dispose()
    self.videoPlayer = nil
  end
  if not IsNil(self.videoGameObj) then
    self.videoGameObj:SetActive(false)
    Destroy(self.videoGameObj)
  end
  self.videoGameObj = nil
  ResLoadMgr.UnloadAssetByTarget(self)
end

return TimelineVideoPlayer
