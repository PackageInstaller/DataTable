local this = class("previewHeroEntity", require(L_EcsConst.aliveType.preview))
local CapsuleCollider = CS.UnityEngine.CapsuleCollider

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this:initPreviewAsync(entityId, go, avatarData, animatorConfig, callback, needLoadedAnimaNameList, entranceType)
  self.goModel = go
  self.gameObject = go
  self.entityId = entityId
  self.modelControl = self.goModel:GetComponent(typeof(C_ModelControl))
  self.unitId = self:getUnitId()
  self.entranceType = entranceType or C_EEntityEntranceType.None
  self.biologyData = L_CommonUtil.getModComponent(typeof(C_BiologyAvatar), self.gameObject)
  if self.biologyData then
    self:getDefaultLod()
    self.biologyData:SetTheoryShadowLodLv(0)
    self.biologyData:UsePreviewLodLevelByInt(self.lodLevel)
  end
  self:setIk()
  local playableAnimator = L_CommonUtil.getModComponent(typeof(C_PlayableAnimator), self.gameObject)
  playableAnimator.cullingMode = C_AnimatorCullingMode.AlwaysAnimate
  playableAnimator.updateMode = C_PlayableAnimator.UpdateMode.LateUpdate
  self:createCollider()
  if animatorConfig ~= nil then
    self.avatarCtrl = AzurWorld.avatarMgr:SetAvatar(self.modelControl, avatarData)
  else
    local loadNames
    if needLoadedAnimaNameList then
      loadNames = CS.System.Array.CreateInstance(typeof(CS.System.String), #needLoadedAnimaNameList)
      for i = 1, #needLoadedAnimaNameList do
        local animaName = needLoadedAnimaNameList[i]
        loadNames[i - 1] = animaName
      end
    end
    self.avatarCtrl = AzurWorld.avatarMgr:SetAvatarUIPreviewWithLoadStateNames(self.modelControl, avatarData, loadNames)
  end
  self:setAnimatorControllerAsync(playableAnimator, animatorConfig, needLoadedAnimaNameList, function()
    self.playableAnimator = playableAnimator
    if callback then
      callback()
    end
  end)
end

function this:getUnitId()
  local unitId = L_GameUtil.getUnitIdByRole(self.entityId, L_Const.roleType.hero)
  return unitId
end

function this:setAnimatorController(playableAnimator, animatorConfig, needLoadedAnimaNameList)
  local isPlayer = self.entityId == L_GameUtil.getDefaultHeroId()
  if not isPlayer then
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
    local key = unitTpl:getAnimatorConfig(unit, animatorConfig or L_Const.avatarAnimatorConfigIndex.uiPreview)
    self.controllerAssetHandle = C_LuaUtility.LoadPlayableController(key, loadNames)
    playableAnimator.defaultAnimatorController = self.controllerAssetHandle.config
  end
end

function this:setAnimatorControllerAsync(playableAnimator, animatorConfig, needLoadedAnimaNameList, callback)
  local isPlayer = self.entityId == L_GameUtil.getDefaultHeroId()
  if not isPlayer then
    local unitTpl = L_GameTpl:getUnitTpl()
    local unit = unitTpl:getTplById(self.unitId)
    local config = unitTpl:getAnimatorConfig(unit, animatorConfig or L_Const.avatarAnimatorConfigIndex.uiPreview)
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
  elseif callback then
    callback()
  end
end

function this:setIk()
  local groundIk = L_CommonUtil.getModComponent(typeof(C_GrounderIK), self.gameObject)
  if groundIk then
    groundIk.enabled = false
    for i = 0, groundIk.legs.Length - 1 do
      groundIk.legs[i].enabled = false
    end
  end
end

function this:createCollider()
  this.super.createCollider(self)
  local formationTpl = L_GameTpl:getFormationTpl()
  local tpl = formationTpl:getTplById(self.unitId)
  local colliderCenter, colliderRadius, colliderHeight = formationTpl:getFormationCollider(tpl)
  local collider = self.gameObject:PickComponent(typeof(CapsuleCollider))
  collider.center = colliderCenter
  collider.radius = colliderRadius
  collider.height = colliderHeight
end

function this:onDestroy()
  self.isDestroyed = true
  this.super.onDestroy(self)
  if self.assetHandle then
    self.assetHandle:Dispose()
    self.assetHandle = nil
  end
  if self.controllerAssetHandle then
    C_LuaUtility.ReleasePlayableController(self.controllerAssetHandle)
    self.controllerAssetHandle = nil
  end
  if self.avatarCtrl then
    AzurWorld.avatarMgr:ReleaseAvatarController(self.avatarCtrl)
    self.avatarCtrl = nil
  end
end

return this
