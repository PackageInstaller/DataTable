local RedDotActivityFinishedWork, Super = System.NewPoolClass("RedDotActivityFinishedWork", RedDotSingleFlow)

function RedDotActivityFinishedWork:ctor(activityTid)
  Super.ctor(self, "活动已结束")
  self.activityTid = activityTid
end

function RedDotActivityFinishedWork:Execute()
  if ActivityManager.Instance:IsActivityFinishedByTid(self.activityTid) then
    return RedDotDefine.RedDotType.None
  end
  return false
end

return RedDotActivityFinishedWork
