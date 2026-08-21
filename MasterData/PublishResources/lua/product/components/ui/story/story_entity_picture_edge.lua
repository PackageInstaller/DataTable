_class("StoryEntityPictureEdge", StoryEntityMovable)
StoryEntityPictureEdge = StoryEntityPictureEdge

function StoryEntityPictureEdge:Constructor(ID, gameObject, resRequest, storyManager, entityConfig)
  StoryEntityPictureEdge.super.Constructor(self, ID, gameObject, resRequest, storyManager)
  self._type = StoryEntityType.PictureSliceEdge
  self._picObject = gameObject
  self._picCmp = gameObject:GetComponent("RawImage")
  self._picColor = self._picCmp.color
  self._inScrolling = false
  self._scrollStartFromCover = true
  self._scrollType = nil
  self._scrollStartTime = 0
  self._scrollDuration = 0
  self._defaultSliceWidth = 350
  self._sliceWidth = 350
  self._sliceHeight = 1438
  self._defaultEdgeSliceWidth = 540
  self._edgeSliceWidth = 540
  self._edgeSliceHeight = 1438
  local rootGO = UnityEngine.GameObject:New(gameObject.name)
  rootGO.transform:SetParent(gameObject.transform.parent, false)
  rootGO.transform.localPosition = gameObject.transform.localPosition
  rootGO:SetActive(gameObject.activeSelf)
  self._gameObject = rootGO
  self._maskObject = UnityEngine.GameObject.Instantiate(storyManager:GetMaskTemplate(), rootGO.transform)
  self._maskObject:SetActive(true)
  self._maskObject.transform.localPosition = Vector3.zero
  gameObject.transform:SetParent(self._maskObject.transform, false)
  gameObject:SetActive(true)
  self._edgeResRequest = ResourceManager:GetInstance():SyncLoadAsset("StorySliceEdge.prefab", LoadType.GameObject)
  self._edgeMaskObject = UnityEngine.GameObject.Instantiate(storyManager:GetMaskTemplate(), rootGO.transform)
  self._edgeMaskObject:SetActive(true)
  self._edgeMaskObject.transform.localPosition = Vector3.zero
  self._edgeObject = self._edgeResRequest.Obj
  if self._edgeObject then
    self._edgeObject.transform:SetParent(self._edgeMaskObject.transform, false)
    self._edgeObject:SetActive(true)
  end
  self._edgeImg = self._edgeObject:GetComponent("RawImage")
  self._edgeImgColor = self._edgeImg.color
  if entityConfig.FitSize then
    local canvasRect = storyManager:GetCanvasRect()
    local picRect = gameObject:GetComponent("RectTransform")
    local targetWidth = canvasRect.width + 300
    local targetHeight = picRect.sizeDelta.y * targetWidth / picRect.sizeDelta.x
    picRect.sizeDelta = Vector2(targetWidth, targetHeight)
  end
end

