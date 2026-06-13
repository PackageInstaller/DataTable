--图鉴获得新英雄红点
local HeroGetAtlasRedPointChecker = BaseClass("HeroGetAtlasRedPointChecker",require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = HeroGetAtlasRedPointChecker

function M:Check(param)
    if not self:OnChanged(param) then
        return
    end

    self.checkResult = PlotAtlasDataMgr:GetInstance():CheckNewHeroRedPointById(param) and 1 or 0
end

return HeroGetAtlasRedPointChecker