require("ViewModel/JiYeChangSheng/Data/JYCSConst")

JYCSData = {}

local this = {
    mapDatas = {},
    mapDataDic = {},
    pointConfigMapDic = {},
    moveEventTestStep = nil
}

JYCSData.InitData = function()
    JYCSData.InitConfig()
end

JYCSData.InitConfig = function()
    JYCSConst.OperateRollTime = ConfigMgr.Config.JYCSConstants.OperateRollTime
    JYCSConst.LoseCloseTime = ConfigMgr.Config.JYCSConstants.LoseCloseTime
    JYCSConst.SuccessCloseTime = ConfigMgr.Config.JYCSConstants.SuccessCloseTime
    JYCSConst.RoleMoveDelay = ConfigMgr.Config.JYCSConstants.RoleMoveDelay
    JYCSConst.RoleRotateDelay = ConfigMgr.Config.JYCSConstants.RoleRotateDelay
    JYCSConst.IntroAnimTime = ConfigMgr.Config.JYCSConstants.NtroAnimTime

    this.mapEventGroup = {}
    this.mapDatas = {}
    this.mapDataDic = {}
    this.pointConfigMapDic = {}
    for key, value in pairs(JYCSConst.EventType) do
        this.mapEventGroup[value] = DataExHelper.EX_GetEventListByArea(value)
    end

    local mapPointConfigs = ConfigMgr.Config.JYCSMapPointMap
    local pointConfigDic = {}
    for id, config in pairs(mapPointConfigs) do
        local mapID = config.MapId
        if pointConfigDic[mapID] == nil then
            pointConfigDic[mapID] = {}
        end
        local data = {}
        data.ID = id
        data.Config = config
        data.Sort = config.Sort
        data.BlockStatus = JYCSConst.BlockStatus.Default
        data.IsCurrent = false
        local eventGroupID = config.EventGroupId
        if eventGroupID ~= nil and eventGroupID ~= "" and eventGroupID ~= 0 and eventGroupID ~= "0" then
            data.EventGroup = ConfigMgr.Config.JYCSEventGroupMap[eventGroupID]
        end

        table.insert(pointConfigDic[mapID], data)
        this.pointConfigMapDic[id] = data
    end

    local passConfigs = ConfigMgr.Config.JYCSMaps
    for id, config in pairs(passConfigs) do
        local data = {}
        data.ID = id
        data.Config = config
        data.BlockDatas = pointConfigDic[id] or {}
        table.sort(data.BlockDatas, JYCSData.SortData)
        for index, blockData in ipairs(data.BlockDatas) do
            blockData.Index = index
        end
        table.insert(this.mapDatas, data)
        this.mapDataDic[id] = data
    end
end

JYCSData.SortData = function(data1, data2)
    return data1.Sort < data2.Sort
end

JYCSData.CheckActivityRunning = function(isStatic)
    if this.lastPlayerUID ~= DataMgr.Player.uid then
        JYCSData.InitData()
        this.lastPlayerUID = DataMgr.Player.uid
    end
    if not DataExHelper.CommonActivityCheck(ActivityKey.JYCS) then
        if not isStatic then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
        end
        return false
    end
    return true
end

JYCSData.GetRemainTimeStr = function()
    local activityData = DataExHelper.GetDataExByTag(ActivityKey.JYCS)
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


JYCSData.GetQuestEventDatas = function(questName)
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
        local state = questData.state or 1
        data.Status = state  - 1
        if data.Status < 0 then
            data.Status = CommonRewardItem.Status.None
        end
        data.QuestData = questData
        if data.Status > 1 then
            totalProgress = totalProgress + 1
        end
        if data.Status == CommonRewardItem.Status.CanGet then
            canGetCount = canGetCount + 1
        end
        table.insert(allDatas, data)
    end
    return allDatas, totalProgress, canGetCount
end

