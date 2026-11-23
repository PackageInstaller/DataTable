BossDummy4Mgr = {
    activityGroupId = 4091,
    plotChoosedBuffMap = {},
    plotChoosedLevelMap = {},
    save_best_level = "",
    save_highest_score = 0
}

local this = {

};

BossDummy4Mgr.GetLockMembersAndHelps = function(plotId)
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

BossDummy4Mgr.GetAnotherPlotIds = function(plotId)
    local plotConfig = BossDummy4Mgr.GetPlotConfig(plotId)
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

BossDummy4Mgr.GetFilterMembers = function(plotId)
    local filterMembers = {}
    local anotherBattleIndexs = BossDummy4Mgr.GetAnotherPlotIds(plotId)
    if anotherBattleIndexs ~= nil then
        for i, v in ipairs(anotherBattleIndexs) do
            local filters = ActivityBattlePrepareMgr.GetLockMembers(ActivityKey.BossDummy4, v)
            for member, uid in pairs(filters) do
                filterMembers[member] = uid
            end
        end
    end
    return filterMembers
end

BossDummy4Mgr.IsBossDungeon = function(levelId)
    local levelConfig = BossDummy4Mgr.GetLevelConfig(levelId)
    local plotConfig = BossDummy4Mgr.GetPlotConfig(levelConfig.BossDummy3Id)
    return plotConfig.Type > 0
end

BossDummy4Mgr.GetPlotConfig = function(plotId)
    for _, v in ipairs(ConfigMgr.Config.BossDummy3s) do
        if v.Id == plotId then
            return v
        end
    end
    return nil
end

BossDummy4Mgr.GetLevelConfig = function(buffId)
    local config = nil
    for _, v in ipairs(ConfigMgr.Config.BossDummy3Buffs) do
        if v.Id == buffId then
            config = v
            break
        end
    end
    return config
end

BossDummy4Mgr.GetBuffDescConfig = function(buffId)
    for _, v in ipairs(ConfigMgr.Config.BossDummy3BuffDesc) do
        if v.Id == buffId then
            return v
        end
    end
    return nil
end

BossDummy4Mgr.GetDungeonUnlockTime = function(plotId)
    local startTime = 0
    local activityData = DataExHelper.GetDataExByTag(ActivityKey.BossDummy4)
    if activityData ~= nil then
        startTime = activityData.startTime
    end
    local plotCfg = BossDummy4Mgr.GetPlotConfig(plotId)
    if TableIsNull(plotCfg) then
        return 0
    end
    local delayTime = plotCfg.Delay * 24 * 60 * 60
    local leftTime = startTime + delayTime
    return leftTime
end

BossDummy4Mgr.GetDungeonLevelUnlockTime = function(levelId)
    local startTime = 0
    local activityData = DataExHelper.GetDataExByTag(ActivityKey.BossDummy4)
    if activityData ~= nil then
        startTime = activityData.startTime
    end
    local levelCfg = BossDummy4Mgr.GetLevelConfig(levelId)
    if TableIsNull(levelCfg) then
        return 0
    end
    local delayTime = levelCfg.Delay * 24 * 60 * 60
    local leftTime = startTime + delayTime
    return leftTime
end

BossDummy4Mgr.GetLevelScoreRatePassStatus = function(Id)
    local plotRewards = DataMgr.Player.bossDummy3Rewards
    if not IsNull(plotRewards) then
        local record = plotRewards[Id];
        if not IsNull(record) then
            return true
        end
    end
    return false
end

BossDummy4Mgr.GetDungeonMaxLevel = function(plotId)
    local plotCfg = BossDummy4Mgr.GetPlotConfig(plotId)
    if TableIsNull(plotCfg) or plotCfg.Type ~= 0 or TableIsNull(plotCfg.EnemyOption) then
        return ""
    end
    local len = #plotCfg.EnemyOption
    for i = len, 1, -1 do
        local levelId = plotCfg.EnemyOption[i]
        local status = BossDummy4Mgr.GetPlotLevelStatus(levelId)
        if status == 0 or status == 2 then
            return levelId
        end
    end
    return ""
end

BossDummy4Mgr.GetDungeonMaxRating = function(plotId)
    local maxLevelId = BossDummy4Mgr.GetDungeonMaxLevel(plotId)
    if not IsNullOrEmpty(maxLevelId) then
        local levelCfg = BossDummy4Mgr.GetLevelConfig(maxLevelId)
        return levelCfg.OptionDesc
    end
    return ""
end

BossDummy4Mgr.GetDungeonMaxScore = function(plotId)
    local plotCfg = BossDummy4Mgr.GetPlotConfig(plotId)
    if TableIsNull(plotCfg) or plotCfg.Type ~= 1 or DataMgr.Player.bossDummy3Records[plotId] == nil then
        return 0
    end

    return DataMgr.Player.bossDummy3Records[plotId].maxDamage
