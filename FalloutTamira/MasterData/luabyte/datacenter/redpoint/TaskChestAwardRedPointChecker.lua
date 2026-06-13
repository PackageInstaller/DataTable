local TaskChestAwardRedPointChecker = BaseClass("TaskChestAwardRedPointChecker" , require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = TaskChestAwardRedPointChecker

function M:__init()
    --checker 依赖的数据中心ID
    self.dataCenterId = {EGetterID.TaskData}
end

function M:Check(type)
    -- 0 为全部 2 为日常  ， 3 为周常 
    if not self:OnChanged(type) then
        return
    end

    self.checkResult = TaskDataMgr:GetActivityAwardRedNum(type)
end


return TaskChestAwardRedPointChecker