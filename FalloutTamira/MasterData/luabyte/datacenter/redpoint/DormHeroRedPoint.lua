local DormHeroRedPoint = BaseClass("DormHeroRedPoint",require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = DormHeroRedPoint

function M:Check(param)
    if not self:OnChanged(param) then
        return
    end
    self.checkResult = DormDataMgr:CheckDormRedPoint() and 1 or 0
end

return DormHeroRedPoint