local M = BaseClass("GetHeroCondition", BaseCommand)

function M:Execute(args)
    local arg1, _ = table.unpack(args)
    local data = IHeroDataMgr:GetMyHeroDataById(arg1)
    if data then return true end
    return false
end

return M
