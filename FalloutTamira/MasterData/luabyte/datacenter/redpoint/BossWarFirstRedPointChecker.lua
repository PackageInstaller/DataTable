local M = BaseClass("BossWarFirstRedPointChecker", require("DataCenter.RedPoint.BaseRedPointChecker"))

function M:Check(param)
    if not self:OnChanged(param) then
        return
    end

    local isShow = BossWarDataMgr:GetInstance():CheckFirstRedPoint(param)
    self.checkResult = isShow and 1 or 0
end

return M
