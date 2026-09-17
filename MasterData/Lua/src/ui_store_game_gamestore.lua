local this = class("gameStore", G_BaseStore)
this.event = {
  refreshDayChange = "gameStore_refreshDayChange",
  enterGame = "gameStore_enterGame",
  creatPlayerModOver = "gameStore_creatPlayerModOver",
  nDayActivityRefresh = "gameStore_nDayActivityRefresh",
  nDayActivityRefreshAnimation = "gameStore_nDayActivityRefreshAnimation",
  nDayActivityReqRewardCloseCallBack = "gameStore_nDayActivityReqRewardCloseCallBack"
}
this:importPartialClass(require(L_R.store .. "game.gameState"))
this:importPartialClass(require(L_R.store .. "game.gameAction"))

function this:dealEnterGame()
  self.data.isEntered = true
  self:call(self.event.enterGame)
end

function this:isEntered()
  return self.data.isEntered
end

return this
