local M = BaseClass("OpenComPopupEnergy", BaseJumpCommand)
M.uiName = "ComPopupEnergy"

function M:Execute(args)
    self:ShowUI(M.uiName, table.unpack(args))
    return true
end

return M
