







DispatchData = {}

DispatchData.MaxHeroCount = 6

DispatchData.StrongholdStatus = {
Lock = 0,
DispatchWait = 1,
Dispatching = 2,
DispatchEnd = 3
}


DispatchData.StatusChangeType = {
DispatchSucc = 0,
GetRewardSucc = 1,
CallbackSucc = 2
}

DispatchData.GetRewardStatus = {
CanGet = 1,
None = 2,
Got = 3
}

DispatchData.DispatchCondType = {
Count = "1",
Rare = "2",
Hero = "3",
Job = "4"
}

local this = {
strongHoldDataDic = {},
strongHoldDataIDDic = {},
    strongHoldDataList = {},
dispatchedHeroDic = {},
reputationDic = {},
    autoDispatchHeroDatas = {},
RandomAwardData = {},
    dispatchStoryDataDic = nil,
randomRewardAM = "AM",
randomRewardPM = "PM"
}

DispatchData.Init = function()

    this.PlayerArchivesKey = DataMgr.Player.uid .. "STRONG_HOLD_DATA"

    this.RandomAwardArchivesKey = DataMgr.Player.uid .. "DISPATCH_RANDOM_AWARD"
    DispatchData.InitArchives()

    this.strongHoldDataDic = {}
    this.strongHoldDataIDDic = {}
    this.strongHoldDataList = {}
    this.reputationDic = {}
    local dispatchConfigs = ConfigMgr.Config.DispatchRegularMap
    for _, config in pairs(dispatchConfigs) do
        local key = config.Group
        if this.strongHoldDataDic[key] == nil then
            this.strongHoldDataDic[key] = {}
        end
        local data = this.strongHoldDataDic[key]
        data.id = config.ID
        data.index = config.ID
        data.config = config
        data.isUnlock = false
        data.status = DispatchData.StrongholdStatus.Lock
        data.unlockText = ""
data.startTime = 0
data.endTime = 0
data.curTaskID = 0
data.heroDic = {}
        data.heroCount = 0
data.taskConfigDic = {}
        data.taskConfigs = {}
        data.rewardDatas = {}
        data.curTaskConfig = nil
        data.timeOptionIndex = 0
        this.strongHoldDataIDDic[config.ID] = data
        table.insert(this.strongHoldDataList, data)
    end
    local taskConfigs = ConfigMgr.Config.DispatchRegularTaskMap
    for _, config in pairs(taskConfigs) do
        local data = this.strongHoldDataDic[config.Group]
        if data ~= nil then
            table.insert(data.taskConfigs, config)
            data.taskConfigDic[config.ID] = config
        else
            LuaDebug.error("DispatchTask is error as field group")
        end
    end

    local reputationConfigs = ConfigMgr.Config.DispatchLevelMap
    for key, config in pairs(reputationConfigs) do
        local data = {}
        data.config = config
        data.isUnlock = false
        data.unlockReputation = 0
        local lastConfig = reputationConfigs[tostring(config.Level - 1)]
        if lastConfig ~= nil then
            data.unlockReputation = lastConfig.Reputation
        end
        this.reputationDic[config.Level] = data
    end
end

DispatchData.GetAllDatas = function(onlyRedPoint)
    for key, value in pairs(this.strongHoldDataDic) do
        DispatchData.RefreshDispatchData(key)
    end
    if onlyRedPoint == nil then
        DispatchData.RefreshDispatchedHero()
        table.sort(this.strongHoldDataList, DispatchData.SortDataFunc)
    end
    return this.strongHoldDataList
end

DispatchData.SortDataFunc = function(data1, data2)
    return data1.id < data2.id
end

DispatchData.SortHeroDataFunc = function(data1, data2)
    return data1.pos < data2.pos
end

