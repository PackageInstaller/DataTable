local this = {}
local sConcat = string.concat
local _petTpl = L_GameTpl:getPetTpl()
local _unitTpl = L_GameTpl:getUnitTpl()
local PETSCENEPATH = "Program/UIScene/Pet/pre_pethouse_ui_01.prefab"
local PETGETBLACKPATH = "Program/UIScene/pre_KiboAddBlack.prefab"
local KIBO_DRESSUP_SWITCH_EFFECT_PATH_MAP = {
  [1] = "Effect/Battle/Common/pre_kibo_dressup_change_01.prefab",
  [2] = "Effect/Battle/Common/pre_kibo_dressup_change_02.prefab",
  [3] = "Effect/Battle/Common/pre_kibo_dressup_change_03.prefab"
}
local _NormalFaceIdx = 1

local function _getPetSkinSuffix(petSkinInfo, key)
  if petSkinInfo == nil then
    return nil
  end
  local suffix = petSkinInfo[key]
  if string.isEmpty(suffix) then
    return nil
  end
  return suffix
end

local function _appendAssetSuffix(path, suffix)
  if string.isEmpty(path) or string.isEmpty(suffix) then
    return path
  end
  local newPath, replaceCount = string.gsub(path, "(%.[^%.]+)$", "_" .. suffix .. "%1", 1)
  if replaceCount == 0 then
    newPath = path .. "_" .. suffix
  end
  return newPath
end

local function _getDressupSwitchEffectPath(bodyType)
  if bodyType == nil or bodyType <= 0 then
    return nil
  end
  if bodyType <= 3 then
    return KIBO_DRESSUP_SWITCH_EFFECT_PATH_MAP[1]
  end
  if bodyType <= 5 then
    return KIBO_DRESSUP_SWITCH_EFFECT_PATH_MAP[2]
  end
  if bodyType == 6 then
    return KIBO_DRESSUP_SWITCH_EFFECT_PATH_MAP[3]
  end
  return nil
end

local function _ensurePetHouseFilterController(sceneGo)
  if not L_CommonUtil.isValid(sceneGo) then
    return nil
  end
  local sceneTrans = sceneGo.transform
  if sceneTrans == nil or sceneTrans.childCount == 0 then
    return nil
  end
  local sceneRootGo = sceneTrans:GetChild(0).gameObject
  local petHouseFilterController = sceneRootGo:GetComponent(typeof(CS.PetHouseFilterController))
  petHouseFilterController = petHouseFilterController or sceneRootGo:AddComponent(typeof(CS.PetHouseFilterController))
  return petHouseFilterController
end

function this:loadPetDetailScene(customSceneId)
  if self.runtimeData and self.runtimeData.petScene then
    if self._curCustomSceneId == customSceneId then
      C_UISceneManager.SetSceneVisible()
      self.runtimeData.petScene:ActiveTrans(true)
      _ensurePetHouseFilterController(self.runtimeData.petScene)
      return
    end
    self:removePetScene()
  end
  local scenePath = L_CommonUtil.getMultiPlatformScenePath(PETSCENEPATH)
  if customSceneId ~= nil and customSceneId ~= 0 then
    local suffix
    if customSceneId < 100 then
      suffix = string.format("%02d", customSceneId)
    else
      suffix = tostring(customSceneId)
    end
    scenePath = L_CommonUtil.getMultiPlatformScenePath(sConcat("Program/UIScene/Pet/pre_pethouse_ui_", suffix, ".prefab"))
  end
  C_UISceneManager.SetSceneVisible()
  self._sceneLoadToken = (self._sceneLoadToken or 0) + 1
  self._curCustomSceneId = customSceneId
  self.runtimeData = require("ui.manager.pet.petSceneRuntimeData").new(L_ResPool:syncGameObject(scenePath))
  local sceneTrans = self.runtimeData.petScene.transform
  sceneTrans:SetParent(C_LuaUtility.GetRootNode())
  L_Vector3.setPos(sceneTrans, C_UIMgr.SceneLoadDefaultPosition)
  L_Vector3.setRot(sceneTrans, L_Vector3.zero)
  _ensurePetHouseFilterController(self.runtimeData.petScene)
end

