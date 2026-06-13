--通行证奖励
local PassCardRewardRedPointChecker = BaseClass("PassCardRewardRedPointChecker", require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = PassCardRewardRedPointChecker

function M:__init()
    --checker 依赖的数据中心ID
    self.dataCenterId = {EGetterID.PassData}
end

function M:Check(lv)
    if not self:OnChanged(lv) then
        return
    end

    self.checkResult = PassDataMgr:GetInstance():CheckPassRewardRedPoint(lv) and 1 or 0
end

return PassCardRewardRedPointChecker
