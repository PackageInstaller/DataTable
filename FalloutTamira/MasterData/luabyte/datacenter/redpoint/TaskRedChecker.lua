local TaskRedChecker = BaseClass("TaskRedChecker",require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = TaskRedChecker 

function M:__init()
    --checker 依赖的数据中心ID
    self.dataCenterId = {EGetterID.TaskData}
end

function M:Check(taskType)
    if not self:OnChanged(taskType) then
        return
    end
   
    self.checkResult = TaskDataMgr:GetMissionCompleteNum(taskType)
end

return TaskRedChecker 
