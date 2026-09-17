local this = class("homeStore", G_BaseStore)
this.event = {
  refreshBuildingBag = "refreshBuildingBag",
  syncWorldMapHomeItem = "syncWorldMapHomeItem",
  refreshBelt = "refreshBelt",
  syncHomeContentUnlock = "homeStore_syncHomeContentUnlock",
  refreshHomeInfo = "refreshHomeInfo",
  refreshHomePetInfo = "refreshHomePetInfo",
  refreshPetEatFinishList = "refreshPetEatFinishList",
  refreshModuleHomeCenterBuildingManageReceiveAllDot = "refreshModuleHomeCenterBuildingManageReceiveAllDot",
  syncRefreshWishLists = "syncRefreshWishLists",
  refreshBuildPetWorkState = "refreshBuildPetWorkState"
}

function this:ctor()
  this.super.ctor(self)
  
  function self.onHomeBuildSyncHandler()
    self:onHomeBuildSync()
  end
  
  C_HomeStoreEvent.instance:Listen(C_EHomeStoreEvent.HomeBuildSync, self.onHomeBuildSyncHandler)
end

function this:onHomeBuildSync()
  self:call(self.event.refreshModuleHomeCenterBuildingManageReceiveAllDot)
end

function this:onHomeWishlistsSync(wishlist, del_wishlist)
  self:call(self.event.syncRefreshWishLists)
end

this:importPartialClass(require(L_R.store .. "home.homeState"))
this:importPartialClass(require(L_R.store .. "home.homeAction"))
this.const_gridSize = 1
return this
