




require("ViewModel/SuiChuNaJi/Data/SCNJConst")
SCNJData = {}
local this = {
    teamRealayGroups = {},
    teamRealayGroupDic = {},
    dailyJoinTimes = 0,

    rewardDatas = {},
    bossRelayHotLevelDic = {},
    bossRelayHotLevelDatas = {},
    noAgainTipsKey = nil
}

SCNJData.InitData = function()
    local groupID = DataExHelper.GetActivityGroup(ActivityKey.TeamRelay)
    if groupID == nil then
        LuaDebug.error("SCNJData InitData groupID is nil")
        return
    end
    local teamDelayConfig = ConfigMgr.Config.TeamRelayMap[SCNJConst.TeamRelayID]
    if teamDelayConfig == nil then
        LuaDebug.error("SCNJData InitData teamDelayConfig is nil")
        return
    end



    local teamRelayDungeonDic = {}
    local teamRelayDungeonConfigs = ConfigMgr.Config.TeamRelayDungeonMap
    for key, config in pairs(teamRelayDungeonConfigs) do
        local data = teamRelayDungeonDic[config.DiffId]
        if data == nil then
            data = {}
            teamRelayDungeonDic[config.DiffId] = data
        end
        for i = 1, #config.BuffGroup do
            local buffID = config.BuffGroup[i]
            if buffID ~= nil and buffID ~= "" then
                data[buffID] = true
            end
        end
    end
    this.dailyJoinTimes = teamDelayConfig.Limit
    local teamRelayGroupIDs = teamDelayConfig.Group
    for i = 1, #teamRelayGroupIDs do
        local data = {}
        local groupID = teamRelayGroupIDs[i]
        local config = ConfigMgr.Config.TeamRelayGroupMap[tostring(groupID)]
        data.ID = groupID
        data.GroupID = groupID
        data.Config = config
        data.IsUnlock = config.Lock == nil or config.Lock == ""
        data.CoopeCount = 0
        data.DungeonList = {}
        data.DungeonDic = {}
        data.DungeonIDs = config.DungeonGroupId
        data.BuffDic = teamRelayDungeonDic[tonumber(config.Id)] or {}
        data.Rewards = {}
        data.Status = CommonRewardItem.Status.None
        data.Desc = ""
        data.NeedHotLevel = tonumber(data.Config.Lock[1]) or 0
        data.NeedHotProgress = tonumber(data.Config.Lock[2]) or 0
        if type(config.Reward) == "table" and #config.Reward > 0 then
            local descLan = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29533")
            data.Desc = string.format(descLan, config.DiffDesc)
            for j = 1, #config.Reward do
                local rewardConfig = config.Reward[j]
                local tempData = SCNJData.GetRewardItem(rewardConfig, CommonRewardItem.Status.None)
                table.insert(data.Rewards, tempData)
            end
        end
        local dungeonIDs = config.DungeonGroupId
        for j = 1, #dungeonIDs do
            local dungeonID = dungeonIDs[j]
            local dungeonConfig = teamRelayDungeonConfigs[dungeonID]
            table.insert(data.DungeonList, dungeonConfig)
            data.DungeonDic[dungeonID] = dungeonConfig
        end
        table.insert(this.teamRealayGroups, data)
        this.teamRealayGroupDic[data.GroupID] = data
    end



    local bossRelayHeatConfigs = ConfigMgr.Config.BossRelayHeatMap
    local len = NumTool.GetLen(bossRelayHeatConfigs)
    local prefixBuff = nil
    local prefixBuffConfigID = nil
    for i = 1, len do
        local ID = tostring(i)
        local config = bossRelayHeatConfigs[ID]
        local tempData = {}
        tempData.ID = ID

        tempData.UnionValue = SCNJData.GetUnionValue(config.Level, config.Progress)
        tempData.Config = config
        tempData.Status = CommonRewardItem.Status.None
        tempData.Rewards = nil
        tempData.Reward = nil
        tempData.BuffGroup = nil
        if type(config.BuffGroup) == "table" and #config.BuffGroup > 0 then
            tempData.BuffGroup = config.BuffGroup
            tempData.PrefixBuff = prefixBuff
            tempData.prefixBuffConfigID = prefixBuffConfigID
            prefixBuff = config.BuffGroup
            prefixBuffConfigID = ID
        end
        if type(config.Award) == "table" then
            local rewardConfig = config.Award[1]
            tempData.Reward = SCNJData.GetRewardItem(rewardConfig, tempData.Status)
            tempData.RewardType = SCNJConst.RewardType.AllServerFireProgress
        end
        table.insert(this.bossRelayHotLevelDatas, tempData)
    end
