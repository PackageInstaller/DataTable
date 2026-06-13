local M = BaseClass("AwakeTaskContext", BaseContext)


function M:Open()
    TaskDataMgr:RequestLoadTaskByType(TaskConst.TaskType.Awake, Bind(self, self.CallBack))
end

function M:CallBack()
    self:_Show()
end


return M
