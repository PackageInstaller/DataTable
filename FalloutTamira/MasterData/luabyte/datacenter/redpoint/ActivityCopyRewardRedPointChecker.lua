-- 活动副本大狂欢界面
local M = BaseClass("ActivityCopyRewardRedPointChecker", require("DataCenter.RedPoint.BaseRedPointChecker"))

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
    ActivityCopyDataMgr:GetInstance():CheckRewardRedPointById(id, Bind(self, self.AsynCallBack))
end

function M:AsynCallBack(data)
    self.isChecking = false
    self.checkResult = data and 1 or 0
end

return M
