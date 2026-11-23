require("DH/DHConst")
PlayerDHMgr = {}

local this = {
isInit = false,
bGetReward = false,
ackMonsterType = nil,
effectFlyPosTab = {},
PlayDissolve = false,
bPlay = false,
delay = nil,
settlementType = 0,
levelType = 0,






};

PlayerDHMgr.Init = function()
    if (this.isInit) then return end

    this.isInit = true;


end

PlayerDHMgr.Clear = function()
    if this.delay ~= nil then
        coroutine_runner.stop(this.delay)
        this.delay = nil
    end
    this.isInit = false;
end

PlayerDHMgr.GetExploreData = function(id)
    return DataMgr.Player.DunHuang.Explore[id]
end

PlayerDHMgr.GetCurExploreReward = function(id)
    local reward = ConfigDHMgr.GetGridReward(DHSurveyGrid.Box2, id)
    local itemConfig = ConfigMgr.Config.itemMap[reward.id]
    if (itemConfig == nil) then
        LuaDebug.error(reward.id .. "  没有在ConfigMgr.Config.itemMap配，报错了")
        return 0
    end
    local itemData = DataMgr.Player.items[itemConfig.id]
    local num = 0
    if itemData ~= nil then
        num = itemData.count0
    end
    return num;
end


PlayerDHMgr.IsMemberLive = function()
    return DataMgr.Player.DunHuang.Hp > 0;
end



PlayerDHMgr.Explore = function(position)
    ApiMgr.Request("dunhuang/explore/explore", { Position = position }, true, this.ExploreResponse, nil, true, true);
end


this.ExploreResponse = function(result)
    LuaMgr.InvokeUIEventListeners(UIEventConst.QinSurveyMapRefresh);
    if (this.specialExploreType == DHSurveyGrid.Box) then
        LuaMgr.ShowLuaPanel(UIName.DHAllusionViewModel, DataMgr.Player.DunHuang.StageId);
        this.specialExploreType = nil;
    end
end

PlayerDHMgr.SetSpecialExploreType = function(type)
    this.specialExploreType = type;
end


PlayerDHMgr.Settlement = function(type)
    this.settlementType = type;
    ApiMgr.Request("dunhuang/explore/settlement", {}, true, this.SettlementResponse, nil, true, true);
end


this.SettlementResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        if (this.settlementType == DHSurveyResultType.Win) then
            LuaMgr.ShowLuaPanel(UIName.DHSurveyResultViewModel, this.settlementType, data.result.Rewards);
        elseif (this.settlementType == DHSurveyResultType.Lose) then
            LuaMgr.ShowLuaPanel(UIName.DHSurveyResultViewModel, this.settlementType, data.result.Rewards);
        elseif (this.settlementType == DHSurveyResultType.Quit
                or this.settlementType == DHSurveyResultType.Leave) then
            LuaMgr.ShowLuaPanel(UIName.DHSeekViewModel);
        end
    end
end


PlayerDHMgr.IsUnExplore = function()
    local grid;
    local qinMap = DataMgr.Player.DunHuang.DHMap;
    local len = #qinMap;
    for i = 1, len do
        grid = qinMap[i];
        if (grid.State == DHSurveyState.Can or grid.State == DHSurveyState.Stop) then
            return true;
        end
        if (grid.State == DHSurveyState.Already) then
            if (grid.Typ ~= DHSurveyGrid.None
                    or grid.Typ ~= DHSurveyGrid.Start
                    or grid.Typ ~= DHSurveyGrid.End
                    or grid.Typ ~= DHSurveyGrid.Monster
                    or grid.Typ ~= DHSurveyGrid.Monster1
                    or grid.Typ ~= DHSurveyGrid.Monster2) then
                return true;
            end
        end
    end
    return false;
end


PlayerDHMgr.SetAckMonsterType = function(ackType)
    this.ackMonsterType = ackType
end


PlayerDHMgr.GetAckMonsterType = function()
    return this.ackMonsterType
end


PlayerDHMgr.SetEffectFlyPos = function(type, pos)
    if (this.effectFlyPosTab == nil) then
        this.effectFlyPosTab = {}
    end
    this.effectFlyPosTab[type] = pos
end


PlayerDHMgr.GetEffectFlyPos = function(type)
    if (this.effectFlyPosTab == nil) then
        return Vector2.zero
    end
    return this.effectFlyPosTab[type]
end


PlayerDHMgr.SetPlayDissolve = function(bPlay)
    this.PlayDissolve = bPlay
end


PlayerDHMgr.GetPlayDissolve = function()
    return this.PlayDissolve;
end

PlayerDHMgr.SetCanGetReward = function(bCan)
    if (bCan and not this.bGetReward) then
        this.bGetReward = bCan

        if this.delay ~= nil then
            coroutine_runner.stop(this.delay)
            this.delay = nil
        end
        this.delay = coroutine_runner.start(function()
            coroutine_runner.wait(1.5)
            this.bGetReward = false
            this.delay = nil
        end)
        return
    end
    if (not bCan and this.delay ~= nil) then
        coroutine_runner.stop(this.delay)
        this.delay = nil
    end
    this.bGetReward = bCan