DispatchData.RefreshDispatchData = function(groupID)
    local groupIDStr = tostring(groupID)
    local data = this.strongHoldDataDic[groupID]
    local dataID = data.id
    local dataIDStr = tostring(dataID)
    local dispatchData = DataMgr.Player.DispatchRegular
    data.heroCount = 0
    data.heroDic = {}
    data.startTime = 0
    data.endTime = 0
    data.isComplete = false
    data.isGotReward = false
    data.zoneRewardStatus = DispatchData.GetRewardStatus.None
    data.curTaskID = dispatchData.task[groupIDStr]
    data.timeOptionIndex = 0
    data.needTime = 0
    if type(dispatchData.items) == "table" and dispatchData.items[dataIDStr] ~= nil then
        local playerData = dispatchData.items[dataIDStr]
        data.startTime = playerData.start
        if type(playerData.members) == "table" then
            for key, heroID in pairs(playerData.members) do
                DispatchData.SelectHero(data.id, heroID, true, true)
            end
        end
        data.timeOptionIndex = playerData.stage + 1
    else
        local heroArchives = this.ArchivesData.HeroDataDic[tostring(dataID)]
        if heroArchives ~= nil then
            local ownerHero = DataMgr.Player.characters
            for heroID, value in pairs(heroArchives) do
                if type(ownerHero[heroID]) == "table" then
                    DispatchData.SelectHero(dataID, heroID, value.isSelected, false)
                else
                    DispatchData.SelectHero(dataID, heroID, false, false)
                end
            end
        end
    end
    data.curTaskConfig = data.taskConfigDic[data.curTaskID]
    if data.startTime ~= 0 and data.timeOptionIndex ~= nil and data.timeOptionIndex > 0 then
        local optionTime = ConfigMgr.Config.DispatchConstants.DispatchTimeOption[data.timeOptionIndex]
        data.endTime = data.startTime + optionTime
        data.needTime = optionTime
    end
    if dispatchData.level ~= nil then
        data.isUnlock = dispatchData.level >= data.config.UnlockLevel
    else
        LuaDebug.error("DispatchData.RefreshDispatchData Line 181 Error" .. table.tostring(dispatchData))
    end
    if data.isUnlock == false then
        local levelData = DispatchData.GetReputationDataByLevel(data.config.UnlockLevel)
        if levelData ~= nil then
            local needZoneName = LuaMgr.GetLangText(levelData.config.LevelNameLan)
            local content = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_23701")
            data.unlockText = string.format(content, needZoneName)
        end
    end

    if data.endTime == 0 and data.isUnlock == true then
        data.status = DispatchData.StrongholdStatus.DispatchWait
    elseif data.endTime ~= nil and data.endTime ~= 0 then
        data.status = DispatchData.StrongholdStatus.Dispatching
        local curTime = LuaMgr.Timestamp()
        if curTime > data.endTime then
            data.status = DispatchData.StrongholdStatus.DispatchEnd
        end
    end
end

DispatchData.GetDispatchData = function(groupID)
    DispatchData.RefreshDispatchData(groupID)
    local data = this.strongHoldDataDic[groupID]
    return data
end




DispatchData.RefreshRewardData = function(strongholdData, stage)
    local data = this.strongHoldDataDic[strongholdData.config.Group]
    if data == nil or stage < 1 or stage > #data.curTaskConfig.Addition then
        return
    end
    local addition = data.curTaskConfig.Addition[stage]
    local rewardConfigs = data.curTaskConfig.Reward
    local toggleOptionCfg = ConfigMgr.Config.DispatchConstants.DispatchTimeOption
    local dispatchHour = math.floor(toggleOptionCfg[stage] / 3600)
    data.rewardDatas = {}
    for key, value in pairs(rewardConfigs) do
        local tempData = {}
        tempData.id = value.id
        tempData.count = math.floor(value.count * (10000 + addition) / 10000.0) * dispatchHour
        table.insert(data.rewardDatas, tempData)
    end
end


DispatchData.RefreshDispatchedHero = function()
    this.dispatchedHeroDic = {}
    local dispatchData = DataMgr.Player.DispatchRegular
    if type(dispatchData.items) ~= "table" then
        return
    end
    for zoneID, zoneData in pairs(dispatchData.items) do
        for __, heroID in pairs(zoneData.members) do
            this.dispatchedHeroDic[heroID] = {}
            this.dispatchedHeroDic[heroID].zoneID = zoneID
        end
    end
