local RedDotActivitySkinCanGetRewardWork, Super = System.NewPoolClass("RedDotActivitySkinCanGetRewardWork", RedDotSingleFlow)

function RedDotActivitySkinCanGetRewardWork:ctor(activityTid)
  Super.ctor(self, "皮肤活动任务处于可领取状态")
  self.activityTid = activityTid
end

function RedDotActivitySkinCanGetRewardWork:Execute()
  local skinTaskInfo = ActivityCfgUtils.GetActivitySkinTaskInfo(self.activityTid)
  if not skinTaskInfo then
    return false
  end
  if TaskDataUtils.IsCanGetRward(skinTaskInfo.skinTaskTid) then
    return RedDotDefine.RedDotType.Red
  end
  return false
end

return RedDotActivitySkinCanGetRewardWork
