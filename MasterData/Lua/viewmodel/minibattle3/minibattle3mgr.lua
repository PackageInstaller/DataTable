MiniBattle3Mgr = {
    activityGroupId = 4100,
}

local this = {
selectMembers = {},
assistMembers = {},
    upLeftTimes = 0,
    downLeftTimes = 0,
};

MiniBattle3Mgr.GetMiniBattle3Data = function()
    local data = {}
    if not IsNull(DataMgr.Player.DualBattles) and not IsNull(DataMgr.Player.DualBattles[tostring(MiniBattle3Mgr.activityGroupId)]) then
        data = DataMgr.Player.DualBattles[tostring(MiniBattle3Mgr.activityGroupId)]
    end
    return data
end

MiniBattle3Mgr.GetLockMembersAndHelps = function(battleId)
    local members = {};
    local helps = {};
    local miniBattleData = MiniBattle3Mgr.GetMiniBattle3Data()
    if not IsNull(miniBattleData) then
        local locks = miniBattleData.locks;
        if not IsNull(locks) then
            local lock = locks[battleId];
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

MiniBattle3Mgr.GetAnotherPlotId = function(plotId)
    local anotherPlotId = ""
    local plotCfg = ConfigMgr.Config.DualBattleMap[plotId]
    if TableIsNull(plotCfg) then
        return anotherPlotId
    end
    local seriesid = plotCfg.SeriesId
    local plotCfgs = ConfigMgr.Config.DualBattleMap
    for k, v in pairs(plotCfgs) do
        if v.SeriesId == seriesid and v.ID ~= plotCfg.ID then
            anotherPlotId = v.ID
            break
        end
    end
    return anotherPlotId
end

MiniBattle3Mgr.GetTotalScore = function()
    local miniBattleData = MiniBattle3Mgr.GetMiniBattle3Data()
    local scores = miniBattleData.scores;
    if (IsNull(scores)) then
        return 0
    end

    local totalScore = 0
    for k, v in pairs(scores) do
        local plotCfg = ConfigMgr.Config.DualBattleMap[k]
        if plotCfg.Type == 2 then
            totalScore = totalScore + v
        end
    end

    return totalScore
end


MiniBattle3Mgr.GetDungeonMaxScore = function(plotId)
    local miniBattleData = MiniBattle3Mgr.GetMiniBattle3Data()
    if (IsNull(miniBattleData.max)) then
        return 0
    end

    local score = miniBattleData.max[plotId];
    if (IsNull(score)) then
        return 0
    end
    return score
end

MiniBattle3Mgr.GetUpDailyBattleCount = function()
    local miniBattleData = MiniBattle3Mgr.GetMiniBattle3Data()
    if IsNull(miniBattleData.upTimes) then
        return 0
    end
    return miniBattleData.upTimes
end

MiniBattle3Mgr.GetDownDailyBattleCount = function()
    local miniBattleData = MiniBattle3Mgr.GetMiniBattle3Data()
    if IsNull(miniBattleData.downTimes) then
        return 0
    end
    return miniBattleData.downTimes
end

MiniBattle3Mgr.CheckUpDailyBattleCount = function()
    local dailyTotalCount = ConfigMgr.Config.constants.DualBattleUpLimit
    local dailyUseCount = MiniBattle3Mgr.GetUpDailyBattleCount()
    return dailyUseCount < dailyTotalCount
end

MiniBattle3Mgr.CheckDownDailyBattleCount = function()
    local dailyTotalCount = ConfigMgr.Config.constants.DualBattleDownLimit
    local dailyUseCount = MiniBattle3Mgr.GetDownDailyBattleCount()
    return dailyUseCount < dailyTotalCount
end

MiniBattle3Mgr.SaveDailyLeftBattleCount = function()
    this.upLeftTimes = ConfigMgr.Config.constants.DualBattleUpLimit - MiniBattle3Mgr.GetUpDailyBattleCount()
    this.downLeftTimes = ConfigMgr.Config.constants.DualBattleDownLimit - MiniBattle3Mgr.GetDownDailyBattleCount()
end

MiniBattle3Mgr.GetSavedDailyLeftBattleCount = function(isUp)
    return isUp and this.upLeftTimes or this.downLeftTimes
end

