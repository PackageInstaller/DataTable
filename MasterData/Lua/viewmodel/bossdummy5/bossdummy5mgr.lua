BossDummy5Mgr = {
    activityGroupId = 4092,
    plotChoosedBuffMap = {},
    plotChoosedLevelMap = {},
    save_best_level = "",
    save_highest_score = 0,
    filterMembersMap = {},
}

local this = {

};

BossDummy5Mgr.GetLockMembersAndHelps = function(plotId)
    local members = {}
    local helps = {}
    local plotRecords = DataMgr.Player.bossDummy3Records
    if not IsNull(plotRecords) then
        local record = plotRecords[plotId];
        if not IsNull(record) then
            if not IsNull(record.helps) then
                helps = record.helps;
            end
            if not IsNull(record.members) then
                members = record.members;
            end
        end
    end
    return members, helps
end

BossDummy5Mgr.GetAnotherPlotIds = function(plotId)
    local plotConfig = BossDummy5Mgr.GetPlotConfig(plotId)
    local anotherIds = {}
    if plotConfig.SeriesId ~= 0 then
        for _, v in ipairs(ConfigMgr.Config.BossDummy3s) do
            if v.SeriesId == plotConfig.SeriesId and v.Id ~= plotId then
                table.insert(anotherIds, v.Id)
            end
        end
    end
    return anotherIds
end

BossDummy5Mgr.GetFilterMembers = function(plotId)
    local filterMembers = {}
    local anotherBattleIndexs = BossDummy5Mgr.GetAnotherPlotIds(plotId)
    if anotherBattleIndexs ~= nil then
        for i, v in ipairs(anotherBattleIndexs) do
            local filters = ActivityBattlePrepareMgr.GetLockMembers(ActivityKey.BossDummy5, v)
            for member, uid in pairs(filters) do
                filterMembers[member] = uid
            end
        end
    end
    return filterMembers
end

BossDummy5Mgr.SetFilterMembersMap = function(plotId)
    BossDummy5Mgr.filterMembersMap = {}
    local plotConfig = BossDummy5Mgr.GetPlotConfig(plotId)
    local anotherIds = {}
    if plotConfig.SeriesId ~= 0 then
        for _, v in ipairs(ConfigMgr.Config.BossDummy3s) do
            if v.SeriesId == plotConfig.SeriesId then
                table.insert(anotherIds, v.Id)
            end
        end
    end
    if anotherIds ~= nil then
        for i, v in ipairs(anotherIds) do
            local filters = ActivityBattlePrepareMgr.GetLockMembers(ActivityKey.BossDummy5, v)
            for member, uid in pairs(filters) do
                BossDummy5Mgr.filterMembersMap[member] = i
            end
        end
    end
    return BossDummy5Mgr.filterMembersMap
end

BossDummy5Mgr.IsBossDungeon = function(levelId)
    local levelConfig = BossDummy5Mgr.GetLevelConfig(levelId)
    local plotConfig = BossDummy5Mgr.GetPlotConfig(levelConfig.BossDummy3Id)
    return plotConfig.Type > 0
end

BossDummy5Mgr.GetPlotConfig = function(plotId)
    for _, v in ipairs(ConfigMgr.Config.BossDummy3s) do
        if v.Id == plotId then
            return v
        end
    end
    return nil
end

BossDummy5Mgr.GetLevelConfig = function(buffId)
    local config = nil
    for _, v in ipairs(ConfigMgr.Config.BossDummy3Buffs) do
        if v.Id == buffId then
            config = v
            break
        end
    end
    return config
end

BossDummy5Mgr.GetBuffDescConfig = function(buffId)
    for _, v in ipairs(ConfigMgr.Config.BossDummy3BuffDesc) do
        if v.Id == buffId then
            return v
        end
    end
    return nil
end

BossDummy5Mgr.GetDungeonUnlockTime = function(plotId)
    local startTime = 0
    local activityData = DataExHelper.GetDataExByTag(ActivityKey.BossDummy5)
    if activityData ~= nil then
        startTime = activityData.startTime
    end
    local plotCfg = BossDummy5Mgr.GetPlotConfig(plotId)
    if TableIsNull(plotCfg) then
        return 0
    end
    local delayTime = plotCfg.Delay * 24 * 60 * 60
    local leftTime = startTime + delayTime
    return leftTime
end

