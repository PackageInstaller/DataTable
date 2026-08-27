local cs_ParticleSystemRenderer = CS.UnityEngine.ParticleSystemRenderer
local cs_PostProcessVolume
local CameraEffectUtil = {}
local cs_Screen, cs_GameObject, cs_PostProcessLayer
local cs_DOTween = CS.DG.Tweening.DOTween
local cs_Shader = CS.UnityEngine.Shader
CameraEffectUtil.mainColorNameHash = cs_Shader.PropertyToID("_MainColor")
CameraEffectUtil._CRTScreenWaveScaleNameHash = cs_Shader.PropertyToID("_CRTScreenWaveScale")

local function OldMovieCameraEffect(resloader, camera)
  if IsNull(camera) then
    return
  end
  if IsNull(resloader) then
    return
  end
  if cs_PostProcessVolume == nil then
    cs_PostProcessVolume = CS.UnityEngine.Rendering.PostProcessing.PostProcessVolume
  end
  local oldMovieMaskPath = "FX/Scene/BattleScene/OldMovieEffect/FXP_OldMovieMask" .. PathConsts.PrefabExtension
  local oldMovieMaskWait = resloader:LoadABAssetAsyncAwait(oldMovieMaskPath)
  coroutine.yield(oldMovieMaskWait)
  local oldMovieMaskPrefab = oldMovieMaskWait.Result
  if IsNull(oldMovieMaskPrefab) then
    return
  end
  local oldMovieMaskPoj = oldMovieMaskPrefab:Instantiate(camera.transform)
  oldMovieMaskPoj.transform.position = camera.transform.position + camera.transform.forward * 0.2
  local bind = {}
  UIUtil.LuaUIBindingTable(oldMovieMaskPoj.transform, bind)
  local oldMoviePostProcessVolumeProfile = bind.pp_OldMovie
  if not IsNull(oldMoviePostProcessVolumeProfile) then
    local oldMoviePostProcessVolume = camera:GetComponent(typeof(cs_PostProcessVolume))
    if IsNull(oldMoviePostProcessVolume) then
      oldMoviePostProcessVolume = camera:AddComponent(typeof(cs_PostProcessVolume))
    end
    oldMoviePostProcessVolume.profile = oldMoviePostProcessVolumeProfile
  end
end

local function ShowOldMovieUIEffect()
  UIManager:ShowWindowAsync(UIWindowTypeID.EffectMask, function(window)
    window:ShowOldMovieEffectMask()
  end)
end

local function HideOldMovieUIEffect()
  local window = UIManager:GetWindow(UIWindowTypeID.EffectMask)
  if window ~= nil then
    window:HideOldMovieEffectMask()
    window:OnDelete()
    UIManager:DeleteWindow(UIWindowTypeID.EffectMask)
  end
end

function CameraEffectUtil:ChangeEffectScaleBySceen(effectObj)
  if IsNull(self.camera) then
    return
  end
  if IsNull(effectObj) or IsNull(effectObj.transform) then
    return
  end
  if cs_Screen == nil then
    cs_Screen = CS.UnityEngine.Screen
  end
  local widthScale = cs_Screen.width / 1920
  local heightScale = cs_Screen.height / 1080
  local nearClipPlane = self.camera.nearClipPlane
  local fov = self.camera.fieldOfView
  if self.orginFov == fov then
    return
  end
  local defaultDistance = 0.39
  if nearClipPlane > defaultDistance then
    local child = effectObj.transform:GetChild(0)
    if not IsNull(child) then
      local distance = nearClipPlane + 0.1
      local scaleY = math.tan(fov * Mathf.Deg2Rad * 0.5) * distance * 2
      local scaleX = scaleY * self.camera.aspect
      child.localPosition = Vector3.Temp(0, 0, distance)
      child.localScale = Vector3.Temp(scaleX * 2, scaleY * 3.5, 1)
    end
  else
    local zScale = heightScale / 2.5 / math.tan(fov * 0.5 * Mathf.Deg2Rad)
    effectObj.transform.localScale = Vector3.Temp(widthScale, heightScale, zScale)
  end
  self.orginFov = self.camera.fieldOfView
end

function CameraEffectUtil:ShowEosSkillEffect()
  local camera = UIManager:GetMainCamera()
  if IsNull(camera) then
    return
  end
  self.camera = camera
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  local resCfg = skinCtr:GetResModel(1068, 306802)
  local origresCfg = skinCtr:GetResModel(1068)
  local CS_AnimationEffectController_Ins = CS.AnimationEffectController.Instance
  CS_AnimationEffectController_Ins:KillRoleEffect(camera.gameObject)
  CS_AnimationEffectController_Ins:RecycleRoleEffect(camera.gameObject)
  local eosScreenEffectId = 106819
  local effect = CS_AnimationEffectController_Ins:AddAnimationEffectByBattleEffectId(eosScreenEffectId, camera.gameObject, resCfg.src_id_model, origresCfg.src_id_model)
  effect.effectCfg.Layer = LayerMask.Character
  effect:Play()
  self.orginFov = nil
  
  function self.__ChangeEffectScaleBySceen()
    self:ChangeEffectScaleBySceen(effect.effectUnit.gameObject)
  end
  
  UpdateManager:AddLateUpdate(self.__ChangeEffectScaleBySceen)
end

function CameraEffectUtil:HideEosSkillEffect(needDispose)
  local camera = self.camera
  if not IsNull(camera) then
    local CS_AnimationEffectController_Ins = CS.AnimationEffectController.Instance
    CS_AnimationEffectController_Ins:KillRoleEffect(camera.gameObject)
    CS_AnimationEffectController_Ins:RecycleRoleEffect(camera.gameObject)
    if needDispose then
      CS_AnimationEffectController_Ins:DisposeAllEffects()
    end
  end
  if self.__ChangeEffectScaleBySceen ~= nil then
    UpdateManager:RemoveLateUpdate(self.__ChangeEffectScaleBySceen)
    self.__ChangeEffectScaleBySceen = nil
  end
  self.orginFov = nil
end

