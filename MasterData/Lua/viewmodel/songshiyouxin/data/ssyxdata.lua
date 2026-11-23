




require("ViewModel/SongShiYouXin/Data/SSYXConst")
SSYXData = {}
local this = {
lastPlayerUID = nil,
wordDatas = {},

wordDataDic = {},
employeeDatas = {},
employeeDic = {},
buildConfigDatas = {},
    buildSceneConfigDatas = {},
buildConfigDic = {},
orderDatas = {},
orderDic = {},
allVisitList = {},
    allVisitDic = {},
    avatarFramesConfigDic = {},
    visitRecordDatas = {},
    technoloyDatas = {},
    technoloyDataDic = {},
    mapEventGroup = {}
}



SSYXData.InitData = function()
    local wordConfigs = ConfigMgr.Config.OperateEmployeeEntryMap
    this.wordDatas = {}
    this.wordDataDic = {}
    this.employeeDatas = {}
    this.employeeDic = {}
    this.avatarFramesConfigDic = {}
    for i = 1, 100 do
        local id = tostring(3000 + i)
        local wordConfig = wordConfigs[id]
        if wordConfig == nil then
            break
        end
        local data = {}
        data.ID = id
        data.Config = wordConfig
data.IsSelected = true
data.EmployeeDatas = {}
data.EmployeeDic = {}
        table.insert(this.wordDatas, data)
        this.wordDataDic[id] = data
    end

    local allConfigs = {}
    local employeeConfigs = ConfigMgr.Config.OperateEmployeeMap
    for key, value in pairs(employeeConfigs) do
        table.insert(allConfigs, value)
    end
    table.sort(allConfigs, SSYXData.SortEmployeeBySort)
    for i = 1, #allConfigs do
        local config = allConfigs[i]
        local employeeData = {}
        employeeData.ID = config.Id
        employeeData.Config = config
        employeeData.Rare = HeroMgr.GetHeroNowRare(employeeData.ID)
        local characterConfig = ConfigMgr.Config.characterTable[employeeData.ID]
        employeeData.Name = LuaMgr.GetLangText(characterConfig.namelan)
        employeeData.BeEmplooyed = false
        employeeData.Level = 1
        employeeData.Exp = 0
        for _, wordID in pairs(config.Entry) do
            local wordData = this.wordDataDic[wordID]
            if wordData == nil then
                LuaDebug.error(string.format("词条ID:%s在配置表中不存在", wordID))
            else
                table.insert(wordData.EmployeeDatas, employeeData)
                wordData.EmployeeDic[employeeData.ID] = employeeData
            end
        end
        table.insert(this.employeeDatas, employeeData)
        this.employeeDic[employeeData.ID] = employeeData
    end

    for i, v in ipairs(ConfigMgr.Config.avatarFrames) do
        this.avatarFramesConfigDic[v.id] = v
    end

    SSYXData.InitBuildData()
    SSYXData.InitOrderData()
    SSYXData.InitTechnologyData()
    SSYXData.InitMapEventData()
end

