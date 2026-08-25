local RedDotStageGroupsMorimenChapterEntryWork, Super = System.NewPoolClass("RedDotStageGroupsMorimenChapterEntryWork", RedDotSequenceFlow)

function RedDotStageGroupsMorimenChapterEntryWork:ctor()
  Super.ctor(self, "忘却篇主线章节红点")
end

function RedDotStageGroupsMorimenChapterEntryWork:Execute()
  do return Super.Execute end
  return Super.Execute, self
end

return RedDotStageGroupsMorimenChapterEntryWork