function CameraEffectUtil:ShowHubbleEntropyEffect(strength)
  if self.camera == nil or IsNull(self.camera) then
    local camera = UIManager:GetMainCamera()
    if IsNull(camera) then
      return
    end
    self.camera = camera
  end
  local camera = self.camera
  local tableKey = "ShowHubbleEntropyEffect"
  if self.__HubbleEntropyEffectMat == nil then
    local CS_AnimationEffectController_Ins = CS.AnimationEffectController.Instance
    CS_AnimationEffectController_Ins:KillRoleEffect(camera.gameObject)
    CS_AnimationEffectController_Ins:RecycleRoleEffect(camera.gameObject)
    local hubbleEntropyScreenEffectId = 12108
    local effect = CS_AnimationEffectController_Ins:AddAnimationEffectByBattleEffectId(hubbleEntropyScreenEffectId, camera.gameObject, "", "")
    effect.effectCfg.Layer = LayerMask.Character
    effect:Play()
    local particleSystemRenderer = effect.effectUnit.transform:Find("low/E001_skyGround").gameObject:GetComponent(typeof(cs_ParticleSystemRenderer))
    self.__HubbleEntropyEffectMat = particleSystemRenderer.material
    self.orginFov = nil
    if self.__ChangeEffectScaleBySceenTable == nil then
      self.__ChangeEffectScaleBySceenTable = {}
    end
    
    local function hubbleEntropyEffect()
      self:ChangeEffectScaleBySceen(effect.effectUnit.gameObject)
    end
    
    self.__ChangeEffectScaleBySceenTable[tableKey] = hubbleEntropyEffect
    UpdateManager:AddLateUpdate(self.__ChangeEffectScaleBySceenTable[tableKey])
  end
  if self.__HubbleEntropyEffectMat ~= nil then
    local colorNameHash = self.mainColorNameHash
    local color = self.__HubbleEntropyEffectMat:GetColor(colorNameHash)
    if color.a ~= math.clamp(strength, 0, 1) then
      color.a = strength
      self.__HubbleEntropyEffectMat:SetColor(colorNameHash, color)
    end
  end
end

function CameraEffectUtil:HideHubbleEntropyEffect(needDispose)
  local camera = self.camera
  if not IsNull(camera) then
    local CS_AnimationEffectController_Ins = CS.AnimationEffectController.Instance
    CS_AnimationEffectController_Ins:KillRoleEffect(camera.gameObject)
    CS_AnimationEffectController_Ins:RecycleRoleEffect(camera.gameObject)
    if needDispose then
      CS_AnimationEffectController_Ins:DisposeAllEffects()
    end
  end
  local tableKey = "ShowHubbleEntropyEffect"
  if self.__ChangeEffectScaleBySceenTable ~= nil and self.__ChangeEffectScaleBySceenTable[tableKey] then
    UpdateManager:RemoveLateUpdate(self.__ChangeEffectScaleBySceenTable[tableKey])
    self.__ChangeEffectScaleBySceenTable[tableKey] = nil
  end
  self.orginFov = nil
  self.__HubbleEntropyEffectMat = nil
  self.camera = nil
end

function CameraEffectUtil:ShowKurisuSkillEffect()
  local camera = UIManager:GetMainCamera()
  if IsNull(camera) then
    return
  end
  self.camera = camera
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  local resCfg = skinCtr:GetResModel(1078, 307800)
  local origresCfg = skinCtr:GetResModel(1078)
  local CS_AnimationEffectController_Ins = CS.AnimationEffectController.Instance
  CS_AnimationEffectController_Ins:KillRoleEffect(camera.gameObject)
  CS_AnimationEffectController_Ins:RecycleRoleEffect(camera.gameObject)
  local KurisuScreenEffectId = 107808
  local effect = CS_AnimationEffectController_Ins:AddAnimationEffectByBattleEffectId(KurisuScreenEffectId, camera.gameObject, resCfg.src_id_model, origresCfg.src_id_model)
  effect.effectCfg.Layer = LayerMask.Character
  effect:Play()
  self.orginFov = nil
  if self.__ChangeEffectScaleBySceenTable == nil then
    self.__ChangeEffectScaleBySceenTable = {}
  end
  local tableKey = "ShowKurisuSkillEffect"
  local gameObject = effect.effectUnit.gameObject
  
  local function kurisuUltimateEffect()
    self:ChangeEffectScaleBySceen(gameObject)
  end
  
  self.__ChangeEffectScaleBySceenTable[tableKey] = kurisuUltimateEffect
  UpdateManager:AddLateUpdate(self.__ChangeEffectScaleBySceenTable[tableKey])
end

function CameraEffectUtil:HideKurisuSkillEffect(needDispose)
  local camera = self.camera
  if not IsNull(camera) then
    local CS_AnimationEffectController_Ins = CS.AnimationEffectController.Instance
    CS_AnimationEffectController_Ins:KillRoleEffect(camera.gameObject)
    CS_AnimationEffectController_Ins:RecycleRoleEffect(camera.gameObject)
    if needDispose then
      CS_AnimationEffectController_Ins:DisposeAllEffects()
    end
  end
  local tableKey = "ShowKurisuSkillEffect"
  if self.__ChangeEffectScaleBySceenTable ~= nil and self.__ChangeEffectScaleBySceenTable[tableKey] then
    UpdateManager:RemoveLateUpdate(self.__ChangeEffectScaleBySceenTable[tableKey])
    self.__ChangeEffectScaleBySceenTable[tableKey] = nil
  end
  self.orginFov = nil
end

function CameraEffectUtil:ShowSteinLineChangeEffect(worldChangeId, closeCallback)
  AudioManager:PlayAudioById(7025)
  local moviePath = "Activity/23steinsgateJump"
  local moviePlayer = UIManager:ShowWindow(UIWindowTypeID.MoviePlayer)
  moviePlayer:SetBgAlpha(0)
  moviePlayer:PlayMovie(moviePath, nil, 1, false, function()
    if self.steinEffectPPStackItem ~= nil then
      self:RemovePPStack(self.steinEffectPPStackItem)
      if not IsNull(self.steineffectProfile) then
        local temp = self.steineffectProfile
        self.steineffectProfile = nil
        DestroyUnityObject(temp)
      end
      self.steinEffectPPStackItem = nil
      self.steineffectProfile = nil
    end
    AudioManager:RemoveCueSheet("SG_Jump")
    if closeCallback ~= nil then
      closeCallback()
    end
  end)
  local delayFadeTime = 5
  local fadeTime = 1.2
  moviePlayer:SetMovieFade(delayFadeTime, fadeTime)
  local functionEffectPath = "FX/UI_effct/SteinsGate/FXP_SteinsGate_gongshi.prefab"
  local magicCircleEffectPath = "FX/UI_effct/SteinsGate/FXP_SteinsGate_huawen.prefab"
  local worldNumberChangeEffectPath = string.format("FX/UI_effct/SteinsGate/FXP_SteinsGate_number_%s.prefab", worldChangeId)
  moviePlayer:AddUIParticle(functionEffectPath)
  moviePlayer:AddUIParticle(worldNumberChangeEffectPath, function(effect)
    local cs_Ease = CS.DG.Tweening.Ease
    effect.gameObject:SetActive(false)
    local __startDelay = 1.2
    TimerManager:StartTimer(__startDelay, function()
      if IsNull(effect) then
        return
      end
      effect.gameObject:SetActive(true)
      effect.transform:DOScale(30, 0.7):From():SetEase(cs_Ease.InCubic):SetLink(effect)
      effect.transform:DOScale(8.888, 2):SetDelay(3.05):SetEase(cs_Ease.OutCubic):SetLink(effect)
    end, self, true)
  end)
  moviePlayer:AddUIParticle(magicCircleEffectPath)
  local wavePath = "FX/UI_effct/SteinsGate/FXP_SteinsGate_number_noise_02.prefab"
  moviePlayer:AddUIParticle(wavePath, function(effect)
    effect.gameObject:SetActive(false)
    local __startDelay = 5.2
    TimerManager:StartTimer(__startDelay, function()
      if IsNull(effect) then
        return
      end
      effect.gameObject:SetActive(true)
    end, self, true)
  end)
