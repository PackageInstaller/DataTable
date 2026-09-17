local this = class("tutorialStore", G_BaseStore)
this.event = {}
this:importPartialClass(require(L_R.store .. "tutorial.tutorialState"))
this:importPartialClass(require(L_R.store .. "tutorial.tutorialAction"))
return this
