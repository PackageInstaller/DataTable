local this = class("ecsConst")
this.alive = require("modules.common.ecs.alive")
this.component = require("modules.common.ecs.component")
this.triggerName = {
  onUpdate = "onUpdate",
  onDestroy = "onDestroy",
  onRemove = "onRemove",
  onBindGameObject = "onBindGameObject",
  onReleaseGameObject = "onReleaseGameObject"
}
this.aliveType = {
  default = L_R.world.core .. "entity.common.entity",
  preview = L_R.world.core .. "entity.uimodel.previewEntity",
  previewHero = L_R.world.core .. "entity.uimodel.previewHeroEntity",
  previewPet = L_R.world.core .. "entity.uimodel.previewPetEntity",
  previewNpc = L_R.world.core .. "entity.uimodel.previewNpcEntity",
  photoPet = L_R.world.core .. "entity.photo.petPhotoEntity",
  uiHero = L_R.world.core .. "entity.uimodel.uiHeroEntity"
}
this.componentType = {
  animator = L_R.world.core .. "entity.common.component.animatorComponent",
  state = L_R.world.core .. "entity.common.component.stateComponent",
  modelControl = L_R.world.core .. "entity.common.component.modelControlComponent",
  ikComponent = L_R.world.core .. "entity.common.component.lookAtIKUIComponent"
}
return this
