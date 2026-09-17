local this = class("starGiftStore", G_BaseStore)
this:importPartialClass(require(L_R.store .. "starGift.starGiftState"))
this:importPartialClass(require(L_R.store .. "starGift.starGiftAction"))

function this:ctor()
  this.super.ctor(self)
end

return this