end


PlayerDHMgr.GetCanGetReward = function()
    return this.bGetReward;
end


PlayerDHMgr.GetMonster = function(index)
    return DataMgr.Player.DunHuang.MonsterMap[tostring(index)];
end


PlayerDHMgr.GetToolsCount = function(id)
    local tools = DataMgr.Player.DunHuang.Tools;
    if (tools ~= nil) then
        local count = tools[id];
        return count == nil and 0 or count;
    end
    return 0;
end



PlayerDHMgr.UseTools = function(itemId, index)
    ApiMgr.Request("dunhuang/explore/useTools", { ItemId = itemId, Index = index }, true, this.UseToolsResponse, nil,
        true, true);
end


this.UseToolsResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        LuaMgr.HidePanel(UIName.DHSurveyResultViewModel);
        LuaMgr.InvokeUIEventListeners(UIEventConst.QinSurveyUseTools, data.result);
    end
end


PlayerDHMgr.Battle = function(index)
    ApiMgr.Request("dunhuang/explore/battle", { Index = index }, true, this.BattleResponse, nil, true, true);
end


this.BattleResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        LuaMgr.HidePanel(UIName.DHSurveyResultViewModel);
        LuaMgr.InvokeUIEventListeners(UIEventConst.QinBattleCountry, data.result);
    end
end


PlayerDHMgr.IsChallengeBoss = function()
    return DataMgr.Player.DunHuang.ChallengeBoss;
end


PlayerDHMgr.SetPlayAudio = function(bPlay)
    this.bPlay = bPlay
end


PlayerDHMgr.GetPlayAudio = function()
    return this.bPlay;
end


PlayerDHMgr.IsKillBoss = function()
    local grid;
    local qinMap = DataMgr.Player.DunHuang.DHMap;
    local len = #qinMap;
    for i = 1, len do
        grid = qinMap[i];
        if (grid.Typ == DHSurveyGrid.Boss and grid.State == DHSurveyState.Get) then
            return true;
        end
    end
    return false;
end


PlayerDHMgr.GetBoxToolsCount = function(stageId, id)
    if (DataMgr.Player.DunHuang.Explore ~= nil) then
        local explore = DataMgr.Player.DunHuang.Explore[stageId];
        if (explore ~= nil and explore.Tools ~= nil) then
            local count = explore.Tools[id];
            return count == nil and 0 or count;
        end
    end
    return 0;
end


PlayerDHMgr.EnterStage = function(stageId)
    ApiMgr.Request("dunhuang/explore/enterStage", { StageId = stageId }, true, this.EnterStageResponse, nil, true, true);
end


this.EnterStageResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        PlayerDHMgr.SetPlayAudio(true)
        LuaMgr.ShowLuaPanel(UIName.DHSurveyViewModel);
    end
end


PlayerDHMgr.GetCurDrawOpenList = function(stageId)
    if (DataMgr.Player.DunHuang.ScrollMap == nil) then
        return {}
    end
    local map = DataMgr.Player.DunHuang.ScrollMap[stageId];
    if (map == nil) then
        return {}
    end
    return map.ScrollGrids
end


PlayerDHMgr.CheckCurDrawMapReward = function(stageId, id)
    local map = DataMgr.Player.DunHuang.ScrollMap[stageId];
    if (map == nil) then
        return false
    end
    return map.GetLines["" .. id] ~= nil
end


PlayerDHMgr.ExploreDraw = function(id, index)
    local curGet = PlayerDHMgr.GetCurExploreReward(id)
    if (curGet == 0) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_21101"));
        return;
    end
    AudioMgr.Singleton:PlayVoice(Path.audio_PATH .. "newUI/enter_click.mp3");
    if (index == nil) then
        ApiMgr.Request("dunhuang/mural/puzzle", { Id = id }, true, this.ExploreDrawResponse, nil, true,
            true);
    else
        ApiMgr.Request("dunhuang/mural/puzzle", { Id = id, Numbers = { index } }, true, this.ExploreDrawResponse, nil,
            true,
            true);
    end
end


this.ExploreDrawResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil and not IsNull(data.result.Rewards)) then
        local reward = json.encode(data.result.Rewards);
        LuaMgr.ShowItemRewared(reward);
    end
    LuaMgr.InvokeUIEventListeners(UIEventConst.QinSurveyMapRefresh);
end


