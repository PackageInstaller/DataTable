JSYZMgr = {
    eventsListGroupMap = {},
    eventsListAreaMap = {},
    novelIndex = 0,
    chapterIndex = 0,
    challengeLastPage = nil,
    showAni = true,
    chatMap = nil,
    gameMap = { [3] = true },
    challengeMap = { [4] = true, [5] = true }
}

JSYZMgr.ClearData = function()
    JSYZMgr.eventsListAreaMap = {}
    JSYZMgr.eventsListGroupMap = {}
    JSYZMgr.novelIndex = 0
    JSYZMgr.chapterIndex = 0
    JSYZMgr.challengeLastPage = nil
    JSYZMgr.chatMap = nil
end

JSYZMgr.GetTimeStr = function()
    local d, h, m = 0, 0, 0
    local timeStr = "";
    if DataExHelper.CommonActivityCheck(ActivityKey.JSYZ) then
        local daqin = DataExHelper.GetDataExByTag(ActivityKey.JSYZ);
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

JSYZMgr.CheckTalentIsUnLock = function(event)
    if not event then return false end

    if event.Unlock == nil or #event.Unlock <= 0 then
        return 3
    end

    local unlockNum = 0
    local eventMap = ConfigMgr.Config.BoomTetechMap
    local unlockEvent = eventMap[event.Unlock[1]]
    if unlockEvent then
        unlockNum = JSYZMgr.CheckTalentIsComplete(unlockEvent) and 1 or 0
    end
    unlockNum = unlockNum + (DataMgr.Player.BoomGame.BoomMap[event.Unlock[2]] ~= nil and 2 or 0)
    return unlockNum
end

JSYZMgr.CheckTalentIsComplete = function(event)
    return DataMgr.Player.BoomGame.BoomTechMap[event.Id] ~= nil
end

JSYZMgr.GetActiveEventsByArea = function(area)
    if not area then return {} end
    if not JSYZMgr.eventsListAreaMap[area] then
        JSYZMgr.eventsListAreaMap[area] = {}
        if ConfigMgr.Config and ConfigMgr.Config.activityMapEventList then
            for _, v in ipairs(ConfigMgr.Config.activityMapEventList) do
                if v.area == area then
                    table.insert(JSYZMgr.eventsListAreaMap[area], v)
                end
            end
        end
    end
    return JSYZMgr.eventsListAreaMap[area]
end

JSYZMgr.CheckEventIsUnLock = function(event)
    if not event then return false end

    if event.unlockType == 0 or not event.unlockParam or event.unlockParam == "" then
        return true
    end

    if event.unlockType == 1 then
        local eventMap = DataExHelper.GetActivityMapEventMap()
        if eventMap then
            local unlockEvent = eventMap[event.unlockParam]
            if unlockEvent then
                return JSYZMgr.CheckEventIsComplete(unlockEvent)
            end
        end
        return false
    else
        LuaDebug.error("Config Error: 不支持的unlockType=" .. tostring(event.unlockType))
        return false
    end
end

JSYZMgr.CheckEventIsComplete = function(event)
    if not event or not event.type then return false end

    if event.type == 1 then
        return DataHelper.CheckNovelComplete(event.eventParam)
    elseif event.type == 2 or event.type == 4 or event.type == 5 or event.type == 6 then
        return DataHelper.CheckDungeonComplete(event.eventParam)
    else
        return DataMgr.Player.BoomGame.BoomMap[event.eventParam] ~= nil
    end
    return false
end

JSYZMgr.SetShowAni = function(_bShow)
    JSYZMgr.showAni = _bShow
end

JSYZMgr.CheckShowAni = function()
    return JSYZMgr.showAni
end

JSYZMgr.SetNovelIndex = function(index)
    JSYZMgr.novelIndex = index or 0
end

JSYZMgr.GetNovelIndex = function()
    return JSYZMgr.novelIndex
end

JSYZMgr.SetChapterIndex = function(index)
    JSYZMgr.chapterIndex = index or 0
end

JSYZMgr.GetChapterIndex = function()
    return JSYZMgr.chapterIndex
end

JSYZMgr.SetChallengeLastPaget = function(page)
    JSYZMgr.challengeLastPage = page
end

JSYZMgr.GetChallengeLastPaget = function()
    return JSYZMgr.challengeLastPage
end


JSYZMgr.GetEventLocPosition = function(strPos, offestX, offestY)
    if IsNullOrEmpty(strPos) then
        return Vector2.zero;
    end
    local posArray = NumTool.split(strPos, ",")
    if #posArray > 1 then
        return Vector2(tonumber(posArray[1]) + offestX, tonumber(posArray[2]) + offestY);
    else
        return Vector2.zero;
    end
