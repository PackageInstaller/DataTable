require("abstract_bhv_finite_time")

function CustomNodeConfigStatic.Check_PrintLogBhv(cfg)
  if cfg.LogStr then
    return true
  end
  return false
end

CustomNodeConfigStatic.AddChecker("PrintLogBhv", CustomNodeConfigStatic.Check_PrintLogBhv)
_class("PrintLogBhv", HasBeginBhv)
PrintLogBhv = PrintLogBhv

function PrintLogBhv:Constructor()
  self.logStr = 0
end

function PrintLogBhv:InitializeNode(cfg, context)
  PrintLogBhv.super.InitializeNode(self, cfg, context)
  self.logStr = cfg.LogStr
end

function PrintLogBhv:OnBegin()
  Log.debug(self.logStr)
end
