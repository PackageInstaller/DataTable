local RedDotStageGroupsStarsCameRightChapterEntryWork, Super = System.NewPoolClass("RedDotStageGroupsStarsCameRightChapterEntryWork", RedDotSequenceFlow)

function RedDotStageGroupsStarsCameRightChapterEntryWork:ctor()
  Super.ctor(self, "星辰篇主线章节红点")
end

function RedDotStageGroupsStarsCameRightChapterEntryWork:Execute()
  do return Super.Execute end
  return Super.Execute, self
end

return RedDotStageGroupsStarsCameRightChapterEntryWork
