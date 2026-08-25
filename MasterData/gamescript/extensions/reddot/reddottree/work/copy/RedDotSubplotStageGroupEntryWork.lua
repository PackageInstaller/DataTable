local RedDotSubplotStageGroupEntryWork, Super = System.NewPoolClass("RedDotSubplotStageGroupEntryWork", RedDotSequenceFlow)

function RedDotSubplotStageGroupEntryWork:ctor(args)
  Super.ctor(self, "单个支线关卡组入口")
  self.stageGroupTid = args.stageGroupTid
end

function RedDotSubplotStageGroupEntryWork:Execute()
  if not SubplotRedUtils.CheckGroupRedValid(self.stageGroupTid) then
    return false
  end
  do return Super.Execute end
  return Super.Execute, self
end

return RedDotSubplotStageGroupEntryWork
