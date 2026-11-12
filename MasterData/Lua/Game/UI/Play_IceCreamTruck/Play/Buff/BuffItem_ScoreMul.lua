local BuffItemBase = require("Game.UI.Play_IceCreamTruck.Play.Buff.BuffItemBase")
local BuffItem_ScoreMul = class("BuffItem_ScoreMul", BuffItemBase)

function BuffItem_ScoreMul:Init(cfg)
  BuffItemBase.Init(self, cfg)
  self.nBuffType = GameEnum.IceBuffEffect.Score
  self.fMul = cfg and cfg.Param and cfg.Param[2] or 2
  if self.fMul <= 0 then
    self.fMul = 1
  end
  self._fPrev = 1
end

function BuffItem_ScoreMul:Apply(ctx)
  self._fPrev = ctx.scoreCalc:GetBuffMultiplier() or 1
  ctx.scoreCalc:SetBuffMultiplier(self._fPrev * self.fMul)
end

function BuffItem_ScoreMul:Revoke(ctx)
  ctx.scoreCalc:SetBuffMultiplier(self._fPrev or 1)
end

return BuffItem_ScoreMul