function StoryEntityPictureEdge:_TriggerKeyframe(keyframeData)
  StoryEntityPictureEdge.super._TriggerKeyframe(self, keyframeData)
  if keyframeData.SliceWidthScale then
    self._sliceWidth = self._defaultSliceWidth * keyframeData.SliceWidthScale
    self._edgeSliceWidth = self._defaultEdgeSliceWidth * keyframeData.SliceWidthScale
  end
  if keyframeData.SliceWidthScaleAnim then
    self._inScaling = true
    self._maskObject:GetComponent("Image").enabled = true
    self._maskObject:GetComponent("Mask").enabled = true
    self._edgeMaskObject:GetComponent("Image").enabled = true
    self._edgeMaskObject:GetComponent("Mask").enabled = true
    self._scalingStartValue = keyframeData.SliceWidthScaleAnim.StartValue
    self._scalingEndValue = keyframeData.SliceWidthScaleAnim.EndValue
    self._scalingDuration = keyframeData.SliceWidthScaleAnim.Duration
    self._scalingStartTime = keyframeData.Time
  end
  if keyframeData.Scroll ~= nil then
    self._inScrolling = true
    self._scrollStartFromCover = keyframeData.Scroll.StartFromCover
    self._scrollType = StoryPictureScrollType[keyframeData.Scroll.Toward]
    self._scrollStartTime = keyframeData.Time
    self._scrollDuration = keyframeData.Scroll.Duration
    self._maskObject:GetComponent("Image").enabled = true
    self._maskObject:GetComponent("Mask").enabled = true
    self._edgeMaskObject:GetComponent("Image").enabled = true
    self._edgeMaskObject:GetComponent("Mask").enabled = true
    local maskRect = self._maskObject:GetComponent("RectTransform")
    local picRect = self._picObject:GetComponent("RectTransform")
    local edgeMaskRect = self._edgeMaskObject:GetComponent("RectTransform")
    local edgeImgRect = self._edgeObject:GetComponent("RectTransform")
    edgeImgRect.sizeDelta = Vector2(self._edgeSliceWidth, self._edgeSliceHeight)
    if self._scrollStartFromCover then
      if self._scrollType == StoryPictureScrollType.LeftToRight or self._scrollType == StoryPictureScrollType.RightToLeft or self._scrollType == StoryPictureScrollType.HorizontalSpread then
        maskRect.sizeDelta = Vector2(0, self._sliceHeight)
        edgeMaskRect.sizeDelta = Vector2(0, self._edgeSliceHeight)
      elseif self._scrollType == StoryPictureScrollType.UpToDown or self._scrollType == StoryPictureScrollType.DownToUp or self._scrollType == StoryPictureScrollType.VerticalSpread then
        maskRect.sizeDelta = Vector2(self._sliceWidth, 0)
        edgeMaskRect.sizeDelta = Vector2(self._edgeSliceWidth, 0)
      elseif self._scrollType == StoryPictureScrollType.Spread then
        maskRect.sizeDelta = Vector2.zero
        edgeMaskRect.sizeDelta = Vector2.zero
      end
    else
      maskRect.sizeDelta = Vector2(self._sliceWidth, self._sliceHeight)
      edgeMaskRect.sizeDelta = Vector2(self._edgeSliceWidth, self._edgeSliceHeight)
    end
    if self._scrollStartFromCover and self._scrollType == StoryPictureScrollType.LeftToRight or not self._scrollStartFromCover and self._scrollType == StoryPictureScrollType.RightToLeft then
      maskRect.pivot = Vector2(0, 0.5)
      maskRect.transform.localPosition = Vector3(-self._sliceWidth / 2, maskRect.transform.localPosition.y, maskRect.transform.localPosition.z)
      picRect.anchorMin = Vector2(0, 0.5)
      picRect.anchorMax = Vector2(0, 0.5)
      picRect.transform.localPosition = Vector3(picRect.sizeDelta.x / 2, picRect.transform.localPosition.y, picRect.transform.localPosition.z)
      edgeMaskRect.pivot = Vector2(0, 0.5)
      edgeMaskRect.transform.localPosition = Vector3(-self._edgeSliceWidth / 2, edgeMaskRect.transform.localPosition.y, edgeMaskRect.transform.localPosition.z)
      edgeImgRect.anchorMin = Vector2(0, 0.5)
      edgeImgRect.anchorMax = Vector2(0, 0.5)
      edgeImgRect.transform.localPosition = Vector3(self._edgeSliceWidth / 2, edgeImgRect.transform.localPosition.y, edgeImgRect.transform.localPosition.z)
    elseif self._scrollStartFromCover and self._scrollType == StoryPictureScrollType.RightToLeft or not self._scrollStartFromCover and self._scrollType == StoryPictureScrollType.LeftToRight then
      maskRect.pivot = Vector2(1, 0.5)
      maskRect.transform.localPosition = Vector3(self._sliceWidth / 2, maskRect.transform.localPosition.y, maskRect.transform.localPosition.z)
      picRect.anchorMin = Vector2(1, 0.5)
      picRect.anchorMax = Vector2(1, 0.5)
      picRect.transform.localPosition = Vector3(-picRect.sizeDelta.x / 2, picRect.transform.localPosition.y, picRect.transform.localPosition.z)
      edgeMaskRect.pivot = Vector2(1, 0.5)
      edgeMaskRect.transform.localPosition = Vector3(self._edgeSliceWidth / 2, edgeMaskRect.transform.localPosition.y, edgeMaskRect.transform.localPosition.z)
      edgeImgRect.anchorMin = Vector2(1, 0.5)
      edgeImgRect.anchorMax = Vector2(1, 0.5)
      edgeImgRect.transform.localPosition = Vector3(-self._edgeSliceWidth / 2, edgeImgRect.transform.localPosition.y, edgeImgRect.transform.localPosition.z)
    elseif self._scrollStartFromCover and self._scrollType == StoryPictureScrollType.UpToDown or not self._scrollStartFromCover and self._scrollType == StoryPictureScrollType.DownToUp then
      maskRect.pivot = Vector2(0.5, 1)
      maskRect.transform.localPosition = Vector3(maskRect.transform.localPosition.x, self._sliceHeight / 2, maskRect.transform.localPosition.z)
      picRect.anchorMin = Vector2(0.5, 1)
      picRect.anchorMax = Vector2(0.5, 1)
      picRect.transform.localPosition = Vector3(picRect.transform.localPosition.x, -picRect.sizeDelta.y / 2, picRect.transform.localPosition.z)
      edgeMaskRect.pivot = Vector2(0.5, 1)
      edgeMaskRect.transform.localPosition = Vector3(edgeMaskRect.transform.localPosition.x, self._edgeSliceHeight / 2, edgeMaskRect.transform.localPosition.z)
      edgeImgRect.anchorMin = Vector2(0.5, 1)
      edgeImgRect.anchorMax = Vector2(0.5, 1)
      edgeImgRect.transform.localPosition = Vector3(edgeImgRect.transform.localPosition.x, -self._edgeSliceHeight / 2, edgeImgRect.transform.localPosition.z)
    elseif self._scrollStartFromCover and self._scrollType == StoryPictureScrollType.DownToUp or not self._scrollStartFromCover and self._scrollType == StoryPictureScrollType.UpToDown then
      maskRect.pivot = Vector2(0.5, 0)
      maskRect.transform.localPosition = Vector3(maskRect.transform.localPosition.x, -self._sliceHeight / 2, maskRect.transform.localPosition.z)
      picRect.anchorMin = Vector2(0.5, 0)
      picRect.anchorMax = Vector2(0.5, 0)
      picRect.transform.localPosition = Vector3(picRect.transform.localPosition.x, picRect.sizeDelta.y / 2, picRect.transform.localPosition.z)
      edgeMaskRect.pivot = Vector2(0.5, 0)
      edgeMaskRect.transform.localPosition = Vector3(edgeMaskRect.transform.localPosition.x, -self._edgeSliceHeight / 2, edgeMaskRect.transform.localPosition.z)
      edgeImgRect.anchorMin = Vector2(0.5, 0)
      edgeImgRect.anchorMax = Vector2(0.5, 0)
      edgeImgRect.transform.localPosition = Vector3(edgeImgRect.transform.localPosition.x, self._edgeSliceHeight / 2, edgeImgRect.transform.localPosition.z)
    elseif self._scrollType == StoryPictureScrollType.Spread then
    elseif self._scrollType == StoryPictureScrollType.HorizontalSpread then
    elseif self._scrollType == StoryPictureScrollType.VerticalSpread then
    end
  end
  if keyframeData.FullScreen ~= nil then
    if keyframeData.FullScreen then
      local rectTrans = self._picObject:GetComponent("RectTransform")
      if rectTrans then
        self:_SetPicFullScreen(rectTrans)
      end
    else
      self._storyManager:SetUIBlackSideSize(0, 0)
    end
  end
