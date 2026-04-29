local PetSkinModelAnimType = {
  BattleIdle = 1,
  AirStand = 2,
  AirClick = 3,
  AirWalk = 4,
  AirSit = 5
}
_enum("PetSkinModelAnimType", PetSkinModelAnimType)
_class("PetSkinShowModelManager", Object)
PetSkinShowModelManager = PetSkinShowModelManager

function PetSkinShowModelManager:Constructor()
  self._petSkin3dRoot = nil
  self._moduleGo = nil
  self._modelParentTrans = nil
  self._model = nil
  self._dragUi = nil
  self.ani_request = nil
  self._aniReqs = {}
  self._dragRotateSpeed = 0.7
  self._curSkinId = 0
  self._debugActionType = PetSkinModelAnimType.BattleIdle
end

function PetSkinShowModelManager:SetRenderTexture(renderTexture)
  self._renderTexture = renderTexture
end

function PetSkinShowModelManager:Reset()
  self:_ReleaseCurModule()
  self._curSkinId = 0
end

function PetSkinShowModelManager:_ReleaseCurModule()
  if self._timeEvent then
    GameGlobal.RealTimer():CancelEvent(self._timeEvent)
    self._timeEvent = nil
  end
  if self._model then
    UIHelper.DestroyGameObject(self._model)
    self._model = nil
  end
  if self._moduleGo then
    UIHelper.DestroyGameObject(self._moduleGo)
    self._moduleGo = nil
  end
  if self._petSkin3dRoot then
    UIHelper.DestroyGameObject(self._petSkin3dRoot)
    self._petSkin3dRoot = nil
  end
  for index, value in ipairs(self._aniReqs) do
    if value then
      value:Dispose()
    end
  end
  self._aniReqs = {}
end

function PetSkinShowModelManager:Dispose()
  self:Reset()
end

function PetSkinShowModelManager:ShowPetSkinModel(skinId)
  if self._curSkinId == skinId then
    return
  else
    self._curSkinId = skinId
  end
  if not self._renderTexture then
    return
  end
  self:_ReleaseCurModule()
  self:_InitRoot()
  if not self._petSkin3dRoot then
    return
  end
  local modelName = self:_GetModelName(skinId)
  if not modelName or modelName == "" then
    return
  end
  self:_SetModel(modelName)
  self:_ShowModel(false)
  if self._timeEvent then
    GameGlobal.RealTimer():CancelEvent(self._timeEvent)
    self._timeEvent = nil
  end
  self:_SetDefaultAction(modelName)
end

local function _createV4FromV3(v3)
  local v4 = Vector4.zero
  v4.x = v3.x
  v4.y = v3.y
  v4.z = v3.z
  v4.w = 1
  return v4
end

function PetSkinShowModelManager:_InitRoot()
  if self._petSkin3dRoot then
    return
  end
  local uiRoot = UnityEngine.GameObject.Find("UIRoot")
  self._petSkin3dRoot = GameObjectHelper.CreateEmpty("UIPetSkin3dModules", uiRoot.transform)
  if not self._petSkin3dRoot then
    return
  end
  self._petSkin3dRoot.transform.localPosition = Vector3.zero
  self._petSkin3dRoot.transform.localEulerAngles = Vector3.zero
  self._petSkin3dRoot.transform.localScale = Vector3.one
  self._moduleGo = UIHelper.GetGameObject("UIPetSkin3DModule.prefab")
  if not self._moduleGo then
    return
  end
  self._modelParentTrans = self._moduleGo.transform:Find("ModelShow/ShowPlayer/Model")
  local moduleTrans = self._moduleGo.transform
  moduleTrans.parent = self._petSkin3dRoot.transform
  moduleTrans.localPosition = Vector3.zero
  moduleTrans.localEulerAngles = Vector3.zero
  moduleTrans.localScale = Vector3.one
  local trans = self._moduleGo.transform
  if trans then
    local camGoTrans = trans:Find("ModelShow/ShowPlayer/UIModelCam/ModelCam")
    local cam = camGoTrans:Find("UIModelCamera"):GetComponent("Camera")
    if cam then
      cam.targetTexture = self._renderTexture
    end
  end
  self:_SetRenderParam()
end

function PetSkinShowModelManager:_SetRenderParam()
  UnityEngine.Shader.SetGlobalVector("_H3D_CustomLightDir", Vector4(0.33, 0.18, 0.93, 1))
  UnityEngine.Shader.SetGlobalVector("_H3D_CustomShadowDir", Vector4(0.14, 0.55, 0.83, 1))
  UnityEngine.Shader.SetGlobalVector("_H3D_ShowdowColor", Vector4(0.092, 0.058, 0.11, 0.3))
end

