local BuffItemBase = require("Game.UI.Play_IceCreamTruck.Play.Buff.BuffItemBase")
local BuffItem_TimeSlow = class("BuffItem_TimeSlow", BuffItemBase)

function BuffItem_TimeSlow:Init(cfg)
  BuffItemBase.Init(self, cfg)
  self.nBuffType = GameEnum.IceBuffEffect.Time
  self.fFactor = cfg and cfg.Param and cfg.Param[2] or 2
  if self.fFactor <= 0 then
    self.fFactor = 1
  end
  self._fPrevScale = 1
end

function BuffItem_TimeSlow:Apply(ctx)
  self._fPrevScale = ctx.getSpeedScale()
  ctx.setSpeedScale(self._fPrevScale / self.fFactor)
end

function BuffItem_TimeSlow:Revoke(ctx)
  ctx.setSpeedScale(self._fPrevScale)
end

return BuffItem_TimeSlow
