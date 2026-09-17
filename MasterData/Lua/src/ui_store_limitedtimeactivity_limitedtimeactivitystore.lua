local this = class("limitedTimeActivityStore", G_BaseStore)
this.event = {}
this:importPartialClass(require(L_R.store .. "limitedTimeActivity.limitedTimeActivityState"))
this:importPartialClass(require(L_R.store .. "limitedTimeActivity.limitedTimeActivityAction"))

function this:ctor()
  this.super.ctor(self)
end

return this
