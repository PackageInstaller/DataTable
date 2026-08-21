require("home_story_entity_movable")
_class("HomeMovieEntitySpine", HomeStoryEntityMovable)
HomeMovieEntitySpine = HomeMovieEntitySpine
local MovieSpineEntityAnimationType = {Dissolve = 1}
_enum("MovieSpineEntityAnimationType", MovieSpineEntityAnimationType)

function HomeMovieEntitySpine:Constructor(ID, gameObject, resRequest, storyManager, storyController, entityConfig)
  HomeMovieEntitySpine.super.Constructor(self, ID, gameObject, resRequest, storyManager)
  self._uiController = storyController
  self._type = StoryEntityType.Spine
  self._spineSke = gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))
  self._spineSkeMultipleTex = gameObject:GetComponentInChildren(typeof(Spine.Unity.Modules.SkeletonGraphicMultiObject))
  self._entityConfig = entityConfig
  self._isSpeaking = false
  self._spineColor = nil
  self._matInsList = {}
  self._EMIMatResRequest = nil
  self._EMIMat = nil
  self._DissolveMatResRequest = nil
  self._DissolveMat = nil
  self._spineAnimationData = {}
  self._outLine = nil
  self._outLineIntensity = 2.5
  if self._spineSke then
    if entityConfig.Effect == "EMI" then
      self._spineSke.material = UnityEngine.Material:New(self._spineSke.material)
      self._EMIMatResRequest = ResourceManager:GetInstance():SyncLoadAsset("spine_graphic_dc.mat", LoadType.Mat)
      self._EMIMat = self._EMIMatResRequest.Obj
      self._spineSke.material.shader = self._EMIMat.shader
      self._spineSke.material:SetTexture("_NoiseTex", self._EMIMat:GetTexture("_NoiseTex"))
    elseif entityConfig.Effect == "DISSOLVE" then
      self._spineSke.material = UnityEngine.Material:New(self._spineSke.material)
      self._DissolveMatResRequest = ResourceManager:GetInstance():SyncLoadAsset("spine_graphic_dissolve.mat", LoadType.Mat)
      self._DissolveMat = self._DissolveMatResRequest.Obj
      self._spineSke.material.shader = self._DissolveMat.shader
      self._spineSke.material:SetTexture("_MaskTex", self._DissolveMat:GetTexture("_MaskTex"))
    end
    self._spineColor = self._spineSke.color
    self._spineSke.AnimationState:SetAnimation(0, "Story_norm", true)
  elseif self._spineSkeMultipleTex then
    if entityConfig.Effect == "EMI" then
      self._EMIMatResRequest = ResourceManager:GetInstance():SyncLoadAsset("spine_dc.mat", LoadType.Mat)
      self._EMIMat = self._EMIMatResRequest.Obj
      self._spineSkeMultipleTex.UseInstanceMaterials = true
      
      function self._spineSkeMultipleTex.OnInstanceMaterialCreated(material)
        self:HandleMultipleTexSpineMatCreated(material)
      end
      
      self._spineSkeMultipleTex:UpdateMesh()
    end
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
end

function HomeMovieEntitySpine:HandleMultipleTexSpineMatCreated(material)
  if self._entityConfig.Effect == "EMI" then
    material.shader = self._EMIMat.shader
    material:SetTexture("_NoiseTex", self._EMIMat:GetTexture("_NoiseTex"))
  end
end

function HomeMovieEntitySpine:Destroy()
  HomeMovieEntitySpine.super.Destroy(self)
  for i = 1, #self._matInsList do
    UnityEngine.Object.Destroy(self._matInsList[i])
  end
  self._matInsList = {}
  if self._EMIMatResRequest then
    self._EMIMat = nil
    self._EMIMatResRequest:Dispose()
    self._EMIMatResRequest = nil
  end
  if self._DissolveMatResRequest then
    self._DissolveMat = nil
    self._DissolveMatResRequest:Dispose()
    self._DissolveMatResRequest = nil
  end
  if self._spineSkeMultipleTex then
    self._spineSkeMultipleTex.OnInstanceMaterialCreated = nil
  end
end

function HomeMovieEntitySpine:_TriggerKeyframe(keyframeData)
  HomeMovieEntitySpine.super._TriggerKeyframe(self, keyframeData)
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
  if keyframeData.LoopAnimation ~= nil and spineSke then
    spineSke.AnimationState:SetAnimation(0, keyframeData.LoopAnimation, true)
  end
  if keyframeData.Animation ~= nil and spineSke then
    spineSke.AnimationState:SetAnimation(0, keyframeData.Animation, false)
  end
  if keyframeData.Dissolve ~= nil and self._entityConfig.Effect == "DISSOLVE" then
    local aniInfo = {
      MovieSpineEntityAnimationType.Dissolve,
      keyframeData.Time,
      keyframeData.Dissolve.StartValue,
      keyframeData.Dissolve.EndValue
    }
    self._spineAnimationData[keyframeData.Dissolve] = aniInfo
  end
  if keyframeData.TilingSize ~= nil then
    self:_SetTilingSize(keyframeData.TilingSize)
  end
  if keyframeData.FullScreen ~= nil then
    if keyframeData.FullScreen then
      self:_SetSpineFullScreen()
      GameGlobal.UIStateManager():SetBlackSideVisible(true)
    else
      self._uiController:SetBlackSideSize(0, 0)
      GameGlobal.UIStateManager():SetBlackSideVisible(false)
    end
  end
  if keyframeData.OutLine ~= nil then
    self:_AddOutLineComponent()
  end
  if keyframeData.SpineSkin ~= nil then
    spineSke.Skeleton:SetSkin(keyframeData.SpineSkin)
  end
