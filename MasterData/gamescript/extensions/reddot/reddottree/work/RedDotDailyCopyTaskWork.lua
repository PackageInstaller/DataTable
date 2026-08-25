local RedDotDailyCopyTaskWork, Super = System.NewPoolClass("RedDotDailyCopyTaskWork", RedDotSingleFlow)

function RedDotDailyCopyTaskWork:ctor(stageGroupTid)
  Super.ctor(self, "每日副本任务奖励")
  self.stageGroupTid = stageGroupTid
end

function RedDotDailyCopyTaskWork:Execute()
  if DailyChallengeDataUtils.IsHaveAchievementReward(self.stageGroupTid) then
    return RedDotDefine.RedDotType.Red
  end
  return false
end

return RedDotDailyCopyTaskWork
