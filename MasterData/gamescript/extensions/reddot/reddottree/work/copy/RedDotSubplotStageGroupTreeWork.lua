local RedDotSubplotStageGroupTreeWork, Super = System.NewPoolClass("RedDotSubplotStageGroupTreeWork", RedDotSequenceFlow)

function RedDotSubplotStageGroupTreeWork:ctor(args)
  Super.ctor(self, "支线关卡组红点")
  self.stageGroupTid = args.stageGroupTid
end

function RedDotSubplotStageGroupTreeWork:Execute()
  if not SubplotRedUtils.CheckGroupRedValid(self.stageGroupTid) then
    return false
  end
  do return Super.Execute end
  return Super.Execute, self
end

return RedDotSubplotStageGroupTreeWork
