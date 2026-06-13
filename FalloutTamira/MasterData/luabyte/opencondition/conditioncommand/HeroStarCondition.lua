local M = BaseClass('HeroStarCondition', BaseCommand)

function M:Execute(args)
    local arg1, arg2 = table.unpack(args)
    local data = IHeroDataMgr:GetMyHeroDataById(arg1)
    if data then return data:GetCoreLevel() >= arg2 end
    return false
end

return M
