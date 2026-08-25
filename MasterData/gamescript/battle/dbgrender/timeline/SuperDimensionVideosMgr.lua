local SuperDimensionVideosMgr, Super = System.NewClass("SuperDimensionVideosMgr")
local videoGoPath = CommonRes.TimelineVideoPath
local T_Renderer = typeof(CS.UnityEngine.Renderer)
local mainCam = CS.UnityEngine.Camera.main
local Canvas = CS.UnityEngine.Canvas

function SuperDimensionVideosMgr:ctor()
  local videoGoAsset = ResLoadMgr.LoadAsset(videoGoPath, self)
  self.startVideoGameObj = Instantiate(videoGoAsset)
  self.loopVideoGameObj = Instantiate(videoGoAsset)
  self.finishVideoGameObj = Instantiate(videoGoAsset)
  self.startVideoGameObj:SetActive(false)
  self.loopVideoGameObj:SetActive(false)
  self.finishVideoGameObj:SetActive(false)
  self.startVideoGameObj.name = "SuperDimensionStart"
  self.loopVideoGameObj.name = "SuperDimensionLoop"
  self.finishVideoGameObj.name = "SuperDimensionFinish"
  self.startVideoGameObjVideoPlayer = AVProAlphaVideoPlayer(self.startVideoGameObj.transform:Find("color").gameObject, self.startVideoGameObj.transform:Find("color_bak").gameObject, self.startVideoGameObj.transform:Find("alpha").gameObject, self.startVideoGameObj.transform:Find("alpha_bak").gameObject)
  self.startVideoGameObjVideoPlayer:SetRenderer(self.startVideoGameObj:GetComponent(T_Renderer))
  self.loopVideoGameObjVideoPlayer = AVProAlphaVideoPlayer(self.loopVideoGameObj.transform:Find("color").gameObject, self.loopVideoGameObj.transform:Find("color_bak").gameObject, self.loopVideoGameObj.transform:Find("alpha").gameObject, self.loopVideoGameObj.transform:Find("alpha_bak").gameObject)
  self.loopVideoGameObjVideoPlayer:SetRenderer(self.loopVideoGameObj:GetComponent(T_Renderer))
  self.loopVideoGameObjVideoPlayer:SetLooping(true)
  self.finishVideoGameObjVideoPlayer = AVProAlphaVideoPlayer(self.finishVideoGameObj.transform:Find("color").gameObject, self.finishVideoGameObj.transform:Find("color_bak").gameObject, self.finishVideoGameObj.transform:Find("alpha").gameObject, self.finishVideoGameObj.transform:Find("alpha_bak").gameObject)
  self.finishVideoGameObjVideoPlayer:SetRenderer(self.finishVideoGameObj:GetComponent(T_Renderer))
  
  function self.cameraShakeFunc()
    self:LateUpdate()
  end
  
  Canvas.willRenderCanvases("+", self.cameraShakeFunc)
end

function SuperDimensionVideosMgr:SetVisible(visible)
  local layName = visible and "Default" or "OutUI"
  if self.startVideoGameObj then
    UIRootMgr.SetLayerRecursively(self.startVideoGameObj, layName)
  end
  if self.loopVideoGameObj then
    UIRootMgr.SetLayerRecursively(self.loopVideoGameObj, layName)
  end
  if self.finishVideoGameObj then
    UIRootMgr.SetLayerRecursively(self.finishVideoGameObj, layName)
  end
end

function SuperDimensionVideosMgr:PlayStartVideo()
  self.startVideoGameObj:SetActive(true)
  
  function self.startVideoGameObjVideoPlayer.preparedCallback()
    if not self.isDestroyed then
      self.startVideoGameObjVideoPlayer:TweenIn()
      self.startVideoGameObjVideoPlayer:Play()
    end
  end
  
  function self.startVideoGameObjVideoPlayer.finishedCallback()
    if self.startVideoGameObjVideoPlayer then
      self.startVideoGameObj:SetActive(false)
      self.startVideoGameObjVideoPlayer:Dispose()
      self.startVideoGameObjVideoPlayer = nil
    end
  end
  
  self.startVideoGameObjVideoPlayer:OpenMedia("In.mp4", "In-Alpha.mp4")
end

function SuperDimensionVideosMgr:PlayLoopingVideo()
  if self.isPlayedFinished then
    return
  end
  self.loopVideoGameObj:SetActive(true)
  
  function self.loopVideoGameObjVideoPlayer.preparedCallback()
    if self.isDestroyed then
      return
    end
    self.loopVideoGameObjVideoPlayer:Play()
    self.loopVideoGameObjVideoPlayer:TweenIn()
    if self.startVideoGameObjVideoPlayer then
      self.startVideoGameObjVideoPlayer:TweenOut()
    end
  end
  
  self.loopVideoGameObjVideoPlayer:OpenMedia("SuperDimension.mp4")
