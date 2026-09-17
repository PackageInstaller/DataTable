local this = class("bigWorldBattleStore", G_BaseStore)
this:importPartialClass(require(L_R.store .. "bigWorldBattle.bigWorldBattleState"))

function this:ctor()
  this.super.ctor(self)
end

return this
