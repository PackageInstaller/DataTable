local this = class("friendStore", G_BaseStore)
this.event = {
  refreshIdList = "friendStore_refreshIdList",
  refreshIdListByLocalPlayer = "friendStore_refreshIdListByLocalPlayer",
  refreshTipNoPlayerInfo = "friendStore_refreshTipNoPlayerInfo"
}
this:importPartialClass(require(L_R.store .. "friend.friendState"))
this:importPartialClass(require(L_R.store .. "friend.friendAction"))

function this:clearPlayerInfoList()
  self.data.baseInfoList = {}
end

function this:clearRecommandFriendList()
  self.data.recommandFriendList = {}
end

return this
