local RedDotCopyConfessionPageEntryWork, Super = System.NewPoolClass("RedDotCopyConfessionPageEntryWork", RedDotSingleFlow)
local FeatureId = CommonDefine.FeatureId

function RedDotCopyConfessionPageEntryWork:ctor()
  Super.ctor(self, "关卡主界面繁衍狂热页签红点")
end

function RedDotCopyConfessionPageEntryWork:Execute()
  local oldRst = RedPointDataUtils.IsFeatureFirstOpen(FeatureId.ConfessionEvent)
  if oldRst then
    return RedDotDefine.OldRedAttrType2RedDotTypeDict[oldRst] or RedDotDefine.RedDotType.New
  end
  return false
end

return RedDotCopyConfessionPageEntryWork
