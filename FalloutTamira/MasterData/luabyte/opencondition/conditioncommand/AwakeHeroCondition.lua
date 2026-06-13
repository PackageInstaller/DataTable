local M = BaseClass("AwakeHeroCondition", BaseCommand)

function M:Execute(args)
    local arg1, _ = table.unpack(args)
    local data = IHeroDataMgr:GetMyHeroDataById(arg1)
    if data then return data:IsAwake() end
    return false
end

return M
