TeamRelay2Mgr = {
    activityGroupId = 4201,
    plotIndexSprite = {
        ["420101"] = "ui_hd_srjh_zjm_img_01",
        ["420102"] = "ui_hd_srjh_zjm_img_02",
        ["420103"] = "ui_hd_srjh_zjm_img_03",
    },
    plotNameSprite = {
        ["420101"] = "ui_hd_srjh_zjm_txt_zfyx",
        ["420102"] = "ui_hd_srjh_zjm_txt_lyyx",
        ["420103"] = "ui_hd_srjh_zjm_txt_jlyx"
    },
}

TeamRelay2Mgr.LevelStatus = {
CanClaim = 0,
NotCompleted = 1,
Claimed = 2,
Locked = 3,
}

local this = {
    curDungeonHighScore = 0,
curChallengePlotId = "",
}


TeamRelay2Mgr.SaveCurDungeonHighScore = function(activityDungeonId)
    local score = TeamRelay2Mgr.GetDungeonHighestScore(activityDungeonId)
    this.curDungeonHighScore = score
end

TeamRelay2Mgr.GetCurDungeonHighScore = function()
    return this.curDungeonHighScore
end

TeamRelay2Mgr.SaveCurChallengePlotId = function(plotId)
    this.curChallengePlotId = plotId
end

TeamRelay2Mgr.GetCurChallengePlotId = function()
    return this.curChallengePlotId
end


TeamRelay2Mgr.GetPlotCfg = function(plotId)
    local plotCfg = ConfigMgr.Config.TeamRelayMap[plotId]
    if plotCfg ~= nil and plotCfg.ActivityGroup == TeamRelay2Mgr.activityGroupId then
        return plotCfg
    end
end

TeamRelay2Mgr.GetLevelCfg = function(levelId)
    return ConfigMgr.Config.TeamRelayGroupMap[tostring(levelId)]
end

TeamRelay2Mgr.GetDungeonCfg = function(dungeonId)
    return ConfigMgr.Config.TeamRelayDungeonMap[tostring(dungeonId)]
end

TeamRelay2Mgr.GetBuffDescCfg = function(buffDescId)
    return ConfigMgr.Config.TeamRelayBuffDescMap[tostring(buffDescId)]
end

TeamRelay2Mgr.GetPlotIds = function()
    local plotIds = {}
    local teamRelayMap = ConfigMgr.Config.TeamRelayMap
    for k, v in pairs(teamRelayMap) do
        if v.ActivityGroup == TeamRelay2Mgr.activityGroupId then
            table.insert(plotIds, v.Id)
        end
    end
    table.sort(plotIds, function(a, b)
        return a < b
    end)
    return plotIds
end

TeamRelay2Mgr.GetTeamIdByActivityDungeonId = function(activityDungeonId)
    local teamId = "1"
    local dungeonCfg = TeamRelay2Mgr.GetDungeonCfg(activityDungeonId)
    local levelCfg = TeamRelay2Mgr.GetLevelCfg(dungeonCfg.DiffId)
    for i, v in ipairs(levelCfg.DungeonGroupId) do
        if v == activityDungeonId then
            teamId = tostring(i)
        end
    end
    return teamId
end


TeamRelay2Mgr.GetPlotData = function(plotId)
    if not IsNull(DataMgr.Player.TeamRelays) and DataMgr.Player.TeamRelays[tostring(plotId)] ~= nil then
        return DataMgr.Player.TeamRelays[tostring(plotId)]
    end
end

TeamRelay2Mgr.GetCurTeamScore = function(plotId, teamId)
    local score = 0
    local plotData = TeamRelay2Mgr.GetPlotData(plotId)
    if plotData ~= nil and not TableIsNull(plotData.Teams) and plotData.Teams[tostring(teamId)] ~= nil then
        score = plotData.Teams[tostring(teamId)].Score
    end
    return score
end

