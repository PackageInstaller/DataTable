-- 剧情图鉴子类型红点
local M = BaseClass("MainStoryBookBySubTypeRedPointChecker", require("DataCenter.RedPoint.BaseRedPointChecker"))

function M:Check(param)
    if not self:OnChanged(param) then
        return
    end

    local isShow = PlotAtlasDataMgr:GetInstance():CheckStoryBookRedPointBySubType(param)
    self.checkResult = isShow and 1 or 0
end

return M
