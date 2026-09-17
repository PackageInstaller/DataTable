local this = class("weaponStore", G_BaseStore)
this.event = {
  refreshWeapon = "weaponStore_refreshWeapon"
}
this:importPartialClass(require(L_R.store .. "weapon.weaponState"))
this:importPartialClass(require(L_R.store .. "weapon.weaponAction"))
return this
