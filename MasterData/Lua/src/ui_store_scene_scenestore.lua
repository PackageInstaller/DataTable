local this = class("sceneStore", G_BaseStore)
this.event = {
  refreshPoint = "refreshPoint"
}
this:importPartialClass(require(L_R.store .. "scene.sceneState"))
this:importPartialClass(require(L_R.store .. "scene.sceneAction"))
return this
