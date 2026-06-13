local M = BaseClass("OpenMainScene", BaseJumpCommand)
M.moduleId = ModuleConfig.MainSceneModule.id

function M:Execute(args)
    local moduleId = IModuleMgr:GetCurModuleId()
    if moduleId ~= M.moduleId then
        self:ChangeModule(M.moduleId)
    else
        self:ShowUI("MainSceneUI")
    end
     -- 清除战员养成步骤记录
     UIContextMgr:GetInstance():GetContext(UIDefine.RoleDevelopMain):Init()
    return true
end

return M
