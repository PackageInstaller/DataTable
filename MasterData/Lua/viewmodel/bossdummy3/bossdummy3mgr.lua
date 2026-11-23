BossDummy3Mgr                          = {}
BossDummy3Mgr.save_owned_buff_list     = {}
BossDummy3Mgr.save_highest_score       = 0
BossDummy3Mgr.save_last_boss_rate_id   = nil
BossDummy3Mgr.cache_selected_buff_list = {}

function BossDummy3Mgr.Init()
    BossDummy3Mgr.save_owned_buff_list     = {}
    BossDummy3Mgr.save_highest_score       = 0
    BossDummy3Mgr.save_last_boss_rate_id   = nil
    BossDummy3Mgr.cache_selected_buff_list = {}
end

function BossDummy3Mgr.GetLockMembersAndHelps(Id)
    local members = {}
    local helps = {}
    local plotRecords = DataMgr.Player.bossDummy3Records
    if not IsNull(plotRecords) then
        local record = plotRecords[Id];
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

function BossDummy3Mgr.GetLevelScoreRatePassStatus(Id)
    local plotRewards = DataMgr.Player.bossDummy3Rewards
    if not IsNull(plotRewards) then
        local record = plotRewards[Id];
        if not IsNull(record) then
            return true
        end
    end
    return false
end

function BossDummy3Mgr.GetAnotherPlotId(id)
    local config = BossDummy3Mgr.GetStageConfig(id)
    local sid = config.SeriesId

    for _, v in ipairs(ConfigMgr.Config.BossDummy3s) do
        if v.SeriesId == sid and v.Id ~= id then
            return v.Id
        end
    end

    return nil
end

function BossDummy3Mgr.GetBossDummy3TodayEffectScoreCount()
    return math.max(0, ConfigMgr.Config.constants.BossDummy3BossLimit - DataMgr.Player.bossDummy3Count)
end

function BossDummy3Mgr.GetBossDummy3TodayLimitScoreCount()
    return ConfigMgr.Config.constants.BossDummy3BossLimit
end

function BossDummy3Mgr.GetBossDummy3StageBossMaxBuffCount()
    return #BossDummy3Mgr.GetOwnedBuffList()
end

function BossDummy3Mgr.GetBossDummy3HighestScore()
    if DataMgr.Player.bossDummy3Records["1005"] ~= nil then
        return DataMgr.Player.bossDummy3Records["1005"].maxDamage
    else
        return 0
    end
end

function BossDummy3Mgr.GetBossDummy3TotalScore()
    if DataMgr.Player.bossDummy3TotalDamage then
        return DataMgr.Player.bossDummy3TotalDamage
    else
        return 0
    end
end

function BossDummy3Mgr.GetStageConfig(id)
    for _, v in ipairs(ConfigMgr.Config.BossDummy3s) do
        if v.Id == id then
            return v
        end
    end
    return nil
end

function BossDummy3Mgr.GetBuffConfig(id)
    local config = nil
    for _, v in ipairs(ConfigMgr.Config.BossDummy3Buffs) do
        if v.Id == id then
            config = v
            break
        end
    end
    return config
end

function BossDummy3Mgr.GetBuffDescConfig(id)
    for _, v in ipairs(ConfigMgr.Config.BossDummy3BuffDesc) do
        if v.Id == id then
            return v
        end
    end
    return nil
end

function BossDummy3Mgr.GetPlotActivityGroupByLevelId(levelId)
    local levelCfg = BossDummy3Mgr.GetBuffConfig(levelId)
    local plotCfg = BossDummy3Mgr.GetStageConfig(levelCfg.BossDummy3Id)
    return plotCfg.ActivityGroup
end

function BossDummy3Mgr.GetDelayTimeText(delay)
    local config = ConfigMgr.Config.activityGroup["4090"]


    local new_ts = config.startTimeUnix + delay * 24 * 60 * 60


    local new_t = os.date("*t", new_ts)


    return string.format(LuaMgr.GetLangText("BossDummy3Mgr_0"), new_t.month, new_t.day, new_t.hour)
end

function BossDummy3Mgr.GetIsUnlock(delay)
    local config = ConfigMgr.Config.activityGroup["4090"]
    if not TableIsNull(config) then
        local opentime = tonumber(config.startTimeUnix) + delay * 24 * 60 * 60;
        return LuaMgr.Timestamp() >= opentime
    end
end

function BossDummy3Mgr.GetOwnedBuffList()
    local set = {}
    for k, v in pairs(DataMgr.Player.bossDummy3Rewards) do
        local config = BossDummy3Mgr.GetBuffConfig(k)
        for _, v2 in ipairs(config.BuffWin) do
            set[v2] = true
        end
    end
    local ret = {}
    for k, _ in pairs(set) do
        table.insert(ret, k)
    end
    return ret
end

