




require("Match3Game/Data/GridPosition")
require("ViewModel/ZhiXiangLiu/Data/ZXLConst")
require("ViewModel/ZhiXiangLiu/Data/ZXLGameData")
ZXLData = {}

local this = {
    eventDic = {},
    glassDatas = {},
    materialDic = {},
    materialDatas = {},
    tempChoosedMatDic = {},
    choosedMatDic = {},
    questEventConfig = {}
}

ZXLData.Init = function()
    ZXLGameData.InitData()
    ZXLData.InitData()
end

ZXLData.InitData = function()
    this.glassDatas = {}
    this.materialDatas = {}

    local glassConfigs = ConfigMgr.Config.GlassMergeMap
    local glassConfigLen = NumTool.GetLen(glassConfigs)
    local materialConfigs = ConfigMgr.Config.GlassMaterialMap
    local mapEventGroup = {}
    for key, value in pairs(ZXLConst.EventType) do
        mapEventGroup[value] = DataExHelper.EX_GetEventListByArea(value)
    end
    for i = 1, glassConfigLen do
        local ID = tostring(100 + i)
        local config = glassConfigs[ID]
        local mapConfigs = {}
        local effectLan = nil
        local existEffect = false
        local effectID = nil
        if type(config.Effect) == "table" and #config.Effect > 0 then
            effectID = config.Effect[1]
            if ConfigMgr.Config.buffMap ~= nil then
                local effectConfig = ConfigMgr.Config.buffMap[effectID]
                effectLan = effectConfig.DescriptionLan
                existEffect = true
            end
        end
        for i = 1, #config.Material do
            local matID = config.Material[i]
            local matConfig = materialConfigs[matID]
            table.insert(mapConfigs, #mapConfigs + 1, matConfig)
        end
        if config.Type == 1 then
            local allEventConfigs = mapEventGroup[config.Area]
            for j = 1, #allEventConfigs do
                local eventConfig = allEventConfigs[j]
                local data = {}
                data.ID = ID
                data.config = config
                data.matConfigs = mapConfigs
                data.status = CommonRewardItem.Status.None
                data.isUnlock = false
                data.eventConfig = eventConfig
                data.name = LuaMgr.GetLangText(eventConfig.namelan)
                data.desc = LuaMgr.GetLangText(config.DescLan)
                data.effectTxt = effectLan ~= nil and LuaMgr.GetLangText(effectLan) or nil
                data.existEffect = existEffect
                data.effectID = effectID
                data.eventIndex = j
                data.canJoin = false
                data.unlockText = ""
                table.insert(this.glassDatas, #this.glassDatas + 1, data)
                this.eventDic[eventConfig.id] = data
            end
        else
            local data = {}
            data.ID = ID
            data.config = config
            data.matConfigs = mapConfigs
            data.status = CommonRewardItem.Status.None
            data.isUnlock = false
data.canJoin = true
            data.effectTxt = effectLan ~= nil and LuaMgr.GetLangText(effectLan) or nil
            data.existEffect = existEffect
            data.effectID = effectID
            data.name = LuaMgr.GetLangText(config.NameLan)
            data.desc = LuaMgr.GetLangText(config.DescLan)
            table.insert(this.glassDatas, #this.glassDatas + 1, data)
        end
    end


    local matConfigLen = NumTool.GetLen(materialConfigs)
    for i = 1, matConfigLen do
        local ID = tostring(1000 + i)
        local config = materialConfigs[ID]
        local data = {}
        data.config = config
        data.ID = ID
        data.unlock = false
        data.unlockTime = 0
        this.materialDic[ID] = data
        table.insert(this.materialDatas, #this.materialDatas + 1, data)
    end
end

ZXLData.CheckActivityRunning = function(isStatic)
    if not DataExHelper.CommonActivityCheck(ActivityKey.ZXL) then
        if not isStatic then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
        end
        return false
    end
    return true
end

ZXLData.GetRemainTimeStr = function()
    local activityData = DataExHelper.GetDataExByTag(ActivityKey.ZXL)
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

ZXLData.GetAllGlassDatas = function(noRepeat)
    local allDataDic = {}
    local allDatas = {}
    local glassNumberDic = {}
    local allActivateBuff = {}
    this.glassEventCompleteDic = {}
    for i = 1, #this.glassDatas do
        local data = this.glassDatas[i]
        local config = data.config
        data.status = CommonRewardItem.Status.None
        data.isUnlock = false
        data.canJoin = false
        data.Index = i
        if config.Type == 1 then
            local eventConfig = data.eventConfig
            local isFinish = ZXLData.CheckFinish(eventConfig)
            glassNumberDic[config.Area] = (glassNumberDic[config.Area] or 0) + 1
            data.glassNumber = glassNumberDic[config.Area]
            if config.Area == ZXLConst.EventType.Novel then
                local reward, isWatch = ZXLData.GetNovelReward(eventConfig)
                data.reward = reward
                data.status = isWatch == true and CommonRewardItem.Status.Got or CommonRewardItem.Status.None
            elseif config.Area == ZXLConst.EventType.Play then
                data.reward = ZXLData.GetGameReward(eventConfig)
                data.status = isFinish == true and CommonRewardItem.Status.Got or CommonRewardItem.Status.None
                local serverData = ZXLData.GetMiniGameData(eventConfig.eventParam)
                data.scoreLevel = serverData or 0
            else
                local reward, raring = ZXLData.GetPassReward(eventConfig)
                data.reward = reward
                data.scoreLevel = raring > 0 and 3 - raring + 1 or 0
                data.status = isFinish == true and CommonRewardItem.Status.Got or CommonRewardItem.Status.None
            end
            if data.status == CommonRewardItem.Status.Got then
                this.glassEventCompleteDic[config.Area] = (this.glassEventCompleteDic[config.Area] or 0) + 1
            end
            data.eventType = config.Area
            local glassMergeData = DataMgr.Player.GlassMerge
            if type(glassMergeData) == "table" and type(glassMergeData.GlassMap) == "table" and glassMergeData.GlassMap[data.ID] then
                data.isUnlock = true
            end
            if data.eventConfig.unlockType == 0 then
                data.canJoin = true
            elseif data.eventConfig.unlockType == 1 then
                local unlockCondData = this.eventDic[data.eventConfig.unlockParam]
                if unlockCondData then
                    local unlockConfig = unlockCondData.eventConfig
                    data.canJoin = ZXLData.CheckFinish(unlockConfig)
                    local name = LuaMgr.GetLangText(unlockConfig.namelan)
                    local lan = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_10001")
                    if config.Area == ZXLConst.EventType.Novel then
                        lan = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_15006")
                    end
                    data.unlockText = string.format(lan, name)
                end
            end
        else
            data.canJoin = true
            local glassMergeData = DataMgr.Player.GlassMerge
            if type(glassMergeData) == "table" and type(glassMergeData.GlassMap) == "table" and glassMergeData.GlassMap[data.ID] then
                data.isUnlock = true
            end
            data.status = data.isUnlock == true and CommonRewardItem.Status.Got or CommonRewardItem.Status.None
            data.reward = ZXLData.GetEggGlassReward(config.Reward, data.status)
            local key = "NULLType" .. data.ID
            glassNumberDic[key] = (glassNumberDic[key] or 0) + 1
            data.glassNumber = glassNumberDic[key]
            if data.status == CommonRewardItem.Status.Got then
                this.glassEventCompleteDic[key] = (this.glassEventCompleteDic[key] or 0) + 1
            end
        end
        if noRepeat == true and allDataDic[data.ID] == nil then
            allDataDic[data.ID] = data
            table.insert(allDatas, data)
        end
        if data.existEffect and data.status == CommonRewardItem.Status.Got then
            table.insert(allActivateBuff, data.effectID)
        end
    end
    if noRepeat == true then
        allDataDic = {}
        return allDatas
    end
    return this.glassDatas, allActivateBuff
end

ZXLData.SeriesEventComplete = function(area)
    return this.glassEventCompleteDic[area] ~= nil
end

ZXLData.SortGlassData = function(data1, data2)
    if data1.config.Area == data2.config.Area then
        return data1.glassNumber < data2.glassNumber
    end
    local id1 = tonumber(data1.ID) or 0
    local id2 = tonumber(data2.ID) or 0
    return id1 < id2
end

ZXLData.GetAllGlassMatDatas = function()
    for key, data in pairs(this.materialDatas) do
        if data.config.Type == 0 then
            data.unlock = true
        elseif data.config.Type == 1 then
            local activityData = DataExHelper.GetDataExByTag(ActivityKey.ZXL)
            data.unlockTime = activityData.startTime + data.config.Unlock * 86400
            local curTime = LuaMgr.Timestamp()
            if curTime >= data.unlockTime then
                data.unlock = true
            end
        end
    end
    return this.materialDatas
end

ZXLData.SetTempChoosedMatData = function(id, data)
    this.tempChoosedMatDic[id] = data
end

ZXLData.ClearTempChoosedMatData = function()
    for key, value in pairs(this.tempChoosedMatDic) do
        this.choosedMatDic[key] = value
    end
    this.tempChoosedMatDic = {}
end

ZXLData.GetTempChoosedMatDatas = function()
    for key, value in pairs(this.tempChoosedMatDic) do
        this.tempChoosedMatDic[key] = value
    end
    this.choosedMatDic = {}
    return this.tempChoosedMatDic
end

ZXLData.GetGlassMatDataByID = function(id)
    return this.materialDic[tostring(id)]
end

ZXLData.GetGlassGoalByMat = function(matDataDic)
    local datas = ZXLData.GetAllGlassDatas()
    for i = 1, #datas do
        local data = datas[i]
        local matIDs = data.config.Material
        local isAllFullCond = true
        for _, matID in pairs(matIDs) do
            if matDataDic[matID] == nil then
                isAllFullCond = false
                break
            end
        end
        if isAllFullCond == true then
            return data
        end
    end
    return nil
end


ZXLData.GetShopDatas = function()
    if ZXLData.QuestCelebrationRecharge == nil then
        ZXLData.QuestCelebrationRecharge = DataExHelper.Check_ConfigQuestEventByText(ZXLConst.QuestCelebrationRecharge)
    end
    local quests = DataMgr.Player.quests
    local len = #ZXLData.QuestCelebrationRecharge
    local allDatas = {}
    local totalProgress = 0
    local canGetCount = 0
    for i = 1, len do
        local questConfig = ZXLData.QuestCelebrationRecharge[i]
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

function ZXLData.GetNovelReward(config)
    local rewardConfig = ConfigHelper.GetNovelRewardByEventID(config.eventParam)
    local rewardMap = {}
    for _, value in pairs(rewardConfig) do
        rewardMap[value.id] = (rewardMap[value.id] or 0) + value.count
    end
    local allDatas = {}
    local isWatch = DataHelper.CheckNovelComplete(config.eventParam)
    for id, count in pairs(rewardMap) do
        local itemConfig = ConfigMgr.Config.itemMap[id]
        if (itemConfig == nil) then
            return allDatas, isWatch
        end
        local tempData = {}
        tempData.id = id
        tempData.count = count
        tempData.status = isWatch == true and CommonRewardItem.Status.Got or CommonRewardItem.Status.None
        tempData.scale = 0.6
        table.insert(allDatas, tempData)
    end
    return allDatas, isWatch
end

function ZXLData.GetPassReward(config)
    local dungeon = ConfigMgr.Config.dungeonMap[config.eventParam]
    local rewardMap = {}
    local allDatas = {}
    if IsNull(dungeon) then
        return allDatas
    end
    local dropShowStr = dungeon.firstDropShow
    if config.area == ZXLConst.EventType.Repeat then
        local isFinish = ZXLData.CheckFinish(config)
        if isFinish == true then
            dropShowStr = dungeon.fixedDropShow
        end
        if dropShowStr == nil or dropShowStr == "" then
            dropShowStr = dungeon.firstDropShow
        end
    end
    local tempList = NumTool.split(dropShowStr, ";")
    if tempList then
        for i = 1, #tempList do
            rewardMap[tempList[i]] = 0
        end
    end
    local raring = DataExHelper.GetDungeonDecordRating(config.eventParam)
    for id, v in pairs(rewardMap) do
        local itemConfig = ConfigMgr.Config.itemMap[id]
        if (itemConfig == nil) then
            return allDatas
        end
        local tempData = {}
        tempData.id = id
        tempData.count = v
        tempData.status = raring > 0 and CommonRewardItem.Status.Got or CommonRewardItem.Status.None
        tempData.scale = 0.6
        table.insert(allDatas, tempData)
    end
    return allDatas, raring
end

function ZXLData.GetGameReward(config)
    local passConfig = ZXLGameData.GetPassConfigByID(config.eventParam)
    local isFinish = ZXLData.CheckFinish(config)
    local rewardMap = passConfig.Reward
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

function ZXLData.GetEggGlassReward(rewardMap, status)
    local allDatas = {}
    for key, item in pairs(rewardMap) do
        local itemConfig = ConfigMgr.Config.itemMap[item.id]
        if (itemConfig == nil) then
            return
        end
        local tempData = {}
        tempData.id = item.id
        tempData.count = item.count
        tempData.status = status
        tempData.scale = 0.6
        table.insert(allDatas, tempData)
    end
    return allDatas
end

ZXLData.CheckFinish = function(config)
    local isFinish = false
    if config.type == ZXLConst.PassNumType.Fushua or config.type == ZXLConst.PassNumType.MainLine or config.type == ZXLConst.PassNumType.Hard then
        local record = DataMgr.Player.dungeonRecords[config.eventParam]
        if (record ~= nil and record.completeCount > 0) then
            isFinish = true
        end
    elseif config.type == ZXLConst.PassNumType.Novel then
        isFinish = DataHelper.CheckNovelComplete(config.eventParam)
    else
        local rewardData = ZXLData.GetMiniGameData(config.eventParam)
        if rewardData ~= nil and rewardData > 0 then
            isFinish = true
        end
    end
    return isFinish
end

ZXLData.CheckUnlock = function(config, configDic)
    if config.unlockParam == nil or config.unlockParam == "" then
        return true
    end
    local isUnlock = false
    if config.type == ZXLConst.PassNumType.Fushua or config.type == ZXLConst.PassNumType.MainLine or config.type == ZXLConst.PassNumType.Hard then
        if configDic == nil then
            configDic = DataExHelper.GetActivityMapEventMap()
        end
        local unlockConfig = configDic[config.unlockParam]
        isUnlock = DataHelper.CheckDungeonComplete(unlockConfig.eventParam)
    elseif config.type == ZXLConst.PassNumType.Novel then
        isUnlock = DataHelper.CheckNovelComplete(config.unlockParam)
    else
        isUnlock = ZXLGameData.CheckPassIsUnlock(config.eventParam)
    end
    return isUnlock
end

ZXLData.GetMiniGameData = function(passID)
    local serverData = DataMgr.Player.PuzzleGame.PuzzleMap
    return serverData[passID] or nil
end

ZXLData.IsFirstCombine = function(glassID)
    local glassMergeData = DataMgr.Player.GlassMerge.GlassMap[glassID]
    if glassMergeData == nil or glassMergeData <= 1 then
        return true
    end
    return false
end

ZXLData.GetAllTaskData = function()
    if this.questEventConfig == nil or #this.questEventConfig == 0 then
        local activityText = "ZXLEvent"
        this.questEventConfig = DataExHelper.Check_ConfigQuestEventByText(activityText)
    end
    local quests = DataMgr.Player.quests
    local len = #this.questEventConfig
    local allDatas = {}
    local existCangetReward = false
    for i = 1, len do
        local questConfig = this.questEventConfig[i]
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


ZXLData.SetBookLastSelected = function(id)
    this.bookLastSelectedID = id
end

ZXLData.GetBookLastSelected = function()
    return this.bookLastSelectedID
end

ZXLData.SetLastUserID = function()
    this.lastUserID = DataMgr.Player.uid
end

ZXLData.CheckIsSwitchUser = function()
    return this.lastUserID ~= DataMgr.Player.uid
end


ZXLData.CheckRed = function()
    local _, existCanget = ZXLData.GetAllTaskData()
    local redNum1 = existCanget == true and 1 or 0
    RedMgr.Singleton:UpdateClientRedData(ZXLConst.RedPoint.Reward, redNum1)

    local rewardRed, taskRed = HeroRedDataHelper.GetPassesRed()
    local redNum2 = rewardRed + taskRed
    RedMgr.Singleton:UpdateClientRedData(ZXLConst.RedPoint.Pass, redNum2)

    local redNum3 = ZXLData.CheckExistNoCompleteDelegate()
    return redNum1 + redNum2 + redNum3
end

ZXLData.CheckExistNoCompleteDelegate = function()
    local allGlassDatas = ZXLData.GetAllGlassDatas()
    local redNum = 0
    local existNocompletePlay = false
    for key, value in pairs(allGlassDatas) do
        if value.isUnlock == true and value.canJoin == true then
            existNocompletePlay = true
            break
        end
    end
    local noCompleted = RedMgr.Singleton:CheckRedCondition(ZXLConst.RedPoint.AllPlay)
    if existNocompletePlay == true and noCompleted == true then
        redNum = 1
    end

    RedMgr.Singleton:UpdateClientRedData(ZXLConst.RedPoint.AllPlay, redNum)
    return redNum
end

