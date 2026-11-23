require("ViewModel/HMWY/HMWYDispatchMgr")
HMWYMgr = {
    eventsListAreaMap = {},
    showAni = true,
isInit = false,
levelType = 0,
bPlay = false,
    CharMap = nil,
}

HMWYMgr.GetTimeStr = function()
    local d, h, m = 0, 0, 0
    local timeStr = "";
    if DataExHelper.CommonActivityCheck(ActivityKey.HMWY) then
        local daqin = DataExHelper.GetDataExByTag(ActivityKey.HMWY);
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

HMWYMgr.SetPlayerAnimation = function(_bPlay)
    HMWYMgr.bPlay = _bPlay
end

HMWYMgr.GetPlayerAnimation = function()
    return HMWYMgr.bPlay
end

HMWYMgr.SetCurTap = function(_tap)
    HMWYMgr.curTap = _tap
end

HMWYMgr.GetCurTap = function()
    return HMWYMgr.curTap
end

HMWYMgr.SetSelectedType = function(_type)
    HMWYMgr.selectedType = _type
end

HMWYMgr.GetSelectedType = function()
    return HMWYMgr.selectedType
end

HMWYMgr.GetCombineData = function()
    local dataList = {}
    local cacheData = HMWYMgr.GetTargetData("HMWY4")
    if (cacheData ~= nil) then
        table.insert(dataList, cacheData)
    end
    cacheData = HMWYMgr.GetTargetData("HMWY2")
    if (cacheData ~= nil) then
        table.insert(dataList, cacheData)
    end
    cacheData = HMWYMgr.GetTargetData("HMWY1")
    if (cacheData ~= nil) then
        table.insert(dataList, cacheData)
    end
    cacheData = HMWYMgr.GetTargetData("HMWY3")
    if (cacheData ~= nil) then
        table.insert(dataList, cacheData)
    end
    local list = HMWYMgr.GetActiveEventsByArea("HMWY5")
    for k, v in pairs(list) do
        if (DataMgr.Player.HMWYGame.Events[v.id]) then
            table.insert(dataList, v)
        end
    end
    return dataList
end

HMWYMgr.GetTargetData = function(area)
    local list = HMWYMgr.GetActiveEventsByArea(area)
    for k, v in pairs(list) do
        local pUnLock = HMWYMgr.CheckEventIsUnLock(v);
        local pPass = HMWYMgr.CheckEventIsComplete(v);
        if (pUnLock and not pPass) then
            return v
        end
    end
end


HMWYMgr.CheckEventIsUnLock = function(event)
    if not event then return false end

    if event.unlockType == 0 or not event.unlockParam or event.unlockParam == "" then
        return true
    end

    if event.unlockType == 1 then
        local eventMap = DataExHelper.GetActivityMapEventMap()
        if eventMap then
            local unlockEvent = eventMap[event.unlockParam]
            if unlockEvent then
                return HMWYMgr.CheckEventIsComplete(unlockEvent)
            end
        end
        return false
    else
        LuaDebug.error("Config Error: 不支持的unlockType=" .. tostring(event.unlockType))
        return false
    end
end

HMWYMgr.CheckEventIsComplete = function(event)
    if not event or not event.type then return false end

    if event.type == 1 then
        return DataHelper.CheckNovelComplete(event.eventParam)
    elseif event.type == 2 or event.type == 4 or event.type == 5 then
        return DataHelper.CheckDungeonComplete(event.eventParam)
    elseif event.type == 3 then
        return HMWYMgr.CheckGameState(event.eventParam) == 2
    else
        return true
    end
end



HMWYMgr.CheckGameState = function(id)
    local state = -1
    local data = DataMgr.Player.HMWYGame.Events[id]
    if (data ~= nil) then
        state = data.State
        if (state == 1 and LuaMgr.Timestamp() >= data.EndTime) then
            state = 2
        end
    end
    return state
end

HMWYMgr.CheckEggEventId = function(id)
    local data = DataMgr.Player.HMWYGame.EggEventId[id]
    return (data ~= nil and data == 1)
end

HMWYMgr.GetCharConfigMap = function()
    if (HMWYMgr.CharMap ~= nil) then
        return HMWYMgr.CharMap
    end
    HMWYMgr.CharMap = {}
    local employeeConfigs = ConfigMgr.Config.HmwyRelicStatsMap
    for key, value in pairs(employeeConfigs) do
        local config = value
        local employeeData = {}
        employeeData.ID = config.Id
        employeeData.Config = config
        employeeData.Rare = HeroMgr.GetHeroNowRare(employeeData.ID)
        local characterConfig = ConfigMgr.Config.characterTable[employeeData.ID]
        employeeData.Name = LuaMgr.GetLangText(characterConfig.namelan)
        employeeData.BeEmplooyed = false
        HMWYMgr.CharMap[employeeData.ID] = employeeData
    end
    return HMWYMgr.CharMap
end

HMWYMgr.CheckTalentIsUnLock = function(event)
    if not event then
        return false
    end
    if (type(event.Prerequisites) == "table") then
        return HMWYMgr.CheckTalentIsUnLockByArr(event)
    else
        return HMWYMgr.CheckTalentIsUnLockByNum(event)
    end