function this:asyncLoadPetDetailScene(customSceneId, callback)
  if self.runtimeData and self.runtimeData.petScene then
    if self._curCustomSceneId == customSceneId then
      C_UISceneManager.SetSceneVisible()
      self.runtimeData.petScene:ActiveTrans(true)
      _ensurePetHouseFilterController(self.runtimeData.petScene)
      if callback then
        callback()
      end
      return
    end
    self:removePetScene()
  end
  local scenePath = L_CommonUtil.getMultiPlatformScenePath(PETSCENEPATH)
  if customSceneId ~= nil and customSceneId ~= 0 then
    local suffix
    if customSceneId < 100 then
      suffix = string.format("%02d", customSceneId)
    else
      suffix = tostring(customSceneId)
    end
    scenePath = L_CommonUtil.getMultiPlatformScenePath(sConcat("Program/UIScene/Pet/pre_pethouse_ui_", suffix, ".prefab"))
  end
  C_UISceneManager.SetSceneVisible()
  self._sceneLoadToken = (self._sceneLoadToken or 0) + 1
  local loadToken = self._sceneLoadToken
  L_ResPool:asyncGameObject(scenePath, function(id, go)
    if loadToken ~= self._sceneLoadToken then
      if L_CommonUtil.isValid(go) then
        L_ResPool:destroyGo(go)
      end
      return
    end
    self._curCustomSceneId = customSceneId
    self.runtimeData = require("ui.manager.pet.petSceneRuntimeData").new(go)
    local sceneTrans = self.runtimeData.petScene.transform
    sceneTrans:SetParent(C_LuaUtility.GetRootNode())
    L_Vector3.setPos(sceneTrans, C_UIMgr.SceneLoadDefaultPosition)
    L_Vector3.setRot(sceneTrans, L_Vector3.zero)
    _ensurePetHouseFilterController(self.runtimeData.petScene)
    if callback then
      callback()
    end
  end)
end

function this:removePetScene()
  self._sceneLoadToken = (self._sceneLoadToken or 0) + 1
  L_TimerManager:clearTimer(self)
  if self._petTransMatJob then
    co.stop(self._petTransMatJob)
    self._petTransMatJob = nil
  end
  if self._petFlashActiveJob then
    co.stop(self._petFlashActiveJob)
    self._petFlashActiveJob = nil
  end
  self:removePetModel()
  if self.runtimeData then
    self.runtimeData:destroy()
    self.runtimeData = nil
  end
  self._curCustomSceneId = nil
  C_UISceneManager.SetSceneVisible()
  self:stopFlashSound()
end

function this:SetBiologyData()
  if self.runtimeData ~= nil and L_CommonUtil.isValid(self.runtimeData.petScene) then
    local petHouseFilterController = _ensurePetHouseFilterController(self.runtimeData.petScene)
    if petHouseFilterController then
      petHouseFilterController:SetBiologyData()
      local curPlacePet = self:getInPlacePet()
      local curPlacePetId = curPlacePet.configId
      local curBodyType = _petTpl:getBodyType(_petTpl:getTplById(curPlacePetId)) or 1
      local cfgScale = L_GameConstTpl:getData("KIBO_FRUIT_CAMERA_FOV_PARAM", L_Const.GameTplType.list_float)
      petHouseFilterController:SetEndValue(cfgScale[curBodyType])
    end
  end
end

function this:_getPetPreviewVariantKey(petConfigId, isSpecial, petSkinInfo)
  local unitSuffix = _getPetSkinSuffix(petSkinInfo, "unitSuffix") or ""
  local animatorSuffix = _getPetSkinSuffix(petSkinInfo, "animatorSuffix") or ""
  return string.format("%s_%s_%s_%s", tostring(petConfigId), tostring(isSpecial or 0), unitSuffix, animatorSuffix)
end

