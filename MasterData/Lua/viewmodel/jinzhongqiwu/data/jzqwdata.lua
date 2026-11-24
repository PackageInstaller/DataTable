



require("ViewModel/JinZhongQiWu/Data/JZQWConst")
require("ViewModel/JinZhongQiWu/Data/JZQWGameData")

JZQWData = {}

local this = {
    gameNpcDatas = {},
    npcDataCount = 0
}

JZQWData.InitData = function()
    JZQWGameData.InitData()
    JZQWData.InitConfig()
end

JZQWData.InitConfig = function()
    this.gameNpcDatas = {}
    this.npcDataCount = 0

    this.mapEventGroup = {}
    for key, value in pairs(JZQWConst.EventType) do
        this.mapEventGroup[value] = DataExHelper.EX_GetEventListByArea(value)
    end

    local chapterConfigs = ConfigMgr.Config.AdventureChapterMap
    local tempDic = {}
    for id, config in pairs(chapterConfigs) do
        local data = {}
        data.NpcID = config.NpcId
        data.ChapterID = id
        if tempDic[data.NpcID] == nil then
            tempDic[data.NpcID] = {}
        end
        this.npcDataCount = this.npcDataCount + 1
        table.insert(this.gameNpcDatas, data)
    end
end

JZQWData.CheckActivityRunning = function(isStatic)
    if this.lastPlayerUID ~= DataMgr.Player.uid then
        JZQWData.InitData()
        this.lastPlayerUID = DataMgr.Player.uid
    end
    if not DataExHelper.CommonActivityCheck(ActivityKey.JZQW) then
        if not isStatic then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
        end
        return false
    end
    return true
end

JZQWData.GetRemainTimeStr = function()
    local activityData = DataExHelper.GetDataExByTag(ActivityKey.JZQW)
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




JZQWData.GetShopDatas = function()
    if this.QuestCelebrationRecharge == nil then
        this.QuestCelebrationRecharge = DataExHelper.Check_ConfigQuestEventByText(JZQWConst.ShopEventIDName)
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

JZQWData.GetAllNovelDatas = function()
    if JZQWData.CheckActivityRunning(true) == false then
        return {}, {}
    end
    if this.NovelConfigs == nil then
        this.NovelConfigs = DataExHelper.EX_GetEventListByArea(JZQWConst.EventType.Novel)
    end
    local finishDatas = {}
    local allDatas = {}
    local firstUnlockData = nil
    for i = 1, #this.NovelConfigs do
        local data = this.NovelConfigs[i]
        data.Index = i
        data.IsFirst = i == 1
        data.IsLast = i == #this.NovelConfigs
        if JZQWData.CheckFinish(data) == true then
            data.Status = CommonRewardItem.Status.Got
        else
            local isUnlock, unlockDesc = JZQWData.CheckUnlock(data)
            if isUnlock == true then
                data.Status = CommonRewardItem.Status.None
            else
                data.Status = CommonRewardItem.Status.Lock
                data.UnlockDesc = unlockDesc
            end
        end
        data.Name = LuaMgr.GetLangText(data.namelan)
        data.EventType = JZQWConst.EventType.Novel
        if data.Status == CommonRewardItem.Status.Got then
            table.insert(finishDatas, data)
        elseif data.Status == CommonRewardItem.Status.None and firstUnlockData == nil then
            firstUnlockData = data
        end
        table.insert(allDatas, data)
    end
    return finishDatas, allDatas, firstUnlockData
end



JZQWData.GetDungeonDatas = function(dungeonType)
    if JZQWData.CheckActivityRunning(true) == false then
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
        data.Name = LuaMgr.GetLangText(configs[i].namelan)
        if JZQWData.CheckFinish(data) == true then
            data.Status = CommonRewardItem.Status.Got
        else
            local isUnlock, unlockDesc = JZQWData.CheckUnlock(data)
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
    return finishDatas, allDatas, firstUnlockData
end

JZQWData.CheckFinish = function(config)
    local isFinish = false
    if config.type == JZQWConst.PassNumType.Repeat or config.type == JZQWConst.PassNumType.MainLine or config.type == JZQWConst.PassNumType.Hard then
        local record = DataMgr.Player.dungeonRecords[config.eventParam]
        if record ~= nil and record.completeCount > 0 then
            isFinish = true
        end
    elseif config.type == JZQWConst.PassNumType.Novel then
        isFinish = DataHelper.CheckNovelComplete(config.eventParam)
    else
        local rewardData = JZQWData.GetMiniGameData(config.eventParam)
        if rewardData ~= nil and rewardData > 0 then
            isFinish = true
        end
    end
    return isFinish