end

function StoryEntityPictureEdge:_SetPicFullScreen(rectTrans)
  local fullPicWidth = 2532
  local fullPicHeight = 1170
  local screenWidth, screenHeight = self._storyManager:GetUICanvasSize()
  local picAspect = fullPicWidth / fullPicHeight
  local screenAspect = screenWidth / screenHeight
  local blackSideHeight = 0
  local blackSideWidth = 0
  if picAspect > screenAspect then
    local picHeight = fullPicHeight * screenWidth / fullPicWidth
    rectTrans.sizeDelta = Vector2(screenWidth, picHeight)
    blackSideHeight = math.abs(screenHeight - picHeight) / 2
  elseif picAspect < screenAspect then
    local picWidth = fullPicWidth * screenHeight / fullPicHeight
    rectTrans.sizeDelta = Vector2(picWidth, screenHeight)
    blackSideWidth = math.abs(screenWidth - picWidth) / 2
  else
    rectTrans.sizeDelta = Vector2(screenWidth, screenHeight)
  end
  self._storyManager:SetUIBlackSideSize(blackSideWidth, blackSideHeight)
end

function StoryEntityPictureEdge:_UpdateAnimation(time)
  local res = StoryEntityPictureEdge.super._UpdateAnimation(self, time)
  if self._inScrolling and self._scrollType then
    local t = 1
    if self._scrollDuration > 0 then
      t = (time - self._scrollStartTime) / self._scrollDuration
    end
    if 1 < t then
      t = 1
    end
    local effectT = t
    if not self._scrollStartFromCover then
      effectT = 1 - effectT
    end
    if not self._maskRect then
      self._maskRect = self._maskObject:GetComponent("RectTransform")
    end
    if not self._edgeMaskRect then
      self._edgeMaskRect = self._edgeMaskObject:GetComponent("RectTransform")
    end
    if not self._edgeRect then
      self._edgeRect = self._edgeObject:GetComponent("RectTransform")
    end
    if self._scrollType == StoryPictureScrollType.LeftToRight or self._scrollType == StoryPictureScrollType.RightToLeft or self._scrollType == StoryPictureScrollType.HorizontalSpread then
      local deltaMaskWidth = lmathext.lerp(0, self._sliceWidth, effectT)
      local deltaEdgeWidth = lmathext.lerp(0, self._edgeSliceWidth, effectT)
      if self._scrollType ~= StoryPictureScrollType.HorizontalSpread then
        deltaMaskWidth = math.min(deltaEdgeWidth, self._sliceWidth)
      end
      self._maskRect.sizeDelta = Vector2(deltaMaskWidth, self._sliceHeight)
      self._edgeMaskRect.sizeDelta = Vector2(deltaEdgeWidth, self._edgeSliceHeight)
      if self._scrollType == StoryPictureScrollType.HorizontalSpread then
        self._edgeRect.sizeDelta = Vector2(deltaEdgeWidth, self._edgeSliceHeight)
      end
    elseif self._scrollType == StoryPictureScrollType.UpToDown or self._scrollType == StoryPictureScrollType.DownToUp or self._scrollType == StoryPictureScrollType.VerticalSpread then
      local deltaHeight = lmathext.lerp(0, self._edgeSliceHeight, effectT)
      self._maskRect.sizeDelta = Vector2(self._sliceWidth, math.min(deltaHeight, self._sliceHeight))
      self._edgeMaskRect.sizeDelta = Vector2(self._edgeSliceWidth, deltaHeight)
    elseif self._scrollType == StoryPictureScrollType.Spread then
      local deltaMaskWidth = lmathext.lerp(0, self._sliceWidth, effectT)
      local deltaMaskHeight = lmathext.lerp(0, self._sliceHeight, effectT)
      self._maskRect.sizeDelta = Vector2(deltaMaskWidth, deltaMaskHeight)
      local deltaEdgeWidth = lmathext.lerp(0, self._edgeSliceWidth, effectT)
      local deltaEdgeHeight = lmathext.lerp(0, self._edgeSliceHeight, effectT)
      self._edgeMaskRect.sizeDelta = Vector2(deltaEdgeWidth, deltaEdgeHeight)
      self._edgeRect.sizeDelta = Vector2(deltaEdgeWidth, deltaEdgeHeight)
    end
    if 1 <= t then
      self._inScrolling = false
    end
    return false
  elseif self._inScaling then
    local t = 1
    if 0 < self._scalingDuration then
      t = (time - self._scalingStartTime) / self._scalingDuration
    end
    if 1 < t then
      t = 1
    end
    if not self._maskRect then
      self._maskRect = self._maskObject:GetComponent("RectTransform")
    end
    if not self._edgeMaskRect then
      self._edgeMaskRect = self._edgeMaskObject:GetComponent("RectTransform")
    end
    if not self._edgeRect then
      self._edgeRect = self._edgeObject:GetComponent("RectTransform")
    end
    self._sliceWidth = self._defaultSliceWidth * lmathext.lerp(self._scalingStartValue, self._scalingEndValue, t)
    self._maskRect.sizeDelta = Vector2(self._sliceWidth, self._sliceHeight)
    self._edgeSliceWidth = self._defaultEdgeSliceWidth * lmathext.lerp(self._scalingStartValue, self._scalingEndValue, t)
    self._edgeMaskRect.sizeDelta = Vector2(self._edgeSliceWidth, self._edgeSliceHeight)
    self._edgeRect.sizeDelta = Vector2(self._edgeSliceWidth, self._edgeSliceHeight)
    if 1 <= t then
      self._inScaling = false
    end
    return false
  else
    return res
  end
