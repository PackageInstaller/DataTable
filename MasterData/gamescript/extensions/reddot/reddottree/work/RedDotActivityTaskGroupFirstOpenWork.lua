local RedDotActivityTaskGroupFirstOpenWork, Super = System.NewPoolClass("RedDotActivityTaskGroupFirstOpenWork", RedDotSingleFlow)

function RedDotActivityTaskGroupFirstOpenWork:ctor(taskGroupTidList, activityTid)
  Super.ctor(self, "活动任务组首次开启红点")
  self.taskGroupTidList = taskGroupTidList or {}
  self.activityTid = activityTid
end

function RedDotActivityTaskGroupFirstOpenWork:Execute()
  for _, taskGroupTid in ipairs(self.taskGroupTidList) do
    local isOpen = ActivityDataUtils.IsActivityTaskGroupOpen(taskGroupTid, self.activityTid)
    if not isOpen then
    else
      local rst = RedPointDataUtils.IsShowClientRed(CommonDefine.ClientDataMainKey.ActivityTaskGroupFirstOpen, tostring(taskGroupTid), RedDotDefine.RedDotType.New)
      if rst then
        return rst
      end
    end
  end
  return false
end

return RedDotActivityTaskGroupFirstOpenWork
