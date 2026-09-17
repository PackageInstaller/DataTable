local this = {}
local sConcat = string.concat
local _petTpl = L_GameTpl:getPetTpl()
local elementTypeTpl = L_GameTpl:getElementTypeTpl()
local _unitTpl = L_GameTpl:getUnitTpl()
local PETGETSCENEPATH = "Program/UIScene/pre_petget_ui.prefab"
local PETGETBLACKPATH = "Program/UIScene/pre_KiboAddBlack.prefab"
local StateNotifyType = CS.Lens.Gameplay.Modules.BigWorld.PlayableAnimator.StateNotifyType
local PATH_EFFECT_ELEMNT = "effect/pre_petget_loop/ElementFXRoot/"
local LIST_EFFECT_ELEMNT = {
  [1] = "pre_petget_fire",
  [2] = "pre_petget_wind",
  [3] = "pre_petget_earth",
  [4] = "pre_petget_wood",
  [5] = "pre_petget_ice",
  [6] = "pre_petget_water",
  [7] = "pre_petget_thunder",
  [8] = "pre_petget_light",
  [9] = "pre_petget_dark"
}
local petGetParam = L_GameConstTpl:getData("KIBO_GET_PETROOT_SCALE_PARAM", L_Const.GameTplType.list_int)

function this:loadPetGetScene()
  if self.runtimePetGetData and self.runtimePetGetData.petScene then
    C_UISceneManager.SetSceneVisible()
    self.runtimePetGetData.petScene:ActiveTrans(true)
    return
  end
  C_UISceneManager.SetSceneVisible()
  self.runtimePetGetData = require("ui.manager.pet.petGetSceneRuntimeData").new(L_ResPool:syncGameObject(PETGETSCENEPATH))
  local sceneTrans = self.runtimePetGetData.petScene.transform
  sceneTrans:SetParent(C_LuaUtility.GetRootNode())
  self.tempTexture = nil
  local bgBlurTrans = sceneTrans:Find("bg_blur")
  if L_CommonUtil.isValid(bgBlurTrans) then
    self.runtimePetGetData.bgBlur = bgBlurTrans:GetComponent(typeof(C_MeshRenderer))
  end
  local bgElementTrans = sceneTrans:Find("bg_element")
  if L_CommonUtil.isValid(bgElementTrans) then
    self.runtimePetGetData.bgElement = bgElementTrans:GetComponent(typeof(C_MeshRenderer))
  end
  self.runtimePetGetData.playableDirector = sceneTrans:GetComponent(typeof(CS.UnityEngine.Playables.PlayableDirector))
  L_Vector3.setPos(sceneTrans, C_UIMgr.SceneLoadDefaultPosition)
  L_Vector3.setRot(sceneTrans, L_Vector3.zero)
end

function this:getTimelineDynamicBinds()
  if table.isEmpty(self.runtimePetGetData) or table.isEmpty(self.runtimePetGetData.placePets) then
    return
  end
  local dynamicBindsData = {}
  local petAnimator = self.runtimePetGetData.placePets.obj:GetComponentInChildren(typeof(C_CsAnimator))
  dynamicBindsData.petAnimator = petAnimator
  local sceneAnimator = self.runtimePetGetData.petScene:GetComponent(typeof(C_CsAnimator))
  dynamicBindsData.sceneAnimator = sceneAnimator
  dynamicBindsData.cameraRoot = self.runtimePetGetData.cameraNode.gameObject
  dynamicBindsData.petRoot = self.runtimePetGetData.petPoints.gameObject
  return dynamicBindsData
end

function this:removePetGetScene()
  L_TimerManager:clearTimer(self)
  self:releaseBlurTexture()
  self:removePetGetModel()
  if self.controllerAssetHandle then
    C_LuaUtility.ReleasePlayableController(self.controllerAssetHandle)
    self.controllerAssetHandle = nil
  end
  if self.runtimePetGetData then
    self.runtimePetGetData:destroy()
    self.runtimePetGetData = nil
  end
  if self._petFlashActiveJob then
    co.stop(self._petFlashActiveJob)
    self._petFlashActiveJob = nil
  end
  C_UISceneManager.SetSceneVisible()
  if self.timer then
    self.timer:destroy()
    Timer.remove(self.timer)
    self.timer = nil
  end
  self:stopFlashSound()
end

