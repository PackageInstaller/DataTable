local AchievementRewardRedPointChecker = BaseClass("AchievementRewardRedPointChecker",require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = AchievementRewardRedPointChecker

function M:__init()
    --checker 依赖的数据中心ID
    self.dataCenterId = {EGetterID.AchievementData}
end

function M:Check(param)
    if not self:OnChanged(param) then
        return
    end
    
    local num = AchievementDataMgr:GetInstance():RewardNum(param)
    self.checkResult = num > 0 and 1 or 0 
end


return AchievementRewardRedPointChecker