local this = class("entityManager", G_EventManagerBase)
this.event = {
  destroyEntity = "destroyEntity",
  destroyAllEntity = "destroyAllEntity",
  triggerStack = "triggerStack"
}
table.merge(this, require(L_R.world.coreMgr .. "entity.entityManager_res"))
table.merge(this, require(L_R.world.coreMgr .. "entity.entityManager_hero"))
table.merge(this, require(L_R.world.coreMgr .. "entity.entityManager_photo"))

function this:ctor()
  this.super.ctor(self)
end

function this:generatePreviewPet(petGuid, go, petData, needLoadedAnimaNameList, callback, callback1, entranceType)
  local entity = require(L_EcsConst.aliveType.previewPet).new(L_EcsConst.aliveType.previewPet)
  entity:initPreview(petGuid, go, petData, needLoadedAnimaNameList, callback, callback1, entranceType)
  return entity
end

function this:generatePreviewPetAsync(petGuid, go, petData, callback, needLoadedAnimaNameList, entranceType)
  local entity = require(L_EcsConst.aliveType.previewPet).new(L_EcsConst.aliveType.previewPet)
  entity:initPreviewAsync(petGuid, go, petData, function()
    if callback then
      callback(entity)
    end
  end, needLoadedAnimaNameList, entranceType)
end

return this
