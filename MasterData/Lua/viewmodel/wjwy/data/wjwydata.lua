require("ViewModel/WJWY/Data/WJWYConst")

WJWYData = {}

local this = {
    mapEventGroup = {},
    bPlay = false,
}

WJWYData.InitData = function()
    WJWYData.InitConfig()
end

WJWYData.InitConfig = function()

    this.mapEventGroup = {}
    for key, value in pairs(WJWYConst.EventType) do
        this.mapEventGroup[value] = DataExHelper.EX_GetEventListByArea(value)
    end
end

WJWYData.SortData = function(data1, data2)
    return data1.Sort < data2.Sort
end

WJWYData.GetActiveEventsByArea = function(area)
    return this.mapEventGroup[area]
end

WJWYData.CheckActivityRunning = function(isStatic)
    if this.lastPlayerUID ~= DataMgr.Player.uid then
        WJWYData.InitData()
        this.lastPlayerUID = DataMgr.Player.uid
    end
    if not DataExHelper.CommonActivityCheck(ActivityKey.WJWY) then
        if not isStatic then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
        end
        return false
    end
    return true
end

WJWYData.GetRemainTimeStr = function()
    local activityData = DataExHelper.GetDataExByTag(ActivityKey.WJWY)
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


WJWYData.GetQuestEventDatas = function(questName)
    if this.QuestCelebrationRecharge == nil then
        this.QuestCelebrationRecharge = DataExHelper.Check_ConfigQuestEventByText(questName)
    end
    local quests = DataMgr.Player.quests
    local len = #this.QuestCelebrationRecharge
    local allDatas = {}
    local totalProgress = 0
    local canGetCount = 0
    for i = 1, len do
        local questConfig = this.QuestCelebrationRecharge[i]
        local questData = quests[questConfig.id]
        local data = {}
        data.Config = questConfig
        data.Rewards = questConfig.showReward
        data.GoalProgress = questConfig.progress
        data.Status = questData and questData.state or (CommonRewardItem.Status.None + 1)
        data.QuestData = questData
        if data.Status > 1 then
            totalProgress = totalProgress + 1
        end
        if (data.Status - 1) == CommonRewardItem.Status.CanGet then
            canGetCount = canGetCount + 1
        end
        table.insert(allDatas, data)
    end
    return allDatas, totalProgress, canGetCount
end

WJWYData.GetAllNovelDatas = function()
    if WJWYData.CheckActivityRunning(true) == false then
        return {}, {}
    end
    if this.NovelConfigs == nil then
        this.NovelConfigs = DataExHelper.EX_GetEventListByArea(WJWYConst.EventType.Novel)
    end
    local finishDatas = {}
    local allDatas = {}
    local firstUnlockData = nil
    for i = 1, #this.NovelConfigs do
        local data = this.NovelConfigs[i]
        data.Index = i
        data.IsFirst = i == 1
        data.IsLast = i == #this.NovelConfigs
        if WJWYData.CheckFinish(data) == true then
            data.Status = CommonRewardItem.Status.Got
        else
            local isUnlock, unlockDesc = WJWYData.CheckUnlock(data)
            if isUnlock == true then
                data.Status = CommonRewardItem.Status.None
            else
                data.Status = CommonRewardItem.Status.Lock
                data.UnlockDesc = unlockDesc
            end
        end
        data.Name = LuaMgr.GetLangText(data.namelan)
        data.EventType = WJWYConst.EventType.Novel
        if data.Status == CommonRewardItem.Status.Got then
            table.insert(finishDatas, data)
        elseif data.Status == CommonRewardItem.Status.None and firstUnlockData == nil then
            firstUnlockData = data
        end
        table.insert(allDatas, data)
    end
    return allDatas, firstUnlockData
end



WJWYData.GetDungeonDatas = function(dungeonType)
    if WJWYData.CheckActivityRunning(true) == false then
        return {}, {}
    end
    local configs = this.mapEventGroup[dungeonType]
    local finishDatas = {}
    local allDatas = {}
    local firstUnlockData = nil
    for i = 1, #configs do
        local data = configs[i]
        data.Index = i
        data.IsFirst = i == 1
        data.IsLast = i == #configs
        data.EventType = dungeonType
        data.DungeonType = dungeonType
        data.Name = LuaMgr.GetLangText(configs[i].namelan)
        if WJWYData.CheckFinish(data) == true then
            data.Status = CommonRewardItem.Status.Got
        else
            local isUnlock, unlockDesc = WJWYData.CheckUnlock(data)
            if isUnlock == true then
                data.Status = CommonRewardItem.Status.None
            else
                data.Status = CommonRewardItem.Status.Lock
                data.UnlockDesc = unlockDesc
            end
        end
        if data.Status == CommonRewardItem.Status.Got then
            table.insert(finishDatas, data)
        elseif data.Status == CommonRewardItem.Status.None and firstUnlockData == nil then
            firstUnlockData = data
        end
        table.insert(allDatas, data)
    end
    for i = 1, #allDatas do
        allDatas[i].PreData = allDatas[i - 1]
        allDatas[i].NextData = allDatas[i + 1]
    end
    return allDatas, firstUnlockData