end

function CameraEffectUtil:HideSteinLineChangeEffect()
end

function CameraEffectUtil:ShowSteinLineChangePostEffect(resLoader)
  if IsNull(resLoader) then
    return
  end
  local steinsGatePPBindPrefab = resLoader:LoadABAsset("FX/UI_effct/SteinsGate/FXP_SteinsGate_PostProfileBind.prefab")
  if IsNull(steinsGatePPBindPrefab) then
    error("steineffectProfile is null")
    return
  end
  local camera = UIManager.UICamera
  if self.steinEffectPPStackItem ~= nil then
    self:RemovePPStack(self.steinEffectPPStackItem)
    DestroyUnityObject(self.steineffectProfile)
    self.steinEffectPPStackItem = nil
    self.steineffectProfile = nil
  end
  local ppPrefabPath = "FX/UI_effct/SteinsGate/FXP_SteinsGate_PostProfileBind.prefab"
  local bindPPName = "steinChangeEffectPP"
  self:__LoadAndSetPP(camera, resLoader, ppPrefabPath, bindPPName, function(ppStackItem)
    if not IsNull(UIManager.csUIManager.UICamPPLayer) then
      UIManager.csUIManager.UICamPPLayer.enabled = true
    end
    self.steinEffectPPStackItem = ppStackItem
    self.steineffectProfile = ppStackItem.profile
    local steineffectProfile = self.steineffectProfile
    local ok = false
    local colorGrading, radialRGBSplit
    ok, colorGrading = steineffectProfile:TryGetSettings(typeof(CS.UnityEngine.Rendering.PostProcessing.ColorGrading))
    if not ok then
      error("Cant get ColorGrading")
      return
    end
    ok, radialRGBSplit = steineffectProfile:TryGetSettings(typeof(CS.XPostProcessing.RadialRGBSplit))
    if not ok then
      error("Cant get radialRGBSplit")
      return
    end
    if IsNull(colorGrading) or IsNull(radialRGBSplit) then
      return
    end
    colorGrading.postExposure:Override(0)
    colorGrading.saturation:Override(0)
    colorGrading.colorFilter:Override(Color.white)
    colorGrading.contrast:Override(0)
    radialRGBSplit.RadialCenterX:Override(0.5)
    radialRGBSplit.RadialCenterY:Override(0.5)
    radialRGBSplit.BlurRadius:Override(0)
    local duration = 1.5
    local filtercolor = Color.Temp(1.12, 0.2638743, 0, 0)
    local cs_Ease = CS.DG.Tweening.Ease
    local riseX = 0
    local startShakeCount = 0
    if IsNull(cs_DOTween) then
      cs_DOTween = CS.DG.Tweening.DOTween
    end
    cs_DOTween.To(function()
      return 0
    end, function(t)
      if IsNull(colorGrading) or IsNull(radialRGBSplit) then
        return
      end
      local jumpValue = 0
      local riseT = riseX / math.pi * 1.2
      local isRiseState = riseT < 1.5
      riseX = isRiseState and riseX + 1 * t or riseX + 0.01 * Mathf.Lerp(80, 20, t)
      local powT = t * t * t * t
      if isRiseState then
        colorGrading.postExposure:Override((1 - riseT) * 3.5)
        colorGrading.saturation:Override(riseT * 6)
      else
        colorGrading.postExposure:Override((1 - t) * 3)
        colorGrading.saturation:Override(0)
        colorGrading.colorFilter:Override(Color.Lerp(Color.white, filtercolor, 1 - powT))
        colorGrading.contrast:Override((1 - t) * 50)
      end
      if isRiseState then
        jumpValue = riseX
        radialRGBSplit.RadialCenterX:Override(0.5)
        radialRGBSplit.RadialCenterY:Override(0.5)
        radialRGBSplit.BlurRadius:Override(7 * t)
      else
        local start = 0.99
        local endvalue = 0.995
        local one = 1 / (endvalue - start)
        if t < 0.95 then
          startShakeCount = startShakeCount + 1
          if 16 < startShakeCount then
            local noiseValue = (math.random(100) / 100 - 0.5) * 2 * 10
            jumpValue = noiseValue / 2 * 3 / 4 * math.pi * (1 - t)
            radialRGBSplit.RadialCenterX:Override(math.random(40, 60) / 100)
            radialRGBSplit.RadialCenterY:Override(math.random(40, 60) / 100)
            radialRGBSplit.BlurRadius:Override(jumpValue)
            startShakeCount = 0
          end
        else
          radialRGBSplit.RadialCenterX:Override(0.5)
          radialRGBSplit.RadialCenterY:Override(0.5)
          radialRGBSplit.BlurRadius:Override(1 - t)
        end
      end
    end, 1, duration):SetEase(cs_Ease.OutQuad)
    local sinX = 0
    local endShakeCount = 0
    if IsNull(cs_DOTween) then
      cs_DOTween = CS.DG.Tweening.DOTween
    end
    cs_DOTween.To(function()
      return 0
    end, function(t)
      if IsNull(colorGrading) or IsNull(radialRGBSplit) then
        return
      end
      local jumpValue = 0
      local shakeStartTime = 0
      local shakeEndTime = 0.5
      if t > shakeStartTime and t < shakeEndTime then
      else
        local hueShiftStartTime = 0.8
        local hueShiftEndTime = 0.9
        if t > hueShiftStartTime and t < hueShiftEndTime then
          local hueShiftLerp = (t - hueShiftStartTime) * (1 / (hueShiftEndTime - hueShiftStartTime))
          colorGrading.hueShift:Override(60 * (1 - hueShiftLerp))
        end
      end
    end, 1, 4):SetEase(cs_Ease.OutExpo):SetDelay(5.4)
  end)
end

