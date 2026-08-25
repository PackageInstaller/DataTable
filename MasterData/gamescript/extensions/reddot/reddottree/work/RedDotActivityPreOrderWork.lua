local RedDotActivityPreOrderWork, Super = System.NewPoolClass("RedDotActivityPreOrderWork", RedDotSingleFlow)

function RedDotActivityPreOrderWork:ctor(activityTid)
  Super.ctor(self, "预约活动红点")
  self.activityTid = activityTid
end

function RedDotActivityPreOrderWork:Execute()
  local taskList = ActivityDataUtils.GetPreOrderCanGetTaskList(self.activityTid)
  return #taskList > 0 and RedDotDefine.RedDotType.Red or false
end

return RedDotActivityPreOrderWork