function this:_getPetPreviewResInfo(petConfigId, isSpecial, petSkinInfo)
  local tpl = _petTpl:getTplById(petConfigId)
  local unitId = _petTpl:getUnitID(tpl)
  local unitTpl = L_GameTpl:getUnitTpl()
  local unit = unitTpl:getTplById(unitId)
  local path = L_GameUtil.getAvatarModelPathByUnitId(unitId, L_Const.avatarModelIndex.UnitModel)
  if isSpecial and isSpecial ~= 0 then
    local specialParm = unitTpl:getSpecialParm(unit)
    local replaceStr = specialParm and specialParm[isSpecial]
    if replaceStr then
      path = _appendAssetSuffix(path, replaceStr)
    end
  end
  local unitSuffix = _getPetSkinSuffix(petSkinInfo, "unitSuffix")
  if unitSuffix then
    path = _appendAssetSuffix(path, unitSuffix)
  end
  local previewPetData
  local animatorSuffix = _getPetSkinSuffix(petSkinInfo, "animatorSuffix")
  if animatorSuffix then
    local animatorConfigPath = L_GameUtil.getAnimatorControllerPathByUnitId(unitId, L_Const.avatarAnimatorConfigIndex.uiPreview)
    animatorConfigPath = _appendAssetSuffix(animatorConfigPath, animatorSuffix)
    if not string.isEmpty(animatorConfigPath) then
      previewPetData = {id = petConfigId, animatorConfigPath = animatorConfigPath}
    end
  end
  return path, previewPetData, self:_getPetPreviewVariantKey(petConfigId, isSpecial, petSkinInfo)
end

function this:loadPetModel(petConfigId, isSpecial, isFlash, moveLeft, petSkinInfo)
  self:stopFlashSound()
  if math.isEmpty(petConfigId) then
    self:removePetModel()
    return
  end
  local modelKey = self:_getPetPreviewVariantKey(petConfigId, isSpecial, petSkinInfo)
  local curPlacePet = self:getInPlacePet()
  if not table.isEmpty(curPlacePet) and curPlacePet.modelKey == modelKey then
    self:_setPetFlashEft(isFlash, curPlacePet.obj)
    return
  end
  self:removePetModel()
  local pointTrans = self.runtimeData.petPoints
  local tpl = _petTpl:getTplById(petConfigId)
  local posList = _petTpl:getUnitCameraPosition(tpl)
  if moveLeft == true then
    self:setCameraNodePos(L_Vector3.new(posList[1] - 1, posList[2], posList[3]))
  else
    self:setCameraNodePos(L_Vector3.new(posList[1], posList[2], posList[3]))
  end
  local petObj, entity
  if not table.isEmpty(self.runtimeData.placePets) then
    petObj = self.runtimeData.placePets.obj
    entity = self.runtimeData.placePets.entity
  else
    petObj, entity = self:_fetchPetModel(petConfigId, isSpecial, petSkinInfo)
  end
  self:processPetModel(petConfigId, isFlash, pointTrans, tpl, petObj, entity, modelKey)
end

function this:asyncLoadPetModel(petConfigId, isSpecial, isFlash, moveLeft, callback, petSkinInfo, petStarColorId)
  self:stopFlashSound()
  if math.isEmpty(petConfigId) then
    self:removePetModel()
    return
  end
  local modelKey = self:_getPetPreviewVariantKey(petConfigId, isSpecial, petSkinInfo)
  local curPlacePet = self:getInPlacePet()
  if not table.isEmpty(curPlacePet) and curPlacePet.modelKey == modelKey then
    self:_setPetFlashEft(isFlash, curPlacePet.obj)
    self:_setPetStarColor(petStarColorId, curPlacePet.obj)
    if callback then
      callback()
    end
    return
  end
  if self._pendingModelKey == modelKey then
    if callback then
      callback()
    end
    return
  end
  self:removePetModel()
  self._pendingModelKey = modelKey
  self:setPetInfo(petConfigId, isSpecial, isFlash, moveLeft, callback, petSkinInfo, petStarColorId)
end

