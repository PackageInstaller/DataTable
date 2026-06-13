local M = BaseClass("OpenComRoomUI", BaseJumpCommand)
M.uiName = "AchievementMain"

function M:Execute(args)
    self:ShowUI(M.uiName, table.unpack(args))
    return true
end

return M