end

DispatchData.CheckCondition = function(heroList, cond, isBase)
    if isBase == true then
        return DispatchData.CheckBaseCondition(heroList, cond)
    else
        return DispatchData.CheckExtraCondition(heroList, cond)
    end
end


DispatchData.CheckBaseCondition = function(heroList, cond)
    if heroList == nil then
        return false
    end
    if cond == nil then
        return true
    end
    local fullBaseCond = true
    if #cond > 1 and cond[1] == DispatchData.DispatchCondType.Count then
        fullBaseCond = #heroList >= tonumber(cond[2])
    elseif #cond > 2 and cond[1] == DispatchData.DispatchCondType.Rare then
        local needRare = tonumber(cond[2])
        local needNum = tonumber(cond[3])
        local curNum = 0
        for key, value in pairs(heroList) do
            local heroConfig = ConfigMgr.Config.characterTable[value.heroID]
            local rare = HeroMgr.GetHeroNowRare(value.heroID)
            if heroConfig and rare >= needRare then
                curNum = curNum + 1
            end
            if curNum >= needNum then
                break
            end
        end
        fullBaseCond = curNum >= needNum
    end
    return fullBaseCond
end




DispatchData.CheckExtraCondition = function(heroList, cond)
    if heroList == nil then
        return false
    end
    if cond == nil then
        return true
    end

    local fullExtraCond = false
    if #cond > 1 and cond[1] == DispatchData.DispatchCondType.Hero then
        local needHeroID = cond[2]
        for key, value in pairs(heroList) do
            if value.heroID == needHeroID then
                fullExtraCond = true
                break
            end
        end
    elseif #cond > 2 and cond[1] == DispatchData.DispatchCondType.Job then
        local needJob = tonumber(cond[2])
        local needJobNum = tonumber(cond[3])
        local curJobNum = 0
        for key, value in pairs(heroList) do
            local heroConfig = ConfigMgr.Config.characterTable[value.heroID]
            if heroConfig.job == needJob then
                curJobNum = curJobNum + 1
            end
            if curJobNum >= needJobNum then
                break
            end
        end
        fullExtraCond = curJobNum >= needJobNum
    elseif #cond > 1 and cond[1] == DispatchData.DispatchCondType.Count then
        fullExtraCond = #heroList >= tonumber(cond[2])
    end
    return fullExtraCond
end

DispatchData.SelectHero = function(zoneID, heroID, isSelect, isDispatching, needCounter)
    local dispatchData = this.strongHoldDataIDDic[zoneID]
    if dispatchData == nil or (dispatchData ~= nil and isSelect == true and dispatchData.heroCount >= DispatchData.MaxHeroCount) then
        return false
    end
    DispatchData.SaveSelectHero(zoneID, heroID, isSelect, isDispatching)
    if isSelect == true then
        local data = {}
        data.pos = dispatchData.heroCount
        data.heroID = heroID
        data.zoneID = zoneID
        data.isSelect = isSelect
        data.isDispatching = isDispatching
        dispatchData.heroDic[heroID] = data
        dispatchData.heroCount = dispatchData.heroCount + 1
    else
        dispatchData.heroDic[heroID] = nil
        if needCounter == true then
            dispatchData.heroCount = dispatchData.heroCount - 1
            dispatchData.heroCount = math.max(0, dispatchData.heroCount)
        end
    end
    return true
end


DispatchData.GetHeroList = function(zoneID)
    local dispatchData = this.strongHoldDataIDDic[zoneID]
    if dispatchData == nil then
        LuaDebug.error("DispatchData.GetHeroList is nil")
        return {}
    end
    local tempData = {}
    local zoneIDStr = tostring(zoneID)
    for heroID, value in pairs(this.dispatchedHeroDic) do
        if value.zoneID ~= zoneIDStr then
            DispatchData.SelectHero(zoneID, heroID, false, false)
            dispatchData.heroDic[heroID] = nil
        end
    end
    for key, heroData in pairs(dispatchData.heroDic) do
        table.insert(tempData, heroData)
    end
    dispatchData.heroCount = #tempData
    table.sort(tempData, DispatchData.SortHeroDataFunc)
    return tempData
