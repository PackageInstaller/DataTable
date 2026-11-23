




require("ViewModel/Management/Data/ManagementConst")
require("ViewModel/Management/Data/ManagementGameData")
require("Match3Game/Data/GridPosition")
ManagementData = {}

local this = {
    eventDic = {},
    delegateSeletedID = ""
}

ManagementData.Init = function()
    ManagementGameData.InitData()
end

ManagementData.CheckActivityRunning = function(isStatic)
    if not DataExHelper.CommonActivityCheck(ActivityKey.LYZM) then
        if not isStatic then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
        end
        return false
    end
    return true
end

ManagementData.GetRemainTimeStr = function()
    local activityData = DataExHelper.GetDataExByTag(ActivityKey.LYZM)
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


ManagementData.GetShopFeedDatas = function()
    if ManagementData.QuestCelebrationRecharge == nil then
        ManagementData.QuestCelebrationRecharge = DataExHelper.Check_ConfigQuestEventByText(ManagementConst.QuestCelebrationRecharge)
    end
    local quests = DataMgr.Player.quests
    local len = #ManagementData.QuestCelebrationRecharge
    local allDatas = {}
    local totalProgress = 0
    local canGetCount = 0
    for i = 1, len do
        local questConfig = ManagementData.QuestCelebrationRecharge[i]
        local questData = quests[questConfig.id]
        local data = {}
        data.config = questConfig
        data.rewards = questConfig.showReward
        data.goalProgress = questConfig.progress
        data.status = questData and questData.state or (CommonRewardItem.Status.None + 1)
        data.questData = questData
        if data.status > 1 then
            totalProgress = totalProgress + 1
        end
        if (data.status - 1) == CommonRewardItem.Status.CanGet then
            canGetCount = canGetCount + 1
        end
        table.insert(allDatas, data)
    end
    return allDatas, totalProgress, canGetCount
end




