require("ViewModel/LHSA/LHSAConst")

LHSAMgr = {
    eventsListAreaMap = {},
    showAni = true,
    isInit = false,
    levelType = 0,
    bPlay = false,
    CharMap = nil,
    eventCompleteTag = { "kfs", "khg", "tg", "zhong", "liang", "you" },
    redEventMap = {},
}
local this = {}


LHSAMgr.EventType = {
    Repeat = "LHSA1",
    MainLine = "LHSA2",
    Hard = "LHSA3",
}

LHSAMgr.GetTimeStr = function()
    local d, h, m = 0, 0, 0
    local timeStr = "";
    if DataExHelper.CommonActivityCheck(ActivityKey.LHSA) then
        local daqin = DataExHelper.GetDataExByTag(ActivityKey.LHSA);
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

LHSAMgr.SetPlayerAnimation = function(_bPlay)
    LHSAMgr.bPlay = _bPlay
end

LHSAMgr.GetPlayerAnimation = function()
    return LHSAMgr.bPlay
end

LHSAMgr.SetCurTap = function(_tap)
    LHSAMgr.curTap = _tap
end

LHSAMgr.GetCurTap = function()
    return LHSAMgr.curTap
end

LHSAMgr.SetSelectedType = function(_type)
    LHSAMgr.selectedType = _type
end

LHSAMgr.GetSelectedType = function()
    return LHSAMgr.selectedType
end

LHSAMgr.GetNovelDatas = function()
    if this.NovelConfigs == nil then
        this.NovelConfigs = DataExHelper.EX_GetEventListByArea(LHSALevelType.Story)
    end
    local allDatas = {}
    for i = 1, #this.NovelConfigs do
        local data = this.NovelConfigs[i]
        data.Index = i
        data.IsNew = false
        data.Type = tonumber(data.classId)
        data.UnlockDesc = ""
        local isComplete = LHSAMgr.CheckEventIsComplete(data)
        local isUnlock = false
        if  isComplete== true then
            data.Status = CommonRewardItem.Status.Got
        else
            local tempIsUnlock, unlockEventName = LHSAMgr.CheckEventIsUnLock(data)
            isUnlock = tempIsUnlock
            if unlockEventName == nil then
                unlockEventName = ""
            end
            if isUnlock == true then
                data.Status = CommonRewardItem.Status.None
            else
                data.Status = CommonRewardItem.Status.Lock
                local lanText = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30035")
                local lannName = LuaMgr.GetLangText(unlockEventName)
                data.UnlockDesc = string.format(lanText, lannName)
            end
        end
        data.Name = LuaMgr.GetLangText(data.namelan)
        local key = DataMgr.Player.uid .. "LHSA_" .. data.id
        if isComplete == false and isUnlock == true and PlayerPrefs.GetInt(key) == 0 then
            data.IsNew = true
        end
        table.insert(allDatas, data)
    end
    return allDatas
end



LHSAMgr.GetDungeonDatas = function(dungeonType)
    if this.mapEventGroup == nil then

        this.mapEventGroup = {}
        for key, value in pairs(LHSAMgr.EventType) do
            this.mapEventGroup[value] = DataExHelper.EX_GetEventListByArea(value)
        end
    end
    local configs = this.mapEventGroup[dungeonType]
    local finishDatas = {}
    local allDatas = {}
    for i = 1, #configs do
        local data = configs[i]
        data.Index = i
        data.IsFirst = i == 1
        data.IsLast = i == #configs
        data.EventType = dungeonType
        data.Name = LuaMgr.GetLangText(configs[i].namelan)
        data.ScoreLan = ""
        data.Status = CommonRewardItem.Status.Lock
        data.IsNew = false
        data.UnlockDesc = ""
        local isComplete = LHSAMgr.CheckEventIsComplete(data)
        local isUnlock = false
        if isComplete == true then
            data.ScoreLan = LHSAMgr.GetEventCompleteTag(data)
            data.Status = CommonRewardItem.Status.Got
        else
            local tempIsUnlock, unlockEventName = LHSAMgr.CheckEventIsUnLock(data)
            if unlockEventName == nil then
                unlockEventName = ""
            end
            isUnlock = tempIsUnlock
            if isUnlock == true then
                data.Status = CommonRewardItem.Status.None
            else
                data.Status = CommonRewardItem.Status.Lock
                local lanText = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30036")
                local lannName = LuaMgr.GetLangText(unlockEventName)
                data.UnlockDesc = string.format(lanText, lannName)
            end
        end
        local key = DataMgr.Player.uid .. "LHSA_" .. data.id;
        if data.Status == CommonRewardItem.Status.Got then
            table.insert(finishDatas, data)
        elseif data.Status == CommonRewardItem.Status.None and PlayerPrefs.GetInt(key) == 0 then
            data.IsNew = true
        end
        table.insert(allDatas, data)
    end
    return finishDatas, allDatas