JYCSData.GetAllNovelDatas = function()
    if JYCSData.CheckActivityRunning(true) == false then
        return {}, {}
    end
    if this.NovelConfigs == nil then
        this.NovelConfigs = DataExHelper.EX_GetEventListByArea(JYCSConst.EventType.Novel)
    end
    local finishDatas = {}
    local allDatas = {}
    local firstUnlockData = nil
    for i = 1, #this.NovelConfigs do
        local data = this.NovelConfigs[i]
        data.Index = i
        data.IsFirst = i == 1
        data.IsLast = i == #this.NovelConfigs
        if JYCSData.CheckFinish(data) == true then
            data.Status = CommonRewardItem.Status.Got
        else
            local isUnlock, unlockDesc = JYCSData.CheckUnlock(data)
            if isUnlock == true then
                data.Status = CommonRewardItem.Status.None
            else
                data.Status = CommonRewardItem.Status.Lock
                data.UnlockDesc = unlockDesc
            end
        end
        data.Name = LuaMgr.GetLangText(data.namelan)
        data.EventType = JYCSConst.EventType.Novel
        if data.Status == CommonRewardItem.Status.Got then
            table.insert(finishDatas, data)
        elseif data.Status == CommonRewardItem.Status.None and firstUnlockData == nil then
            firstUnlockData = data
        end
        table.insert(allDatas, data)
    end
    return allDatas, firstUnlockData
end



JYCSData.GetDungeonDatas = function(dungeonType)
    if JYCSData.CheckActivityRunning(true) == false then
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
        if JYCSData.CheckFinish(data) == true then
            data.Status = CommonRewardItem.Status.Got
        else
            local isUnlock, unlockDesc = JYCSData.CheckUnlock(data)
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
    return allDatas, firstUnlockData
end

JYCSData.SetDungeonPage = function(index)
    this.dungeonPage = index
end

JYCSData.GetDungeonPage = function()
    return this.dungeonPage or 1
end

JYCSData.SetTempDungeonData = function(pageIndex, data)
    if this.tempDungeonData == nil then
        this.tempDungeonData = {}
    end
    this.tempDungeonData[pageIndex] = data
end

JYCSData.GetTempDungeonData = function(pageIndex)
    if this.tempDungeonData == nil then
        return nil
    end
    return this.tempDungeonData[pageIndex]
end

JYCSData.CheckFinish = function(config)
    local isFinish = false
    if config.type == JYCSConst.PassNumType.Repeat or config.type == JYCSConst.PassNumType.MainLine or config.type == JYCSConst.PassNumType.Hard then
        local record = DataMgr.Player.dungeonRecords[config.eventParam]
        if record ~= nil and record.completeCount > 0 then
            isFinish = true
        end
    elseif config.type == JYCSConst.PassNumType.Novel then
        isFinish = DataHelper.CheckNovelComplete(config.eventParam)
    else
        local rewardData = JYCSData.GetMiniGameData(config.eventParam)
        if rewardData ~= nil and rewardData > 0 then
            isFinish = true
        end
    end
    return isFinish
end

JYCSData.CheckUnlock = function(config)
    if config.unlockParam == nil or config.unlockParam == "" then
        return true
    end
    if this.mapEventConfigDic == nil then
        this.mapEventConfigDic = DataExHelper.GetActivityMapEventMap()
    end
    local isUnlock = false
    local unlockText = ""
    if config.type == JYCSConst.PassNumType.Repeat or config.type == JYCSConst.PassNumType.MainLine or config.type == JYCSConst.PassNumType.Hard then
        local unlockConfig = this.mapEventConfigDic[config.unlockParam]
        isUnlock = DataHelper.CheckDungeonComplete(unlockConfig.eventParam)
        if isUnlock == false then
            local unlockConfig = this.mapEventConfigDic[config.unlockParam]
            local lanText = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30036")
            local name = LuaMgr.GetLangText(unlockConfig.namelan)
            unlockText = string.format(lanText, name)
        end
    elseif config.type == JYCSConst.PassNumType.Novel then
        isUnlock = DataHelper.CheckNovelComplete(config.unlockParam)
        if isUnlock == false then
            local unlockConfig = this.mapEventConfigDic[config.unlockParam]
            local lanText = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30035")
            local name = LuaMgr.GetLangText(unlockConfig.namelan)
            unlockText = string.format(lanText, name)
        end
    end
    return isUnlock, unlockText
end

JYCSData.GetAllQuestDatas = function()
    if this.taskQuestEvents == nil then
        local allConfigs = DataExHelper.Check_ConfigQuestEventByText(JYCSConst.QuestEventID)
        this.taskQuestEvents = allConfigs
    end
    return this.taskQuestEvents
end

JYCSData.GetQuestDataByIndex = function(index)
    local allQuestEvents = JYCSData.GetAllQuestDatas()
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



JYCSData.SetIsChildPanel = function(isChild)
    this.isChildPanel = isChild
end

JYCSData.GetIsChildPanel = function()
    return this.isChildPanel
end

JYCSData.SaveGameBattleResumeData = function(data)
    this.gameBattleResumeData = data