end

HMWYMgr.CheckTalentIsUnLockByNum = function(event)
    if event.Prerequisites == nil or event.Prerequisites == 0 then
        return true
    end

    local eventMap = ConfigMgr.Config.HmwyTechTreeMap
    local unlockEvent = eventMap[event.Prerequisites .. ""]
    if unlockEvent then
        return HMWYMgr.CheckTalentIsComplete(unlockEvent)
    end
    return false
end

HMWYMgr.CheckTalentIsUnLockByArr = function(event)
    if event.Prerequisites == nil or event.Prerequisites[1] == nil or event.Prerequisites[1] == 0 then
        return true
    end

    local eventMap = ConfigMgr.Config.HmwyTechTreeMap
    for k, v in pairs(event.Prerequisites) do
        local unlockEvent = eventMap[v .. ""]
        if unlockEvent then
            if HMWYMgr.CheckTalentIsComplete(unlockEvent) then
                return true
            end
        end
    end
    return false
end


HMWYMgr.CheckTalentIsComplete = function(event)
    return DataMgr.Player.HMWYGame.TechTree[event.Id] ~= nil
end

HMWYMgr.GetUnlockTalentBuffList = function()
    if (DataMgr.Player.HMWYGame == nil or DataMgr.Player.HMWYGame.TechTree == nil) then
        return {}
    end
    local list = {}
    for k, v in pairs(DataMgr.Player.HMWYGame.TechTree) do
        local event = ConfigMgr.Config.HmwyTechTreeMap[k]
        if (event.BuffID ~= nil and #event.BuffID > 0) then
            table.insert(list, event.BuffID)
        end
    end
    return list
end

HMWYMgr.ClearData = function()
    HMWYMgr.eventsListAreaMap = {}
end

HMWYMgr.GetActiveEventsByArea = function(area)
    if not area then return {} end

    if not HMWYMgr.eventsListAreaMap[area] then
        HMWYMgr.eventsListAreaMap[area] = {}

        if ConfigMgr.Config and ConfigMgr.Config.activityMapEventList then
            for _, v in ipairs(ConfigMgr.Config.activityMapEventList) do
                if v.area == area then
                    table.insert(HMWYMgr.eventsListAreaMap[area], v)
                end
            end
        end
    end

    return HMWYMgr.eventsListAreaMap[area]
end

HMWYMgr.SetShowAni = function(_bShow)
    HMWYMgr.showAni = _bShow
end

HMWYMgr.CheckShowAni = function()
    return HMWYMgr.showAni
end



HMWYMgr.CheckEntranceRedDot = function()
    local main = HMWYMgr.CheckMainRedDot()
    local talent = HMWYMgr.CheckTalentRedDot()
    local bPlay = HMWYMgr.CheckPlayRedDot()
    local bStory = HMWYMgr.CheckStoryRedDot()
    if (main or talent or bPlay or bStory) then
        return 1
    else
        return 0
    end
end

HMWYMgr.CheckMainRedDot = function()
    local bRed = false
    if (not RedMgr.Singleton:CheckRedCondition("17821") and bRed) then
        bRed = false
    end
    if (bRed) then
        RedMgr.Singleton:UpdateClientRedData("17821", 1)
    else
        RedMgr.Singleton:UpdateClientRedData("17821", 0)
    end
    return bRed
end

HMWYMgr.CheckTalentRedDot = function()
    local bRed = false
    for k, v in pairs(ConfigMgr.Config.HmwyTechTreeMap) do
        if (HMWYMgr.CheckTalentIsUnLock(v) == 3) then
            if (not HMWYMgr.CheckTalentIsComplete(v)) then
                local cost = v.UnConsump[1]
                local count = DataHelper.GetItemCountById(cost.id)
                if cost.count <= count then
                    bRed = true
                    break
                end
            end
        end
    end
    if (bRed) then
        RedMgr.Singleton:UpdateClientRedData("17822", 1)
    else
        RedMgr.Singleton:UpdateClientRedData("17822", 0)
    end
    return bRed
end

HMWYMgr.CheckPlayRedDot = function()
    local bRed = false
    local list = HMWYMgr.GetActiveEventsByArea("HMWY5")
    for k, v in pairs(list) do
        local state = HMWYMgr.CheckGameState(v.id)
        if (state == 2) then
            bRed = true;
            break;
        end
    end
    if (bRed) then
        RedMgr.Singleton:UpdateClientRedData("17823", 1)
    else
        RedMgr.Singleton:UpdateClientRedData("17823", 0)
    end
    return bRed
end


HMWYMgr.CheckStoryRedDot = function()
    local bRed = false
    local list = HMWYMgr.GetActiveEventsByArea("HMWY4")
    for k, v in pairs(list) do
        local state = HMWYMgr.CheckEventIsUnLock(v) and not HMWYMgr.CheckEventIsComplete(v)
        if (state) then
            bRed = true;
            break;
        end
    end
    return bRed
end







return HMWYMgr