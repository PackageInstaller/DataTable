require("ViewModel/FSMY/FSMYConst")

FSMYMgr = {
    eventsListAreaMap = {},
    showAni = true,
isInit = false,
levelType = 0,
bPlay = false,
    CharMap = nil,
    eventCompleteTag = { "kfs", "khg", "tg", "zhong", "liang", "you" },
    redEventMap = {},
}

FSMYMgr.GetTimeStr = function()
    local d, h, m = 0, 0, 0
    local timeStr = "";
    if DataExHelper.CommonActivityCheck(ActivityKey.FSMY) then
        local daqin = DataExHelper.GetDataExByTag(ActivityKey.FSMY);
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

FSMYMgr.SetPlayerAnimation = function(_bPlay)
    FSMYMgr.bPlay = _bPlay
end

FSMYMgr.GetPlayerAnimation = function()
    return FSMYMgr.bPlay
end

FSMYMgr.SetCurTap = function(_tap)
    FSMYMgr.curTap = _tap
end

FSMYMgr.GetCurTap = function()
    return FSMYMgr.curTap
end

FSMYMgr.SetSelectedType = function(_type)
    FSMYMgr.selectedType = _type
end

FSMYMgr.GetSelectedType = function()
    return FSMYMgr.selectedType
end

FSMYMgr.CheckEventIsUnLock = function(event)
    if not event then return false end
    if event.unlockType == 0 or not event.unlockParam or event.unlockParam == "" then
        return true
    end

    if event.unlockType == 1 then
        local eventMap = DataExHelper.GetActivityMapEventMap()
        if eventMap then
            local unlockEvent = eventMap[event.unlockParam]
            if unlockEvent then
                return FSMYMgr.CheckEventIsComplete(unlockEvent)
            end
        end
        return false
    else
        LuaDebug.error("Config Error: 不支持的unlockType=" .. tostring(event.unlockType))
        return false
    end
end

FSMYMgr.CheckEventIsComplete = function(event)
    if not event or not event.type then return false end

    if event.type == 1 then
        return DataHelper.CheckNovelComplete(event.eventParam)
    elseif event.type == 2 or event.type == 4 or event.type == 5 then
        return DataHelper.CheckDungeonComplete(event.eventParam)
    elseif event.type == 3 then
        return FSMYMgr.CheckGameState(event.eventParam)
    else
        return true
    end
end


FSMYMgr.CheckGameState = function(id)
    local hackGame = DataMgr.Player.HackGame
    if hackGame == nil or hackGame.LevelMap == nil then
        return false
    end
    local levelConfig = ConfigMgr.Config.HackGameLevelMap[id]
    if (levelConfig == nil) then
        return false
    else
        if (levelConfig.Type <= 1) then
            local score = hackGame.LevelScoreMap and hackGame.LevelScoreMap[id]
            if (score ~= nil and score > 0) then
                return true
            end
        else
            local score = hackGame.LevelDailyMap and hackGame.LevelDailyMap[id]
            if (score ~= nil and score > 0) then
                return true
            end
        end
    end
    return false
end

FSMYMgr.GetEventCompleteTag = function(curEventCfg)
    if curEventCfg.type == 1 then
        if DataHelper.CheckNovelComplete(curEventCfg.eventParam) then
            return FSMYMgr.eventCompleteTag[2]
        end
    elseif curEventCfg.type == 2 then
        local dungeon = DataMgr.Player.dungeonRecords[curEventCfg.eventParam];
        if dungeon ~= nil and dungeon.completeCount > 0 then
            if curEventCfg.area == "FSMY1" then

                return FSMYMgr.eventCompleteTag[1]
            elseif curEventCfg.area == "FSMY2" then

                return FSMYMgr.eventCompleteTag[3]
            elseif curEventCfg.area == "FSMY3" then

                if dungeon.historyRating == "S" then
                    return FSMYMgr.eventCompleteTag[6]
                elseif dungeon.historyRating == "A" then
                    return FSMYMgr.eventCompleteTag[5]
                elseif dungeon.historyRating == "B" then
                    return FSMYMgr.eventCompleteTag[4]
                end
            end
        end
    elseif curEventCfg.type == 3 then

        if FSMYMgr.CheckGameState(curEventCfg.eventParam) then
            return FSMYMgr.eventCompleteTag[3]
        end
    end
    return nil;
end


FSMYMgr.ClearData = function()
    FSMYMgr.eventsListAreaMap = {}
end

FSMYMgr.GetActiveEventsByArea = function(area)
    if not area then return {} end

    if not FSMYMgr.eventsListAreaMap[area] then
        FSMYMgr.eventsListAreaMap[area] = {}

        if ConfigMgr.Config and ConfigMgr.Config.activityMapEventList then
            for _, v in ipairs(ConfigMgr.Config.activityMapEventList) do
                if v.area == area then
                    table.insert(FSMYMgr.eventsListAreaMap[area], v)
                end
            end
        end
    end

    return FSMYMgr.eventsListAreaMap[area]
end

FSMYMgr.SetShowAni = function(_bShow)
    FSMYMgr.showAni = _bShow
end

FSMYMgr.CheckShowAni = function()
    return FSMYMgr.showAni
end



FSMYMgr.CheckEntranceRedDot = function()
    local main = FSMYMgr.SetEventRed()
    local mission = FSMYMgr.CheckMissionEntranceRedDot()
    if (main > 0 or mission) then
        return 1
    else
        return 0
    end
end

FSMYMgr.SetEventRed = function()
    local redList = { 0, 0, 0, 0, 0 }
    FSMYMgr.redEventMap = {}

    for i = 1, 5, 1 do
        local area = FSMYLevel2StrType[i];
        local eventList = FSMYMgr.GetActiveEventsByArea(area);
        if area == FSMYLevelType.Play then
            local lastItem = eventList[#eventList]
            if lastItem ~= nil and FSMYMgr.CheckEventIsComplete(lastItem) then
                if (RedMgr.Singleton:CheckRedCondition("18108")) then
                    redList[i] = 1;
                    break
                end
            end
        end
        for p, v in ipairs(eventList) do
            local key = DataMgr.Player.uid .. "FSMY_" .. v.id;
            if not FSMYMgr.CheckEventIsComplete(v) and FSMYMgr.CheckEventIsUnLock(v) and PlayerPrefs.GetInt(key) == 0 then
                redList[i] = 1;
                FSMYMgr.redEventMap[v.id] = 1;
            end
        end
    end
    RedMgr.Singleton:UpdateClientRedData("18102", redList[1]);
    RedMgr.Singleton:UpdateClientRedData("18105", redList[2]);
    RedMgr.Singleton:UpdateClientRedData("18106", redList[3]);
    RedMgr.Singleton:UpdateClientRedData("18103", redList[4]);
    RedMgr.Singleton:UpdateClientRedData("18104", redList[5]);
    return redList[1] + redList[2] + redList[3] + redList[4] + redList[5];
end

FSMYMgr.CheckMissionEntranceRedDot = function()
    local bRed = false
    local questEvents = DataExHelper.Check_ConfigQuestEventByText("FSMY");
    local quests = DataMgr.Player.quests;
    local len = #questEvents;
    for i = 1, len do
        local questData = quests[questEvents[i].id];
        if (questData ~= nil and questData.state == 2) then
            bRed = true;
            break
        end
    end
    if (bRed) then
        RedMgr.Singleton:UpdateClientRedData("18107", 1)
    else
        RedMgr.Singleton:UpdateClientRedData("18107", 0)
    end
    return bRed
end



return FSMYMgr