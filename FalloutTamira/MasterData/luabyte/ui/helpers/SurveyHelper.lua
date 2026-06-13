local SurveyHelper = {}

function SurveyHelper.FilterHerosByCond(limit, params, herolist)
    local heros = {}
    if limit == 1 then -- 上阵x与y角色（ID数组）
        local heroDic = {}
        for _, id in ipairs(params) do heroDic[id] = true end
        for _, role in ipairs(herolist) do
            if heroDic[role.HeroId] then table.insert(heros, role) end
        end
    elseif limit == 2 then -- 上阵等级为x的y角色（等级，ID）
        local heroLv, heroId = params[1], params[2]
        for _, role in ipairs(herolist) do
            if (role.HeroId == heroId) and (role.Level >= heroLv) then
                table.insert(heros, role)
                break
            end
        end
    elseif limit == 3 then -- 上阵进阶等级为x的y角色（突破等级,ID）
        local breakLv, heroId = params[1], params[2]
        for _, role in ipairs(herolist) do
            if (heroId == role.HeroId) and (role.BreakLevel >= breakLv) then
                table.insert(heros, role)
                break
            end
        end
    elseif limit == 4 then -- 上阵核心等级为x的y角色（核心等级,ID）
        local starLv, heroId = params[1], params[2]
        for _, role in ipairs(herolist) do
            if (heroId == role.HeroId) and (role.CoreLevel >= starLv) then
                table.insert(heros, role)
                break
            end
        end
    elseif limit == 5 then -- 上阵x名y级角色（数量,等级）
        local heroNum, heroLv, heroCount = params[1], params[2], 0
        for _, role in ipairs(herolist) do
            if role.Level >= heroLv then
                table.insert(heros, role)
                heroCount = heroCount + 1
                if heroCount >= heroNum then break end
            end
        end
    elseif limit == 6 then -- 上阵x名进阶等级为y的角色（数量,突破等级）
        local breakNum, breakLv, breakCount = params[1], params[2], 0
        for _, role in ipairs(herolist) do
            if role.BreakLevel >= breakLv then
                table.insert(heros, role)
                breakCount = breakCount + 1
                if breakCount >= breakNum then break end
            end
        end
    elseif limit == 7 then -- 上阵x名y职业角色（数量,职业）
        local heroNum, heroPro, heroCount = params[1], params[2], 0
        for _, role in ipairs(herolist) do
            if role.Profession == heroPro then
                table.insert(heros, role)
                heroCount = heroCount + 1
                if heroCount >= heroNum then break end
            end
        end
    elseif limit == 8 then -- 上阵X名Y等级的Z职业角色（数量,等级,职业）
        local num, lv, prof, count = params[1], params[2], params[3], 0
        for _, role in ipairs(herolist) do
            if (role.Level >= lv) and (role.Profession == prof) then
                table.insert(heros, role)
                count = count + 1
                if count >= num then break end
            end
        end
    end
    return heros
end

-- 检查英雄条件是否满足
function SurveyHelper.CheckHeroCond(limit, params, heroIds)
    if limit == 1 then -- 上阵x与y角色（ID数组）
        local heroDic, heroNum, count = {}, 0, 0
        for _, id in ipairs(params) do
            heroDic[id], heroNum = true, heroNum + 1
        end
        for _, id in pairs(heroIds) do
            if heroDic[id] then count = count + 1 end
        end

        return count == heroNum
    elseif limit == 2 then -- 上阵等级为x的y角色（等级，ID）
        local heroLv, heroId = params[1], params[2]
        for _, id in pairs(heroIds) do
            if id == heroId then
                return IHeroDataMgr:GetMyHeroDataById(heroId):GetLevel() >= heroLv
            end
        end
    elseif limit == 3 then -- 上阵进阶等级为x的y角色（突破等级,ID）
        local breakLv, heroId = params[1], params[2]
        for _, id in pairs(heroIds) do
            if heroId == id then
                return IHeroDataMgr:GetMyHeroDataById(heroId):GetBreakLevel() >= breakLv
            end
        end
    elseif limit == 4 then -- 上阵核心为x的y角色（核心等级,ID）
        local starLv, heroId = params[1], params[2]
        for _, id in pairs(heroIds) do
            if id == heroId then
                return IHeroDataMgr:GetMyHeroDataById(id):GetCoreLevel() >= starLv
            end
        end
    elseif limit == 5 then -- 上阵x名y级角色（数量,等级）
        local count, heroNum, heroLv = 0, params[1], params[2]
        for _, id in pairs(heroIds) do
            if IHeroDataMgr:GetMyHeroDataById(id):GetLevel() >= heroLv then
                count = count + 1
            end
        end
        return count >= heroNum
    elseif limit == 6 then -- 上阵x名进阶等级为y的角色（数量,突破等级）
        local count, breakNum, breakLv = 0, params[1], params[2]
        for _, id in pairs(heroIds) do
            if IHeroDataMgr:GetMyHeroDataById(id):GetBreakLevel() >= breakLv then
                count = count + 1
            end
        end
        return count >= breakNum
    elseif limit == 7 then -- 上阵x名y职业角色（数量,职业）
        local count, heroNum, heroPro = 0, params[1], params[2]
        for _, id in pairs(heroIds) do
            if IHeroDataMgr:GetMyHeroDataById(id):GetProfession() == heroPro then
                count = count + 1
            end
        end
        return count >= heroNum
    elseif limit == 8 then -- 上阵X名Y等级的Z职业角色（数量,等级,职业）
        local num, lv, prof, count = params[1], params[2], params[3], 0
        for _, id in pairs(heroIds) do
            local hd = IHeroDataMgr:GetMyHeroDataById(id)
            if hd and (hd:GetLevel() >= lv) and (hd:GetProfession() == prof) then
                count = count + 1
            end
        end
        return count >= num
    end

    return false
end

-- 任务目标需要的英雄id和数量
function SurveyHelper.GetHerosAndNum(limit, params)
    local heroDic, heroNum = {}, 0
    if limit == 1 then -- 上阵x与y角色（ID数组）
        for _, id in pairs(params) do
            heroDic[id] = true
            heroNum = heroNum + 1
        end
    elseif limit == 2 then -- 上阵等级为x的y角色（等级，ID）
        heroDic[params[2]], heroNum = true, 1
    elseif limit == 3 then -- 上阵进阶等级为x的y角色（突破等级,ID）
        heroDic[params[2]], heroNum = true, 1
    elseif limit == 4 then -- 上阵核心为x的y角色（核心等级,ID）
        heroDic[params[2]], heroNum = true, 1
    elseif limit == 5 then -- 上阵x名y级角色（数量,等级）
        heroNum = params[1]
    elseif limit == 6 then -- 上阵x名进阶等级为y的角色（数量,突破等级）
        heroNum = params[1]
    elseif limit == 7 then -- 上阵x名y职业角色（数量,职业）
        heroNum = params[1]
    elseif limit == 8 then -- 上阵X名Y等级的Z职业角色（数量,等级,职业）
        heroNum = params[1]
    end
    return heroDic, heroNum
end

return SurveyHelper
