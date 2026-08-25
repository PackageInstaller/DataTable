local RedDotActivityRedValidCheckWork, Super = System.NewPoolClass("RedDotActivityRedValidCheckWork", RedDotSingleFlow)

function RedDotActivityRedValidCheckWork:ctor(activityTid)
  Super.ctor(self, "客户端红点合理性检测")
  self.activityTid = activityTid
end

function RedDotActivityRedValidCheckWork:Execute()
  local activityData = ActivityManager.Instance:GetActivityData(self.activityTid)
  if not ActivityRedUtils.CheckRedValid(activityData) then
    return RedDotDefine.RedDotType.None
  end
  return false
end

return RedDotActivityRedValidCheckWork
