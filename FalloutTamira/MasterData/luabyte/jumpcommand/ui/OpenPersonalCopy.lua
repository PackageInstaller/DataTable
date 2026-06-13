local M = BaseClass("OpenPersonalCopy", BaseJumpCommand)
M.uiName = "DormPersonalEventMainUI"
M.closeOtherUI = { "Dorm" }

function M:Execute(args)
    local module = ModuleMgr:GetInstance():GetCurrentModule()
    local list = DormDataMgr:GetPersonalPassRecord(module.heroId)
    if list and #list > 0 then
        self:ShowUI(M.uiName, module.heroId, list)
        return true
    end

    GameHelper.TipsById(5205) -- 暂无个人副本
    return false
end

return M