end

JZQWData.CheckUnlock = function(config)
    if config.unlockParam == nil or config.unlockParam == "" then
        return true
    end
    if this.mapEventConfigDic == nil then
        this.mapEventConfigDic = DataExHelper.GetActivityMapEventMap()
    end
    local isUnlock = false
    local unlockText = ""
    if config.type == JZQWConst.PassNumType.Repeat or config.type == JZQWConst.PassNumType.MainLine or config.type == JZQWConst.PassNumType.Hard then
        local unlockConfig = this.mapEventConfigDic[config.unlockParam]
        isUnlock = DataHelper.CheckDungeonComplete(unlockConfig.eventParam)
        if isUnlock == false then
            local unlockConfig = this.mapEventConfigDic[config.unlockParam]
            local lanText = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30036")
            local name = LuaMgr.GetLangText(unlockConfig.namelan)
            unlockText = string.format(lanText, name)
        end
    elseif config.type == JZQWConst.PassNumType.Novel then
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

JZQWData.GetAllQuestDatas = function()
    if this.taskQuestEvents == nil then
        local allConfigs = DataExHelper.Check_ConfigQuestEventByText(JZQWConst.QuestEventID)
        this.taskQuestEvents = allConfigs
    end
    return this.taskQuestEvents
end

JZQWData.GetQuestDataByIndex = function(index)
    local allQuestEvents = JZQWData.GetAllQuestDatas()
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




JZQWData.GetRecollectionCount = function(type)
    if type == JZQWConst.PageType.Dungeon then
        local count1 = #this.mapEventGroup[JZQWConst.EventType.Repeat]
        local count2 = #this.mapEventGroup[JZQWConst.EventType.Hard]
        local count3 = #this.mapEventGroup[JZQWConst.EventType.MainLine]
        return count1 + count2 + count3
    elseif type == JZQWConst.PageType.Novel then
        return #this.mapEventGroup[JZQWConst.EventType.Novel]
    end
    return this.npcDataCount
end

JZQWData.GetOwnerNpcDatas = function()
    local tempDataDic = {}
    local datas = {}
    local serverData = DataMgr.Player.Adventure.Chapters or {}
    for i = 1, #this.gameNpcDatas do
        local tempData = this.gameNpcDatas[i]
        local chapterID = tempData.ChapterID
        local npcID = tempData.NpcID
        if serverData[chapterID] ~= nil then
            if tempDataDic[npcID] == nil then
                tempDataDic[npcID] = {}
            end
            table.insert(tempDataDic[npcID], chapterID)
        end
    end
    for key, value in pairs(tempDataDic) do
        local npcConfig = ConfigMgr.Config.AdventureObjectsMap[key]
        local data = {}
        data.NpcID = key
        data.Name = LuaMgr.GetLangText(npcConfig.NameLan)
        data.Icon = string.format("%s_main", npcConfig.Asset[1])
        data.DescList = {}
        for i = 1, #value do
            local chapterID = value[i]
            local chapterConfig = ConfigMgr.Config.AdventureChapterMap[chapterID]
            table.insert(data.DescList, LuaMgr.GetLangText(chapterConfig.NpcDescLan))
        end
        table.insert(datas, data)
    end
    return datas, this.npcDataCount
end

JZQWData.SetIsChildPanel = function(isChild)
    this.isChildPanel = isChild
end

JZQWData.GetIsChildPanel = function()
    return this.isChildPanel
end

JZQWData.SetHomeSelectPageType = function(pageType)
    this.homeSelectPageType = pageType
end

JZQWData.GetHomeSelectPageType = function()
    return this.homeSelectPageType
end

JZQWData.Clear = function()
end



JZQWData.CheckRedPoint = function()
    if not JZQWData.CheckActivityRunning(true) then
        return 0
    end
    local activityData = DataExHelper.GetDataExByTag(ActivityKey.JZQW)
    if activityData == nil then
        return 0
    end
    local rewardRed, taskRed = HeroRedDataHelper.GetPassesRed()
    local redNum2 = rewardRed + taskRed
    RedMgr.Singleton:UpdateClientRedData(JZQWConst.RedPoint.Pass, redNum2)

    local redNum3 = JZQWData.CheckHomeRedPoint()

    return redNum2 + redNum3
end

