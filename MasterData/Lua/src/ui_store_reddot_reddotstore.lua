local this = class("reddotStore", G_BaseStore)
local C_RedDotStore = CS.Lens.Gameplay.UI.RedDotStore
this:importPartialClass(require(L_R.store .. "reddot.reddotAction"))
this.event = {
  reddotUpdate = "reddotUpdate",
  soulessenceUpdate = "soulessenceUpdate",
  refreshAccessoryList = "refreshAccessoryList",
  refreshBag = "refreshBag"
}
this.serverDotDef = {
  Mail = 1,
  WorldExplore = 2,
  AreaNew = 3,
  AreaAnim = 4,
  DomainNew = 5,
  DomainAnim = 6,
  DailyReward = 7
}

function this:init()
  this.super.init(self)
end

function this:hasDot(id, subId)
  return C_RedDotStore.GetStore():HasDot(id, subId)
end

function this:onSoulessenceChange()
  self:call(self.event.soulessenceUpdate)
end

function this:onAccessoryChange()
  self:call(self.event.refreshAccessoryList)
end

function this:onBagChange()
  self:call(self.event.refreshBag)
end

function this:onRedDotChange()
  self:call(self.event.reddotUpdate)
end

return this
