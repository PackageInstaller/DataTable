CrisisContract4Mgr = {
    activityGroupId = 4202,
}

local this = {
selectMembers = {},
assistMembers = {},

    curBattleScore = 0,
    playerPrefsKey = "",
    plotDungeonMaxScoreMap = nil,
    leftDailyChallengeCount = 0,
};


CrisisContract4Mgr.SaveCurBattleScore = function(plotId, score)
    this.curBattleScore = score
    local curPlotData = CrisisContract4Mgr.GetPlotData(plotId)
    this.plotDungeonMaxScoreMap = nil
    if curPlotData ~= nil and not IsNull(curPlotData.DungeonId4MaxScore) then
        this.plotDungeonMaxScoreMap = table.Copy(curPlotData.DungeonId4MaxScore)
        this.leftDailyChallengeCount = CrisisContract4Mgr.GetDailyLeftTimes(plotId)
    end
end

CrisisContract4Mgr.GetCurBattleScore = function()
    return this.curBattleScore
end

CrisisContract4Mgr.GetHistoryPlotScore = function(dungeonId)
    if IsNull(this.plotDungeonMaxScoreMap) or IsNull(this.plotDungeonMaxScoreMap[dungeonId]) then
        return 0
    end
    return this.plotDungeonMaxScoreMap[dungeonId]
end

CrisisContract4Mgr.IsShowNoBattleCountTips = function()
    return this.leftDailyChallengeCount == 0
end



CrisisContract4Mgr.GetPlotConfig = function(plotId)
    local plotCfg = ConfigMgr.Config.TeamRelayMap[plotId]
    if plotCfg ~= nil and plotCfg.ActivityGroup == CrisisContract4Mgr.activityGroupId then
        return plotCfg
    end
end

CrisisContract4Mgr.GetLevelCfg = function(levelId)
    return ConfigMgr.Config.TeamRelayGroupMap[tostring(levelId)]
end

CrisisContract4Mgr.GetDungeonCfg = function(dungeonId)
    return ConfigMgr.Config.TeamRelayDungeonMap[tostring(dungeonId)]
end

CrisisContract4Mgr.GetBuffGroupConfig = function(buffGroupId)
    return ConfigMgr.Config.TeamRelayBuffGroupMap[tostring(buffGroupId)]
end

CrisisContract4Mgr.GetBuffDescCfg = function(buffDescId)
    return ConfigMgr.Config.TeamRelayBuffDescMap[tostring(buffDescId)]
end

CrisisContract4Mgr.GetBuffMaxLevel = function(buffGroupId)
    local maxLevel = 0
    local buffGroupCfg = CrisisContract4Mgr.GetBuffGroupConfig(buffGroupId)
    if buffGroupCfg ~= nil then
        maxLevel = buffGroupCfg.Initial
    end
    return maxLevel
end

CrisisContract4Mgr.GetBuffInfoByLevel = function(buffGroupId, level)
    local buffInfo = nil
    local buffGroupCfg = CrisisContract4Mgr.GetBuffGroupConfig(buffGroupId)
    if buffGroupCfg ~= nil then
        local tempLevel = level == 0 and 1 or level
        local buffId = buffGroupCfg.Buff[tempLevel]
        local buffCfg = CrisisContract4Mgr.GetBuffDescCfg(buffId)
        if buffCfg ~= nil then
            buffInfo = {
                BuffId = buffId,
                Level = level,
                Icon = LuaMgr.GetSprite("BuffIcon", buffCfg.BuffIcon),
                Name = LuaMgr.GetLangText(buffCfg.BuffNameLan),
                Desc = LuaMgr.GetLangText(buffCfg.BuffDesLan),
                AttrStr = (level > 0 and next(buffCfg.Param) ~= nil) and buffCfg.Param[1] or "",
            }
        end
    end
    return buffInfo
end

