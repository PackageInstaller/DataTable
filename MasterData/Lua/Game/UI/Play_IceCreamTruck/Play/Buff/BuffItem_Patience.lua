local BuffItemBase = require("Game.UI.Play_IceCreamTruck.Play.Buff.BuffItemBase")
local BuffItem_Patience = class("BuffItem_Patience", BuffItemBase)

function BuffItem_Patience:Init(cfg)
  BuffItemBase.Init(self, cfg)
  self.nBuffType = GameEnum.IceBuffEffect.Patience
end

function BuffItem_Patience:Apply(ctx)
  ctx.resetCustomerPatience()
  ctx.freezeCustomerPatience(true)
end

function BuffItem_Patience:Revoke(ctx)
  ctx.freezeCustomerPatience(false)
end

return BuffItem_Patience
