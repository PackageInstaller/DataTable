local M = BaseClass("OpenMainFirstRecharge", BaseJumpCommand)
M.uiName = "MainFirstRecharge"
M.isJumpBack = false
function M:Execute(args)
    self:ShowUI(M.uiName, table.unpack(args))
    return true
end

return M
