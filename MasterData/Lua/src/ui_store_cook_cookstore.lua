local this = class("cookStore", G_BaseStore)
this.event = {}
this:importPartialClass(require(L_R.store .. "cook.cookState"))
this:importPartialClass(require(L_R.store .. "cook.cookAction"))
return this
