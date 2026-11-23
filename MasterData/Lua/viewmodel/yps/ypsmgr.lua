YPSMgr = {
    eventsListGroupMap = {},
    eventsListAreaMap = {},
    novelIndex = 0,
    showAni = true,
    chatMap = nil,
}

YPSMgr.ClearData = function()
    YPSMgr.eventsListAreaMap = {}
    YPSMgr.eventsListGroupMap = {}
    YPSMgr.novelIndex = 0
    YPSMgr.chatMap = nil
end

YPSMgr.GetShopCfgData = function()
    local cfgShopList = DataExHelper.Check_ConfigQuestEventByText("PackUpShop")
    if cfgShopList then
        table.sort(cfgShopList, function(a, b) return a.sort < b.sort end)
    end
    return cfgShopList or {}
end

YPSMgr.GetPuzzleRewardCfgData = function()
    local rewardListByGroup = {}
    local list = DataExHelper.Check_ConfigQuestEventByText("PackUp")

    if not list then return rewardListByGroup end

    for _, v in ipairs(list) do
        if v.conditionArgs and #v.conditionArgs > 0 then
            local key = v.conditionArgs[1]
            if key and key ~= "" then
                rewardListByGroup[key] = rewardListByGroup[key] or {}
                table.insert(rewardListByGroup[key], v)
            end
        end
    end

    return rewardListByGroup
end

YPSMgr.GetActiveEventsByArea = function(area)
    if not area then return {} end

    if not YPSMgr.eventsListAreaMap[area] then
        YPSMgr.eventsListAreaMap[area] = {}

        if ConfigMgr.Config and ConfigMgr.Config.activityMapEventList then
            for _, v in ipairs(ConfigMgr.Config.activityMapEventList) do
                if v.area == area then
                    table.insert(YPSMgr.eventsListAreaMap[area], v)
                end
            end
        end
    end

    return YPSMgr.eventsListAreaMap[area]
end

YPSMgr.GetGroupsByYPS = function(area)
    local groupList = {}

    if ConfigMgr.Config and ConfigMgr.Config.activityMapGroupList then
        for _, v in ipairs(ConfigMgr.Config.activityMapGroupList) do
            if v.area == area then
                table.insert(groupList, v)
            end
        end
    end

    return groupList
end

YPSMgr.GetEventsByGroupId = function(groupId)
    if not groupId then return {} end

    if not YPSMgr.eventsListGroupMap[groupId] then
        YPSMgr.eventsListGroupMap[groupId] = {}

        if ConfigMgr.Config and ConfigMgr.Config.activityMapEventList then
            for _, v in ipairs(ConfigMgr.Config.activityMapEventList) do
                if v.groupId == groupId then
                    table.insert(YPSMgr.eventsListGroupMap[groupId], v)
                end
            end
        end
    end

    return YPSMgr.eventsListGroupMap[groupId]
end

YPSMgr.CheckGroupIsLock = function(cfgGroup)
    if cfgGroup == nil then return false, 0, "" end;
    if cfgGroup.openDate > 0 then
        local reTime = cfgGroup.openDate - LuaMgr.Timestamp();
        if reTime > 0 then
            local day, hour, min = GetTimeDHM2(reTime)
            local tips = "";
            if day > 0 then
                tips = string.format(ConfigMgr.LangGlobal("25201"), day .. LuaMgr.GetLangText("KZRYMgr_0"));
            elseif hour > 0 then
                tips = string.format(ConfigMgr.LangGlobal("25201"), hour .. LuaMgr.GetLangText("KZRYMgr_1"));
            else
                tips = string.format(ConfigMgr.LangGlobal("25201"), min .. LuaMgr.GetLangText("KZRYMgr_2"));
            end
            return true, 1, tips;
        end
    end
    if cfgGroup.unlockParam and cfgGroup.unlockParam ~= "" then
        local missionMap = DataMgr.Player.passesMissionsMultiple["219"].period;
        for i, v in pairs(missionMap) do
            if v.id == cfgGroup.unlockParam then
                if v.current < v.target then
                    local cfgMissionItem = ConfigMgr.Config.PassesTaskMap[v.id]
                    local tips = LuaMgr.GetLangText(cfgMissionItem.Namelan);
                    return true, 2, string.format(ConfigMgr.LangGlobal("25202"), tips);
                end
            end
        end
    end

    return false, 0, "";
end

YPSMgr.CheckEventIsUnLock = function(event)
    if not event then return false end

    if event.unlockType == 0 or not event.unlockParam or event.unlockParam == "" then
        return true
    end

    if event.unlockType == 1 then
        local eventMap = DataExHelper.GetActivityMapEventMap()
        if eventMap then
            local unlockEvent = eventMap[event.unlockParam]
            if unlockEvent then
                return YPSMgr.CheckEventIsComplete(unlockEvent)
            end
        end
        return false
    else
        LuaDebug.error("Config Error: 不支持的unlockType=" .. tostring(event.unlockType))
        return false
    end
