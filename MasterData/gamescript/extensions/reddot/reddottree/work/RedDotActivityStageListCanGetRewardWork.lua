local RedDotActivityStageListCanGetRewardWork, Super = System.NewPoolClass("RedDotActivityStageListCanGetRewardWork", RedDotSingleFlow)

function RedDotActivityStageListCanGetRewardWork:ctor(activityTid, stageTidList)
  Super.ctor(self, "活动关卡列表处于可领取状态")
  self.activityTid = activityTid
  self.stageTidList = stageTidList or {}
end

function RedDotActivityStageListCanGetRewardWork:Execute()
  local activityData = ActivityManager.Instance:GetActivityData(self.activityTid)
  local prizeStateList = activityData and activityData.stageList
  if not prizeStateList then
    return false
  end
  local listToCheck = self.stageTidList
  if not table.next(listToCheck) then
    listToCheck = {}
    for stageTid in pairs(prizeStateList) do
      listToCheck[#listToCheck + 1] = stageTid
    end
  end
  for _, stageTid in ipairs(listToCheck) do
    if prizeStateList[stageTid] == CommonDefine.CommonState.GainPrize then
      return RedDotDefine.RedDotType.Red
    end
  end
  return false
end

return RedDotActivityStageListCanGetRewardWork
