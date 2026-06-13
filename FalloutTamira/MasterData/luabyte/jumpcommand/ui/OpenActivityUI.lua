-- 活动跳转
local M = BaseClass("OpenActivityUI", BaseJumpCommand)
M.uiName = UIDefine.UIActivity

function M:Execute(args)
    self:ShowUI(M.uiName, args[1])
    return true
end

return M
