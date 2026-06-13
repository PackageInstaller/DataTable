local M = BaseClass("OpenComRoomUI", BaseJumpCommand)
M.uiName = "DormitorySelectPopup"

function M:Execute(args)
    self.args = args
    self:ShowUI(M.uiName, table.unpack(self.args))
    return true
end

return M
