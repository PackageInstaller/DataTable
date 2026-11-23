MiniBattle4Mgr = {
    activityGroupId = 4101,
}

local this = {
selectMembers = {},
assistMembers = {},
    savedPlotMaxScores = nil,
    curBattleScore = 0,
    
    tempSelectSeriesId = "",
tempSelectedPlotMap = {},
tempSelectedLevelMap = {},
tempSelectedHelpMap = {},
};


MiniBattle4Mgr.SaveSelectedSeriesId = function(seriesId)
    this.tempSelectSeriesId = seriesId
end

MiniBattle4Mgr.GetSelectedSeriesId = function()
    return this.tempSelectSeriesId
end

MiniBattle4Mgr.SaveSelectedPlot = function(seriesId, plotId)
    this.tempSelectedPlotMap[seriesId] = plotId
end

MiniBattle4Mgr.GetSelectedPlot = function(seriesId)
    if this.tempSelectedPlotMap[seriesId] ~= nil then
        return this.tempSelectedPlotMap[seriesId]
    end
    return ""
end

MiniBattle4Mgr.SaveSelectedLevel = function(plotId, levelId)
    this.tempSelectedLevelMap[plotId] = levelId
end

MiniBattle4Mgr.GetSelectedLevel = function(plotId)
    if this.tempSelectedLevelMap[plotId] ~= nil then
        return this.tempSelectedLevelMap[plotId]
    end
    return ""
end

MiniBattle4Mgr.SaveSelectedHelp = function(plotId, helpId)
    this.tempSelectedHelpMap[plotId] = helpId
end

MiniBattle4Mgr.GetSelectedHelp = function(plotId)
    if this.tempSelectedHelpMap[plotId] ~= nil then
        return this.tempSelectedHelpMap[plotId]
    end
    return ""
end

MiniBattle4Mgr.SaveCurBattleScore = function(levelId, isVaild)
    local levelCfg = MiniBattle4Mgr.GetLevelCfg(levelId)
    this.curBattleScore = isVaild and levelCfg.Credit or 0
    local activityData = MiniBattle4Mgr.GetActivityData()
    this.savedPlotMaxScores = table.Copy(activityData.max)
end

MiniBattle4Mgr.GetCurBattleScore = function()
    return this.curBattleScore
end

MiniBattle4Mgr.GetHistoryPlotBestScore = function(plotId)
    if IsNull(this.savedPlotMaxScores) then
        return 0
    end

    local score = this.savedPlotMaxScores[plotId];
    if (IsNull(score)) then
        return 0
    end
    return score
end

MiniBattle4Mgr.Clear = function()
    this.savedPlotMaxScores = nil
    this.curBattleScore = 0
    this.tempSelectSeriesId = ""
    this.tempSelectedPlotMap = {}
    this.tempSelectedLevelMap = {}
    this.tempSelectedHelpMap = {}
end



MiniBattle4Mgr.GetSeriesCfg = function(seriesId)
    return ConfigMgr.Config.DualBattleSetiesidMap[tostring(seriesId)]
end

MiniBattle4Mgr.GetPlotCfg = function(plotId)
    return ConfigMgr.Config.DualBattleMap[plotId]
end

MiniBattle4Mgr.GetLevelCfg = function(levelId)
    return ConfigMgr.Config.DualBattleBuffMap[levelId]
end

MiniBattle4Mgr.GetBuffDescCfg = function(buffDescId)
    return ConfigMgr.Config.DualBattleBuffDescMap[buffDescId]
end

MiniBattle4Mgr.GetMonsterInfo = function(monsterId)
    local monsterCfg = ConfigMgr.Config.monsterMap[monsterId]
    local dualBattleMonsterCfg = ConfigMgr.Config.DualBattleMonsterInfoMap[monsterId]
    if monsterCfg == nil or dualBattleMonsterCfg == nil then
        return
    end
    local monsterInfo = {
        charecterId = monsterCfg.monsterModel,
        skinId = monsterCfg.monsterSkin,
        level = dualBattleMonsterCfg.Level,
        star = dualBattleMonsterCfg.Star,
        dualBattleCfg = dualBattleMonsterCfg,
    }
    return monsterInfo
end

