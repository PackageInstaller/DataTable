_class("StoryEntitySpineSliceHorizontal", StoryEntityMovable)
StoryEntitySpineSliceHorizontal = StoryEntitySpineSliceHorizontal

function StoryEntitySpineSliceHorizontal:Constructor(ID, gameObject, resRequest, storyManager, entityConfig)
  StoryEntitySpineSliceHorizontal.super.Constructor(self, ID, gameObject, resRequest, storyManager)
  self._type = StoryEntityType.SpineSliceHorizontal
  self._spineGameObject = gameObject
  self._spineSke = gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))
  self._spineSkeMultipleTex = gameObject:GetComponentInChildren(typeof(Spine.Unity.Modules.SkeletonGraphicMultiObject))
  self._entityConfig = entityConfig
  self._isSpeaking = false
  self._spineColor = nil
  self._matInsList = {}
  self._EMIMatResRequest = nil
  self._EMIMat = nil
  if self._spineSke then
    self._spineSke.material = UnityEngine.Material:New(self._spineSke.material)
    if entityConfig.Effect == "EMI" then
      self._EMIMatResRequest = ResourceManager:GetInstance():SyncLoadAsset("spine_graphic_dc.mat", LoadType.Mat)
      self._EMIMat = self._EMIMatResRequest.Obj
      self._spineSke.material.shader = self._EMIMat.shader
      self._spineSke.material:SetTexture("_NoiseTex", self._EMIMat:GetTexture("_NoiseTex"))
    end
    self._spineSke.material:SetFloat("_StencilComp", 3)
    self._matInsList[1] = self._spineSke.material
    self._spineColor = self._spineSke.color
    self._spineSke.AnimationState:SetAnimation(0, "Story_norm", true)
  elseif self._spineSkeMultipleTex then
    self._spineSkeMultipleTex.UseInstanceMaterials = true
    if entityConfig.Effect == "EMI" then
      self._EMIMatResRequest = ResourceManager:GetInstance():SyncLoadAsset("spine_dc.mat", LoadType.Mat)
      self._EMIMat = self._EMIMatResRequest.Obj
    end
    
    function self._spineSkeMultipleTex.OnInstanceMaterialCreated(material)
      self:HandleMultipleTexSpineMatCreated(material)
    end
    
    self._spineSkeMultipleTex:UpdateMesh()
    if self._spineSkeMultipleTex.Skeleton then
      self._spineColor = Color(self._spineSkeMultipleTex.Skeleton.R, self._spineSkeMultipleTex.Skeleton.G, self._spineSkeMultipleTex.Skeleton.B, self._spineSkeMultipleTex.Skeleton.A)
    else
      self._spineColor = Color.white
    end
    self._spineSkeMultipleTex.AnimationState:SetAnimation(0, "Story_norm", true)
  end
  if not self._spineColor then
    self._spineColor = Color.white
  end
  self._defaultSliceHeight = 350
  self._sliceHeight = 350
  self._sliceWidth = 2539
  self._defaultEdgeSliceHeight = 540
  self._edgeSliceHeight = 540
  self._edgeSliceWidth = 2539
  local rootGO = UnityEngine.GameObject:New(gameObject.name)
  rootGO.transform:SetParent(gameObject.transform.parent, false)
  rootGO.transform.localPosition = gameObject.transform.localPosition
  rootGO:SetActive(gameObject.activeSelf)
  self._gameObject = rootGO
  self._maskObject = UnityEngine.GameObject.Instantiate(storyManager:GetSpineSliceHorizontalMaskTemplate(), rootGO.transform)
  self._maskObject:SetActive(true)
  self._maskObject.transform.localPosition = Vector3.zero
  gameObject.transform:SetParent(self._maskObject.transform, false)
  gameObject:SetActive(true)
  self._edgeResRequest = ResourceManager:GetInstance():SyncLoadAsset("StorySliceHorizontalEdge.prefab", LoadType.GameObject)
  self._edgeMaskObject = UnityEngine.GameObject.Instantiate(storyManager:GetMaskHorizontalTemplate(), rootGO.transform)
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
    local edgeRect = self._edgeObject:GetComponent("RectTransform")
    local targetWidth = canvasRect.width + 300
    local targetHeight = edgeRect.sizeDelta.y * targetWidth / edgeRect.sizeDelta.x
    edgeRect.sizeDelta = Vector2(targetWidth, targetHeight)
  end
end