end


DispatchData.ChooseHeroList = function(strongholdData, pointHeroIDs)
    local data = this.strongHoldDataDic[strongholdData.config.Group]
    local zoneIDStr = tostring(data.id)
    for heroID, value in pairs(this.dispatchedHeroDic) do
        if value.zoneID == zoneIDStr then
            DispatchData.SelectHero(strongholdData.id, heroID, false, false)
            data.heroDic[heroID] = nil
        end
    end
    local heroArchives = this.ArchivesData.HeroDataDic[tostring(data.id)]
    if heroArchives ~= nil then
        for heroID, value in pairs(heroArchives) do
            DispatchData.SelectHero(data.id, heroID, false, false)
        end
    end
    data.heroCount = 0
    data.heroDic = {}
    local needRareData, needJobData, needHeroID, needHeroCount = DispatchData.GetConditionByStronghold(strongholdData)

    local rareDataDic = {}
    local jobDataDic = {}
    local allDataDic = {}
    local needHeroData = nil
    local characters = DataMgr.Player.characters

    for key, value in pairs(characters) do
        local heroConfig = ConfigMgr.Config.characterTable[key]
        local heroDispachData = DispatchData.GetHeroData(strongholdData.id, heroConfig.id)

        local isDispatched = DispatchData.CheckHeroBeDispatched(heroConfig.id, data.id)
        if isDispatched ~= true and (heroDispachData == nil or (heroDispachData.isSelected ~= true and heroDispachData.isDispatching ~= true)) then
            local rare = HeroMgr.GetHeroNowRare(heroConfig.id)
            local job = tonumber(heroConfig.job)
            local data = {}
            data.heroID = heroConfig.id
            data.rare = rare
            data.job = job
            local tempData = DataMgr.Player.characters[heroConfig.id]
            data.prestigeLevel = tempData.prestigeLevel
            data.prestige = tempData.prestige
            if needRareData.rare ~= 0 and rare >= needRareData.rare then
                rareDataDic[heroConfig.id] = data
            else
                allDataDic[heroConfig.id] = data
            end
            if needJobData.job ~= 0 and job == needJobData.job then
                jobDataDic[heroConfig.id] = data
            else
                allDataDic[heroConfig.id] = data
            end

            if heroConfig.id == needHeroID then
                needHeroData = data
            end
        end
    end

    local tempChooseDataDic = {}
    local remainCount = needHeroCount
    if needHeroData ~= nil and DispatchData.AutoSelectHero(needHeroData, strongholdData.id, pointHeroIDs) then
        tempChooseDataDic[needHeroData.heroID] = needHeroData
        needHeroData.zoneID = strongholdData.id
        needHeroData.isSelected = true
        needHeroData.isDispatching = false
        DispatchData.SelectHero(needHeroData.zoneID, needHeroData.heroID, true, false)
        remainCount = remainCount - 1
    end

    local fullAllCondDic = {}
    for key, value in pairs(rareDataDic) do
        if jobDataDic[value.heroID] ~= nil then
            table.insert(fullAllCondDic, value)
        end
    end
    table.sort(fullAllCondDic, DispatchData.SrotHeroByFeel)


    for key, heroData in pairs(fullAllCondDic) do
        if remainCount <= 0 then
            break
        end

        if DispatchData.AutoSelectHero(heroData, strongholdData.id, pointHeroIDs) == true then
            tempChooseDataDic[heroData.heroID] = heroData
            heroData.zoneID = strongholdData.id
            heroData.isSelected = true
            heroData.isDispatching = false
            if heroData.rare >= needRareData.needCount then
                needRareData.selectCount = needRareData.selectCount + 1
            end
            if heroData.job >= needJobData.needCount then
                needJobData.selectCount = needJobData.selectCount + 1
            end
            if DispatchData.SelectHero(heroData.zoneID, heroData.heroID, true, false) == true then
                remainCount = remainCount - 1
            end
        end
    end

    local tempCanChoosedHeroDatas = {}
    local index = 1
    if remainCount > 0 then
        for key, heroData in pairs(rareDataDic) do
            if DispatchData.AutoSelectHero(heroData, strongholdData.id, pointHeroIDs) == true then
                table.insert(tempCanChoosedHeroDatas, heroData)
            end
        end
        table.sort(tempCanChoosedHeroDatas, DispatchData.SrotHeroByFeel)
        while remainCount > 0 and index <= #tempCanChoosedHeroDatas do
            local heroData = tempCanChoosedHeroDatas[index]
            if tempChooseDataDic[heroData.heroID] == nil then
                tempChooseDataDic[heroData.heroID] = heroData
                needRareData.selectCount = needRareData.selectCount + 1
                DispatchData.SelectHero(heroData.zoneID, heroData.heroID, true, false)
                remainCount = remainCount - 1
            end
            index = index + 1
        end
    end
    if remainCount > 0 then

        tempCanChoosedHeroDatas = {}
        index = 1
        for key, heroData in pairs(jobDataDic) do
            if DispatchData.AutoSelectHero(heroData, strongholdData.id, pointHeroIDs) == true then
                table.insert(tempCanChoosedHeroDatas, heroData)
            end
        end
        table.sort(tempCanChoosedHeroDatas, DispatchData.SrotHeroByFeel)
        while remainCount > 0 and index <= #tempCanChoosedHeroDatas do
            local heroData = tempCanChoosedHeroDatas[index]
            if tempChooseDataDic[heroData.heroID] == nil then
                tempChooseDataDic[heroData.heroID] = heroData
                remainCount = remainCount - 1
            end
            index = index + 1
        end
    end

    if remainCount > 0 then
        tempCanChoosedHeroDatas = {}
        index = 1
        for key, heroData in pairs(allDataDic) do
            if DispatchData.AutoSelectHero(heroData, strongholdData.id, pointHeroIDs) == true then
                table.insert(tempCanChoosedHeroDatas, heroData)
            end
        end
        table.sort(tempCanChoosedHeroDatas, DispatchData.SrotHeroByFeel)
        while remainCount > 0 and index <= #tempCanChoosedHeroDatas do
            local heroData = tempCanChoosedHeroDatas[index]
            if tempChooseDataDic[heroData.heroID] == nil then
                tempChooseDataDic[heroData.heroID] = heroData
                remainCount = remainCount - 1
            end
            index = index + 1
        end
    end

    local tempDataList = {}
    for key, heroData in pairs(tempChooseDataDic) do
        table.insert(tempDataList, heroData)
    end
    return tempDataList
