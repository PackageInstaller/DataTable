local this = class("previewNpcEntity", require(L_EcsConst.aliveType.preview))

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this:getUnitId()
  local unitId = self.entityId
  return unitId
end

function this:setAnimatorController(playableAnimator, animatorConfig, needLoadedAnimaNameList)
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
  local key = unitTpl:getAnimatorConfig(unit, L_Const.avatarAnimatorConfigIndex.uiPreview)
  self.controllerAssetHandle = C_LuaUtility.LoadPlayableController(key, loadNames)
  playableAnimator.defaultAnimatorController = self.controllerAssetHandle.config
end

function this:play(anim)
  self.playableAnimator:Play(anim)
end

function this:ChangeSkinPlayableAnimatorByAnimatorSuffix(animatorSuffix)
  local unitTpl = L_GameTpl:getUnitTpl()
  local unit = unitTpl:getTplById(self.unitId)
  local key = unitTpl:getAnimatorConfig(unit, L_Const.avatarAnimatorConfigIndex.uiPreview)
  local skinSuffix = string.format("_%s.asset", animatorSuffix)
  local skinKey = string.gsub(key, ".asset", skinSuffix)
  self.controllerAssetHandle = C_LuaUtility.LoadPlayableController(skinKey)
  self.playableAnimator.defaultAnimatorController = self.controllerAssetHandle.config
end

function this:getCurrentAnimatorStateInfo(index)
  local info = self.playableAnimator:GetCurrentAnimatorStateInfo(index)
  return info.name
end

function this:getCurrentAnimatorIsLooping(index)
  local info = self.playableAnimator:GetCurrentAnimatorStateInfo(index)
  return info.isLooping
end

function this:getCurrentAnimatorStateLength(index)
  local info = self.playableAnimator:GetCurrentAnimatorStateInfo(index)
  return info.length
end

function this:onDestroy()
  if self.controllerAssetHandle then
    C_LuaUtility.ReleasePlayableController(self.controllerAssetHandle)
    self.controllerAssetHandle = nil
  end
  this.super.onDestroy(self)
end

return this
