_class("StoryEntitySpineCircleEdge", StoryEntityMovable)
StoryEntitySpineCircleEdge = StoryEntitySpineCircleEdge

function StoryEntitySpineCircleEdge:Constructor(ID, gameObject, resRequest, storyManager, entityConfig)
  StoryEntitySpineCircleEdge.super.Constructor(self, ID, gameObject, resRequest, storyManager)
  self._type = StoryEntityType.SpineCircleEdge
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
  local rootGO = UnityEngine.GameObject:New(gameObject.name)
  rootGO.transform:SetParent(gameObject.transform.parent, false)
  rootGO.transform.localPosition = gameObject.transform.localPosition
  rootGO:SetActive(gameObject.activeSelf)
  self._gameObject = rootGO
  self._spineMaskObject = UnityEngine.GameObject.Instantiate(storyManager:GetSpineCircleMaskTemplate(), rootGO.transform)
  self._spineMaskObject:SetActive(true)
  self._spineMaskObject.transform.localPosition = Vector3.zero
  gameObject.transform:SetParent(self._spineMaskObject.transform, false)
  gameObject:SetActive(true)
  self._edgeResRequest = ResourceManager:GetInstance():SyncLoadAsset("StoryCircleEdge.prefab", LoadType.GameObject)
  self._edgeObject = self._edgeResRequest.Obj
  if self._edgeObject then
    self._edgeObject.transform:SetParent(rootGO.transform, false)
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

function StoryEntitySpineCircleEdge:SectionStart(trackData)
  StoryEntitySpineCircleEdge.super.SectionStart(self, trackData)
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

function StoryEntitySpineCircleEdge:_TriggerKeyframe(keyframeData)
  StoryEntitySpineCircleEdge.super._TriggerKeyframe(self, keyframeData)
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
  if keyframeData.SpineSkin ~= nil then
    spineSke.Skeleton:SetSkin(keyframeData.SpineSkin)
  end
  if keyframeData.Scroll ~= nil then
    self._inScrolling = true
    self._scrollStartTime = keyframeData.Time
    self._scrollStartFromCover = keyframeData.Scroll.StartFromCover
    self._scrollDuration = keyframeData.Scroll.Duration
    self._radius = keyframeData.Scroll.Radius
    if not string.isnullorempty(keyframeData.Scroll.Background.Resource) then
      self._backgroundReq = ResourceManager:GetInstance():SyncLoadAsset(keyframeData.Scroll.Background.Resource, LoadType.GameObject)
      if self._backgroundReq.Obj then
        self._backgroundObj = self._backgroundReq.Obj
        self._backgroundObj.transform:SetParent(self._spineMaskObject.transform, false)
        self._backgroundObj.transform.localPosition = Vector3(keyframeData.Scroll.Background.Offset[1], keyframeData.Scroll.Background.Offset[2], 0)
        self._backgroundObj:SetActive(true)
        self._backgroundObj.transform:SetAsFirstSibling()
      end
    end
    if keyframeData.Scroll.Shadow.ShowShadow then
      self._shadowSpineGameObject = UnityEngine.GameObject.Instantiate(self._spineGameObject, self._spineMaskObject.transform)
      self._shadowSpineGameObject.transform.localPosition = Vector3(keyframeData.Scroll.Shadow.Offset[1], keyframeData.Scroll.Shadow.Offset[2], 0)
      self._shadowSpineSke = self._shadowSpineGameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))
      self._shadowSpineSkeMultipleTex = self._shadowSpineGameObject:GetComponentInChildren(typeof(Spine.Unity.Modules.SkeletonGraphicMultiObject))
      self._spineGameObject.transform:SetAsLastSibling()
      if self._shadowSpineSke then
        self._shadowSpineSke.color = Color.black
      end
      if self._shadowSpineSkeMultipleTex then
        self._shadowSpineSkeMultipleTex.color = Color.black
        self._shadowSpineSkeMultipleTex.UseInstanceMaterials = true
        
        function self._shadowSpineSkeMultipleTex.OnInstanceMaterialCreated(material)
          self:HandleMultipleTexSpineMatCreated(material)
        end
        
        self._shadowSpineSkeMultipleTex:UpdateMesh()
        self._shadowSpineSkeMultipleTex.AnimationState:SetAnimation(0, "Story_norm", true)
      end
    end
    self._spineMaskObject:GetComponent("RawImage").enabled = true
    self._spineMaskObject:GetComponent("Mask").enabled = true
  end
