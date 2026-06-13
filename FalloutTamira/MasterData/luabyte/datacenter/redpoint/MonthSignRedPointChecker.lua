local M = BaseClass("MonthSignRedPointChecker", require("DataCenter.RedPoint.BaseRedPointChecker"))

function M:Check()
    local openConditionMonthSign = ConfigHelper.GetCfgPropByLua("functionOpen", 21, "openCondition")
    local isUnlockMonthSign = JumpMgr:GetInstance():CheckLockByOpenConditionIds(openConditionMonthSign)
    if not isUnlockMonthSign then
        self.checkResult = 0
        return
    end
    local m_CycleData = CycleDataMgr:GetInstance():GetCycleDataByType(protocol.ECycleEvent.ECET_Award_Sign)
    local m_IsSign = m_CycleData:IsSigned()
    self.checkResult = m_IsSign and 0 or 1
end

return M