function CameraEffectUtil:InstantiatePostProcessProfile(postProcessProfile)
  if IsNull(postProcessProfile) then
    return
  end
  if cs_GameObject == nil then
    cs_GameObject = CS.UnityEngine.GameObject
  end
  local instancePPProfile = cs_GameObject.Instantiate(postProcessProfile)
  instancePPProfile.settings:Clear()
  for i = 0, postProcessProfile.settings.Count - 1 do
    local instanceSetting = cs_GameObject.Instantiate(postProcessProfile.settings[i])
    instancePPProfile.settings:Add(instanceSetting)
  end
  return instancePPProfile
end

function CameraEffectUtil:__LoadAndSetPP(camera, resloader, ppPrefabPath, bindPPName, loadPPCallback)
  if IsNull(camera) then
    return
  end
  if IsNull(resloader) then
    return
  end
  if cs_PostProcessVolume == nil then
    cs_PostProcessVolume = CS.UnityEngine.Rendering.PostProcessing.PostProcessVolume
  end
  resloader:LoadABAssetAsync(ppPrefabPath, function(prefab)
    if prefab == nil then
      return
    end
    local bind = {}
    UIUtil.LuaUIBindingTable(prefab.transform, bind)
    local EffectProfile = bind[bindPPName]
    local postProcessVolume = camera:GetComponent(typeof(cs_PostProcessVolume))
    if not IsNull(EffectProfile) then
      local instancePPProfile = self:InstantiatePostProcessProfile(EffectProfile)
      local ppStackItem = self:AddPPStack(camera, instancePPProfile)
      postProcessVolume.sharedProfile = instancePPProfile
      postProcessVolume.profile = instancePPProfile
      if loadPPCallback ~= nil then
        loadPPCallback(ppStackItem)
      end
    end
  end)
end

function CameraEffectUtil:__ClosePP(camera)
  if self.cameraPPStackDic == nil then
    return
  end
  if self.cameraPPStackDic[camera] == nil then
    return
  end
  if cs_PostProcessVolume == nil then
    cs_PostProcessVolume = CS.UnityEngine.Rendering.PostProcessing.PostProcessVolume
  end
  local pre = self.cameraPPStackDic[camera]:Peek()
  while pre ~= nil and not pre.active and self.cameraPPStackDic[camera]:Count() > 1 do
    self.cameraPPStackDic[camera]:Pop()
    pre = self.cameraPPStackDic[camera]:Peek()
  end
  local postProcessVolume = camera:GetComponent(typeof(cs_PostProcessVolume))
  if pre ~= nil and pre.active and not IsNull(pre.profile) then
    postProcessVolume.profile = nil
    postProcessVolume.sharedProfile = pre.profile
  else
    postProcessVolume.sharedProfile = nil
    postProcessVolume.profile = nil
  end
  if pre.ppLayerEnabled ~= nil then
    if cs_PostProcessLayer == nil then
      cs_PostProcessLayer = CS.UnityEngine.Rendering.PostProcessing.PostProcessLayer
    end
    local PostProcessLayer = camera:GetComponent(typeof(cs_PostProcessLayer))
    if not IsNull(PostProcessLayer) then
      PostProcessLayer.enabled = pre.ppLayerEnabled
    end
  end
  for camera, stack in pairs(self.cameraPPStackDic) do
    if IsNull(camera) then
      self.cameraPPStackDic[camera] = nil
    end
  end
end

function CameraEffectUtil:AddPPStack(camera, instancePPProfile)
  if IsNull(camera) then
    return
  end
  if IsNull(instancePPProfile) then
    return
  end
  if cs_PostProcessVolume == nil then
    cs_PostProcessVolume = CS.UnityEngine.Rendering.PostProcessing.PostProcessVolume
  end
  if self.cameraPPStackDic == nil then
    self.cameraPPStackDic = {}
  end
  if self.cameraPPStackDic[camera] == nil then
    local Stack = require("Framework.Lib.Stack")
    self.cameraPPStackDic[camera] = Stack.New()
    local postProcessVolume = camera:GetComponent(typeof(cs_PostProcessVolume))
    if not IsNull(postProcessVolume) then
      local ppStackItem = {}
      ppStackItem.profile = postProcessVolume.sharedProfile
      ppStackItem.active = true
      ppStackItem.camera = camera
      if cs_PostProcessLayer == nil then
        cs_PostProcessLayer = CS.UnityEngine.Rendering.PostProcessing.PostProcessLayer
      end
      local PostProcessLayer = camera:GetComponent(typeof(cs_PostProcessLayer))
      if not IsNull(PostProcessLayer) then
        ppStackItem.ppLayerEnabled = PostProcessLayer.enabled
      end
      self.cameraPPStackDic[camera]:Push(ppStackItem)
    end
  end
  local ppStackItem = {}
  ppStackItem.profile = instancePPProfile
  ppStackItem.active = true
  ppStackItem.camera = camera
  self.cameraPPStackDic[camera]:Push(ppStackItem)
  return ppStackItem
end

function CameraEffectUtil:RemovePPStack(ppStackItem)
  if ppStackItem == nil then
    return
  end
  if IsNull(ppStackItem.camera) then
    return
  end
  ppStackItem.active = false
  self:__ClosePP(ppStackItem.camera, ppStackItem)
end

function CameraEffectUtil:ClearPPStack()
  if self.cameraPPStackDic == nil then
    return
  end
  for camera, stack in pairs(self.cameraPPStackDic) do
    if IsNull(camera) then
      self.cameraPPStackDic[camera] = nil
    end
  end
  self.cameraPPStackDic = nil
end

function CameraEffectUtil:IsCurrentPP(ppStackItem)
  if self.cameraPPStackDic == nil then
    return false
  end
  if ppStackItem == nil then
    return false
  end
  if self.cameraPPStackDic[ppStackItem.camera] == nil then
    return false
  end
  if self.cameraPPStackDic[ppStackItem.camera]:Peek() ~= ppStackItem then
    return false
  end
  return true
end