TeamRelay2Mgr.GetCurChallengeTotalScore = function(plotId)
    local totalScore = 0
    for i = 1, 3 do
        totalScore = totalScore + TeamRelay2Mgr.GetCurTeamScore(plotId, tostring(i))
    end
    return totalScore
end

TeamRelay2Mgr.GetPlotHighestScore = function(plotId)
    local plotData = TeamRelay2Mgr.GetPlotData(plotId)
    if plotData ~= nil then
        return plotData.MaxScore
    end
    return 0
end

TeamRelay2Mgr.CheckPlotIsCanDelegate = function(plotId)
    local plotData = TeamRelay2Mgr.GetPlotData(plotId)
    if plotData ~= nil and not TableIsNull(plotData.Finish) then
        return true
    end
    return false
end

TeamRelay2Mgr.GetDungeonHighestScore = function(activityDungeonId)
    local score = 0
    local dungeonCfg = TeamRelay2Mgr.GetDungeonCfg(activityDungeonId)
    local levelCfg = TeamRelay2Mgr.GetLevelCfg(dungeonCfg.DiffId)
    local plotData = TeamRelay2Mgr.GetPlotData(levelCfg.TeamRelayId)
    if plotData ~= nil and not TableIsNull(plotData.DamageTeamRecords) then
        local record = plotData.DamageTeamRecords[tostring(dungeonCfg.DiffId)]
        if record ~= nil then
            local teamId = TeamRelay2Mgr.GetTeamIdByActivityDungeonId(activityDungeonId)
            if record[teamId] ~= nil then
                score = record[teamId].MaxScore
            end
        end
    end
    return score
end

TeamRelay2Mgr.GetTotalScore = function(plotId)
    local totalScore = 0
    local plotIds = TeamRelay2Mgr.GetPlotIds()
    for i, v in ipairs(plotIds) do
        local plotData = TeamRelay2Mgr.GetPlotData(v)
        if plotData ~= nil then
            totalScore = totalScore + plotData.Score
        end
    end
    return totalScore
end

TeamRelay2Mgr.GetAllLeftChallengeCount = function()
    local challengeCount = 0
    local limitCount = 0
    local plotIds = TeamRelay2Mgr.GetPlotIds()
    for i, v in ipairs(plotIds) do
        local plotCfg = TeamRelay2Mgr.GetPlotCfg(v)
        if plotCfg.ShareLimit == 1 then
            limitCount = plotCfg.Limit
        end
        local plotData = TeamRelay2Mgr.GetPlotData(v)
        if plotData ~= nil then
            challengeCount = challengeCount + plotData.ChallengeCount
        end
    end
    return limitCount - challengeCount, limitCount
end


TeamRelay2Mgr.GetLevelStatus = function(levelId)
    local status = 1
    local levelCfg = TeamRelay2Mgr.GetLevelCfg(levelId)
    local plotData = TeamRelay2Mgr.GetPlotData(levelCfg.TeamRelayId)
    local hasReward = not IsNull(levelCfg.Reward)
    if plotData ~= nil and plotData.Reward ~= nil and plotData.Reward[tostring(levelId)] ~= nil then
        status = 2
    elseif plotData ~= nil and plotData.Finish ~= nil and plotData.Finish[tostring(levelId)] ~= nil then
        status = hasReward and 0 or 2
    else
        local curTime = LuaMgr.Timestamp()
        local unlockTime = TeamRelay2Mgr.GetLevelUnlockTime(levelId)
        status = curTime < unlockTime and 3 or 1
    end
    return status
end


TeamRelay2Mgr.GetPlotUnlockTime = function(plotId)
    local plotCfg = TeamRelay2Mgr.GetPlotCfg(plotId)
    if TableIsNull(plotCfg) then
        return 0
    end
    local leftTime = this.GetDelayTime(plotCfg.Lock)
    return leftTime
end


