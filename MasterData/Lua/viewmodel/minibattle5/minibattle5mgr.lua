MiniBattle5Mgr = {
    activityGroupId = 3092,
}

local this = {
selectMembers = {},
assistMembers = {},
    savedPlotMaxScores = nil,
    curBattleScore = 0,
};

MiniBattle5Mgr.GetMiniBattleNewData = function()
    local data = {}
    if not IsNull(DataMgr.Player.MiniBattleNews) and not IsNull(DataMgr.Player.MiniBattleNews[tostring(MiniBattle5Mgr.activityGroupId)]) then
        data = DataMgr.Player.MiniBattleNews[tostring(MiniBattle5Mgr.activityGroupId)]
    end
    return data
end


MiniBattle5Mgr.GetRewards = function(plotId, callback)
    ApiMgr.Request("miniBattleNew/getRewards", { ID = plotId }, true, callback, nil, true, true);
end

MiniBattle5Mgr.GetLockMembersAndHelps = function(battleId)
    local members = {};
    local helps = {};
    local miniBattleData = MiniBattle5Mgr.GetMiniBattleNewData()
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

MiniBattle5Mgr.GetAnotherPlotId = function(plotId)
    local anotherPlotId = ""
    local plotCfg = ConfigMgr.Config.MiniBattleNewMap[plotId]
    if TableIsNull(plotCfg) then
        return anotherPlotId
    end
    local seriesid = plotCfg.SeriesId
    local plotCfgs = ConfigMgr.Config.MiniBattleNewMap
    for k, v in pairs(plotCfgs) do
        if v.SeriesId == seriesid and v.ID ~= plotCfg.ID then
            anotherPlotId = v.ID
            break
        end
    end
    return anotherPlotId
end

MiniBattle5Mgr.GetTotalScore = function()
    local miniBattleNew = MiniBattle5Mgr.GetMiniBattleNewData()
    local scores = miniBattleNew.scores;
    if (IsNull(scores)) then
        return 0
    end

    local totalScore = 0
    for k, v in pairs(scores) do
        totalScore = totalScore + v
    end

    return totalScore
end

MiniBattle5Mgr.GetDungeonScore = function(dungeonId)
    local miniBattleNew = MiniBattle5Mgr.GetMiniBattleNewData()
    if (IsNull(miniBattleNew.max)) then
        return 0
    end

    local score = miniBattleNew.max[dungeonId];
    if (IsNull(score)) then
        return 0
    end
    return score
end

MiniBattle5Mgr.GetHistoryPlotScore = function(plotId)
    if IsNull(this.savedPlotMaxScores) or IsNull(this.savedPlotMaxScores[plotId]) then
        return 0
    end
    return this.savedPlotMaxScores[plotId]
end

MiniBattle5Mgr.SavePlotScores = function(score)
    if MiniBattle5Mgr.CheckDailyBattleCount() then
        this.curBattleScore = score
    else
        this.curBattleScore = 0
    end
    local miniBattleNew = MiniBattle5Mgr.GetMiniBattleNewData()
    this.savedPlotMaxScores = table.Copy(miniBattleNew.max)
end

MiniBattle5Mgr.GetCurBattleScore = function()
    return this.curBattleScore
end

MiniBattle5Mgr.GetDailyBattleCount = function()
    local miniBattleNew = MiniBattle5Mgr.GetMiniBattleNewData()
    if IsNull(miniBattleNew.times) then
        return 0
    end
    return miniBattleNew.times
end

MiniBattle5Mgr.CheckDailyBattleCount = function()
    local dailyTotalCount = ConfigMgr.Config.constants.MiniBattleNewLimit
    local dailyUseCount = MiniBattle5Mgr.GetDailyBattleCount()
    return dailyUseCount < dailyTotalCount
end

MiniBattle5Mgr.GetMiniBattleCfgs = function()
    local ConfigList = {}
    for k, v in pairs(ConfigMgr.Config.MiniBattleNewMap) do
        if v.ActivityGroup == MiniBattle5Mgr.activityGroupId then
            table.insert(ConfigList, v)
        end
    end
    table.sort(ConfigList, function(a, b)
        return a.ID < b.ID
    end)
    return ConfigList
end

MiniBattle5Mgr.GetDungeonUnlockTime = function(plotId)
    local startTime = 0
    local activityData = DataExHelper.GetDataExByTag(ActivityKey.MiniBattle5)
    if activityData ~= nil then
        startTime = activityData.startTime
    end
    local plotCfg = ConfigMgr.Config.MiniBattleNewMap[plotId]
    if TableIsNull(plotCfg) then
        return 0
    end
    local delayTime = plotCfg.Delay * 24 * 60 * 60
    local leftTime = startTime + delayTime
    return leftTime
end