ManagementData.GetDelegatedData = function(pageType)
    local areaType = ManagementConst.EventType.Repeat
    local configList = this.eventDic[areaType]
    if configList == nil then
        configList = DataExHelper.EX_GetEventListByArea(areaType)
        this.eventDic[areaType] = configList
    end
    local datas = {}
    local configDic = DataExHelper.GetActivityMapEventMap()
    for i = 1, #configList do
        local config = configList[i]
        local data = {}
        data.config = config
        data.ID = config.id
        data.name = LuaMgr.GetLangText(data.config.namelan)
        data.desc = LuaMgr.GetLangText(data.config.descriptionlan)
        data.isUnLock = ManagementData.CheckUnlock(data.config, configDic)
        data.isFinish = ManagementData.CheckFinish(data.config)
        data.type = data.config.type
        if data.type == ManagementConst.PassNumType.Fushua or data.type == ManagementConst.PassNumType.MainLine then
            data.reward = ManagementData.GetPassReward(data.config)
        elseif data.type == ManagementConst.PassNumType.Event then
            data.reward = ManagementData.GetGameRewardConfig(data.config)
        end
        if data.reward == nil then
            data.reward = {}
        end
        if pageType == ManagementConst.DelegeateType.All then
            if data.isUnLock == true then
                table.insert(datas, #datas + 1, data)
            end
        elseif pageType == ManagementConst.DelegeateType.Completed then
            if data.isFinish == true then
                table.insert(datas, #datas + 1, data)
            end
        elseif pageType == ManagementConst.DelegeateType.NoComplete then
            if data.isUnLock == true and data.isFinish == false then
                table.insert(datas, #datas + 1, data)
            end
        end
    end
    return datas
end

function ManagementData.SetNeedOpenDelegate(isNeed, curSelectPage)
    this.isNeedOpenDelegate = isNeed
    this.curSelectPage = curSelectPage
end

function ManagementData.NeedOpenDelegate()
    return this.isNeedOpenDelegate, this.curSelectPage
end

function ManagementData.GetPassReward(config)
    local dungeon = ConfigMgr.Config.dungeonMap[config.eventParam]
    local rewardMap = {}
    if IsNull(dungeon) then
        return
    end
    for i, v in ipairs(dungeon.firstDrop) do
        local items = ConfigMgr.Config.dropMap[v.id].items
        for p, m in ipairs(items) do
            if rewardMap[m.id] == nil then
                rewardMap[m.id] = m.count
            else
                rewardMap[m.id] = rewardMap[m.id] + m.count
            end
        end
    end
    local raring = DataExHelper.GetDungeonDecordRating(config.eventParam)
    local allDatas = {}
    for id, v in pairs(rewardMap) do
        local itemConfig = ConfigMgr.Config.itemMap[id]
        if (itemConfig == nil) then
            return
        end
        local tempData = {}
        tempData.id = id
        tempData.count = v
        tempData.status = raring > 0 and CommonRewardItem.Status.Got or CommonRewardItem.Status.None
        tempData.scale = 0.6
        table.insert(allDatas, tempData)
    end
    return allDatas
end

function ManagementData.GetGameRewardConfig(config)
    local passConfig = ConfigMgr.Config.ManagementGameMap[config.eventParam]
    local isFinish = ManagementData.CheckFinish(config)
    local rewardMap = passConfig.reward
    local allDatas = {}
    for key, item in pairs(rewardMap) do
        local itemConfig = ConfigMgr.Config.itemMap[item.id]
        if (itemConfig == nil) then
            return
        end
        local tempData = {}
        tempData.id = item.id
        tempData.count = item.count
        tempData.status = isFinish == true and CommonRewardItem.Status.Got or CommonRewardItem.Status.None
        tempData.scale = 0.6
        table.insert(allDatas, tempData)
    end
    return allDatas
end

ManagementData.GetDelegateSeletedID = function()
    return this.delegateSeletedID
end

ManagementData.SetDelegateSeletedID = function(id)
    this.delegateSeletedID = id
end

ManagementData.GetMaxReputationLevel = function()
    if this.maxReputationLevel == nil then
        this.maxReputationLevel = NumTool.GetLen(ConfigMgr.Config.ManagementReputationMap)
    end
    return this.maxReputationLevel
end


ManagementData.GetHardDelegatedData = function()
    local areaType = ManagementConst.EventType.Hard
    if this.eventDic[areaType] == nil then
        local configList = DataExHelper.EX_GetEventListByArea(areaType)
        this.eventDic[areaType] = configList
    end
    local data = {}
    data.configList = this.eventDic[areaType]
    data.serverData = {}
    return data
end


ManagementData.GetNovelData = function()
    local areaType = ManagementConst.EventType.Story
    local configList = this.eventDic[areaType]
    local configDic = DataExHelper.GetActivityMapEventMap()
    if configList == nil then
        configList = DataExHelper.EX_GetEventListByArea(areaType)
        this.eventDic[areaType] = configList
    end
    local datas = {}
    local noWatchNum = 0
    for i = 1, #configList do
        local config = configList[i]
        local data = {}
        data.config = config
        data.ID = data.id
        data.name = LuaMgr.GetLangText(data.config.namelan)
        if data.config.unlockParam == nil or data.config.unlockParam == "" then
            data.isUnLock = true
        else
            data.isUnLock = DataHelper.CheckNovelComplete(data.config.unlockParam)
            data.unlockText = ""
            if configDic ~= nil then
                local name = LuaMgr.GetLangText(configDic[data.config.unlockParam].namelan)
                local lan = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_27111")
                data.unlockText = string.format(lan, name)
                if data.isUnLock == false then
                    local unlockConfig = configDic[data.config.unlockParam]
                    data.isUnLock = DataHelper.CheckDungeonComplete(unlockConfig.eventParam)
                end
            end
        end
        data.isWatch = DataHelper.CheckNovelComplete(data.config.eventParam)
        if data.isWatch == false and data.isUnLock == true then
            noWatchNum = noWatchNum + 1
        end
        table.insert(datas, #datas + 1, data)
    end
    local existNoWatch = noWatchNum > 0
    return datas, existNoWatch
end


ManagementData.GetDelegatedRewardData = function()
    local areaType = ManagementConst.RewardUIKey
    local configList = this.eventDic[areaType]
    if configList == nil then
        local activityText = "LYZMReward"
        configList = DataExHelper.Check_ConfigQuestEventByText(activityText)
        this.eventDic[areaType] = configList
    end
    local quests = DataMgr.Player.quests
    local len = #configList
    local allDatas = {}
    local existCangetReward = false
    for i = 1, len do
        local questConfig = configList[i]
        local questData = quests[questConfig.id]
        local data = {}
        data.config = questConfig
        data.rewards = questConfig.showReward
        data.goalProgress = questConfig.progress
        data.status = questData and (questData.state - 1) or CommonRewardItem.Status.None
        if data.status == CommonRewardItem.Status.CanGet then
            existCangetReward = true
        end
        data.questData = questData
        table.insert(allDatas, data)
    end
    return allDatas, existCangetReward
end


ManagementData.GetLastGetCoinTime = function()
    local level = DataMgr.Player.SmallShopData.Level
    local curTime = LuaMgr.Timestamp()
    local activityData = DataExHelper.GetDataExByTag(ActivityKey.LYZM)
    if activityData == nil then
        return 0, 0, 0
    end
    local defaultTime = math.max(DataMgr.Player.registTime, activityData and activityData.startTime or 0)
    local lastGetTime = DataMgr.Player.SmallShopData.LastCollectTime == 0 and defaultTime or DataMgr.Player.SmallShopData.LastCollectTime
    local deltaTime = curTime - lastGetTime
    local dailyAccumulateBasicSpeedInterval = ConfigMgr.Config.constants.DailyAccumulateBasicSpeedInterval * 60
    deltaTime = math.max(deltaTime, 0)
    deltaTime = math.min(deltaTime, ConfigMgr.Config.constants.DailyAccumulateTimeLimit)
    deltaTime = math.floor(deltaTime / dailyAccumulateBasicSpeedInterval)
    local earningSpeedRate = ManagementData.GetCoinSpeedByLevel(level)

    return earningSpeedRate * deltaTime, earningSpeedRate, lastGetTime
end


ManagementData.GetCoinSpeedByLevel = function(level)
    if level < 1 then
        return ConfigMgr.Config.constants.DailyAccumulateBasicSpeed[1].count
    else
        return ConfigMgr.Config.ManagementReputationMap[tostring(level)].revenue[1].count
    end
end

ManagementData.GetLevelUpNeedItem = function(level)
    return ConfigMgr.Config.ManagementReputationMap[tostring(level)].reputation[1]
end

ManagementData.CheckFinish = function(config)
    local isFinish = false
    if config.type == ManagementConst.PassNumType.Fushua or config.type == ManagementConst.PassNumType.MainLine or config.type == ManagementConst.PassNumType.Hard then
        local record = DataMgr.Player.dungeonRecords[config.eventParam]
        if (record ~= nil and record.completeCount > 0) then
            isFinish = true
        end
    elseif config.type == ManagementConst.PassNumType.Juqing then
        isFinish = DataHelper.CheckNovelComplete(config.id)
    else
        local rewardData = ManagementData.GetMiniGameData(config.eventParam)
        if rewardData ~= nil and rewardData.passed == true then
            isFinish = true
        end
    end
    return isFinish
end

ManagementData.CheckUnlock = function(config, configDic)
    if config.unlockParam == nil or config.unlockParam == "" then
        return true
    end
    local isUnlock = false
    if config.type == ManagementConst.PassNumType.Fushua or config.type == ManagementConst.PassNumType.MainLine or config.type == ManagementConst.PassNumType.Hard then
        if configDic == nil then
            configDic = DataExHelper.GetActivityMapEventMap()
        end
        local unlockConfig = configDic[config.unlockParam]
        isUnlock = DataHelper.CheckDungeonComplete(unlockConfig.eventParam)
    elseif config.type == ManagementConst.PassNumType.Juqing then
        isUnlock = DataHelper.CheckNovelComplete(config.unlockParam)
    else
        isUnlock = ManagementGameData.CheckPassIsUnlock(config.eventParam)
    end
    return isUnlock
end

ManagementData.CheckCanLevelUp = function()
    local currentLevel = DataMgr.Player.SmallShopData.Level or 0
    local maxLevel = ManagementData.GetMaxReputationLevel()
    if currentLevel >= maxLevel then
        return false
    end
    local nextLevel = currentLevel + 1
    local needItem = ManagementData.GetLevelUpNeedItem(nextLevel)
    local deltaCount = 0
    if currentLevel == 0 then
        deltaCount = needItem.count
    else
        local uplevelBeforeCount = ManagementData.GetLevelUpNeedItem(currentLevel).count
        local costReputationCount = ManagementData.GetLevelUpNeedItem(nextLevel).count
        deltaCount = costReputationCount - uplevelBeforeCount
    end
    local playerItemCount = PlayerItemMgr.GetItemCountById(needItem.id)
    if playerItemCount >= deltaCount then
        return true
    end
    return false
end

ManagementData.GetMiniGameData = function(passID)
    local serverData = DataMgr.Player.CasualsGame
    return serverData[passID] or nil
end


ManagementData.CheckRed = function()
    local _, existCanget = ManagementData.GetDelegatedRewardData()
    local redNum1 = existCanget == true and 1 or 0
    RedMgr.Singleton:UpdateClientRedData(ManagementConst.RedPoint.Reward, redNum1)

    local rewardRed, taskRed = HeroRedDataHelper.GetPassesRed()
    local redNum2 = rewardRed + taskRed
    RedMgr.Singleton:UpdateClientRedData(ManagementConst.RedPoint.Pass, redNum2)

    local _, existNoWatch = ManagementData.GetNovelData()
    local redNum3 = existNoWatch == true and 1 or 0
    RedMgr.Singleton:UpdateClientRedData(ManagementConst.RedPoint.Novel, redNum3)

    local redNum4 = ManagementData.CheckCanLevelUp() == true and 1 or 0
    RedMgr.Singleton:UpdateClientRedData(ManagementConst.RedPoint.LevelUp, redNum4)

    local _, _, lastCollectTime = ManagementData.GetLastGetCoinTime()
    local curTime = LuaMgr.Timestamp()

    local redNum5 = curTime - lastCollectTime >= 86400 and 1 or 0
    RedMgr.Singleton:UpdateClientRedData(ManagementConst.RedPoint.Collect, redNum5)

    local redNum6 = ManagementData.CheckExistNoCompleteDelegate()

    return redNum1 + redNum2 + redNum3 + redNum4 + redNum5 + redNum6
end

ManagementData.CheckExistNoCompleteDelegate = function()
    local noCompleteDelegateDatas = ManagementData.GetDelegatedData(ManagementConst.DelegeateType.NoComplete)
    local noCompleted = RedMgr.Singleton:CheckRedCondition(ManagementConst.RedPoint.Delegate)
    local redNum6 = 0
    if noCompleteDelegateDatas ~= nil and #noCompleteDelegateDatas > 0 and noCompleted == true then
        redNum6 = 1
    end
    RedMgr.Singleton:UpdateClientRedData(ManagementConst.RedPoint.Delegate, redNum6)
    return redNum6
end