SSYXData.InitBuildData = function()
    this.buildConfigDatas = {}
    this.buildConfigDic = {}
    this.buildSceneConfigDatas = {{}, {}}

    local buildConfigs = ConfigMgr.Config.OperateSceneMap
    for i = 1, 100 do
        local id = tostring(1000 + i)
        local buildConfig = buildConfigs[id]
        if buildConfig == nil then
            break
        end
        local buildData = {}
        buildData.ID = id
        buildData.Config = buildConfig
        buildData.OutputConfig = ConfigMgr.Config.OperateOutputMap[id]
        buildData.IsUnlock = buildConfig.UnlockType == 1
        buildData.Level = buildConfig.InitialLevel
        buildData.WordDic = {}
        buildData.SceneIndex = buildConfig.ParentType
        if buildConfig.ParentType == 1 then
            table.insert(this.buildSceneConfigDatas[1], buildData)
        else
            table.insert(this.buildSceneConfigDatas[2], buildData)
        end
        if buildConfig.Task ~= nil then
            buildData.TaskDatas = {}
            buildData.TaskDataDic = {}
            for j = 1, #buildConfig.Task do
                local taskID = buildConfig.Task[j]
                local config = ConfigMgr.Config.questEvent[taskID]
                local conditionArgs = config.conditionArgs
                local levelDatas = {}
                if conditionArgs ~= nil and #conditionArgs > 0 then
                    for k = 1, #conditionArgs do
                        local questID = conditionArgs[k]
                        local childQuestConfig = ConfigMgr.Config.questEvent[questID]
                        local childQuestConfig = table.CopyNoMeta(childQuestConfig)
                        childQuestConfig.ID = questID
                        childQuestConfig.IsComplete = false
                        childQuestConfig.CurProgress = 0
                        childQuestConfig.TotalProgress = childQuestConfig.progress
                        table.insert(levelDatas, childQuestConfig)
                    end
                end
                buildData.TaskDataDic[j] = levelDatas
                table.insert(buildData.TaskDatas, #buildData.TaskDatas + 1, levelDatas)
            end
        end
        buildData.UpgradeItems = {}
        if type(buildData.Config.UpgradeCostItem1) == "table" then
            for j = 1, #buildData.Config.UpgradeCostItem1 do
                local tempItems = buildData.Config.UpgradeCostItem1[j]
                for k = 1, #tempItems do
                    local item = tempItems[k]
                    local data = {}
                    data.ID = item.id
                    data.NeedCount = item.count
                    data.IsInBag = true
                    data.OwnerCount = 0
                    if buildData.UpgradeItems[j] == nil then
                        buildData.UpgradeItems[j] = {}
                    end
                    table.insert(buildData.UpgradeItems[j], data)
                end
            end
        end
        if type(buildData.Config.UpgradeCostItem2) == "table" then
            for j = 1, #buildData.Config.UpgradeCostItem2 do
                local tempItems = buildData.Config.UpgradeCostItem2[j]
                for k = 1, #tempItems do
                    local item = tempItems[k]
                    local data = {}
                    data.ID = item.id
                    data.NeedCount = item.count
                    data.IsInBag = false
                    data.OwnerCount = 0
                    if buildData.UpgradeItems[j] == nil then
                        buildData.UpgradeItems[j] = {}
                    end
                    table.insert(buildData.UpgradeItems[j], data)
                end
            end
        end
        if type(buildData.Config.OperateEmployeeEntryID) == "table" then
            for _, wordID in pairs(buildData.Config.OperateEmployeeEntryID) do
                buildData.WordDic[wordID] = true
            end
        end
        table.insert(this.buildConfigDatas, buildData)
        this.buildConfigDic[id] = buildData
    end
    this.buildUnlockReverseDatas = {}
    for i = 1, #this.buildConfigDatas do
        local data = {}
        local buildConfigData = this.buildConfigDatas[i]
        if buildConfigData.Config ~= nil and buildConfigData.Config.UnlockConditions ~= nil then
            local condition = buildConfigData.Config.UnlockConditions
            local conditionID = condition[1]
            local conditionLevel = tonumber(condition[2]) or 0
            if conditionID ~= nil and conditionID ~= "" then
                data.ID = buildConfigData.ID
                data.ConditionLevel = conditionLevel
                if this.buildUnlockReverseDatas[conditionID] == nil then
                    this.buildUnlockReverseDatas[conditionID] = {}
                end
                if conditionLevel > 0 then
                    this.buildUnlockReverseDatas[conditionID][conditionLevel] = data
                end
            end
        end
    end
end

SSYXData.InitOrderData = function()
    this.orderDatas = {}
    this.orderDic = {}
    local orderConfigs = ConfigMgr.Config.OperateOrderMap
    for i = 1, 100 do
        local id = tostring(i)
        local orderConfig = orderConfigs[id]
        if orderConfig == nil then
            break
        end
        local orderData = {}
        orderData.ID = id
        orderData.Config = orderConfig
        orderData.IsUnlock = orderConfig.UnlockType == 1
        table.insert(this.orderDatas, orderData)
        this.orderDic[id] = orderData
    end
end

SSYXData.InitTechnologyData = function()
    this.technoloyDatas = {}
    this.technoloyDataDic = {}
    local configs = ConfigMgr.Config.OperateTechTreeMap
    for i = 1, 100 do
        local id = tostring(i)
        local config = configs[id]
        if config == nil then
            break
        end
        local data = {}
        data.ID = id
        data.Config = config
        data.Level = 1
        data.IsUnlock = data.PrerequisitesTech == nil and true or false
        table.insert(this.technoloyDatas, data)
        this.technoloyDataDic[id] = data
    end
end

SSYXData.InitMapEventData = function()
    this.mapEventGroup = {}
    for key, value in pairs(SSYXConst.EventType) do
        this.mapEventGroup[value] = DataExHelper.EX_GetEventListByArea(value)
    end
end



SSYXData.CheckActivityRunning = function(isStatic)
    if this.lastPlayerUID ~= DataMgr.Player.uid then
        SSYXData.InitData()
        this.lastPlayerUID = DataMgr.Player.uid
    end
    if not DataExHelper.CommonActivityCheck(ActivityKey.SSYX) then
        if not isStatic then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
        end
        return false
    end
    return true
end

SSYXData.GetRemainTimeStr = function()
    local activityData = DataExHelper.GetDataExByTag(ActivityKey.SSYX)
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


SSYXData.GetAllWordDatas = function()
    return this.wordDatas
end

SSYXData.SelectOneWord = function(wordID, isSelected)
    this.wordDataDic[wordID].IsSelected = isSelected
end

SSYXData.IsWordSelected = function(wordID)
    return this.wordDataDic[wordID] ~= nil and this.wordDataDic[wordID].IsSelected == true
end

SSYXData.SelectAllWord = function(isSelected)
    for _, wordData in pairs(this.wordDatas) do
        wordData.IsSelected = isSelected
    end
end

SSYXData.GetAllSelectedWordIDs = function()
    local selectedWordIDs = {}
    for _, wordData in pairs(this.wordDatas) do
        if wordData.IsSelected == true then
            table.insert(selectedWordIDs, wordData.ID)
        end
    end
    return selectedWordIDs
end

SSYXData.GetEmployeeWordDatas = function(employeeID)
    local employeeData = this.employeeDic[employeeID]
    if employeeData == nil then
        return {}
    end
    local wordDatas = {}
    for _, wordID in pairs(employeeData.Config.Entry) do
        local wordData = this.wordDataDic[wordID]
        if wordData ~= nil then
            table.insert(wordDatas, wordData)
        end
    end
    return wordDatas
end



SSYXData.GetAllBuildConfigs = function()
    return this.buildConfigDatas
end

SSYXData.GetAllBuildData = function(sceneIndex, uid, isCreated)
    local opBuilds = nil
    local allCreatedData = {}
    if uid == nil then
        uid = DataMgr.Player.uid
    end
    local isSelf = uid == DataMgr.Player.uid
    if isSelf then
        opBuilds = SSYXData.GetSelfBuildServerData()
    else
        opBuilds = SSYXData.GetVisitorBuildServerData()
    end
    if opBuilds == nil then
        LuaDebug.error("拜访了其他玩家，但是数据错误")
        return {}
    end
    local configDatas = this.buildSceneConfigDatas[sceneIndex]
    local canCreateCount = 0
    for key, value in pairs(configDatas) do
        SSYXData.RefreshBuildData(value)
        if isCreated == true and value.IsCreated == true then
            table.insert(allCreatedData, value)
        end
        if value.CanCreate == true then
            canCreateCount = canCreateCount + 1
        end
    end
    table.sort(configDatas, SSYXData.SortBuildData)
    return configDatas, allCreatedData, canCreateCount
end

SSYXData.SortBuildData = function(data1, data2)
    return data1.Config.Location < data2.Config.Location
end

SSYXData.RefreshBuildDataByID = function(buildID)
    local buildData = SSYXData.GetBuildDataByID(buildID)
    SSYXData.RefreshBuildData(buildData)
end

SSYXData.RefreshBuildData = function(buildData, opBuilds, isSelf)
    if opBuilds == nil then
        opBuilds = SSYXData.GetSelfBuildServerData()
    end
    if isSelf == nil then
        isSelf = true
    end
    local buildID = buildData.ID
    local serverData = opBuilds[buildID]
    buildData.CanCreate = false
    buildData.CanUpgrade = false
    buildData.Level = 1
    buildData.IsUnlock = SSYXData.CheckBuildIsUnlock(buildID)
    buildData.IsCreated = SSYXData.CheckBuildCreated(buildID, opBuilds)
    buildData.IsSelf = isSelf
    buildData.ServerData = serverData or {}
    buildData.CanCreate = SSYXData.CheckBuildCanCreate(buildID, opBuilds)
    if serverData ~= nil then
        buildData.Level = serverData.Level
        buildData.IsUnlock = SSYXData.CheckBuildIsUnlock(buildID, opBuilds)
        if isSelf == true then
            buildData.CanUpgrade = SSYXData.CheckBuildCanUpgrade(buildID, opBuilds)
            buildData.IsCompleteAllTask = SSYXData.CheckBuildTaskAllCompleted(buildID, opBuilds)
        end
    end
end

SSYXData.GetBuildServerData = function(buildID)
    local opBuilds = SSYXData.GetSelfBuildServerData()
    if opBuilds == nil then
        return {}
    end
    local opBuild = opBuilds[buildID]
    return opBuild
end

SSYXData.GetEmployingDatas = function(buildID)
    local opBuild = SSYXData.GetBuildServerData(buildID)
    if opBuild == nil then
        return {}
    end
    local datas = {}
    for key, value in pairs(opBuild.Employees) do
        local data = SSYXData.GetEmployeDataByID(key)
        table.insert(datas, data)
    end
    return datas
end

SSYXData.GetBuildDataByID = function(buildID)
    if this.lastPlayerUID ~= DataMgr.Player.uid then
        SSYXData.InitData()
    end
    local buildData = this.buildConfigDic[buildID]
    SSYXData.RefreshBuildData(buildData)
    return buildData
end

SSYXData.GetSelfBuildServerData = function()
    return DataMgr.Player.OperateBuild.OpBuilds or {}
end

SSYXData.SetVisitorBuildServerData = function(opBuilds)
    this.visitorBuildServerData = opBuilds
end

SSYXData.GetVisitorBuildServerData = function()
    return this.visitorBuildServerData or {}
end

SSYXData.CheckBuildIsUnlock = function(buildID, opBuilds)
    local buildConfig = this.buildConfigDic[buildID]
    if buildConfig.Config.UnlockType == SSYXConst.BuildUnlockType.Defalt or buildConfig.Config.UnlockType == SSYXConst.BuildUnlockType.Buy then
        return true
    elseif buildConfig.Config.UnlockType == SSYXConst.BuildUnlockType.Level and opBuilds ~= nil then
        local condition = buildConfig.Config.UnlockConditions
        local conditionID = condition[1]
        local conditionLevel = tonumber(condition[2]) or 0
        return opBuilds[conditionID] ~= nil and opBuilds[conditionID].Level >= conditionLevel
    end
    return false
end

SSYXData.CheckBuildCreated = function(buildID, opBuilds)
    return opBuilds ~= nil and opBuilds[buildID] ~= nil
end

SSYXData.CheckBuildCanCreate = function(buildID, opBuilds)
    local buildConfig = this.buildConfigDic[buildID]
    if buildConfig == nil then
        return false
    end
    local isUnlock = SSYXData.CheckBuildIsUnlock(buildID, opBuilds)
    if isUnlock == false then
        return false
    elseif buildConfig.Config.DefaultConstruction == 1 then
        return false
    end
    return SSYXData.CheckBuildCreated(buildID, opBuilds) == false
end

SSYXData.CheckBuildTaskAllCompleted = function(buildID, opBuilds)
    local buildConfig = this.buildConfigDic[buildID]
    if buildConfig == nil then
        return false
    end
    local opBuildData = opBuilds[buildID]
    local _, complateCount, totalCount = SSYXData.GetBuildTaskDatas(buildID, opBuildData.Level)
    return complateCount ~= 0 and complateCount >= totalCount
end

SSYXData.CheckBuildCanUpgrade = function(buildID, opBuilds)
    local buildConfig = this.buildConfigDic[buildID]
    if buildConfig == nil then
        return false
    end
    local isUnlock = SSYXData.CheckBuildIsUnlock(buildID, opBuilds)
    if isUnlock == false then
        return false
    end
    if buildConfig.Level >= buildConfig.Config.LevelCap then
        return false
    end
    if buildConfig.Config.Upgrade ~= 1 then
        return false
    end
    if buildConfig.Config.UpgradeCost2 == nil or buildConfig.Config.UpgradeCost2 == "" or SSYXData.IsEnoughConsume(buildConfig.Config.UpgradeCostItem2[buildConfig.Level], true) == false then
        return false
    end
    if buildID == SSYXConst.BuildID.HuiGuan and SSYXData.CheckBuildTaskAllCompleted(buildID, opBuilds) == false then
        return false
    end
    return true
end

SSYXData.IsEnoughConsume = function(items, isActivityItem)
    for i = 1, #items do
        local item = items[i]
        local ownerCount = PlayerItemMgr.GetItemCountById(item.id)
        if isActivityItem == true then
            ownerCount = SSYXData.GetItemCountByID(item.id)
        end
        if ownerCount < item.count then
            return false
        end
    end
    return true
end

SSYXData.IsEmploying = function(employeeID)
    local employeeData = this.employeeDic[employeeID]
    if employeeData == nil then
        return false
    end
    return employeeData.BeEmplooyed == true
end

SSYXData.GetBuildTaskDatas = function(buildID, level)
    local buildData = this.buildConfigDic[buildID]
    if buildData == nil or buildData.TaskDatas == nil then
        return {}, 0, 0
    end
    local taskDatas = buildData.TaskDatas[level]
    if taskDatas == nil then
        taskDatas = buildData.TaskDatas[#buildData.TaskDatas]
    end
    if taskDatas == nil then
        return {}, 0, 0
    end
    local completeCount = 0
    for j = 1, #taskDatas do
        local taskData = taskDatas[j]
        local serverData = DataMgr.Player.quests[taskData.ID]
        taskData.CurProgress = 0
        taskData.IsComplete = false
        if type(serverData) == "table" then
            taskData.CurProgress = serverData.progress
            if serverData.state == 1 then
                taskData.IsComplete = false
            elseif type(serverData.state) == "number" then
                taskData.IsComplete = true
                completeCount = completeCount + 1
            end
        end
    end
    return taskDatas, completeCount, #taskDatas
end

SSYXData.GetBuildUpgradeItems = function(buildID, level)
    local buildConfig = this.buildConfigDic[buildID]
    if buildConfig == nil then
        return {}
    end
    local items = buildConfig.UpgradeItems[level]
    if items == nil then
        LuaDebug.error(string.format("SSYXData.GetBuildUpgradeItems 当前等级的升级道具数据不存在.BuildID:%d Level:%d", buildID, level))
        return {}
    end
    for i = 1, #items do
        local item = items[i]
        if item.IsInBag == true then
            item.OwnerCount = PlayerItemMgr.GetItemCountById(item.ID)
        else
            item.OwnerCount = SSYXData.GetItemCountByID(item.ID)
        end
    end
    return items
end

SSYXData.GetMainBuildUpgradeData = function(buildID, level)
    local reverseData = this.buildUnlockReverseDatas[buildID]
    if reverseData == nil then
        return {}
    end
    return reverseData[level]
end


SSYXData.SetBuildTempData = function(buildData)
    this.tempBuildData = buildData
end


SSYXData.GetBuildTempData = function()
    local data = this.tempBuildData
    this.tempBuildData = nil
    return data
end

SSYXData.GetProductDatas = function(buildID)
    local buildData = SSYXData.GetBuildDataByID(buildID)
    local datas = {}
    local config = buildData.OutputConfig
    local contentProductions = config.ContentProductionTool
    local consumes = config.ConsumeTool
    local maxOutputNums = config.MaxOutputNum
    local outputTimes = config.OutputTime
    local curUnlockNum = SSYXData.ProductGridIsUnlock(buildData)
    local existMakingProduct = false
    for i = 1, #contentProductions do
        local data = {}
        data.Index = i

        local contentProduct = contentProductions[i][1]
        local tempData = contentProduct
        tempData.ID = tempData.id
        tempData.Count = tempData.count
        tempData.IsInBag = false
        tempData.NumText = tostring(tempData.count)
        data.ContentProduction = tempData
        data.Consume = {}
        data.MakingOther = false
        if consumes ~= nil and consumes[i] ~= nil then
            for j = 1, #consumes[i] do
                local tempData1 = consumes[i][j]
                tempData1.ID = tempData1.id
                tempData1.Count = tempData1.count
                tempData1.IsInBag = false
                tempData1.NumText = tostring(tempData1.count)
                table.insert(data.Consume, tempData1)
            end
        end
        data.MaxOutputNum = maxOutputNums[buildData.Level] or 0
        data.OutputTime = outputTimes[buildData.Level]
        data.IsMaking = SSYXData.GetIsMaking(buildData, i)
        if data.IsMaking == true then
            existMakingProduct = true
        end
        data.IsUnlock = i <= curUnlockNum
        local config = SSYXData.GetItemConfig(tempData.ID)
        data.IconName = config.Icon
        if data.IsUnlock == false then
            data.UnlockDesc = SSYXData.GetProductUnlockDesc(i, buildData)
        end
        table.insert(datas, data)
    end
    for key, value in pairs(datas) do
        if value.IsMaking == false and existMakingProduct == true then
            value.MakingOther = true
        end
    end
    return datas
end

SSYXData.ProductGridIsUnlock = function(buildData)
    local curUnlockNum = 0
    local employmentQuantity = buildData.Config.UnlookOutput
    for i = 1, buildData.Level do
        curUnlockNum = curUnlockNum + employmentQuantity[i]
    end
    return curUnlockNum
end

SSYXData.GetProductUnlockDesc = function(tempIndex, buildData)
    local employmentQuantity = buildData.Config.UnlookOutput
    local curUnlockNum = 0
    for i = 1, #employmentQuantity do
        local tempNum = employmentQuantity[i]
        if i > buildData.Level then
            local nextTotalNum = curUnlockNum + tempNum
            if tempIndex <= nextTotalNum then
                return string.format(LuaMgr.GetLangText(SSYXConst.LanText.LanText25), i)
            end
        end
        curUnlockNum = curUnlockNum + tempNum
    end
    LuaDebug.error("GetProductUnlockDesc 数据错误")
    return ""
end



SSYXData.GetTreeData = function(uid)
    local isSelf = uid == DataMgr.Player.uid
    local treeExp = 0
    if isSelf then
        treeExp = SSYXData.GetSelfTreeExp()
    else
        treeExp = SSYXData.GetVisitorTreeExp()
    end
    local level = SSYXData.GetTreeLevel(treeExp)
    local data = {}
    data.TreeExp = treeExp
    data.Level = level
    data.WaterCount = SSYXData.GetWaterCount()
    data.MaxWaterCount = ConfigMgr.Config.OperateConstants.DailyMaxLikeCount
    return data
end

SSYXData.GetTreeLevel = function(treeExp)
    local dailyLikeExpLevel = ConfigMgr.Config.OperateConstants.DailyLikeExpLevel
    local level = 1
    for i = 1, #dailyLikeExpLevel do
        if treeExp >= dailyLikeExpLevel[i] then
            level = math.max(level, i)
        end
    end
    return level
end

SSYXData.GetSelfTreeExp = function()
    return DataMgr.Player.OperateBuild.Tree.TreeExp or 0
end

SSYXData.SetVisitorTreeExp = function(treeExp)
    this.visitorTreeExp = treeExp
end

SSYXData.GetVisitorTreeExp = function()
    return this.visitorTreeExp or 0
end

SSYXData.GetWaterCount = function()
    local dailyWatering = DataMgr.Player.OperateBuild.Tree.DailyWatering
    if type(dailyWatering) ~= "table" then
        return 0
    end
    local count = 0
    for key, value in pairs(dailyWatering) do
        count = count + value
    end
    return count
end




SSYXData.GetAllSelectWordEmployeeDatas = function()
    local allSelectedWordIDs = SSYXData.GetAllSelectedWordIDs()
    local employeeDic = {}
    for i = 1, #allSelectedWordIDs do
        local wordID = allSelectedWordIDs[i]
        local wordData = this.wordDataDic[wordID]
        if wordData ~= nil then
            for _, employeeData in pairs(wordData.EmployeeDic) do
                employeeDic[employeeData.ID] = employeeData
            end
        end
    end
    local employeeDatas = {}
    for _, employeeData in pairs(employeeDic) do
        local heroData = DataMgr.Player.characters[employeeData.ID]
        if heroData ~= nil then
            table.insert(employeeDatas, employeeData)
            SSYXData.RefreshEmployeeData(employeeData.ID)
        end
    end
    return employeeDatas
end

SSYXData.GetEmployeeByWordDatas = function(wordID)
    if wordID == nil then
        return SSYXData.GetAllWordEmployeeDatas()
    end
    local employeeDatas = this.wordDataDic[wordID] and this.wordDataDic[wordID].EmployeeDatas or {}
    local employeeDic = this.wordDataDic[wordID] and this.wordDataDic[wordID].EmployeeDic or {}
    return employeeDatas, employeeDic
end

SSYXData.GetEmployeDataByID = function(employeeID)
    SSYXData.RefreshEmployeeData(employeeID)
    return this.employeeDic[employeeID]
end

SSYXData.GetAllWordEmployeeDatas = function()
    return this.employeeDatas
end

SSYXData.RefreshEmployeeData = function(employeeID)
    local employeeData = this.employeeDic[employeeID]
    if employeeData == nil then
        return
    end
    local employeeServerDatas = DataMgr.Player.OperateBuild.Employees
    if employeeServerDatas == nil then
        return
    end
    local serverData = employeeServerDatas[employeeID]
    if serverData == nil then
        return
    end
    employeeData.Level = serverData.Level
    employeeData.BuildId = serverData.BuildId
    employeeData.Exp = serverData.Exp
    employeeData.CreateTime = serverData.CreateTime
    employeeData.BeEmplooyed = serverData.BuildId ~= nil and serverData.BuildId ~= ""
    local levelConfig = ConfigMgr.Config.OperateEmployeeLevelMap[tostring(employeeData.Level)]
    employeeData.Attribute = employeeData.Config.Attribute + levelConfig.Attribute
end

SSYXData.GetEmployeeLevel = function(employeeID)
    local employeeData = this.employeeDic[employeeID]
    if employeeData == nil then
        return 0
    end
    return employeeData.Level or 0
end

SSYXData.GetIsMaking = function(buildData, index)
    SSYXData.RefreshBuildDataByID(buildData.ID)
    local produceCount = buildData.ServerData.ProduceCount or 0
    if index == nil then
        return produceCount > 0
    end
    return buildData.ServerData.ProduceChoose == index - 1 and produceCount > 0
end



SSYXData.SortEmployeeBySort = function(data1, data2)
    return data1.Sort < data2.Sort
end

SSYXData.SortEmployeeByRare = function(data1, data2)
    if data1.Rare == data2.Rare then
        return data1.Config.Sort < data2.Config.Sort
    else
        return data1.Rare < data2.Rare
    end
end

SSYXData.SortEmployeeDescendingByRare = function(data1, data2)
    if data1.CanAddition == true and data2.CanAddition == false then
        return true
    elseif data1.CanAddition == false and data2.CanAddition == true then
        return false
    end
    if data1.Rare == data2.Rare then
        return data1.Config.Sort < data2.Config.Sort
    else
        return data1.Rare > data2.Rare
    end
end






SSYXData.GetAllOrderDatas = function()
    local curTime = LuaMgr.Timestamp()
    local actTimeData = DataExHelper.GetActivityTimeData(ActivityKey.SSYX)
    if actTimeData.StartTime ~= nil and actTimeData.ExpireTime ~= nil and actTimeData.StartTime > curTime or actTimeData.ExpireTime < curTime then
        return {}
    end
    local deltaSec = curTime - actTimeData.StartTime
    local day = GetTimeDHM2(deltaSec)
    for i = 1, #this.orderDatas do
        local data = this.orderDatas[i]
        data.Index = i
        data.AutoRefreshSecond = data.Config.RefreshTime
        data.RefreshSecond = ConfigMgr.Config.OperateConstants.OrderCDTime
        SSYXData.RefreshSingleOrderData(i, day)
    end
    return this.orderDatas
end

SSYXData.RefreshSingleOrderData = function(index, day)
    local serverDatas = SSYXData.GetOrderServerData()
    local data = this.orderDatas[index]
    local serverData = serverDatas[data.ID]
    local isUnlock, unlockDesc = SSYXData.CheckOrderGridIsUnlock(index)
    data.IsUnlock = isUnlock
    data.EndTime = 0
    if data.IsUnlock == false then
        data.UnlockDesc = unlockDesc
    end
    if serverData == nil then
        return
    end
    local allEmployeeDatas = this.employeeDatas
    local exchangeIdNum = tonumber(serverData.ExchangeId) or 1
    if day == nil then
        local curTime = LuaMgr.Timestamp()
        local actTimeData = DataExHelper.GetActivityTimeData(ActivityKey.SSYX) or {}
        local deltaSec = curTime - (actTimeData.StartTime or 0)
        day = GetTimeDHM2(deltaSec)
    end
    math.randomseed(exchangeIdNum * 10000 + day)
    local randomIndex = math.random(1, #allEmployeeDatas)
    data.CharacterID = allEmployeeDatas[randomIndex].ID
    data.TaskConfig = ConfigMgr.Config.OperateOrderTaskMap[serverData.ExchangeId]
    data.EndTime = serverData.EffectTime
    data.CanTrade = true
    data.RewardDatas = {}
    for key, value in pairs(data.TaskConfig.RequiredMaterials) do
        local haveCount = SSYXData.GetItemCountByID(value.id)
        if haveCount < value.count then
            data.CanTrade = false
            break
        end
    end
    for i = 1, #data.TaskConfig.Reward1 do
        local rewardData = data.TaskConfig.Reward1[i]
        rewardData.ID = rewardData.id
        rewardData.Count = rewardData.count
        rewardData.IsInBag = true
        table.insert(data.RewardDatas, rewardData)
    end
    for i = 1, #data.TaskConfig.Reward2 do
        local rewardData = data.TaskConfig.Reward2[i]
        rewardData.ID = rewardData.id
        rewardData.Count = rewardData.count
        rewardData.IsInBag = false
        table.insert(data.RewardDatas, rewardData)
    end
    return data
end

SSYXData.CheckOrderGridIsUnlock = function(index)
    local orderData = this.orderDatas[index]
    local unlockTips = ""
    if orderData.Config.UnlockType == 1 then
        return true, unlockTips
    elseif orderData.Config.UnlockType == 2 then
        local needBuildID = orderData.Config.UnlockParam[1]
        local needBuildLevel = orderData.Config.UnlockParam[2]
        local buildConfig = this.buildConfigDic[needBuildID]
        if buildConfig == nil then
            LuaDebug.error("SSYXData.CheckOrderGridIsUnlock 配置错误:" .. needBuildID)
            return false, unlockTips
        end
        local curLevel = buildConfig.Level
        local serverData = SSYXData.GetBuildServerData()
        if serverData ~= nil then
            curLevel = serverData.Level
        end
        local isUnlock = curLevel >= tonumber(needBuildLevel)
        if isUnlock == false then
            unlockTips = LuaMgr.GetLangText(orderData.Config.DescriptionRem)
        end
        return isUnlock, unlockTips
    elseif orderData.Config.UnlockType == 3 then
        local dungeonID = orderData.Config.UnlockParam[1]
        local isUnlock = DataHelper.CheckDungeonComplete(dungeonID)
        if isUnlock == false then
            unlockTips = LuaMgr.GetLangText(orderData.Config.DescriptionRem)
        end
        return isUnlock, unlockTips
    elseif orderData.Config.UnlockType == 4 then
        local id = orderData.Config.UnlockParam[1]
        SSYXData.RefershTechnoloyData(id)
        local techData = this.technoloyDataDic[id]
        local isUnlock = techData.IsUnlock == true
        if isUnlock == false then
            unlockTips = LuaMgr.GetLangText(orderData.Config.DescriptionRem)
        end
        return isUnlock, unlockTips
    end
    return false, unlockTips
end

SSYXData.GetOrderDataByID = function(orderID)
    SSYXData.RefreshOrderData(orderID)
    return this.orderDic[orderID]
end

SSYXData.RefreshOrderData = function(orderID)
    local orderData = this.orderDic[orderID]
    if orderData == nil then
        return
    end
end

SSYXData.GetOrderNumDatas = function()
    local dailyLikeExpLevelRewardItem = ConfigMgr.Config.OperateConstants.DailyOrderRewardsItem
    local dailyOrderNumsConfig = ConfigMgr.Config.OperateConstants.DailyOrderNums
    local datas = {}
    local curCount = DataMgr.Player.dailyCount.operateOrderFinish or 0
    local canGetCount = 0
    for i = 1, #dailyLikeExpLevelRewardItem do
        local data = {}
        data.Reward = {}
        for j = 1, #dailyLikeExpLevelRewardItem[i] do
            local rewardConfig = dailyLikeExpLevelRewardItem[i][j]
            local rewardData = {}
            rewardData.ID = rewardConfig.id
            rewardData.Count = rewardConfig.count
            rewardData.IsInBag = false
            table.insert(data.Reward, rewardData)
        end
        data.OrderCount = dailyOrderNumsConfig[i]
        data.Status = CommonRewardItem.Status.None
        if SSYXData.IsGotOrderReward(i - 1) then
            data.Status = CommonRewardItem.Status.Got
        elseif curCount >= data.OrderCount then
            data.Status = CommonRewardItem.Status.CanGet
            canGetCount = canGetCount + 1
        end
        table.insert(datas, data)
    end
    return datas, canGetCount
end

SSYXData.GetOrderNum = function()
    local config = ConfigMgr.Config.OperateConstants.DailyOrderNums
    local maxCount = config[#config]
    local curCount = DataMgr.Player.dailyCount.operateOrderFinish or 0
    return curCount, maxCount
end




SSYXData.GetRewardQuestDatas = function()
    if this.RewardQuestDatas == nil then
        this.RewardQuestDatas = DataExHelper.Check_ConfigQuestEventByText(SSYXConst.QuestEventIDName)
    end
    local quests = DataMgr.Player.quests
    local len = #this.RewardQuestDatas
    local allDatas = {}
    local totalProgress = 0
    local canGetCount = 0
    for i = 1, len do
        local questConfig = this.RewardQuestDatas[i]
        local questData = quests[questConfig.id]
        local data = {}
        data.Config = questConfig
        data.Rewards = questConfig.showReward
        data.GoalProgress = questConfig.progress

        data.Status = CommonRewardItem.Status.None
        if questData ~= nil and questData.state == 2 then
            data.Status = CommonRewardItem.Status.CanGet
        elseif questData ~= nil and questData.state == 3 then
            data.Status = CommonRewardItem.Status.Got
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
    table.sort(allDatas, SSYXData.SortRewardQuestData)
    return allDatas, canGetCount
end

SSYXData.SortRewardQuestData = function(data1, data2)
    if data1.Status == CommonRewardItem.Status.CanGet and data2.Status ~= CommonRewardItem.Status.CanGet then
        return true
    elseif data1.Status ~= CommonRewardItem.Status.CanGet and data2.Status == CommonRewardItem.Status.CanGet then
        return false
    end
    if data1.Status == CommonRewardItem.Status.Got and data2.Status ~= CommonRewardItem.Status.Got then
        return false
    elseif data1.Status ~= CommonRewardItem.Status.Got and data2.Status == CommonRewardItem.Status.Got then
        return true
    end
    return data1.Config.sort < data2.Config.sort
end



SSYXData.GetWhichDayData = function()
    local curTime = LuaMgr.Timestamp()
    local actTimeData = DataExHelper.GetActivityTimeData(ActivityKey.SSYX)
    if actTimeData.StartTime ~= nil and actTimeData.ExpireTime ~= nil and actTimeData.StartTime > curTime or actTimeData.ExpireTime < curTime then
        return {}
    end
    local deltaSec = curTime - actTimeData.StartTime
    local day, _1, _2 = GetTimeDHM2(deltaSec)
    local whichDay = day + 1
    local config = ConfigMgr.Config.OperateDailyInformationMap
    local data = {}
    if config ~= nil then
        data.Config = config[tostring(whichDay)]
        data.WhichDay = whichDay
    else
        LuaDebug.error("SSYXData.GetWhichDayData 天气数据错误")
    end
    return data
end



SSYXData.GetAllTechDatas = function()
    local unlockCount = 0
    local canLockCount = 0
    for id, data in pairs(this.technoloyDataDic) do
        SSYXData.RefershTechnoloyData(id)
        if data.IsUnlock == true then
            unlockCount = unlockCount + 1
        end
    end
    local serverData = SSYXData.GetTechServerData()
    for id, data in pairs(this.technoloyDataDic) do
        local canShow, code, lanText = SSYXData.CheckTechCanShow(id)
        if data.IsUnlock == false then
            data.CanUnlock = false
            data.CanShow = canShow
            data.UnlockDesc = lanText
            if code == SSYXConst.UnlockTipType.FullCondition then
                data.CanUnlock = true
                canLockCount = canLockCount + 1
            end
        else
            data.Level = serverData[id] or 1
            local canUpgrede, _, noUpgradeText = SSYXData.CheckTechCanUpgrade(id)
            data.CanUpgrade = canUpgrede
            data.UpgredeDesc = noUpgradeText
        end
    end
    return this.technoloyDatas, unlockCount, canLockCount
end

SSYXData.RefershTechnoloyData = function(id)
    local data = this.technoloyDataDic[id]
    if data == nil then
        LuaDebug.error("SSYXData.RefershTechnoloyData 科技树数据错误" .. id)
        return
    end
    local serverData = SSYXData.GetTechServerData()
    data.Level = serverData[id] or 1
    data.IsUnlock = serverData[id] ~= nil and true or false
end

SSYXData.CheckTechCanShow = function(id)
    local data = this.technoloyDataDic[id]
    local reason = SSYXConst.UnlockTipType
    if data == nil then
        LuaDebug.error("SSYXData.CheckTechCanUnlock 科技树数据错误" .. id)
        return false, reason
    end
    if data.Config.PrerequisitesTech == nil or #data.Config.PrerequisitesTech == 0 then
        return true, reason
    end
    local conditionTechData = this.technoloyDataDic[data.Config.PrerequisitesTech[1]]
    if conditionTechData == nil then
        LuaDebug.error("SSYXData.CheckTechCanUnlock 前置条件配置错误" .. id)
        return false
    end
    if conditionTechData.IsUnlock == false then
        return false, SSYXConst.UnlockTipType.NoFullCondition, LuaMgr.GetLangText(SSYXConst.LanText.LanText12)
    else
        local needLevel = tonumber(data.Config.PrerequisitesTech[2])
        if conditionTechData.Level < needLevel then
            local lanText = LuaMgr.GetLangText(SSYXConst.LanText.LanText16)
            local preTechName = LuaMgr.GetLangText(data.Config.NameLan)
            local text = string.format(lanText, preTechName, needLevel)
            return true, SSYXConst.UnlockTipType.NoFullCondition, text
        end
    end
    local matIsEnough = SSYXData.IsEnoughConsume(data.Config.UnlockConsumption)
    if matIsEnough == true then
        return true, SSYXConst.UnlockTipType.FullCondition
    else
        return true, SSYXConst.UnlockTipType.NotEnoughItem, LuaMgr.GetLangText(SSYXConst.LanText.LanText13)
    end
end

SSYXData.CheckTechCanUpgrade = function(id)
    local data = this.technoloyDataDic[id]
    if data == nil then
        LuaDebug.error("SSYXData.CheckTechCanUpgrade 科技树数据错误" .. id)
        return false
    end
    if data.Level >= data.Config.MaxLevel then
        return false
    end
    if data.Config.UpgradeConsumptionItem == nil or #data.Config.UpgradeConsumptionItem == 0 then
        return false
    end
    local matIsEnough = SSYXData.IsEnoughConsume(data.Config.UpgradeConsumptionItem[data.Level])
    if matIsEnough == false then
        return false, SSYXConst.UnlockTipType.NotEnoughItem, LuaMgr.GetLangText(SSYXConst.LanText.LanText14)
    end
    return true
end

SSYXData.GetTechUnlockConsume = function(id)
    local techData = this.technoloyDataDic[id]
    local datas = {}
    if techData == nil then
        LuaDebug.error("SSYXData.GetTechUpgradeCosume 科技树数据错误" .. id)
        return datas, false
    end
    if techData.IsUnlock == true then
        return datas, false
    end
    local matConfig = techData.Config.UnlockConsumption
    for i = 1, #matConfig do
        local data = {}
        data.ID = matConfig[i].id
        data.Count = matConfig[i].count
        data.IsInBag = true
        data.OwnerCount = DataHelper.GetItemCountById(data.ID)
        table.insert(datas, data)
    end
    return datas, true
end

SSYXData.GetTechUpgradeConsume = function(id)
    local techData = this.technoloyDataDic[id]
    local datas = {}
    if techData == nil then
        LuaDebug.error("SSYXData.GetTechUpgradeCosume 科技树数据错误" .. id)
        return datas, false
    end
    if techData.Level > techData.Config.MaxLevel then
        return datas, false
    end
    local matConfig = techData.Config.UpgradeConsumptionItem[techData.Level] or {}
    for i = 1, #matConfig do
        local data = {}
        data.ID = matConfig[i].id
        data.Count = matConfig[i].count
        data.IsInBag = true
        data.OwnerCount = DataHelper.GetItemCountById(data.ID)
        table.insert(datas, data)
    end
    return datas, true
end

SSYXData.CheckTechIsUnlock = function(id)
    SSYXData.RefershTechnoloyData(id)
    local techData = this.technoloyDataDic[id]
    return techData.IsUnlock == true
end

SSYXData.GetTechSubConsumeCount = function(baseCount)
    if SSYXData.CheckTechIsUnlock(SSYXConst.TechID.ConsumeSub) == false then
        return 0
    end
    local techData = this.technoloyDataDic[SSYXConst.TechID.ConsumeSub]
    local parameter = techData.Config.Parameter[techData.Level or 0]
    if parameter == nil then
        return 0
    end
    return math.floor(baseCount * parameter / 10000)
end




SSYXData.GetPreviewDataByLevel = function(level, index)
    local rewardConfig = ConfigMgr.Config.OperateDailyRewardMap[tostring(level)]
    if type(rewardConfig) ~= "table" then
        return nil
    end
    local id = ""
    local count = 0
    local name = ""
    if index == 1 then
        id = rewardConfig.Reward1[1].id
        count = rewardConfig.Reward1[1].count
        name = LuaMgr.GetLangText(ConfigMgr.Config.itemMap[id].nameLan)
    elseif index == 2 then
        if type(rewardConfig.Reward2) == "table" then
            id = rewardConfig.Reward2[1].id
            count = rewardConfig.Reward2[1].count
            local itemConfig = SSYXData.GetItemConfig(id)
            if itemConfig == nil then
                LuaDebug.error("SSYXData.GetPreviewDataByLevel 奖励道具配置错误")
                return nil
            end
            name = LuaMgr.GetLangText(itemConfig.NameLan)
        else
            return nil
        end
    else
        if type(rewardConfig.DropID) == "number" and rewardConfig.DropID ~= 0 then
            id = rewardConfig.Reward1[1].id
            count = 1
            name = LuaMgr.GetLangText(ConfigMgr.Config.itemMap[id].nameLan)
        else
            return nil
        end
    end
    local minutes = rewardConfig.HangingTime / 60
    local data = {}
    data.Name = name
    data.UnitOut = count
    data.HangingTime = rewardConfig.HangingTime
    return data
end

SSYXData.GetItemConfig = function(id)
    local configs = ConfigMgr.Config.OperateItemMap
    return configs[id]
end








SSYXData.UseItem = function(id, useTyp, count, typ, extraID, callback)
    local onSucc = function(result)
        local res = json.decode(result)
        if res.code ~= nil and res.code ~= 0 then
            LuaDebug.error("SSYXData.UseItem 请求错误:" .. res.code)
            return
        end
        if callback then
            callback()
        end
    end
    local data = {}
    data.UseTyp = useTyp
    data.Id = id
    data.Count = count
    data.Typ = typ
    data.ExtraId = extraID
    ApiMgr.Request("operateBuild/useTool", data, true, onSucc, nil, true)
end




SSYXData.GetShopDatas = function()
    if this.QuestCelebrationRecharge == nil then
        this.QuestCelebrationRecharge = DataExHelper.Check_ConfigQuestEventByText(SSYXConst.ShopEventIDName)
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

SSYXData.GetAllNovelDatas = function()
    if this.NovelConfigs == nil then
        this.NovelConfigs = DataExHelper.EX_GetEventListByArea(SSYXConst.EventType.Novel)
    end
    local allDatas = {}
    for i = 1, #this.NovelConfigs do
        local data = this.NovelConfigs[i]
        if SSYXData.CheckFinish(data) == true then
            data.Status = CommonRewardItem.Status.Got
        else
            local isUnlock, unlockDesc = SSYXData.CheckUnlock(data)
            if isUnlock == true then
                data.Status = CommonRewardItem.Status.None
            else
                data.Status = CommonRewardItem.Status.Lock
                data.UnlockDesc = unlockDesc
            end
        end
        data.Name = LuaMgr.GetLangText(data.namelan)
        table.insert(allDatas, data)
    end
    return allDatas
end

SSYXData.GetDungeonDatas = function(dungeonType)
    local configs = this.mapEventGroup[dungeonType]
    local datas = {}
    for i = 1, #configs do
        local data = configs[i]
        data.Index = i
        data.IsFirst = i == 1
        data.IsLast = i == #configs
        data.DungeonType = dungeonType
        if SSYXData.CheckFinish(data) == true then
            data.Status = CommonRewardItem.Status.Got
        else
            local isUnlock, unlockDesc = SSYXData.CheckUnlock(data)
            if isUnlock == true then
                data.Status = CommonRewardItem.Status.None
            else
                data.Status = CommonRewardItem.Status.Lock
                data.UnlockDesc = unlockDesc
            end
        end
        table.insert(datas, data)
    end
    return datas
end

SSYXData.SetDungeonPage = function(index)
    this.dungeonPage = index
end

SSYXData.GetDungeonPage = function()
    return this.dungeonPage or 1
end

SSYXData.SetTempDungeonData = function(pageIndex, data)
    if this.tempDungeonData == nil then
        this.tempDungeonData = {}
    end
    this.tempDungeonData[pageIndex] = data
end

SSYXData.GetTempDungeonData = function(pageIndex)
    if this.tempDungeonData == nil then
        return nil
    end
    return this.tempDungeonData[pageIndex]
end

SSYXData.CheckFinish = function(config)
    local isFinish = false
    if config.type == SSYXConst.PassNumType.Repeat or config.type == SSYXConst.PassNumType.MainLine or config.type == SSYXConst.PassNumType.Hard then
        local record = DataMgr.Player.dungeonRecords[config.eventParam]
        if (record ~= nil and record.completeCount > 0) then
            isFinish = true
        end
    elseif config.type == SSYXConst.PassNumType.Novel then
        isFinish = DataHelper.CheckNovelComplete(config.eventParam)
    else
        local rewardData = SSYXData.GetMiniGameData(config.eventParam)
        if rewardData ~= nil and rewardData > 0 then
            isFinish = true
        end
    end
    return isFinish
end

SSYXData.CheckUnlock = function(config)
    if config.unlockParam == nil or config.unlockParam == "" then
        return true
    end
    if this.mapEventConfigDic == nil then
        this.mapEventConfigDic = DataExHelper.GetActivityMapEventMap()
    end
    local isUnlock = false
    local unlockText = ""
    if config.type == SSYXConst.PassNumType.Repeat or config.type == SSYXConst.PassNumType.MainLine or config.type == SSYXConst.PassNumType.Hard then
        local unlockConfig = this.mapEventConfigDic[config.unlockParam]
        isUnlock = DataHelper.CheckDungeonComplete(unlockConfig.eventParam)
        if isUnlock == false then
            local unlockConfig = this.mapEventConfigDic[config.unlockParam]
            local lanText = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30036")
            local name = LuaMgr.GetLangText(unlockConfig.namelan)
            unlockText = string.format(lanText, name)
        end
    elseif config.type == SSYXConst.PassNumType.Novel then
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



SSYXData.RefreshVisitRoleList = function(callBack)
    if SSYXData.CheckActivityRunning() == false then
        return
    end
    local onSucc = function(result)
        local res = json.decode(result)
        if res.code ~= nil and res.code ~= 0 then
            return
        end
        local visits = res.result.Visits
        this.allVisitList = {}
        this.allVisitDic = {}
        this.visitRecordDatas = res.result.VisitRecords
        for key, value in pairs(visits) do
            table.insert(this.allVisitList, value)
            this.allVisitDic[value.Uid] = value
        end
        if callBack then
            callBack()
        end
    end
    local data = {}
    ApiMgr.Request("operateBuild/visitList", data, true, onSucc, nil, true)
end

SSYXData.GetAllVisitList = function()
    return this.allVisitList
end

SSYXData.GetAllVisitRecordList = function()
    return this.visitRecordDatas
end

SSYXData.GetRoleBaseData = function(uid)
    local data = {}
    if uid == DataMgr.Player.uid then
        data.Uid = DataMgr.Player.uid
        data.Name = DataMgr.Player.name
        data.Avatar = DataMgr.Player.Avatar
        data.AvatarFrame = DataMgr.Player.currentAvatarFrame
        data.Level = DataMgr.Player.OperateBuild.Level
        data.Exp = DataMgr.Player.OperateBuild.Exp
        data.TreeExp = DataMgr.Player.OperateBuild.Tree.TreeExp
        local avatarTexture, imgTye = SSYXData.GetPlayerAvatar(data.Avatar)
        data.AvatarTexture = avatarTexture
        data.ImgType = imgTye
    else
        data = this.allVisitDic[uid]
        local avatarTexture, imgTye = SSYXData.GetPlayerAvatar(data.Avatar)
        data.AvatarTexture = avatarTexture
        data.ImgType = imgTye
    end

    local config = ConfigMgr.Config.OperateBusinessLevelMap[tostring(data.Level)]
    if (config.Exp == nil or config.Exp == 0) and data.Level > 0 then
        data.MaxExp = ConfigMgr.Config.OperateBusinessLevelMap[tostring(data.Level - 1)]
        data.IsMaxLevel = true
    else
        data.MaxExp = config.Exp
        data.IsMaxLevel = false
    end
    return data
end

SSYXData.GetPlayerFrame = function(avatarFrameID)
    local frameConfig = this.avatarFramesConfigDic[avatarFrameID]
    if frameConfig == nil then
        return nil
    end
    return frameConfig.id
end

SSYXData.GetPlayerAvatar = function(avatarID)
    local avatarConfig = this.avatarFramesConfigDic[avatarID]
    if avatarConfig == nil then
        return nil
    end
    local avatarPath = ConfigHelper.GetHeadIconPath(avatarConfig.img, avatarConfig.imgId)
    return LuaMgr.GetTexture(avatarPath), avatarConfig.imgType
end

SSYXData.GetItemCountByID = function(id)
    local allTools = DataMgr.Player.OperateBuild.Tools or {}
    return allTools[id] or 0
end

SSYXData.GetOrderServerData = function()
    return DataMgr.Player.OperateOrders.Orders or {}
end

SSYXData.IsGotOrderReward = function(orderID)
    local rewardData = type(DataMgr.Player.OperateOrders.Rewards) == "table" and DataMgr.Player.OperateOrders.Rewards or {}
    return rewardData[tostring(orderID)] ~= nil
end

SSYXData.GetTechServerData = function()
    return DataMgr.Player.OperateBuild.TechTree or {}
end





SSYXData.CheckRed = function()
    if SSYXData.CheckActivityRunning() == false then
        return 0
    end
    local redNum1 = SSYXData.GetDungeonRedPoint()
    RedMgr.Singleton:UpdateClientRedData(tostring(SSYXConst.RedPoint.HardDungeon), redNum1)

    local rewardRed, taskRed = HeroRedDataHelper.GetPassesRed()
    local redNum2 = rewardRed + taskRed
    RedMgr.Singleton:UpdateClientRedData(SSYXConst.RedPoint.Pass, redNum2)

    local redNum3 = SSYXData.CheckGameRedPoint()
    RedMgr.Singleton:UpdateClientRedData(SSYXConst.RedPoint.GameMain, redNum3)

    local teamTowerRed = HeroRedDataHelper.CheckTeamTowerRed()
    return redNum1 + redNum2 + redNum3 + teamTowerRed
end


SSYXData.SetDungeonRedPoint = function(count)
    this.dungeonRedPoint = count
    local redID = tostring(SSYXConst.RedPoint.HardDungeon)
    if this.dungeonRedPoint > 0 then
        RedMgr.Singleton:UpdateClientRedData(redID, 1)
        RedMgr.Singleton:SetRedState(redID, 1)
    else
        RedMgr.Singleton:UpdateClientRedData(redID, 0)
        RedMgr.Singleton:FrushRedCondition(redID)
    end
end

SSYXData.GetDungeonRedPoint = function(allDatas)
    if allDatas == nil then
        allDatas = SSYXData.GetDungeonDatas(SSYXConst.EventType.Hard)
    end
    local redCount = 0
    for key, data in pairs(allDatas) do
        local dungeonTypeIndex = SSYXConst.EventTypeMapIndex[data.DungeonType]
        local redID = string.format("%d_%d", SSYXConst.RedPoint.HardDungeon, dungeonTypeIndex * 100 + data.Index)
        if RedMgr.Singleton:CheckRedCondition(redID) and data.Status == CommonRewardItem.Status.None then
            redCount = redCount + 1
        end
    end
    return redCount
end


SSYXData.CheckGameRedPoint = function()
    local redNum1 = SSYXData.GetAllCanCreateRedPoint()
    RedMgr.Singleton:UpdateClientRedData(SSYXConst.RedPoint.GameBuild, redNum1)

    local redNum2 = SSYXData.CheckBankRedPoint()
    local redNum3 = SSYXData.CheckShopRedPoint()
    local redNum4 = SSYXData.CheckTechRedPoint()
    local redNum5 = SSYXData.CheckRewardRedPoint()
    local redNum6 = SSYXData.CheckProduceBuildRedPoint()
    LuaDebug.error("1565===========" .. redNum1 .. "|" .. redNum2 .. "|" .. redNum3 .. "|" .. redNum4 .. "|" .. redNum5 .. "|" .. redNum6)
    return redNum1 + redNum2 + redNum3 + redNum4 + redNum5 + redNum6
end

SSYXData.GetAllCanCreateRedPoint = function()
    local totalCanCreateCount = 0
    for i = 1, 2 do
        local _, _, canCreateCount = SSYXData.GetAllBuildData(i)
        local redID = string.format("%s_%d", SSYXConst.RedPoint.GameBuild, i)
        local redCount = canCreateCount > 0 and 1 or 0
        RedMgr.Singleton:UpdateClientRedData(redID, redCount)
        totalCanCreateCount = totalCanCreateCount + canCreateCount
    end
    RedMgr.Singleton:UpdateClientRedData(SSYXConst.RedPoint.GameBuild, totalCanCreateCount)
    return totalCanCreateCount
end

SSYXData.CheckBankRedPoint = function()
    local buildData = SSYXData.GetBuildDataByID(SSYXConst.BuildID.YinHang)
    if buildData.IsCreated ~= true then
        return 0
    end
    local curTime = LuaMgr.Timestamp()
    local deltaTime = curTime - (buildData.ServerData.IdleTime or 0)
    local maxTime = ConfigMgr.Config.OperateConstants.DailyIdleReminderTime
    return deltaTime > maxTime and 1 or 0
end

SSYXData.CheckShopRedPoint = function()
    local _, canGetCount = SSYXData.GetOrderNumDatas()
    return canGetCount > 0 and 1 or 0
end


SSYXData.CheckTechRedPoint = function()

    return 0
end

SSYXData.CheckRewardRedPoint = function()
    local _, canGetCount = SSYXData.GetRewardQuestDatas()
    return canGetCount > 0 and 1 or 0
end

SSYXData.CheckProduceBuildRedPoint = function()
    local existCanGetReward = false
    local buildDatas = SSYXData.GetAllBuildData(2)
    for key, buildData in pairs(buildDatas) do
        if SSYXData.CheckProduceSingleBuildRedPoint(buildData) > 0 then
            existCanGetReward = true
            break
        end
    end
    return existCanGetReward == true and 1 or 0
end

SSYXData.CheckProduceSingleBuildRedPoint = function(buildData)
    local existCanGetReward = false
    local curTime = LuaMgr.Timestamp()
    local makingIndex = buildData.ServerData.ProduceChoose or 0
    local produceCount = buildData.ServerData.ProduceCount or 0
    if produceCount > 0 then
        local allProductDatas = SSYXData.GetProductDatas(buildData.ID)
        local makingData = allProductDatas[makingIndex + 1]

        local produceTime = buildData.ServerData.ProduceTime or 0
        local remainProductTime = makingData.OutputTime * (buildData.ServerData.ProduceCount - 1)
        remainProductTime = math.max(remainProductTime, 0)
        local extraCdAdd = buildData.ServerData.ExtraCdAdd ~= nil and buildData.ServerData.ExtraCdAdd / 10000 or 0
        local singleSubTime = math.floor(makingData.OutputTime * extraCdAdd)
        local totalSubTime = buildData.ServerData.ProduceCount * singleSubTime
        local remainTime = makingData.OutputTime + buildData.ServerData.ProduceTime - curTime + remainProductTime - totalSubTime

        if produceTime > 0 and remainTime < 0 then
            existCanGetReward = true
        end
    end
    return existCanGetReward == true and 1 or 0
end