end

YPSMgr.CheckEventIsComplete = function(event)
    if not event or not event.type then return false end

    if event.type == 1 then
        return DataHelper.CheckNovelComplete(event.eventParam)
    elseif event.type == 2 or event.type == 4 or event.type == 5 or event.type == 6 then
        return DataHelper.CheckDungeonComplete(event.eventParam)
    elseif event.type == 3 then
        return YPSMgr.CheckGameIsComplete(event.eventParam)
    else
        return DataMgr.Player.CookGame.ChatRewards[event.eventParam] ~= nil
    end
    return false
end

YPSMgr.CheckGameIsComplete = function(id)
    return DataMgr.Player.PackUpGameMap[id] ~= nil
end

YPSMgr.GetEventLocPosition = function(strPos)
    if not strPos or strPos == "" then
        return Vector2.zero
    end

    local posArray = NumTool.split(strPos, ",")
    if #posArray >= 2 then
        local x = tonumber(posArray[1])
        local y = tonumber(posArray[2])
        if x and y then
            return Vector2(x, y)
        end
    end

    return Vector2.zero
end

YPSMgr.GetEventsProByGroup = function(groupId)
    local events = YPSMgr.GetEventsByGroupId(groupId)
    if not events or #events == 0 then
        return 0, 0
    end

    local completedCount = 0
    for _, v in ipairs(events) do
        if YPSMgr.CheckEventIsComplete(v) then
            completedCount = completedCount + 1
        end
    end

    return completedCount, #events
end

YPSMgr.GetGroupsUnLockProIndex = function()
    local unlockedCount = 0
    local groups = YPSMgr.GetGroupsByYPS("YPS01")

    for _, v in ipairs(groups) do
        local isLock = YPSMgr.CheckGroupIsLock(v)
        if not isLock then
            unlockedCount = unlockedCount + 1
        end
    end

    return math.min(unlockedCount, #groups)
end

YPSMgr.GetHistoryProIndex = function()
    if not DataMgr.Player or not DataMgr.Player.uid then
        return 0
    end

    local key = DataMgr.Player.uid .. "_PackUp_PRO"
    return PlayerPrefs.GetInt(key)
end

YPSMgr.UpdateHistoryProIndex = function(index)
    if not DataMgr.Player or not DataMgr.Player.uid or not index then
        return
    end

    local key = DataMgr.Player.uid .. "_PackUp_PRO"
    PlayerPrefs.SetInt(key, index)
end

YPSMgr.GetHistoryIndex = function(index)
    if not DataMgr.Player or not DataMgr.Player.uid then
        return 0
    end

    local key = DataMgr.Player.uid .. "_PackUp_Index" .. index
    return PlayerPrefs.GetInt(key)
end

YPSMgr.UpdateHistoryIndex = function(index)
    if not DataMgr.Player or not DataMgr.Player.uid or not index then
        return
    end

    local key = DataMgr.Player.uid .. "_PackUp_Index" .. index
    PlayerPrefs.SetInt(key, index)
end

YPSMgr.GetMedalList = function()
    local medalConfigs = ConfigMgr.Config.Medals
    if not medalConfigs then return {} end

    local tempList = {}
    for _, v in pairs(medalConfigs) do
        if v.Activity == "4150" then
            local item = {
                id = v.Id,
                icon = LuaMgr.GetSprite("ZhanXunIcon", v.Id),
                name = LuaMgr.GetLangText(v.NameLan),
                desc = LuaMgr.GetLangText(v.DesLan),
                remark = LuaMgr.GetLangText(v.RemarksLan),
            }
            table.insert(tempList, item)
        end
    end

    return tempList
end

YPSMgr.GetTotalScore = function(_id)
    if not _id or not DataMgr.Player or not DataMgr.Player.MedalStepMap then
        return { Current = 0, Target = 1 }
    end

    return DataMgr.Player.MedalStepMap[_id] or { Current = 0, Target = 1 }
end

YPSMgr.GetNovelRecord = function(id)
    if not id or not DataMgr.Player or not DataMgr.Player.completedChapters then
        return false
    end

    for _, v in ipairs(DataMgr.Player.completedChapters) do
        if v == id then
            return true
        end
    end

    return false
end

YPSMgr.SetNovelIndex = function(index)
    YPSMgr.novelIndex = index or 0
end

YPSMgr.GetNovelIndex = function()
    return YPSMgr.novelIndex
end

YPSMgr.GetDungeonRecord = function(id)
    if not id or not DataMgr.Player or not DataMgr.Player.dungeonRecords then
        return nil
    end

    return DataMgr.Player.dungeonRecords[id]
end

YPSMgr.IsUnlock = function(id, isTips)
    if not id or id == "" then
        return true
    end

    local record = YPSMgr.GetDungeonRecord(id)
    if not record or not record.historyRating or record.historyRating == "" then
        if isTips then
            local unlockName = ConfigMgr.Config.dungeonMap[id];
            if (unlockName == nil) then
                unlockName = ""
            end
            local tips = string.format(ConfigMgr.LangGlobal("10001"), unlockName)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tips)
        end
        return false
    end

    return true
