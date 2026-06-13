local M = BaseClass("HaveHeroCountCondition", BaseCommand)

function M:Execute(args)
    local arg1, _ = table.unpack(args)
    return arg1 <= IHeroDataMgr:GetHeros().Count
end

return M