PlayerDHMgr.CheckDHSeekLock = function(_config)
    local type = _config.UnlockType
    local parem = _config["Unlock_" .. type]
    if (parem == nil) then

        return false
    end
    local isLock = false
    if (type == 1) then
        local gridType = ConfigDHMgr.GetGridType(DHSurveyGrid.Box2);
        local curGet = PlayerDHMgr.GetBoxToolsCount(parem, gridType.ItemsID);
        local config = ConfigMgr.Config.DHLevelMap[parem]
        local maxGet = config.DebrisNum / 5
        isLock = curGet ~= maxGet
    else
        local timestamp = LuaMgr.Timestamp()
        isLock = tonumber(parem) > timestamp
    end
    return isLock
end


PlayerDHMgr.SetLevelType = function(levelType)
    this.levelType = levelType;
end


PlayerDHMgr.GetLevelType = function()
    if (this.levelType == 0 or this.levelType == nil) then
        for i = 1, 3 do
            local type = "DH0" .. i;
            local eventList = DataExHelper.EX_GetEventListByArea(type);
            for j, v in ipairs(eventList) do
                local eventData = PlayerDHMgr.GetActivityMapEvent(type, v.id);
                if (eventData ~= nil) then
                    this.levelType = i;
                    return this.levelType;
                end
            end
        end
    end
    if (this.levelType == 0 or this.levelType == nil) then
        this.levelType = 1;
    end
    return this.levelType;
end


PlayerDHMgr.GetActivityMapEvent = function(type, id)
    local data = DataMgr.Player.activityMaps[type];
    if (data ~= nil) then
        return data.activityEvents[id];
    end
    return nil;
end




PlayerDHMgr.CheckEntranceRedDot = function()
    local bStory = PlayerDHMgr.CheckStoryEntranceRedDot()
    local bStage = PlayerDHMgr.CheckStageEntranceRedDot()
    local bExplore = PlayerDHMgr.CheckExploreEntranceRedDot()
    if (bStory or bExplore > 0 or bStage) then
        return 1
    else
        return 0
    end
end


PlayerDHMgr.CheckStoryEntranceRedDot = function()
    local storyRed = false
    for k, v in ipairs(ConfigMgr.Config.activityMapEventList) do
        if (v.area == "DH04") then
            storyRed = PlayerDHMgr.CheckStoryRedDot("DH04", v.id)
            if (storyRed) then
                break
            end
        end
    end
    if (storyRed) then
        RedMgr.Singleton:UpdateClientRedData("16054", 1)
    else
        RedMgr.Singleton:UpdateClientRedData("16054", 0)
    end
    return storyRed
end

PlayerDHMgr.CheckStoryRedDot = function(_area, _id)
    local eventData = nil
    local cacheData = DataMgr.Player.activityMaps[_area];
    if (cacheData ~= nil) then
        eventData = cacheData.activityEvents[_id];
    end
    if (eventData ~= nil) then
        local isRead = DataHelper.CheckNovelComplete(_id);
        if (eventData.complete or isRead) then
            return false
        end
        return true
    end
    return false
end

PlayerDHMgr.CheckStageEntranceRedDot = function()
    local bRed = false
    if (RedMgr.Singleton:CheckRedCondition("16055")) then
        for k, v in ipairs(ConfigMgr.Config.activityMapEventList) do
            for i = 1, 3 do
                if (v.area == "DH0" .. i) then
                    bRed = PlayerDHMgr.CheckStoryRedDot("DH0" .. i, v.id)
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
        RedMgr.Singleton:UpdateClientRedData("16055", 1)
    else
        RedMgr.Singleton:UpdateClientRedData("16055", 0)
    end
    return bRed
end


PlayerDHMgr.CheckExploreEntranceRedDot = function()
    local isOpen = false
    if (RedMgr.Singleton:CheckRedCondition("16057")) then
        if ConfigMgr.Config.DHLevelMap then
            for k, v in pairs(ConfigMgr.Config.DHLevelMap) do
                local isLock = PlayerDHMgr.CheckDHSeekLock(v)
                if (not isLock) then
                    local gridType = ConfigDHMgr.GetGridType(DHSurveyGrid.Box2);
                    local curGet = PlayerDHMgr.GetBoxToolsCount(v.Id, gridType.ItemsID);
                    local maxGet = v.DebrisNum / 5
                    if (curGet < maxGet) then
                        isOpen = true
                        break
                    end
                end
            end
        end
    end

    local sOpen = PlayerDHMgr.CheckExploreRedDot()

    if (sOpen) then
        isOpen = true
    end

    if (isOpen) then
        RedMgr.Singleton:UpdateClientRedData("16057", 1)
    else
        RedMgr.Singleton:UpdateClientRedData("16057", 0)
    end
    RedMgr.Singleton:Refresh()
    return isOpen and 1 or 0
end


PlayerDHMgr.CheckExploreRedDot = function()
    if ConfigMgr.Config.DHLevelMap then
        for k, v in pairs(ConfigMgr.Config.DHLevelMap) do
            local getNum = PlayerDHMgr.GetCurExploreReward(v.Id)
            if (getNum > 0) then
                return true
            end
        end
    end
    return false
end