end

JYCSData.GetGameBattleResumeData = function()
    return this.gameBattleResumeData
end

JYCSData.ClearGameBattleResumeData = function()
    this.gameBattleResumeData = nil
end


















JYCSData.GetBlockIndex = function(mapData, blockID)
    if mapData == nil or blockID == nil or blockID == "" then
        return nil
    end
    local blockData = this.pointConfigMapDic[blockID]
    if blockData == nil or blockData.Config.MapId ~= mapData.ID then
        return nil
    end
    return blockData.Index
end

JYCSData.GetBlockIDByIndex = function(mapData, blockIndex)
    if mapData == nil then
        return nil
    end
    local blockData = mapData.BlockDatas[blockIndex]
    return blockData ~= nil and blockData.ID or nil
end

JYCSData.GetServerRound = function()
    return this.GetServerData().DiceCount or 0
end

JYCSData.GetMonsterRound = function()
    return this.GetServerData().MonsterRound or 0
end

JYCSData.IsPassRunMonster = function(mapData)
    local passRunMonster = this.GetServerData().PassRunMonster
    if type(passRunMonster) ~= "table" or next(passRunMonster) == nil or mapData == nil then
        return false
    end
    return JYCSData.GetBlockIndex(mapData, this.GetServerData().MonsterPosition) ~= nil
end

JYCSData.GetMonsterPosition = function(mapData)
    if mapData == nil then
        return nil
    end
    local serverData = this.GetServerData()
    local monsterPosition = serverData.MonsterPosition
    local startIndex = JYCSData.GetBlockIndex(mapData, monsterPosition)
    if startIndex == nil then
        return nil
    end
    local activeRound = JYCSData.GetMonsterRound() - mapData.Config.WaitTime
    local moveStep = math.max(0, activeRound) * mapData.Config.Speed
    local targetIndex = (startIndex - 1 + moveStep) % #mapData.BlockDatas + 1
    return JYCSData.GetBlockIDByIndex(mapData, targetIndex)
end

JYCSData.GetMonsterBlockIndex = function(mapData, round)
    if mapData == nil or #mapData.BlockDatas == 0 then
        return nil
    end
    if JYCSData.IsPassRunMonster(mapData) == true then
        local monsterPosition = JYCSData.GetMonsterPosition(mapData)
        return JYCSData.GetBlockIndex(mapData, monsterPosition)
    end
    local config = mapData.Config
    local moveRound = math.max(0, (round or JYCSData.GetServerRound()) - config.Round)
    return (config.MonsterStartPoint - 1 + moveRound * config.Speed) % #mapData.BlockDatas + 1
end

JYCSData.GetMonsterDungeonID = function(mapData)
    if mapData == nil or mapData.Config == nil or mapData.Config.EventId == nil or mapData.Config.EventId == "" then
        return nil
    end
    local eventConfig = ConfigMgr.Config.JYCSEventMap[mapData.Config.EventId]
    if eventConfig == nil or type(eventConfig.OptionsParame) ~= "table" then
        return nil
    end
    return eventConfig.OptionsParame[1]
end

JYCSData.ShouldShowMonster = function(mapData, round)
    if JYCSData.GetMonsterDungeonID(mapData) == nil then
        return false
    end
    if JYCSData.IsPassRunMonster(mapData) == true then
        return JYCSData.GetMonsterPosition(mapData) ~= nil
    end
    return (round or JYCSData.GetServerRound()) >= mapData.Config.Round
end

JYCSData.IsMonsterSleeping = function(mapData)
    if JYCSData.IsPassRunMonster(mapData) == false then
        return false
    end
    return JYCSData.GetMonsterRound() <= mapData.Config.WaitTime
end

JYCSData.GetForwardBlockStepCount = function(mapData, startIndex, targetIndex)
    if mapData == nil or startIndex == nil or targetIndex == nil then
        return 0
    end
    return (targetIndex - startIndex) % #mapData.BlockDatas
end

