local RedDotStageNewTreeWork, Super = System.NewPoolClass("RedDotStageNewTreeWork", RedDotSingleFlow)

function RedDotStageNewTreeWork:ctor(args)
  Super.ctor(self, "新关卡")
  self.stageTid = args.stageTid
end

function RedDotStageNewTreeWork:Execute()
  if not CopyDataUtils.CheckStageIsUnlocked(self.stageTid) then
    return false
  end
  do return self.GetServerRedStatus, self, RedPointDataUtils.RedType.NewStageUnlock end
  return self.GetServerRedStatus, self, RedPointDataUtils.RedType.NewStageUnlock, {
    self.stageTid
  }, self.stageTid
end

return RedDotStageNewTreeWork
