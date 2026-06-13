local M = BaseClass('FirstRechargeCondition', BaseCommand)

function M:Execute(args)
    local firstRechargeState = RechargeDataMgr:GetInstance():GetFirstRechargeState()
    if firstRechargeState == RechargeConst.FirstRechargeState.Rewarded then
        return true
    else
        return false
    end
end

return M
