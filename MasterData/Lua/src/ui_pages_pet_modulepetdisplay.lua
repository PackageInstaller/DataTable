local module = class("modulePetDisplay", G_UIModuleBase)
local petTpl = L_GameTpl:getPetTpl()

function module.bind()
  return {
    modEuler = Unity.Vector3.zero,
    petModule = "",
    modScale = Unity.Vector3.one,
    modOffest = Unity.Vector3(-0.2, 0.1, 0)
  }
end

function module.methods()
  return {
    dragBegin = function(self, pos)
      self.deltaX = 0
      self.bind.modEuler = Unity.Vector3(0, self.bind.modEuler.y + self.deltaX, 0)
      self.oldDragX = pos.x
    end,
    drag = function(self, pos)
      self.deltaX = (self.oldDragX - pos.x) * 0.3
      self.bind.modEuler = Unity.Vector3(0, self.bind.modEuler.y + self.deltaX, 0)
      self.oldDragX = pos.x
    end,
    dragEnd = function(self, pos)
      self.deltaX = (self.oldDragX - pos.x) * 0.3
      self.bind.modEuler = Unity.Vector3(0, self.bind.modEuler.y + self.deltaX, 0)
      self.oldDragX = pos.x
    end
  }
end

function module:created(...)
  module.super.created(self, ...)
end

function module:open()
  C_UISceneManager.SetSceneVisible()
  if self.bindComponents.virCamera then
    self.bindComponents.virCamera.enabled = true
  end
end

function module:close()
  if self.bindComponents.virCamera then
    self.bindComponents.virCamera.enabled = false
  end
end

function module:show()
  self.bindComponents.Pet.parent.gameObject:ActiveTrans(true)
end

function module:hide()
  self.bindComponents.Pet.parent.gameObject:ActiveTrans(false)
end

function module:infoRefresh(pet, isScenePet)
  local tpl = petTpl:getTplById(pet.id)
  local _petTpl = petTpl:getTplById(pet.id)
  local unitID = petTpl:getUnitID(_petTpl)
  local all_stage_scale = 1
  if isScenePet ~= nil and isScenePet == true then
    all_stage_scale = petTpl:getUnitScale(tpl)
  end
  if unitID then
    local unitTpl = L_GameTpl:getUnitTpl()
    local unit = unitTpl:getTplById(unitID)
    local path = unitTpl:getModel(unit, 1, pet:isSpecialPet())
    local worldScale = unitTpl:getModelScale(unit)
    local scale = all_stage_scale / 10000
    self.bind.modScale = Unity.Vector3(scale * worldScale, scale * worldScale, scale * worldScale)
    self.bind.petModule = path
    self.bind.modEuler = Unity.Vector3.zero
    local position
    position = petTpl:getUnitPosition(tpl)
    self.bind.modOffest = Unity.Vector3(position[1], position[2], position[3])
    self.bind.modEuler = Unity.Vector3(0, -45, 0)
    local biologyData = L_CommonUtil.getModComponent(typeof(C_BiologyAvatar), self.bindComponents.Pet.prefab)
    if biologyData then
      biologyData:SetTheoryShadowLodLv(0)
      biologyData:UsePreviewLodLevelByInt()
    end
    local animator = L_CommonUtil.getModComponent(typeof(C_PlayableAnimator), self.bindComponents.Pet.prefab)
    animator.cullingMode = C_AnimatorCullingMode.AlwaysAnimate
    animator.updateMode = C_PlayableAnimator.UpdateMode.LateUpdate
    if self.controllerAssetHandle then
      C_LuaUtility.ReleasePlayableController(self.controllerAssetHandle)
    end
    local needAnimaList = {"Idle"}
    local loadNames = CS.System.Array.CreateInstance(typeof(CS.System.String), #needAnimaList)
    for i = 1, #needAnimaList do
      loadNames[i - 1] = needAnimaList[i]
    end
    self.controllerAssetHandle = C_LuaUtility.LoadPlayableController(unitTpl:getAnimatorConfig(unit, L_Const.avatarAnimatorConfigIndex.uiPreview), loadNames)
    animator.defaultAnimatorController = self.controllerAssetHandle.config
    L_EntityManager:generatePreviewPet(pet.guid, self.bindComponents.Pet.prefab, pet, needAnimaList)
    animator:Play("Idle")
  end
end

function module:disableMod()
  self.bind.petModule = ""
  self.bind.modScale = Unity.Vector3(0, 0, 0)
end

function module:destroy()
  module.super.destroy(self)
  if self.controllerAssetHandle then
    C_LuaUtility.ReleasePlayableController(self.controllerAssetHandle)
    self.controllerAssetHandle = nil
  end
end

return module
