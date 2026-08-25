local RedDotStageGroupTreeWork, Super = System.NewPoolClass("RedDotStageGroupTreeWork", RedDotSequenceFlow)

function RedDotStageGroupTreeWork:ctor(args)
  Super.ctor(self, "关卡组")
  self.stageGroupTid = args.stageGroupTid
end

function RedDotStageGroupTreeWork:Execute()
  if not MainCopyDataUtils.IsStageGroupUnlock(self.stageGroupTid) then
    return false
  end
  do return Super.Execute end
  return Super.Execute, self
end

return RedDotStageGroupTreeWork
