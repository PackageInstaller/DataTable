local this = class("worldMapLvStore", G_BaseStore)
this.event = {
  syncWorldMapLevel = "syncWorldMapLevel",
  refreshDeddot = "refreshDeddot"
}
this:importPartialClass(require(L_R.store .. "worldMapLv.worldMapLvState"))
this:importPartialClass(require(L_R.store .. "worldMapLv.worldMapLvAction"))
return this
