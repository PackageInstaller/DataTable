local this = class("satietyStore", G_BaseStore)
this.event = {
  satiety_addPet = "satiety_addPet",
  satiety_value_refresh = "satiety_value_refresh"
}
this:importPartialClass(require(L_R.store .. "satiety.satietyState"))
this:importPartialClass(require(L_R.store .. "satiety.satietyAction"))
this:importPartialClass(require(L_R.store .. "satiety.satietyServer"))
return this
