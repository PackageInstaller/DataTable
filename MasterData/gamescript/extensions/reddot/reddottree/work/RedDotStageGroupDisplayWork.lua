local RedDotStageGroupDisplayWork, Super = System.NewPoolClass("RedDotStageGroupDisplayWork", RedDotSingleFlow)

function RedDotStageGroupDisplayWork:ctor(stageGroupTidList)
  Super.ctor(self, "关卡组首次开启红点")
  self.stageGroupTidList = stageGroupTidList or {}
end

function RedDotStageGroupDisplayWork:Execute()
  for _, stageGroupTid in ipairs(self.stageGroupTidList) do
    if not CopyDataUtils.IsInDisplayTime(stageGroupTid) then
    else
      local rst = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.NewStageGroupUnlock, {stageGroupTid})
      if rst then
        return RedDotDefine.OldRedAttrType2RedDotTypeDict[rst]
      end
    end
  end
  return false
end

return RedDotStageGroupDisplayWork