end




JSYZMgr.CheckEntranceRedDot = function()
    local bMission = JSYZMgr.CheckMissionEntranceRedDot()
    local bPlay = JSYZMgr.CheckPlayRedDot()
    local challenge = JSYZMgr.CheckChallengeRedDot()
    local talent = JSYZMgr.CheckTalentRedDot()
    local sign = JSYZMgr.CheckChapterRedDot()
    if (bPlay or bMission or challenge or talent or sign) then
        return 1
    else
        return 0
    end
end

JSYZMgr.CheckMissionEntranceRedDot = function()
    local bRed = false
    local questEvents = DataExHelper.Check_ConfigQuestEventByText("JSYZGame");
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
        RedMgr.Singleton:UpdateClientRedData("17602", 1)
    else
        RedMgr.Singleton:UpdateClientRedData("17602", 0)
    end
end

JSYZMgr.CheckFinishAll = function(typeMap)
    local cacheList = JSYZMgr.GetActiveEventsByArea("JSYZ")
    local isfinishAll = true
    for k, v in pairs(cacheList) do
        if typeMap[v.type] == true then
            local finish = JSYZMgr.CheckEventIsComplete(v)
            if (not finish) then
                isfinishAll = false
                break
            end
        end
    end
    return isfinishAll
end

JSYZMgr.CheckPlayRedDot = function()
    local bRed = false
    if (not JSYZMgr.CheckFinishAll(JSYZMgr.gameMap) and RedMgr.Singleton:CheckRedCondition("17603")) then
        bRed = true
    end
    if (bRed) then
        RedMgr.Singleton:UpdateClientRedData("17603", 1)
    else
        RedMgr.Singleton:UpdateClientRedData("17603", 0)
    end
    return bRed
end

JSYZMgr.CheckChallengeRedDot = function()
    local bRed = false
    if (not JSYZMgr.CheckFinishAll(JSYZMgr.challengeMap) and RedMgr.Singleton:CheckRedCondition("17606")) then
        bRed = true
    end
    if (bRed) then
        RedMgr.Singleton:UpdateClientRedData("17606", 1)
    else
        RedMgr.Singleton:UpdateClientRedData("17606", 0)
    end
    return bRed
end

JSYZMgr.CheckTalentRedDot = function()
    local bRed = false
    for k, v in pairs(ConfigMgr.Config.BoomTetechMap) do
        if (JSYZMgr.CheckTalentIsUnLock(v) == 3) then
            if (not JSYZMgr.CheckTalentIsComplete(v)) then
                local cost = v.Consume[1]
                local count = DataHelper.GetItemCountById(cost.id)
                if cost.count <= count then
                    bRed = true
                    break
                end
            end
        end
    end
    if (bRed) then
        RedMgr.Singleton:UpdateClientRedData("17607", 1)
    else
        RedMgr.Singleton:UpdateClientRedData("17607", 0)
    end
    return bRed
end

JSYZMgr.CheckChapterRedDot = function()
    local nRed = 0
    RedMgr.Singleton:UpdateClientRedData("17608", 0)
    RedMgr.Singleton:UpdateClientRedData("17609", 0)
    RedMgr.Singleton:UpdateClientRedData("17610", 0)
    RedMgr.Singleton:UpdateClientRedData("17611", 0)
    for i = 1, 4 do
        local str = "JSYZ" .. i
        local configArea = DataExHelper.EX_GetGroupListByArea(str)
        if (configArea ~= nil) then
            local groupId = configArea[1].id
            local mapEventList = DataExHelper.EX_GetEventMapByArea("JSYZ")
            local evetList = mapEventList[groupId]
            if (evetList ~= nil) then
                for k, v in ipairs(evetList) do
                    local pUnLock = JSYZMgr.CheckEventIsUnLock(v);
                    local pPass = JSYZMgr.CheckEventIsComplete(v);
                    if (pUnLock and not pPass) then
                        if (i == 1) then
                            RedMgr.Singleton:UpdateClientRedData("17608", 1)
                            nRed = nRed + 1
                            break
                        elseif (i == 2) then
                            RedMgr.Singleton:UpdateClientRedData("17609", 1)
                            nRed = nRed + 1
                            break
                        elseif (i == 3) then
                            RedMgr.Singleton:UpdateClientRedData("17610", 1)
                            nRed = nRed + 1
                            break
                        else
                            RedMgr.Singleton:UpdateClientRedData("17611", 1)
                            nRed = nRed + 1
                            break
                        end
                    end
                end
            end
        end
    end
    return nRed > 0
end


return JSYZMgr