MiniBattle4Mgr.GetMonsterDataJson = function(monsterId)
    local monsterInfo = MiniBattle4Mgr.GetMonsterInfo(monsterId)
    local jsonData = {
        monsterId = monsterId,
        characterId = monsterInfo.charecterId,
        skinId = monsterInfo.skinId,
        level = monsterInfo.level,
        star = monsterInfo.star,
        rareLevel = monsterInfo.dualBattleCfg.RareLevel,
        propertyLevel = monsterInfo.dualBattleCfg.PropertyLevel,
        weaponId = monsterInfo.dualBattleCfg.WeaponId,
        weaponSkin = monsterInfo.dualBattleCfg.WeaponSkin,
        weaponLevel = monsterInfo.dualBattleCfg.WeaponLevel,
        weaponStar = monsterInfo.dualBattleCfg.WeaponStar,
        equipSkills = monsterInfo.dualBattleCfg.WeaponSkill,
    }
    local jsonStr = json.encode(jsonData)
    return jsonStr
end

MiniBattle4Mgr.GetPlotCfgList = function(seriesId)
    local plotCfgs = {}
    local dualBattleCfgs = ConfigMgr.Config.DualBattleMap
    for k, v in pairs(dualBattleCfgs) do
        if v.ActivityGroup == MiniBattle4Mgr.activityGroupId and v.SeriesId == seriesId then
            table.insert(plotCfgs, v)
        end
    end
    table.sort(plotCfgs, function(a, b)
        return a.ID < b.ID
    end)
    return plotCfgs
end

MiniBattle4Mgr.GetSeriesList = function()
    local seriesList = {}
    local seriesMap = ConfigMgr.Config.DualBattleSetiesidMap
    for k, v in pairs(seriesMap) do
        if v.ActivityGroup == MiniBattle4Mgr.activityGroupId then
            table.insert(seriesList, v.SeriesId)
        end
    end
    return seriesList
end

this.GetDelayTime = function(delay)
    local startTime = 0
    local activityData = DataExHelper.GetDataExByTag(ActivityKey.DualBattle2)
    if activityData ~= nil then
        startTime = activityData.startTime
    end
    local delayTime = delay * 24 * 60 * 60
    local leftTime = startTime + delayTime
    return leftTime
end


MiniBattle4Mgr.GetSeriesUnlockTime = function(seriesId)
    local seriesCfg = MiniBattle4Mgr.GetSeriesCfg(seriesId)
    if TableIsNull(seriesCfg) then
        return 0
    end
    local leftTime = this.GetDelayTime(seriesCfg.Delay)
    return leftTime
end


MiniBattle4Mgr.GetLevelUnlockTime = function(levelId)
    local levelCfg = MiniBattle4Mgr.GetLevelCfg(levelId)
    if TableIsNull(levelCfg) then
        return 0
    end
    local leftTime = this.GetDelayTime(levelCfg.Delay)
    return leftTime
end

MiniBattle4Mgr.GetBuffCardInfo = function(buffDescId)
    local buffCardInfo = nil
    local buffDescCfg = MiniBattle4Mgr.GetBuffDescCfg(buffDescId)
    if buffDescCfg ~= nil and buffDescCfg.IfHidden == 0 then
        buffCardInfo = {
            id = buffDescId,
            buffId = buffDescCfg.BuffId,
            name = LuaMgr.GetLangText(buffDescCfg.BuffNamelan),
            desc = LuaMgr.GetLangText(buffDescCfg.BuffDeslan),
            icon = LuaMgr.GetTexture("Assets/_BundleResources/Images/MoreModIcon/" .. buffDescCfg.BuffIcon .. ".png"),
            quality = 1
        }
    end
    return buffCardInfo
end

MiniBattle4Mgr.GetAnotherPlotIds = function(plotId)
    local plotIds = {}
    local plotCfg = MiniBattle4Mgr.GetPlotCfg(plotId)
    local seriesid = plotCfg.SeriesId
    local plotCfgs = ConfigMgr.Config.DualBattleMap
    for k, v in pairs(plotCfgs) do
        if v.SeriesId == seriesid and v.ID ~= plotId then
            table.insert(plotIds, v.ID)
        end
    end
    return plotIds
end

MiniBattle4Mgr.GetFilterMembers = function(plotId)
    local filterMembers = {}
    local anotherBattleIndexs = MiniBattle4Mgr.GetAnotherPlotIds(plotId)
    if anotherBattleIndexs ~= nil then
        for i, v in ipairs(anotherBattleIndexs) do
            local filters = ActivityBattlePrepareMgr.GetLockMembers(ActivityKey.DualBattle2, v)
            for member, uid in pairs(filters) do
                filterMembers[member] = uid
            end
        end
    end
    return filterMembers
end


MiniBattle4Mgr.GetActivityData = function()
    return DataMgr.Player.Dual2Battle
end


