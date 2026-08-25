local RedDotCopyLargeSubplotPageEntryWork, Super = System.NewPoolClass("RedDotCopyLargeSubplotPageEntryWork", RedDotSequenceFlow)

function RedDotCopyLargeSubplotPageEntryWork:ctor()
  Super.ctor(self, "关卡主界面特遣记录页签红点")
end

function RedDotCopyLargeSubplotPageEntryWork:Execute()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.LargeSubplotTab, PlayerDataUtils.GetFeatureMainTypeKey())
  if not unlocked then
    return false
  end
  do return Super.Execute end
  return Super.Execute, self
end

return RedDotCopyLargeSubplotPageEntryWork