end

WJWYData.SetDungeonPage = function(index)
    this.dungeonPage = index
end

WJWYData.GetDungeonPage = function()
    return this.dungeonPage or 1
end

WJWYData.SetTempDungeonData = function(pageIndex, data)
    if this.tempDungeonData == nil then
        this.tempDungeonData = {}
    end
    this.tempDungeonData[pageIndex] = data
end

WJWYData.GetTempDungeonData = function(pageIndex)
    if this.tempDungeonData == nil then
        return nil
    end
    return this.tempDungeonData[pageIndex]
end

WJWYData.CheckFinish = function(config)
    local isFinish = false
    if config.type == WJWYConst.PassNumType.Repeat or config.type == WJWYConst.PassNumType.MainLine or config.type == WJWYConst.PassNumType.Hard then
        local record = DataMgr.Player.dungeonRecords[config.eventParam]
        if record ~= nil and record.completeCount > 0 then
            isFinish = true
        end
    elseif config.type == WJWYConst.PassNumType.Novel then
        isFinish = DataHelper.CheckNovelComplete(config.eventParam)
    else
        local rewardData = WJWYData.GetMiniGameData(config.eventParam)
        if rewardData ~= nil and rewardData > 0 then
            isFinish = true
        end
    end
    return isFinish
end

WJWYData.CheckUnlock = function(config)
    if config.unlockParam == nil or config.unlockParam == "" then
        return true
    end
    if this.mapEventConfigDic == nil then
        this.mapEventConfigDic = DataExHelper.GetActivityMapEventMap()
    end
    local isUnlock = false
    local unlockText = ""
    if config.type == WJWYConst.PassNumType.Repeat or config.type == WJWYConst.PassNumType.MainLine or config.type == WJWYConst.PassNumType.Hard then
        local unlockConfig = this.mapEventConfigDic[config.unlockParam]
        isUnlock = DataHelper.CheckDungeonComplete(unlockConfig.eventParam)
        if isUnlock == false then
            local unlockConfig = this.mapEventConfigDic[config.unlockParam]
            local lanText = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30036")
            local name = LuaMgr.GetLangText(unlockConfig.namelan)
            unlockText = string.format(lanText, name)
        end
    elseif config.type == WJWYConst.PassNumType.Novel then
        isUnlock = DataHelper.CheckNovelComplete(config.unlockParam)
        if isUnlock == false then
            local unlockConfig = this.mapEventConfigDic[config.unlockParam]
            local lanText = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30035")
            local name = LuaMgr.GetLangText(unlockConfig.namelan)
            unlockText = string.format(lanText, name)
        end
    else
        local rewardData = WJWYData.GetMiniGameData(config.unlockParam)
        if rewardData ~= nil and rewardData > 0 then
            isUnlock = true
        end
        if isUnlock == false then
            local unlockConfig = this.mapEventConfigDic[config.unlockParam]
            local lanText = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30036")
            local name = LuaMgr.GetLangText(unlockConfig.namelan)
            unlockText = string.format(lanText, name)
        else
            local isUnLockTime, timeStr = WJWYData.CheckEventIsUnLockTime(config)
            if isUnLockTime == false then
                isUnlock = false
                unlockText = timeStr
            end
        end
    end
    return isUnlock, unlockText
end

WJWYData.GetMiniGameData = function(passID)
    local serverData = DataMgr.Player.SurroundGame.Rewards
    return serverData[passID] or nil
end

WJWYData.CheckEventIsUnLockTime = function(event)
    local curTimeStamp = LuaMgr.Timestamp();
    if event.openDate == 0 and event.closeDate == 0 then
        return true, nil;
    end
    local bShow = curTimeStamp >= event.openDate and curTimeStamp <= event.closeDate
    local timeStr = nil
    if (curTimeStamp < event.openDate) then
        local interval = event.openDate - curTimeStamp
        timeStr = TimeString(interval) .. ConfigMgr.LangGlobal("2092")
    end
    return bShow, timeStr
end