MiniBattle3Mgr.GetMiniBattleCfgs = function()
    local ConfigList = {}
    for k, v in pairs(ConfigMgr.Config.DualBattleMap) do
        if v.ActivityGroup == MiniBattle3Mgr.activityGroupId then
            table.insert(ConfigList, v)
        end
    end
    table.sort(ConfigList, function(a, b)
        return a.ID < b.ID
    end)
    return ConfigList
end

MiniBattle3Mgr.GetDungeonUnlockTime = function(plotId)
    local startTime = 0
    local activityData = DataExHelper.GetDataExByTag(ActivityKey.DualBattle)
    if activityData ~= nil then
        startTime = activityData.startTime
    end
    local plotCfg = ConfigMgr.Config.DualBattleMap[plotId]
    if TableIsNull(plotCfg) then
        return 0
    end
    local delayTime = plotCfg.Delay * 24 * 60 * 60
    local leftTime = startTime + delayTime
    return leftTime
end

MiniBattle3Mgr.GetDungeonLevelUnlockTime = function(levelId)
    local startTime = 0
    local activityData = DataExHelper.GetDataExByTag(ActivityKey.DualBattle)
    if activityData ~= nil then
        startTime = activityData.startTime
    end
    local levelCfg = ConfigMgr.Config.DualBattleBuffMap[levelId]
    if TableIsNull(levelCfg) then
        return 0
    end
    local delayTime = levelCfg.Delay * 24 * 60 * 60
    local leftTime = startTime + delayTime
    return leftTime
end

MiniBattle3Mgr.CheckDungeonLevelIsUnLock = function(levelId)
    local curTime = LuaMgr.Timestamp()
    local unlockTime = MiniBattle3Mgr.GetDungeonLevelUnlockTime(levelId)
    return unlockTime ~= 0 and curTime >= unlockTime
end


MiniBattle3Mgr.CheckCollectRed = function()
    local buffLevelCfgs = ConfigMgr.Config.DualBattleBuffLevelMap
    local redCount = 0
    for k, v in pairs(buffLevelCfgs) do
        if MiniBattle3Mgr.CheckBuffIsCanUpGrade(k) then
            redCount = 1
            break
        end
    end
    return redCount
end

MiniBattle3Mgr.CheckBuffIsCanUpGrade = function(buffLevelId)
    local buffLevelCfg = ConfigMgr.Config.DualBattleBuffLevelMap[buffLevelId]
    local maxBuffLevel = #buffLevelCfg.GroupId
    local curBuffLevel = MiniBattle3Mgr.GetBuffLevel(buffLevelId)
    if curBuffLevel >= maxBuffLevel then
        return false
    end

    local cost = ConfigMgr.Config.constants.DualBattleCoin
    local costCount = buffLevelCfg.Cost[curBuffLevel]
    local item = DataMgr.Player.items[cost];
    local itemCount = item ~= nil and item.count0 or 0;
    return itemCount >= costCount
end

MiniBattle3Mgr.GetBuffLevel = function(buffLevelId)
    local miniBattleData = MiniBattle3Mgr.GetMiniBattle3Data()
    if IsNull(miniBattleData.buffLevel) or miniBattleData.buffLevel[buffLevelId] == nil then
        return 1
    end
    return miniBattleData.buffLevel[buffLevelId]
end

MiniBattle3Mgr.GetBuffIdByLevelGroupId = function(buffLevelId)
    local level = MiniBattle3Mgr.GetBuffLevel(buffLevelId)
    local buffLevelCfg = ConfigMgr.Config.DualBattleBuffLevelMap[buffLevelId]
    return buffLevelCfg.GroupId[level]
end

MiniBattle3Mgr.CheckAllDungeonRewardRed = function()
    local dungeonCfgs = MiniBattle3Mgr.GetMiniBattleCfgs()
    local redCount = 0
    for i, v in ipairs(dungeonCfgs) do
        if MiniBattle3Mgr.CheckDungeonRewardRed(v.ID) then
            redCount = 1
            break
        end
    end
    return redCount
end

MiniBattle3Mgr.CheckDungeonRewardRed = function(plotId)
    local plotCfg = ConfigMgr.Config.DualBattleMap[plotId]
    local enemyLevelList = plotCfg.EnemyOption
    for i, v in ipairs(enemyLevelList) do
        if MiniBattle3Mgr.GetDungeonLevelRewardStatus(v) == 0 then
            return true
        end
    end
    return false