MiniBattle5Mgr.GetDungeonLevelUnlockTime = function(levelId)
    local startTime = 0
    local activityData = DataExHelper.GetDataExByTag(ActivityKey.MiniBattle5)
    if activityData ~= nil then
        startTime = activityData.startTime
    end
    local levelCfg = ConfigMgr.Config.MiniBattleNewBuffMap[levelId]
    if TableIsNull(levelCfg) then
        return 0
    end
    local delayTime = levelCfg.Delay * 24 * 60 * 60
    local leftTime = startTime + delayTime
    return leftTime
end

MiniBattle5Mgr.CheckDungeonLevelIsUnLock = function(levelId)
    local curTime = LuaMgr.Timestamp()
    local unlockTime = MiniBattle5Mgr.GetDungeonLevelUnlockTime(levelId)
    return unlockTime ~= 0 and curTime >= unlockTime
end

MiniBattle5Mgr.CheckAllDungeonRewardRed = function()
    local dungeonCfgs = MiniBattle5Mgr.GetMiniBattleCfgs()
    local redCount = 0
    for i, v in ipairs(dungeonCfgs) do
        if MiniBattle5Mgr.CheckDungeonRewardRed(v.ID) then
            redCount = 1
            break
        end
    end
    return redCount
end

MiniBattle5Mgr.CheckDungeonRewardRed = function(plotId)
    local plotCfg = ConfigMgr.Config.MiniBattleNewMap[plotId]
    local enemyLevelList = plotCfg.EnemyOption
    for i, v in ipairs(enemyLevelList) do
        if MiniBattle5Mgr.GetDungeonLevelRewardStatus(v) == 0 then
            return true
        end
    end
    return false
end


MiniBattle5Mgr.GetDungeonLevelRewardStatus = function(levelId)
    local data = MiniBattle5Mgr.GetMiniBattleNewData()
    if not IsNull(data.reward) and data.reward[levelId] ~= nil then
        return 2
    elseif not IsNull(data.finish) and data.finish[levelId] ~= nil then
        return 0
    end
    return 1
end

MiniBattle5Mgr.GetDungeonAllEnemyBuff = function(plotId)
    local plotCfg = ConfigMgr.Config.MiniBattleNewMap[plotId]
    local maxLevelId = plotCfg.EnemyOption[#plotCfg.EnemyOption]
    local levelCfg = ConfigMgr.Config.MiniBattleNewBuffMap[maxLevelId]
    return levelCfg.BuffGroup
end

MiniBattle5Mgr.GetChooseBuffListByPlotId = function(plotId)
    local PlayerPrefsKey = "MiniBattleNewBuffs" .. DataMgr.Player.uid
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
    if IsNullOrEmpty(levelId) or not MiniBattle5Mgr.CheckDungeonLevelIsUnLock(levelId) then
        levelId = MiniBattle5Mgr.GetCurMaxDungeonLevelId(plotId)
    end
    return selfBuff, levelId
end

MiniBattle5Mgr.SaveChooseBuffList = function(plotId, enemyLevelId, selfBuff)
    local selfBuffStr = ""
    for i, v in ipairs(selfBuff) do
        selfBuffStr = selfBuffStr .. v .. ","
    end
    local buffListStr = string.format("%s;%s", selfBuffStr, enemyLevelId)
    local PlayerPrefsKey = "MiniBattleNewBuffs" .. DataMgr.Player.uid
    PlayerPrefs.SetString(PlayerPrefsKey .. plotId, buffListStr)
    PlayerPrefs.Save()
end

MiniBattle5Mgr.GetCurMaxDungeonLevelId = function(plotId)
    local plotCfg = ConfigMgr.Config.MiniBattleNewMap[plotId]
    local enemyLevelList = plotCfg.EnemyOption
    local curLevelId = ""
    for i = #enemyLevelList, 1, -1 do
        local levelId = enemyLevelList[i]
        if MiniBattle5Mgr.GetDungeonLevelRewardStatus(levelId) ~= 1 then
            return curLevelId
        end
        if MiniBattle5Mgr.CheckDungeonLevelIsUnLock(levelId) then
            curLevelId = levelId
        end
    end
    return curLevelId
end

MiniBattle5Mgr.GetBuffCardInfo = function(id)
    local buffCardInfo = {
        id = id,
        buffId = "",
        name = "",
        desc = "",
        icon = DefaultTexture,
        quality = 0,
    }
    local buffDescCfg = ConfigMgr.Config.MiniBattleNewBuffDescMap[id]
    if buffDescCfg ~= nil then
        buffCardInfo = {
            id = id,
            buffId = buffDescCfg.BuffId,
            name = LuaMgr.GetLangText(buffDescCfg.BuffNamelan),
            desc = LuaMgr.GetLangText(buffDescCfg.BuffDeslan),
            icon = LuaMgr.GetTexture("Assets/_BundleResources/Images/MoreModIcon/" .. buffDescCfg.BuffIcon .. ".png"),
            quality = buffDescCfg.BuffQuality
        }
    end
    return buffCardInfo
end