local M = BaseClass("OpenUIVoting", BaseJumpCommand)
M.uiName = "UIVoting"

function M:Execute(args)
    self:ShowUI(M.uiName, table.unpack(args))
    return true
end

return M