end


MiniBattle3Mgr.GetDungeonLevelRewardStatus = function(levelId)
    local data = MiniBattle3Mgr.GetMiniBattle3Data()
    if not IsNull(data.reward) and data.reward[levelId] ~= nil then
        return 2
    elseif not IsNull(data.finish) and data.finish[levelId] ~= nil then
        return 0
    end
    return 1
end

MiniBattle3Mgr.GetDungeonAllEnemyBuff = function(plotId)
    local plotCfg = ConfigMgr.Config.DualBattleMap[plotId]
    local maxLevelId = plotCfg.EnemyOption[#plotCfg.EnemyOption]
    local levelCfg = ConfigMgr.Config.DualBattleBuffMap[maxLevelId]
    return levelCfg.BuffGroup
end

MiniBattle3Mgr.GetChooseBuffListByPlotId = function(plotId)
    local PlayerPrefsKey = "MiniBattle3Buffs" .. DataMgr.Player.uid
    local buffListStr = PlayerPrefs.GetString(PlayerPrefsKey .. plotId, "")

    local selfBuff = {}
    local levelId = ""
    if not IsNullOrEmpty(buffListStr) then
        local list = NumTool.split(buffListStr, ";");
        if #list > 0 then
            local tempList = NumTool.split(list[1], ",");
            for i, v in ipairs(tempList) do
                if not IsNullOrEmpty(v) then
                    table.insert(selfBuff, v)
                end
            end
        end
        if #list > 1 then
            levelId = list[2]
        end
    end
    if IsNullOrEmpty(levelId) or not MiniBattle3Mgr.CheckDungeonLevelIsUnLock(levelId) then
        levelId = MiniBattle3Mgr.GetCurMaxDungeonLevelId(plotId)
    end
    return selfBuff, levelId
end

MiniBattle3Mgr.SaveChooseBuffList = function(plotId, enemyLevelId, selfBuffGroupIds)
    local selfBuffStr = ""
    for i, v in ipairs(selfBuffGroupIds) do
        selfBuffStr = selfBuffStr .. v .. ","
    end
    local buffListStr = string.format("%s;%s", selfBuffStr, enemyLevelId)
    local PlayerPrefsKey = "MiniBattle3Buffs" .. DataMgr.Player.uid
    PlayerPrefs.SetString(PlayerPrefsKey .. plotId, buffListStr)
    PlayerPrefs.Save()
end


MiniBattle3Mgr.GetCurMaxDungeonLevelId = function(plotId)
    local plotCfg = ConfigMgr.Config.DualBattleMap[plotId]
    local enemyLevelList = plotCfg.EnemyOption
    local curLevelId = ""
    for i = #enemyLevelList, 1, -1 do
        local levelId = enemyLevelList[i]
        if MiniBattle3Mgr.GetDungeonLevelRewardStatus(levelId) ~= 1 then
            curLevelId = levelId
        end
        if MiniBattle3Mgr.CheckDungeonLevelIsUnLock(levelId) then
            curLevelId = levelId
        end
    end
    if IsNullOrEmpty(curLevelId) then
        curLevelId = enemyLevelList[1]
    end
    return curLevelId
end

MiniBattle3Mgr.GetBuffCardInfo = function(id)
    local buffCardInfo = {
        id = id,
        buffId = "",
        name = "",
        desc = "",
        icon = DefaultTexture,
    }
    local buffDescCfg = ConfigMgr.Config.DualBattleBuffDescMap[id]
    if buffDescCfg ~= nil then
        buffCardInfo = {
            id = id,
            buffId = buffDescCfg.BuffId,
            name = LuaMgr.GetLangText(buffDescCfg.BuffNamelan),
            desc = LuaMgr.GetLangText(buffDescCfg.BuffDeslan),
            icon = LuaMgr.GetSprite("BuffIcon", buffDescCfg.BuffIcon),
        }
    end
    return buffCardInfo
end


MiniBattle3Mgr.GetRewards = function(plotId, callback)
    ApiMgr.Request("dualBattle/getRewards", { ID = plotId }, true, callback, nil, true, true);
end


MiniBattle3Mgr.UpGradeBuffLevel = function(buffLevelId, level, callback)
    ApiMgr.Request("dualBattle/buffLevel", { BuffId = buffLevelId, Level = level }, true, callback, nil, true, true);
end