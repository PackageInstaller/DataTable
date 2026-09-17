local this = class("gameActStore", G_BaseStore)
this.event = {
  refreshGameAct = "refreshGameAct",
  refreshSignInInfo = "refreshSignInInfo",
  onDayChanged = "onDayChanged"
}
this.rewardStatus = {
  canNotGet = 0,
  canGet = 1,
  alreadyGot = 2
}
this:importPartialClass(require(L_R.store .. "gameAct.gameActState"))
this:importPartialClass(require(L_R.store .. "gameAct.gameActAction"))

function this:setDayChangedFlag(bool)
  self.data.dayChangedFlag = bool
  if bool == true then
    self:call(self.event.onDayChanged)
  end
end

function this:getSignInStatus()
  return self.data.signInStatus
end

function this:setBlockPageReward(bBlock)
  self.data.blockPageReward = bBlock
end

function this:getBlockPageReward()
  return self.data.blockPageReward
end

return this
