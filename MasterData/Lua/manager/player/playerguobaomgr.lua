PlayerGuoBaoMgr = {}

local this = {
    isInit = false,
    novelIndex = 1,
    levelType = nil,
    levelMainIndex = 1,
    levelBattleIndex = 1,
};

PlayerGuoBaoMgr.Init = function()
    if (this.isInit) then return end
    
    this.isInit = true;
end

PlayerGuoBaoMgr.Clear = function()
    this.isInit = false;
    this.novelIndex = 1;
    this.levelType = nil;
    this.levelMainIndex = 1;
    this.levelBattleIndex = 1;
end


this.OnTimer = function()
    this.CheckBuildingRewards();
end


PlayerGuoBaoMgr.CheckActivityStatus = function()
    if (not DataExHelper.CommonActivityCheck(ActivityKey.GuoBao)) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("18344"));
        return false;
    end
    return true;
end


PlayerGuoBaoMgr.GetActivityMapEvent = function(type, id)
    local guobao = DataMgr.Player.activityMaps[type];
    if (guobao ~= nil) then
        return guobao.activityEvents[id];
    end
    return nil;
end


PlayerGuoBaoMgr.GetSimulatedShop = function(group)
    return DataMgr.Player.simulatedShop.building[group];
end


PlayerGuoBaoMgr.GetBuildingYields = function(config)
    local data = PlayerGuoBaoMgr.GetSimulatedShop(config.Group);
    if (data ~= nil) then
        local time = LuaMgr.Timestamp() - data.YieldsStartTime;
        local num = math.floor(time / config.Period) * config.YieldsBase;
        if (num >= config.YieldsLimit) then
            return config.YieldsLimit;
        end
        return math.floor(num);
    end
    return 0;
end


PlayerGuoBaoMgr.GetBuildingRewards = function()
    local config;
    local yields;
    local rewards = {};
    local building = DataMgr.Player.simulatedShop.building;
    local simulatedShopMap = ConfigMgr.Config.SimulatedShopMap;
    for _, v in pairs(building) do
        config = simulatedShopMap[v.id];
        if (config ~= nil and config.Type == 1) then
            yields = PlayerGuoBaoMgr.GetBuildingYields(config);
            if (yields > 0) then
                table.insert(rewards, {id=config.YieldsItem, count=yields});
            end
        end
    end
    return rewards;
end


PlayerGuoBaoMgr.CheckBuildingRewards = function()
    if (DataExHelper.CommonActivityCheck(ActivityKey.GuoBao)) then
        if (IsNull(DataMgr.Player.simulatedShop)) then return end

        local building = DataMgr.Player.simulatedShop.building;
        if (IsNull(building)) then return end

        local simulatedShopMap = ConfigMgr.Config.SimulatedShopMap;
        if (IsNull(simulatedShopMap)) then return end

        if (not LuaMgr.IsPanelOpen(UIName.MainPageViewModel)) then return end

        local config;
        local yields;
        for _, v in pairs(building) do
            config = simulatedShopMap[v.id];
            if (config ~= nil and config.Type == 1) then
                yields = PlayerGuoBaoMgr.GetBuildingYields(config);
                if (yields > 0 and yields >= config.YieldsLimit) then
                    if (not LuaMgr.IsPanelOpen(UIName.GuoBaoMainTipsViewModel)) then
                        LuaMgr.ShowLuaPanel(UIName.GuoBaoMainTipsViewModel);
                    end
                    return;
                end
            end
        end
    end
    LuaMgr.HidePanel(UIName.GuoBaoMainTipsViewModel);
end


PlayerGuoBaoMgr.IsBuildingUnlock = function(config, isTips)
    local unlock = DataMgr.Player.simulatedShop.unlock[config.ID];
    if (unlock ~= nil) then return true end
    if (IsNullOrEmpty(config.UnlockParam)) then return false end
    
    if (isTips) then
        local dungeonConfig = ConfigMgr.Config.dungeonMap[config.UnlockParam];
        local dungeonName = LuaMgr.GetLangText(dungeonConfig.NameLan);
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(ConfigMgr.LangGlobal("10001"), dungeonName));
    end
    return false;
end


PlayerGuoBaoMgr.IsBuildingUpgrade = function(config)
    if (IsNull(config.Cost)) then return true end
    local len = #config.Cost;
    for i = 1, len do
        local item = config.Cost[i];
        local itemCount = PlayerItemMgr.GetItemCountById(item.id);
        if (itemCount < item.count) then
            return false;
        end
    end
    return true;
end


PlayerGuoBaoMgr.SimulatedShopReward = function(callback)
    ApiMgr.Request("simulatedshop/reward", {}, true, callback, nil, true, true);