function CameraEffectUtil:ShowCRTScreenEffect(waveScale)
  if self._CRTScreenWaveScale ~= waveScale and waveScale ~= nil and type(waveScale) == "number" then
    cs_Shader.SetGlobalFloat(CameraEffectUtil._CRTScreenWaveScaleNameHash, waveScale)
    self._CRTScreenWaveScale = cs_Shader.GetGlobalFloat(CameraEffectUtil._CRTScreenWaveScaleNameHash)
    if self:IsCurrentPP(self._crtScreenppStackItem) then
      return
    end
  end
  if self._CRTScreenEffectResLoader ~= nil then
    self._CRTScreenEffectResLoader:Put2Pool()
    self._CRTScreenEffectResLoader = nil
  end
  if self._CRTScreenEffectResLoader == nil then
    self._CRTScreenEffectResLoader = CS.ResLoader.Create()
  end
  local resloader = self._CRTScreenEffectResLoader
  local camera = UIManager:GetMainCamera()
  local ppPrefabPath = "FX/UI_effct/SteinsGate/FXP_CRTScreen_PostProfileBind.prefab"
  local bindPPName = "CRTScreenEffectPP"
  self:__LoadAndSetPP(camera, resloader, ppPrefabPath, bindPPName, function(ppStackItem)
    self._crtScreenppStackItem = ppStackItem
    local ok, CRTScreen = ppStackItem.profile:TryGetSettings(typeof(CS.XPostProcessing.CRTScreen))
    if ok then
      cs_Shader.SetGlobalFloat(CameraEffectUtil._CRTScreenWaveScaleNameHash, waveScale)
      self._CRTScreenWaveScale = cs_Shader.GetGlobalFloat(CameraEffectUtil._CRTScreenWaveScaleNameHash)
    end
  end)
end

function CameraEffectUtil:HideCRTScreenEffect()
  if self._CRTScreenEffectResLoader ~= nil then
    self._CRTScreenEffectResLoader:Put2Pool()
    self._CRTScreenEffectResLoader = nil
  end
  if self._crtScreenppStackItem == nil then
    return
  end
  self:RemovePPStack(self._crtScreenppStackItem)
  self._crtScreenppStackItem = nil
  self._CRTScreenWaveScale = nil
  if not IsNull(self._CRTScreen) then
    local temp = self._CRTScreen
    self._CRTScreen = nil
    DestroyUnityObject(temp)
  end
end

function CameraEffectUtil:ShowRedVignetteEffect(intensity)
  if self._redVignette ~= nil and intensity ~= nil then
    self._redVignette.intensity:Override(intensity)
    if self:IsCurrentPP(self._redVignetteStackItem) then
      return
    end
  end
  if self._RedVignetteEffectResLoader ~= nil then
    self._RedVignetteEffectResLoader:Put2Pool()
    self._RedVignetteEffectResLoader = nil
  end
  if self._RedVignetteEffectResLoader == nil then
    self._RedVignetteEffectResLoader = CS.ResLoader.Create()
  end
  local resloader = self._RedVignetteEffectResLoader
  local camera = UIManager:GetMainCamera()
  local ppPrefabPath = "FX/UI_effct/SteinsGate/FXP_RedVignette_PostProfileBind.prefab"
  local bindPPName = "redVignetteEffectPP"
  self:__LoadAndSetPP(camera, resloader, ppPrefabPath, bindPPName, function(ppStackItem)
    self._redVignetteStackItem = ppStackItem
    local ok, Vignette = ppStackItem.profile:TryGetSettings(typeof(CS.UnityEngine.Rendering.PostProcessing.Vignette))
    if ok then
      self._redVignette = Vignette
      self._redVignette.intensity:Override(intensity)
    end
  end)
end

function CameraEffectUtil:HideRedVignetteEffect()
  if self._RedVignetteEffectResLoader ~= nil then
    self._RedVignetteEffectResLoader:Put2Pool()
    self._RedVignetteEffectResLoader = nil
  end
  if self._redVignetteStackItem == nil then
    return
  end
  self:RemovePPStack(self._redVignetteStackItem)
  self._redVignetteStackItem = nil
  if not IsNull(self._redVignette) then
    local temp = self._redVignette
    self._redVignette = nil
    DestroyUnityObject(temp)
  end
end

function CameraEffectUtil:ShowWhiteSpaceEffect(resloader)
  local camera = UIManager:GetMainCamera()
  local ppPrefabPath = "FX/UI_effct/SteinsGate/FXP_WhiteSpace_PostProfileBind.prefab"
  local bindPPName = "whiteSpaceEffectPP"
  self:__LoadAndSetPP(camera, resloader, ppPrefabPath, bindPPName, function(ppStackItem)
    self._whiteSpaceStackItem = ppStackItem
  end)
end

function CameraEffectUtil:HideWhiteSpaceEffect()
  if self._whiteSpaceStackItem == nil then
    return
  end
  self:RemovePPStack(self._whiteSpaceStackItem)
  self._whiteSpaceStackItem = nil
end

function CameraEffectUtil:ShowPenumbraUltimateEffect()
  if self.camera == nil or IsNull(self.camera) then
    local camera = UIManager:GetMainCamera()
    if IsNull(camera) then
      return
    end
    self.camera = camera
  end
  local camera = self.camera
  local tableKey = "ShowPenumbraUltimateEffect"
  local CS_AnimationEffectController_Ins = CS.AnimationEffectController.Instance
  CS_AnimationEffectController_Ins:KillRoleEffect(camera.gameObject)
  CS_AnimationEffectController_Ins:RecycleRoleEffect(camera.gameObject)
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  local resCfg = skinCtr:GetResModel(1079, 307900)
  local origresCfg = skinCtr:GetResModel(1079)
  local CS_AnimationEffectController_Ins = CS.AnimationEffectController.Instance
  CS_AnimationEffectController_Ins:KillRoleEffect(camera.gameObject)
  CS_AnimationEffectController_Ins:RecycleRoleEffect(camera.gameObject)
  local KurisuScreenEffectId = 107918
  local effect = CS_AnimationEffectController_Ins:AddAnimationEffectByBattleEffectId(KurisuScreenEffectId, camera.gameObject, resCfg.src_id_model, origresCfg.src_id_model)
  effect.effectCfg.Layer = LayerMask.Character
  effect:Play()
  if self.__ChangeEffectScaleBySceenTable == nil then
    self.__ChangeEffectScaleBySceenTable = {}
  end
  local effectObj = effect.effectUnit.gameObject
  
  local function penumbraUltimateEffect()
    self:ChangeEffectScaleBySceen(effectObj)
  end
  
  self.__ChangeEffectScaleBySceenTable[tableKey] = penumbraUltimateEffect
  UpdateManager:AddLateUpdate(self.__ChangeEffectScaleBySceenTable[tableKey])
end

function CameraEffectUtil:HidePenumbraUltimateEffect(needDispose)
  local camera = self.camera
  if not IsNull(camera) then
    local CS_AnimationEffectController_Ins = CS.AnimationEffectController.Instance
    CS_AnimationEffectController_Ins:KillRoleEffect(camera.gameObject)
    CS_AnimationEffectController_Ins:RecycleRoleEffect(camera.gameObject)
    if needDispose then
      CS_AnimationEffectController_Ins:DisposeAllEffects()
    end
  end
  local tableKey = "ShowPenumbraUltimateEffect"
  if self.__ChangeEffectScaleBySceenTable ~= nil and self.__ChangeEffectScaleBySceenTable[tableKey] then
    UpdateManager:RemoveLateUpdate(self.__ChangeEffectScaleBySceenTable[tableKey])
    self.__ChangeEffectScaleBySceenTable[tableKey] = nil
  end
  self.camera = nil
