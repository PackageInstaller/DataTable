-- 任意英雄突破等级达到
local AnyHeroBreakCondition = BaseClass("AnyHeroBreakCondition", BaseCommand)
local M = AnyHeroBreakCondition
function M:Execute(args)
    local arg1, arg2 = table.unpack(args)
    local heros = IHeroDataMgr:GetHeros()
    for i = 0, heros.Count - 1 do
        local heroData = heros[i]
        if heroData:GetBreakLevel() >= arg1 then
            return true
        end
    end
    return false
end

return AnyHeroBreakCondition