end

function StoryEntityPictureEdge:_SetAlpha(alpha)
  self._picColor.a = alpha
  self._picCmp.color = self._picColor
  self._edgeImgColor.a = alpha
  self._edgeImg.color = self._edgeImgColor
end

function StoryEntityPictureEdge:_SetBrightness(brightness)
  self._picColor:Set(brightness, brightness, brightness, self._picColor.a)
  self._picCmp.color = self._picColor
  self._edgeImgColor:Set(brightness, brightness, brightness, self._edgeImgColor.a)
  self._edgeImg.color = self._edgeImgColor
end

function StoryEntityPictureEdge:Destroy()
  StoryEntityPictureEdge.super.Destroy(self)
  if self._edgeResRequest ~= nil then
    self._edgeResRequest:Dispose()
    self._edgeResRequest = nil
  end
end

function StoryEntityPictureEdge:_SetPicBlur(blurType, blurDirection, blur)
  blurType = blurType + 1
  self._picCmp.material:DisableKeyword("_BLUR_NONE")
  self._picCmp.material:DisableKeyword("_BLUR_GAUSSIAN")
  self._picCmp.material:DisableKeyword("_BLUR_RADIAL")
  self._picCmp.material:DisableKeyword("_BLUR_DIRECTIONAL")
  if blurType == StoryPictureBlurType.None then
    self._picCmp.material:EnableKeyword("_BLUR_NONE")
    self._picCmp.material:SetFloat("_BlurSize", 0)
  elseif blurType == StoryPictureBlurType.RadialBlur then
    self._picCmp.material:SetFloat("_BlurSize", blur)
  else
    self._picCmp.material:SetFloat("_BlurSize", blur * 5)
  end
  self._picCmp.material:EnableKeyword("_BLUR_DIRECTIONAL")
  if blurType == StoryPictureBlurType.MotionBlur then
    if blurDirection == 0 then
      self._picCmp.material:SetFloat("_DirectionalAngle", 90)
    else
      self._picCmp.material:SetFloat("_DirectionalAngle", 180)
    end
  end
  if blurType == StoryPictureBlurType.GaussianBlur then
    self._picCmp.material:EnableKeyword("_BLUR_GAUSSIAN")
  end
  if blurType == StoryPictureBlurType.RadialBlur then
    self._picCmp.material:EnableKeyword("_BLUR_RADIAL")
    self._picCmp.material:SetFloat("_RadialCenterX", 0)
    self._picCmp.material:SetFloat("_RadialCenterY", 0)
  end
end

function StoryEntityPictureEdge:GetMaterial()
  return self._picCmp.material
end
