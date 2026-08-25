local RedDotStageGroupSvrWork, Super = System.NewPoolClass("RedDotStageGroupSvrWork", RedDotSingleFlow)

function RedDotStageGroupSvrWork:ctor(stageGroupTidList)
  Super.ctor(self, "关卡组服务器红点")
  self.stageGroupTidList = stageGroupTidList or {}
end

function RedDotStageGroupSvrWork:Execute()
  for _, stageGroupTid in ipairs(self.stageGroupTidList) do
    local redKey = PlayerDataUtils.GetFeatureByKey(stageGroupTid)
    if not redKey or not stageGroupTid then
    else
      local rst = RedPointDataUtils.GetRedPointState(redKey, {stageGroupTid})
      if rst then
        return RedDotDefine.OldRedAttrType2RedDotTypeDict[rst]
      end
    end
  end
  return false
end

return RedDotStageGroupSvrWork
