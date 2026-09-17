local this = class("previewEntity", require(L_EcsConst.aliveType.default))
local CapsuleCollider = CS.UnityEngine.CapsuleCollider

function this:ctor(...)
  this.super.ctor(self, ...)
  self.lodLevel = -1
  self.entranceType = C_EEntityEntranceType.None
end

function this:initPreview(entityId, go, avatarData, animatorConfig, needLoadedAnimaNameList, entranceType)
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
  self:setAnimatorController(playableAnimator, animatorConfig, needLoadedAnimaNameList)
  self.playableAnimator = playableAnimator
  self:createCollider()
  if avatarData then
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
  end
end

function this:getDefaultLod()
  self.lodLevel = C_EntityManager.GetUIEntityLodLevelInt(self.entranceType)
end

function this:getDefaultPetLod()
  self.lodLevel = C_EntityManager.GetUIEntityLodLevelInt(self.entranceType)
end

function this:setAnimatorController(playableAnimator, animatorConfig, needLoadedAnimaNameList)
end

function this:createCollider()
  local childCollider = self.gameObject:GetComponentsInChildren(typeof(CapsuleCollider))
  for i = 0, childCollider.Length - 1 do
    if childCollider[i].transform ~= self.gameObject.transform then
      childCollider[i].enabled = false
    end
  end
  local unitTpl = L_GameTpl:getUnitTpl()
  local unit = unitTpl:getTplById(self.unitId)
  local colliderId = unitTpl:getColliderId(unit)
  local colliderTpl = L_GameTpl:getUnitColliderTpl()
  local colliderList = colliderTpl:getColliderList(colliderTpl:getTplById(colliderId))[1]
  local x = colliderList[1]
  local y = colliderList[2]
  local z = colliderList[3]
  local radius = colliderList[4]
  local height = colliderList[5]
  local collider = self.gameObject:PickComponent(typeof(CapsuleCollider))
  collider.center = L_Vector3.new(x, y, z)
  collider.radius = radius
  collider.height = height
end

function this:getUnitId()
  return 0
end

function this:setIk()
end

function this:getTarget()
  return self.target or nil
end

function this:updateAnimSpeed(animSpeed)
  if L_CommonUtil.isValid(self.playableAnimator) then
    self.playableAnimator.speed = animSpeed
  end
end

function this:onDestroy()
  this.super.onDestroy(self)
  if self.avatarCtrl then
    AzurWorld.avatarMgr:ReleaseAvatarController(self.avatarCtrl)
    self.avatarCtrl = nil
  end
  self.modelControl = nil
  self.playableAnimator = nil
  self.biologyData = nil
  self.entranceType = C_EEntityEntranceType.None
  self.lodLevel = -1
end

return this
