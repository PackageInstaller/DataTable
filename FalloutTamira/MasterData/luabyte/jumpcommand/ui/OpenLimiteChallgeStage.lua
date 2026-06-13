local M = BaseClass("OpenLimiteChallgeStage", BaseJumpCommand)

function M:Execute(args)
    self:ShowUI("LimiteChallgeStage")
    return true
end

return M
