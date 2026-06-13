local HeroAltasRedPointChecker = BaseClass("HeroAltasRedPointChecker" , require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = HeroAltasRedPointChecker


function M:Check(id)
    if not self:OnChanged(id) then
        return
    end

    self.checkResult = PlotAtlasDataMgr:GetInstance():IsPendingAward(id) and 1 or 0
end


return HeroAltasRedPointChecker