-- 假面舞会成就红点
local M = BaseClass("ActivityCopyAchievementRedPointChecker", require("DataCenter.RedPoint.BaseRedPointChecker"))

function M:__init()
    -- checker 依赖的数据中心ID
    self.dataCenterId = {EGetterID.AchievementData}
end

function M:Check(id)
    if id <= 0 then
        self.checkResult = 0
        return
    end
    local openCondition = ConfigHelper.GetCfgPropByLua("activity", id, "openCondition")
    local isUnlock = JumpMgr:GetInstance():CheckLockByOpenConditionIds(openCondition)
    if not isUnlock then
        self.checkResult = 0
        return
    end
    self.isChecking = true
    ActivityCopyDataMgr:GetInstance():CheckAchieveRedPointById(id, Bind(self, self.AsynCallBack))
end

function M:AsynCallBack(data)
    self.isChecking = false
    self.checkResult = data and 1 or 0
end

return M