function PetSkinShowModelManager:_GetModelName(skinId)
  local modelName = "1500921.prefab"
  local curSkinCfg = Cfg.cfg_pet_skin[skinId]
  if curSkinCfg then
    modelName = curSkinCfg.Prefab
    if not modelName then
      return
    end
  end
  return modelName
end

function PetSkinShowModelManager:_SetModel(modelName)
  if self._model then
    UIHelper.DestroyGameObject(self._model)
    self._model = nil
  end
  self._model = UIHelper.GetGameObject(modelName)
  if not self._model then
    return
  end
  self._model.transform.parent = self._modelParentTrans
  self._model.transform.localPosition = Vector3.zero
  self._model.transform.localEulerAngles = Vector3.zero
  local scaleParam = 1
  local cfgSkin = Cfg.cfg_pet_skin[self._curSelSkinId]
  if cfgSkin and cfgSkin.UiModelScale then
    scaleParam = cfgSkin.UiModelScale
  end
  self._model.transform.localScale = Vector3(scaleParam, scaleParam, scaleParam)
end

function PetSkinShowModelManager:_ShowModel(bShow)
  if bShow then
    self._model.transform.localPosition = Vector3.zero
  else
    self._model.transform.localPosition = Vector3(0, -100, 0)
  end
end

function PetSkinShowModelManager:_SetDefaultAction(modelName)
  if not self._model then
    return
  end
  local animator = self._moduleGo:GetComponentInChildren(typeof(UnityEngine.Animator))
  if not animator then
    return
  end
  local controllerType = PetAnimatorControllerType.Aircraft
  if self._debugActionType == PetSkinModelAnimType.BattleIdle then
    controllerType = PetAnimatorControllerType.Battle
  end
  local ancName = HelperProxy:GetInstance():GetPetAnimatorControllerName(modelName, controllerType)
  self.ani_request = ResourceManager:GetInstance():SyncLoadAsset(ancName, LoadType.GameObject)
  table.insert(self._aniReqs, self.ani_request)
  if self.ani_request == nil then
    Log.fatal("LoadGameObject failed", "[" .. ancName .. "]")
    return
  end
  if isBattleAct then
    local animatorController = self.ani_request.Obj:GetComponent(typeof(UnityEngine.Animator)).runtimeAnimatorController
    if animatorController == nil then
      Log.fatal("[ani] getAnimatorController Error", self.ani_request.m_Name)
      return
    end
    animator.runtimeAnimatorController = animatorController
    animator:Play("idle")
    self.ani_request.Obj:SetActive(false)
    self:_ShowModel(true)
  else
    local anim = self.ani_request.Obj:GetComponent("Animation")
    self:_SetAirAction(anim)
  end
end

function PetSkinShowModelManager:_SetAirAction(anim)
  local root = self._model.transform:Find("Root").gameObject
  if anim == nil then
    Log.fatal("找不到Animation组件，加载pet模型失败：", self._petID)
    return
  end
  if anim.clip == nil then
    Log.exception("星灵没有默认的Stand动作：", self._petID)
    return
  end
  local animator = root:GetComponent(typeof(UnityEngine.Animator))
  if animator then
    UnityEngine.Object.Destroy(animator)
  end
  local petAnim = root:AddComponent(typeof(UnityEngine.Animation))
  local clips = HelperProxy:GetInstance():GetAllAnimationClip(anim)
  for i = 0, clips.Length - 1 do
    local clip = clips[i]
    if clip == nil then
      Log.exception("星灵动作为空:", self._petID, "，索引：", i)
    else
      petAnim:AddClip(clip, clip.name)
    end
  end
  petAnim.clip = anim.clip
  local AirPetAnimName = {
    Stand = "stand",
    Walk = "walk",
    Click = "click01",
    Sit = "sit"
  }
  local act = ""
  if self._debugActionType == PetSkinModelAnimType.AirStand then
    act = AirPetAnimName.Stand
  elseif self._debugActionType == PetSkinModelAnimType.AirClick then
    act = AirPetAnimName.Click
  elseif self._debugActionType == PetSkinModelAnimType.AirWalk then
    act = AirPetAnimName.Walk
  elseif self._debugActionType == PetSkinModelAnimType.AirSit then
    act = AirPetAnimName.Sit
  end
  petAnim:Play(AirPetAnimName.Stand)
  GameGlobal.Timer():AddEvent(1, function()
    petAnim:Play(act)
    GameGlobal.Timer():AddEvent(1, function()
      self:_ShowModel(true)
    end)
  end)
end

function PetSkinShowModelManager:OnDrag(eventData)
  if not self._model then
    return
  end
  local Abs = math.abs
  local delta = eventData.delta
  if delta and Abs(delta.x) >= 1 then
    local rot = -1 * self._dragRotateSpeed * delta.x
    self._model.transform.localEulerAngles = Vector3(0, self._model.transform.localEulerAngles.y + rot, 0)
  end
end