function StoryEntitySpineSliceHorizontal:HandleMultipleTexSpineMatCreated(material)
  material:SetFloat("_StencilComp", 3)
  if self._entityConfig.Effect == "EMI" then
    material.shader = self._EMIMat.shader
    material:SetTexture("_NoiseTex", self._EMIMat:GetTexture("_NoiseTex"))
  end
end

function StoryEntitySpineSliceHorizontal:SectionStart(trackData)
  StoryEntitySpineSliceHorizontal.super.SectionStart(self, trackData)
  if self._currentTrackData.IsSpeaking then
    self._storyManager:AddAudioPlayCallback(function(speaking)
      local spineSke
      if self._spineSke then
        spineSke = self._spineSke
      elseif self._spineSkeMultipleTex then
        spineSke = self._spineSkeMultipleTex
      else
        return
      end
      if speaking then
        spineSke.AnimationState:SetAnimation(1, "talk_start", true)
      else
        spineSke.AnimationState:SetEmptyAnimation(1, 0)
      end
    end)
  end
end

function StoryEntitySpineSliceHorizontal:_TriggerKeyframe(keyframeData)
  StoryEntitySpineSliceHorizontal.super._TriggerKeyframe(self, keyframeData)
  local spineSke
  if self._spineSke then
    spineSke = self._spineSke
  elseif self._spineSkeMultipleTex then
    spineSke = self._spineSkeMultipleTex
  else
    return
  end
  if not spineSke.AnimationState then
    return
  end
  local layer = 0
  if keyframeData.AnimationLayer then
    layer = keyframeData.AnimationLayer
  end
  if keyframeData.ClearAnimationLayer and spineSke then
    spineSke.AnimationState:SetEmptyAnimation(keyframeData.ClearAnimationLayer, 0)
  end
  if keyframeData.LoopAnimation ~= nil and spineSke then
    spineSke.AnimationState:SetAnimation(layer, keyframeData.LoopAnimation, true)
  end
  if keyframeData.Animation ~= nil and spineSke then
    spineSke.AnimationState:SetAnimation(layer, keyframeData.Animation, false)
  end
  if keyframeData.SpineOffset then
    self:_SetSpinePosition(Vector3(keyframeData.SpineOffset[1], keyframeData.SpineOffset[2], 0))
  end
  if keyframeData.SliceHeightScale then
    self._sliceHeight = self._defaultSliceHeight * keyframeData.SliceHeightScale
    self._edgeSliceHeight = self._defaultEdgeSliceHeight * keyframeData.SliceHeightScale
  end
  if keyframeData.SliceHeightScaleAnim then
    self._inScaling = true
    self._edgeMaskObject:GetComponent("Image").enabled = true
    self._edgeMaskObject:GetComponent("Mask").enabled = true
    self._scalingStartValue = keyframeData.SliceHeightScaleAnim.StartValue
    self._scalingEndValue = keyframeData.SliceHeightScaleAnim.EndValue
    self._scalingDuration = keyframeData.SliceHeightScaleAnim.Duration
    self._scalingStartTime = keyframeData.Time
  end
  if keyframeData.SpineSkin ~= nil then
    spineSke.Skeleton:SetSkin(keyframeData.SpineSkin)
  end
  if keyframeData.Scroll ~= nil then
    self._inScrolling = true
    self._scrollStartFromCover = keyframeData.Scroll.StartFromCover
    self._scrollType = StoryPictureScrollType[keyframeData.Scroll.Toward]
    self._scrollStartTime = keyframeData.Time
    self._scrollDuration = keyframeData.Scroll.Duration
    self._edgeMaskObject:GetComponent("Image").enabled = true
    self._edgeMaskObject:GetComponent("Mask").enabled = true
    local maskRect = self._maskObject:GetComponent("RectTransform")
    local spineRect = self._spineGameObject:GetComponent("RectTransform")
    local edgeMaskRect = self._edgeMaskObject:GetComponent("RectTransform")
    local edgeImgRect = self._edgeObject:GetComponent("RectTransform")
    edgeImgRect.sizeDelta = Vector2(self._edgeSliceHeight, self._edgeSliceWidth)
    if self._scrollStartFromCover then
      if self._scrollType == StoryPictureScrollType.LeftToRight or self._scrollType == StoryPictureScrollType.RightToLeft or self._scrollType == StoryPictureScrollType.HorizontalSpread then
        maskRect.sizeDelta = Vector2(0, self._sliceHeight)
        edgeMaskRect.sizeDelta = Vector2(self._edgeSliceHeight, 0)
      elseif self._scrollType == StoryPictureScrollType.UpToDown or self._scrollType == StoryPictureScrollType.DownToUp or self._scrollType == StoryPictureScrollType.VerticalSpread then
        maskRect.sizeDelta = Vector2(self._sliceWidth, 0)
        edgeMaskRect.sizeDelta = Vector2(0, self._edgeSliceWidth)
      elseif self._scrollType == StoryPictureScrollType.Spread then
        maskRect.sizeDelta = Vector2.zero
        edgeMaskRect.sizeDelta = Vector2.zero
      end
    else
      maskRect.sizeDelta = Vector2(self._sliceWidth, self._sliceHeight)
      edgeMaskRect.sizeDelta = Vector2(self._edgeSliceHeight, self._edgeSliceWidth)
    end
    if self._scrollStartFromCover and self._scrollType == StoryPictureScrollType.LeftToRight or not self._scrollStartFromCover and self._scrollType == StoryPictureScrollType.RightToLeft then
      maskRect.pivot = Vector2(0, 0.5)
      maskRect.transform.localPosition = Vector3(-self._sliceWidth / 2, maskRect.transform.localPosition.y, maskRect.transform.localPosition.z)
      local offset = 0
      if spineRect.anchorMin == Vector2(0, 0.5) then
        offset = 0
      elseif spineRect.anchorMin == Vector2(1, 0.5) then
        offset = self._sliceWidth
      else
        offset = self._sliceWidth / 2
      end
      spineRect.anchorMin = Vector2(0, 0.5)
      spineRect.anchorMax = Vector2(0, 0.5)
      if self._scrollStartFromCover then
        spineRect.transform.localPosition = Vector3(spineRect.transform.localPosition.x + offset, spineRect.transform.localPosition.y, spineRect.transform.localPosition.z)
      end
      edgeMaskRect.pivot = Vector2(0.5, 1)
      edgeMaskRect.transform.localPosition = Vector3(-self._edgeSliceWidth / 2, edgeMaskRect.transform.localPosition.y, edgeMaskRect.transform.localPosition.z)
      edgeImgRect.anchorMin = Vector2(0.5, 1)
      edgeImgRect.anchorMax = Vector2(0.5, 1)
      edgeImgRect.transform.localPosition = Vector3(edgeImgRect.transform.localPosition.x, -self._edgeSliceWidth / 2, edgeImgRect.transform.localPosition.z)
    elseif self._scrollStartFromCover and self._scrollType == StoryPictureScrollType.RightToLeft or not self._scrollStartFromCover and self._scrollType == StoryPictureScrollType.LeftToRight then
      maskRect.pivot = Vector2(1, 0.5)
      maskRect.transform.localPosition = Vector3(self._sliceWidth / 2, maskRect.transform.localPosition.y, maskRect.transform.localPosition.z)
      local offset = 0
      if spineRect.anchorMin == Vector2(1, 0.5) then
        offset = 0
      elseif spineRect.anchorMin == Vector2(0, 0.5) then
        offset = self._sliceWidth
      else
        offset = self._sliceWidth / 2
      end
      spineRect.anchorMin = Vector2(1, 0.5)
      spineRect.anchorMax = Vector2(1, 0.5)
      if self._scrollStartFromCover then
        spineRect.transform.localPosition = Vector3(spineRect.transform.localPosition.x - offset, spineRect.transform.localPosition.y, spineRect.transform.localPosition.z)
      end
      edgeMaskRect.pivot = Vector2(0.5, 0)
      edgeMaskRect.transform.localPosition = Vector3(self._edgeSliceWidth / 2, edgeMaskRect.transform.localPosition.y, edgeMaskRect.transform.localPosition.z)
      edgeImgRect.anchorMin = Vector2(0.5, 0)
      edgeImgRect.anchorMax = Vector2(0.5, 0)
      edgeImgRect.transform.localPosition = Vector3(edgeImgRect.transform.localPosition.x, self._edgeSliceWidth / 2, edgeImgRect.transform.localPosition.z)
    elseif self._scrollStartFromCover and self._scrollType == StoryPictureScrollType.UpToDown or not self._scrollStartFromCover and self._scrollType == StoryPictureScrollType.DownToUp then
      maskRect.pivot = Vector2(0.5, 1)
      maskRect.transform.localPosition = Vector3(maskRect.transform.localPosition.x, self._sliceHeight / 2, maskRect.transform.localPosition.z)
      spineRect.anchorMin = Vector2(0.5, 1)
      spineRect.anchorMax = Vector2(0.5, 1)
      if self._scrollStartFromCover then
        spineRect.transform.localPosition = Vector3(spineRect.transform.localPosition.x, spineRect.transform.localPosition.y - self._sliceHeight / 2, spineRect.transform.localPosition.z)
      end
      edgeMaskRect.pivot = Vector2(1, 0.5)
      edgeMaskRect.transform.localPosition = Vector3(edgeMaskRect.transform.localPosition.x, self._edgeSliceHeight / 2, edgeMaskRect.transform.localPosition.z)
      edgeImgRect.anchorMin = Vector2(1, 0.5)
      edgeImgRect.anchorMax = Vector2(1, 0.5)
      edgeImgRect.transform.localPosition = Vector3(-self._edgeSliceHeight / 2, edgeImgRect.transform.localPosition.y, edgeImgRect.transform.localPosition.z)
    elseif self._scrollStartFromCover and self._scrollType == StoryPictureScrollType.DownToUp or not self._scrollStartFromCover and self._scrollType == StoryPictureScrollType.UpToDown then
      maskRect.pivot = Vector2(0.5, 0)
      maskRect.transform.localPosition = Vector3(maskRect.transform.localPosition.x, -self._sliceHeight / 2, maskRect.transform.localPosition.z)
      spineRect.anchorMin = Vector2(0.5, 0)
      spineRect.anchorMax = Vector2(0.5, 0)
      if self._scrollStartFromCover then
        spineRect.transform.localPosition = Vector3(spineRect.transform.localPosition.x, spineRect.transform.localPosition.y + self._sliceHeight / 2, spineRect.transform.localPosition.z)
      end
      edgeMaskRect.pivot = Vector2(0, 0.5)
      edgeMaskRect.transform.localPosition = Vector3(edgeMaskRect.transform.localPosition.x, -self._edgeSliceHeight / 2, edgeMaskRect.transform.localPosition.z)
      edgeImgRect.anchorMin = Vector2(0, 0.5)
      edgeImgRect.anchorMax = Vector2(0, 0.5)
      edgeImgRect.transform.localPosition = Vector3(edgeImgRect.sizeDelta.x / 2, edgeImgRect.transform.localPosition.y, edgeImgRect.transform.localPosition.z)
    elseif self._scrollType == StoryPictureScrollType.Spread then
    elseif self._scrollType == StoryPictureScrollType.HorizontalSpread then
    elseif self._scrollType == StoryPictureScrollType.VerticalSpread then
    end
  end