end

LHSAMgr.CheckEventIsUnLock = function(event)
    if not event then return false end
    if event.unlockType == 0 or not event.unlockParam or event.unlockParam == "" then
        return true
    end

    if event.unlockType == 1 then
        local eventMap = DataExHelper.GetActivityMapEventMap()
        if eventMap then
            local unlockEvent = eventMap[event.unlockParam]
            if unlockEvent then
                return LHSAMgr.CheckEventIsComplete(unlockEvent), unlockEvent.namelan
            end
        end
        return false
    else
        LuaDebug.error("Config Error: 不支持的unlockType=" .. tostring(event.unlockType))
        return false
    end
end

LHSAMgr.CheckEventIsUnLockTime = function(event)
    local curTimeStamp = LuaMgr.Timestamp();
    if event.openDate == 0 and event.closeDate == 0 then
        return true, nil;
    end
    local bShow = curTimeStamp >= event.openDate and curTimeStamp <= event.closeDate
    local timeStr = nil
    if (curTimeStamp < event.openDate) then
        local interval = event.openDate - curTimeStamp
        timeStr = TimeString(interval) .. ConfigMgr.LangGlobal("2092")
    end
    return bShow, timeStr
end

LHSAMgr.CheckEventIsComplete = function(event)
    if not event or not event.type then return false end

    if event.type == 1 then
        return DataHelper.CheckNovelComplete(event.eventParam)
    elseif event.type == 2 or event.type == 4 or event.type == 5 then
        return DataHelper.CheckDungeonComplete(event.eventParam)
    elseif event.type == 3 then
        return LHSAMgr.CheckGameState(event.eventParam) >= 0
    else
        return true
    end
end


LHSAMgr.CheckGameState = function(id)
    local hackGame = DataMgr.Player.CaseGame
    if hackGame == nil or hackGame.LevelMap == nil then
        return -1
    end
    local levelConfig = ConfigMgr.Config.CaseLevelMap[id]
    if (levelConfig == nil) then
        return -1
    else
        if (hackGame.LevelMap[id] ~= nil) then
            return hackGame.LevelMap[id]
        end
    end
    return -1
end

LHSAMgr.GetEventCompleteTag = function(curEventCfg)
    if curEventCfg.type == 1 then
        if DataHelper.CheckNovelComplete(curEventCfg.eventParam) then
            return LHSAMgr.eventCompleteTag[2]
        end
    elseif curEventCfg.type == 2 then
        local dungeon = DataMgr.Player.dungeonRecords[curEventCfg.eventParam];
        if dungeon ~= nil and dungeon.completeCount > 0 then
            if curEventCfg.area == "LHSA1" then

                return LHSAMgr.eventCompleteTag[1]
            elseif curEventCfg.area == "LHSA2" then

                return LHSAMgr.eventCompleteTag[3]
            elseif curEventCfg.area == "LHSA3" then

                if dungeon.historyRating == "S" then
                    return "LangGlobalLan_LangGlobal_name_2417"
                elseif dungeon.historyRating == "A" then
                    return "LangGlobalLan_LangGlobal_name_2419"
                elseif dungeon.historyRating == "B" then
                    return "LangGlobalLan_LangGlobal_name_2418"
                end
            end
        end
    elseif curEventCfg.type == 3 then

        local state = LHSAMgr.CheckGameState(curEventCfg.eventParam)
        if state >= 0 then
            if state == 1 then
                return "yz"
            else
                return "wz"
            end
        end
    end
    return nil;
end

LHSAMgr.SetNeedOpenDungeonUI = function(isNeed)
    this.isNeedOpenDungeonUI = isNeed
end

LHSAMgr.GetNeedOpenDungeonUI = function()
    return this.isNeedOpenDungeonUI
