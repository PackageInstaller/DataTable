local this = class("collectionStore", G_BaseStore)
this.event = {
  refreshCollection = "collectionStore_refreshCollection",
  updateCollection = "collectionStore_updateCollection",
  refreshModuleHomeCenterBuildingManageReceiveAllDot = "refreshModuleHomeCenterBuildingManageReceiveAllDot"
}
this:importPartialClass(require(L_R.store .. "collection.collectionState"))
this:importPartialClass(require(L_R.store .. "collection.collectionAction"))
return this
