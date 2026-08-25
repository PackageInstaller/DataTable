local DungeonUtils = {}

function DungeonUtils.IsShowStageLevelLimit(stageType)
  local typeList = DT.GetOriginalConstant("PlayerLevelStageGroup")
  for _, type in ipairs(typeList) do
    if stageType == type then
      return true
    end
  end
  return false
end

function DungeonUtils.GetWeekBossRefreshTimeDesc()
  local refreshTime = CopyDataUtils.GetWeekBossRefreshTime()
  local leftTime = refreshTime - TimeUtils.GetServerTime()
  local days, hours = TimeUtils.WeekBossRefresh(leftTime)
  do return LT.Textf, "UI_WeekBoss_Refresh", days end
  return LT.Textf, "UI_WeekBoss_Refresh", days, hours
end

return DungeonUtils
