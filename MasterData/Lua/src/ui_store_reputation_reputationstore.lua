local this = class("reputationStore", G_BaseStore)
this.event = {
  reputationChange = "reputation_change"
}
this:importPartialClass(require(L_R.store .. "reputation.reputationState"))
this:importPartialClass(require(L_R.store .. "reputation.reputationAction"))

function this:ctor()
  this.super.ctor(self)
end

function this.removeItem(id)
  self.data.forceDic[id] = nil
end

return this