end

function CameraEffectUtil:ShowBelladonnaUltimateEffect()
  local camera = UIManager:GetMainCamera()
  if IsNull(camera) then
    return
  end
  self.camera = camera
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  local resCfg = skinCtr:GetResModel(1085, 308500)
  local origresCfg = skinCtr:GetResModel(1085)
  local CS_AnimationEffectController_Ins = CS.AnimationEffectController.Instance
  CS_AnimationEffectController_Ins:KillRoleEffect(camera.gameObject)
  CS_AnimationEffectController_Ins:RecycleRoleEffect(camera.gameObject)
  local BelladonnaScreenEffectId = 108512
  local effect = CS_AnimationEffectController_Ins:AddAnimationEffectByBattleEffectId(BelladonnaScreenEffectId, camera.gameObject, resCfg.src_id_model, origresCfg.src_id_model)
  effect.effectCfg.Layer = LayerMask.Character
  effect:Play()
  self.orginFov = nil
  if self.__ChangeEffectScaleBySceenTable == nil then
    self.__ChangeEffectScaleBySceenTable = {}
  end
  local tableKey = "ShowBelladonnaUltimateEffect"
  local gameObject = effect.effectUnit.gameObject
  
  local function BelladonnaUltimateEffect()
    self:ChangeEffectScaleBySceen(gameObject)
  end
  
  self.__ChangeEffectScaleBySceenTable[tableKey] = BelladonnaUltimateEffect
  UpdateManager:AddLateUpdate(self.__ChangeEffectScaleBySceenTable[tableKey])
end

function CameraEffectUtil:HideBelladonnaUltimateEffect(needDispose)
  local camera = self.camera
  if not IsNull(camera) then
    local CS_AnimationEffectController_Ins = CS.AnimationEffectController.Instance
    CS_AnimationEffectController_Ins:KillRoleEffect(camera.gameObject)
    CS_AnimationEffectController_Ins:RecycleRoleEffect(camera.gameObject)
    if needDispose then
      CS_AnimationEffectController_Ins:DisposeAllEffects()
    end
  end
  local tableKey = "ShowBelladonnaUltimateEffect"
  if self.__ChangeEffectScaleBySceenTable ~= nil and self.__ChangeEffectScaleBySceenTable[tableKey] then
    UpdateManager:RemoveLateUpdate(self.__ChangeEffectScaleBySceenTable[tableKey])
    self.__ChangeEffectScaleBySceenTable[tableKey] = nil
  end
  self.orginFov = nil
end

function CameraEffectUtil:ShowDodge_deviceUltimateEffect()
  local camera = UIManager:GetMainCamera()
  if IsNull(camera) then
    return
  end
  self.camera = camera
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  local CS_AnimationEffectController_Ins = CS.AnimationEffectController.Instance
  CS_AnimationEffectController_Ins:KillRoleEffect(camera.gameObject)
  CS_AnimationEffectController_Ins:RecycleRoleEffect(camera.gameObject)
  local Dodge_deviceScreenEffectId = 214901
  local effect = CS_AnimationEffectController_Ins:AddAnimationEffectByBattleEffectId(Dodge_deviceScreenEffectId, camera.gameObject, nil, nil)
  effect.effectCfg.Layer = LayerMask.Character
  effect:Play()
  self.orginFov = nil
  if self.__ChangeEffectScaleBySceenTable == nil then
    self.__ChangeEffectScaleBySceenTable = {}
  end
  local tableKey = "ShowDodge_deviceUltimateEffect"
  local gameObject = effect.effectUnit.gameObject
  
  local function Dodge_deviceEffect()
    self:ChangeEffectScaleBySceen(gameObject)
  end
  
  self.__ChangeEffectScaleBySceenTable[tableKey] = Dodge_deviceEffect
  UpdateManager:AddLateUpdate(self.__ChangeEffectScaleBySceenTable[tableKey])
end

function CameraEffectUtil:HideDodge_deviceUltimateEffect(needDispose)
  local camera = self.camera
  if not IsNull(camera) then
    local CS_AnimationEffectController_Ins = CS.AnimationEffectController.Instance
    CS_AnimationEffectController_Ins:KillRoleEffect(camera.gameObject)
    CS_AnimationEffectController_Ins:RecycleRoleEffect(camera.gameObject)
    if needDispose then
      CS_AnimationEffectController_Ins:DisposeAllEffects()
    end
  end
  local tableKey = "ShowDodge_deviceUltimateEffect"
  if self.__ChangeEffectScaleBySceenTable ~= nil and self.__ChangeEffectScaleBySceenTable[tableKey] then
    UpdateManager:RemoveLateUpdate(self.__ChangeEffectScaleBySceenTable[tableKey])
    self.__ChangeEffectScaleBySceenTable[tableKey] = nil
  end
  self.orginFov = nil
end

function CameraEffectUtil:ShowSolUltimateEffect()
  if self.camera == nil or IsNull(self.camera) then
    local camera = UIManager:GetMainCamera()
    if IsNull(camera) then
      return
    end
    self.camera = camera
  end
  local camera = self.camera
  local tableKey = "ShowSolUltimateEffect"
  local CS_AnimationEffectController_Ins = CS.AnimationEffectController.Instance
  CS_AnimationEffectController_Ins:KillRoleEffect(camera.gameObject)
  CS_AnimationEffectController_Ins:RecycleRoleEffect(camera.gameObject)
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  local resCfg = skinCtr:GetResModel(1090, 309000)
  local origresCfg = skinCtr:GetResModel(1090)
  local CS_AnimationEffectController_Ins = CS.AnimationEffectController.Instance
  CS_AnimationEffectController_Ins:KillRoleEffect(camera.gameObject)
  CS_AnimationEffectController_Ins:RecycleRoleEffect(camera.gameObject)
  local SolScreenEffectId = 109010
  local effect = CS_AnimationEffectController_Ins:AddAnimationEffectByBattleEffectId(SolScreenEffectId, camera.gameObject, resCfg.src_id_model, origresCfg.src_id_model)
  effect.effectCfg.Layer = LayerMask.Character
  effect:Play()
  if self.__ChangeEffectScaleBySceenTable == nil then
    self.__ChangeEffectScaleBySceenTable = {}
  end
  local effectObj = effect.effectUnit.gameObject
  
  local function SolUltimateEffect()
    self:ChangeEffectScaleBySceen(effectObj)
  end
  
  self.__ChangeEffectScaleBySceenTable[tableKey] = SolUltimateEffect
  UpdateManager:AddLateUpdate(self.__ChangeEffectScaleBySceenTable[tableKey])