function this:setPetInfo(petConfigId, isSpecial, isFlash, moveLeft, callback, petSkinInfo, petStarColorId)
  if self.runtimeData ~= nil then
    local pointTrans = self.runtimeData.petPoints
    local tpl = _petTpl:getTplById(petConfigId)
    local modelKey = self:_getPetPreviewVariantKey(petConfigId, isSpecial, petSkinInfo)
    local posList = _petTpl:getUnitCameraPosition(tpl)
    if moveLeft == true then
      self:setCameraNodePos(L_Vector3.new(posList[1] - 1, posList[2], posList[3]))
    else
      self:setCameraNodePos(L_Vector3.new(posList[1], posList[2], posList[3]))
    end
    self:setStarSoulCamPos(tpl)
    local petObj, entity
    if not table.isEmpty(self.runtimeData.placePets) then
      petObj = self.runtimeData.placePets.obj
      entity = self.runtimeData.placePets.entity
      self:processPetModel(petConfigId, isFlash, pointTrans, tpl, petObj, entity, modelKey, petStarColorId)
      L_PetManager:SetBiologyData()
      if callback then
        callback()
      end
    else
      self:_asyncFetchPetModel(petConfigId, isSpecial, petSkinInfo, function(petObj, entity)
        if self._pendingModelKey ~= modelKey then
          if entity then
            entity:onDestroy()
          end
          if L_CommonUtil.isValid(petObj) then
            if self.runtimeData then
              petObj:SetActive(false)
              petObj.transform:SetParent(self.runtimeData.modelCache)
              self.runtimeData.petCache[modelKey] = petObj
            else
              L_ResPool:destroyGo(petObj)
            end
          end
          return
        end
        self._pendingModelKey = nil
        self:processPetModel(petConfigId, isFlash, pointTrans, tpl, petObj, entity, modelKey, petStarColorId)
        L_PetManager:SetBiologyData()
        if callback then
          callback()
        end
      end)
    end
    self.runtimeData:refreshBlend()
    self:switchToFeed()
  else
    self._pendingModelKey = nil
  end
end

function this:processPetModel(petConfigId, isFlash, pointTrans, tpl, petObj, entity, modelKey, petStarColorId)
  local rotationOffset = C_GameObject("RotationOffset")
  rotationOffset.transform:SetParent(pointTrans)
  L_Vector3.setLocalPos(rotationOffset.transform, L_Vector3.zero)
  L_Vector3.setLocalRot(rotationOffset.transform, L_Vector3.zero)
  L_Vector3.setSize(rotationOffset.transform, 1)
  petObj.transform:SetParent(rotationOffset.transform)
  local unitId = L_GameUtil.getUnitIdByRole(petConfigId, L_Const.roleType.pet)
  local all_stage_scale = _petTpl:getUnitScale(tpl) or 10000
  local unitTpl = _unitTpl:getTplById(unitId)
  local worldScale = _unitTpl:getModelScale(unitTpl)
  local scale = all_stage_scale / 10000
  L_Vector3.setSize(petObj.transform, scale * worldScale)
  local position = _petTpl:getUnitPosition(tpl)
  if table.isEmpty(position) then
    L_Vector3.setLocalPos(petObj.transform, L_Vector3.zero)
  else
    L_Vector3.setLocalPos(petObj.transform, L_Vector3.new(position[1], position[2], position[3]))
  end
  local rot = L_Vector3.zero
  L_Vector3.setLocalRot(petObj.transform, rot)
  petObj:ActiveTrans(true)
  local petTpl = _petTpl:getTplById(petConfigId)
  local rotationType = _petTpl:getUnitRotationType(petTpl)
  self.runtimeData.placePets = {
    obj = petObj,
    configId = petConfigId,
    modelKey = modelKey,
    entity = entity,
    unitId = unitId,
    rotationType = rotationType,
    rotationRoot = pointTrans
  }
  self:_setPetFlashEft(isFlash, petObj)
  self:_setPetStarColor(petStarColorId, petObj)
  local hipBoneTrans = L_GameUtil.findTranByName(petObj, "Hips")
  local neckBoneTrans = L_GameUtil.findTranByName(petObj, "Neck")
  if hipBoneTrans and neckBoneTrans then
    local hipPos = hipBoneTrans.position
    local neckPos = neckBoneTrans.position
    local centerPos = (hipPos + neckPos) * 0.5
    rotationOffset.transform.position = centerPos
    local localPos = L_Vector3.getLocalPos(rotationOffset.transform)
    local newPos = L_Vector3.new(-localPos.x, 0, -localPos.z)
    L_Vector3.setLocalPos(rotationOffset.transform, newPos)
  end
  local disableShadowObjName = _petTpl:getNoShadow(petTpl)
  self._petTransMatJob = co.start(function()
    co.step(2)
    local renderers = petObj:GetComponentsInChildren(typeof(CS.UnityEngine.SkinnedMeshRenderer))
    for i = 0, renderers.Length - 1 do
      local materials = renderers[i].sharedMaterials
      for j = 0, materials.Length - 1 do
        local material = materials[j]
        if material and material.shader then
          local shaderName = material.shader.name
          if string.find(shaderName, "Transparent") or string.find(shaderName, "Expression") or string.find(shaderName, "ImmuneBuff") then
            if material.renderQueue + 1500 > 4999 then
              material.renderQueue = 4999
            else
              material.renderQueue = material.renderQueue + 1500
            end
          end
        else
          print("Material: null")
        end
      end
    end
    co.step(2)
    for _, objName in ipairs(disableShadowObjName) do
      local targetObj = L_GameUtil.findTranByName(petObj, objName)
      if targetObj then
        local skinnedMeshRenderer = targetObj:GetComponent(typeof(CS.UnityEngine.SkinnedMeshRenderer))
        if skinnedMeshRenderer then
          local sharedMaterials = skinnedMeshRenderer.sharedMaterials
          for k = 0, sharedMaterials.Length - 1 do
            local mat = sharedMaterials[k]
            if mat then
              mat:EnableKeyword("_DISABLE_SHADOW_RECEIVE")
            end
          end
        end
      end
    end
  end)
