local RedDotRecallEntryWork, Super = System.NewPoolClass("RedDotRecallEntryWork", RedDotSingleFlow)

function RedDotRecallEntryWork:ctor()
  Super.ctor(self, "记忆回响入口红点")
end

function RedDotRecallEntryWork:Execute()
  local permanentActivityTidList = ActivityDataUtils.GetShowingPermanentActivityTidList()
  for _, permanentActivityTid in ipairs(permanentActivityTidList) do
    local activityType = ActivityCfgUtils.GetCfgField("ActivityType", permanentActivityTid)
    if activityType == ActivityDefine.ActivityType.RailWayActivity and RedPointDataUtils.IsRailWayEntryRed() then
      return RedDotDefine.RedDotType.Red
    end
  end
  return false
end

return RedDotRecallEntryWork