end

function StoryEntitySpineSliceHorizontal:SetSpeak(speaking)
  local spineSke
  if self._spineSke then
    spineSke = self._spineSke
  elseif self._spineSkeMultipleTex then
    spineSke = self._spineSkeMultipleTex
  else
    return
  end
  self._isSpeaking = speaking
  local curAnimName = "normal"
  local loop = true
  local track = spineSke.AnimationState:GetCurrent(1)
  if track then
    curAnimName = track.Animation.Name
    loop = track.Loop
  end
  if self._isSpeaking ~= string.equal_with_ignorecase(curAnimName, "shoot") then
    if self._isSpeaking then
      spineSke.AnimationState:SetAnimation(1, "shoot", loop)
    else
      spineSke.AnimationState:SetAnimation(1, "aim", loop)
    end
  end
end

function StoryEntitySpineSliceHorizontal:_SetSpinePosition(pos)
  self._spineGameObject.transform.localPosition = pos
end

function StoryEntitySpineSliceHorizontal:_UpdateAnimation(time)
  local baseAllEnd = StoryEntitySpineSliceHorizontal.super._UpdateAnimation(self, time)
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
      local deltaWidth = lmathext.lerp(0, self._edgeSliceWidth, effectT)
      self._maskRect.sizeDelta = Vector2(math.min(deltaWidth, self._sliceWidth), self._sliceHeight)
      self._edgeMaskRect.sizeDelta = Vector2(self._edgeSliceHeight, deltaWidth)
    elseif self._scrollType == StoryPictureScrollType.UpToDown or self._scrollType == StoryPictureScrollType.DownToUp or self._scrollType == StoryPictureScrollType.VerticalSpread then
      local deltaMaskHeight = lmathext.lerp(0, self._sliceHeight, effectT)
      local deltaEdgeHeight = lmathext.lerp(0, self._edgeSliceHeight, effectT)
      if self._scrollType ~= StoryPictureScrollType.VerticalSpread then
        deltaMaskHeight = math.min(deltaEdgeHeight, self._sliceHeight)
      end
      self._maskRect.sizeDelta = Vector2(self._sliceWidth, deltaMaskHeight)
      self._edgeMaskRect.sizeDelta = Vector2(deltaEdgeHeight, self._edgeSliceWidth)
      if self._scrollType == StoryPictureScrollType.VerticalSpread then
        self._edgeRect.sizeDelta = Vector2(deltaEdgeHeight, self._edgeSliceWidth)
      end
    elseif self._scrollType == StoryPictureScrollType.Spread then
      local deltaMaskWidth = lmathext.lerp(0, self._sliceWidth, effectT)
      local deltaMaskHeight = lmathext.lerp(0, self._sliceHeight, effectT)
      self._maskRect.sizeDelta = Vector2(deltaMaskWidth, deltaMaskHeight)
      local deltaEdgeWidth = lmathext.lerp(0, self._edgeSliceWidth, effectT)
      local deltaEdgeHeight = lmathext.lerp(0, self._edgeSliceHeight, effectT)
      self._edgeMaskRect.sizeDelta = Vector2(deltaEdgeHeight, deltaEdgeWidth)
      self._edgeRect.sizeDelta = Vector2(deltaEdgeHeight, deltaEdgeWidth)
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
    self._sliceHeight = self._defaultSliceHeight * lmathext.lerp(self._scalingStartValue, self._scalingEndValue, t)
    self._maskRect.sizeDelta = Vector2(self._sliceWidth, self._sliceHeight)
    self._edgeSliceHeight = self._defaultEdgeSliceHeight * lmathext.lerp(self._scalingStartValue, self._scalingEndValue, t)
    self._edgeMaskRect.sizeDelta = Vector2(self._edgeSliceHeight, self._edgeSliceWidth)
    self._edgeRect.sizeDelta = Vector2(self._edgeSliceHeight, self._edgeSliceWidth)
    if 1 <= t then
      self._inScaling = false
    end
    return false
  else
    return baseAllEnd
  end
