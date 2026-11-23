WMFCMgr = {
    eventsListGroupMap = {},
    eventsListAreaMap = {},
    novelIndex = 0,
    showAni = true,
    chatMap = nil,
}

WMFCMgr.ClearData = function()
    WMFCMgr.eventsListAreaMap = {}
    WMFCMgr.eventsListGroupMap = {}
    WMFCMgr.novelIndex = 0
    WMFCMgr.chatMap = nil
end

WMFCMgr.GetTimeStr = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.WMFC) then
        return ""
    end

    local daqin = DataExHelper.GetDataExByTag(ActivityKey.WMFC)
    local time = daqin.expireTime - LuaMgr.Timestamp()
    local d, h, m = GetTimeDHM(time)

    local timeStr = ""
    if not IsNullOrEmpty(d) then
        timeStr = timeStr .. string.format("%s%s", d, ConfigMgr.LangGlobal("10365"))
    end
    if not IsNullOrEmpty(h) then
        timeStr = timeStr .. string.format("%s%s", h, ConfigMgr.LangGlobal("10366"))
    end
    if not IsNullOrEmpty(m) then
        timeStr = timeStr .. string.format("%s%s", m, ConfigMgr.LangGlobal("10367"))
    end
    return timeStr
end

WMFCMgr.CheckTalentIsUnLock = function(event)
    if not event then return false end

    if not event.Unlock or #event.Unlock <= 0 then
        return true
    end

    if event.Unlock[1] == "1" then
        local eventMap = ConfigMgr.Config.BoomTetechMap
        if eventMap and eventMap[event.Unlock[2]] then
            return WMFCMgr.CheckTalentIsComplete(eventMap[event.Unlock[2]])
        end
    end
    return false
end

WMFCMgr.CheckTalentIsComplete = function(event)
    return DataMgr.Player.BoomGame.BoomTechMap[event.Id] ~= nil
end

WMFCMgr.GetActiveEventsByArea = function(area)
    if not area then return {} end

    if not WMFCMgr.eventsListAreaMap[area] then
        local list = {}
        local eventList = ConfigMgr.Config and ConfigMgr.Config.activityMapEventList
        if eventList then
            for _, v in ipairs(eventList) do
                if v.area == area then
                    table.insert(list, v)
                end
            end
        end
        WMFCMgr.eventsListAreaMap[area] = list
    end
    return WMFCMgr.eventsListAreaMap[area]
end

WMFCMgr.CheckEventIsUnLock = function(event)
    if not event then return false end

    if event.unlockType == 0 or not event.unlockParam or event.unlockParam == "" then
        return true
    end

    if event.unlockType == 1 then
        local eventMap = DataExHelper.GetActivityMapEventMap()
        if eventMap and eventMap[event.unlockParam] then
            return WMFCMgr.CheckEventIsComplete(eventMap[event.unlockParam])
        end
        return false
    else
        LuaDebug.error("Config Error: 不支持的unlockType=" .. tostring(event.unlockType))
        return false
    end
end

WMFCMgr.CheckEventIsComplete = function(event)
    if not event or not event.type then return false end

    if event.type == 1 then
        return DataHelper.CheckNovelComplete(event.eventParam)
    elseif event.type == 2 or event.type == 4 or event.type == 5 or event.type == 6 then
        return DataHelper.CheckDungeonComplete(event.eventParam)
    elseif event.type == 3 then
        return WMFCMgr.CheckGameIsComplete(event.eventParam)
    else
        return DataMgr.Player.CookGame.ChatRewards[event.eventParam] ~= nil
    end
    return false
end

WMFCMgr.SetShowAni = function(_bShow)
    WMFCMgr.showAni = _bShow
end

WMFCMgr.CheckShowAni = function()
    return WMFCMgr.showAni
end

WMFCMgr.SetNovelIndex = function(index)
    WMFCMgr.novelIndex = index or 0
end

WMFCMgr.GetNovelIndex = function()
    return WMFCMgr.novelIndex
end






WMFCMgr.CheckEntranceRedDot = function()
    local bStory = WMFCMgr.CheckStoryEntranceRedDot()
    local bStage = WMFCMgr.CheckStageEntranceRedDot()
    return (bStory or bStage) and 1 or 0
end


WMFCMgr.CheckStoryEntranceRedDot = function()
    local storyRed = false
    local eventList = ConfigMgr.Config.activityMapEventList
    if eventList then
        for _, v in ipairs(eventList) do
            if v.area == "WMFC1" then
                if WMFCMgr.CheckStoryRedDot("WMFC1", v.id) then
                    storyRed = true
                    break
                end
            end
        end
    end

    RedMgr.Singleton:UpdateClientRedData("17306", storyRed and 1 or 0)
    return storyRed
end

WMFCMgr.CheckStoryRedDot = function(_area, _id)
    local cacheData = DataMgr.Player.activityMaps and DataMgr.Player.activityMaps[_area]
    local eventData = cacheData and cacheData.activityEvents and cacheData.activityEvents[_id]

    if eventData then
        local isRead = DataHelper.CheckNovelComplete(_id)
        return not (eventData.complete or isRead)
    end
    return false
end


WMFCMgr.CheckStageEntranceRedDot = function()
    local b = RedMgr.Singleton:CheckRedCondition("17305") == true
    RedMgr.Singleton:UpdateClientRedData("17305", b and 1 or 0)
    return b
end


return WMFCMgr