end

SCNJData.CheckActivityRunning = function(isStatic)
    if not DataExHelper.CommonActivityCheck(ActivityKey.TeamRelay) then
        if not isStatic then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
        end
        return false
    end
    return true
end

SCNJData.GetRemainTimeStr = function()
    local activityData = DataExHelper.GetDataExByTag(ActivityKey.TeamRelay)
    if activityData == nil then
        return ""
    end
    local time = activityData.expireTime - LuaMgr.Timestamp()
    if time <= 0 then
        return LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_18344")
    end
    local timeStr = ""
    local d, h, m = GetTimeDHM(time)
    if (not IsNullOrEmpty(d)) then
        timeStr = timeStr .. string.format("%s%s", d, ConfigMgr.LangGlobal("10365"))
    end
    if (not IsNullOrEmpty(h)) then
        timeStr = timeStr .. string.format("%s%s", h, ConfigMgr.LangGlobal("10366"))
    end
    if (not IsNullOrEmpty(m)) then
        timeStr = timeStr .. string.format("%s%s", m, ConfigMgr.LangGlobal("10367"))
    end
    return timeStr
end

SCNJData.GetScore = function(damage, isConvert)
    if isConvert == true then
        local battleParams = BattlePrepareMgr.GetEnterDungeonParamsObj()
        if battleParams ~= nil then
            local diffcultConfig = this.teamRealayGroupDic[battleParams.diffcultID]
            if diffcultConfig ~= nil then
                local scoreParam = ConfigMgr.Config.TeamRelayConstants.ScorePara
                local credit = diffcultConfig.Config.Credit
                return math.floor(damage * scoreParam * (1 + credit / 10000))
            end
        end
    end
    return damage
end


SCNJData.GetChallengeCount = function()
    local teamRelayData = SCNJData.GetTeamRelayData()
    local dailyCount = teamRelayData.ChallengeCount or 0
    local maxCount = this.dailyJoinTimes
    return dailyCount, maxCount
end

SCNJData.GetAllDifficultyDatas = function()
    if #this.teamRealayGroups == 0 then
        SCNJData.InitData()
    end
    local bossRelayData = SCNJData.GetCurServerHotData()
    for key, data in pairs(this.teamRealayGroups) do
        if data.IsUnlock == false then
            local needHotLevel = tonumber(data.Config.Lock[1])
            local needHotProgress = tonumber(data.Config.Lock[2])
            if bossRelayData.hotLevel > needHotLevel or (bossRelayData.hotLevel == needHotLevel and bossRelayData.hotExp >= needHotProgress) then
                data.IsUnlock = true
            end
        end
    end
    return this.teamRealayGroups
end

SCNJData.GetAllBuffDatasByID = function(id)
    local data = this.teamRealayGroupDic[id] or this.teamRealayGroupDic[tonumber(id)]
    if data == nil then
        return {}, {}
    end
    local allBuffDatas = {}
    for key, value in pairs(data.BuffDic) do
        local config = ConfigMgr.Config.TeamRelayBuffDescMap[key]
        if type(config) == "table" then
            local data = table.CopyNoMeta(config)
            data.Level = config.Param[2] or 0
            data.Name = LuaMgr.GetLangText(config.BuffNameLan)
            data.Desc = LuaMgr.GetLangText(config.BuffDesLan)
            data.BuffIcon = config.BuffIcon
            table.insert(allBuffDatas, data)
        end
    end
    table.sort(allBuffDatas, SCNJData.OnBuffSort)
    return allBuffDatas, data
end

SCNJData.OnBuffSort = function(data1, data2)
    return data1.Sort < data2.Sort
end

SCNJData.GetCurSelectedDifficultyDataID = function()
    return this.curSelectedDifficultyDataID
end

SCNJData.SetCurSelectedDifficultyDataID = function(id)
    this.curSelectedDifficultyDataID = id
end