CrisisContract4Mgr.GetBuffIdByLevel = function(buffGroupId, level)
    local buffId = ""
    local buffGroupCfg = CrisisContract4Mgr.GetBuffGroupConfig(buffGroupId)
    if buffGroupCfg ~= nil then
        local tempLevel = level == 0 and 1 or level
        buffId = buffGroupCfg.Buff[tempLevel]
    end
    return buffId
end

CrisisContract4Mgr.GetBuffScoreByLevel = function(buffGroupId, level)
    local buffGroupCfg = CrisisContract4Mgr.GetBuffGroupConfig(buffGroupId)
    local Score = level > 0 and buffGroupCfg.Credit[level] or 0
    return Score
end

CrisisContract4Mgr.GetLevelUnlockTime = function(levelId)
    local startTime = 0
    local activityData = DataExHelper.GetDataExByTag(ActivityKey.TeamRelay3)
    if activityData ~= nil then
        startTime = activityData.startTime
    end
    local cfg = CrisisContract4Mgr.GetLevelCfg(levelId)
    if TableIsNull(cfg) then
        return 0
    end
    local delay = TableIsNull(cfg.Lock) and 0 or cfg.Lock[1]
    local delayTime = delay * 24 * 60 * 60
    local leftTime = startTime + delayTime
    return leftTime
end

CrisisContract4Mgr.GetTeamIdByActivityDungeonId = function(teamRelayDungeonId)
    local teamId = "1"
    local dungeonCfg = CrisisContract4Mgr.GetDungeonCfg(teamRelayDungeonId)
    local levelCfg = CrisisContract4Mgr.GetLevelCfg(dungeonCfg.DiffId)
    for i, v in ipairs(levelCfg.DungeonGroupId) do
        if v == teamRelayDungeonId then
            teamId = tostring(i)
        end
    end
    return teamId
end

CrisisContract4Mgr.GetLeftTimeStr = function(time)
    local day, hour, minute = GetTimeDHM(time)
    local timeStr = ""
    if IsNullOrEmpty(day) then
        timeStr = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10209"].NameLan), hour, minute)
    else
        timeStr = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10208"].NameLan), day, hour)
    end
    return timeStr
end

CrisisContract4Mgr.GetPlotIdByDungeonId = function(dungeonId)
    local dungeonCfg = CrisisContract4Mgr.GetDungeonCfg(dungeonId)
    local levelCfg = CrisisContract4Mgr.GetLevelCfg(dungeonCfg.DiffId)
    return levelCfg.TeamRelayId
end


CrisisContract4Mgr.GetPlotData = function(plotId)
    if not IsNull(DataMgr.Player.TeamRelays) and DataMgr.Player.TeamRelays[tostring(plotId)] ~= nil then
        return DataMgr.Player.TeamRelays[tostring(plotId)]
    end
end

CrisisContract4Mgr.GetDailyLeftTimes = function(plotId)
    local challengeCount, totalTimes = 0, 0
    local teamRelayMap = ConfigMgr.Config.TeamRelayMap
    for k, plotCfg in pairs(teamRelayMap) do
        if plotCfg.ActivityGroup == CrisisContract4Mgr.activityGroupId then
            local plotData = TeamRelay2Mgr.GetPlotData(k)
            totalTimes = plotCfg.Limit
            if plotId ~= nil and plotCfg.ShareLimit == 0 then
                challengeCount = plotData.ChallengeCount
                break
            else
                challengeCount = challengeCount + plotData.ChallengeCount
            end
        end
    end
    return totalTimes - challengeCount, totalTimes
end

CrisisContract4Mgr.GetTotalScore = function()
    local totalScore = 0
    local teamRelayMap = ConfigMgr.Config.TeamRelayMap
    for k, v in pairs(teamRelayMap) do
        if v.ActivityGroup == CrisisContract4Mgr.activityGroupId then
            local plotData = CrisisContract4Mgr.GetPlotData(v.Id)
            if plotData ~= nil then
                totalScore = totalScore + plotData.Score
            end
        end
    end
    return totalScore
end

