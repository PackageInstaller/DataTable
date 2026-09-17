local this = class("dungeonStore", G_BaseStore)
this.event = {
  syncCurDungeon = "dungeonStore_syncCurDungeon",
  syncStaminaChest = "dungeonStore_syncStaminaChest"
}
this:importPartialClass(require(L_R.store .. "dungeon.dungeonState"))
this:importPartialClass(require(L_R.store .. "dungeon.dungeonAction"))

function this:ctor()
  this.super.ctor(self)
end

function this:resetCurDungeon()
end

return this
