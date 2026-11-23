TeamWeaponMgr = {
    isShowPreparePopup = false
}

local this = {

}


TeamWeaponMgr.GetTeamWeaponCfg = function(weaponId)
    return ConfigMgr.Config.TeamWeaponMap[weaponId]
end

TeamWeaponMgr.GetTeamWeaponAttrs = function(weaponId, level)
    local result = {}
    local weaponCfg = TeamWeaponMgr.GetTeamWeaponCfg(weaponId)
    local talentMap = ConfigMgr.Config.talentBankMap
    local upAttrValue = { 0, 0, 0, 0 }
    local upAttrLen = #weaponCfg.UpAttribute
    local attrLen = #weaponCfg.TeamWeaponAttribute
    if level > 1 then
        level = level - 1
        local fullCycles = math.floor(level / upAttrLen)
        local remainder = fullCycles > 0 and level % upAttrLen or level
        for i = 1, upAttrLen do
            for attrIndex = 1, attrLen do
                local count = fullCycles
                if i <= remainder then
                    count = fullCycles + 1
                end
                upAttrValue[attrIndex] = upAttrValue[attrIndex] + tonumber(weaponCfg.UpAttribute[i][attrIndex]) * count
            end
        end
    end
    for i, talentId in ipairs(weaponCfg.TeamWeaponAttribute) do
        local attrName, attrValue, attrType, iconName = ConfigHelper.GetAttrNameStr(talentId)
        local attrData = {
            attrId = iconName,
            name = attrName,
            value = tonumber(attrValue) + upAttrValue[i],
        }
        table.insert(result, attrData)
    end
    return result
end

TeamWeaponMgr.GetLevelExp = function(weaponId, level)
    local exp = 0
    local weaponCfg = TeamWeaponMgr.GetTeamWeaponCfg(weaponId)
    local weaponLevelCfgs = ConfigMgr.Config.TeamWeaponLevelUpMap
    if weaponLevelCfgs[tostring(level)] ~= nil then
        exp = weaponLevelCfgs[tostring(level)]["Exp" .. weaponCfg.Rare]
    end
    if exp == nil then
        LuaDebug.error("levelExp == nil!")
        exp = 0
    end
    return exp
end