end

function CameraEffectUtil:HideSolUltimateEffect(needDispose)
  local camera = self.camera
  if not IsNull(camera) then
    local CS_AnimationEffectController_Ins = CS.AnimationEffectController.Instance
    CS_AnimationEffectController_Ins:KillRoleEffect(camera.gameObject)
    CS_AnimationEffectController_Ins:RecycleRoleEffect(camera.gameObject)
    if needDispose then
      CS_AnimationEffectController_Ins:DisposeAllEffects()
    end
  end
  local tableKey = "ShowSolUltimateEffect"
  if self.__ChangeEffectScaleBySceenTable ~= nil and self.__ChangeEffectScaleBySceenTable[tableKey] then
    UpdateManager:RemoveLateUpdate(self.__ChangeEffectScaleBySceenTable[tableKey])
    self.__ChangeEffectScaleBySceenTable[tableKey] = nil
  end
  self.camera = nil
end

function CameraEffectUtil:ShowAnniversary24StoryLevelEffect(speed)
  if self._glitchImageBlockV3 ~= nil and speed ~= nil then
    self._glitchImageBlockV3.Speed:Override(speed)
    if self:IsCurrentPP(self._glitchImageBlockV3Item) then
      return
    end
  end
  if self._GlitchImageBlockV3ResLoader ~= nil then
    self._GlitchImageBlockV3ResLoader:Put2Pool()
    self._GlitchImageBlockV3ResLoader = nil
  end
  if self._GlitchImageBlockV3ResLoader == nil then
    self._GlitchImageBlockV3ResLoader = CS.ResLoader.Create()
  end
  local uiCamera = UIManager.UICamera
  if self._glitchImageBlockV3Item ~= nil then
    self:RemovePPStack(self._glitchImageBlockV3Item)
    DestroyUnityObject(self.steineffectProfile)
    self._glitchImageBlockV3Item = nil
    self._glitchImageBlockProfile = nil
  end
  local ppPrefabPath = "FX/UI_effct/SteinsGate/FXP_GlitchImageBlockV3_PostProfileBind.prefab"
  local bindPPName = "glitchImageBlockV3EffectPP"
  self:__LoadAndSetPP(uiCamera, self._GlitchImageBlockV3ResLoader, ppPrefabPath, bindPPName, function(ppStackItem)
    if not IsNull(UIManager.csUIManager.UICamPPLayer) then
      UIManager.csUIManager.UICamPPLayer.enabled = true
    end
    self._glitchImageBlockV3Item = ppStackItem
    self._glitchImageBlockProfile = ppStackItem.profile
    local ok, GlitchImageBlockV3 = ppStackItem.profile:TryGetSettings(typeof(CS.XPostProcessing.GlitchImageBlockV3))
    if ok then
      self._glitchImageBlockV3 = GlitchImageBlockV3
      GlitchImageBlockV3.Speed:Override(speed)
    end
  end)
  local epMapCamera = UIManager:GetMainCamera()
  self.camera = epMapCamera
  local CS_AnimationEffectController_Ins = CS.AnimationEffectController.Instance
  local animationEffectConfig = CS.AnimationEffectConfig()
  animationEffectConfig.EffectPath = "FX/Common/FX_Common_Zn24/FX_zn24_SkillScreen01.prefab"
  animationEffectConfig.ResName = "FX_zn24_SkillScreen01"
  animationEffectConfig.OriginResName = "FX_zn24_SkillScreen01"
  animationEffectConfig.BirthType = 1
  animationEffectConfig.BirthPoint = 3
  animationEffectConfig.BindPoint = 0
  animationEffectConfig.BindType = 3
  animationEffectConfig.Duration = 99999999
  animationEffectConfig.Layer = LayerMask.EpMap
  local effect = CS_AnimationEffectController_Ins:AddAnimationEffect(animationEffectConfig, epMapCamera.gameObject)
  effect:Play()
  local tableKey = "ShowAnniversary24StoryLevelEffect"
  if self.__ChangeEffectScaleBySceenTable == nil then
    self.__ChangeEffectScaleBySceenTable = {}
  end
  local effectObj = effect.effectUnit.gameObject
  
  local function __ShowAnniversary24StoryLevelEffect()
    self:ChangeEffectScaleBySceen(effectObj)
  end
  
  self.__ChangeEffectScaleBySceenTable[tableKey] = __ShowAnniversary24StoryLevelEffect
  UpdateManager:AddLateUpdate(self.__ChangeEffectScaleBySceenTable[tableKey])
  UIManager:ShowWindowAsync(UIWindowTypeID.EffectMask, function(window)
    window:ShowWhiteSpaceV2Mask()
  end)
end

function CameraEffectUtil:HideAnniversary24StoryLevelEffect()
  if self._GlitchImageBlockV3ResLoader ~= nil then
    self._GlitchImageBlockV3ResLoader:Put2Pool()
    self._GlitchImageBlockV3ResLoader = nil
  end
  if self._glitchImageBlockV3Item == nil then
    return
  end
  self:RemovePPStack(self._glitchImageBlockV3Item)
  self._glitchImageBlockV3Item = nil
  if not IsNull(self._glitchImageBlockV3) then
    local temp = self._glitchImageBlockV3
    self._glitchImageBlockV3 = nil
    DestroyUnityObject(temp)
  end
  local epMapCamera = UIManager:GetMainCamera()
  local CS_AnimationEffectController_Ins = CS.AnimationEffectController.Instance
  CS_AnimationEffectController_Ins:KillRoleEffect(epMapCamera.gameObject)
  CS_AnimationEffectController_Ins:RecycleRoleEffect(epMapCamera.gameObject)
  CS_AnimationEffectController_Ins:DisposeAllEffects()
  local tableKey = "ShowAnniversary24StoryLevelEffect"
  if self.__ChangeEffectScaleBySceenTable ~= nil and self.__ChangeEffectScaleBySceenTable[tableKey] then
    UpdateManager:RemoveLateUpdate(self.__ChangeEffectScaleBySceenTable[tableKey])
    self.__ChangeEffectScaleBySceenTable[tableKey] = nil
  end
  local window = UIManager:GetWindow(UIWindowTypeID.EffectMask)
  if window ~= nil then
    window:HideWhiteSpaceV2Mask()
    window:Delete()
  end
end