CrisisContract4Mgr.GetTotalMaxScore = function()
    local totalScore = 0
    local teamRelayMap = ConfigMgr.Config.TeamRelayMap
    for k, v in pairs(teamRelayMap) do
        if v.ActivityGroup == CrisisContract4Mgr.activityGroupId then
            local plotData = CrisisContract4Mgr.GetPlotData(v.Id)
            if plotData ~= nil then
                for i, v in pairs(plotData.DungeonId4MaxScore) do
                    totalScore = totalScore + v
                end
            end
        end
    end
    return totalScore
end

CrisisContract4Mgr.GetDungeonHighestScore = function(dungeonId)
    local plotId = CrisisContract4Mgr.GetPlotIdByDungeonId(dungeonId)
    local plotData = CrisisContract4Mgr.GetPlotData(plotId)
    if plotData ~= nil and not IsNull(plotData.DungeonId4MaxScore) and plotData.DungeonId4MaxScore[dungeonId] ~= nil then
        return plotData.DungeonId4MaxScore[dungeonId]
    end
    return 0
end

CrisisContract4Mgr.GetDungeonRewardStatus = function(dungeonId)
    local plotId = CrisisContract4Mgr.GetPlotIdByDungeonId(dungeonId)
    local plotData = CrisisContract4Mgr.GetPlotData(plotId)
    if plotData ~= nil and not IsNull(plotData.DungeonId4Reward) and plotData.DungeonId4Reward[dungeonId] ~= nil then
        return plotData.DungeonId4Reward[dungeonId] + 1
    end
    return 0
end

CrisisContract4Mgr.GetChooseBuffList = function(dungeonId)
    if IsNullOrEmpty(this.playerPrefsKey) then
        this.playerPrefsKey = "Contract4PlotBuffs" .. DataMgr.Player.uid
    end
    local buffListStr = PlayerPrefs.GetString(this.playerPrefsKey .. dungeonId, "")

    local selfBuff = {}
    local enemyBuff = {}
    if not IsNullOrEmpty(buffListStr) then
        local list = NumTool.split(buffListStr, ";");
        if #list > 0 then
            selfBuff = CrisisContract4Mgr.DecodeBuffStr(list[1])
        end
        if #list > 1 then
            enemyBuff = CrisisContract4Mgr.DecodeBuffStr(list[2])
        end
    end
    return selfBuff, enemyBuff
end

CrisisContract4Mgr.SaveChooseBuffList = function(dungeonId, enemyBuff, selfBuff)
    local selfBuffStr = CrisisContract2Mgr.EncodeBuffStr(selfBuff)
    local enemyBuffStr = CrisisContract2Mgr.EncodeBuffStr(enemyBuff)
    local buffListStr = string.format("%s;%s", selfBuffStr, enemyBuffStr)
    PlayerPrefs.SetString(this.playerPrefsKey .. dungeonId, buffListStr)
    PlayerPrefs.Save()
end

CrisisContract4Mgr.DecodeBuffStr = function(buffStr)
    local buffList = {}
    if IsNullOrEmpty(buffStr) then
        return buffList
    end
    local list = NumTool.split(buffStr, ",");
    for i, v in ipairs(list) do
        if not IsNullOrEmpty(v) then
            local buffInfo = NumTool.split(v, "|");
            local id = buffInfo[1]
            local level = tonumber(buffInfo[2])
            local buffItem = {
                Id = id,
                Level = level,
                MaxLevel = CrisisContract4Mgr.GetBuffMaxLevel(id),
            }
            table.insert(buffList, buffItem)
        end
    end
    return buffList
end

CrisisContract4Mgr.EncodeBuffStr = function(buffList)
    local buffListStr = ""
    local len = #buffList
    for i, v in ipairs(buffList) do
        if v.Level > 0 then
            local buffStr = string.format("%s|%s", v.Id, v.Level)
            buffListStr = buffListStr .. buffStr .. ","
        end
    end
    return buffListStr
end

