XCHDMgr = {
    eventsListGroupMap = {},
    eventsListAreaMap = {},
    novelIndex = 0,
    showAni = true,
    chatMap = nil,
Repeat = "XCHD1",
Main = "XCHD2",
Difficult = "XCHD3",
Story = "XCHD4",
    levelType = 0,
}

XCHDMgr.ClearData = function()
    XCHDMgr.eventsListAreaMap = {}
    XCHDMgr.eventsListGroupMap = {}
    XCHDMgr.novelIndex = 0
    XCHDMgr.chatMap = nil
end

XCHDMgr.GetActiveEventsByArea = function(area)
    if not area then return {} end
    if not XCHDMgr.eventsListAreaMap[area] then
        XCHDMgr.eventsListAreaMap[area] = {}
        if ConfigMgr.Config and ConfigMgr.Config.activityMapEventList then
            for _, v in ipairs(ConfigMgr.Config.activityMapEventList) do
                if v.area == area then
                    table.insert(XCHDMgr.eventsListAreaMap[area], v)
                end
            end
        end
    end
    return XCHDMgr.eventsListAreaMap[area]
end

XCHDMgr.CheckEventIsUnLock = function(event)
    if not event then return false end

    if event.unlockType == 0 or not event.unlockParam or event.unlockParam == "" then
        return true
    end

    if event.unlockType == 1 then
        local eventMap = DataExHelper.GetActivityMapEventMap()
        if eventMap then
            local unlockEvent = eventMap[event.unlockParam]
            if unlockEvent then
                return XCHDMgr.CheckEventIsComplete(unlockEvent)
            end
        end
        return false
    else
        LuaDebug.error("Config Error: 不支持的unlockType=" .. tostring(event.unlockType))
        return false
    end
end

XCHDMgr.CheckEventIsComplete = function(event)
    if not event or not event.type then return false end

    if event.type == 1 then
        return DataHelper.CheckNovelComplete(event.eventParam)
    elseif event.type == 2 or event.type == 4 or event.type == 5 or event.type == 6 then
        return DataHelper.CheckDungeonComplete(event.eventParam)
    elseif event.type == 3 then
        return XCHDMgr.CheckGameIsComplete(event.eventParam)
    else
        return DataMgr.Player.CookGame.ChatRewards[event.eventParam] ~= nil
    end
    return false
end

XCHDMgr.CheckGameIsComplete = function(id)
    return DataMgr.Player.PackUpGameMap[id] ~= nil
end

XCHDMgr.SetShowAni = function(_bShow)
    XCHDMgr.showAni = _bShow
end

XCHDMgr.CheckShowAni = function()
    return XCHDMgr.showAni
end

XCHDMgr.GetTimeStr = function()
    local d, h, m = 0, 0, 0
    local timeStr = "";
    if DataExHelper.CommonActivityCheck(ActivityKey.XCHD) then
        local daqin = DataExHelper.GetDataExByTag(ActivityKey.XCHD);
        local time = daqin.expireTime - LuaMgr.Timestamp();
        d, h, m = GetTimeDHM(time);
    end
    if (not IsNullOrEmpty(d)) then
        timeStr = timeStr .. string.format("%s%s", d, ConfigMgr.LangGlobal("10365"));
    end
    if (not IsNullOrEmpty(h)) then
        timeStr = timeStr .. string.format("%s%s", h, ConfigMgr.LangGlobal("10366"));
    end
    if (not IsNullOrEmpty(m)) then
        timeStr = timeStr .. string.format("%s%s", m, ConfigMgr.LangGlobal("10367"));
    end
    return timeStr
end


XCHDMgr.SetLevelType = function(levelType)
    XCHDMgr.levelType = levelType;
end


XCHDMgr.GetLevelType = function()
    if (XCHDMgr.levelType == 0 or XCHDMgr.levelType == nil) then
        for i = 1, 3 do
            local type = "XCHD" .. i;
            local eventList = DataExHelper.EX_GetEventListByArea(type);
            for j, v in ipairs(eventList) do
                local eventData = XCHDMgr.GetActivityMapEvent(type, v.id);
                if (eventData ~= nil) then
                    XCHDMgr.levelType = i;
                    return XCHDMgr.levelType;
                end
            end
        end
    end
    if (XCHDMgr.levelType == 0 or XCHDMgr.levelType == nil) then
        XCHDMgr.levelType = 1;
    end
    return XCHDMgr.levelType;
end


XCHDMgr.GetActivityMapEvent = function(type, id)
    local data = DataMgr.Player.activityMaps[type];
    if (data ~= nil) then
        return data.activityEvents[id];
    end
    return nil;
end




XCHDMgr.CheckEntranceRedDot = function()
    local bStory = XCHDMgr.CheckStoryEntranceRedDot()
    local bStage = XCHDMgr.CheckStageEntranceRedDot()

    if (bStory or bStage) then
        return 1
    else
        return 0
    end
end


XCHDMgr.CheckStoryEntranceRedDot = function()
    local storyRed = false
    for k, v in ipairs(ConfigMgr.Config.activityMapEventList) do
        if (v.area == "XCHD4") then
            storyRed = XCHDMgr.CheckStoryRedDot("XCHD4", v.id)
            if (storyRed) then
                break
            end
        end
    end
    if (storyRed) then
        RedMgr.Singleton:UpdateClientRedData("17315", 1)
    else
        RedMgr.Singleton:UpdateClientRedData("17315", 0)
    end
    return storyRed
end

XCHDMgr.CheckStoryRedDot = function(_area, _id)
    local eventData = nil
    local cacheData = DataMgr.Player.activityMaps[_area];
    if (cacheData ~= nil) then
        eventData = cacheData.activityEvents[_id];
    end
    if (eventData ~= nil) then
        local isRead = DataHelper.CheckNovelComplete(eventData.eventParam);
        if (eventData.complete or isRead) then
            return false
        end
        return true
    end
    return false
end

XCHDMgr.CheckStageEntranceRedDot = function()
    local bRed = false
    if (RedMgr.Singleton:CheckRedCondition("17314")) then
        for k, v in ipairs(ConfigMgr.Config.activityMapEventList) do
            for i = 1, 3 do
                if (v.area == "XCHD" .. i) then
                    bRed = XCHDMgr.CheckStoryRedDot("XCHD" .. i, v.id)
                    if (bRed) then
                        break
                    end
                end
            end
            if (bRed) then
                break
            end
        end
    end
    if (bRed) then
        RedMgr.Singleton:UpdateClientRedData("17314", 1)
    else
        RedMgr.Singleton:UpdateClientRedData("17314", 0)
    end
    return bRed
end


XCHDMgr.CheckSimulateRedDot=function()
    local taskRed=SimulateRoomMgr.CheckTaskRed();
    local dropLevelRed=SimulateRoomMgr.CheckDropGameRed();
    local techTreeRed=SimulateRoomMgr.CheckTechTreeRed();
    local simulateRed=SimulateRoomMgr.CheckSimulateRed();
    local riddleRed=SimulateRoomMgr.CheckRiddlesRed();
    local lightMakeRed=SimulateRoomMgr.CheckLightMakeRed();
    local bRed=taskRed+dropLevelRed+techTreeRed+simulateRed+riddleRed+lightMakeRed;
    RedMgr.Singleton:UpdateClientRedData("17316", bRed);
    return bRed;
end




return XCHDMgr