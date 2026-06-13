local M = BaseClass("OpenMail", BaseJumpCommand)
M.uiName = "MailUI"

function M:Execute(args)
    self:ShowUI(M.uiName, table.unpack(args))
    return true
end

return M