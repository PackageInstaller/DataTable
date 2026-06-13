local M = BaseClass("OpenCurrencyExchangeUI", BaseJumpCommand)
M.uiName = "CurrencyExchangeUI"
M.isJumpBack = false

function M:Execute(args)
    self:ShowUI(M.uiName, table.unpack(args))
    return true
end

return M