JZQWData.CheckHomeRedPoint = function()
    local _, _, firstUnlockData = JZQWData.GetDungeonDatas(JZQWConst.EventType.Repeat)
    local redNum3 = 0
    if firstUnlockData ~= nil then
        local redId = string.format("%s_%s", JZQWConst.RedPoint.Repeat, firstUnlockData.eventParam)
        if RedMgr.Singleton:CheckRedCondition(redId) then
            redNum3 = 1
        end
        RedMgr.Singleton:UpdateClientRedData(redId, redNum3)
        RedMgr.Singleton:UpdateClientRedData(JZQWConst.RedPoint.Repeat, redNum3)
    end

    local _, _, firstUnlockData = JZQWData.GetDungeonDatas(JZQWConst.EventType.MainLine)
    local redNum4 = 0
    if firstUnlockData ~= nil then
        local redId = string.format("%s_%s", JZQWConst.RedPoint.MainLineDungeon, firstUnlockData.eventParam)
        if RedMgr.Singleton:CheckRedCondition(redId) then
            redNum4 = 1
        end
        RedMgr.Singleton:UpdateClientRedData(redId, redNum4)
        RedMgr.Singleton:UpdateClientRedData(JZQWConst.RedPoint.MainLineDungeon, redNum4)
    end

    local _, _, firstUnlockData = JZQWData.GetDungeonDatas(JZQWConst.EventType.Hard)
    local redNum5 = 0
    if firstUnlockData ~= nil then
        local redId = string.format("%s_%s", JZQWConst.RedPoint.HardDungeon, firstUnlockData.eventParam)
        if RedMgr.Singleton:CheckRedCondition(redId) then
            redNum5 = 1
        end
        RedMgr.Singleton:UpdateClientRedData(redId, redNum5)
        RedMgr.Singleton:UpdateClientRedData(JZQWConst.RedPoint.HardDungeon, redNum5)
    end
    RedMgr.Singleton:UpdateClientRedData(JZQWConst.RedPoint.Dungeon, redNum3 + redNum4 + redNum5)

    local _, _, firstUnlockData = JZQWData.GetAllNovelDatas()
    local redNum6 = 0
    if firstUnlockData ~= nil then
        local redId = string.format("%s_%s", JZQWConst.RedPoint.Novel, firstUnlockData.eventParam)
        if RedMgr.Singleton:CheckRedCondition(redId) then
            redNum6 = 1
        end
        RedMgr.Singleton:UpdateClientRedData(redId, redNum6)
        RedMgr.Singleton:UpdateClientRedData(JZQWConst.RedPoint.Novel, redNum6)
    else
        RedMgr.Singleton:FrushRedCondition(JZQWConst.RedPoint.Novel)
        RedMgr.Singleton:SetRedState(JZQWConst.RedPoint.Novel, redNum6)
        RedMgr.Singleton:UpdateClientRedData(JZQWConst.RedPoint.Novel, redNum6)
    end

    local allSceneData = JZQWGameData.GetAllSceneDatas()
    local redNum7 = 0
    local redId = nil
    for i = 1, #allSceneData do
        local sceneData = allSceneData[i]
        local tempRedId = string.format("%s_%s", JZQWConst.RedPoint.Game, sceneData.Config.Id)
        local data = sceneData
        data.OnClickIntroBtn = this.OnClickIntroBtn
        data.Name = LuaMgr.GetLangText(sceneData.Config.NameLan)
        if data.Status == JZQWConst.SceneStatus.UnlockShow then
            if data.CanIntro == true and RedMgr.Singleton:CheckRedCondition(tempRedId) then
                redNum7 = 1
                redId = tempRedId
                break
            end
        end
    end

    if redId ~= nil then
        RedMgr.Singleton:UpdateClientRedData(redId, redNum7)
    end

    local redNum8 = JZQWData.CheckTaskRedPoint()
    RedMgr.Singleton:UpdateClientRedData(JZQWConst.RedPoint.Task, redNum8)
    RedMgr.Singleton:UpdateClientRedData(JZQWConst.RedPoint.Game, redNum7 + redNum8)
    LuaDebug.error("402===================" .. redNum3 .. "===" .. redNum4 .. "===" .. redNum5 .. "===" .. redNum6 .. "===" .. redNum7)
    return redNum3 + redNum4 + redNum5 + redNum6 + redNum7 + redNum8
end

JZQWData.CheckTaskRedPoint = function()
    local allQuestEvents = JZQWData.GetAllQuestDatas()
    for i = 1, #allQuestEvents do
        local data = JZQWData.GetQuestDataByIndex(i)
        if data.Status == CommonRewardItem.Status.CanGet then
            return 1
        end
    end
    return 0
end