BossDummy5Mgr.GetDungeonLevelUnlockTime = function(levelId)
    local startTime = 0
    local activityData = DataExHelper.GetDataExByTag(ActivityKey.BossDummy5)
    if activityData ~= nil then
        startTime = activityData.startTime
    end
    local levelCfg = BossDummy5Mgr.GetLevelConfig(levelId)
    if TableIsNull(levelCfg) then
        return 0
    end
    local delayTime = levelCfg.Delay * 24 * 60 * 60
    local leftTime = startTime + delayTime
    return leftTime
end

BossDummy5Mgr.GetLevelScoreRatePassStatus = function(Id)
    local plotRewards = DataMgr.Player.bossDummy3Rewards
    if not IsNull(plotRewards) then
        local record = plotRewards[Id];
        if not IsNull(record) then
            return true
        end
    end
    return false
end

BossDummy5Mgr.GetDungeonMaxLevel = function(plotId)
    local plotCfg = BossDummy5Mgr.GetPlotConfig(plotId)
    if TableIsNull(plotCfg) or plotCfg.Type ~= 0 or TableIsNull(plotCfg.EnemyOption) then
        return ""
    end
    local len = #plotCfg.EnemyOption
    for i = len, 1, -1 do
        local levelId = plotCfg.EnemyOption[i]
        local status = BossDummy5Mgr.GetPlotLevelStatus(levelId)
        if status == 0 or status == 2 then
            return levelId
        end
    end
    return ""
end

BossDummy5Mgr.GetDungeonMaxRating = function(plotId)
    local maxLevelId = BossDummy5Mgr.GetDungeonMaxLevel(plotId)
    if not IsNullOrEmpty(maxLevelId) then
        local levelCfg = BossDummy5Mgr.GetLevelConfig(maxLevelId)
        return levelCfg.OptionDesc
    end
    return ""
end

BossDummy5Mgr.GetDungeonMaxScore = function(plotId)
    local plotCfg = BossDummy5Mgr.GetPlotConfig(plotId)
    if TableIsNull(plotCfg) or plotCfg.Type ~= 1 or DataMgr.Player.bossDummy3Records[plotId] == nil then
        return 0
    end

    return DataMgr.Player.bossDummy3Records[plotId].maxDamage
end

BossDummy5Mgr.GetMainDungeonTotalScore = function(plotId)
    local totalDamage = DataMgr.Player.bossDummy3TotalDamageL[plotId]
    return totalDamage == nil and 0 or totalDamage
end

BossDummy5Mgr.GetBossDummy5TotalScore = function()
    local totalScore = 0;
    for _, v in ipairs(ConfigMgr.Config.BossDummy3s) do
        if v.ActivityGroup == 4092 then
            totalScore = totalScore + BossDummy5Mgr.GetMainDungeonTotalScore(v.Id)
        end
    end
    return totalScore
end

BossDummy5Mgr.GetBossDummy5HighestScore = function(plotId)
    if DataMgr.Player.bossDummy3Records[plotId] ~= nil then
        return DataMgr.Player.bossDummy3Records[plotId].maxDamage
    else
        return 0
    end
end

BossDummy5Mgr.GetBossDummy5TotalHighestScore = function()
    local damage = 0;
    for i, v in pairs(DataMgr.Player.bossDummy3Records) do
        damage = damage + v.maxDamage
    end
    return damage
end

BossDummy5Mgr.GetMainDungeonDailyEffectCount = function(plotId)
    local battleCount = DataMgr.Player.bossDummy3CountL[plotId]
    if battleCount == nil then
        battleCount = 0
    end
    return math.max(0, ConfigMgr.Config.constants.BossDummy3BossLimit - battleCount)
end

BossDummy5Mgr.SavePlotChoosedLevel = function(plotId, levelId)
    BossDummy5Mgr.plotChoosedLevelMap[plotId] = levelId
end

BossDummy5Mgr.GetPlotChoosedLevel = function(plotId)
    return BossDummy5Mgr.plotChoosedLevelMap[plotId]
end

BossDummy5Mgr.SavePlotChoosedBuff = function(plotId, buffId)
    BossDummy5Mgr.plotChoosedBuffMap[plotId] = buffId
end

BossDummy5Mgr.GetPlotChoosedBuff = function(plotId)
    return BossDummy5Mgr.plotChoosedBuffMap[plotId]
end

BossDummy5Mgr.SaveHighestScore = function(plotId)
    BossDummy3Mgr.save_highest_score = BossDummy5Mgr.GetDungeonMaxScore(plotId)
end

BossDummy5Mgr.GetSavedHighestScore = function()
    return BossDummy3Mgr.save_highest_score
end