end

YPSMgr.SetShowAni = function(_bShow)
    YPSMgr.showAni = _bShow
end

YPSMgr.CheckShowAni = function()
    return YPSMgr.showAni
end

YPSMgr.GetTimeStr = function()
    local d, h, m = 0, 0, 0
    local timeStr = "";
    if DataExHelper.CommonActivityCheck(ActivityKey.YPS) then
        local daqin = DataExHelper.GetDataExByTag(ActivityKey.YPS);
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

YPSMgr.GetChatListByGroupType = function(groupType)
    if (YPSMgr.chatMap == nil) then
        YPSMgr.chatMap = {};
        for k, v in pairs(ConfigMgr.Config.CookPlotMap) do
            if (YPSMgr.chatMap[v.GroupType] == nil) then
                YPSMgr.chatMap[v.GroupType] = {}
            end
            table.insert(YPSMgr.chatMap[v.GroupType], v);
        end
        for k, v in pairs(YPSMgr.chatMap) do
            table.sort(v, function(a, b)
                return tonumber(a.Id) < tonumber(b.Id)
            end);
        end
    end
    return YPSMgr.chatMap[groupType];
end

YPSMgr.SetChallengeLastPaget = function(page)
    PlayerWaterlilyMgr.challengeLastPage = page
end

YPSMgr.GetChallengeLastPaget = function()
    return PlayerWaterlilyMgr.challengeLastPage
end

YPSMgr.CheckChallengeTimes = function()
    local maxCount = DataMgr.Player.CookGame.Challenge or 0
    if maxCount == 0 then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7501")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return false
    end
    return true
end



YPSMgr.CheckEntranceRedDot = function()
    local bMission = YPSMgr.CheckMissionEntranceRedDot()
    local bPlay = YPSMgr.CheckPlayRedDot()
    local challenge = YPSMgr.CheckChallengeRedDot()
    local talent = YPSMgr.CheckTalentRedDot()
    local sign = YPSMgr.CheckSignRedDot()
    if (bPlay or bMission or challenge or talent or sign) then
        return 1
    else
        return 0
    end
end

YPSMgr.CheckMissionEntranceRedDot = function()
    local bRed = false
    local questEvents = DataExHelper.Check_ConfigQuestEventByText("cookGame");
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
        RedMgr.Singleton:UpdateClientRedData("17202", 1)
    else
        RedMgr.Singleton:UpdateClientRedData("17202", 0)
    end
end

YPSMgr.CheckPlayRedDot = function()
    local bRed = false
    if (DataMgr.Player.CookGame.Challenge > 0 and RedMgr.Singleton:CheckRedCondition("17203")) then
        bRed = true
    end
    if (bRed) then
        RedMgr.Singleton:UpdateClientRedData("17203", 1)
    else
        RedMgr.Singleton:UpdateClientRedData("17203", 0)
    end
    return bRed
end

YPSMgr.CheckChallengeRedDot = function()
    local bRed = false
    if (RedMgr.Singleton:CheckRedCondition("17206")) then
        bRed = true
    end
    if (bRed) then
        RedMgr.Singleton:UpdateClientRedData("17206", 1)
    else
        RedMgr.Singleton:UpdateClientRedData("17206", 0)
    end
    return bRed
end

YPSMgr.CheckTalentRedDot = function()
    local bRed = false
    for i = 1, 5 do
        local config = ConfigMgr.Config.CookConstants["Talent" .. i]
        local data = DataMgr.Player.CookGame.TalentMap["talent" .. i]
        if (data == 0) then
            local itemList = config[2]           
            local myCount = DataHelper.GetItemCountById(itemList[1])
            if (myCount >= tonumber(itemList[2])) then
                bRed = true
                break
            end          
        end
    end
    if (bRed) then
        RedMgr.Singleton:UpdateClientRedData("17207", 1)
    else
        RedMgr.Singleton:UpdateClientRedData("17207", 0)
    end
    return bRed
end

YPSMgr.CheckSignRedDot = function()
    local bRed = false
    if YPSMgr.questEvents == nil then
        YPSMgr.questEvents = DataExHelper.Check_ConfigQuestEventByText("MScheckIn")
    end
    local len = #YPSMgr.questEvents
    for i = 1, len do
        local eventData = YPSMgr.questEvents[i]
        local state = 0
        if DataMgr.Player.quests[eventData.id] ~= nil then
            state = DataMgr.Player.quests[eventData.id].state
        end
        if state == 2 then
           bRed = true
           break
        end
    end
    if (bRed) then
        RedMgr.Singleton:UpdateClientRedData("17205", 1)
    else
        RedMgr.Singleton:UpdateClientRedData("17205", 0)
    end
    return bRed
end


return YPSMgr