end

function this:loadBlackPetModel(petConfigId)
  if math.isEmpty(petConfigId) then
    self:removePetModel()
    return
  end
  local curPlacePet = self:getInPlacePet()
  if not table.isEmpty(curPlacePet) and curPlacePet.configId == petConfigId then
    self:_setPetFlashEft(isFlash, curPlacePet.obj)
    return
  end
  self:removePetModel()
  local pointTrans = self.runtimeData.petPoints
  local tpl = _petTpl:getTplById(petConfigId)
  local posList = _petTpl:getUnitCameraPosition(tpl)
  self:setCameraNodePos(L_Vector3.new(posList[1], posList[2], posList[3]))
  local petObj, entity
  if not table.isEmpty(self.runtimeData.placePets) then
    petObj = self.runtimeData.placePets.obj
    entity = self.runtimeData.placePets.entity
  else
    petObj, entity = self:_fetchPetModel(petConfigId)
  end
  petObj.transform:SetParent(pointTrans)
  local unitId = L_GameUtil.getUnitIdByRole(petConfigId, L_Const.roleType.pet)
  local all_stage_scale = _petTpl:getUnitScale(tpl) or 10000
  local unitTpl = _unitTpl:getTplById(unitId)
  local worldScale = _unitTpl:getModelScale(unitTpl)
  local scale = all_stage_scale / 10000
  L_Vector3.setSize(petObj.transform, scale * worldScale)
  local position = _petTpl:getUnitPosition(tpl)
  if table.isEmpty(position) then
    L_Vector3.setLocalPos(petObj.transform, L_Vector3.zero)
  else
    L_Vector3.setLocalPos(petObj.transform, L_Vector3.new(position[1], position[2], position[3]))
  end
  local rot = L_Vector3.zero
  L_Vector3.setLocalRot(petObj.transform, rot)
  petObj:ActiveTrans(true)
  local petTpl = _petTpl:getTplById(petConfigId)
  local rotationType = _petTpl:getUnitRotationType(petTpl)
  self.runtimeData.placePets = {
    obj = petObj,
    configId = petConfigId,
    entity = entity,
    unitId = unitId,
    rotationType = rotationType,
    rotationRoot = pointTrans
  }
  local blackObj = L_ResPool:syncGameObject(PETGETBLACKPATH)
  blackObj.transform:Reset(petObj.transform)
  blackObj.transform.localScale = L_Vector3.one
  blackObj.transform.localPosition = L_Vector3.zero
  blackObj.name = "blackRoot"
  local EffectMaterialHelperCom = blackObj.transform:GetComponent(typeof(CS.EffectMaterialHelper))
  if EffectMaterialHelperCom then
    EffectMaterialHelperCom.characterRoot = petObj
  end
  local EffectAutoMultiColCom = blackObj.transform:GetComponent(typeof(CS.EffectAutoMultiCol))
  if EffectAutoMultiColCom then
    EffectAutoMultiColCom.characterRoot = petObj
  end
  self.runtimeData.blackObj = blackObj
  self:_setPetBlackColor(C_Color(0, 0, 0, 1))
  blackObj:SetActive(false)
  blackObj:SetActive(true)