BossDummy5Mgr.SaveBestLevel = function(plotId)
    BossDummy3Mgr.save_best_level = BossDummy5Mgr.GetDungeonMaxLevel(plotId)
end

BossDummy5Mgr.GetSavedBestLevel = function()
    return BossDummy3Mgr.save_best_level
end


BossDummy5Mgr.GetPlotLevelStatus = function(levelId)
    local plotRewards = DataMgr.Player.bossDummy3Rewards
    if not IsNull(plotRewards) then
        local record = plotRewards[levelId];
        if not IsNull(record) then
            if record.status == 0 then
                return 0
            else
                return 2
            end
        end
    else
        local levelCfg = BossDummy5Mgr.GetLevelConfig(levelId)
        local unlockTime = BossDummy5Mgr.GetDungeonLevelUnlockTime(levelId)
        local curTime = LuaMgr.Timestamp()
        if curTime >= unlockTime then
            return 1
        else
            return 3
        end
    end
    return 1
end

BossDummy5Mgr.GetIsUnlock = function(delay)
    local config = ConfigMgr.Config.activityGroup["4092"]
    if not TableIsNull(config) then
        local opentime = tonumber(config.startTimeUnix) + delay * 24 * 60 * 60;
        return LuaMgr.Timestamp() >= opentime
    end
end

BossDummy5Mgr.GetDelayTimeText = function(delay)
    local config = ConfigMgr.Config.activityGroup["4092"]


    local new_ts = config.startTimeUnix + delay * 24 * 60 * 60


    local new_t = os.date("*t", new_ts)


    return string.format(LuaMgr.GetLangText("BossDummy3Mgr_0"), new_t.month, new_t.day, new_t.hour)
end

BossDummy5Mgr.CheckPlotLevelIsLock = function(levelId)
    local plotRewards = DataMgr.Player.bossDummy3Rewards
    if not IsNull(plotRewards) then
        local record = plotRewards[levelId];
        if not IsNull(record) then
            return false
        end
    end
    local levelCfg = BossDummy5Mgr.GetLevelConfig(levelId)
    if IsNull(levelCfg.ScoreLock) or #levelCfg.ScoreLock <= 1 then
        return false
    end
    local scoreType = levelCfg.ScoreLock[1]
    local targetScore = tonumber(levelCfg.ScoreLock[2])
    local scoreCount = 0
    for _, v in ipairs(ConfigMgr.Config.BossDummy3Buffs) do
        local levelStatus = BossDummy5Mgr.GetPlotLevelStatus(v.Id)
        if (levelStatus == 0 or levelStatus == 2) and not IsNull(v.ScoreReward) and #v.ScoreReward >= 2 and v.ScoreReward[1] == scoreType then
            scoreCount = scoreCount + v.ScoreReward[2]
        end
    end
    return scoreCount < targetScore
end

BossDummy5Mgr.CheckPlotLevelRed = function()
    local plotIds = {}
    for _, v in ipairs(ConfigMgr.Config.BossDummy3s) do
        if v.ActivityGroup == 4092 then
            if BossDummy5Mgr.CheckPlotRed(v.Id) then
                return true
            end
        end
    end

    return false
end

BossDummy5Mgr.CheckPlotRed = function(plotId)
    local plotCfg = BossDummy5Mgr.GetPlotConfig(plotId)
    for i, levelId in ipairs(plotCfg.EnemyOption) do
        local levelStatus = BossDummy5Mgr.GetPlotLevelStatus(levelId)
        if levelStatus == 0 then
            return true
        end
    end
    return false
end

BossDummy5Mgr.CheckMissionRed = function()
    local missionRed = 0
    local isFinish = true
    local activityData = DataExHelper.Check_ConfigQuestEventByGroupId(4092)
    for index, value in ipairs(activityData) do
        local tempData = DataMgr.Player.quests[value.id]
        if tempData ~= nil then
            if tempData.state ~= 3 then
                isFinish = false
            end
            if tempData.state == 2 then
                missionRed = 1
            end
        end
    end
    return missionRed, isFinish
end

BossDummy5Mgr.Clear = function()
    BossDummy5Mgr.plotChoosedBuffMap = {}
    BossDummy5Mgr.plotChoosedLevelMap = {}
end

BossDummy5Mgr.UnlockMembers = function(id,callBack)
    local askData = {
        ID = id,
    }
    ApiMgr.Request("bossDummy3/clear", askData, true, function()
        if callBack ~= nil then
            callBack();
        end
    end, nil, true);
end