TeamRelay2Mgr.GetLevelUnlockTime = function(levelId)
    local levelCfg = TeamRelay2Mgr.GetLevelCfg(levelId)
    if TableIsNull(levelCfg) or TableIsNull(levelCfg.Lock) then
        return 0
    end
    local leftTime = this.GetDelayTime(levelCfg.Lock[1])
    return leftTime
end

TeamRelay2Mgr.GetLockMembersAndHelps = function(activityDungeonId)
    local dungeonCfg = TeamRelay2Mgr.GetDungeonCfg(activityDungeonId)
    local levelCfg = TeamRelay2Mgr.GetLevelCfg(dungeonCfg.DiffId)
    local plotData = TeamRelay2Mgr.GetPlotData(levelCfg.TeamRelayId)
    local teamId = TeamRelay2Mgr.GetTeamIdByActivityDungeonId(activityDungeonId)
    local members = {};
    local helps = {};
    if not IsNull(plotData) and not IsNull(plotData.Teams) then
        local teamData = plotData.Teams[teamId]
        if not IsNull(teamData) then
            local locks = teamData.Locks;
            if not IsNull(locks) then
                local lock = locks[activityDungeonId];
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

TeamRelay2Mgr.GetFilterMembers = function(activityDungeonId)
    local filterMembers = {}
    local filterMembersTeamMap = {}
    local dungeonCfg = TeamRelay2Mgr.GetDungeonCfg(activityDungeonId)
    local levelCfg = TeamRelay2Mgr.GetLevelCfg(dungeonCfg.DiffId)
    local teamIndex = 0
    for i, v in ipairs(levelCfg.DungeonGroupId) do
        if v ~= activityDungeonId then
            local filters = ActivityBattlePrepareMgr.GetLockMembers(ActivityKey.TeamRelay2, v)
            for member, uid in pairs(filters) do
                filterMembers[member] = uid
                filterMembersTeamMap[member] = i
            end
        end
    end
    return filterMembers, filterMembersTeamMap
end

this.GetDelayTime = function(delay)
    local startTime = 0
    local activityData = DataExHelper.GetDataExByTag(ActivityKey.TeamRelay2)
    if activityData ~= nil then
        startTime = activityData.startTime
    end
    local delayTime = tonumber(delay) * 24 * 60 * 60
    local leftTime = startTime + delayTime
    return leftTime
end


TeamRelay2Mgr.GetRewards = function(levelIds, callback)
    ApiMgr.Request("teamRelay/teamRelayRewards2", { GroupIds = levelIds }, true,
            function(result)
                local re = json.decode(result);
                local data = json.encode(re.result);
                LuaMgr.ShowItemRewared(data);
                if callback ~= nil then
                    callback()
                end
            end
    , nil, true, true)
end


TeamRelay2Mgr.StartEndTeamRelay = function(type, plotId, levelId, callback)
    ApiMgr.Request("teamRelay/startEndTeamRelay", { Typ = type, Id = plotId, DungeonGroupId = levelId }, true, callback, nil, true, true)
end


TeamRelay2Mgr.EnterLeaveDungeon = function(plotId, count, callback)
    local plotCfg = TeamRelay2Mgr.GetPlotCfg(plotId)
    local levelCfg = TeamRelay2Mgr.GetLevelCfg(plotCfg.Group[1])
    local dungeonId = TeamRelay2Mgr.GetDungeonCfg(levelCfg.DungeonGroupId[1]).DungeonId
    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams();
    enterDungeonParams.eventId = dungeonId;
    enterDungeonParams.dungeonId = dungeonId;
    enterDungeonParams.count = count
    enterDungeonParams.extraParams = { "team_relay2", plotId, "", "-1" };
    ApiMgr.Request("enter_leave_dungeon", enterDungeonParams, true, callback, nil, true, true);
end

TeamRelay2Mgr.Clear = function()
    this.curDungeonHighScore = 0
    this.curChallengePlotId = ""
end