local CameraEffectEnum = {
  OldMovie = 1,
  EosSkill = 2,
  HubbleEntropy = 3,
  SteinLineChange = 4,
  WhiteSpace = 5,
  CRTScreen = 6,
  RedVignette = 7,
  KurisuSkill = 8,
  PenumbraUltimateSkill = 9,
  BelladonnaUltimateSkill = 10,
  Dodge_deviceUltimateEffect = 11,
  SolUltimateSkill = 12,
  WhiteRadiate = 13,
  WhiteRadiateAndIntermittentGlitchImageBlockV3 = 14,
  WhiteRadiateAndSustainabilityGlitchImageBlockV3 = 15
}
CameraEffectUtil.CameraEffectEnum = CameraEffectEnum
CameraEffectUtil.CameraEffectFunction = {}
CameraEffectUtil.CloseCameraEffectFunction = {}
CameraEffectUtil.CameraEffectFunction[CameraEffectEnum.OldMovie] = ShowOldMovieUIEffect
CameraEffectUtil.CloseCameraEffectFunction[CameraEffectEnum.OldMovie] = HideOldMovieUIEffect
CameraEffectUtil.CameraEffectFunction[CameraEffectEnum.EosSkill] = function()
  CameraEffectUtil:ShowEosSkillEffect()
end
CameraEffectUtil.CloseCameraEffectFunction[CameraEffectEnum.EosSkill] = function()
  CameraEffectUtil:HideEosSkillEffect()
end
CameraEffectUtil.CameraEffectFunction[CameraEffectEnum.HubbleEntropy] = function(strength)
  CameraEffectUtil:ShowHubbleEntropyEffect(strength)
end
CameraEffectUtil.CloseCameraEffectFunction[CameraEffectEnum.HubbleEntropy] = function()
  CameraEffectUtil:HideHubbleEntropyEffect(true)
end
CameraEffectUtil.CameraEffectFunction[CameraEffectEnum.SteinLineChange] = function(worldChangeId, resLoader, closeCallback)
  CameraEffectUtil:ShowSteinLineChangeEffect(worldChangeId, closeCallback)
  CameraEffectUtil:ShowSteinLineChangePostEffect(resLoader)
end
CameraEffectUtil.CloseCameraEffectFunction[CameraEffectEnum.SteinLineChange] = function()
  CameraEffectUtil:HideSteinLineChangeEffect()
end
CameraEffectUtil.CameraEffectFunction[CameraEffectEnum.WhiteSpace] = function()
  UIManager:ShowWindowAsync(UIWindowTypeID.EffectMask, function(window)
    window:ShowWhiteSpaceMask()
  end)
end
CameraEffectUtil.CloseCameraEffectFunction[CameraEffectEnum.WhiteSpace] = function()
  local window = UIManager:GetWindow(UIWindowTypeID.EffectMask)
  if window ~= nil then
    window:HideWhiteSpaceMask()
    window:Delete()
  end
end
CameraEffectUtil.CameraEffectFunction[CameraEffectEnum.CRTScreen] = function(waveScale)
  CameraEffectUtil:ShowCRTScreenEffect(waveScale)
end
CameraEffectUtil.CloseCameraEffectFunction[CameraEffectEnum.CRTScreen] = function()
  CameraEffectUtil:HideCRTScreenEffect()
end
CameraEffectUtil.CameraEffectFunction[CameraEffectEnum.RedVignette] = function(intensity)
  CameraEffectUtil:ShowRedVignetteEffect(intensity)
end
CameraEffectUtil.CloseCameraEffectFunction[CameraEffectEnum.RedVignette] = function()
  CameraEffectUtil:HideRedVignetteEffect()
end
CameraEffectUtil.CameraEffectFunction[CameraEffectEnum.KurisuSkill] = function()
  CameraEffectUtil:ShowKurisuSkillEffect()
end
CameraEffectUtil.CloseCameraEffectFunction[CameraEffectEnum.KurisuSkill] = function()
  CameraEffectUtil:HideKurisuSkillEffect()
end
CameraEffectUtil.CameraEffectFunction[CameraEffectEnum.PenumbraUltimateSkill] = function()
  CameraEffectUtil:ShowPenumbraUltimateEffect()
end
CameraEffectUtil.CloseCameraEffectFunction[CameraEffectEnum.PenumbraUltimateSkill] = function()
  CameraEffectUtil:HidePenumbraUltimateEffect(true)
end
CameraEffectUtil.CameraEffectFunction[CameraEffectEnum.BelladonnaUltimateSkill] = function()
  CameraEffectUtil:ShowBelladonnaUltimateEffect()
end
CameraEffectUtil.CloseCameraEffectFunction[CameraEffectEnum.BelladonnaUltimateSkill] = function()
  CameraEffectUtil:HideBelladonnaUltimateEffect(true)
end
CameraEffectUtil.CameraEffectFunction[CameraEffectEnum.Dodge_deviceUltimateEffect] = function()
  CameraEffectUtil:ShowDodge_deviceUltimateEffect()
end
CameraEffectUtil.CloseCameraEffectFunction[CameraEffectEnum.Dodge_deviceUltimateEffect] = function()
  CameraEffectUtil:HideDodge_deviceUltimateEffect(true)
end
CameraEffectUtil.CameraEffectFunction[CameraEffectEnum.SolUltimateSkill] = function()
  CameraEffectUtil:ShowSolUltimateEffect()
end
CameraEffectUtil.CloseCameraEffectFunction[CameraEffectEnum.SolUltimateSkill] = function()
  CameraEffectUtil:HideSolUltimateEffect(true)
end
CameraEffectUtil.CameraEffectFunction[CameraEffectEnum.WhiteRadiate] = function()
  CameraEffectUtil:ShowAnniversary24StoryLevelEffect(0)
end
CameraEffectUtil.CloseCameraEffectFunction[CameraEffectEnum.WhiteRadiate] = function()
  CameraEffectUtil:HideAnniversary24StoryLevelEffect()
end
CameraEffectUtil.CameraEffectFunction[CameraEffectEnum.WhiteRadiateAndIntermittentGlitchImageBlockV3] = function()
  CameraEffectUtil:ShowAnniversary24StoryLevelEffect(20)
end
CameraEffectUtil.CloseCameraEffectFunction[CameraEffectEnum.WhiteRadiateAndIntermittentGlitchImageBlockV3] = function()
  CameraEffectUtil:HideAnniversary24StoryLevelEffect()
end
CameraEffectUtil.CameraEffectFunction[CameraEffectEnum.WhiteRadiateAndSustainabilityGlitchImageBlockV3] = function()
  CameraEffectUtil:ShowAnniversary24StoryLevelEffect(25)
end
CameraEffectUtil.CloseCameraEffectFunction[CameraEffectEnum.WhiteRadiateAndSustainabilityGlitchImageBlockV3] = function()
  CameraEffectUtil:HideAnniversary24StoryLevelEffect()
end
return CameraEffectUtil
