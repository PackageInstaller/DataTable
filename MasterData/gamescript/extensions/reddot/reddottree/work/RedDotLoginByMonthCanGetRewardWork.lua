local RedDotLoginByMonthCanGetRewardWork, Super = System.NewClass("RedDotLoginByMonthCanGetRewardWork", RedDotSingleFlow)

function RedDotLoginByMonthCanGetRewardWork:ctor(activityTid)
  Super.ctor(self, "月签到活动可领取奖励红点")
  self.activityTid = activityTid
end

function RedDotLoginByMonthCanGetRewardWork:Execute()
  local activityData = ActivityManager.Instance:GetActivityData(self.activityTid)
  if not (activityData and activityData.prize) or not activityData.base then
    return false
  end
  if activityData.base.state ~= ActivityDefine.ActivityState.Running then
    return false
  end
  for _, prizeState in ipairs(activityData.prize) do
    if prizeState == CommonDefine.CommonState.GainPrize then
      return RedDotDefine.RedDotType.Red
    end
  end
  return false
end

return RedDotLoginByMonthCanGetRewardWork
