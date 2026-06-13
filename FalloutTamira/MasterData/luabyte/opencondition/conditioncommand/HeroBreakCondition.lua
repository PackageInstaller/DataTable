-- 英雄突破等级达到
local HeroBreakCondition = BaseClass("HeroBreakCondition", BaseCommand)
local M = HeroBreakCondition
function M:Execute(args)
    local arg1, arg2, arg3 = table.unpack(args)
    local data
    if arg1 and arg1 > 0 then
        data = IHeroDataMgr:GetMyHeroDataById(arg1)
    elseif arg3 and arg3 > 0 then
        data = IHeroDataMgr:GetMyHeroDataById(arg3)
    end
    if data then
        return data:GetBreakLevel() >= arg2
    end
    return false
end

return HeroBreakCondition