end

DispatchData.SrotHeroByFeel = function(data1, data2)
    if data1.prestigeLevel == data2.prestigeLevel then
        return data1.prestige < data2.prestige
    end
    return data1.prestigeLevel < data2.prestigeLevel
end

DispatchData.GetConditionByStronghold = function(strongholdData)

    local needHeroCount = 0
    local needRareData = {rare = 0, needCount = 0, selectCount = 0}
    local needHeroID = ""
    local needJobData = {job = 0, needCount = 0, selectCount = 0}
    local baseCond = strongholdData.curTaskConfig.BaseCond
    local extraCond = strongholdData.curTaskConfig.ExtraCond
    local allCond = {}
    for key, value in pairs(baseCond) do
        table.insert(allCond, value)
    end
    for key, value in pairs(extraCond) do
        table.insert(allCond, value)
    end
    for index, value in pairs(allCond) do
        local type = value[1]
        if type == DispatchData.DispatchCondType.Count then
            local tempCount = tonumber(value[2]) or 0
            needHeroCount = math.max(needHeroCount, tempCount)
        elseif type == DispatchData.DispatchCondType.Rare then
            needRareData.rare = tonumber(value[2]) or 0
            needRareData.needCount = tonumber(value[3]) or 0
        elseif type == DispatchData.DispatchCondType.Hero then
            needHeroID = value[2]
        elseif type == DispatchData.DispatchCondType.Job then
            needJobData.job = tonumber(value[2]) or 0
            needJobData.needCount = tonumber(value[3]) or 0
        end
    end
    return needRareData, needJobData, needHeroID, needHeroCount