function this:loadPetGetModel(petConfigId, isSpecial, isFlash, starColorId)
  if math.isEmpty(petConfigId) then
    self:removePetGetModel()
    return
  else
    local curPlacePet = self:_getInPlacePetGet()
    if not table.isEmpty(curPlacePet) and curPlacePet.configId == petConfigId then
      self:_setPetGetFlashEft(isFlash, curPlacePet.obj)
      self:_setPetStarColor(starColorId, curPlacePet.obj)
      return
    end
  end
  self:removePetGetModel()
  local pointTrans = self.runtimePetGetData.petPoints
  local petObj, entity
  if not table.isEmpty(self.runtimePetGetData.placePets) then
    petObj = self.runtimePetGetData.placePets.obj
    entity = self.runtimePetGetData.placePets.entity
  else
    petObj, entity = self:_fetchPetGetModel(petConfigId, isSpecial)
  end
  petObj.transform:SetParent(pointTrans)
  local unitId = L_GameUtil.getUnitIdByRole(petConfigId, L_Const.roleType.pet)
  local tpl = _petTpl:getTplById(petConfigId)
  local all_stage_scale = _petTpl:getUnitScale(tpl) or 10000
  local unitTpl = _unitTpl:getTplById(unitId)
  local worldScale = 1
  local bodyType = _petTpl:getBodyType(tpl)
  local pageScale = petGetParam[bodyType] / 10000
  local scale = all_stage_scale / 10000
  L_Vector3.setSize(petObj.transform, scale * worldScale * pageScale)
  local position = _petTpl:getUnitPositionGet(tpl)
  if table.isEmpty(position) then
    L_Vector3.setLocalPos(petObj.transform, L_Vector3.zero)
  else
    L_Vector3.setLocalPos(petObj.transform, L_Vector3.new(position[1], position[2], position[3]))
  end
  local rotation = _petTpl:getUnitRotationGet(tpl)
  local rot = L_Vector3.zero
  if not table.isEmpty(rotation) then
    rot = L_Vector3.new(rotation[1], rotation[2], rotation[3])
  end
  L_Vector3.setLocalRot(petObj.transform, rot)
  petObj:ActiveTrans(true)
  self.runtimePetGetData.placePets = {
    obj = petObj,
    configId = petConfigId,
    entity = entity,
    unitId = unitId
  }
  local elementTypeId = _petTpl:getFirstElement(tpl)
  local elementTpl = elementTypeTpl:getTplById(elementTypeId)
  if elementTpl then
    local C_TextureManager = CS.Lens.Framework.Manager.TextureManager
    local readType = CS.Lens.Framework.Manager.ETextureReadType.DefaultSprite
    local PATH_BG_ELEMENT = string.format("UI/Texture/PetGet/tex_petduel_bg_element_%s__tss1.png", elementTypeId)
    local texture = C_TextureManager.Load(PATH_BG_ELEMENT, readType)
    if texture then
      self.textureElementWrapper = texture
      self:setElementTexture(texture.sprite.texture)
    else
      print("没有获取到")
    end
  end
  local sceneTrans = self.runtimePetGetData.petScene.transform
  if elementTypeId ~= 0 then
    local targetEffectTrans = sceneTrans:Find(PATH_EFFECT_ELEMNT .. LIST_EFFECT_ELEMNT[elementTypeId])
    if L_CommonUtil.isValid(targetEffectTrans) then
      targetEffectTrans.gameObject:SetActive(true)
    else
      warn(string.format("未找到名字为%s的预制体", PATH_EFFECT_ELEMNT .. LIST_EFFECT_ELEMNT[elementTypeId]))
    end
  end
  self:_setPetGetFlashEft(isFlash, petObj)
  self:_setPetStarColor(starColorId, petObj)
end

function this:removePetGetModel()
  if table.isEmpty(self.runtimePetGetData.placePets) then
    return
  end
  self:_recyclePetGetModel(self.runtimePetGetData.placePets.configId, self.runtimePetGetData.placePets.obj)
  self.runtimePetGetData.placePets = nil
  self:_setPetGetFlashEft(false)
end

function this:_getInPlacePetGet()
  return self.runtimePetGetData.placePets
end

