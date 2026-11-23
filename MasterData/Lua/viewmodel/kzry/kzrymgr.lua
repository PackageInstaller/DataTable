require("Match3Game/Match3GameManager")


KZRYMgr = {
    eventsListGroupMap = {},
    eventsListAreaMap = {},
    novelIndex = 0,
    showAni = true,
};

KZRYMgr.ClearData = function()
    KZRYMgr.eventsListAreaMap = {}
    KZRYMgr.novelIndex = 0
end

KZRYMgr.GetShopCfgData = function()
    local cfgShopList = DataExHelper.Check_ConfigQuestEventByText("KZRYShop")
    if cfgShopList ~= nil then
        table.sort(cfgShopList, function(a, b) return a.sort < b.sort end)
    end
    return cfgShopList;
end


KZRYMgr.GetPuzzleRewardCfgData = function()
    local rewardListByGroup = {}
    local list = DataExHelper.Check_ConfigQuestEventByText("KZRY")
    for i, v in ipairs(list) do
        if not IsNull(v.conditionArgs) and #v.conditionArgs > 0 then
            local key = v.conditionArgs[1]
            if not IsNullOrEmpty(key) then
                if rewardListByGroup[key] == nil then
                    rewardListByGroup[key] = {}
                end
                table.insert(rewardListByGroup[key], v);
            end
        end
    end
    return rewardListByGroup;
end

KZRYMgr.GetActiveEventsByArea = function(area)
    if KZRYMgr.eventsListAreaMap[area] == nil then
        KZRYMgr.eventsListAreaMap[area] = {}
        for i, v in ipairs(ConfigMgr.Config.activityMapEventList) do
            if v.area == area then
                table.insert(KZRYMgr.eventsListAreaMap[area], v);
            end
        end
    end
    return KZRYMgr.eventsListAreaMap[area];
end


KZRYMgr.GetGroupsByKZRY = function()
    Match3GameManager.InitConfig()
    local groupList = {}
    for i, v in ipairs(ConfigMgr.Config.activityMapGroupList) do
        if v.area == "KZRY" then
            table.insert(groupList, v);
        end
    end
    return groupList;
end


KZRYMgr.GetEventsByGroupId = function(groupId)
    if KZRYMgr.eventsListGroupMap[groupId] == nil then
        KZRYMgr.eventsListGroupMap[groupId] = {}
        for i, v in ipairs(ConfigMgr.Config.activityMapEventList) do
            if v.groupId == groupId then
                table.insert(KZRYMgr.eventsListGroupMap[groupId], v);
            end
        end
    end
    return KZRYMgr.eventsListGroupMap[groupId];
end


KZRYMgr.CheckGroupIsLock = function(cfgGroup)
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
    if cfgGroup.unlockType == 5 and not IsNullOrEmpty(cfgGroup.unlockParam) then
        if DataMgr.Player.quests[cfgGroup.unlockParam] == nil or DataMgr.Player.quests[cfgGroup.unlockParam].state == 1 then
            local tips = LuaMgr.GetLangText(ConfigMgr.Config.questEvent[cfgGroup.unlockParam].namelan);
            return true, 2, string.format(ConfigMgr.LangGlobal("25202"), tips);
        end
    end
    return false, 0, "";
end


KZRYMgr.CheckEventIsUnLock = function(event)
    if event.unlockType == 0 or IsNullOrEmpty(event.unlockParam) then
        return true;
    end
    if event.unlockType == 1 then
        local eventMap = DataExHelper.GetActivityMapEventMap();
        local unlockEvent = eventMap[event.unlockParam]
        if unlockEvent ~= nil then
            return KZRYMgr.CheckEventIsComplete(unlockEvent);
        end
        return false;
    else
        local errorInfo = "Config is Error,KZRYMgr is not support other unlockType:" .. event.unlockType;
        LuaDebug.error(errorInfo)
    end
end


KZRYMgr.CheckEventIsComplete = function(event)
    if event.type == 1 then
        return DataHelper.CheckNovelComplete(event.eventParam);
    elseif event.type == 2 or event.type == 4 then
        return DataHelper.CheckDungeonComplete(event.eventParam);
    elseif event.type == 3 then
        return Match3GameManager.GotPassReward(event.eventParam)
    end
end


KZRYMgr.GetEventLocPosition = function(strPos)
    if IsNullOrEmpty(strPos) then
        return Vector2.zero;
    end
    local posArray = NumTool.split(strPos, ",")
    if #posArray > 1 then
        return Vector2(tonumber(posArray[1]), tonumber(posArray[2]));
    else
        return Vector2.zero;
    end
end

KZRYMgr.GetEventsProByGroup = function(groupId)
    local events = KZRYMgr.GetEventsByGroupId(groupId);
    if events == nil or #events == 0 then
        return 0, 0;
    end
    local pro = 0;
    for i, v in ipairs(events) do
        if KZRYMgr.CheckEventIsComplete(v) then
            pro = pro + 1;
        end
    end
    return pro, #events;
end


KZRYMgr.GetGroupsUnLockProIndex = function()
    local index = 0;
    local groups = KZRYMgr.GetGroupsByKZRY()
    for i, v in ipairs(groups) do
        local lock, type, info = KZRYMgr.CheckGroupIsLock(v)
        if not lock then
            index = index + 1;
        end
    end
    if index > #groups then
        index = #groups;
    end
    return index;
end

KZRYMgr.GetHistoryProIndex = function()
    local key = DataMgr.Player.uid .. "_KZRY_PRO"
    return PlayerPrefs.GetInt(key)
end

KZRYMgr.UpdateHistoryProIndex = function(index)
    local key = DataMgr.Player.uid .. "_KZRY_PRO"
    PlayerPrefs.SetInt(key, index);
end


KZRYMgr.GetMedalList = function()
    local medalConfigs = ConfigMgr.Config.Medals
    local tempList = {}
    for k, v in pairs(medalConfigs) do
        if v.Activity == "4009" then
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


KZRYMgr.GetTotalScore = function(_id)
    if IsNull(DataMgr.Player.MedalStepMap[_id]) then
        return { Current = 0, Target = 1 }
    end
    return DataMgr.Player.MedalStepMap[_id]
end


KZRYMgr.GetNovelRecord = function(id)
    local completedChapters = DataMgr.Player.completedChapters;
    for _, v in ipairs(completedChapters) do
        if (v == id) then
            return true;
        end
    end
    return false;
end


KZRYMgr.SetNovelIndex = function(index)
    KZRYMgr.novelIndex = index;
end


KZRYMgr.GetNovelIndex = function()
    return KZRYMgr.novelIndex;
end


KZRYMgr.GetDungeonRecord = function(id)
    return DataMgr.Player.dungeonRecords[id];
end


KZRYMgr.IsUnlock = function(id, isTips)
    if (not IsNullOrEmpty(id)) then
        local record = KZRYMgr.GetDungeonRecord(id);
        if (record == nil or IsNullOrEmpty(record.historyRating)) then
            if (isTips) then
                local unlockName = ConfigKZRYMgr.GetDungeonName(id);
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(ConfigMgr.LangGlobal("10001"), unlockName));
            end
            return false;
        end
    end
    return true;
end

KZRYMgr.SetShowAni = function (_bShow)
    KZRYMgr.showAni = _bShow
end

KZRYMgr.CheckShowAni = function ()
    return KZRYMgr.showAni
end

return KZRYMgr