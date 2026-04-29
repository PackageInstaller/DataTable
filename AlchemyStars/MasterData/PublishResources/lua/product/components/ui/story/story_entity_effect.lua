_class("StoryEntityEffect", StoryEntityMovable)
StoryEntityEffect = StoryEntityEffect

function StoryEntityEffect:Constructor(ID, gameObject, resRequest, storyManager)
  StoryEntityEffect.super.Constructor(self, ID, gameObject, resRequest, storyManager)
  self._type = StoryEntityType.Effect
  self._fadeCmp = nil
  self:_SetSpecialMaterial("RawImage", "Ring")
end

function StoryEntityEffect:_TriggerKeyframe(keyframeData)
  StoryEntityEffect.super._TriggerKeyframe(self, keyframeData)
  if keyframeData.FullScreen ~= nil then
    if keyframeData.FullScreen then
      self:_SetFullScreen()
    else
      self._storyManager:SetUIBlackSideSize(0, 0)
    end
  end
  if keyframeData.EffectFullScreen ~= nil and keyframeData.EffectFullScreen then
    self:_SetEffectFullScreen()
  end
  if keyframeData.Blink ~= nil then
    self:_SetBlinkAnim(keyframeData.Blink)
  end
  if keyframeData.MeshMatAnim ~= nil then
    self:_SetMeshMatAnim(keyframeData.MeshMatAnim)
  end
  if keyframeData.RawImageMatAnim ~= nil then
    self:_SetRawImageMatAnim(keyframeData.RawImageMatAnim)
  end
  if keyframeData.Color ~= nil then
    self:_SetMaterialColor(keyframeData.Color)
  end
  if keyframeData.Active ~= nil then
    self:_PlayAudio(keyframeData.Active)
  end
end

function StoryEntityEffect:_SetBlinkAnim(blinkData)
  if self._gameObject == nil then
    return
  end
  local image = self._gameObject:GetComponentInChildren(typeof(UnityEngine.UI.Image))
  if image == nil then
    return
  end
  local blinkMat = image.material
  if blinkMat == nil then
    return
  end
  blinkMat:SetFloat("_Height", blinkData.StartValue)
  blinkMat:DOFloat(blinkData.EndValue, "_Height", blinkData.Duration)
end

function StoryEntityEffect:_SetMeshMatAnim(animData)
  if self._gameObject == nil then
    return
  end
  local meshRenderer = self._gameObject:GetComponentInChildren(typeof(UnityEngine.MeshRenderer))
  if meshRenderer == nil then
    return
  end
  local meshMat = meshRenderer.sharedMaterial
  if meshMat == nil then
    return
  end
  for i = 1, #animData do
    meshMat:SetFloat(animData[i].Var, animData[i].StartValue)
    if animData[i].EndValue then
      meshMat:DOFloat(animData[i].EndValue, animData[i].Var, animData[i].Duration)
    end
  end
end

function StoryEntityEffect:_SetRawImageMatAnim(animData)
  if self._gameObject == nil then
    return
  end
  local rawImage = self._gameObject:GetComponentInChildren(typeof(UnityEngine.UI.RawImage))
  if rawImage == nil then
    return
  end
  local imageMat = rawImage.material
  if imageMat == nil then
    return
  end
  self._rawImageMat = imageMat
  for i = 1, #animData do
    imageMat:SetFloat(animData[i].Var, animData[i].StartValue)
    if animData[i].EndValue then
      imageMat:DOFloat(animData[i].EndValue, animData[i].Var, animData[i].Duration)
    end
  end
end

function StoryEntityEffect:_SetFullScreen()
  if not self._gameObject then
    return
  end
  local transform = self._gameObject.transform
  local fullPicWidth = 2532
  local fullPicHeight = 1170
  local screenWidth, screenHeight = self._storyManager:GetUICanvasSize()
  local effectAspect = fullPicWidth / fullPicHeight
  local screenAspect = screenWidth / screenHeight
  local effectScale = 1
  local blackSideHeight = 0
  local blackSideWidth = 0
  if effectAspect > screenAspect then
    effectScale = screenWidth / fullPicWidth
    local picHeight = fullPicHeight * screenWidth / fullPicWidth
    blackSideHeight = math.abs(screenHeight - picHeight) / 2
  elseif effectAspect < screenAspect then
    effectScale = screenHeight / fullPicHeight
    local picWidth = fullPicWidth * screenHeight / fullPicHeight
    blackSideWidth = math.abs(screenWidth - picWidth) / 2
  else
    effectScale = screenHeight / fullPicHeight
  end
  transform.localScale = Vector3(effectScale, effectScale, 1)
  self._storyManager:SetUIBlackSideSize(blackSideWidth, blackSideHeight)