end

function StoryEntitySpineSliceHorizontal:_SetAlpha(alpha)
  self._spineColor.a = alpha
  if self._spineSke then
    self._spineSke.color = self._spineColor
  elseif self._spineSkeMultipleTex and self._spineSkeMultipleTex.Skeleton then
    self._spineSkeMultipleTex.Skeleton.A = alpha
  end
  self._edgeImgColor.a = alpha
  self._edgeImg.color = self._edgeImgColor
end

function StoryEntitySpineSliceHorizontal:_SetBrightness(brightness)
  self._spineColor:Set(brightness, brightness, brightness, self._spineColor.a)
  if self._spineSke then
    self._spineSke.color = self._spineColor
  elseif self._spineSkeMultipleTex and self._spineSkeMultipleTex.Skeleton then
    self._spineSkeMultipleTex.Skeleton.R = brightness
    self._spineSkeMultipleTex.Skeleton.G = brightness
    self._spineSkeMultipleTex.Skeleton.B = brightness
  end
  self._edgeImgColor:Set(brightness, brightness, brightness, self._edgeImgColor.a)
  self._edgeImg.color = self._edgeImgColor
end

function StoryEntitySpineSliceHorizontal:_SetRotation(rot)
  self._spineGameObject.transform.localRotation = rot