end

function this:_setPetBlackColor(color)
  if table.isEmpty(self.runtimeData) or self.runtimeData.blackObj == nil then
    return
  end
  local blackObj = self.runtimeData.blackObj
  local effectMaterialHelper = blackObj.transform:GetComponent(typeof(CS.EffectMaterialHelper))
  local EffectAutoMultiColCom = blackObj.transform:GetComponent(typeof(CS.EffectAutoMultiCol))
  local material = effectMaterialHelper.insMaterial
  material:SetColor("_IB_Color", color)
  local percent = 1 - color.a
  EffectAutoMultiColCom.effectMultiColor = C_Color(percent, percent, percent, 1)
end

function this:removePetModel()
  self._pendingModelKey = nil
  if self.runtimeData == nil or table.isEmpty(self.runtimeData.placePets) then
    return
  end
  self:_recyclePetModel(self.runtimeData.placePets.configId, self.runtimeData.placePets.obj, self.runtimeData.placePets.modelKey)
  self.runtimeData.placePets = nil
  self:_setPetFlashEft(false)
  self:stopFlashSound()
end

function this:getInPlacePet()
  if self.runtimeData == nil then
    return nil
  end
  return self.runtimeData.placePets
end

function this:_fetchPetModel(petConfigId, isSpecial, petSkinInfo)
  local path, previewPetData, modelKey = self:_getPetPreviewResInfo(petConfigId, isSpecial, petSkinInfo)
  local obj
  if self.runtimeData.petCache[modelKey] then
    obj = self.runtimeData.petCache[modelKey]
    self.runtimeData.petCache[modelKey] = nil
  else
    obj = L_ResPool:syncGameObject(path)
  end
  local animator = L_CommonUtil.getModComponent(typeof(C_PlayableAnimator), obj)
  animator.cullingMode = C_AnimatorCullingMode.AlwaysAnimate
  animator.updateMode = C_PlayableAnimator.UpdateMode.LateUpdate
  animator.rootMotionController.selfApplyRootMotion = true
  obj.name = sConcat("pet_", petConfigId)
  local needAnimaList = {"Idle"}
  local entity = L_EntityManager:generatePreviewPet(petConfigId, obj, previewPetData, needAnimaList, nil, nil, C_EEntityEntranceType.PetDetail)
  entity.playableAnimator:Play("Idle")
  return obj, entity
end

function this:_asyncFetchPetModel(petConfigId, isSpecial, petSkinInfo, callback)
  local path, previewPetData, modelKey = self:_getPetPreviewResInfo(petConfigId, isSpecial, petSkinInfo)
  local obj
  local needAnimaList = {"Idle"}
  if self.runtimeData.petCache[modelKey] then
    obj = self.runtimeData.petCache[modelKey]
    self.runtimeData.petCache[modelKey] = nil
    local entity = L_EntityManager:generatePreviewPet(petConfigId, obj, previewPetData, needAnimaList, nil, nil, C_EEntityEntranceType.PetDetail)
    self:setPetAnim(petConfigId, obj, entity)
    if callback then
      callback(obj, entity)
    end
  else
    L_ResPool:asyncGameObject(path, function(id, obj)
      local entity = L_EntityManager:generatePreviewPet(petConfigId, obj, previewPetData, needAnimaList, nil, nil, C_EEntityEntranceType.PetDetail)
      self:setPetAnim(petConfigId, obj, entity)
      if callback then
        callback(obj, entity)
      end
    end)
  end
end

function this:setPetAnim(petConfigId, obj, entity)
  local animator = L_CommonUtil.getModComponent(typeof(C_PlayableAnimator), obj)
  animator.cullingMode = C_AnimatorCullingMode.AlwaysAnimate
  animator.updateMode = C_PlayableAnimator.UpdateMode.LateUpdate
  animator.rootMotionController.selfApplyRootMotion = true
  obj.name = sConcat("pet_", petConfigId)
  entity.playableAnimator:Play("Idle")
