local this = class("placePointStore", G_BaseStore)
this.event = {
  CSProtoPlaceSync = "CSProtoPlaceSync",
  CSProtoPlaceGet = "CSProtoPlaceGet",
  CSProtoPlaceTake = "CSProtoPlaceTake"
}
this:importPartialClass(require(L_R.store .. "placePoint.placePointState"))
this:importPartialClass(require(L_R.store .. "placePoint.placePointAction"))
return this