end

function HomeMovieEntitySpine:_SetSpineFullScreen()
  if not self._gameObject then
    return
  end
  local transfrom = self._gameObject.transform
  local fullPicWidth = 2532
  local fullPicHeight = 1170
  local screenWidth, screenHeight = self._uiController:GetCanvasSize()
  local spineAspect = fullPicWidth / fullPicHeight
  local screenAspect = screenWidth / screenHeight
  local spineScale = 1
  local blackSideHeight = 0
  local blackSideWidth = 0
  if spineAspect > screenAspect then
    spineScale = screenWidth / fullPicWidth
    local picHeight = fullPicHeight * screenWidth / fullPicWidth
    blackSideHeight = math.abs(screenHeight - picHeight) / 2
  elseif spineAspect < screenAspect then
    spineScale = screenHeight / fullPicHeight
    local picWidth = fullPicWidth * screenHeight / fullPicHeight
    blackSideWidth = math.abs(screenWidth - picWidth) / 2
  else
    spineScale = screenHeight / fullPicHeight
  end
  transfrom.localScale = Vector3(spineScale, spineScale, 1)
  self._uiController:SetBlackSideSize(blackSideWidth, blackSideHeight)
end

function HomeMovieEntitySpine:_UpdateAnimation(time)
  local baseEnd = HomeMovieEntitySpine.super._UpdateAnimation(self, time)
  local allEnd = true
  for aniData, aniInfo in pairs(self._spineAnimationData) do
    allEnd = false
    local t = 1
    if aniData.Duration > 0 then
      t = (time - aniInfo[2]) / aniData.Duration
    end
    if 1 < t then
      t = 1
    end
    if aniInfo[1] == MovieSpineEntityAnimationType.Dissolve then
      self:_SetDissolve(lmathext.lerp(aniInfo[3], aniInfo[4], t))
    end
    if 1 <= t then
      self._spineAnimationData[aniData] = nil
    end
  end
  return allEnd and baseEnd
end

function HomeMovieEntitySpine:SetSpeak(speaking)
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

function HomeMovieEntitySpine:_SetDissolve(value)
  self._spineSke.material:SetFloat("_Dissovle", value)
end

function HomeMovieEntitySpine:_SetTilingSize(value)
  self._spineSke.material:SetFloat("_TilingSize", value)
end

function HomeMovieEntitySpine:_SetAlpha(alpha)
  self._spineColor.a = alpha
  if self._spineSke then
    self._spineSke.color = self._spineColor
    if self._outLine then
      self._outLine.intensity = self._outLineIntensity
    end
  elseif self._spineSkeMultipleTex and self._spineSkeMultipleTex.Skeleton then
    self._spineSkeMultipleTex.Skeleton.A = alpha
    if self._outLine then
      self._outLine.intensity = self._outLineIntensity * alpha
    end
  end
end

function HomeMovieEntitySpine:_SetBrightness(brightness)
  self._spineColor:Set(brightness, brightness, brightness, self._spineColor.a)
  if self._spineSke then
    self._spineSke.color = self._spineColor
    if self._outLine then
      self._outLine.intensity = self._outLineIntensity
    end
  elseif self._spineSkeMultipleTex and self._spineSkeMultipleTex.Skeleton then
    self._spineSkeMultipleTex.Skeleton.R = brightness
    self._spineSkeMultipleTex.Skeleton.G = brightness
    self._spineSkeMultipleTex.Skeleton.B = brightness
    if self._outLine then
      self._outLine.intensity = self._outLineIntensity * brightness
    end
  end
end

function HomeMovieEntitySpine:_AddOutLineComponent()
  if APPVER125 then
    self._outLine = self._gameObject:GetComponent(typeof(OutlineComponent))
    if not self._outLine then
      self._outLine = self._gameObject:AddComponent(typeof(OutlineComponent))
    end
    local camera = GameGlobal.UIStateManager():GetControllerCamera("UIHomeStoryController")
    if camera then
      self._outLine.blurNum = 3
      self._outLine.intensity = self._outLineIntensity
      self._outLine.outlineSize = 1
      self._outLine.blendType = OutlineComponent.BlendType.Blend
      self._outLine.m_CustomCamera = camera
    else
      self._outLine.enabled = false
    end
  end
end

function HomeMovieEntitySpine:GetMaterial()
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
