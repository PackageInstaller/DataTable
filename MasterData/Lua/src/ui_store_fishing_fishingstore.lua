local this = class("fishingStore", G_BaseStore)
this.event = {
  refreshFishingGear = "fishingStore_refreshFishingGear",
  refreshFishPoint = "fishingStore_refreshFishPoint"
}
this:importPartialClass(require(L_R.store .. "fishing.fishingState"))
this:importPartialClass(require(L_R.store .. "fishing.fishingAction"))

function this:resetFishFinish()
  self.data.fishFinish = require(L_R.store .. "fishing.data.fishFinish").new()
end

return this