WJWYData.CheckGameState = function(id)
    local serverData = DataMgr.Player.SurroundGame.Rewards
    if serverData == nil then
        return -1
    end
    if (serverData[id] ~= nil) then
        return serverData[id]
    end
    return -1
end

WJWYData.GetAllQuestDatas = function()
    if this.taskQuestEvents == nil then
        local allConfigs = DataExHelper.Check_ConfigQuestEventByText(WJWYConst.QuestEventID)
        this.taskQuestEvents = allConfigs
    end
    return this.taskQuestEvents
end

WJWYData.GetQuestDataByIndex = function(index)
    local allQuestEvents = WJWYData.GetAllQuestDatas()
    local questEvent = allQuestEvents[index]
    local questData = DataMgr.Player.quests[questEvent.id]
    local data = {}
    data.Config = questEvent

    data.Status = CommonRewardItem.Status.None
    if questData ~= nil and questData.state == 2 then
        data.Status = CommonRewardItem.Status.CanGet
    elseif questData ~= nil and questData.state == 3 then
        data.Status = CommonRewardItem.Status.Got
    end
    return data
end



WJWYData.SetIsChildPanel = function(isChild)
    this.isChildPanel = isChild
end

WJWYData.GetIsChildPanel = function()
    return this.isChildPanel
end

WJWYData.SetPlayerAnimation = function(bPlay)
    this.bPlay = bPlay
end

WJWYData.GetPlayerAnimation = function()
    return this.bPlay
end



WJWYData.CheckRedPoint = function()
    if not WJWYData.CheckActivityRunning(true) then
        return 0
    end
    local activityData = DataExHelper.GetDataExByTag(ActivityKey.WJWY)
    if activityData == nil then
        return 0
    end
    local rewardRed, taskRed = HeroRedDataHelper.GetPassesRed()
    local redNum1 = rewardRed + taskRed
    RedMgr.Singleton:UpdateClientRedData(WJWYConst.RedPoint.Pass, redNum1)

    local redNum2 = WJWYData.CheckNovelPoint()
    RedMgr.Singleton:UpdateClientRedData(WJWYConst.RedPoint.Novel, redNum2)

    local redNum3_1 = WJWYData.GetDungeonRedPoint(WJWYConst.EventType.Repeat)
    local redNum3_2 = WJWYData.GetDungeonRedPoint(WJWYConst.EventType.Hard)
    local redNum3_3 = WJWYData.GetDungeonRedPoint(WJWYConst.EventType.MainLine)
    local redNum3_4 = WJWYData.GetDungeonRedPoint(WJWYConst.EventType.Play)
    local redNum3 = redNum3_1 + redNum3_2 + redNum3_3
    RedMgr.Singleton:UpdateClientRedData(WJWYConst.RedPoint.Dungeon, redNum3)

    local _, _, canGetCount = WJWYData.GetQuestEventDatas(WJWYConst.TaskEventIDName)
    local redNum4 = canGetCount
    RedMgr.Singleton:UpdateClientRedData(WJWYConst.RedPoint.Task, redNum4)
    RedMgr.Singleton:UpdateClientRedData(WJWYConst.RedPoint.Game, redNum3_4 + redNum4)
    return redNum1 + redNum2 + redNum3 + redNum4 + redNum3_4
end


WJWYData.GetDungeonRedPoint = function(dungeonType)
    local prefix = nil
    if dungeonType == WJWYConst.EventType.Repeat then
        prefix = WJWYConst.RedPoint.Repeat
    elseif dungeonType == WJWYConst.EventType.Hard then
        prefix = WJWYConst.RedPoint.HardDungeon
    elseif dungeonType == WJWYConst.EventType.MainLine then
        prefix = WJWYConst.RedPoint.MainLineDungeon
    elseif dungeonType == WJWYConst.EventType.Play then
        prefix = WJWYConst.RedPoint.Game
    end
    if prefix == nil then
        return 0
    end
    local _, firstUnlockData = WJWYData.GetDungeonDatas(dungeonType)
    if firstUnlockData == nil then
        return 0
    end
    local redID = string.format("%s_%s", prefix, firstUnlockData.id)
    if RedMgr.Singleton:CheckRedCondition(redID) == true then
        return 1
    end
    return 0
end

WJWYData.CheckNovelPoint = function()
    local _, newNovelData = WJWYData.GetAllNovelDatas()
    if newNovelData == nil then
        return 0
    end
    local redID = string.format("%s_%s", WJWYConst.RedPoint.Novel, newNovelData.eventParam)
    if RedMgr.Singleton:CheckRedCondition(redID) == true then
        return 1
    end
    return 0
end

