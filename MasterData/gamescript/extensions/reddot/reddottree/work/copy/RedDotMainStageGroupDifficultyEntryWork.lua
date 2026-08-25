local RedDotMainStageGroupDifficultyEntryWork, Super = System.NewPoolClass("RedDotMainStageGroupDifficultyEntryWork", RedDotSequenceFlow)

function RedDotMainStageGroupDifficultyEntryWork:ctor(args)
  Super.ctor(self, "主线章节难度红点")
end

function RedDotMainStageGroupDifficultyEntryWork:Execute()
  do return Super.Execute end
  return Super.Execute, self
end

return RedDotMainStageGroupDifficultyEntryWork
