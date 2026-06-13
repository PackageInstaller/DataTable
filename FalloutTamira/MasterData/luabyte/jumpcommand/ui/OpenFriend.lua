local M = BaseClass("OpenFriend", BaseJumpCommand)
M.uiName = "Friend"

function M:Execute(args)
    self:ShowUI(M.uiName, table.unpack(args))
    return true
end

return M