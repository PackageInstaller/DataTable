local cls = class("localStore", G_BaseStore)
local tag = cls:getName()
cls:importPartialClass(require("ui.store.local.localState"))
cls.EventKey = {}
return cls
