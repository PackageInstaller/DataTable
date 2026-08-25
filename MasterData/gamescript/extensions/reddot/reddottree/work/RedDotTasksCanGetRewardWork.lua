local RedDotTasksCanGetRewardWork, Super = System.NewPoolClass("RedDotTasksCanGetRewardWork", RedDotSingleFlow)

function RedDotTasksCanGetRewardWork:ctor(taskTidList)
  Super.ctor(self, "目标任务处于可领取状态")
  self.taskTidList = taskTidList
end

function RedDotTasksCanGetRewardWork:Execute()
  for _, taskTid in ipairs(self.taskTidList) do
    local taskCfg = DT.Task[taskTid]
    if taskCfg and taskCfg.CompleteAward and TaskDataUtils.IsCanGetRward(taskTid) then
      return RedDotDefine.RedDotType.Red
    end
  end
  return false
end

return RedDotTasksCanGetRewardWork
