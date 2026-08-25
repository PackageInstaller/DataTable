local RedDotTasksCanGetExtraRewardWork, Super = System.NewPoolClass("RedDotTasksCanGetExtraRewardWork", RedDotSingleFlow)

function RedDotTasksCanGetExtraRewardWork:ctor(taskTidList)
  Super.ctor(self, "目标任务处于可领取高级奖励状态")
  self.taskTidList = taskTidList
end

function RedDotTasksCanGetExtraRewardWork:Execute()
  for _, taskTid in ipairs(self.taskTidList) do
    local taskCfg = DT.Task[taskTid]
    if taskCfg and taskCfg.ExtraAward and TaskDataUtils.IsCanGetRward(taskTid) then
      return RedDotDefine.RedDotType.Red
    end
  end
  return false
end

return RedDotTasksCanGetExtraRewardWork
