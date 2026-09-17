local this = class("previewPetEntity", require(L_EcsConst.aliveType.preview))
local CapsuleCollider = CS.UnityEngine.CapsuleCollider

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this:initPreview(entityId, go, petData, needLoadedAnimaNameList, callback, callback1, entranceType)
  self.goModel = go
  self.gameObject = go
  self.entityId = entityId
  self.petData = petData
  self.modelControl = self.goModel:GetComponent(typeof(C_ModelControl))
  self.unitId = self:getUnitId(petData)
  self.entranceType = entranceType or C_EEntityEntranceType.None
  self.biologyData = L_CommonUtil.getModComponent(typeof(C_BiologyAvatar), self.gameObject)
  if self.biologyData then
    if callback ~= nil then
      self.biologyData:AddAllPartUpdateListener(callback)
    end
    if callback1 ~= nil then
      self.biologyData:AddAllPartUpdateListener(callback1)
    end
    self:getDefaultPetLod()
    self.biologyData:SetTheoryShadowLodLv(0)
    self.biologyData:UsePreviewLodLevelByInt(self.lodLevel)
  end
  self:setIk()
  local playableAnimator = L_CommonUtil.getModComponent(typeof(C_PlayableAnimator), self.gameObject)
  playableAnimator.cullingMode = C_AnimatorCullingMode.AlwaysAnimate
  playableAnimator.updateMode = C_PlayableAnimator.UpdateMode.LateUpdate
  playableAnimator.rootMotionController.selfApplyRootMotion = false
  self:setAnimatorController(playableAnimator, needLoadedAnimaNameList)
  self.playableAnimator = playableAnimator
  self:createCollider()
  if not self.biologyData then
    if callback ~= nil then
      callback()
    end
    if callback1 ~= nil then
      callback1()
    end
  end
end

function this:initPreviewAsync(entityId, go, petData, callback, needLoadedAnimaNameList, entranceType)
  self.goModel = go
  self.gameObject = go
  self.entityId = entityId
  self.petData = petData
  self.modelControl = self.goModel:GetComponent(typeof(C_ModelControl))
  self.unitId = self:getUnitId(petData)
  self.entranceType = entranceType or C_EEntityEntranceType.None
  self.biologyData = L_CommonUtil.getModComponent(typeof(C_BiologyAvatar), self.gameObject)
  if self.biologyData then
    self:getDefaultPetLod()
    self.biologyData:SetTheoryShadowLodLv(0)
    self.biologyData:UsePreviewLodLevelByInt(self.lodLevel)
  end
  self:setIk()
  local playableAnimator = L_CommonUtil.getModComponent(typeof(C_PlayableAnimator), self.gameObject)
  playableAnimator.cullingMode = C_AnimatorCullingMode.AlwaysAnimate
  playableAnimator.updateMode = C_PlayableAnimator.UpdateMode.LateUpdate
  playableAnimator.rootMotionController.selfApplyRootMotion = false
  self:setAnimatorControllerAsync(playableAnimator, needLoadedAnimaNameList, function()
    self.playableAnimator = playableAnimator
    self:createCollider()
    if callback then
      callback()
    end
  end)
end

function this:getUnitId(petData)
  local petGuid = self.entityId
  local tpl
  local unitId = 0
  local petInfoTpl = L_GameTpl:getPetTpl()
  petData = petData or L_PetStore:getPetItem(petGuid)
  if table.isEmpty(petData) then
    tpl = petInfoTpl:getTplById(self.entityId)
    if table.isEmpty(tpl) then
      return 0
    else
      unitId = petInfoTpl:getUnitID(tpl)
      return unitId
    end
  end
  tpl = petInfoTpl:getTplById(petData.id)
  unitId = petInfoTpl:getUnitID(tpl)
  return unitId
end

function this:setAnimatorController(playableAnimator, needLoadedAnimaNameList)
  local unitTpl = L_GameTpl:getUnitTpl()
  local unit = unitTpl:getTplById(self.unitId)
  local loadNames
  if needLoadedAnimaNameList then
    loadNames = CS.System.Array.CreateInstance(typeof(CS.System.String), #needLoadedAnimaNameList)
    for i = 1, #needLoadedAnimaNameList do
      local animaName = needLoadedAnimaNameList[i]
      loadNames[i - 1] = animaName
    end
  end
  local key = self.petData and self.petData.animatorConfigPath or unitTpl:getAnimatorConfig(unit, L_Const.avatarAnimatorConfigIndex.uiPreview)
  self.controllerAssetHandle = C_LuaUtility.LoadPlayableController(key, loadNames)
  playableAnimator.defaultAnimatorController = self.controllerAssetHandle.config
end

function this:setAnimatorControllerAsync(playableAnimator, needLoadedAnimaNameList, callback)
  local unitTpl = L_GameTpl:getUnitTpl()
  local unit = unitTpl:getTplById(self.unitId)
  local config = self.petData and self.petData.animatorConfigPath or unitTpl:getAnimatorConfig(unit, L_Const.avatarAnimatorConfigIndex.uiPreview)
  local loadNames
  if needLoadedAnimaNameList then
    loadNames = CS.System.Array.CreateInstance(typeof(CS.System.String), #needLoadedAnimaNameList)
    for i = 1, #needLoadedAnimaNameList do
      local animaName = needLoadedAnimaNameList[i]
      loadNames[i - 1] = animaName
    end
  end
  local assetHandle = C_LuaUtility.LoadPlayableControllerAsync(config, loadNames, function(handle)
    self.controllerAssetHandle = handle
    self.assetHandle = nil
    if L_CommonUtil.isValid(playableAnimator) and not self.isDestroyed then
      playableAnimator.defaultAnimatorController = self.controllerAssetHandle.config
    end
    if callback then
      callback()
    end
  end, true)
  self.assetHandle = assetHandle
end

function this:createCollider()
  this.super.createCollider(self)
  local formationTpl = L_GameTpl:getFormationTpl()
  local tpl = formationTpl:getTplById(self.unitId)
  if not tpl then
    error("formationTpl内没有" .. self.unitId)
    return
  end
  local colliderCenter, colliderRadius, colliderHeight = formationTpl:getFormationCollider(tpl)
  local collider = self.gameObject:PickComponent(typeof(CapsuleCollider))
  collider.center = colliderCenter
  collider.radius = colliderRadius
  collider.height = colliderHeight
end

function this:setIk()
  local ik = self.gameObject:GetComponentInChildren(typeof(C_FullBodyBipedIK))
  if ik then
    ik.enabled = false
  end
end

function this:onDestroy()
  this.super.onDestroy(self)
  if self.assetHandle then
    self.assetHandle:Dispose()
    self.assetHandle = nil
  end
  if self.controllerAssetHandle then
    C_LuaUtility.ReleasePlayableController(self.controllerAssetHandle)
    self.controllerAssetHandle = nil
  end
end

return this