end

DispatchData.ClearAutoDispatchData = function()
    this.autoDispatchHeroDatas = {}
end

DispatchData.AutoSelectHero = function(heroData, strongholdID, pointHeroIDs)
    if heroData == nil or this.autoDispatchHeroDatas[heroData.heroID] ~= nil then
        return false
    end
    if pointHeroIDs ~= nil then

        for tempStrongholdID, heroID in pairs(pointHeroIDs) do
            if heroID == heroData.heroID and tempStrongholdID ~= strongholdID then
                return false
            end
        end
    end
    this.autoDispatchHeroDatas[heroData.heroID] = heroData
    return true
end


DispatchData.CheckHeroBeDispatched = function(heroID, zoneID)
    local heroData = this.dispatchedHeroDic[heroID]
    if heroData ~= nil then
        return heroData.zoneID ~= tostring(zoneID)
    end
    return false
end





DispatchData.ExistStatusStronghold = function(status, type)
    local isFull = true
    if type == 1 then
        isFull = false
    end
    for key, value in pairs(this.strongHoldDataIDDic) do
        if type == 1 and value.status == status then
            return true
        elseif type == -1 and value.status ~= DispatchData.StrongholdStatus.Lock and value.status ~= status then
            isFull = false
        end
    end
    return isFull
end


DispatchData.GetStrongholdNum = function(status)
    local count = 0
    for key, value in pairs(this.strongHoldDataIDDic) do
        if value.status == status then
            count = count + 1
        end
    end
    return count
end

DispatchData.GetRedPointCount = function()
    return DispatchData.CheckRedPoint(true, true)
end

DispatchData.GetStoryRewardRed = function()
    if FeatureManager.IsLock("30097") then
        return 0
    end
    local storyDatas = DispatchData.GetStoryDatas()
    if storyDatas == nil then
        return 0
    end
    local redID = "16823"
    local redNum = 0
    for key, value in pairs(storyDatas) do
        if value.status == DispatchData.GetRewardStatus.CanGet then
            redNum = 1
            break
        end
    end
    RedMgr.Singleton:UpdateClientRedData(redID, redNum)
    return redNum
end

DispatchData.CheckRedPoint = function(isInit, onlyRedPoint, noCalData)
    if FeatureManager.IsLock("30095") == true then
        return 0
    end
    if isInit and DispatchData.IsInit ~= true then
        DispatchData.IsInit = true
        DispatchData.Init()
    end
    if noCalData ~= true then
        DispatchData.GetAllDatas(onlyRedPoint)
    end

    local strongholdRed = 0
    for key, data in pairs(this.strongHoldDataIDDic) do
        if data.status == DispatchData.StrongholdStatus.DispatchEnd then
            strongholdRed = strongholdRed + 1
        end
    end
    RedMgr.Singleton:UpdateClientRedData("16822", strongholdRed)

    local randomAwardRed = 0
    local randomAwardIndex = DispatchData.GetRandomAwardIndex(true)
    if randomAwardIndex ~= nil then
        randomAwardRed = 1
    end
    RedMgr.Singleton:UpdateClientRedData("16824", randomAwardRed)


    local redID = "16820"
    if RedMgr.Singleton:CheckRedCondition(redID) then
        RedMgr.Singleton:UpdateClientRedData(redID, 0)
        return 1
    end
    return strongholdRed + randomAwardRed
end


DispatchData.GetPlayerReputationData = function()
    local configs = ConfigMgr.Config.DispatchLevelMap
    local curLevel = DataMgr.Player.DispatchRegular.level
    local curLevelConfig = configs[tostring(curLevel)]
    local progressNum = DataMgr.Player.DispatchRegular.reputation or 0
    local nextLevelNeedReputation = 0
    if curLevelConfig ~= nil then
        nextLevelNeedReputation = curLevelConfig.Reputation
    end
    return progressNum, nextLevelNeedReputation
end


