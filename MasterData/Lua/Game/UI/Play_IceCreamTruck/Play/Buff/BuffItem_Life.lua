local BuffItemBase = require("Game.UI.Play_IceCreamTruck.Play.Buff.BuffItemBase")
local BuffItem_Life = class("BuffItem_Life", BuffItemBase)

function BuffItem_Life:Init(cfg)
  BuffItemBase.Init(self, cfg)
  self.nBuffType = GameEnum.IceBuffEffect.HP
  self.nHeal = cfg and cfg.Param and cfg.Param[1] or 1
  self.nDuration = 0
end

function BuffItem_Life:Apply(ctx)
  ctx.addHp(self.nHeal)
end

return BuffItem_Life