MiniBattle4Mgr.GetPlotBestScore = function(plotId)
    local activityData = MiniBattle4Mgr.GetActivityData()
    if (IsNull(activityData.max)) then
        return 0
    end

    local score = activityData.max[plotId];
    if (IsNull(score)) then
        return 0
    end
    return score
end


MiniBattle4Mgr.GetTotalScore = function()
    local activityData = MiniBattle4Mgr.GetActivityData()
    local scores = activityData.scores
    if (IsNull(scores)) then
        return 0
    end

    local totalScore = 0
    for k, v in pairs(scores) do
        local plotCfg = MiniBattle4Mgr.GetPlotCfg(k)
        if plotCfg.ActivityGroup == MiniBattle4Mgr.activityGroupId and plotCfg.Type == 2 then
            totalScore = totalScore + v
        end
    end
    return totalScore
end


MiniBattle4Mgr.GetPlotLevelStatus = function(levelId)
    local activityData = MiniBattle4Mgr.GetActivityData()
    if not IsNull(activityData.reward) and activityData.reward[levelId] ~= nil then
        return 2
    elseif not IsNull(activityData.finish) and activityData.finish[levelId] ~= nil then
        return 0
    end

    local curTime = LuaMgr.Timestamp()
    local unlockTime = MiniBattle4Mgr.GetLevelUnlockTime(levelId)
    if curTime < unlockTime then
        return 3
    end
    return 1
end


MiniBattle4Mgr.GetPlotHighestLevel = function(plotId)
    local plotCfg = MiniBattle4Mgr.GetPlotCfg(plotId)
    local enemyLevelList = plotCfg.EnemyOption
    local highestLevelId = ""
    for i = #enemyLevelList, 1, -1 do
        local levelId = enemyLevelList[i]
        local levelStatus = MiniBattle4Mgr.GetPlotLevelStatus(levelId)
        if levelStatus ~= 1 and levelStatus ~= 3 then
            highestLevelId = levelId
            break
        end
    end
    return highestLevelId
end


MiniBattle4Mgr.GetPlotHighestUnlockedLevel = function(plotId)
    local levelId = MiniBattle4Mgr.GetPlotHighestLevel(plotId)
    if IsNullOrEmpty(levelId) then
        local plotCfg = MiniBattle4Mgr.GetPlotCfg(plotId)
        local enemyLevelList = plotCfg.EnemyOption
        levelId = enemyLevelList[#enemyLevelList]
    end
    return levelId
end

MiniBattle4Mgr.GetSeriesData = function(seriesId)
    local activityData = MiniBattle4Mgr.GetActivityData()
    if not IsNull(activityData.Series) and not IsNull(activityData.Series[tostring(seriesId)]) then
        return activityData.Series[tostring(seriesId)]
    end
    return nil
end


MiniBattle4Mgr.GetSeriesLeftChallengeCount = function(seriesId)
    local seriesCfg = MiniBattle4Mgr.GetSeriesCfg(seriesId)
    local activityData = MiniBattle4Mgr.GetActivityData()
    local maxCount = seriesCfg.SeriesChallengeNum
    local useCount = 0
    local seriesData = MiniBattle4Mgr.GetSeriesData(seriesId)
    if seriesData ~= nil then
        useCount = seriesData.challengeCount
    end
    return math.max(maxCount - useCount, 0), maxCount
end

MiniBattle4Mgr.GetLockedCharacterMap = function(seriesId)
    local chaMap = {}
    local seriesData = MiniBattle4Mgr.GetSeriesData(seriesId)
    if seriesData ~= nil and not IsNull(seriesData.locks) then
        for plotId, lockData in pairs(seriesData.locks) do
            if not IsNull(lockData.actors) then
                for i, actor in ipairs(lockData.actors) do
                    chaMap[actor] = plotId
                end
            end
        end
    end
        
    return chaMap
end

MiniBattle4Mgr.GetLockMembersAndHelps = function(plotId)
    local members = {};
    local helps = {};
    local plotCfg = MiniBattle4Mgr.GetPlotCfg(plotId)
    local seriesData = MiniBattle4Mgr.GetSeriesData(plotCfg.SeriesId)
    if not IsNull(seriesData) then
        local locks = seriesData.locks;
        if not IsNull(locks) then
            local lock = locks[plotId];
            if not IsNull(lock) then
                if (not IsNull(lock.helps)) then
                    helps = lock.helps;
                end
                if (not IsNull(lock.members)) then
                    members = lock.members;
                end
            end
        end
    end
    return members, helps
end



MiniBattle4Mgr.GetRewards = function(plotId, callback)
    ApiMgr.Request("dual2Battle/getRewards", { ID = plotId }, true, callback, nil, true, true);
end