TeamWeaponMgr.GetLevelByExp = function(weaponId, exp)
    local level = 0
    local weaponCfg = TeamWeaponMgr.GetTeamWeaponCfg(weaponId)
    local weaponLevelCfgs = ConfigMgr.Config.TeamWeaponLevelUpMap
    local maxLevel = tonumber(weaponCfg.LevelLimite[#weaponCfg.LevelLimite])
    for i = 1, maxLevel do
        local needExp = weaponLevelCfgs[tostring(i)]["Exp" .. weaponCfg.Rare]
        if exp >= needExp then
            level = i
        else
            break
        end
    end
    return level
end

TeamWeaponMgr.GetLevelUpCoinByRare = function(rare)
    return ConfigMgr.Config.constants.TeamWeaponExpToCoin
end

TeamWeaponMgr.TeamWeaponStarUpCfg = function(weaponId, star)
    local teamWeaponStarUpMap = ConfigMgr.Config.TeamWeaponStarUpMap
    if teamWeaponStarUpMap[weaponId] ~= nil and teamWeaponStarUpMap[weaponId][tostring(star)] ~= nil then
        return table.Copy(teamWeaponStarUpMap[weaponId][tostring(star)])
    end
    return nil
end


TeamWeaponMgr.GetTeamWeaponData = function(weaponId)
    if not IsNull(DataMgr.Player.TeamWeapons) and DataMgr.Player.TeamWeapons[weaponId] ~= nil then
        return DataMgr.Player.TeamWeapons[weaponId]
    end
    return nil
end

TeamWeaponMgr.GetTeamIndexByWeaponId = function(weaponId)
    local count = ConfigMgr.Config.constants.maxSquadCount
    for i = 0, count - 1 do
        local team = DataMgr.Player.teams[tostring(i)]
        if team ~= nil and team.teamWeapon == weaponId then
            return i
        end
    end
    return -1
end

TeamWeaponMgr.CheckWeaponIsLocked = function(weaponId)
return false
end

TeamWeaponMgr.GetWeaponTotalLevel = function()
    local totalLevel = 0
    local teamWeaponDatas = DataMgr.Player.TeamWeapons
    if teamWeaponDatas ~= nil then
        for k, v in pairs(teamWeaponDatas) do
            totalLevel = totalLevel + v.Level
        end
    end
    return totalLevel
end








local GetLevelUpItem
GetLevelUpItem = function(expItemList, itemIndex, needExp, costCoin, rareUpCoin, needExpItemMap)
    if needExpItemMap == nil then
        needExpItemMap = {}
    end
    if needExp <= 0 then
        return true
    end
    if itemIndex <= 0 then
        return false
    end

    local expItem = expItemList[itemIndex]
    local serverItem = PlayerItemMgr.GetItemById(expItem.id)
    local count = serverItem ~= nil and serverItem.count0 or 0
    local needItemCount = 0
    local coin = PlayerItemMgr.GetItemCountById("3")
    if expItem ~= nil and count > 0 then
        needItemCount = math.min(math.floor(needExp / expItem.drop), count)
        while coin < needItemCount * expItem.drop * rareUpCoin + costCoin do
            needItemCount = needItemCount - 1
        end
    end
    local isOk = GetLevelUpItem(expItemList, itemIndex - 1, needExp - needItemCount * expItem.drop, needItemCount * expItem.drop * rareUpCoin + costCoin, rareUpCoin, needExpItemMap)

    if not isOk then

        if needItemCount + 1 > count then
            return false, false
        end
        needItemCount = needItemCount + 1
        if needItemCount <= 0 or coin < needItemCount * expItem.drop * rareUpCoin + costCoin then
            return false, true
        end
    end
    needExpItemMap[expItem.id] = needItemCount

    return true, true
end


TeamWeaponMgr.GetFastLevelUpItem = function(weaponId, isCalculateOptimalExpItems)
    local isItemEnough = false
    local expItemList = ConfigItemMgr.GetItemsByType(ItemType.TeamWeaponExp)
    local weaponCfg = TeamWeaponMgr.GetTeamWeaponCfg(weaponId)
    local weaponData = TeamWeaponMgr.GetTeamWeaponData(weaponId)
    local limitedLevel = math.min(tonumber(weaponCfg.LevelLimite[weaponData.Star]), tonumber(weaponCfg.LevelLimite[#weaponCfg.LevelLimite]))
    if weaponCfg == nil or weaponData == nil or weaponData.Level >= limitedLevel then
        return false
    end

    local canLevelUpMaxLevel = weaponData.Level
    local needExp = TeamWeaponMgr.GetLevelExp(weaponId, canLevelUpMaxLevel + 1) - weaponData.Exp
    local rareUpCoin = TeamWeaponMgr.GetLevelUpCoinByRare(weaponCfg.Rare) / 100
    local coin = PlayerItemMgr.GetItemCountById("3")
    local needExpItemMap = {}
    local isOk = false

    if isCalculateOptimalExpItems then
        local maxExpByCoin = math.floor(coin / rareUpCoin)
        local maxExpByItem = 0
        for i = 1, #expItemList do
            local expItem = expItemList[i]
            local needItemCount = 0
            local serverItem = PlayerItemMgr.GetItemById(expItem.id)
            local count = serverItem ~= nil and serverItem.count0 or 0
            maxExpByItem = maxExpByItem + expItem.drop * count
        end
        local maxExp = math.min(maxExpByCoin, maxExpByItem)
        isItemEnough = maxExpByItem >= maxExpByCoin
        local allExp = maxExp + weaponData.Exp
        while canLevelUpMaxLevel <= limitedLevel do
            if allExp < TeamWeaponMgr.GetLevelExp(weaponId, canLevelUpMaxLevel) then
                canLevelUpMaxLevel = canLevelUpMaxLevel - 1
                break
            end
            canLevelUpMaxLevel = canLevelUpMaxLevel + 1
        end
        canLevelUpMaxLevel = math.min(limitedLevel, canLevelUpMaxLevel)

        while canLevelUpMaxLevel > weaponData.Level do
            needExp = TeamWeaponMgr.GetLevelExp(weaponId, canLevelUpMaxLevel) - weaponData.Exp
            isOk, isItemEnough = GetLevelUpItem(expItemList, #expItemList, needExp, 0, rareUpCoin, needExpItemMap)
            if isOk then
                break
            end
            canLevelUpMaxLevel = canLevelUpMaxLevel - 1
        end
    else
        isOk, isItemEnough = GetLevelUpItem(expItemList, #expItemList, needExp, 0, rareUpCoin, needExpItemMap)
    end

    return isOk, needExpItemMap, isItemEnough
end



TeamWeaponMgr.CheckAllTeamWeaponCultivateRed = function()
    local count = ConfigMgr.Config.constants.maxSquadCount
    for teamIndex = 0, count - 1 do
        local team = DataMgr.Player.teams[tostring(teamIndex)]
        if team ~= nil and not IsNullOrEmpty(team.teamWeapon) then
            local levelUpRed, ascensionRed = TeamWeaponMgr.GetTeamWeaponCultivateRed(team.teamWeapon)
            if levelUpRed + ascensionRed > 0 then
                return 1
            end
        end
    end
    return 0
end

TeamWeaponMgr.CheckTeamWeaponCultivateRed = function(weaponId)
    local redCount = 0
    local count = ConfigMgr.Config.constants.maxSquadCount
    for teamIndex = 0, count - 1 do
        local team = DataMgr.Player.teams[tostring(teamIndex)]
        if team ~= nil and not IsNullOrEmpty(team.teamWeapon) and team.teamWeapon == weaponId then
            local levelUpRed, ascensionRed = TeamWeaponMgr.GetTeamWeaponCultivateRed(weaponId)
            redCount = levelUpRed + ascensionRed
            break
        end
    end
    return redCount
end

TeamWeaponMgr.GetTeamWeaponCultivateRed = function(weaponId)
    local levelUpRed, ascensionRed = 0, 0
    local weaponCfg = TeamWeaponMgr.GetTeamWeaponCfg(weaponId)
    local weaponData = TeamWeaponMgr.GetTeamWeaponData(weaponId)
    local isOk, isItemEnough = TeamWeaponMgr.GetFastLevelUpItem(weaponId)
    if isOk and isItemEnough then
        levelUpRed = 1
    end
    
    local limitLevel =  tonumber(weaponCfg.LevelLimite[weaponData.Star])
    local starUpCfg = TeamWeaponMgr.TeamWeaponStarUpCfg(weaponId, weaponData.Star + 1)
    if weaponData.Level >= limitLevel and starUpCfg ~= nil then
        local isAscensionCostEnough = true
        local coin = PlayerItemMgr.GetItemCountById("3")
        if coin < starUpCfg.Coin then
            isAscensionCostEnough = false
        end
        if isAscensionCostEnough then
            for i, v in ipairs(starUpCfg.Res) do
                local serverCount = PlayerItemMgr.GetItemCountById(v.id)
                if serverCount < v.count then
                    isAscensionCostEnough = false
                    break
                end
            end
        end
        if isAscensionCostEnough then
            ascensionRed = 1
        end
    end
    return levelUpRed, ascensionRed
end

TeamWeaponMgr.CheckTotalLevelRed = function()
    local totalLevel = TeamWeaponMgr.GetWeaponTotalLevel()
    local allAttrStatusMap = DataMgr.Player.TeamWeaponAttribute
    local allAttrList = ConfigMgr.Config.TeamWeaponAllAttributes
    for i, v in ipairs(allAttrList) do
        if totalLevel >= v.Level and allAttrStatusMap[tostring(v.Level)] == nil then
            return 1
        end
    end
    return 0
end


TeamWeaponMgr.LevelUpApi = function(weaponId, costItemMap, callback)
    local itemMap = {}
    for k, v in pairs(costItemMap) do
        if v > 0 then
            itemMap[k] = v
        end
    end
    local paramData = {
        Id = weaponId,
        cost = itemMap
    }
    ApiMgr.Request("team_weapon/level_up", paramData, true, callback, nil, true)
end

TeamWeaponMgr.AscensionApi = function(weaponId, costItemMap, callback)
    local paramData = {
        Id = weaponId,
        cost = costItemMap
    }
    ApiMgr.Request("team_weapon/star_up", paramData, true, callback, nil, true)
end

TeamWeaponMgr.UnlockTotalLevelAttrApi = function(level, callback)
    local paramData = {
        Level = level
    }
    ApiMgr.Request("team_weapon/activate_attribute", paramData, true, callback, nil, true)
end

TeamWeaponMgr.Clear = function()
    TeamWeaponMgr.isShowPreparePopup = false
end