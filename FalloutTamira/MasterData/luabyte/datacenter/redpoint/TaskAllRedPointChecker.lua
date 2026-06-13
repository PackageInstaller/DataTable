local TaskAllRedPointChecker = BaseClass("TaskAllRedPointChecker",require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = TaskAllRedPointChecker 

function M:__init()
    --checker 依赖的数据中心ID
    self.dataCenterId = {EGetterID.TaskData}
end

function M:Check()
    local num1 = TaskDataMgr:GetActivityAwardRedNum(0)
    local num2 = TaskDataMgr:GetMissionCompleteNum(0)
    self.checkResult = num2
end

return TaskAllRedPointChecker 