CrisisContract4Mgr.GetLockMembersAndHelps = function(teamRelayDungeonId)
    local plotId = CrisisContract4Mgr.GetPlotIdByDungeonId(teamRelayDungeonId)
    local plotData = CrisisContract4Mgr.GetPlotData(plotId)
    local teamId = CrisisContract4Mgr.GetTeamIdByActivityDungeonId(teamRelayDungeonId)
    local members = {};
    local helps = {};
    if not IsNull(plotData) and not IsNull(plotData.Teams) then
        local teamData = plotData.Teams[teamId]
        if not IsNull(teamData) then
            local locks = teamData.Locks;
            if not IsNull(locks) then
                local lock = locks[teamRelayDungeonId];
                if not IsNull(lock) then
                    if (not IsNull(lock.Helps)) then
                        helps = lock.Helps;
                    end
                    if (not IsNull(lock.Members)) then
                        members = lock.Members;
                    end
                end
            end
        end
    end
    return members, helps
end

CrisisContract4Mgr.GetFilterMembers = function(teamRelayDungeonId)
    local filterMembers = {}
    local filterMembersTeamMap = {}
    local dungeonCfg = CrisisContract4Mgr.GetDungeonCfg(teamRelayDungeonId)
    local levelCfg = CrisisContract4Mgr.GetLevelCfg(dungeonCfg.DiffId)
    local teamIndex = 0
    for i, v in ipairs(levelCfg.DungeonGroupId) do
        if v ~= teamRelayDungeonId then
            local filters = ActivityBattlePrepareMgr.GetLockMembers(ActivityKey.TeamRelay3, v)
            for member, uid in pairs(filters) do
                filterMembers[member] = uid
                filterMembersTeamMap[member] = i
            end
        end
    end
    return filterMembers, filterMembersTeamMap
end

CrisisContract4Mgr.CheckAllDungeonRewardRed = function()
    local plotCfgMap = ConfigMgr.Config.TeamRelayMap
    for k, plotCfg in pairs(plotCfgMap) do
        for _, levelId in ipairs(plotCfg.Group) do
            if CrisisContract4Mgr.CheckLevelDungeonsRewardRed(levelId) then
                return true
            end
        end
    end
    return false
end

CrisisContract4Mgr.CheckLevelDungeonsRewardRed = function(levelId)
    local levelCfg = CrisisContract4Mgr.GetLevelCfg(levelId)
    for _, dungeonId in ipairs(levelCfg.DungeonGroupId) do
        if CrisisContract4Mgr.CheckDungeonRewardRed(dungeonId) then
            return true
        end
    end
    return false
end

CrisisContract4Mgr.CheckDungeonRewardRed = function(dungeonId)
    local dungeonCfg = CrisisContract4Mgr.GetDungeonCfg(dungeonId)
    local rewardStatus = CrisisContract4Mgr.GetDungeonRewardStatus(dungeonId)
    local highestScore = CrisisContract4Mgr.GetDungeonHighestScore(dungeonId)
    local creditList = ConfigMgr.Config.TeamRelayConstants.TeamRelay3Credit
    for i = 1, #creditList do
        if i > rewardStatus and highestScore >= creditList[i] then
            return true
        end
    end
    return false
end

CrisisContract4Mgr.GetMedalList = function()
    local medalConfigs = ConfigMgr.Config.Medals
    local tempList = {}
    for k, v in pairs(medalConfigs) do
        if v.Activity == tostring(CrisisContract4Mgr.activityGroupId) then
            local item = {
                icon = LuaMgr.GetSprite("ZhanXunIcon", v.Id),
                name = LuaMgr.GetLangText(v.NameLan),
                desc = LuaMgr.GetLangText(v.DesLan),
                remark = LuaMgr.GetLangText(v.RemarksLan),
                target = 0
            }
            if not TableIsNull(v.Condition) and not TableIsNull(v.Condition[1]) and v.Condition[1].UnlockType == 116 then
                item.target = tonumber(v.Condition[1].ElementID)
            end
            table.insert(tempList, item)
        end
    end
    return tempList
end



CrisisContract4Mgr.GetRewards = function(id, callback)
    ApiMgr.Request("teamRelay/teamRelayRewards3", { Id = id }, true, callback, nil, true, true);
end