end

BossDummy4Mgr.GetMainDungeonTotalScore = function(plotId)
    local totalDamage = DataMgr.Player.bossDummy3TotalDamageL[plotId]
    return totalDamage == nil and 0 or totalDamage
end

BossDummy4Mgr.GetBossDummy4TotalScore = function()
    local totalScore = BossDummy4Mgr.GetMainDungeonTotalScore("2004") +
            BossDummy4Mgr.GetMainDungeonTotalScore("2008")
    if totalScore > 2147483647 then
        totalScore = 2147483647
    end
    return totalScore
end

BossDummy4Mgr.GetMainDungeonDailyEffectCount = function(plotId)
    local battleCount = DataMgr.Player.bossDummy3CountL[plotId]
    if battleCount == nil then
        battleCount = 0
    end
    return math.max(0, ConfigMgr.Config.constants.BossDummy3BossLimit - battleCount)
end

BossDummy4Mgr.SavePlotChoosedLevel = function(plotId, levelId)
    BossDummy4Mgr.plotChoosedLevelMap[plotId] = levelId
end

BossDummy4Mgr.GetPlotChoosedLevel = function(plotId)
    return BossDummy4Mgr.plotChoosedLevelMap[plotId]
end

BossDummy4Mgr.SavePlotChoosedBuff = function(plotId, buffId)
    BossDummy4Mgr.plotChoosedBuffMap[plotId] = buffId
end

BossDummy4Mgr.GetPlotChoosedBuff = function(plotId)
    return BossDummy4Mgr.plotChoosedBuffMap[plotId]
end

BossDummy4Mgr.SaveHighestScore = function(plotId)
    BossDummy3Mgr.save_highest_score = BossDummy4Mgr.GetDungeonMaxScore(plotId)
end

BossDummy4Mgr.GetSavedHighestScore = function()
    return BossDummy3Mgr.save_highest_score
end

BossDummy4Mgr.SaveBestLevel = function(plotId)
    BossDummy3Mgr.save_best_level = BossDummy4Mgr.GetDungeonMaxLevel(plotId)
end

BossDummy4Mgr.GetSavedBestLevel = function()
    return BossDummy3Mgr.save_best_level
end


BossDummy4Mgr.GetPlotLevelStatus = function(levelId)
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
        local levelCfg = BossDummy4Mgr.GetLevelConfig(levelId)
        local unlockTime = BossDummy4Mgr.GetDungeonLevelUnlockTime(levelId)
        local curTime = LuaMgr.Timestamp()
        if curTime >= unlockTime then
            return 1
        else
            return 3
        end
    end
    return 1
end

BossDummy4Mgr.CheckPlotLevelIsLock = function(levelId)
    local plotRewards = DataMgr.Player.bossDummy3Rewards
    if not IsNull(plotRewards) then
        local record = plotRewards[levelId];
        if not IsNull(record) then
            return false
        end
    end
    local levelCfg = BossDummy4Mgr.GetLevelConfig(levelId)
    if IsNull(levelCfg.ScoreLock) or #levelCfg.ScoreLock <= 1 then
        return false
    end
    local scoreType = levelCfg.ScoreLock[1]
    local targetScore = tonumber(levelCfg.ScoreLock[2])
    local scoreCount = 0
    for _, v in ipairs(ConfigMgr.Config.BossDummy3Buffs) do
        local levelStatus = BossDummy4Mgr.GetPlotLevelStatus(v.Id)
        if (levelStatus == 0 or levelStatus == 2) and not IsNull(v.ScoreReward) and #v.ScoreReward >= 2 and v.ScoreReward[1] == scoreType then
            scoreCount = scoreCount + v.ScoreReward[2]
        end
    end
    return scoreCount < targetScore
end

BossDummy4Mgr.CheckPlotLevelRed = function()
    local plotIds = {}
    for _, v in ipairs(ConfigMgr.Config.BossDummy3s) do
        if v.ActivityGroup == 4091 then
            if BossDummy4Mgr.CheckPlotRed(v.Id) then
                return true
            end
        end
    end

    return false
end

BossDummy4Mgr.CheckPlotRed = function(plotId)
    local plotCfg = BossDummy4Mgr.GetPlotConfig(plotId)
    for i, levelId in ipairs(plotCfg.EnemyOption) do
        if plotCfg.Type == 0 then
            local levelStatus = BossDummy4Mgr.GetPlotLevelStatus(levelId)
            if levelStatus == 0 then
                return true
            end
        end
    end
    return false
end

BossDummy4Mgr.CheckMissionRed = function()
    local missionRed = 0
    local isFinish = true
    local activityData = DataExHelper.Check_ConfigQuestEventByGroupId(4091)
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

BossDummy4Mgr.Clear = function()
    BossDummy4Mgr.plotChoosedBuffMap = {}
    BossDummy4Mgr.plotChoosedLevelMap = {}
end

