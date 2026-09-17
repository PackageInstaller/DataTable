local this = class("favorabilityStore", G_BaseStore)
this:importPartialClass(require(L_R.store .. "favorability.favorabilityState"))
this:importPartialClass(require(L_R.store .. "favorability.favorabilityAction"))
return this