DispatchData.GetReputationDatas = function()
    for key, value in pairs(this.reputationDic) do
        value.isUnlock = key <= DataMgr.Player.DispatchRegular.level
    end
    return this.reputationDic
end


DispatchData.GetReputationDataByLevel = function(level)
    local data = this.reputationDic[level]
    if data ~= nil then
        data.isUnlock = data.config.Level <= DataMgr.Player.DispatchRegular.level
    end
    return data
end


DispatchData.InitStoryConfig = function()
    local dispatchStoryConfigs = ConfigMgr.Config.DispatchStoryMap
    for key, value in pairs(dispatchStoryConfigs) do
        local data = {}
        data.config = value
        data.status = DispatchData.GetRewardStatus.None
        this.dispatchStoryDataDic[tostring(value.ID)] = data
    end
end

DispatchData.GetStoryDatas = function()
    if this.dispatchStoryDataDic == nil then
        this.dispatchStoryDataDic = {}
        DispatchData.InitStoryConfig()
    end
    local datas = DataMgr.Player.DispatchRegular.storyIds
    if type(datas) == "function" then
        datas = {}
    end
    local dataList = {}
    for key, value in pairs(datas) do
        local valueNum = tonumber(value)
        local data = this.dispatchStoryDataDic[tostring(key)]
        if valueNum == 0 then
            data.status = DispatchData.GetRewardStatus.CanGet
        else
            data.status = DispatchData.GetRewardStatus.Got
        end
        table.insert(dataList, data)
    end
    local onSort = function(data1, data2)
        return data1.config.ID < data2.config.ID
    end
    table.sort(dataList, onSort)
    return dataList
end



