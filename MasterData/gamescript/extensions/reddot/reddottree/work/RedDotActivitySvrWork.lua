local RedDotActivitySvrWork, Super = System.NewPoolClass("RedDotActivitySvrWork", RedDotSingleFlow)

function RedDotActivitySvrWork:ctor(activityTidList)
  Super.ctor(self, "活动服务器红点")
  self.activityTidList = activityTidList
end

function RedDotActivitySvrWork:Execute()
  if not self.activityTidList or not table.next(self.activityTidList) then
    self.activityTidList = {}
    local activityDataList = ActivityManager.Instance:GetDisplayActivityList()
    for _, activityData in pairs(activityDataList) do
      table.insert(self.activityTidList, activityData.activityTid)
    end
  end
  for _, activityTid in pairs(self.activityTidList) do
    if ActivityRedUtils.CheckActiveDisplay(activityTid) and ActivityDataUtils.IsActivityOpen(activityTid) then
      local serverRedData = RedPointDataUtils.GetRedPointState(RedTypeDefine.RedType.ActivityServer, {activityTid})
      if serverRedData then
        return RedDotDefine.OldRedAttrType2RedDotTypeDict[serverRedData]
      end
    end
  end
  return false
end

return RedDotActivitySvrWork