end

function this:_recyclePetModel(petConfigId, petObj, modelKey)
  if self.runtimeData.placePets ~= nil and self.runtimeData.placePets.entity ~= nil then
    self.runtimeData.placePets.entity:onDestroy()
  end
  if petObj ~= nil then
    local rotationOffset = petObj.transform.parent
    petObj:SetActive(false)
    local petTrans = petObj.transform
    petTrans:SetParent(self.runtimeData.modelCache)
    L_Vector3.setLocalPos(petTrans, L_Vector3.one)
    L_Vector3.setLocalRot(petTrans, L_Vector3.zero)
    self.runtimeData.petCache[modelKey or petConfigId] = petObj
    if L_CommonUtil.isValid(rotationOffset) and rotationOffset.name == "RotationOffset" then
      C_GameObject.Destroy(rotationOffset.gameObject)
    end
  end
end

function this:_setPetFlashEft(bShow, petObj)
  if not bShow then
    if self.runtimeData.petFlashObj then
      L_CommonUtil.setObjActive(self.runtimeData.petFlashObj, false)
      self.runtimeData.petFlashObj.transform:SetParent(self.runtimeData.modelCache)
    end
    return
  end
  local obj
  if self.runtimeData.petFlashObj then
    obj = self.runtimeData.petFlashObj
  else
    local mediaPackTpl = L_GameTpl:getMediaPackTplTpl()
    local petFlashKey = L_GameTpl:getGameConstTpl():getData("PET_FLASH_EFFECT_PATH_PAGE", L_Const.GameTplType.string)
    local path = mediaPackTpl:getPath(mediaPackTpl:getTplByKey(petFlashKey))
    obj = L_ResPool:syncGameObject(path)
  end
  L_CommonUtil.setObjActive(obj, false)
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
  self.runtimeData.petFlashObj = obj
end

function this:_setPetStarColor(starColorId, petObj)
  local biologyData = L_CommonUtil.getModComponent(typeof(C_BiologyAvatar), petObj)
  if biologyData then
    biologyData:SetStarColor(starColorId and starColorId or 0)
  end
end

function this:setSceneArtActive(active)
  if self.runtimeData ~= nil and L_CommonUtil.isValid(self.runtimeData.petScene) then
    if active then
      C_UISceneManager.SetSceneVisible()
      self.runtimeData.petScene:SetActive(active)
    else
      self.runtimeData.petScene:SetActive(active)
      C_UISceneManager.SetSceneVisible()
    end
  end
end

function this:SetPetRotDisable(isDisable)
  self.isDisablePetRot = isDisable
end

function this:setScenePetRot(rot)
  if self.isDisablePetRot then
    return
  end
  if not table.isEmpty(self.runtimeData.placePets) then
    if self.runtimeData.placePets.rotationType == 1 then
      local newRot = L_Vector3.new(rot.x, rot.y - 45, rot.z)
      L_Vector3.setLocalRot(self.runtimeData.placePets.rotationRoot.transform, newRot)
    elseif self.runtimeData.placePets.rotationType == 2 then
      L_Vector3.setLocalRot(self.runtimeData.placePets.obj.transform, rot)
    end
  end
end

function this:switchToFeed()
  self:switchCam(L_PetConst.EnumCamName.Feed)
end

function this:switchToStarSoul()
  self:switchCam(L_PetConst.EnumCamName.StarSoul)
end

function this:switchCam(camName)
  if not self.runtimeData or not self.runtimeData.cameraNodeData then
    return
  end
  if self.runtimeData.curCamName == camName then
    return
  end
  self.runtimeData:refreshBlend()
  for name, cameraData in pairs(self.runtimeData.cameraNodeData) do
    if cameraData.camera then
      cameraData.camera.enabled = true
      cameraData.camera.Priority = name == camName and 10 or 0
    end
  end
  self.runtimeData.curCamName = camName
end

