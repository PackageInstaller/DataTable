local RoleAwakeRedPointChecker = BaseClass("RoleAwakeRedPointChecker", require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = RoleAwakeRedPointChecker

function M:__init()
    -- checker 依赖的数据中心ID
    self.dataCenterId = {EGetterID.TaskData}
end

function M:Check(param)
    if param < 0 then
        self.checkResult = 0
        return
    end
    if not self:OnChanged(param) then
        return
    end

    self.checkResult = DevelopMgr:GetInstance():GetAwakeRedPoint(param) and 1 or 0
end

return RoleAwakeRedPointChecker
