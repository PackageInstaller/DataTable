local M = BaseClass("OpenBag", BaseJumpCommand)
M.uiName = "Bag"

function M:Execute(args)
    self:ShowUI(M.uiName, table.unpack(args))
    return true
end

return M