function this:setStarSoulCamPos(tpl)
  if not tpl then
    return
  end
  if not self.runtimeData or not L_CommonUtil.isValid(self.runtimeData.starSoulCamNode) then
    return
  end
  local posList = _petTpl:getStaroulCamPos(tpl)
  local rotList = _petTpl:getStarsoulCamRot(tpl)
  if posList and #posList == 3 then
    L_Vector3.setLocalPos(self.runtimeData.starSoulCamNode.transform, L_Vector3.new(posList[1], posList[2], posList[3]))
  end
  if rotList and #rotList == 3 then
    L_Vector3.setLocalRot(self.runtimeData.starSoulCamNode.transform, L_Vector3.new(rotList[1], rotList[2], rotList[3]))
  end
end

function this:setCameraNodePos(pos)
  if L_CommonUtil.isValid(self.runtimeData.cameraNode) then
    L_Vector3.setLocalPos(self.runtimeData.cameraNode.transform, pos)
  end
end

function this:setCameraNodePosOffset(pos)
  if L_CommonUtil.isValid(self.runtimeData.cameraNode) then
    local oldPos = L_Vector3.getLocalPos(self.runtimeData.cameraNode.transform)
    local newPos = oldPos + pos
    L_Vector3.setLocalPos(self.runtimeData.cameraNode.transform, newPos)
  end
end

function this:setCameraNodeRotOffset(rot)
  if L_CommonUtil.isValid(self.runtimeData.cameraNode) then
    local oldRot = L_Vector3.getLocalRot(self.runtimeData.cameraNode.transform)
    local newRot = oldRot + rot
    L_Vector3.setLocalRot(self.runtimeData.cameraNode.transform, newRot)
  end
end

function this:playExpression(index)
  local curPlacePet = self:getInPlacePet()
  if table.isEmpty(curPlacePet) then
    return
  end
  local petObj = curPlacePet.obj
  local modelControl = petObj:GetComponent(typeof(C_ModelControl))
  if modelControl == nil then
    return
  end
  self.expression = modelControl:GetComponentByType(typeof(CS.KiboExpression))
  if not self.expression then
    error("奇波缺少KiboExpression组件")
    return
  end
  if index == nil then
    index = _NormalFaceIdx
  end
  self.expression.LockExpression = false
  self.expression:SetEye(index)
  self.expression:SetMouth(index)
  if index ~= _NormalFaceIdx then
    self.expression.LockExpression = true
  end
end

function this:playFlashSound()
  self.flashSound = C_AudioManager.Play("Play_SFX_CREAT_Common_FX_Shining_System")
end

function this:stopFlashSound()
  if L_CommonUtil.isValid(self.flashSound) then
    C_AudioManager.FreeSource(self.flashSound)
    self.flashSound = nil
  end
end

function this:playDressupSwitchEffect(bodyType)
  if self.runtimeData == nil then
    return
  end
  local effectPath = _getDressupSwitchEffectPath(bodyType)
  if string.isEmpty(effectPath) then
    return
  end
  local curPlacePet = self:getInPlacePet()
  if table.isEmpty(curPlacePet) or not L_CommonUtil.isValid(curPlacePet.obj) then
    return
  end
  local targetTrans = L_CommonUtil.findTranByName("Global", curPlacePet.obj.transform) or curPlacePet.obj.transform
  if not L_CommonUtil.isValid(targetTrans) then
    return
  end
  if L_CommonUtil.isValid(self.runtimeData.dressupSwitchEffect) then
    L_ResPool:destroyGo(self.runtimeData.dressupSwitchEffect)
    self.runtimeData.dressupSwitchEffect = nil
  end
  local effectObj = L_ResPool:syncGameObject(effectPath)
  if not L_CommonUtil.isValid(effectObj) then
    return
  end
  effectObj.transform:SetParent(targetTrans)
  L_Vector3.setLocalPos(effectObj.transform, L_Vector3.zero)
  L_Vector3.setLocalRot(effectObj.transform, L_Vector3.zero)
  effectObj.transform.localScale = C_Vector3(effectObj.transform.localScale.x * 2, effectObj.transform.localScale.y * 2, effectObj.transform.localScale.z * 2)
  effectObj:ActiveTrans(true)
  self.runtimeData.dressupSwitchEffect = effectObj
end

return this
