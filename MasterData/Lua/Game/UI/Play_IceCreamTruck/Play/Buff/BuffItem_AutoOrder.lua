local BuffItemBase = require("Game.UI.Play_IceCreamTruck.Play.Buff.BuffItemBase")
local BuffItem_AutoOrder = class("BuffItem_AutoOrder", BuffItemBase)

function BuffItem_AutoOrder:Init(cfg)
  BuffItemBase.Init(self, cfg)
  self.nBuffType = GameEnum.IceBuffEffect.Order
end

function BuffItem_AutoOrder:Apply(ctx)
  ctx.setAutoOrderMode(true)
end

function BuffItem_AutoOrder:Revoke(ctx)
  ctx.setAutoOrderMode(false)
end

return BuffItem_AutoOrder