end

function StoryEntitySpineCircleEdge:HandleMultipleTexSpineMatCreated(material)
  material:SetFloat("_StencilComp", 3)
  if self._entityConfig.Effect == "EMI" then
    material.shader = self._EMIMat.shader
    material:SetTexture("_NoiseTex", self._EMIMat:GetTexture("_NoiseTex"))
  end
end

function StoryEntitySpineCircleEdge:SetSpeak(speaking)
  local spineSke, shadowSpineSke
  if self._spineSke then
    spineSke = self._spineSke
    shadowSpineSke = self._shadowSpineSke
  elseif self._spineSkeMultipleTex then
    spineSke = self._spineSkeMultipleTex
    shadowSpineSke = self._shadowSpineSkeMultipleTex
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
      if shadowSpineSke then
        shadowSpineSke.AnimationState:SetAnimation(1, "shoot", loop)
      end
    else
      spineSke.AnimationState:SetAnimation(1, "aim", loop)
      if shadowSpineSke then
        shadowSpineSke.AnimationState:SetAnimation(1, "aim", loop)
      end
    end
  end
end

function StoryEntitySpineCircleEdge:_SetSpinePosition(pos)
  self._spineGameObject.transform.localPosition = pos
end

function StoryEntitySpineCircleEdge:_UpdateAnimation(time)
  local baseAllEnd = StoryEntitySpineCircleEdge.super._UpdateAnimation(self, time)
  if self._inScrolling then
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
      self._maskRect = self._spineMaskObject:GetComponent("RectTransform")
    end
    if not self._edgeObjectRect then
      self._edgeObjectRect = self._edgeObject:GetComponent("RectTransform")
    end
    if 1 <= t then
      self._inScrolling = false
    end
    local deltaRadius = lmathext.lerp(0, self._radius, effectT)
    local sizeDelta = Vector2(deltaRadius, deltaRadius)
    self._maskRect.sizeDelta = sizeDelta
    self._edgeObjectRect.sizeDelta = sizeDelta * 1.23
    return false
  else
    return baseAllEnd
  end
end

function StoryEntitySpineCircleEdge:_SetAlpha(alpha)
  self._spineColor.a = alpha
  if self._spineSke then
    self._spineSke.color = self._spineColor
  elseif self._spineSkeMultipleTex and self._spineSkeMultipleTex.Skeleton then
    self._spineSkeMultipleTex.Skeleton.A = alpha
  end
  self._edgeImgColor.a = alpha
  self._edgeImg.color = self._edgeImgColor
end

function StoryEntitySpineCircleEdge:_SetBrightness(brightness)
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

function StoryEntitySpineCircleEdge:_SetRotation(rot)
  self._spineGameObject.transform.localRotation = rot
end

function StoryEntitySpineCircleEdge:_SetScaling(scale)
  self._spineGameObject.transform.localScale = scale
end

function StoryEntitySpineCircleEdge:Destroy()
  StoryEntitySpineCircleEdge.super.Destroy(self)
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
  if self._shadowSpineGameObject then
    self._shadowSpineGameObject:Destroy()
    self._shadowSpineGameObject = nil
  end
  if self._backgroundReq then
    self._backgroundReq:Dispose()
  end
  if self._backgroundObj then
    self._backgroundObj:Destroy()
    self._backgroundObj = nil
  end
end
