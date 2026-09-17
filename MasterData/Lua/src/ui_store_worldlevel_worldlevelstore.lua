local this = class("worldLevelStore", G_BaseStore)
this.event = {
  syncWorldLevel = "syncWorldLevel",
  upWorldLevel = "upWorldLevel",
  animWorldLevel = "animWorldLevel"
}
this:importPartialClass(require(L_R.store .. "worldLevel.worldLevelState"))
this:importPartialClass(require(L_R.store .. "worldLevel.worldLevelAction"))

function this:setNeedShowLevel()
  self.data.needShowLevel = false
end

return this