JYCSData.GetCurrentMonsterMoveRange = function(mapData)
    if mapData == nil or mapData.Config == nil or type(mapData.BlockDatas) ~= "table" or #mapData.BlockDatas == 0 then
        return nil, nil, 0
    end
    local speed = math.max(0, math.floor(tonumber(mapData.Config.Speed) or 0))
    if speed <= 0 then
        return nil, nil, 0
    end
    if JYCSData.IsPassRunMonster(mapData) == true then
        local startIndex = JYCSData.GetBlockIndex(mapData, this.GetServerData().MonsterPosition)
        local waitTime = math.max(0, tonumber(mapData.Config.WaitTime) or 0)
        local activeRound = math.floor(tonumber(JYCSData.GetMonsterRound()) or 0) - waitTime
        if startIndex == nil or activeRound <= 0 then
            return nil, nil, 0
        end
        local previousIndex = (startIndex - 1 + (activeRound - 1) * speed) % #mapData.BlockDatas + 1
        local targetIndex = (previousIndex - 1 + speed) % #mapData.BlockDatas + 1
        return previousIndex, targetIndex, speed
    end
    local currentRound = math.floor(tonumber(JYCSData.GetServerRound()) or 0)
    local appearRound = math.max(0, math.floor(tonumber(mapData.Config.Round) or 0))
    if currentRound <= appearRound then
        return nil, nil, 0
    end
    local previousIndex = JYCSData.GetMonsterBlockIndex(mapData, currentRound - 1)
    local targetIndex = JYCSData.GetMonsterBlockIndex(mapData, currentRound)
    return previousIndex, targetIndex, speed
end

JYCSData.IsBlockInCurrentMonsterMovePath = function(mapData, blockIndex)
    local targetBlockIndex = tonumber(blockIndex)
    local previousIndex, _, moveStep = JYCSData.GetCurrentMonsterMoveRange(mapData)
    if targetBlockIndex == nil or previousIndex == nil or moveStep <= 0 then
        return false
    end
    local blockCount = #mapData.BlockDatas
    targetBlockIndex = math.max(1, math.min(math.floor(targetBlockIndex), blockCount))
    local forwardStep = JYCSData.GetForwardBlockStepCount(mapData, previousIndex, targetBlockIndex)
    if forwardStep == 0 then
        return moveStep >= blockCount
    end
    return forwardStep <= moveStep
end

JYCSData.GetMapData = function()
    local serverData = this.GetServerData()
    local mapID = serverData.MapId
    local data = this.mapDataDic[mapID]
    if data == nil then
        LuaDebug.error("JYCSData.GetMapDataByID mapID is nil : " .. tostring(mapID))
        return nil
    end
    local blockStatus = serverData.BlockStatus or {}
    for i = 1, #data.BlockDatas do
        local blockData = data.BlockDatas[i]
        local blockStatus = blockStatus[blockData.ID]
        if blockStatus ~= nil then
            blockData.BlockStatus = JYCSConst.BlockStatus.Finish
        else
            blockData.BlockStatus = JYCSConst.BlockStatus.Default
        end
        if blockData.ID == serverData.BlockId then
            blockData.IsCurrent = true
            this.latsBlockID = blockData.ID
        else
            blockData.IsCurrent = false
        end
    end
    return data
end

JYCSData.GetCurBlock = function()
    local serverData = this.GetServerData()
    return serverData.BlockId or 0
end

JYCSData.UpdateCurBlock = function(blockID)
    if blockID == nil or blockID == "" or blockID == 0 then
        return
    end
    local serverData = this.GetServerData()
    serverData.BlockId = blockID
    JYCSData.RefreshBlockData(blockID)
end



JYCSData.GetDangerValue = function()
    local serverData = this.GetServerData()
    return serverData.DangerVal or 0
end

JYCSData.GetCostRollTimes = function()
    local serverData = this.GetServerData()
    return serverData.Dice or 0
end

JYCSData.GetCostRollRemainTimes = function(mapData)
    if mapData == nil then
        return 0, 0
    end
    local maxRollTimes = tonumber(mapData.Config.Cost) or 0
    local usedRollTimes = tonumber(JYCSData.GetCostRollTimes()) or 0
    return math.max(0, maxRollTimes - usedRollTimes), maxRollTimes
end

JYCSData.CanUseCostRoll = function(mapData)
    local remainRollTimes = JYCSData.GetCostRollRemainTimes(mapData)
    return remainRollTimes > 0
end

JYCSData.RefreshBlockData = function(blockID)
    local blockData = this.pointConfigMapDic[blockID]
    if blockData == nil then
        return
    end
    local serverData = this.GetServerData()
    local blockStatus = serverData.BlockStatus or {}
    if blockStatus[blockID] ~= nil then
        blockData.BlockStatus = JYCSConst.BlockStatus.Finish
    end
    if blockID == serverData.BlockId then
        blockData.IsCurrent = true
    else
        blockData.IsCurrent = false
    end
    if this.latsBlockID ~= nil then
        local lastBlockData = this.pointConfigMapDic[this.latsBlockID]
        if lastBlockData ~= nil then
            lastBlockData.IsCurrent = false
        end
    end

    local curBlockData = this.pointConfigMapDic[serverData.BlockId]
    if curBlockData ~= nil then
        curBlockData.IsCurrent = true
        this.latsBlockID = curBlockData.ID
    end