SCNJData.GetRewardDatas = function(rewardType)
    local data = {}
    local existCanGetReward = false
    if rewardType == SCNJConst.RewardType.AllServerFireProgress then
        data, existCanGetReward = SCNJData.GetAllServerProgressReward()
    elseif rewardType == SCNJConst.RewardType.FireProgress then
        data, existCanGetReward = SCNJData.GetTeamRelayGroupReward()
    else
        data, existCanGetReward = SCNJData.GetQuestEventRewards(rewardType)
    end
    return data, existCanGetReward
end


SCNJData.GetQuestEventRewards = function(rewardType)
    if this.quesetEventConfigs == nil then
        this.quesetEventConfigs = DataExHelper.Check_ConfigQuestEventByGroupId(SCNJConst.QuestEventGroupID)
    end
    local typeToEventType = {
        [SCNJConst.RewardType.ThroughPass] = 820,
        [SCNJConst.RewardType.PercentFireNum] = 821
    }
    local datas = this.rewardDatas[rewardType]
    local quests = DataMgr.Player.quests
    local existCanGetReward = false
    if datas == nil or #datas == 0 then
        datas = {}
        for i = 1, #this.quesetEventConfigs do
            local config = this.quesetEventConfigs[i]
            local eventType = typeToEventType[rewardType]
            if config.eventType == eventType then
                local tempData = {}
                local questData = quests[config.id]
                tempData.ID = config.id
                tempData.Config = config
                tempData.Rewards = {}
                tempData.Reward = nil
                tempData.Status = CommonRewardItem.Status.None
                tempData.questData = questData
                tempData.Desc = LuaMgr.GetLangText(config.remarksLan)
                tempData.RewardType = rewardType
                if questData ~= nil and questData.state == 2 then
                    existCanGetReward = true
                    tempData.Status = CommonRewardItem.Status.CanGet
                elseif questData ~= nil and questData.state == 3 then
                    tempData.Status = CommonRewardItem.Status.Got
                end
                for j = 1, #config.showReward do
                    local rewardConfig = config.showReward[j]
                    local tempRewardItem = SCNJData.GetRewardItem(rewardConfig, tempData.Status)
                    table.insert(tempData.Rewards, tempRewardItem)
                end
                table.insert(datas, #datas + 1, tempData)
            end
        end
        this.rewardDatas[rewardType] = datas
    else
        for i = 1, #datas do
            local tempData = datas[i]
            local questData = quests[tempData.ID]
            tempData.questData = questData
            if questData ~= nil and questData.state == 2 then
                existCanGetReward = true
                tempData.Status = CommonRewardItem.Status.CanGet
            elseif questData ~= nil and questData.state == 3 then
                tempData.Status = CommonRewardItem.Status.Got
            else
                tempData.Status = CommonRewardItem.Status.None
            end
            for j = 1, #tempData.Rewards do
                local rewardItem = tempData.Rewards[j]
                rewardItem.status = tempData.Status
            end
        end
    end
    return datas, existCanGetReward
end


SCNJData.GetAllServerProgressReward = function()
    local data = {}
    local len = #this.bossRelayHotLevelDatas
    local serverRewardDatas = DataMgr.Player.BossRelay.HotRewards or {}
    local existCanGetReward = false
    for i = 1, len do
        local tempData = this.bossRelayHotLevelDatas[i]
        local config = tempData.Config
        local ID = tempData.ID
        if type(config.Award) == "table" then
            if serverRewardDatas[ID] == 0 then
                tempData.Status = CommonRewardItem.Status.CanGet
                existCanGetReward = true
            elseif serverRewardDatas[ID] == 1 then
                tempData.Status = CommonRewardItem.Status.Got
            end
            local rewardConfig = config.Award[1]
            tempData.Reward = SCNJData.GetRewardItem(rewardConfig, tempData.Status)
            tempData.RewardType = SCNJConst.RewardType.AllServerFireProgress
        end
        if tempData.Reward ~= nil then
            table.insert(data, tempData)
        end
    end
    return data, existCanGetReward
end

SCNJData.GetTeamRelayGroupReward = function()
    local datas = {}
    local teamRelayData = SCNJData.GetTeamRelayData()
    local finishData = type(teamRelayData.Finish) == "table" and teamRelayData.Finish or {}
    local gotRewardData = type(teamRelayData.Reward) == "table" and teamRelayData.Reward or {}
    local existCanGetReward = false
    for i = 1, #this.teamRealayGroups do
        local tempData = this.teamRealayGroups[i]
        if #tempData.Rewards > 0 then
            local status = CommonRewardItem.Status.None
            local intID = tostring(tempData.ID)
            if gotRewardData[intID] ~= nil then
                status = CommonRewardItem.Status.Got
            elseif finishData[intID] ~= nil then
                status = CommonRewardItem.Status.CanGet
                existCanGetReward = true
            end
            tempData.Status = status
            tempData.RewardType = SCNJConst.RewardType.FireProgress
            for j = 1, #tempData.Rewards do
                local rewardItem = tempData.Rewards[j]
                rewardItem.status = status
            end
            table.insert(datas, tempData)
        end
    end
    return datas, existCanGetReward
end

SCNJData.GetAllServerProgressData = function()
    return this.bossRelayHotLevelDatas
end

SCNJData.GetUnionValue = function(level, progress)
    return level * SCNJConst.RelayHeatLevelRadio + progress
end

SCNJData.GetRewardItem = function(item, status)
    local tempData = {}
    tempData.id = item.id
    tempData.count = item.count
    tempData.status = status
    tempData.scale = 0.6
    return tempData
end

SCNJData.GetCurSelectedRewardPage = function()
    return this.curSelectedRewardPage
end

SCNJData.SetCurSelectedRewardPage = function(pageType)
    this.curSelectedRewardPage = pageType
end

SCNJData.GetAllServerBuff = function()
    local serverProgressData = SCNJData.GetAllServerProgressData()
    local buffDatas = {}
    local curHotLevelData = SCNJData.GetCurServerHotData()
    local curUnionValue = SCNJData.GetUnionValue(curHotLevelData.hotLevel, curHotLevelData.hotExp)
    local curMaxHotData = nil
    for i = 1, #serverProgressData do
        local config = serverProgressData[i]
        if curUnionValue >= config.UnionValue then
            if type(config.BuffGroup) == "table" and #config.BuffGroup > 0 then
                curMaxHotData = config
            end
        else
            break
        end
    end
    if curMaxHotData == nil then
        return buffDatas
    end
    local buffIDs = curMaxHotData.BuffGroup
    for i = 1, #buffIDs do
        local buffID = buffIDs[i]
        local buffConfig = ConfigMgr.Config.TeamRelayBuffDescMap[buffID]
        local data = {}
        data.BuffID = buffConfig.Id
        data.Level = buffConfig.Param[2] or 0
        data.Name = LuaMgr.GetLangText(buffConfig.BuffNameLan)
        data.Desc = LuaMgr.GetLangText(buffConfig.BuffDesLan)
        data.BuffIcon = buffConfig.BuffIcon
        table.insert(buffDatas, data)
    end
    return buffDatas
end






SCNJData.GetHelpList = function(callBack)
    if callBack == nil then
        LuaDebug.error("317 SCNJData.GetHelpList==========回调不能为空")
        return
    end
    local data = {}
    local helpServerData = SCNJData.GetDailyHelpData()
    local onSucc = function(result)
        local res = json.decode(result)
        local playerList = {}
        if res.code ~= nil and res.code ~= 0 then
            callBack(playerList)
            return
        end
        local list = res.result.List
        for key, value in pairs(list) do
            local playerData = {}
            playerData.Level = value.Level
            playerData.Avatar = value.Avatar
            playerData.AvatarFrameIcon = value.AvatarFrameIcon
            playerData.Name = value.Name
            local dungeonGroup = this.teamRealayGroupDic[value.DungeonGroup]

            playerData.DungeonGroup = value.DungeonGroup
            playerData.Diff = string.format("%s%%", dungeonGroup and dungeonGroup.Config.DiffDesc or "")
            playerData.Damage = SCNJData.GetScore(value.Damage)
            playerData.Uid = value.Uid
            playerData.IsBeHelp = helpServerData[value.Uid] ~= nil and true or false
            table.insert(playerList, playerData)
        end
        callBack(playerList)
    end
    ApiMgr.Request("bossRelay/helpList", data, true, onSucc, nil, true)
end

SCNJData.GetDailyHelpCount = function()
    local dailyHelpData = SCNJData.GetDailyHelpData()
    local dailyCount = NumTool.GetLen(dailyHelpData)
    local maxCount = ConfigMgr.Config.TeamRelayConstants.HelpDayCount
    return dailyCount, maxCount
end

SCNJData.SetOldHelpLevel = function()
    local bossRelayData = DataMgr.Player.BossRelay or {}
    this.oldHelpLevel = bossRelayData.HelpLevel or 1
end

SCNJData.GetOldHelpLevel = function()
    return this.oldHelpLevel or 1
end

SCNJData.SetOldHelpScore = function()
    local bossRelayData = DataMgr.Player.BossRelay or {}
    this.oldHelpScore = bossRelayData.HelpScore or 0
end

SCNJData.GetOldHelpScore = function()
    return this.oldHelpScore or 1
end

SCNJData.GetCurHelpLevel = function()
    local bossRelayData = DataMgr.Player.BossRelay or {}
    return bossRelayData.HelpLevel or 1, bossRelayData.HelpExp or 0, bossRelayData.HelpScore or 0
end

SCNJData.GetHelpAddition = function(level)
    local config = ConfigMgr.Config.BossRelayHelpMap[tostring(level)]
    if config == nil then
        return {}, {}
    end
    local talentBanks = config.TalentBank or {}
    local additionConfigs = {}
    local additionConfigDic = {}
    for i = 1, #talentBanks do
        local talentBankID = talentBanks[i]
        local talentBankConfig = ConfigMgr.Config.talentBankMap[talentBankID]
        if talentBankConfig == nil then
            LuaDebug.error("380 SCNJData.GetHelpAddition==========未配置的TalentBank:" .. talentBankID)
            break
        end
        local data = {}
        data.Config = talentBankConfig
        local attrDesLength = NumTool.GetStringLength(talentBankConfig.talentParam1)
        local attrDes = NumTool.split(LuaMgr.SubstringLen(talentBankConfig.talentParam1, 1, attrDesLength - 2), ",")
        if attrDes ~= nil then
            data.TalentName = attrDes[1]
            data.TalentNumber = attrDes[2]
        end
        data.DescLan = talentBankConfig.DescriptionLan
        table.insert(additionConfigs, data)
        additionConfigDic[data.TalentName] = data
    end
    return additionConfigs, additionConfigDic
end





SCNJData.GetTeamData = function(dungeonGroupID, stageIndex)
    local teamRealayData = SCNJData.GetTeamRelayData()
    local damageTeamRecords = teamRealayData.DamageTeamRecords or {}
    if IsNull(damageTeamRecords) then
        damageTeamRecords = {}
    end
    local teamDataDic = damageTeamRecords[tostring(dungeonGroupID)] or {}
    return teamDataDic[tostring(stageIndex)]
end

SCNJData.GetDungeonTeamDatas = function(dungeonConfigDic)
    local teamDatas = {}
    for key, dungeonConfig in pairs(dungeonConfigDic) do
        local data = table.CopyNoMeta(dungeonConfig)
data.Index = tonumber(key)
data.TeamData = SCNJData.GetTeamData(dungeonConfig.DiffId, data.StageIndex)
data.IsShow = false
        table.insert(teamDatas, data)
    end
    table.sort(teamDatas, SCNJData.SortDataByIndex)
    local lastValidIndex = 0
    for i = 1, #teamDatas do
        if teamDatas[i].TeamData ~= nil and next(teamDatas[i].TeamData) ~= nil then
            lastValidIndex = i
        end
    end

    if lastValidIndex == 0 then
        if #teamDatas >= 1 then
            teamDatas[1].IsShow = true
        end
    else
        local showUntilIndex = lastValidIndex + 1
        showUntilIndex = math.min(showUntilIndex, #teamDatas)
        for i = 1, showUntilIndex do
            teamDatas[i].IsShow = true
        end
    end
    return teamDatas
end

SCNJData.SortDataByIndex = function(data1, data2)
    return data1.Index < data2.Index
end

SCNJData.OnResetTeamData = function(dungeonGroup, teamIDs, callback)
    if #teamIDs == 0 then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29614")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    local onSucc = function(result)
        local res = json.decode(result)
        if res.code ~= nil and res.code ~= 0 then
            return
        end
        if callback ~= nil then
            callback()
        end
    end
    local data = {}
    data.Id = SCNJConst.TeamRelayID
    data.DungeonGroup = dungeonGroup
    data.TeamId = teamIDs
    ApiMgr.Request("teamRelay/resetTeamRelay", data, true, onSucc, nil, true)
end


SCNJData.SetOldTotleScore = function()
    this.oldTotleScore = SCNJData.GetPlayerTotalScore()
end

SCNJData.GetOldTotleScore = function()
    return this.oldTotleScore or 0
end

SCNJData.SetTempTeamIndex = function(index)
    this.tempTeamIndex = index
end

SCNJData.GetLockMembersAndHelps = function(teamRelayDungeonID, teamIndex)
    local members = {}
    local helps = {}
    local teamRealayData = SCNJData.GetTeamRelayData()
    if teamRealayData == nil then
        return members, helps
    end
    local dungeonGroupConfig = ConfigMgr.Config.TeamRelayDungeonMap[teamRelayDungeonID]
    if dungeonGroupConfig == nil then
        return members, helps
    end
    if type(teamRealayData.DamageTeamRecords) ~= "table" then
        return members, helps
    end
    local dungeonGroupID = dungeonGroupConfig.DiffId
    local dungeonGroupData = teamRealayData.DamageTeamRecords[tostring(dungeonGroupID)]
    if type(dungeonGroupData) ~= "table" then
        return members, helps
    end
    local teamIndex = tostring(dungeonGroupConfig.StageIndex)
    local teamInfo = dungeonGroupData[teamIndex]
    if teamInfo == nil then
        return members, helps
    end
    return teamInfo.Members, teamInfo.Helps
end

SCNJData.GetLockMembers = function(teamRelayDungeonID, diffcultID, teamIndex)
    local members = {}
    local teamRealayData = SCNJData.GetTeamRelayData()
    if teamRealayData == nil then
        return members
    end
    if type(teamRealayData.DamageTeamRecords) ~= "table" then
        return members
    end
    local memberDic = {}
    local teamIndexStr = tostring(teamIndex)
    local diffcultIDStr = tostring(diffcultID)
    for tempDiffcultID, drungeonDatas in pairs(teamRealayData.DamageTeamRecords) do
        for teamIndex, teamData in pairs(drungeonDatas) do
            if tempDiffcultID == diffcultIDStr and teamIndexStr ~= teamIndex then
                local members = teamData.Members
                for key, memberID in pairs(members) do
                    memberDic[memberID] = memberID
                end
            end
        end
    end
    for key, value in pairs(memberDic) do
        if value ~= nil and value ~= "" then
            table.insert(members, value)
        end
    end
    return members
end







SCNJData.GetTeamRelayData = function()
    local data = DataMgr.Player.TeamRelays[SCNJConst.TeamRelayID]
    if type(data) == "table" then
        return data
    end
    return {}
end



SCNJData.SetOldServerHotData = function(hadTipConfigData)
    local curServerHotData = SCNJData.GetOldServerHotData()
    if hadTipConfigData == nil and curServerHotData.HadTipConfigData ~= nil then
        return
    end
    local bossRelayData = SCNJData.GetCurServerHotData()
    this.hotLevelData = {}
    this.hotLevelData.hotLevel = bossRelayData.hotLevel
    this.hotLevelData.hotExp = bossRelayData.hotExp
    this.hotLevelData.HadTipConfigData = hadTipConfigData or {}
end

SCNJData.GetOldServerHotData = function()
    local defaultData = {hotLevel = 1, hotExp = 0}
    return this.hotLevelData or defaultData
end

SCNJData.GetCurServerHotData = function()
    local bossRelayData = DataMgr.Player.BossRelay or {}
    local hotLevelData = {}
    hotLevelData.hotLevel = bossRelayData.HotLevel or 1
    local maxExp = ConfigMgr.Config.TeamRelayConstants.HeatProgress
    local curLevelExp = bossRelayData.HotExp - maxExp * (hotLevelData.hotLevel - 1)
    curLevelExp = math.min(curLevelExp, maxExp)
    curLevelExp = math.max(curLevelExp, 0)
    hotLevelData.hotExp = curLevelExp
    return hotLevelData
end

SCNJData.GetPlayerTotalScore = function(uid)
    if uid == nil then
        local teamRealayData = SCNJData.GetTeamRelayData()
        local damage = teamRealayData.Damage or 0
        return SCNJData.GetScore(damage)
    end
    return 0
end

SCNJData.SetOldPlayerTotalScore = function()
    this.oldPlayerTotalScore = SCNJData.GetPlayerTotalScore()
end

SCNJData.GetOldPlayerTotalScore = function()
    return this.oldPlayerTotalScore or 0
end

SCNJData.GetDailyHelpData = function()
    local bossRelayData = DataMgr.Player.BossRelay or {}
    return bossRelayData.DailyHelp or {}
end



SCNJData.GetDungeonGroupTotalDamage = function(dungeonGroupID, isMax)
    local teamRealayData = SCNJData.GetTeamRelayData()
    local damageRecords = type(teamRealayData.DamageTeamRecords) == "table" and teamRealayData.DamageTeamRecords or {}
    local dungeonGroupIDStr = tostring(dungeonGroupID)
    local dungeonGroupData = type(damageRecords[dungeonGroupIDStr]) == "table" and damageRecords[dungeonGroupIDStr] or {}
    local totalDamage = 0
    for key, value in pairs(dungeonGroupData) do
        if isMax == true then
            totalDamage = value.MaxDamage + totalDamage
        else
            totalDamage = value.Damage + totalDamage
        end
    end
    return totalDamage
end

SCNJData.GetDungeonDmage = function(dungeonGroupID, stageIndex, isMax)
    local teamRealayData = SCNJData.GetTeamRelayData()
    local damageRecords = type(teamRealayData.DamageTeamRecords) == "table" and teamRealayData.DamageTeamRecords or {}
    local dungeonGroupIDStr = tostring(dungeonGroupID)
    local dungeonGroupData = type(damageRecords[dungeonGroupIDStr]) == "table" and damageRecords[dungeonGroupIDStr] or {}
    local stageData = dungeonGroupData[tostring(stageIndex)] or {}
    if isMax then
        return stageData.MaxDamage or 0
    else
        return stageData.Damage or 0
    end
end

SCNJData.CheckHelpCharacterValid = function(uid, heroId)
    if PlayerAssistMgr.CheckAssistListContainsKeyHero(uid, heroId) then
        local characterData = PlayerAssistMgr.GetAssist_Character(uid, heroId)
        if characterData ~= nil then
            return characterData
        end
    end
    return nil
end



SCNJData.GetNoAgainTipsKey = function()
    return DataMgr.Player.uid .. "SCNJNoAgainTipsKey"
end

SCNJData.GetArchiveByKey = function(key)
    return PlayerPrefs.GetInt(key)
end

SCNJData.SetArchiveByKey = function(key, value)
    if not value then
        local nowstamp = LuaMgr.Timestamp()
        local nowDate = DateTool.UnixToDateTime(nowstamp, 1)
        value = nowDate.Day
    end
    if type(value) == "number" then
        PlayerPrefs.SetInt(key, value)
        PlayerPrefs.Save()
    end
end





SCNJData.CheckRed = function()
    if SCNJData.CheckActivityRunning() == false then
        return 0
    end
    local existCanGetReward = SCNJData.GetExistCanGetRewardRedNum()
    local redNum1 = existCanGetReward
    RedMgr.Singleton:UpdateClientRedData(SCNJConst.RedPoint.Reward, redNum1)

    local redNum2 = 0
    local noCompleted = RedMgr.Singleton:CheckRedCondition(SCNJConst.RedPoint.Help)
    if noCompleted == true then
        redNum2 = 1
    end
    RedMgr.Singleton:UpdateClientRedData(SCNJConst.RedPoint.Help, redNum2)

    return redNum1 + redNum2
end

SCNJData.GetExistCanGetRewardRedNum = function()
    for key, value in pairs(SCNJConst.RewardType) do
        local _, existCanGetReward = SCNJData.GetRewardDatas(value)
        if existCanGetReward == true then
            return 1
        end
    end
    return 0
end

SCNJData.RefreshRewardRed = function()
    for key, value in pairs(SCNJConst.RewardType) do
        local _, existCanGetReward = SCNJData.GetRewardDatas(value)
        local redNum = existCanGetReward == true and 1 or 0
        local redPointID = string.format("%s_%d", SCNJConst.RedPoint.Reward, value)
        RedMgr.Singleton:UpdateClientRedData(redPointID, redNum)
    end
end


