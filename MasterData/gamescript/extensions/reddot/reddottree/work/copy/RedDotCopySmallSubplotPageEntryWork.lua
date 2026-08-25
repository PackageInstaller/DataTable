local RedDotCopySmallSubplotPageEntryWork, Super = System.NewPoolClass("RedDotCopySmallSubplotPageEntryWork", RedDotSequenceFlow)

function RedDotCopySmallSubplotPageEntryWork:ctor()
  Super.ctor(self, "关卡主界面意识浅游页签红点")
end

function RedDotCopySmallSubplotPageEntryWork:Execute()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.SmallSubplotTab, PlayerDataUtils.GetFeatureMainTypeKey())
  if not unlocked then
    return false
  end
  do return Super.Execute end
  return Super.Execute, self
end

return RedDotCopySmallSubplotPageEntryWork