end

LHSAMgr.ClearData = function()
    LHSAMgr.eventsListAreaMap = {}
end





LHSAMgr.SafeText = function(value)
    if value == nil then return "" end
    return tostring(value)
end

LHSAMgr.IsEmpty = function(value)
    return value == nil or value == ""
end


LHSAMgr.GetMapConfig = function(mapName, key)
    if not ConfigMgr or not ConfigMgr.Config then return nil end

    local map = ConfigMgr.Config[mapName]
    if not map or key == nil then return nil end

    local cfg = map[key]
    if cfg ~= nil then return cfg end

    cfg = map[tostring(key)]
    if cfg ~= nil then return cfg end

    local numberKey = tonumber(key)
    if numberKey ~= nil then
        cfg = map[numberKey]
        if cfg ~= nil then return cfg end
    end

    return nil
end


LHSAMgr.GetConfigText = function(rawText, langKey)
    if not LHSAMgr.IsEmpty(langKey) and LuaMgr and LuaMgr.GetLangText then
        local key = tostring(langKey)
        local langText = LuaMgr.GetLangText(key)
        if not LHSAMgr.IsEmpty(langText) and tostring(langText) ~= key then
            return tostring(langText)
        end
    end

    return LHSAMgr.SafeText(rawText)
end


LHSAMgr.ParseConfigList = function(value)
    local result = {}

    if value == nil then
        return result
    end

    if type(value) == "table" then
        for i = 1, #value do
            table.insert(result, value[i])
        end


        if #result == 0 then
            for _, v in pairs(value) do
                table.insert(result, v)
            end
        end

        return result
    end

    local text = tostring(value)
    text = string.gsub(text, "%[", "")
    text = string.gsub(text, "%]", "")

    for item in string.gmatch(text, "[^;,%s]+") do
        table.insert(result, item)
    end

    return result
end

LHSAMgr.ClampNumber = function(value, minValue, maxValue)
    local num = tonumber(value) or 0

    if minValue ~= nil and num < minValue then
        num = minValue
    end

    if maxValue ~= nil and num > maxValue then
        num = maxValue
    end

    return num
end


LHSAMgr.BuildWitnessList = function(eventConfig)
    local witnessList = {}
    if not eventConfig then return witnessList end

    local contentIds = LHSAMgr.ParseConfigList(eventConfig.EventContents)
    for i = 1, #contentIds do
        local contentId = contentIds[i]
        local contentConfig = LHSAMgr.GetMapConfig("CaseEventContentMap", contentId)

        if contentConfig then
            table.insert(witnessList, {
                id = contentId,
                name = LHSAMgr.GetConfigText(contentConfig.Name, contentConfig.NameLan),
                content = LHSAMgr.GetConfigText(contentConfig.Text, contentConfig.TextLan),
                icon = contentConfig.Icon,
            })
        else
            table.insert(witnessList, {
                id = contentId,
                name = LuaMgr.GetLangText("LHSAMgr_0"),
                content = LuaMgr.GetLangText("LHSAMgr_1") .. tostring(contentId) .. "]",
                icon = nil,
            })
        end
    end

    return witnessList
end


LHSAMgr.BuildEvidenceList = function(eventConfig)
    local evidenceList = {}
    if not eventConfig then return evidenceList end

    local eventName = LHSAMgr.GetConfigText(eventConfig.EviNameContent, eventConfig.EviNameContentLan)
    local evidenceContent = LHSAMgr.GetConfigText(eventConfig.EviContent, eventConfig.EviContentLan)

    if not LHSAMgr.IsEmpty(eventConfig.EviIcon) or not LHSAMgr.IsEmpty(evidenceContent) then
        table.insert(evidenceList, {
            name = LHSAMgr.IsEmpty(eventName) and LuaMgr.GetLangText("LHSAMgr_2") or eventName,
            content = evidenceContent,
            icon = eventConfig.EviIcon,
        })
    end

    return evidenceList
end


LHSAMgr.GetCaseConstants = function()
    if ConfigMgr and ConfigMgr.Config and ConfigMgr.Config.CaseConstants then
        return ConfigMgr.Config.CaseConstants
    end
    return {}
end






