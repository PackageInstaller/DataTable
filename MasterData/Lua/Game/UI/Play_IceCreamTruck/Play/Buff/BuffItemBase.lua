local BuffItemBase = class("BuffItemBase")

function BuffItemBase:Init(cfg)
  self.cfg = cfg
  self.nBuffId = cfg and cfg.BuffId or 0
  self.nBuffType = cfg and cfg.BuffType or 0
  self.nDuration = cfg and cfg.Param and cfg.Param[1] or 0
end

function BuffItemBase:Apply(ctx)
end

function BuffItemBase:OnTick(ctx, dt)
end

function BuffItemBase:Revoke(ctx)
end

function BuffItemBase:GetType()
  return self.nBuffType
end

function BuffItemBase:GetBuffId()
  return self.nBuffId
end

function BuffItemBase:GetDuration()
  return self.nDuration or 0
end

return BuffItemBase
