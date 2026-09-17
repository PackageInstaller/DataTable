local this = class("controlStore", G_BaseStore)
this.event = {toggleType = "toggleType"}
this:importPartialClass(require(L_R.store .. "control.controlState"))
this:importPartialClass(require(L_R.store .. "control.controlAction"))

function this:ctor()
  this.super.ctor(self)
end

function this:toggleControlBlock(type)
  self:call(self.event.toggleType, type)
end

return this