end


PlayerGuoBaoMgr.SimulatedShopUpgrade = function(group)
    ApiMgr.Request("simulatedshop/upgrade", {Group=group}, true, function(result)
        local data = json.decode(result);
        if (data ~= nil and data.result ~= nil) then
            LuaMgr.InvokeUIEventListeners(UIEventConst.GuoBaoBuildingRefresh, group);
            LuaMgr.HidePanel(UIName.GuoBaoUpLevelViewModel);
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("18342"));
        end
    end, nil, true, true);
end


PlayerGuoBaoMgr.SimulatedShopExchangeChar = function(callback)
    ApiMgr.Request("simulatedshop/exchangeChar", {}, true, callback, nil, true, true);
end


PlayerGuoBaoMgr.GetQuestEvent = function(id)
    return DataMgr.Player.quests[id];
end


PlayerGuoBaoMgr.GetFinishEvent = function(id)
    local finishEvent = DataMgr.Player.simulatedShop.finishEvent;
    if (not IsNull(finishEvent)) then
        return finishEvent[id];
    end
    return nil;
end


PlayerGuoBaoMgr.SimulatedShopFinishEvent = function(id, callback)
    ApiMgr.Request("simulatedshop/finishEvent", {ID=id}, true, callback, nil, true, true);
end


PlayerGuoBaoMgr.IsPaintingNew = function()
    local event;
    local time = LuaMgr.Timestamp();
    local eventList = ConfigGuoBaoMgr.GetEventList(2);
    local len = #eventList;
    for i = 1, len do
        event = eventList[i];
        if (time >= event.StartTime and PlayerGuoBaoMgr.GetFinishEvent(event.ID) == nil) then
            return true;
        end
    end
    return false;
end


PlayerGuoBaoMgr.SimulatedShopWish = function(id, callback)
    ApiMgr.Request("simulatedshop/wish", {Index=id-1}, true, callback, nil, true, true);
end


PlayerGuoBaoMgr.SimulatedShopWishList = function()
    ApiMgr.Request("simulatedshop/wishlist", {}, true, this.SimulatedShopWishListResponse, nil, true, true);
end


this.SimulatedShopWishListResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        LuaMgr.ShowLuaPanel(UIName.GuoBaoWishViewModel, data.result.items);
    end
end


PlayerGuoBaoMgr.GetSimulatedShopWish = function()
    local event;
    local eventList = ConfigGuoBaoMgr.GetEventList(1);
    local len = #eventList;
    for i = 1, len do
        event = eventList[i];
        if (PlayerGuoBaoMgr.GetFinishEvent(event.ID) == nil) then
            return event;
        end
    end
    return nil;
end


PlayerGuoBaoMgr.SetNovelIndex = function(index)
    this.novelIndex = index;
end


PlayerGuoBaoMgr.GetNovelIndex = function()
    return this.novelIndex;
end


PlayerGuoBaoMgr.SetLevelType = function(type)
    this.levelType = type;
end


PlayerGuoBaoMgr.GetLevelType = function()
    return this.levelType;
end


PlayerGuoBaoMgr.SetLevelMainIndex = function(index)
    this.levelMainIndex = index;
end


PlayerGuoBaoMgr.GetLevelMainIndex = function()
    return this.levelMainIndex;
end


PlayerGuoBaoMgr.SetLevelBattleIndex = function(index)
    this.levelBattleIndex = index;
end


PlayerGuoBaoMgr.GetLevelBattleIndex = function()
    return this.levelBattleIndex;
end


PlayerGuoBaoMgr.IsFZQKUnlock = function()
    local variable = DataMgr.Player.variables["group.3021"];
    if (variable ~= nil) then
        if (LuaMgr.Timestamp() > variable.startTime) then
            return true;
        end
    end
    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("PlayerGuoBaoMgr_0"));
    return false;
end


PlayerGuoBaoMgr.IsCollectReceive = function()
    local completeEvent = "302030";
    local questConfig = ConfigMgr.Config.questEvent[completeEvent];
    if (questConfig ~= nil) then
        local questData = PlayerGuoBaoMgr.GetQuestEvent(completeEvent);
        if (questData ~= nil) then
            return questData.state == 2;
        end
    end
    return false;
end


PlayerGuoBaoMgr.IsCollectReward = function(group)
    local questConfig = ConfigGuoBaoMgr.GetSimulatedShopQuestEvent("GuoBaostamp" .. group);
    if (questConfig ~= nil) then
        local questData = PlayerGuoBaoMgr.GetQuestEvent(questConfig.id);
        if (questData ~= nil) then
            return questData.state == 2;
        end
    end
    return false;
end