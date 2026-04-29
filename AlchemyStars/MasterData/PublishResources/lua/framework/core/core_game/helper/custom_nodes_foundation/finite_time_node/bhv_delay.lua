require("abstract_bhv_finite_time")

function CustomNodeConfigStatic.Check_DelayBhv(cfg)
  if cfg.TimeLen then
    return true
  end
  return false
end

CustomNodeConfigStatic.AddChecker("DelayBhv", CustomNodeConfigStatic.Check_DelayBhv)
_class("DelayBhv", FiniteTimeBhv)
DelayBhv = DelayBhv

function DelayBhv:Constructor()
  self.delayTime = 0
end

function DelayBhv:InitializeNode(cfg, context)
  DelayBhv.super.InitializeNode(self, cfg, context)
  self.delayTime = self:Parse(cfg.TimeLen)
  self:InitDuration(self.delayTime)
end

function DelayBhv:Reset()
  DelayBhv.super.Reset(self)
  self:InitDuration(self.delayTime)
end
