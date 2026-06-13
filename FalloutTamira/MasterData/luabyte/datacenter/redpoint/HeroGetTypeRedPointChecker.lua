local HeroGetTypeRedPointChecker = BaseClass("HeroGetTypeRedPointChecker",require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = HeroGetTypeRedPointChecker

function M:Check(param)
    if not self:OnChanged(param) then
        return
    end

    self.checkResult = PlotAtlasDataMgr:GetInstance():CheckNewHeroRedPointByFaction(param) and 1 or 0
end

return HeroGetTypeRedPointChecker