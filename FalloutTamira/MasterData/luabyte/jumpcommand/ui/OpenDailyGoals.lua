local M = BaseClass("OpenDailyGoals", BaseJumpCommand)
M.uiName = "DailyGoals"

function M:Execute(args)
    self:ShowUI(M.uiName, table.unpack(args))
    return true
end

return M
