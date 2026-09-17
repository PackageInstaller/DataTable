local this = class("otakuStore", G_BaseStore)
this.event = {
  furnitureUpdate = "furnitureUpdate"
}
this:importPartialClass(require(L_R.store .. "otaku.otakuState"))
this:importPartialClass(require(L_R.store .. "otaku.otakuAction"))
this:importPartialClass(require(L_R.store .. "otaku.otakuDataCls"))
return this
