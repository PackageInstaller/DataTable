local M = BaseClass("OpenOtakuMain", BaseJumpCommand)
M.moduleId = ModuleConfig.OtakuMain.id

function M:Execute(args)
    if not OtakuRoomDataMgr:GetInstance():IsReady() then
        return false
    end 
    self:ChangeModule(M.moduleId, table.unpack(args))
    return true
end

return M
