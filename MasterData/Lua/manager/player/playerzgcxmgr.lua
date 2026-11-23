require("ZGCX/ZGCXConst")
PlayerZGCXMgr = {}

local this = {
isInit = false,
levelType = 0,
bPlay = false,
};

PlayerZGCXMgr.Init = function()
    if (this.isInit) then return end
    this.isInit = true;
end

PlayerZGCXMgr.Clear = function()
    this.isInit = false;
end


PlayerZGCXMgr.GetLightGameRewardsData = function()
    if not IsNull(DataMgr.Player.LightGame) and not IsNull(DataMgr.Player.LightGame.rewards) then
        return DataMgr.Player.LightGame.rewards
    else
        return {}
    end
end

PlayerZGCXMgr.GetLightGameRandomData = function()
    if not IsNull(DataMgr.Player.LightGame) and not IsNull(DataMgr.Player.LightGame.random) then
        return DataMgr.Player.LightGame.random
    else
        return {}
    end
end


PlayerZGCXMgr.Search = function()
    ApiMgr.Request("lightgame/random", {}, true, this.SearchResponse, nil, true, true);
end


this.SearchResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        LuaMgr.InvokeUIEventListeners(UIEventConst.ZGCXMsgShow);
    end
end

PlayerZGCXMgr.InitMainAreaUnlockData = function()
    if (this.bInitMainAreaUnlockData == nil) then
        this.bInitMainAreaUnlockData = true
    else
        return
    end
    this.unlockDataMap = {}
    for i, v in ipairs(ConfigMgr.Config.activityMapGroupList) do
        if v.area == "ZGCX" then
            local cache = {}
            cache.bShown = PlayerZGCXMgr.CheckMapGroupTime(v)
            cache.config = v
            table.insert(this.unlockDataMap, cache)
        end
    end
end

PlayerZGCXMgr.CheckMapGroupTime = function(group)
    local curTimeStamp = LuaMgr.Timestamp();
    if group.openDate == 0 and group.closeDate == 0 then
        return true, nil;
    end
    local bShow = curTimeStamp >= group.openDate and curTimeStamp <= group.closeDate
    local timeStr = nil
    if (curTimeStamp < group.openDate) then
        local interval = group.openDate - curTimeStamp
        timeStr = TimeString(interval) .. ConfigMgr.LangGlobal("2092")
    end
    return bShow, timeStr
end

PlayerZGCXMgr.GetShownNum = function()
    local index = 0
    for i, v in ipairs(this.unlockDataMap) do
        if v.bShown then
            index = index + 1
        end
    end
    return index
end

PlayerZGCXMgr.CheckCurShownIndex = function()
    local index = 0
    for i, v in ipairs(this.unlockDataMap) do
        if not v.bShown then
            local canShow = PlayerZGCXMgr.CheckMapGroupTime(v.config)
            if (canShow) then
                index = i
                v.bShown = true
            end
        end
    end
    return index
end

PlayerZGCXMgr.GetUnlockDataMap = function()
    return this.unlockDataMap
end

PlayerZGCXMgr.CheckFinish = function(_config)
    local isFinish = false
    if (_config.area == ZGCXLevelType.Repeat or _config.area == ZGCXLevelType.Main or _config.area == ZGCXLevelType.Difficult) then
        local record = DataMgr.Player.dungeonRecords[_config.eventParam];
        if (record ~= nil and record.completeCount > 0) then
            isFinish = true
        end
    elseif (_config.area == ZGCXLevelType.Story) then
        isFinish = DataHelper.CheckNovelComplete(_config.id);
    else
        local rewardData = PlayerZGCXMgr.GetLightGameRewardsData();
        if (rewardData ~= nil and rewardData[_config.eventParam] ~= nil) then
            isFinish = true
        end
    end
    return isFinish
end

PlayerZGCXMgr.GetEventsNum = function()
    local finishNum = 0
    local totalNum = 0
    for k, v in ipairs(ConfigMgr.Config.activityMapEventList) do
        if(ZGCXLevelStrType[v.area] ~= nil)then
            if (PlayerZGCXMgr.CheckFinish(v)) then
                finishNum = finishNum + 1
            end
            totalNum = totalNum + 1
        end
    end
    return { finishNum, totalNum }
end

PlayerZGCXMgr.SetPlayerAnimation = function(_bPlay)
    this.bPlay = _bPlay
end

PlayerZGCXMgr.GetPlayerAnimation = function()
    return this.bPlay
end

PlayerZGCXMgr.SetSelectedType = function(_type)
    this.selectedType = _type
end

PlayerZGCXMgr.GetSelectedType = function()
    return this.selectedType
end

PlayerZGCXMgr.SetCurTap = function(_tap)
    this.curTap = _tap
end

PlayerZGCXMgr.GetCurTap = function()
    return this.curTap
end



PlayerZGCXMgr.CheckEntranceRedDot = function()
    local bStage = PlayerZGCXMgr.CheckStageEntranceRedDot()
    local bStory = PlayerZGCXMgr.CheckTaskRedDot()
    if (bStory or bStage) then
        return 1
    else
        return 0
    end
end

PlayerZGCXMgr.CheckStageEntranceRedDot = function()
    local bRed = false
    local numTab = PlayerZGCXMgr.GetEventsNum()
    local finish = numTab[1] == numTab[2]   
    if (RedMgr.Singleton:CheckRedCondition("16405") and not finish) then
        bRed = true
    end
    if (bRed) then
        RedMgr.Singleton:UpdateClientRedData("16403", 1)
        RedMgr.Singleton:UpdateClientRedData("16405", 1)
    else
        RedMgr.Singleton:UpdateClientRedData("16403", 0)
        RedMgr.Singleton:UpdateClientRedData("16405", 0)
    end
    return bRed
end

PlayerZGCXMgr.CheckTaskRedDot = function()
    if (this.configQuest == nil) then
        this.configQuest = DataExHelper.Check_ConfigQuestEventByGroupId(3085);
    end
    local checkA = false
    for k, v in pairs(this.configQuest) do
        local state = DataExHelper.Check_RewardState(v.id);
        if (v.text == "ZGCX" and state ~= nil and state == 2 and not checkA) then
            checkA = true
            RedMgr.Singleton:UpdateClientRedData("16406", 1)
            RedMgr.Singleton:UpdateClientRedData("16403", 1)
            RedMgr.Singleton:UpdateClientRedData("16410", 1)
            break
        end
    end
    if (not checkA) then
        RedMgr.Singleton:UpdateClientRedData("16406", 0)       
        RedMgr.Singleton:UpdateClientRedData("16410", 0)
    end
    return checkA
end