function BossDummy3Mgr.SaveOwnedBuffList()
    BossDummy3Mgr.save_owned_buff_list = BossDummy3Mgr.GetOwnedBuffList()
end

function BossDummy3Mgr.GetSaveOwnedBuffList()
    return BossDummy3Mgr.save_owned_buff_list
end

function BossDummy3Mgr.IsBossDungeon(id)
    local buffConfig = BossDummy3Mgr.GetBuffConfig(id)
    local stageConfig = BossDummy3Mgr.GetStageConfig(buffConfig.BossDummy3Id)
    return stageConfig.Type > 0
end


function BossDummy3Mgr.GetBuffWinList(id)
    local ret = {}
    local arr = {}

    local config = BossDummy3Mgr.GetBuffConfig(id)
    for _, v in ipairs(ConfigMgr.Config.BossDummy3Buffs) do
        if v.BossDummy3Id == config.BossDummy3Id then
            table.insert(arr, v)
        end
    end

    for _, v in ipairs(arr) do
        table.move(v.BuffWin, 1, #v.BuffWin, #ret + 1, ret)
        if v.Id == id then
            break
        end
    end

    return ret
end

function BossDummy3Mgr.SaveBossDummy3HighestScore()
    BossDummy3Mgr.save_highest_score = BossDummy3Mgr.GetBossDummy3HighestScore()
end

function BossDummy3Mgr.GetBossDummy3SavedHighestScore()
    return BossDummy3Mgr.save_highest_score
end

function BossDummy3Mgr.GetConstantsBossDummy3BossPara()
    return ConfigMgr.Config.constants.BossDummy3BossPara
end

function BossDummy3Mgr.SaveLastBossRateId(id)
    BossDummy3Mgr.save_last_boss_rate_id = id
end

function BossDummy3Mgr.GetLastBossRateId()
    return BossDummy3Mgr.save_last_boss_rate_id
end

function BossDummy3Mgr.GetCacheSelectedBuffList()
    return BossDummy3Mgr.cache_selected_buff_list
end

function BossDummy3Mgr.SaveCacheSelectedBuffList(bufflist)
    BossDummy3Mgr.cache_selected_buff_list = {}
    for i, v in ipairs(bufflist) do
        table.insert(BossDummy3Mgr.cache_selected_buff_list, v)
    end
end

function BossDummy3Mgr.GetHighestScoreRewardStatus()
    for i, v in ipairs(DataExHelper.Check_ConfigQuestEventByGroupId(4090)) do
        if v.eventType == 809 then
            local state = DataExHelper.Check_RewardState(v.id)
            if state == 2 then
                return 1
            end
        end
    end
    return 0
end

function BossDummy3Mgr.GetTotalScoreRewardStatus()
    for i, v in ipairs(DataExHelper.Check_ConfigQuestEventByGroupId(4090)) do
        if v.eventType == 810 then
            local state = DataExHelper.Check_RewardState(v.id)
            if state == 2 then
                return 1
            end
        end
    end
    return 0
end

function BossDummy3Mgr.GetNormalLevelRewardStatus(id)
    for i, v in ipairs(ConfigMgr.Config.BossDummy3Buffs) do
        if id == v.BossDummy3Id then
            if BossDummy3Mgr.GetIsUnlock(v.Delay) then
                if DataMgr.Player.bossDummy3Rewards and DataMgr.Player.bossDummy3Rewards[v.Id] then
                    local a = DataMgr.Player.bossDummy3Rewards[v.Id]
                    if a.status == 0 then
                        return 1
                    end
                end
            end
        end
    end
    return 0
end

function BossDummy3Mgr.GetRedStatus()


    local getInt = PlayerPrefs.GetInt(DataMgr.Player.uid .. "BossDummy3_Enter_TimeStamp")
    if (getInt == 0) then
        return 1
    end











    local status = 0
    status = status + BossDummy3Mgr.GetHighestScoreRewardStatus()
    status = status + BossDummy3Mgr.GetTotalScoreRewardStatus()
    status = status + BossDummy3Mgr.GetNormalLevelRewardStatus("1001")
    status = status + BossDummy3Mgr.GetNormalLevelRewardStatus("1002")
    status = status + BossDummy3Mgr.GetNormalLevelRewardStatus("1003")
    status = status + BossDummy3Mgr.GetNormalLevelRewardStatus("1004")
    return status
end

function BossDummy3Mgr.GetTimezoneOffset()
    local now = os.time()
    local localTime = os.date("*t", now)
    local utcTime = os.date("!*t", now)
    localTime.isdst = false
    utcTime.isdst = false
    local localTimestamp = os.time(localTime)
    local utcTimestamp = os.time(utcTime)

    return localTimestamp - utcTimestamp
end

function BossDummy3Mgr.SaveEnterTimeStamp()
    PlayerPrefs.SetInt(DataMgr.Player.uid .. "BossDummy3_Enter_TimeStamp", LuaMgr.Timestamp())
end