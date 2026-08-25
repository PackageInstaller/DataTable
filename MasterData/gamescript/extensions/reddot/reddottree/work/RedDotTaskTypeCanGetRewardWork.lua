local RedDotTasksCanGetRewardWork, Super = System.NewPoolClass("RedDotTasksCanGetRewardWork", RedDotSingleFlow)

function RedDotTasksCanGetRewardWork:ctor(taskType)
  Super.ctor(self, "目标任务类型存在可领奖的任务")
  self.taskType = taskType
end

function RedDotTasksCanGetRewardWork:Execute()
  return TaskDataUtils.IsTaskTypeHaveReceiveState(self.taskType) and RedDotDefine.RedDotType.Red or false
end

return RedDotTasksCanGetRewardWork