LHSAMgr.GetSortedAssessConfigs = function()
    if not ConfigMgr or not ConfigMgr.Config or not ConfigMgr.Config.CaseAssessMap then
        return {}
    end

    local configs = {}
    for _, assessConfig in pairs(ConfigMgr.Config.CaseAssessMap) do
        if type(assessConfig) == "table" then
            table.insert(configs, assessConfig)
        end
    end

    table.sort(configs, function(a, b)
        return (tonumber(a.AssessRangeMin) or 0) < (tonumber(b.AssessRangeMin) or 0)
    end)

    return configs
end

LHSAMgr.GetActiveEventsByArea = function(area)
    if not area then return {} end

    if not LHSAMgr.eventsListAreaMap[area] then
        LHSAMgr.eventsListAreaMap[area] = {}

        if ConfigMgr.Config and ConfigMgr.Config.activityMapEventList then
            for _, v in ipairs(ConfigMgr.Config.activityMapEventList) do
                if v.area == area then
                    table.insert(LHSAMgr.eventsListAreaMap[area], v)
                end
            end
        end
    end

    return LHSAMgr.eventsListAreaMap[area]
end

LHSAMgr.SetShowAni = function(_bShow)
    LHSAMgr.showAni = _bShow
end

LHSAMgr.CheckShowAni = function()
    return LHSAMgr.showAni
end


LHSAMgr.FindAssessConfig = function(score)
    local configs = LHSAMgr.GetSortedAssessConfigs()
    if #configs == 0 then return nil end

    local matched = nil

    for i = 1, #configs do
        local assessConfig = configs[i]
        local minScore = tonumber(assessConfig.AssessRangeMin)
        local maxScore = tonumber(assessConfig.AssessRangeMax)

        if minScore ~= nil and maxScore ~= nil then

            if score >= minScore and (score < maxScore) then
                matched = assessConfig
                break
            end
        end
    end


    if matched == nil then
        for i = 1, #configs do
            local assessConfig = configs[i]
            local minScore = tonumber(assessConfig.AssessRangeMin)
            local maxScore = tonumber(assessConfig.AssessRangeMax)

            if minScore ~= nil and maxScore ~= nil and score >= minScore and score <= maxScore then
                matched = assessConfig
                break
            end
        end
    end

    return matched
end

LHSAMgr.GetTexture = function(resId)
    return LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/LHSA/%s.png", resId));
end

LHSAMgr.SetDungeonPageIndex = function(index)
    this.dungeonPageIndex = index
end

LHSAMgr.GetDungeonPageIndex = function()
    return this.dungeonPageIndex or 1
end


LHSAMgr.CheckEntranceRedDot = function()
    local main = LHSAMgr.SetEventRed()
    local mission = LHSAMgr.CheckMissionEntranceRedDot()
    if (main > 0 or mission) then
        return 1
    else
        return 0
    end
end

LHSAMgr.SetEventRed = function()
    local redList = { 0, 0, 0, 0, 0 }
    LHSAMgr.redEventMap = {}

    for i = 1, 4, 1 do
        local area = LHSALevel2StrType[i];
        local eventList = LHSAMgr.GetActiveEventsByArea(area);
        for p, v in ipairs(eventList) do
            local key = DataMgr.Player.uid .. "LHSA_" .. v.id;
            if not LHSAMgr.CheckEventIsComplete(v) and LHSAMgr.CheckEventIsUnLock(v) and PlayerPrefs.GetInt(key) == 0 then
                redList[i] = 1;
                LHSAMgr.redEventMap[v.id] = 1;
            end
        end
    end
    RedMgr.Singleton:UpdateClientRedData("18502", redList[1]);
    RedMgr.Singleton:UpdateClientRedData("18504", redList[2]);
    RedMgr.Singleton:UpdateClientRedData("18505", redList[3]);
    RedMgr.Singleton:UpdateClientRedData("18503", redList[4]);
    local redBox = redList[1] + redList[2] + redList[3];
    RedMgr.Singleton:UpdateClientRedData("18507", redBox > 0 and 1 or 0);
    return redBox + redList[4];
end

LHSAMgr.CheckMissionEntranceRedDot = function()
    local bRed = false
    local questEvents = DataExHelper.Check_ConfigQuestEventByText("LHSA");
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
        RedMgr.Singleton:UpdateClientRedData("18506", 1)
    else
        RedMgr.Singleton:UpdateClientRedData("18506", 0)
    end
    return bRed
end



return LHSAMgr