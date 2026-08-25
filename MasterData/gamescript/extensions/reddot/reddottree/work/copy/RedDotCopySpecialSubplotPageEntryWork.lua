local RedDotCopySpecialSubplotPageEntryWork, Super = System.NewPoolClass("RedDotCopySpecialSubplotPageEntryWork", RedDotSequenceFlow)

function RedDotCopySpecialSubplotPageEntryWork:ctor()
  Super.ctor(self, "关卡主界面异梦视界页签红点")
end

function RedDotCopySpecialSubplotPageEntryWork:Execute()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.SpecialSubplotTab, PlayerDataUtils.GetFeatureMainTypeKey())
  if not unlocked then
    return false
  end
  do return Super.Execute end
  return Super.Execute, self
end

return RedDotCopySpecialSubplotPageEntryWork
