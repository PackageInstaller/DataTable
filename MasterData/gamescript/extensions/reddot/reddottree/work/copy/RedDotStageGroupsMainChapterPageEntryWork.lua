local RedDotStageGroupsMainChapterPageEntryWork, Super = System.NewPoolClass("RedDotStageGroupsMainChapterPageEntryWork", RedDotSequenceFlow)

function RedDotStageGroupsMainChapterPageEntryWork:ctor()
  Super.ctor(self, "关卡主界面主线页签红点")
end

function RedDotStageGroupsMainChapterPageEntryWork:Execute()
  if StoryReviewModel.Instance:IsExistMainCopyReviewStoryRedNew() then
    return RedDotDefine.RedDotType.New
  end
  do return Super.Execute end
  return Super.Execute, self
end

return RedDotStageGroupsMainChapterPageEntryWork