end

function SuperDimensionVideosMgr:PlayFinishedVideo()
  self.isPlayedFinished = true
  self.finishVideoGameObj:SetActive(true)
  
  function self.finishVideoGameObjVideoPlayer.preparedCallback()
    if self.isDestroyed then
      return
    end
    self.finishVideoGameObjVideoPlayer:TweenIn()
    if self.startVideoGameObjVideoPlayer then
      self.startVideoGameObjVideoPlayer:TweenOut()
    end
    if self.loopVideoGameObjVideoPlayer then
      self.loopVideoGameObjVideoPlayer:TweenOut()
    end
    self.finishVideoGameObjVideoPlayer:Play()
  end
  
  self.finishVideoGameObjVideoPlayer:OpenMedia("Out.mp4", "Out-Alpha.mp4")
end

function SuperDimensionVideosMgr:LateUpdate()
  if self.isDestroyed then
    return
  end
  local cameraWorldPos = mainCam.cameraToWorldMatrix:GetColumn(3)
  local worldForward = -mainCam.cameraToWorldMatrix:GetColumn(2)
  self:_UpdateTransform(self.startVideoGameObj, 0.001, cameraWorldPos, worldForward)
  self:_UpdateTransform(self.finishVideoGameObj, 0.001, cameraWorldPos, worldForward)
  self:_UpdateTransform(self.loopVideoGameObj, 27, cameraWorldPos, worldForward)
end

function SuperDimensionVideosMgr:_UpdateTransform(obj, offset, cameraWorldPos, worldForward)
  local zPos = mainCam.nearClipPlane + offset
  local posx = cameraWorldPos.x + worldForward.x * zPos
  local posy = cameraWorldPos.y + worldForward.y * zPos
  local posz = cameraWorldPos.z + worldForward.z * zPos
  local ex, ey, ez = CS.Framework.TransformUtil.GetEulerAngles(mainCam.transform, nil, nil, nil)
  local sx, sy, sz = CS.Framework.TransformUtil.GetLocalScale(mainCam.transform, nil, nil, nil)
  local scale = math.tan(mainCam.fieldOfView * math.pi / 180 * 0.5) * zPos * 2.0
  local signX = self:_Sign(sx)
  local signY = self:_Sign(sy)
  local signZ = self:_Sign(sz)
  local aspect = 2.1666666666666665
  local scaleX = math.max(aspect, mainCam.aspect) * scale
  CS.Framework.TransformUtil.SetPos(obj.transform, posx, posy, posz)
  CS.Framework.TransformUtil.SetEulerAngles(obj.transform, ex, ey, ez)
  CS.Framework.TransformUtil.SetLocalScale(obj.transform, scaleX * signX, scale * signY, signZ)
end

function SuperDimensionVideosMgr:_Sign(val)
  if val > 0 then
    return 1
  elseif val < 0 then
    return -1
  end
  return 0
end

function SuperDimensionVideosMgr:Dispose()
  if self.isDestroyed then
    return
  end
  self.isDestroyed = true
  if self.cameraShakeFunc then
    Canvas.willRenderCanvases("-", self.cameraShakeFunc)
    self.cameraShakeFunc = nil
  end
  if self.startVideoGameObjVideoPlayer then
    self.startVideoGameObjVideoPlayer:Dispose()
    self.startVideoGameObjVideoPlayer = nil
  end
  if self.loopVideoGameObjVideoPlayer then
    self.loopVideoGameObjVideoPlayer:Dispose()
    self.loopVideoGameObjVideoPlayer = nil
  end
  if self.finishVideoGameObjVideoPlayer then
    self.finishVideoGameObjVideoPlayer:Dispose()
    self.finishVideoGameObjVideoPlayer = nil
  end
  if not IsNil(self.startVideoGameObj) then
    Destroy(self.startVideoGameObj)
  end
  if not IsNil(self.loopVideoGameObj) then
    Destroy(self.loopVideoGameObj)
  end
  if not IsNil(self.finishVideoGameObj) then
    Destroy(self.finishVideoGameObj)
  end
  self.startVideoGameObj = nil
  self.loopVideoGameObj = nil
  self.finishVideoGameObj = nil
  ResLoadMgr.UnloadAssetByTarget(self)
end

return SuperDimensionVideosMgr
