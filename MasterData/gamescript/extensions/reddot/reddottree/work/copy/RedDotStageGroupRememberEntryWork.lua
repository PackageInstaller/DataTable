local RedDotStageGroupRememberEntryWork, Super = System.NewPoolClass("RedDotStageGroupRememberEntryWork", RedDotSingleFlow)

function RedDotStageGroupRememberEntryWork:ctor()
  Super.ctor(self, "溯梦模式红点")
end

function RedDotStageGroupRememberEntryWork:Execute()
  if StoryReviewModel.Instance:IsExistMainCopyReviewStoryRedNew() then
    return RedDotDefine.RedDotType.New
  end
  return false
end

return RedDotStageGroupRememberEntryWork