function this:_fetchPetGetModel(petConfigId, isSpecial)
  local unitTpl = L_GameTpl:getUnitTpl()
  local tpl = _petTpl:getTplById(petConfigId)
  local unitId = _petTpl:getUnitID(tpl)
  local unit = unitTpl:getTplById(unitId)
  local obj
  if self.runtimePetGetData.petCache[petConfigId] then
    obj = self.runtimePetGetData.petCache[petConfigId]
  else
    local path = L_GameUtil.getAvatarModelPathByUnitId(unitId, L_Const.avatarModelIndex.UnitModel)
    if isSpecial and isSpecial ~= 0 then
      local specialParm = unitTpl:getSpecialParm(unit)
      local replaceStr = specialParm[isSpecial]
      path = string.gsub(path, ".prefab", "_" .. replaceStr .. ".prefab")
    end
    obj = L_ResPool:syncGameObject(path)
    local blackObj = L_ResPool:syncGameObject(PETGETBLACKPATH)
    blackObj.transform:Reset(obj.transform)
    blackObj.transform.localScale = L_Vector3.one
    blackObj.transform.localPosition = L_Vector3.zero
    blackObj.name = "blackRoot"
    local EffectMaterialHelperCom = blackObj.transform:GetComponent(typeof(CS.EffectMaterialHelper))
    if EffectMaterialHelperCom then
      EffectMaterialHelperCom.characterRoot = obj
    end
    local EffectAutoMultiColCom = blackObj.transform:GetComponent(typeof(CS.EffectAutoMultiCol))
    if EffectAutoMultiColCom then
      EffectAutoMultiColCom.characterRoot = obj
    end
    self.runtimePetGetData.blackObj = blackObj
  end
  self.animator = L_CommonUtil.getModComponent(typeof(C_PlayableAnimator), obj)
  self.animator.cullingMode = C_AnimatorCullingMode.AlwaysAnimate
  self.animator.updateMode = C_PlayableAnimator.UpdateMode.LateUpdate
  self.animator.rootMotionController.selfApplyRootMotion = true
  obj.name = sConcat("pet_", petConfigId)
  local needAnimaList = {
    "Idle",
    "Personl_Show"
  }
  local loadNames = CS.System.Array.CreateInstance(typeof(CS.System.String), #needAnimaList)
  for i = 1, #needAnimaList do
    loadNames[i - 1] = needAnimaList[i]
  end
  self.controllerAssetHandle = C_LuaUtility.LoadPlayableController(unitTpl:getAnimatorConfig(unit, L_Const.avatarAnimatorConfigIndex.uiPreview), loadNames)
  self.animator.defaultAnimatorController = self.controllerAssetHandle.config
  self.animator:Play("Idle")
  self.state = "Idle"
  local entity = L_EntityManager:generatePreviewPet(petConfigId, obj, nil, needAnimaList, nil, nil, C_EEntityEntranceType.PetGet)
  return obj, entity
end

function this:setPetBlackRootColor(color)
  if table.isEmpty(self.runtimePetGetData) or self.runtimePetGetData.blackObj == nil then
    return
  end
  local blackObj = self.runtimePetGetData.blackObj
  local effectMaterialHelper = blackObj.transform:GetComponent(typeof(CS.EffectMaterialHelper))
  local EffectAutoMultiColCom = blackObj.transform:GetComponent(typeof(CS.EffectAutoMultiCol))
  local material = effectMaterialHelper.insMaterial
  material:SetColor("_IB_Color", color)
  local percent = 1 - color.a
  EffectAutoMultiColCom.effectMultiColor = C_Color(percent, percent, percent, 1)
end

function this:_setPetStarColor(starColorId, petObj)
  local biologyData = L_CommonUtil.getModComponent(typeof(C_BiologyAvatar), petObj)
  if biologyData then
    biologyData:SetStarColor(starColorId and starColorId or 0)
  end
end

function this:_setPetGetFlashEft(bShow, petObj)
  if not bShow then
    if self.runtimePetGetData.petFlashObj then
      L_CommonUtil.setObjActive(self.runtimePetGetData.petFlashObj, false)
      self.runtimePetGetData.petFlashObj.transform:SetParent(self.runtimePetGetData.modelCache)
    end
    return
  end
  local obj
  if self.runtimePetGetData.petFlashObj then
    obj = self.runtimePetGetData.petFlashObj
  else
    local mediaPackTpl = L_GameTpl:getMediaPackTplTpl()
    local petFlashKey = L_GameTpl:getGameConstTpl():getData("PET_FLASH_EFFECT_PATH_PAGE", L_Const.GameTplType.string)
    local path = mediaPackTpl:getPath(mediaPackTpl:getTplByKey(petFlashKey))
    obj = L_ResPool:syncGameObject(path)
  end
  local EffectMaterialHelperCom = obj.transform:GetComponentInChildren(typeof(CS.EffectMaterialHelper))
  if EffectMaterialHelperCom then
    EffectMaterialHelperCom.characterRoot = petObj
  end
  local ImmuneBuffHelperCom = obj.transform:GetComponentInChildren(typeof(CS.ImmuneBuffHelper))
  if ImmuneBuffHelperCom then
    ImmuneBuffHelperCom.characterRoot = petObj
  end
  local BindMeshEffectCom = obj.transform:GetComponentInChildren(typeof(CS.Lens.Gameplay.Modules.BigWorld.BindMeshEffect))
  if BindMeshEffectCom then
    BindMeshEffectCom:BindMeshBody(petObj)
  end
  obj.transform:SetParent(petObj.transform)
  self._petFlashActiveJob = co.start(function()
    co.step(5)
    L_CommonUtil.setObjActive(obj, true)
  end)
  L_Vector3.setLocalPos(obj.transform, L_Vector3.zero)
  L_Vector3.setLocalRot(obj.transform, L_Vector3.zero)
  L_Vector3.setSize(obj.transform, 1)
  self:playFlashSound()
  self.runtimePetGetData.petFlashObj = obj
end

function this:playPetPersonalShow()
  if self.animator == nil then
    return
  end
  local state = self.animator:GetState("Personl_Show")
  if state ~= nil then
    self.animator:Play("Personl_Show")
    self.state = "Personl_Show"
  end
end

function this:stateNotifyFunc(index, notifyType, stateName)
  if index ~= 0 then
    return
  end
  if notifyType == StateNotifyType.Complete and self.state == "Personl_Show" then
    self.state = nil
    self.animator:CrossFadeInFixedTime("Idle", 0.3, -1, 0, 0.5)
  end
end

function this:_recyclePetGetModel(petConfigId, petObj)
  self.runtimePetGetData.placePets.entity:onDestroy()
  petObj:SetActive(false)
  local petTrans = petObj.transform
  petTrans:SetParent(self.runtimePetGetData.modelCache)
  L_Vector3.setLocalPos(petTrans, L_Vector3.one)
  L_Vector3.setLocalRot(petTrans, L_Vector3.zero)
  self.runtimePetGetData.petCache[petConfigId] = petObj
end

function this:setPetGetActive(active)
  if self.runtimePetGetData and L_CommonUtil.isValid(self.runtimePetGetData.petScene) then
    if active then
      C_UISceneManager.SetSceneVisible()
      self.runtimePetGetData.petScene:SetActive(active)
    else
      self.runtimePetGetData.petScene:SetActive(active)
      C_UISceneManager.SetSceneVisible()
    end
  end
end

function this:setPetGetRot(rot)
  if not table.isEmpty(self.runtimePetGetData.placePets) then
    L_Vector3.setLocalRot(self.runtimePetGetData.placePets.obj.transform, rot)
  end
end

function this:setBlurTexture(texture)
  if L_CommonUtil.isValid(self.runtimePetGetData.bgBlur) then
    self.runtimePetGetData.bgBlur.materials[0]:SetTexture("_BaseMap", texture)
    self.tempTexture = texture
  end
end

function this:setElementTexture(texture)
  if L_CommonUtil.isValid(self.runtimePetGetData.bgElement) then
    self.runtimePetGetData.bgElement.materials[0]:SetTexture("_BaseMap", texture)
    self.runtimePetGetData.bgElement.materials[0]:SetInt("_ColorGradingEnabled", 1)
    self.runtimePetGetData.bgElement.materials[0]:SetInt("_BloomEffectIntensity", -10)
    self.tempElementTexture = texture
  end
end

function this:setPlayableDirectorTime(time)
  if self.runtimePetGetData.playableDirector then
    self.runtimePetGetData.playableDirector.time = time
  end
end

function this:releaseBlurTexture()
  if self.textureWrapper then
    local C_TextureManager = CS.Lens.Framework.Manager.TextureManager
    C_TextureManager.Release(self.textureWrapper)
  end
  if self.textureElementWrapper then
    local C_TextureManager = CS.Lens.Framework.Manager.TextureManager
    C_TextureManager.Release(self.textureElementWrapper)
  end
end

function this:playFlashSound()
  L_TimerManager:newOrResetTimer(self, "playFlashSound", function()
    if L_CommonUtil.isValid(self.flashSound) then
      C_AudioManager.FreeSource(self.flashSound)
      self.flashSound = nil
    end
    self.flashSound = C_AudioManager.Play("Play_SFX_CREAT_Common_FX_Shining_System")
    print("playFlashSound")
  end, 0.5)
end

function this:stopFlashSound()
  L_TimerManager:stopTimer(self, "playFlashSound")
  if L_CommonUtil.isValid(self.flashSound) then
    C_AudioManager.FreeSource(self.flashSound)
    self.flashSound = nil
  end
end

function this:ClearNestCoopPetGuid()
  self.curNestCoopCatchGuid = nil
end

function this:CheckOpenNestCoopPet()
  if self.curNestCoopCatchGuid then
    local petItem = L_PetStore:getPetItem(self.curNestCoopCatchGuid)
    if petItem == nil then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_kibo_can_not_get_info"))
      return
    end
    L_PetManager:getTempRenderTexture(function(tempTex)
      L_UI:open("pageGetPet", {
        pet = petItem,
        showType = L_Const.getPetShowType.long,
        texture = tempTex,
        ignoreNestCall = true
      }, nil, true)
    end)
  end
end

return this
