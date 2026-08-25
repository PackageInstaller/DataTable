local RedDotCopyLinkageActivityPageEntryWork, Super = System.NewPoolClass("RedDotCopyLinkageActivityPageEntryWork", RedDotSequenceFlow)
local FeatureId = CommonDefine.FeatureId

function RedDotCopyLinkageActivityPageEntryWork:ctor()
  Super.ctor(self, "关卡主界面联动活动页签红点")
end

function RedDotCopyLinkageActivityPageEntryWork:Execute()
  local firstOpenRst = RedPointDataUtils.IsFeatureFirstOpen(FeatureId.SpecialSubplotTab)
  if firstOpenRst then
    return RedDotDefine.OldRedAttrType2RedDotTypeDict[firstOpenRst] or RedDotDefine.RedDotType.New
  end
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.SpecialSubplotTab, PlayerDataUtils.GetFeatureMainTypeKey())
  if not unlocked then
    return false
  end
  do return Super.Execute end
  return Super.Execute, self
end

return RedDotCopyLinkageActivityPageEntryWork