DispatchData.GetRandomAwardIndex = function(onlyRed)
    local weekGetCount = DataMgr.Player.weeklyCount.dispatchRegularRewards or 0
    local weekGetLimit = ConfigMgr.Config.DispatchConstants.RandomRewardLimit
    if weekGetCount >= weekGetLimit then
        return nil
    end

    DispatchData.RefreshRandomAwardArc()
    local curTime = LuaMgr.Timestamp()
    local curHour = LuaMgr.GetNowHour()
    local tempRandomData = nil
    if curHour <= 13 then
        tempRandomData = this.RandomAwardData[this.randomRewardAM]
    else
        tempRandomData = this.RandomAwardData[this.randomRewardPM]
    end
    local awardTime = 0
    local awardIndex = 0
    local gotStatus = DispatchData.GetRewardStatus.None
    if tempRandomData ~= nil then
        awardTime = tempRandomData.awardTime or 0
        awardIndex = tempRandomData.awardIndex or 0
        gotStatus = tempRandomData.gotStatus or DispatchData.GetRewardStatus.None
    end
    local awardInterval = ConfigMgr.Config.DispatchConstants.RandomRewardLastTime * 60
    local existRandomAward = true
    if awardTime + awardInterval < curTime then
        existRandomAward = false
    else

        if gotStatus == DispatchData.GetRewardStatus.CanGet then
            return awardIndex
        end
        return nil
    end
    if onlyRed == true then
        return nil
    end
    if tempRandomData ~= nil and tempRandomData.gotStatus == DispatchData.GetRewardStatus.Got then
        return nil
    end
    if existRandomAward == false then
        local duringData = DispatchData.GetRandomTimeDuring()
        local canRandom = false
        for key, value in pairs(duringData) do
            if curHour >= value[1] and curHour <= value[2] then
                canRandom = true
                break
            end
        end
        local isTrigger = false
        if canRandom == true then
            math.randomseed(curTime)
            local randomNum = math.random(1, 10000)
            isTrigger = randomNum < ConfigMgr.Config.DispatchConstants.RandomRewardRate
        end
        if isTrigger == true then
            local randomAwardCfg = ConfigMgr.Config.DispatchConstants.RandomReward
            awardTime = curTime
            awardIndex = math.random(1, #randomAwardCfg)
            gotStatus = DispatchData.GetRewardStatus.CanGet
            local data = {}
            data.awardTime = awardTime
            data.awardIndex = awardIndex
            data.gotStatus = gotStatus
            if curHour <= 13 then
                this.RandomAwardData[this.randomRewardAM] = data
            else
                this.RandomAwardData[this.randomRewardPM] = data
            end
            DispatchData.SaveRandomAwardArchives()
            return awardIndex
        end
    end
    return nil
end

DispatchData.GetRandomTimeDuring = function()
    if this.RandomTimeDuringData ~= nil then
        return this.RandomTimeDuringData
    end
    this.RandomTimeDuringData = {}
    local ramdomTimes = ConfigMgr.Config.DispatchConstants.RandomRewardTime
    for key, value in pairs(ramdomTimes) do
        local startStr, endStr = value[1], value[2]
        local startHourStr = startStr:match("(%d+):(%d+)")
        local endHourStr = endStr:match("(%d+):(%d+)")
        local startHourNum = tonumber(startHourStr)
        local endHourNum = tonumber(endHourStr)
        table.insert(this.RandomTimeDuringData, {startHourNum, endHourNum})
    end
    return this.RandomTimeDuringData
end


DispatchData.GetRandomAward = function()
    local curHour = LuaMgr.GetNowHour()
    local data = nil
    if curHour <= 13 then
        data = this.RandomAwardData[this.randomRewardAM]
    else
        data = this.RandomAwardData[this.randomRewardPM]
    end
    data.gotStatus = DispatchData.GetRewardStatus.Got
    DispatchData.SaveRandomAwardArchives()
end


DispatchData.InitArchives = function()
    local archivesStr = PlayerPrefs.GetString(this.PlayerArchivesKey)
    if not archivesStr or archivesStr == "" then
        this.ArchivesData = {}
        this.ArchivesData.HeroDataDic = {}
    else
        this.ArchivesData = json.decode(archivesStr)
        if this.ArchivesData.HeroDataDic == nil then
            this.ArchivesData.HeroDataDic = {}
        end
    end
end

DispatchData.SaveSelectHero = function(zoneID, heroID, isSelect, isDispatching)
    if not this.ArchivesData.HeroDataDic then
        this.ArchivesData.HeroDataDic = {}
    end
    local zoneIDStr = tostring(zoneID)
    if this.ArchivesData.HeroDataDic[zoneIDStr] == nil then
        this.ArchivesData.HeroDataDic[zoneIDStr] = {}
    end
    local heroIDStr = tostring(heroID)
    if this.ArchivesData.HeroDataDic[zoneIDStr][heroIDStr] == nil then
        this.ArchivesData.HeroDataDic[zoneIDStr][heroIDStr] = {}
    end
    local heroData = this.ArchivesData.HeroDataDic[zoneIDStr][heroIDStr]
    heroData.zoneID = zoneID
    heroData.heroID = heroID
    heroData.isSelected = isSelect
    heroData.isDispatching = isDispatching
end

DispatchData.GetHeroData = function(zoneID, heroID)
    if this.ArchivesData.HeroDataDic == nil then
        return nil
    end
    local zoneIDStr = tostring(zoneID)
    if this.ArchivesData.HeroDataDic[zoneIDStr] == nil then
        return nil
    end
    local heroIDStr = tostring(heroID)
    local heroData = this.ArchivesData.HeroDataDic[zoneIDStr][heroIDStr]
    return heroData
end

DispatchData.SaveArchives = function()
    if this.ArchivesData == nil then
        this.ArchivesData = {}
    end
    PlayerPrefs.SetString(this.PlayerArchivesKey, json.encode(this.ArchivesData))
    PlayerPrefs.Save()
end

DispatchData.RefreshRandomAwardArc = function()
    this.RandomAwardData = {}
    local randomAwardStr = PlayerPrefs.GetString(this.RandomAwardArchivesKey)
    if randomAwardStr ~= nil and randomAwardStr ~= "" then
        this.RandomAwardData = json.decode(randomAwardStr)
    end
end

DispatchData.SaveRandomAwardArchives = function()
    PlayerPrefs.SetString(this.RandomAwardArchivesKey, json.encode(this.RandomAwardData))
    PlayerPrefs.Save()
end


