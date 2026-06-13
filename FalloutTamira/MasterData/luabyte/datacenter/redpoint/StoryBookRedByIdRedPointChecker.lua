-- 剧情图鉴红点 
local M = BaseClass("StoryBookRedByIdRedPointChecker", require("DataCenter.RedPoint.BaseRedPointChecker"))

function M:Check(param)
    if not self:OnChanged(param) then
        return
    end

    local isShow = PlotAtlasDataMgr:GetInstance():CheckStoryBookRedPointById(param)
    self.checkResult = isShow and 1 or 0
end

return M