end



JYCSData.CheckIsMapLastBlock = function(blockID)
    local serverData = this.GetServerData()
    local mapID = serverData.MapId
    if blockID == nil or blockID == "" then
        blockID = serverData.BlockId
    end
    if mapID == nil or mapID == "" or blockID == nil or blockID == "" then
        return false
    end
    local mapData = this.mapDataDic[mapID]
    if mapData == nil then
        return false
    end
    local lastBlockData = mapData.BlockDatas[#mapData.BlockDatas]
    if lastBlockData == nil then
        return false
    end
    return lastBlockData.ID == blockID
end




JYCSData.CheckBlockType = function(blockData, blockType)
    if blockData == nil or blockData.Config == nil then
        return false
    end
    return blockData.Config.Type == blockType
end





JYCSData.CheckBlockIsSkip = function(blockData, blockType, blockStatus)
    if JYCSData.CheckBlockType(blockData, blockType) == false then
        return false
    end
    return type(blockStatus) == "table" and blockStatus[blockData.ID] == nil
end

JYCSData.IsEndlessMap = function(mapData)
    return mapData ~= nil and mapData.Config ~= nil and tonumber(mapData.Config.MapType) == 2
end






JYCSData.GetPlayerMoveStep = function(mapData, startIndex, moveStep)
    if mapData == nil or type(mapData.BlockDatas) ~= "table" then
        return nil
    end
    local blockCount = #mapData.BlockDatas
    local currentIndex = tonumber(startIndex)
    local step = tonumber(moveStep)
    if blockCount <= 0 or currentIndex == nil or step == nil then
        return nil
    end
    currentIndex = math.max(1, math.min(math.floor(currentIndex), blockCount))
    step = step >= 0 and math.floor(step) or math.ceil(step)
    if step >= 0 then
        return math.min(step, blockCount - currentIndex)
    end
    local maxBackwardStep = JYCSData.IsEndlessMap(mapData) == true and currentIndex or currentIndex - 1
    return -math.min(math.abs(step), maxBackwardStep)
end






JYCSData.GetTargetBlockIndex = function(mapData, startIndex, moveStep)
    if mapData == nil or type(mapData.BlockDatas) ~= "table" then
        return nil
    end
    local blockCount = #mapData.BlockDatas
    local currentIndex = tonumber(startIndex)
    local step = JYCSData.GetPlayerMoveStep(mapData, startIndex, moveStep)
    if blockCount <= 0 or currentIndex == nil or step == nil then
        return nil
    end
    currentIndex = math.max(1, math.min(math.floor(currentIndex), blockCount))
    local targetIndex = currentIndex + step
    if JYCSData.IsEndlessMap(mapData) == true then
        return (targetIndex - 1) % blockCount + 1
    end
    return math.max(1, math.min(targetIndex, blockCount))
end



JYCSData.GetNormalRollNum = function()
    local serverData = this.GetServerData()
    local curBlockData = this.pointConfigMapDic[serverData.BlockId]
    if curBlockData == nil then
        LuaDebug.error("JYCSData.GetNormalRollNum curBlockData is nil")
        return 0
    end
    local curIndex = curBlockData.Index
    local curMapData = this.mapDataDic[serverData.MapId]
    if curMapData == nil then
        LuaDebug.error("JYCSData.GetNormalRollNum curMapData is nil" .. tostring(serverData.MapId))
        return 0
    end
    local remainCount = #curMapData.BlockDatas - curIndex
    if remainCount <= 0 then
        return 0
    end
    local rollNum = math.random(1, 6)
    local blockStatus = serverData.BlockStatus or {}
    local existSkipEvent = false
    if curIndex > 1 then
        for i = 1, curIndex - 1 do
            local blockData = curMapData.BlockDatas[i]
            if JYCSData.CheckBlockIsSkip(blockData, 1, blockStatus) == true then
                existSkipEvent = true
                break
            end
        end
    end
    if existSkipEvent == true then
        local maxStep = math.min(6, remainCount)
        for step = 1, maxStep do
            local targetIndex = JYCSData.GetTargetBlockIndex(curMapData, curIndex, step)
            local blockData = curMapData.BlockDatas[targetIndex]
            if JYCSData.CheckBlockIsSkip(blockData, 1, blockStatus) == true then
                rollNum = step
                break
            end
        end
    end
    if rollNum > remainCount then
        rollNum = remainCount
    end
    return rollNum
end

JYCSData.GetRollNum = function()
    return JYCSData.GetNormalRollNum()
end

JYCSData.ClampRollNumToMapEnd = function(mapData, rollNum)
    local value = math.max(0, tonumber(rollNum) or 0)
    if mapData == nil then
        return value
    end
    local curBlockIndex = JYCSData.GetBlockIndex(mapData, JYCSData.GetCurBlock())
    if curBlockIndex == nil then
        return value
    end
    local remainBlockCount = math.max(0, #mapData.BlockDatas - curBlockIndex)
    return math.min(value, remainBlockCount)
end

JYCSData.IsBlockFinished = function(blockID)
    if blockID == nil or blockID == "" then
        return false
    end
    local blockStatus = this.GetServerData().BlockStatus or {}
    return blockStatus[blockID] ~= nil
end

JYCSData.GetBlockEventID = function(blockData, ignoreBlockStatus)
    if blockData == nil then
        return nil
    end
    if ignoreBlockStatus ~= true and JYCSData.IsBlockFinished(blockData.ID) == true then
        return nil
    end
    local eventGroupID = blockData.Config.EventGroupId
    if eventGroupID == nil or eventGroupID == "" or eventGroupID == 0 or eventGroupID == "0" then
        return nil
    end
    local eventGroupConfig = blockData.EventGroup
    if eventGroupConfig == nil or type(eventGroupConfig.EventId) ~= "table" or #eventGroupConfig.EventId == 0 then
        LuaDebug.error("JYCSData.GetBlockEventID: Event group data is invalid")
        return nil
    end

    local allFinishEvent = JYCSData.GetAllFinishEvent()
    if #eventGroupConfig.EventId == 1 then
        local eventID = eventGroupConfig.EventId[1]
        if allFinishEvent[eventID] ~= true then
            return eventID
        end
        return nil
    end

    local weightConfigs = type(eventGroupConfig.Weight) == "table" and eventGroupConfig.Weight or {}
    local candidates = {}
    local totalWeight = 0
    for i = 1, #eventGroupConfig.EventId do
        local eventID = eventGroupConfig.EventId[i]
        if allFinishEvent[eventID] ~= true then
            local weight = tonumber(weightConfigs[i]) or 0
            table.insert(candidates, {ID = eventID, Weight = weight})
            if weight > 0 then
                totalWeight = totalWeight + weight
            end
        end
    end

    if #candidates == 0 then
        return nil
    end

    if totalWeight <= 0 then
        return candidates[math.random(1, #candidates)].ID
    end

    local randomWeight = math.random() * totalWeight
    local currentWeight = 0
    for i = 1, #candidates do
        local candidate = candidates[i]
        if candidate.Weight > 0 then
            currentWeight = currentWeight + candidate.Weight
            if randomWeight <= currentWeight then
                return candidate.ID
            end
        end
    end
    return candidates[#candidates].ID
end

JYCSData.GetCurrentBlockEventID = function(rollNum)
    if type(rollNum) ~= "number" then
        LuaDebug.error("JYCSData.GetCurrentBlockEventID: rollNum is invalid")
        return nil
    end
    local serverData = this.GetServerData()
    local curBlockData = this.pointConfigMapDic[serverData.BlockId]
    local curMapData = this.mapDataDic[serverData.MapId]
    if curBlockData == nil or curMapData == nil then
        return nil
    end
    local targetIndex = JYCSData.GetTargetBlockIndex(curMapData, curBlockData.Index, rollNum)
    return JYCSData.GetBlockEventID(curMapData.BlockDatas[targetIndex])
end

JYCSData.GetEventConfigByRoll = function(rollNum)
    local id = JYCSData.GetCurrentBlockEventID(rollNum)
    return ConfigMgr.Config.JYCSEventMap[id]
end

JYCSData.GetEventConfigByBlock = function(blockData, ignoreBlockStatus)
    local eventID = JYCSData.GetBlockEventID(blockData, ignoreBlockStatus)
    return ConfigMgr.Config.JYCSEventMap[eventID]
end

JYCSData.GetEventMoveStep = function(eventData, selectIndex)
    local eventParams = type(eventData.OptionsParame) == "table" and eventData.OptionsParame or {}
    local configStep = tonumber(eventParams[selectIndex]) or tonumber(eventParams[1]) or 0
    return this.moveEventTestStep or configStep
end

JYCSData.GetEventOptionParam = function(eventData, selectIndex)
    if eventData.Type == JYCSConst.MapEventType.Move then
        return JYCSData.GetEventMoveStep(eventData, selectIndex)
    end
    local eventParams = type(eventData.OptionsParame) == "table" and eventData.OptionsParame or {}
    return tonumber(eventParams[selectIndex]) or 0
end

JYCSData.GetEventSubmitBlockID = function(mapData, blockData, eventData, selectIndex)
    if eventData.Type ~= JYCSConst.MapEventType.Move then
        return blockData.ID
    end
    local moveStep = JYCSData.GetEventMoveStep(eventData, selectIndex)
    local blockIndex = JYCSData.GetBlockIndex(mapData, blockData.ID)
    if moveStep == 0 or blockIndex == nil then
        return blockData.ID
    end
    local targetIndex = JYCSData.GetTargetBlockIndex(mapData, blockIndex, moveStep)
    return JYCSData.GetBlockIDByIndex(mapData, targetIndex) or blockData.ID
end

JYCSData.GetEventNeedStep = function(isCostRoll, isMoveEvent, needStep)
    local requestNeedStep = tonumber(needStep)
    if requestNeedStep ~= nil then
        return requestNeedStep
    end
    if isMoveEvent == true then
        return JYCSConst.EventNeedStep.IgnoreMonsterRound
    end
    if isCostRoll == true then
        return JYCSConst.EventNeedStep.CostRoll
    end
    return JYCSConst.EventNeedStep.NormalRoll
end

JYCSData.BuildBlockEventRequest = function(mapData, blockData, eventData, selectIndex, isCostRoll, isMoveEvent)
    local requestData = {
        MapId = mapData.ID,
        BlockId = JYCSData.GetEventSubmitBlockID(mapData, blockData, eventData, selectIndex),
        EventId = eventData.Id,
        EventTyp = eventData.Type,
        Param = JYCSData.GetEventOptionParam(eventData, selectIndex),
        NeedStep = JYCSData.GetEventNeedStep(isCostRoll, isMoveEvent)
    }
    return requestData
end

JYCSData.BuildEmptyBlockEventRequest = function(mapData, blockData, isCostRoll, isMoveEvent)
    return {
        MapId = mapData.ID,
        BlockId = blockData.ID,
        EventId = JYCSConst.EmptyIconEventID,
        EventTyp = JYCSConst.MapEventType.Empty,
        Param = 0,
        NeedStep = JYCSData.GetEventNeedStep(isCostRoll, isMoveEvent)
    }
end

JYCSData.GetEventDungeonID = function(eventData)
    local eventParams = eventData ~= nil and eventData.OptionsParame or nil
    return type(eventParams) == "table" and eventParams[1] or nil
end

JYCSData.BuildBattleExtraParams = function(blockID, eventType, isCostRoll, eventID, isMoveEvent, needStep)
    return {
        JYCSConst.DungeonBuffName,
        blockID,
        tostring(eventType),
        tostring(JYCSData.GetEventNeedStep(isCostRoll, isMoveEvent, needStep)),
        eventID
    }
end

JYCSData.GetBattleReturnReportEventType = function(blockID, eventType)
    local serverData = this.GetServerData()
    local blockStatus = serverData.BlockStatus or {}
    local sourceEventType = tonumber(eventType) or eventType
    if blockStatus[blockID] ~= nil and eventType ~= JYCSConst.MapEventType.RunFight then
        return JYCSConst.MapEventType.Empty
    end
    return sourceEventType
end

JYCSData.BuildBattleFailEventRequest = function(mapData, battleData)
    local extraParams = battleData.extraParams
    local blockID = extraParams[2]
    local eventType = tonumber(extraParams[3])
    return {
        MapId = mapData.ID,
        BlockId = blockID,
        EventId = extraParams[5],
        EventTyp = JYCSData.GetBattleReturnReportEventType(blockID, eventType),
        Param = tonumber(battleData.dungeonId) or 0,
        NeedStep = tonumber(extraParams[4]) or JYCSConst.EventNeedStep.NormalRoll
    }
end

JYCSData.ApplyStepResponse = function(response)
    local blockID = response.BlockId
    if blockID == nil or blockID == 0 then
        return JYCSData.GetCurBlock()
    end
    JYCSData.UpdateCurBlock(blockID)
    return blockID
end

JYCSData.GetAllFinishEvent = function()
    local serverData = this.GetServerData()
    local blockStatus = serverData.BlockStatus or {}
    local eventDic = {}
    for key, value in pairs(blockStatus) do
        eventDic[key] = true
    end
    return eventDic
end

JYCSData.GetScore = function()
    local serverData = this.GetServerData()
    return serverData.Score or 0, serverData.ScoreCount or 0
end

JYCSData.GetDungeonBuffID = function()
    local curDanger = JYCSData.GetDangerValue()
    local dangerStage = ConfigMgr.Config.JYCSConstants.JYCSDangerStage
    local dangerStageBuff = ConfigMgr.Config.JYCSConstants.JYCSDangerStageBuff
    local buffConfigID = nil
    for i = 1, #dangerStage do
        local stage = dangerStage[i]
        local minValue = stage[1] or 0
        local maxValue = stage[2] or 0
        if curDanger >= minValue and curDanger <= maxValue then
            buffConfigID = dangerStageBuff[i]
            break
        end
    end
    if curDanger > 0 and buffConfigID == nil then
        buffConfigID = dangerStageBuff[#dangerStageBuff]
    elseif curDanger < 0 and buffConfigID == nil then
        buffConfigID = dangerStageBuff[1]
    end
    return buffConfigID
end

JYCSData.GetBuffIDStr = function()
    return JYCSData.GetDungeonBuffID()
end

this.GetServerData = function()
    local data = DataMgr.Player.JYCSGame
    if type(data) ~= "table" then
        data = {}
    end
    return data
end




JYCSData.CheckRedPoint = function()
    if not JYCSData.CheckActivityRunning(true) then
        return 0
    end
    local activityData = DataExHelper.GetDataExByTag(ActivityKey.JYCS)
    if activityData == nil then
        return 0
    end
    local rewardRed, taskRed = HeroRedDataHelper.GetPassesRed()
    local redNum1 = rewardRed + taskRed
    RedMgr.Singleton:UpdateClientRedData(JYCSConst.RedPoint.Pass, redNum1)

    local redNum2 = JYCSData.CheckNovelPoint()
    RedMgr.Singleton:UpdateClientRedData(JYCSConst.RedPoint.Novel, redNum2)

    local redNum3_1 = JYCSData.GetDungeonRedPoint(JYCSConst.EventType.Repeat)
    local redNum3_2 = JYCSData.GetDungeonRedPoint(JYCSConst.EventType.Hard)
    local redNum3_3 = JYCSData.GetDungeonRedPoint(JYCSConst.EventType.MainLine)
    local redNum3 = redNum3_1 + redNum3_2 + redNum3_3
    RedMgr.Singleton:UpdateClientRedData(JYCSConst.RedPoint.Dungeon, redNum3)

    local _, _, canGetCount = JYCSData.GetQuestEventDatas(JYCSConst.TaskEventIDName)
    local redNum4 = canGetCount
    RedMgr.Singleton:UpdateClientRedData(JYCSConst.RedPoint.Task, redNum4)
    return redNum1 + redNum2 + redNum3 + redNum4
end


JYCSData.GetDungeonRedPoint = function(dungeonType)
    local prefix = nil
    if dungeonType == JYCSConst.EventType.Repeat then
        prefix = JYCSConst.RedPoint.Repeat
    elseif dungeonType == JYCSConst.EventType.Hard then
        prefix = JYCSConst.RedPoint.HardDungeon
    elseif dungeonType == JYCSConst.EventType.MainLine then
        prefix = JYCSConst.RedPoint.MainLineDungeon
    end
    if prefix == nil then
        return 0
    end
    local _, firstUnlockData = JYCSData.GetDungeonDatas(dungeonType)
    if firstUnlockData == nil then
        return 0
    end
    local redID = string.format("%s_%s", prefix, firstUnlockData.id)
    if RedMgr.Singleton:CheckRedCondition(redID) == true then
        return 1
    end
    return 0
end

JYCSData.CheckNovelPoint = function()
    local _, newNovelData = JYCSData.GetAllNovelDatas()
    if newNovelData == nil then
        return 0
    end
    local redID = string.format("%s_%s", JYCSConst.RedPoint.Novel, newNovelData.eventParam)
    if RedMgr.Singleton:CheckRedCondition(redID) == true then
        return 1
    end
    return 0
end

