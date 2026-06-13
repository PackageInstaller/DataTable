local DormAtmosphereRedPointChecker = BaseClass("DormAtmosphereRedPointChecker",require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = DormAtmosphereRedPointChecker

function M:Check(param)
    if not self:OnChanged(param) then
        return
    end
    self.checkResult = DormDataMgr:CheckAtmosphereAward(param) and 1 or 0
end

return DormAtmosphereRedPointChecker