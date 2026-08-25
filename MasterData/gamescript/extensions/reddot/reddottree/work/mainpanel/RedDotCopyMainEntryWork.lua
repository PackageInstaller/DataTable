local RedDotCopyMainEntryWork, Super = System.NewPoolClass("RedDotCopyMainEntryWork", RedDotSequenceFlow)

function RedDotCopyMainEntryWork:ctor()
  Super.ctor(self, "主线和支线入口红点")
end

function RedDotCopyMainEntryWork:Execute()
  if StoryReviewModel.Instance:IsExistMainCopyReviewStoryRedNew() then
    return RedDotDefine.RedDotType.New
  end
  do return Super.Execute end
  return Super.Execute, self
end

return RedDotCopyMainEntryWork
