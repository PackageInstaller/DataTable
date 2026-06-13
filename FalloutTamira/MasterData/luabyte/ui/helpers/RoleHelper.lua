local RoleHelper = {}
local GeneOpenId = EnumConst.GeneOpenId

function RoleHelper.IsUpRoleGene(heroData, pos)
    local heroId = heroData:GetHeroId()
    local rare = heroData:GetHeroCfg().rare
    if not RoleHelper.OpenGene(heroId, rare) then
        return
    end
    local heroId = heroData:GetHeroId()
    local geneCfg = ConfigHelper.GetCfgsByLua("heroAi", {heroId=heroId, slot=pos})[1]
    if not geneCfg then
        Logger.LogError("英雄 Id = " .. tostring(heroId) .. " heroAi 表里没有基因位置：" .. tostring(pos) .. "的数据")
        return false
    end

    local starCfg = ConfigHelper.GetCfgsByLua("heroAiStar", {aiType=geneCfg.aiType})
    local geneStar = heroData:GeneByPosition(pos - 1)
    local items = starCfg[geneStar + 1].costItems
    local nums = starCfg[geneStar + 1].costNum
    local length = #items

    if length == 0 then
        return false
    end

    for i = 1, length do
        local costId = items[i]
        local costNum = nums[i]
        if not GameHelper.CheckItem(costId, costNum) then
            return false
        end
    end

    return true
end

-- 基因是否开放
function RoleHelper.OpenGene(heroId, rare)
    rare = rare or ConfigHelper.GetCfgPropByLua("hero", heroId, "rare")
    local showCondition = ConfigHelper.GetCfgPropByLua("functionOpen", GeneOpenId[rare], "showCondition")
    local isOpen = GameHelper.CheckLockByOpenConditionIds(showCondition, heroId)
    return isOpen
end

return RoleHelper
