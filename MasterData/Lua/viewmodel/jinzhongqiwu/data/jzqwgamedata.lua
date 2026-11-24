require("ViewModel/JinZhongQiWu/Data/JZQWGameChapter")
require("ViewModel/JinZhongQiWu/Data/JZQWGameActivateObjData")
require("ViewModel/JinZhongQiWu/Data/JZQWGameProps")
require("ViewModel/JinZhongQiWu/Data/JZQWGameEvent")
JZQWGameData = {}

local this = {

    chapterDatas = {},

    chapterDataDic = {},
    sceneDataDic = {},
    sceneDatas = {},

    activateSceneObjs = {},

    activateSceneObjDic = {},

    propsDataDic = {},

    eventDataDic = {}
}

JZQWGameData.InitData = function()
    this.chapterDatas = {}
    this.chapterDataDic = {}
    this.sceneDatas = {}
    this.sceneDataDic = {}
    this.activateSceneObjs = {}
    this.activateSceneObjDic = {}
    this.propsDataDic = {}
    this.eventDataDic = {}
    this.curOperateProps = nil
    local eventConfigs = ConfigMgr.Config.AdventureEventMap
    local chapterEvent = {}
    for id, config in pairs(eventConfigs) do
        local data = JZQWGameEvent.New()
        data.ID = id
        data.Config = config
        data.Status = JZQWConst.EventStatus.None
        local chapterID = config.ChapterID
        if chapterEvent[chapterID] == nil then
            chapterEvent[chapterID] = {}
        end
        table.insert(chapterEvent[chapterID], data)
        this.eventDataDic[id] = data
    end
    local chapterConfigs = ConfigMgr.Config.AdventureChapterMap
    for id, config in pairs(chapterConfigs) do
        local data = JZQWGameChapter.New()
        data.ID = id
        data.Config = config
        data.EventList = chapterEvent[id]
        data.LastEvent = this.eventDataDic[config.AdventureEventID]
        if data.EventList then
            table.sort(data.EventList, JZQWGameData.SortByID)
        end
        table.insert(this.chapterDatas, data)
        this.chapterDataDic[id] = data
    end

    local sceneConfigs = ConfigMgr.Config.AdventureSenceMap
    for id, config in pairs(sceneConfigs) do
        local data = {}
        data.ID = id
        data.Config = config
        data.IsUnlock = false
        data.Status = JZQWConst.SceneStatus.None
        this.sceneDataDic[id] = data
        table.insert(this.sceneDatas, #this.sceneDatas + 1, data)
    end
    table.sort(this.sceneDatas, JZQWGameData.SortByOrder)

    local activateConfigs = ConfigMgr.Config.AdventureObjectsMap
    this.activateSceneObjs = {}
    for id, config in pairs(activateConfigs) do
        local senceID = config.SenceId
        if this.activateSceneObjDic[senceID] == nil then
            this.activateSceneObjDic[senceID] = {}
        end
        if this.activateSceneObjs[senceID] == nil then
            this.activateSceneObjs[senceID] = {}
        end
        local data = JZQWGameActivateObjData.New()
        data.ID = id
        data.IDNum = tonumber(id) or 0
        data.Config = config

        this.activateSceneObjDic[senceID][id] = data
        table.insert(this.activateSceneObjs[senceID], data)
    end

    local propsConfigs = ConfigMgr.Config.AdventureItemMap
    for id, config in pairs(propsConfigs) do
        local data = JZQWGameProps.New()
        data.ID = id
        data.Config = config
        data.IsOwner = false
        this.propsDataDic[id] = data
    end

    local recipesConfigs = ConfigMgr.Config.AdventureItemRecipesMap
    for id, config in pairs(recipesConfigs) do
        if tonumber(config.Type) == JZQWConst.CombineType.Props then
            local propsAID = config.ItemAId[1].id
            local propsBID = config.ItemBId[1].id

            local propsDataA = this.propsDataDic[propsAID]
            local propsData = {}
            propsData.ActivateType = config.Type
            propsData.ActivateID = propsBID
            propsData.IsClearA = config.ConsumedA == 1
            propsData.IsClearB = config.ConsumedB == 1
            propsData.OutputPropsID = config.OutputItem[1].id
            propsDataA.CanCombine = true
            propsDataA.ActivateObjs[propsBID] = propsData

            local propsDataB = this.propsDataDic[propsBID]
            local propsData = {}
            propsData.ActivateType = config.Type
            propsData.ActivateID = propsAID
            propsData.IsClearA = config.ConsumedA == 1
            propsData.IsClearB = config.ConsumedB == 1
            propsData.OutputPropsID = config.OutputItem[1].id
            propsDataB.CanCombine = true
            propsDataB.ActivateObjs[propsAID] = propsData
        elseif config.Type == JZQWConst.CombineType.Obj then
            local propsAID = config.ItemAId[1].id
            local propsDataA = this.propsDataDic[propsAID]
            local propsData = {}
            propsData.ActivateType = config.Type
            propsData.ActivateID = config.ObjectId
            propsData.OutputPropsID = config.OutputItem[1].id
            propsData.ChangeObjStatus = tonumber(config.ChangeC) or 0
            propsData.IsChangeObjStatus = propsData.ChangeObjStatus == -1
            propsDataA.ActivateObjs[propsData.ActivateID] = propsData
        end
    end
    JZQWConst.RoleMoveSpeed = ConfigMgr.Config.constants.AdventureRoleMoveSpeed
    JZQWConst.TipsWaitTime = ConfigMgr.Config.constants.AdventureTipsWaitSecond
    JZQWConst.ChapterJumpWaitTime = ConfigMgr.Config.constants.AdventureSkipWaitSecond
    if type(JZQWConst.RoleMoveSpeed) ~= "number" or JZQWConst.RoleMoveSpeed == 0 then
        JZQWConst.RoleMoveSpeed = 150
    end
    if type(JZQWConst.TipsWaitTime) ~= "number" or JZQWConst.TipsWaitTime == 0 then
        JZQWConst.TipsWaitTime = 10
    end
    if type(JZQWConst.ChapterJumpWaitTime) ~= "number" or JZQWConst.ChapterJumpWaitTime <= 0 then
        JZQWConst.ChapterJumpWaitTime = 60
    end
end

JZQWGameData.SortByID = function(data1, data2)
    return tonumber(data1.ID) < tonumber(data2.ID)
end

JZQWGameData.SortByOrder = function(data1, data2)
    return data1.Config.Order < data2.Config.Order
end

JZQWGameData.GetAllChapterDatas = function()
    for i = 1, #this.chapterDatas do
        local chapterData = this.chapterDatas[i]
        JZQWGameData.RefreshChapterData(chapterData.ID)
    end
    table.sort(this.chapterDatas, JZQWGameData.SortByOrder)
    return this.chapterDatas
end

JZQWGameData.GetChapterData = function(id)
    if id == nil then
        if type(DataMgr.Player.Adventure.ChapterId) == "string" and DataMgr.Player.Adventure.ChapterId ~= "" then
            id = DataMgr.Player.Adventure.ChapterId
        else
            id = JZQWConst.FirstChapter
        end
    end
    JZQWGameData.RefreshChapterData(id)
    return this.chapterDataDic[id]
end




JZQWGameData.GetEventDataByID = function(eventID)
    if type(eventID) == "nil" or eventID == "" then
        return nil
    end
    local chapterID = nil
    if type(DataMgr.Player.Adventure.ChapterId) == "string" and DataMgr.Player.Adventure.ChapterId ~= "" then
        chapterID = DataMgr.Player.Adventure.ChapterId
    else
        chapterID = JZQWConst.FirstChapter
    end
    local eventData = this.eventDataDic[eventID]
    if eventData == nil then
        return nil
    end
    JZQWGameData.RefreshEventData(chapterID, eventData)
    return eventData
end




JZQWGameData.GetEventByFinishItemID = function(id)
    local curChapterData = JZQWGameData.GetChapterData()
    local eventList = curChapterData.EventList
    for key, eventData in pairs(eventList) do
        JZQWGameData.RefreshEventData(curChapterData.ID, eventData)
        if type(eventData.Config.CompleteItem) == "table" then
            for i = 1, #eventData.Config.CompleteItem do
                local item = eventData.Config.CompleteItem[i]
                if item ~= nil and item.id == id then
                    return eventData
                end
            end
        end
    end
    return nil
end

JZQWGameData.CheckEventUnlockByItemID = function(id)
    local curChapterData = JZQWGameData.GetChapterData()
    local eventList = curChapterData.EventList
    local findeEventData = nil
    for key, eventData in pairs(eventList) do
        JZQWGameData.RefreshEventData(curChapterData.ID, eventData)
        local isFindEvent = false
        if type(eventData.Config.CompleteItem) == "table" then
            for i = 1, #eventData.Config.CompleteItem do
                local item = eventData.Config.CompleteItem[i]
                if item ~= nil and item.id == id then
                    isFindEvent = true
                    break
                end
            end
        end
        if isFindEvent == true then
            findeEventData = eventData
        end
    end
    if findeEventData == nil or findeEventData.Status ~= JZQWConst.EventStatus.Unlock then
        return false
    end
    return true
end

JZQWGameData.GetChapterGoal = function()
    local chapterData = JZQWGameData.GetChapterData()
    local allDatas = {}
    for i = 1, #chapterData.EventList do
        local eventData = chapterData.EventList[i]
        if eventData.Status == JZQWConst.EventStatus.Unlock then
            table.insert(allDatas, eventData)
        end
    end
    return allDatas
end

JZQWGameData.GetAllSceneDatas = function()
    local lastUnlockSceneData = nil
    local curChapterData = JZQWGameData.GetChapterData()
    local curTime = LuaMgr.Timestamp()
    for i = 1, #this.sceneDatas do
        local sceneData = this.sceneDatas[i]
        local id = sceneData.ID
        JZQWGameData.RefreshSceneData(id)
        sceneData.Status = sceneData.IsUnlock == true and JZQWConst.SceneStatus.Unlock or JZQWConst.SceneStatus.None
        if sceneData.IsUnlock == true then
            lastUnlockSceneData = sceneData
        end
        local isCurChapterScene = JZQWGameData.IsCurChapterScene(id)
        sceneData.CanIntro = true
        sceneData.UnlockTipsLan = ""
        if sceneData.Status == JZQWConst.SceneStatus.Unlock and isCurChapterScene == true and curChapterData ~= nil then
            sceneData.Status = JZQWConst.SceneStatus.UnlockShow
            local unlockTime = 0
            if type(curChapterData.Config.UnlockTime) == "number" then
                unlockTime = curChapterData.Config.UnlockTime
            end
            if curTime >= unlockTime then
                sceneData.CanIntro = true
            else
                sceneData.UnlockTime = unlockTime
                sceneData.CanIntro = false
                sceneData.UnlockTipsLan = JZQWConst.TextLan.TextLan9
            end
        else
            if curChapterData ~= nil and curChapterData.Config.NextChapter == "" and curChapterData.Status == JZQWConst.ChapterStatus.Finish then
                sceneData.Status = JZQWConst.SceneStatus.UnlockShow
            end
        end
    end
    for key, value in pairs(this.sceneDatas) do
        if curChapterData ~= nil and curChapterData.Config.NextChapter == "" and curChapterData.Status == JZQWConst.ChapterStatus.Finish then
            value.Status = JZQWConst.SceneStatus.None
        end
    end

    return this.sceneDatas, lastUnlockSceneData
end

JZQWGameData.IsCurChapterScene = function(sceneID)
    local curChapterData = JZQWGameData.GetChapterData()
    if curChapterData == nil then
        return false
    end
    local curChapterNpcID = curChapterData.Config.NpcId
    local npcConfig = ConfigMgr.Config.AdventureObjectsMap[curChapterNpcID]
    if npcConfig.SenceId == sceneID then
        return true
    end
    return false
end

JZQWGameData.GetSceneData = function(id)
    JZQWGameData.RefreshSceneData(id)
    return this.sceneDataDic[id]
end

JZQWGameData.RefreshChapterData = function(id)
    local chapterData = this.chapterDataDic[id]
    local serverData = DataMgr.Player.Adventure or {}
    local chapterServerDataMap = serverData.Chapters or {}
    local chapterStatus = chapterServerDataMap[id]
    if chapterStatus ~= nil then
        chapterData.Status = JZQWConst.ChapterStatus.None
        if chapterStatus == 0 then
            chapterData.Status = JZQWConst.ChapterStatus.Unlock
        elseif chapterStatus == 1 then
            chapterData.Status = JZQWConst.ChapterStatus.Finish
        end
    end
    if type(chapterData.EventList) == "table" then
        for key, value in pairs(chapterData.EventList) do
            JZQWGameData.RefreshEventData(id, value)
        end
    end
end

JZQWGameData.IsEventPreEventsFinish = function(chapterData, eventID)
    if chapterData == nil or type(chapterData.EventList) ~= "table" then
        return true
    end
    local hasPreEvent = false
    for i = 1, #chapterData.EventList do
        local eventData = chapterData.EventList[i]
        local nextEvents = eventData.Config.NextEvent
        if type(nextEvents) == "table" then
            for j = 1, #nextEvents do
                if nextEvents[j] == eventID then
                    hasPreEvent = true
                    if eventData.Status ~= JZQWConst.EventStatus.Finish then
                        return false
                    end
                end
            end
        end
    end
    return hasPreEvent
end

JZQWGameData.RefreshEventData = function(chapterID, eventData)
    if eventData == nil then
        return
    end
    local chapterData = this.chapterDataDic[chapterID]
    local serverData = DataMgr.Player.Adventure or {}
    local eventServerDataMap = serverData.EventIds or {}
    local eventID = eventData.ID
    local eventStatus = eventServerDataMap[eventID]
    if eventStatus == 0 then
        eventData.Status = JZQWConst.EventStatus.Unlock
    elseif eventStatus == 1 then
        eventData.Status = JZQWConst.EventStatus.Finish
    end
    if eventData.Status == JZQWConst.EventStatus.None and (type(eventData.Config.TriggerItem) ~= "table" or #eventData.Config.TriggerItem <= 0) then
        eventData.Status = JZQWConst.EventStatus.Unlock
    end
    if eventData.Status == JZQWConst.EventStatus.None and type(eventData.Config.TriggerItem) == "table" and JZQWGameData.IsEventPreEventsFinish(chapterData, eventID) == true then
        local isUnlock = true
        for key, value in pairs(eventData.Config.TriggerItem) do
            local propsData = JZQWGameData.GetPropsDataByID(value.id)
            if propsData and propsData.IsOwner == false then
                isUnlock = false
                break
            end
        end
        if isUnlock == true then
            eventData.Status = JZQWConst.EventStatus.Unlock
        end
    end
    if chapterData.LastEvent.ID == eventID then
        chapterData.LastEvent.Status = eventData.Status
    end
end

JZQWGameData.RefreshSceneData = function(id)
    local data = this.sceneDataDic[id]
    local serverData = DataMgr.Player.Adventure or {}
    local eventServerDataMap = serverData.EventIds or {}
    if type(data.Config.UnlockEvent) == "string" and data.Config.UnlockEvent == "" then
        data.IsUnlock = true
    else
        data.IsUnlock = eventServerDataMap[data.Config.UnlockEvent] ~= nil
    end
end




JZQWGameData.GetSceneActivateObjs = function(sceneID)
    local sceneObjDatas = this.activateSceneObjs[sceneID]
    if sceneObjDatas == nil then
        return {}
    end
    for key, value in pairs(sceneObjDatas) do
        JZQWGameData.RefreshSceneObj(sceneID, value.ID)
    end

    local sceneObjDic = this.activateSceneObjDic[sceneID]
    local curChapterData = JZQWGameData.GetChapterData()
    if type(curChapterData.Config.ObjList) == "table" then
        local datas = {}
        for index = 1, #curChapterData.Config.ObjList do
            local objID = curChapterData.Config.ObjList[index]
            if sceneObjDic[objID] then
                table.insert(datas, sceneObjDic[objID])
            end
        end
        return datas
    else
        return sceneObjDatas
    end
end





JZQWGameData.GetSceneActivateObj = function(sceneID, objID)
    local sceneObjDatas = this.activateSceneObjDic[sceneID]
    if sceneObjDatas == nil or objID == nil then
        return nil
    end
    local objData = sceneObjDatas[objID]
    JZQWGameData.RefreshSceneObj(sceneID, objID)
    return objData
end

JZQWGameData.RefreshSceneObj = function(sceneID, objID)
    local serverDatas = DataMgr.Player.Adventure.NpcIds or {}
    local serverState = serverDatas[objID]
    local sceneObjDatas = this.activateSceneObjDic[sceneID]
    if serverState ~= nil and sceneObjDatas ~= nil then
        local objData = sceneObjDatas[objID]
        objData:SetStatus(serverState)
        objData:Refresh()
    end
end

JZQWGameData.GetGameNovelData = function(id)
    id = id or "1"
    local serverDatas = DataMgr.Player.Adventure.StoryIds or {}
    if serverDatas[id] == nil then
        return ConfigMgr.Config.AdventureManifestoMap[id]
    end
    return nil
end



JZQWGameData.GetAllPropsData = function()
    local ownerPorps = DataMgr.Player.Adventure.Tools or {}
    local datas = {}
    for key, propsData in pairs(this.propsDataDic) do
        local serverData = ownerPorps[propsData.ID]
        if serverData ~= nil and serverData > 0 and propsData.Config.Type == 1 then
            propsData.IsOwner = true
            table.insert(datas, propsData)
        else
            propsData.IsOwner = false
        end
    end
    return datas
end

JZQWGameData.GetRecipesInAndOutProps = function(recipesID)
    local recipesConfig = ConfigMgr.Config.AdventureItemRecipesMap[recipesID]
    local outputProps = {}
    local consumeProps = {}
    for key, value in pairs(recipesConfig.OutputItem) do
        outputProps[value.id] = 1
    end
    if recipesConfig.ConsumedA == 1 then
        consumeProps[recipesConfig.ItemAId[1].id] = 1
    end

    if recipesConfig.ConsumedB == 1 then
        consumeProps[recipesConfig.ItemBId[1].id] = 1
    end
    return outputProps, consumeProps, tonumber(recipesConfig.ChangeC) or 0
end





JZQWGameData.GetCombineInAndOutProps = function(id1, id2, objType)
    if id1 == nil or id2 == nil then
        LuaDebug.error("JZQWGameData.GetCombineInAndOutPropsBy 数据异常")
        return nil, nil
    end
    local configs = ConfigMgr.Config.AdventureItemRecipesMap
    local outputProps = nil
    local consumeProps = nil
    for key, config in pairs(configs) do
        local propsAID = nil
        if type(config.ItemAId) == "table" then
            propsAID = config.ItemAId[1].id
        end
        local propsBID = nil
        if type(config.ItemBId) == "table" then
            propsBID = config.ItemBId[1].id
        end
        if (id1 == propsAID and id2 == propsBID) or (id1 == propsBID and id2 == propsAID) then
            if outputProps == nil then
                outputProps = {}
            end
            if consumeProps == nil then
                consumeProps = {}
            end
            for key, outputConfig in pairs(config.OutputItem) do
                outputProps[outputConfig.id] = 1
            end
            if propsAID ~= nil and config.ConsumedA == 1 then
                consumeProps[propsAID] = 1
            end

            if propsBID ~= nil and config.ConsumedB == 1 then
                consumeProps[propsBID] = 1
            end
            break
        end
    end
    return outputProps, consumeProps
end

JZQWGameData.SetPropsDataByID = function(id, isOwner)
    local propsData = this.propsDataDic[id]
    if propsData ~= nil then
        propsData.IsOwner = isOwner
    end
end

JZQWGameData.GetPropsDataByID = function(id)
    local ownerPorps = DataMgr.Player.Adventure.Tools or {}
    local serverData = ownerPorps[id]
    local propsData = this.propsDataDic[id]
    if propsData == nil then
        return nil
    end
    if serverData ~= nil and serverData > 0 then
        propsData.IsOwner = true
    else
        propsData.IsOwner = false
    end
    return this.propsDataDic[id]
end

JZQWGameData.IsEventCompleteByOutputItems = function(eventData, outputItems)
    if eventData == nil or eventData.Config == nil or type(eventData.Config.CompleteItem) ~= "table" or type(outputItems) ~= "table" then
        return false
    end
    for i = 1, #eventData.Config.CompleteItem do
        local item = eventData.Config.CompleteItem[i]
        if item ~= nil and outputItems[item.id] ~= nil then
            return true
        end
    end
    return false
end

JZQWGameData.GetUnfinishedTriggerEventByItems = function(itemMap, outputItems)
    if type(itemMap) ~= "table" then
        return nil, nil
    end
    local chapterData = JZQWGameData.GetChapterData()
    if chapterData == nil or type(chapterData.EventList) ~= "table" then
        return nil, nil
    end
    for i = 1, #chapterData.EventList do
        local eventData = chapterData.EventList[i]
        if eventData ~= nil and eventData.Status ~= JZQWConst.EventStatus.Finish and JZQWGameData.IsEventCompleteByOutputItems(eventData, outputItems) == false and eventData.Config ~= nil and type(eventData.Config.TriggerItem) == "table" then
            for j = 1, #eventData.Config.TriggerItem do
                local item = eventData.Config.TriggerItem[j]
                local propsData = item ~= nil and JZQWGameData.GetPropsDataByID(item.id) or nil
                if propsData ~= nil and propsData.Config ~= nil and propsData.Config.Type == 1 and itemMap[item.id] ~= nil then



                    return eventData, item.id
                end
            end
        end
    end
    return nil, nil
end



JZQWGameData.SetOperateProps = function(item)
    this.curOperateProps = item
end

JZQWGameData.GetOperateProps = function()
    return this.curOperateProps
end







JZQWGameData.CheckCombineRes = function(propsData1, propsData2)
    for key, value in pairs(propsData1.ActivateObjs) do
        if value.ActivateType == JZQWConst.CombineType.Props and key == propsData2.ID then
            return value.IsClearA, value.IsClearB, value.OutputPropsID
        end
    end
    return false, false
end



JZQWGameData.Clear = function()
    for key, value in pairs(this.propsDataDic) do
        value.IsOwner = false
    end
end