end

function StoryEntitySpineSliceHorizontal:_SetScaling(scale)
  self._spineGameObject.transform.localScale = scale
end

function StoryEntitySpineSliceHorizontal:Destroy()
  StoryEntitySpineSliceHorizontal.super.Destroy(self)
  for i = 1, #self._matInsList do
    UnityEngine.Object.Destroy(self._matInsList[i])
  end
  self._matInsList = {}
  if self._EMIMatResRequest then
    self._EMIMat = nil
    self._EMIMatResRequest:Dispose()
    self._EMIMatResRequest = nil
  end
  if self._edgeResRequest ~= nil then
    self._edgeResRequest:Dispose()
    self._edgeResRequest = nil
  end
end

function StoryEntitySpineSliceHorizontal:GetMaterial()
  if self._spineSke then
    return self._spineSke.material
  end
  if self._spineSkeMultipleTex then
    if self._spineSkeMultipleTex.material then
      return self._spineSkeMultipleTex.material
    elseif self._spineSkeMultipleTex.canvasRenderers.Count > 0 then
      local materials = {}
      for i = 0, self._spineSkeMultipleTex.canvasRenderers.Count - 1 do
        local material = self._spineSkeMultipleTex.canvasRenderers[i]:GetMaterial()
        if material then
          table.insert(materials, material)
        end
      end
      if 0 < #materials then
        return materials
      end
    end
  end
  return nil
end