end

function StoryEntityEffect:_SetEffectFullScreen()
  if not self._gameObject then
    return
  end
  local transform = self._gameObject.transform
  local screenWidth, screenHeight = self._storyManager:GetUICanvasSize()
  local vector2 = Vector2(0.5, 0.5)
  transform.anchorMin = vector2
  transform.anchorMax = vector2
  transform.pivot = vector2
  transform.sizeDelta = Vector2(screenWidth, screenHeight)
end

function StoryEntityEffect:_SetAlpha(alpha)
  if not self._fadeCmp then
    self:_GetFadeComponent()
    if not self._fadeCmp then
      Log.fatal("can't find alpha component")
      return
    end
  end
  self._fadeCmp.Alpha = alpha
end

function StoryEntityEffect:_GetFadeComponent()
  self._fadeCmp = self._gameObject:GetComponent(typeof(FadeComponent))
  if not self._fadeCmp then
    self._fadeCmp = self._gameObject:AddComponent(typeof(FadeComponent))
  end
end

function StoryEntityEffect:_SetMaterialColor(animData)
  if self._gameObject == nil then
    return
  end
  local renderer = self._gameObject:GetComponent(typeof(UnityEngine.Renderer))
  if not renderer then
    return
  end
  local intensity = 1
  if animData.Intensity and animData.Intensity > 0 then
    intensity = animData.Intensity
  end
  self._sharedMaterialsColor = Color(animData.RGB.R * intensity, animData.RGB.G * intensity, animData.RGB.B * intensity, 1)
  for i = 0, renderer.sharedMaterials.Length - 1 do
    renderer.sharedMaterials[i]:DOColor(self._sharedMaterialsColor, "_MainColor", animData.Duration)
  end
end

function StoryEntityEffect:Destroy()
  self:_RevertMatData()
  StoryEntityEffect.super.Destroy(self)
end

function StoryEntityEffect:_RevertMatData()
  if not self._rawImageMat then
    return
  end
  if self._rawImageMat.name ~= "uieff_Story_AntiDeColor" then
    return
  end
  self._rawImageMat:SetFloat("_Decolor", 0)
  self._rawImageMat:SetFloat("_AntiColor", 0)
end

function StoryEntityEffect:_SetSpecialMaterial(srcName, tarName)
  local srcTransform = GameObjectHelper.FindChild(self._gameObject.transform, srcName)
  local tarTransform = GameObjectHelper.FindChild(self._gameObject.transform, tarName)
  if srcTransform and tarTransform then
    local rawImage = srcTransform.gameObject:GetComponent(typeof(UnityEngine.UI.RawImage))
    local renderer = tarTransform.gameObject:GetComponent(typeof(UnityEngine.Renderer))
    if rawImage and renderer then
      renderer.material:SetTexture("_MainTex", rawImage.material:GetTexture("_MainTex"))
    end
  end
end

function StoryEntityEffect:GetMaterial()
  if self._gameObject == nil then
    return nil
  end
  local rawImage = self._gameObject:GetComponentInChildren(typeof(UnityEngine.UI.RawImage))
  if rawImage ~= nil then
    return rawImage.material
  end
  local meshRenderer = self._gameObject:GetComponentInChildren(typeof(UnityEngine.MeshRenderer))
  if meshRenderer ~= nil then
    return meshRenderer.sharedMaterial
  end
  return nil
end

function StoryEntityEffect:_PlayAudio(active)
  if active then
    if self._gameObject.name == "uieff_N20_Favorability_up" then
      AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N20StrategyAdd)
    elseif self._gameObject.name == "uieff_N20_Favorability_down" then
      AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N20StrategyReduce)
    elseif self._gameObject.name == "uieff_N28_Favorability_up_1" then
      AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N20StrategyAdd)
    elseif self._gameObject.name == "uieff_N28_Favorability_up_2" then
      AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N20StrategyAdd)
    end
  end
end
