PlayerFoundationMgr = {};

local this = {
isInit = false,
itemMap = {},
comfort = {},
furnitureId = 0,
furnitureItemMap = {},
buildingCharacterMap = {},
selectCharacters = {},
composeChoices = {},
visitUid = "",
visitData = nil,
settingFriend = false,
settingStranger = false,
likePoint = 0,
alyUseLikePoint = 0,
    isVisitNext = false,
activityVisitUid = "",
activityVisitPlayer = "",
activityVisitData = nil,
    isShowAnimator = false,
};

PlayerFoundationMgr.Init = function()
    if (PlayerFoundationMgr.IsInit()) then
        this.itemMap = {};
        PlayerFoundationMgr.InitFurnitureId();
        this.InitBuildingCharacters();
        this.selectCharacters = {};
        LuaMgr.AddTimer(TimerConst.FoundationDataTime, this.OnTimer, 1, -1, false);
    end
end

PlayerFoundationMgr.Clear = function()
    this.isInit = false;
    LuaMgr.RemoveTimer(TimerConst.FoundationDataTime);
    this.itemMap = {};
    this.comfort = {};
    this.furnitureItemMap = {};
    this.buildingCharacterMap = {};
    this.selectCharacters = {};
    this.friendInteractions = nil;
    this.friendFurnitures = nil;
    this.visitData = nil;
    this.activityVisitData = nil;
    this.activityVisitPlayer = nil;
end


PlayerFoundationMgr.IsInit = function()
    if (this.isInit) then return false end
    
    local interactions = DataMgr.Player.interactions;
    if (interactions ~= nil and next(interactions) ~= nil) then
        this.isInit = true;
        return true;
    end
    return false;
end


PlayerFoundationMgr.IsUpLevel = function(id)
    local interactions = DataMgr.Player.interactions;
    if (interactions ~= nil) then
        local data = interactions[id];
        return data ~= nil and data.LevelupEndTime > 0;
    end
    return false;
end


PlayerFoundationMgr.IsWorkCharacter = function(interaction)
    local data = DataMgr.Player.interactions[interaction];
    if (data ~= nil and not IsNull(data.Characters) and #data.Characters > 0) then
        return true;
    end
    return false;
end


PlayerFoundationMgr.IsFullWorkCharacter = function(interaction)
    local data = DataMgr.Player.interactions[interaction];
    if (data ~= nil) then
        local config = ConfigFoundationMgr.GetInteractionById(interaction);
        if (config ~= nil and not IsNull(data.Characters) and #data.Characters >= config.Cap) then
            return true;
        end
    end
    return false;
end


PlayerFoundationMgr.IsYieldsDraw = function(config, data)
    if (data.ResidualPoints > 0) then
        return true;
    end
    local hasCharacter = PlayerFoundationMgr.IsWorkCharacter(config.Id);
    return hasCharacter and LuaMgr.Timestamp() - data.YieldsStartTime > 600;
end


PlayerFoundationMgr.IsRoomDraw = function(config, data)
    local hasCharacter = PlayerFoundationMgr.IsWorkCharacter(config.Id);
    return hasCharacter and LuaMgr.Timestamp() - data.YieldsStartTime > config.Period;
end


PlayerFoundationMgr.GetYieldsDrawProgress = function(config, data)
    local count = IsNull(data.Characters) and 0 or #data.Characters;
    if (count > 0) then
        local minute = math.ceil(config.YieldsLimit / (config.YieldsBase + config.YieldsPerChar * count));
        local second = minute * 60;
        local time = LuaMgr.Timestamp() - data.YieldsStartTime;
        return time / second;
    end
    return 0;
end


PlayerFoundationMgr.GetCurrentStamina = function()
    local baseRoomId = FoundationMgr.GetBaseRoomId();
    local staminaBuildingId = PlayerFoundationMgr.GetRoomStaminaInteractionId(baseRoomId);
    local staminaBuildingData = DataMgr.Player.interactions[staminaBuildingId];
    if (staminaBuildingData ~= nil) then
        local config = ConfigFoundationMgr.GetInteractionById(staminaBuildingId);
        if (config == nil) then
            return DataMgr.Player.extraStamina;
        end
        local level = tostring(DataMgr.Player.level);
        local levelUp = ConfigMgr.Config.playerLevelUp[level];
        if (DataMgr.Player.stamina < levelUp.staminaLimit) then
            return DataMgr.Player.extraStamina;
        end
        local staminaLimit = PlayerFoundationMgr.GetRoomStaminaInteraction();
        if (DataMgr.Player.extraStamina > staminaLimit) then
            return DataMgr.Player.extraStamina;
        end
        local time = LuaMgr.Timestamp() - DataMgr.Player.lastRecoverStaminaTime;
        local stamina = math.floor(time / config.Period) + DataMgr.Player.extraStamina;
        return stamina > staminaLimit and staminaLimit or stamina;
    end
    return 0;
end


PlayerFoundationMgr.IsMakeDraw = function(config, data)
    if (data.Formula ~= "" and data.Count > 0) then
        local formula = ConfigMgr.Config.FormulaMap[data.Formula];
        if (formula ~= nil) then
            if (PlayerFoundationMgr.IsWorkCharacter(config.Id)) then
                local endTime = PlayerFoundationMgr.CalcMakeItemTime(config, data, formula.Workload);
                return LuaMgr.Timestamp() > endTime;
            end
        end
    end
    return false;
end


PlayerFoundationMgr.IsMake = function(interaction)
    local interactions = DataMgr.Player.interactions;
    if (interactions ~= nil) then
        local data = interactions[interaction];
        if (data ~= nil and data.Formula ~= "") then
            local config = ConfigFoundationMgr.GetInteractionById(interaction);
            if (config ~= nil) then
                local workload = ConfigFoundationMgr.GetFormulaWorkLoad(data.Formula, data.Count);
                local endTime = PlayerFoundationMgr.CalcMakeItemTime(config, data, workload);
                if (data.Count > 0 and LuaMgr.Timestamp() < endTime) then
                    return true;
                end
            end
        end
    end
    return false;
end


PlayerFoundationMgr.IsConsume = function(formulaId, count)
    local items = DataMgr.Player.items;
    local itemMap = ConfigMgr.Config.itemMap;
    local formula = ConfigMgr.Config.FormulaMap[formulaId];
    if (formula ~= nil) then
        if (IsNull(formula.Cost)) then
            return true;
        end
        local costItem;
        local len = #formula.Cost;
        for i = 1, len do
            costItem = formula.Cost[i];
            itemConfig = itemMap[costItem.id];
            if (itemConfig ~= nil) then
                local item = items[itemConfig.id];
                local itemCount = item ~= nil and item.count0 or 0;
                if (itemCount < costItem.count * count) then
                    return false;
                end
            end
        end
    end
    return true;
end


PlayerFoundationMgr.GetFormulaMaxNum = function(formula)
    if (IsNull(formula.Cost)) then
        return formula.Count;
    end
    local costItem;
    local itemData;
    local itemCount;
    local count;
    local maxNum = formula.Count;
    local items = DataMgr.Player.items;
    local len = #formula.Cost;
    for i = 1, len do
        costItem = formula.Cost[i];
        itemData = items[costItem.id];
        itemCount = itemData ~= nil and itemData.count0 or 0;
        count = math.floor(itemCount / costItem.count);
        if (count < maxNum) then
            maxNum = count;
        end
    end
    if (formula.CostRequire > 0) then
        local composeChoices = PlayerFoundationMgr.GetComposeChoices();
        len = #composeChoices;
        for i = 1, len do
            local index = PlayerFoundationMgr.GetCostSelectIndex(formula, composeChoices[i]);
            costItem = formula.CostSelect[index];
            itemData = items[costItem.id];
            itemCount = itemData ~= nil and itemData.count0 or 0;
            count = math.floor(itemCount / costItem.count);
            if (count < maxNum) then
                maxNum = count;
            end
        end
    end
    return maxNum > 0 and maxNum or 1;
end


PlayerFoundationMgr.GetCostSelectIndex = function(formula, itemId)
    local len = #formula.CostSelect;
    for i = 1, len do
        if (formula.CostSelect[i].id == itemId) then
            return i;
        end
    end
    return 0;
end


PlayerFoundationMgr.CalcTime = function(interaction, heroCount, cost)
    local num = interaction.YieldsPerChar * heroCount + interaction.YieldsBase;
    return math.floor(cost / num);
end


PlayerFoundationMgr.CalcMakeItemTime = function(config, data, workLoad)
    if (data.Formula ~= "" and not IsNull(data.Characters)) then
        return data.YieldsStartTime + PlayerFoundationMgr.CalcTime(config, #data.Characters, workLoad - data.ResidualPoints);
    end
    return 0;
end


PlayerFoundationMgr.GetMakeItemTime = function(config, data)
    if (data.Formula ~= "" and not IsNull(data.Characters)) then
        local workLoad = ConfigFoundationMgr.GetFormulaWorkLoad(data.Formula, data.Count);
        local nowTime = LuaMgr.Timestamp();
        local endTime = PlayerFoundationMgr.CalcMakeItemTime(config, data, workLoad);
        if (nowTime < endTime) then
            return endTime - nowTime;
        end
    end
    return 0;
end


PlayerFoundationMgr.GetMainInteraction = function()
    local interactions = DataMgr.Player.interactions;
    if (interactions ~= nil) then
        local config;
        for k, _ in pairs(interactions) do
            config = ConfigFoundationMgr.GetInteractionById(k);
            if (config ~= nil and config.Type == 6) then
                return config;
            end
        end
    end
    return nil;
end


PlayerFoundationMgr.GetBuildingConfigByType = function(type)
    local interactions = DataMgr.Player.interactions;
    if (interactions ~= nil) then
        local config;
        for k, _ in pairs(interactions) do
            config = ConfigFoundationMgr.GetInteractionById(k);
            if (config ~= nil and config.Type == type) then
                return config;
            end
        end
    end
    return nil;
end


PlayerFoundationMgr.GetBuildingConfigByGroup = function(group)
    local interactions = DataMgr.Player.interactions;
    if (interactions ~= nil) then
        local config;
        for k, _ in pairs(interactions) do
            config = ConfigFoundationMgr.GetInteractionById(k);
            if (config ~= nil and config.Group == group) then
                return config;
            end
        end
    end
    return nil;
end


PlayerFoundationMgr.GetBuildingLevelByType = function(type)
    local config = PlayerFoundationMgr.GetBuildingConfigByType(type);
    if (config ~= nil) then
        return config.Level;
    end
    return 1;
end


PlayerFoundationMgr.GetTeaBuildingLevel = function()
    return PlayerFoundationMgr.GetBuildingLevelByType(3);
end


PlayerFoundationMgr.IsTeaUpLevel = function()
    local interactions = DataMgr.Player.interactions;
    if (interactions ~= nil) then
        for k, v in pairs(interactions) do
            config = ConfigFoundationMgr.GetInteractionById(k);
            if (config ~= nil and config.Type == 3) then
                return v.LevelupEndTime > 0;
            end
        end
    end
    return false;
end


PlayerFoundationMgr.IsTeaIdleOrComplete = function()
    local interactions = DataMgr.Player.interactions;
    if (interactions ~= nil) then
        for k, _ in pairs(interactions) do
            config = ConfigFoundationMgr.GetInteractionById(k);
            if (config ~= nil and config.Type == 3) then
                local item = this.itemMap[k];
                if (item ~= nil) then
                    return item.tea;
                end
            end
        end
    end
    return false;
end


PlayerFoundationMgr.IsRoomStamina = function()
    local stamina = PlayerFoundationMgr.GetCurrentStamina();
    return stamina > 0;
end


PlayerFoundationMgr.GetWeaponMakeComplete = function(nowTime)
    local order;
    local ordersList = DataMgr.Player.weaponMade.OrdersList;
    local len = #ordersList;
    for i = 1, len do
        order = ordersList[i];
        if (order.EndTime < nowTime) then
            return order.OrdersType;
        end
    end
    return nil;
end


PlayerFoundationMgr.GetWeaponMaking = function(nowTime)
    local order;
    local ordersList = DataMgr.Player.weaponMade.OrdersList;
    local len = #ordersList;
    for i = 1, len do
        order = ordersList[i];
        if (order.EndTime > nowTime) then
            return order.OrdersType;
        end
    end
    return nil;
end


PlayerFoundationMgr.IsWeaponMakeIdle = function(config)
    local unlockNum = ConfigMgr.Config.MakeUpGradeList[config.Level].WaitNum;
    local ordersList = DataMgr.Player.weaponMade.OrdersList;
    local allorderNum = #ordersList;
    return allorderNum < unlockNum;
end


PlayerFoundationMgr.CheckWeaponMakeItem = function()
    local count;
    local ordersType = ConfigMgr.Config.weaponMade.OrdersType;
    for _, v in pairs(ordersType) do
        count = PlayerItemMgr.GetItemCountById(v.SpendItems);
        if (count > 0) then
            return true;
        end
    end
    return false;
end


PlayerFoundationMgr.IsUpgrade = function(config)
    local nextConfig = ConfigFoundationMgr.GetInteractionByGroupLevel(config.Group, config.Level + 1);
    if (nextConfig ~= nil and not IsNullOrEmpty(nextConfig.UnlockCond)) then
        local areaEvent = DataMgr.Player.completedAreaEvents[nextConfig.UnlockCond];
        if (areaEvent == nil) then
            return false;
        end
    end
    local mainConfig = PlayerFoundationMgr.GetMainInteraction();
    if (mainConfig ~= nil and mainConfig.Id ~= config.Id) then
        nextConfig = ConfigFoundationMgr.GetInteractionByGroupLevel(config.Group, config.Level + 1);
        if (nextConfig ~= nil) then
            if (mainConfig.Level < nextConfig.Unlock) then
                return false;
            end
        end
    end
    if (nextConfig ~= nil) then
        if (nextConfig.Cost ~= nil and #nextConfig.Cost > 0) then
            local cost;
            local item;
            local len = #nextConfig.Cost;
            for i = 1, len do
                cost = nextConfig.Cost[i];
                item = DataMgr.Player.items[cost.id];
                if (item == nil or item.count0 < cost.count) then
                    return false;
                end
            end
        end
        return true;
    end
    return false;
end

this.OnTimer = function()
    this.CheckInteractions();
end


this.CheckInteractions = function()
    local interactions = DataMgr.Player.interactions;
    if (interactions == nil) then return end
    
    local item;
    local config;
    local nowTime = LuaMgr.Timestamp();
    for k, data in pairs(interactions) do
        config = ConfigFoundationMgr.GetInteractionById(k);
        if (config ~= nil) then
            item = PlayerFoundationMgr.GetItem(config.Room, k, config.Type);
            if (data.LevelupEndTime > 0) then
                item.levelUp = true;
                item.complete = nowTime > data.LevelupEndTime;
            else
                item.levelUp = false;
                item.complete = false;
if (config.Type == 1) then
                    this.CheckYields(item, config, data);
elseif (config.Type == 2) then
                    this.CheckMake(item, config, data);
elseif (config.Type == 3) then
                    this.CheckTea(item, config, nowTime);
elseif (config.Type == 4) then
                    this.CheckVendingMachine(item, config, data);
elseif (config.Type == 5) then

elseif (config.Type == 6) then
                    this.CheckUpgrade(item, config);
elseif (config.Type == 7) then
                    this.CheckWeaponMake(item, config, nowTime);
elseif (config.Type == 8) then
                    this.CheckUpgrade(item, config);
elseif (config.Type == 9) then
                    this.CheckUpgrade(item, config);
elseif (config.Type == 12) then
                    this.CheckComfort(item, config, data);
elseif (config.Type == 13) then
                    this.CheckStamina(item);
                end
            end
        end
    end
end


this.CheckStamina = function(item)
    item.stamina = PlayerFoundationMgr.IsRoomStamina();
end


this.CheckComfort = function(item, config, data)
    if (PlayerFoundationMgr.IsRoomDraw(config, data)) then
        this.comfort[item.roomId] = true;
    else
        this.comfort[item.roomId] = nil;
    end
end


this.CheckUpgrade = function(item, config)
    item.upgrade = PlayerFoundationMgr.IsUpgrade(config);
end


this.CheckYields = function(item, config, data)
    local redStatus = 0;
    if (PlayerFoundationMgr.IsYieldsDraw(config, data)) then
        item.itemId = PlayerFoundationMgr.GetDrawItemId(config, data);
        local progress = PlayerFoundationMgr.GetYieldsDrawProgress(config, data);
        redStatus = progress >= 1 and 1 or 0;
    else
        item.itemId = "";
        local hasCharacter = PlayerFoundationMgr.IsWorkCharacter(config.Id);
        item.idle = not hasCharacter;
    end
    this.CheckUpgrade(item, config);
    RedMgr.Singleton:UpdateClientRedData("1159", redStatus);
end


this.CheckMake = function(item, config, data)
    local redStatus = 0;
    local isMakeDraw = PlayerFoundationMgr.IsMakeDraw(config, data);
    if (isMakeDraw) then
        item.itemId = PlayerFoundationMgr.GetDrawItemId(config, data);
        item.idle = false;
        item.stopWork = false;
        redStatus = 1;
    else
        item.itemId = "";
        local isMake = data.Formula ~= "" and data.Count > 0;
        if (isMake) then
            item.idle = false;
            if (PlayerFoundationMgr.IsWorkCharacter(config.Id)) then
                item.stopWork = false;
            else
                item.itemId = PlayerFoundationMgr.GetDrawItemId(config, data);
                item.stopWork = true;
            end
        else
            item.idle = true;
            item.stopWork = false;
        end
    end
    this.CheckUpgrade(item, config);
    RedMgr.Singleton:UpdateClientRedData("1161", redStatus);
end


this.CheckVendingMachine = function(item, config, data)
    item.vendingMachine = false;
    local vendingMachineConfig = ConfigMgr.Config.VendingMachineList[config.Level];
    if (vendingMachineConfig ~= nil) then
        local count = vendingMachineConfig.Frequency - data.TodayCount;
        if (count > 0) then
            local nowTime = LuaMgr.Timestamp();
            item.vendingMachine = nowTime > data.VendingEndTime;
        end
    end
    if (item.vendingMachine) then
        item.upgrade = false;
    else
        this.CheckUpgrade(item, config);
    end
    RedMgr.Singleton:UpdateClientRedData("1160", item.vendingMachine and 1 or 0);
end
 

this.CheckTea = function(item, config, nowTime)
    item.miniGame = false;

    local minigameConfig=ConfigMgr.Config.constants["GamePoint"]
    for index, value in ipairs(minigameConfig) do
        if RedMgr.Singleton:GetRedStateById("1100_".. value[1]) > 0 then
            item.miniGame = true;
            break;
        end
    end
    item.tea = false;
    this.CheckUpgrade(item, config);
    local teadata = DataMgr.Player.hightea;
    local items = DataMgr.Player.items;
    local highteaMainMap = ConfigMgr.Config.highteaMain;
    local dailyCount = DataMgr.Player.dailyCount;
    if (teadata == nil or items == nil or highteaMainMap == nil or dailyCount == nil) then return end

    if (teadata.Stage == 5) then
        local lastTime = teadata.Deadline - nowTime;
        if (lastTime > 0) then
            item.tea = true;
            return;
        end
    end
    if (teadata.Stage == 1) then
        item.tea = true;
        return;
    end
    local drinkTeaTimes = dailyCount.HighteaTimes ~= nil and dailyCount.HighteaTimes or 0;
    local highteaTimesDaily = ConfigMgr.Config.constants.HighteaTimesDaily;
    local highteaTimes = highteaTimesDaily[config.Level];
    if (drinkTeaTimes >= highteaTimes) then
        return;
    end
    for _, v in pairs(highteaMainMap) do
        local temp = items[v.ID];
        if (temp ~= nil) then
            if (temp.count0 > 0) then
                item.tea = true;
                break;
            end
        end
    end
end


this.CheckWeaponMake = function(item, config, nowTime)
    item.idle = false;
    item.stopWork = false;
    item.itemId = "";
    item.weaponMake = false;
    local redStatus = 0;
    local ordersType = PlayerFoundationMgr.GetWeaponMakeComplete(nowTime);
    if (ordersType ~= nil) then
        local ordersTypeConfig = ConfigMgr.Config.weaponMade.OrdersType[ordersType];
        if (ordersTypeConfig ~= nil) then
            item.itemId = ordersTypeConfig.Rank;
            item.weaponMake = true;
            redStatus = 1;
        end
    end
    local isIdle = PlayerFoundationMgr.IsWeaponMakeIdle(config);
    item.idle = isIdle;
    this.CheckUpgrade(item, config);
    RedMgr.Singleton:UpdateClientRedData("1162", redStatus);
end


PlayerFoundationMgr.GetItem = function(roomId, id, type)
    local item = this.itemMap[id];
    if (item == nil) then
        item = {roomId=roomId, id=id, type=type, itemId="", count=0,
                idle=false, stopWork=false, levelUp=false, complete=false, vendingMachine=false, 
                tea=false, weaponMake=false, upgrade=false, stamina=false,miniGame=false};
        this.itemMap[id] = item;
    end
    return item;
end


PlayerFoundationMgr.RemoveItem = function(id)
    this.itemMap[id] = nil;
end


PlayerFoundationMgr.GetDrawItemByRoom = function(roomId)
    local item = nil;
    for _, v in pairs(this.itemMap) do
        if (v.roomId == roomId) then
            if (v.itemId ~= "" and not v.stopWork) then
                item = v;
                break;
            end
        end
    end
    for _, v in pairs(this.itemMap) do
        if (v.roomId == roomId) then
            if (v.complete or v.upgrade) then
                return item, v;
            end
        end
    end
    for _, v in pairs(this.itemMap) do
        if (v.roomId == roomId) then
            if (v.vendingMachine or v.tea or v.weaponMake or v.stamina or v.miniGame) then
                return item, v;
            end
        end
    end
    for _, v in pairs(this.itemMap) do
        if (v.roomId == roomId) then
            if (not v.levelUp and v.idle) then
                return item, v;
            end
        end
    end
    return item, nil;
end


PlayerFoundationMgr.GetComfort = function()
    return this.comfort;
end


PlayerFoundationMgr.IsDrawItemById = function(id)
    local item = this.itemMap[id];
    if (item ~= nil) then
        return item.itemId ~= "";
    end
    return false;
end


PlayerFoundationMgr.IsStopWork = function(id)
    local item = this.itemMap[id];
    if (item ~= nil) then
        return item.itemId ~= "" and item.stopWork;
    end
    return false;
end


PlayerFoundationMgr.GetDrawItemId = function(config, data)
    if (config.Type == 1) then
        return config.YieldsItem;
    end
    if (data ~= nil and data.Formula ~= "") then
        local formula = ConfigMgr.Config.FormulaMap[data.Formula];
        if (formula ~= nil and formula.Produce ~= nil) then
            local produce = formula.Produce[1];
            if (produce ~= nil) then
                return produce.id;
            end
        end
    end
    return "";
end


PlayerFoundationMgr.IsBuildingsIdle = function()
    for _, v in pairs(this.itemMap) do
        if (v.idle) then
            return true;
        end
    end
    return false;
end


PlayerFoundationMgr.IsBuildingsDrawItem = function()
    for _, v in pairs(this.itemMap) do
        if (v.itemId ~= "" and not v.stopWork) then
            return true;
        end
    end
    return false;
end


PlayerFoundationMgr.UpLevel = function(id)
    local data = {ID = id};
    ApiMgr.Request("foundation/upgrade_interaction", data, true, this.UpLevelResponse, nil, true, true);
end


this.UpLevelResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        if (not IsNull(data.result.Rewards)) then
            local reward = json.encode(data.result.Rewards);
            LuaMgr.ShowItemRewared(reward);
        end
        PlayerFoundationMgr.RemoveItem(data.result.ID);
        local config = ConfigFoundationMgr.GetInteractionById(data.result.ID);
        if (config ~= nil) then
            local building = FoundationBuildingMgr.GetBuildingByCid(config.Id);
            if (config.Type ~= 3) then
                FoundationBuildingMgr.SetCharacters(data.result.ID);
                if (building ~= nil and building.upgrade ~= nil) then
                    building.upgrade:SetData(1);
                end
            end
            FoundationBuildingMgr.UpLevel(building);
        end
        this.InitBuildingCharacters();
    end
    LuaMgr.HidePanel(UIName.FoundationUpLevelViewModel);
end


PlayerFoundationMgr.RefreshLevel = function(id)
    local interactions = DataMgr.Player.interactions;
    if (interactions ~= nil) then
        local data = interactions[id];
        if (data ~= nil and data.LevelupEndTime > 0) then
            local nowTime = LuaMgr.Timestamp();
            if (nowTime > data.LevelupEndTime) then
                ApiMgr.Request("foundation/refreshLevel", {ID = id}, true, this.RefreshLevelResponse, nil, true, true);
            end
        end
    end
end


this.RefreshLevelResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        local before = data.result.Before;
        PlayerFoundationMgr.RemoveItem(before);
        local building = FoundationBuildingMgr.GetBuildingByCid(before);
        if (building ~= nil) then
            local buildingId = building.id;
            if (building.config ~= nil and building.config.Type ~= 3) then
                FoundationCharacterMgr.RemoveBuildingCharacters(buildingId);
            end
            FoundationBuildingMgr.RemoveBuilding(buildingId);
            local after = data.result.After;
            LuaMgr.TriggerFoundationBuilding(after);
            local interactionConfig = ConfigFoundationMgr.GetInteractionById(after);
            if (interactionConfig ~= nil) then
                FoundationBuildingMgr.AddBuilding(interactionConfig);
                building = FoundationBuildingMgr.GetBuildingByCid(interactionConfig.Id);
                if (building ~= nil) then
                    if (interactionConfig.Type == 3) then
                        FoundationCharacterMgr.UpdateBuildingCharacters(buildingId, building.id);
                    end
                    if (building.upgrade ~= nil) then
                        building.upgrade:SetData(3);
                    end
                end
                local newBuildings = FoundationBuildingMgr.GetNewBuildings();
                local len = #newBuildings;
                if (len > 0) then
                    for i = 1, len do
                        FoundationBuildingMgr.AddBuilding(newBuildings[i]);
                    end
                end
                LuaMgr.ShowLuaPanel(UIName.FoundationUpLevelSuccessfulViewModel, interactionConfig);
            end
        end
        FoundationBuildingMgr.SetBuildingsInfo();
    end
    LuaMgr.HidePanel(UIName.FoundationOperateViewModel);
end


PlayerFoundationMgr.Draw = function(id)
    local config = ConfigFoundationMgr.GetInteractionById(id);
    if (config == nil) then return end

if (config.Type == 1) then
        ApiMgr.Request("foundation/yields/get", {Interaction = id}, true, this.YieldsGetResponse, nil, true, true);
elseif (config.Type == 2) then
        ApiMgr.Request("foundation/made/get", {Interaction = id}, true, this.MadeGetResponse, nil, true, true);
elseif (config.Type == 3) then
elseif (config.Type == 4) then
elseif (config.Type == 5) then
elseif (config.Type == 6) then
elseif (config.Type == 7) then
        PlayerFoundationMgr.WeaponMadeGather();
elseif (config.Type == 8) then
elseif (config.Type == 9) then
elseif (config.Type == 12) then
        ApiMgr.Request("foundation/yields/get", {Interaction = id}, true, this.YieldsGetResponse, nil, true, true);
    end
end


this.YieldsGetResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        if (not IsNull(data.result.Rewards)) then
            local reward = json.encode(data.result.Rewards);
            LuaMgr.ShowItemRewared(reward);
        end
        FoundationCharacterMgr.CheckFriendlys(data.result.Interaction);
        FoundationRoomCtrl.CheckComfort(true);
    end
end


PlayerFoundationMgr.DrawComfort = function()
    ApiMgr.Request("foundation/yields/get_room_all", {}, true, this.DrawComfortResponse, nil, true, true);
end


this.DrawComfortResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        if (not IsNull(data.result.Rewards)) then
            local reward = json.encode(data.result.Rewards);
            LuaMgr.ShowItemRewared(reward);
        end
    end
end


this.MadeGetResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        if (not IsNull(data.result.Rewards)) then
            local reward = json.encode(data.result.Rewards);
            LuaMgr.ShowItemRewared(reward);
        end
        FoundationCharacterMgr.CheckFriendlys(data.result.Interaction);
    end
end


PlayerFoundationMgr.MadeStart = function(interaction, formula, count, autoAppend, callback)
    ApiMgr.Request("foundation/made/start", {Interaction = interaction, Formula = formula, Count = count, AutoAppend = autoAppend}, true, callback, nil, true, true);
end


PlayerFoundationMgr.Compose = function(interaction, formula, count, costSelectIndex, callback)
    local data = {Interaction = interaction, Formula = formula, Count = count};
    if (#costSelectIndex > 0) then
        data.CostSelectIndex = costSelectIndex;
    end
    ApiMgr.Request("foundation/compose", data, true, callback, nil, true, true);
end


PlayerFoundationMgr.MulCompose = function(interaction, dataMap, callback)
    local data = {Interaction = interaction, FormulaM = dataMap};   
    ApiMgr.Request("foundation/mulCompose", data, true, callback, nil, true, true);
end


PlayerFoundationMgr.GetAllRewards = function(type)
    ApiMgr.Request("foundation/get_all_rewards", {Type = type}, true, this.GetAllRewardsResponse, nil, true, true);
end


this.GetAllRewardsResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        if (not IsNull(data.result.Rewards)) then
            local reward = json.encode(data.result.Rewards);
            LuaMgr.ShowItemRewared(reward);
            return;
        end
    end
    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("PlayerFoundationMgr_18"));
end


PlayerFoundationMgr.InitFurnitureId = function()
    this.furnitureId = 0;
    local furnitures = DataMgr.Player.furnitures;
    if (furnitures ~= nil) then
        local id;
        for k, _ in pairs(furnitures) do
            id = tonumber(k);
            if (id > this.furnitureId) then
                this.furnitureId = id;
            end
        end
    end
end


PlayerFoundationMgr.GetFurnitureId = function()
    this.furnitureId = this.furnitureId + 1;
    return this.furnitureId;
end


PlayerFoundationMgr.InitFurnitureItems = function()
    this.furnitureItemMap = {};
    local config;
    local item;
    local items = DataMgr.Player.items;
    local interactions = ConfigMgr.Config.interactionMap;
    local len = #interactions;
    for i = 1, len do
        config = interactions[i];
        if (config.Type == 10) then
            item = items[config.Furniture];
            this.furnitureItemMap[config.Furniture] = item ~= nil and item.count0 or 0;
        end
    end
end


PlayerFoundationMgr.ClearFurnitureItems = function(roomId)
    local furnitures = DataMgr.Player.furnitures;
    if (furnitures ~= nil) then
        local config;
        for _, v in pairs(furnitures) do
            if (v.Room == roomId) then
                config = ConfigFoundationMgr.GetInteractionById(v.BuildingId);
                if (config ~= nil) then
                    PlayerFoundationMgr.FurnitureItemCount(config.Furniture, 1);
                end
            end
        end
    end
end


PlayerFoundationMgr.GetPutFurnitureCount = function(roomId, furniture)
    local furnitures = DataMgr.Player.furnitures;
    if (furnitures ~= nil) then
        local config;
        local count = 0;
        for _, v in pairs(furnitures) do
            if (v.Room == roomId) then
                config = ConfigFoundationMgr.GetInteractionById(v.BuildingId);
                if (config ~= nil and config.Id == furniture) then
                    count = count + 1;
                end
            end
        end
        return count;
    end
    return 0;
end


PlayerFoundationMgr.GetFurnitureItemCount = function(itemId)
    return this.furnitureItemMap[itemId];
end


PlayerFoundationMgr.FurnitureItemCount = function(itemId, itemCount)
    local count = this.furnitureItemMap[itemId];
    this.furnitureItemMap[itemId] = count + itemCount;
end


PlayerFoundationMgr.SetFurnitures = function(roomId, furnitures, callback)
    ApiMgr.Request("furniture/set", {RoomId = roomId, Furnitures = furnitures}, true, callback, nil, true, true);
end


PlayerFoundationMgr.SetStyle = function(room, style, callback)
    ApiMgr.Request("foundation/setStyle", {Room = room, Style = style}, true, callback, nil, true, true);
end


PlayerFoundationMgr.PutCharacters = function(interactionId)
    local data = {Interaction = interactionId};
    if (#this.selectCharacters > 0) then
        data.Characters = this.selectCharacters;
    end
    ApiMgr.Request("foundation/put_characters", data, true, this.PutCharactersResponse, nil, true, true);
end


this.PutCharactersResponse = function(result)
    LuaMgr.HidePanel(UIName.FoundationHeroChoiceViewModel);
    LuaMgr.HidePanel(UIName.FoundationBuildingHeroViewModel);
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        if (not IsNull(data.result.Rewards)) then
            local reward = json.encode(data.result.Rewards);
            LuaMgr.ShowItemRewared(reward);
        end
        LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationHeroChoice, data.result.Interaction);
        FoundationCharacterMgr.CheckFriendlys(data.result.Interaction);
        this.InitBuildingCharacters();
    end
end


PlayerFoundationMgr.SelectMusic = function(musicId, callback)
    ApiMgr.Request("foundation/selectMusic", {MusicID = musicId}, true, callback, nil, true, true);
end

PlayerFoundationMgr.SelectBGMList = function(bgmList,callback)
    ApiMgr.Request("foundation/selectMusic", {MusicID = bgmList}, true, callback, nil, true, true);
end

PlayerFoundationMgr.RemoveBGMList = function(bgmList,callback)
    ApiMgr.Request("foundation/removeMusic", {MusicID = bgmList}, true, callback, nil, true, true);
end

PlayerFoundationMgr.ChangePlayerType = function(type,callback)
    ApiMgr.Request("foundation/musicPlay", {Type = type}, true, callback, nil, true, true);
end


PlayerFoundationMgr.GetFriendlyValue = function(characterId)
    local constants = ConfigMgr.Config.constants;
    local maxCount = constants.MaxPrestigeByWorkPerWeek;
    local nowCount = DataMgr.Player.weeklyCount["prest_" .. characterId] or 0;
    if (nowCount >= maxCount) then
        return -1;
    end
    local workingSec = DataMgr.Player.workingSec[characterId] or 0;
    local calcCount = math.floor(workingSec / constants.PrestigeWorkPeriod);
    if (calcCount > 0) then
        local count = maxCount - nowCount;
        return calcCount >= count and count or calcCount;
    end
    return 0;
end


PlayerFoundationMgr.GetPrestige = function(characterId)
    ApiMgr.Request("foundation/getPrestige", {CharacterID = characterId}, true, this.GetPrestigeResponse, nil, true, true);
end


this.GetPrestigeResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        local countStr = "+" .. data.result.AddPrestigeCount;
        if (FoundationRoomCtrl.IsInRoom()) then
            FoundationRoomCtrl.AddFlyText(data.result.CharacterID, countStr);
        else
            FoundationCharacterMgr.AddFlyText(data.result.CharacterID, countStr);
        end
    end
end


PlayerFoundationMgr.GetAllPrestige = function()
    ApiMgr.Request("foundation/getAllPrestige", {}, true, this.GetAllPrestigeResponse, nil, true, true);
end


this.GetAllPrestigeResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        local len = NumTool.GetLen(data.result.Details);
        if (len > 0) then
            LuaMgr.ShowLuaPanel(UIName.FoundationFriendlyViewModel, data.result.Details);
        else
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("PlayerFoundationMgr_21"));
        end
    end
end


this.InitBuildingCharacters = function()
    this.buildingCharacterMap = {};
    local interactions = DataMgr.Player.interactions;
    if (interactions ~= nil) then
        local characters;
        local len;
        for k, v in pairs(interactions) do
            characters = v.Characters;
            if (not IsNull(characters)) then
                len = #characters;
                if (len > 0) then
                    for i = 1, len do
                        this.buildingCharacterMap[characters[i]] = k;
                    end
                end
            end
        end
    end
end


PlayerFoundationMgr.GetCharacterBuilding = function(characterId)
    return this.buildingCharacterMap[characterId];
end


PlayerFoundationMgr.InitSelectCharacters = function(characters)
    this.selectCharacters = {};
    if (not IsNull(characters)) then
        local len = #characters;
        for i = 1, len do
            this.selectCharacters[i] = characters[i];
        end
    end
end


PlayerFoundationMgr.SelectCharacter = function(characterId, maxCharacter)
    local len = #this.selectCharacters;
    if (len > 0) then
        for i = 1, len do
            if (this.selectCharacters[i] == characterId) then
                table.remove(this.selectCharacters, i);
                return;
            end
        end
    end
    if (#this.selectCharacters >= maxCharacter) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("PlayerFoundationMgr_22"));
        return;
    end
    table.insert(this.selectCharacters, characterId);
end


PlayerFoundationMgr.GetSelectCharacters = function()
    return this.selectCharacters;
end


PlayerFoundationMgr.GetSelectCharacterNum = function(characterId)
    local len = #this.selectCharacters;
    if (len > 0) then
        for i = 1, len do
            if (this.selectCharacters[i] == characterId) then
                return i;
            end
        end
    end
    return 0;
end


PlayerFoundationMgr.GetEggsRewards = function(id)
    ApiMgr.Request("foundation/get_eggs_rewards", {Egg = id}, true, this.GetEggsRewardsResponse, nil, true, true);
end


this.GetEggsRewardsResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        if (not IsNull(data.result.Rewards)) then
            if (not IsNull(data.result.Rewards.Items)) then
                LuaMgr.ShowLuaPanel(UIName.FoundationSurpriseViewModel, data.result.Rewards);
            end
        end
    end
    FoundationCharacterMgr.RemoveBuildingCharacters("surprise");
end


PlayerFoundationMgr.IsVendingMachineInStock = function(id)
    local interaction = DataMgr.Player.interactions[id];
    if (interaction ~= nil) then
        local nowTime = LuaMgr.Timestamp();
        return interaction.VendingEndTime > nowTime;
    end
    return false;
end


PlayerFoundationMgr.IsVendingMachineCount = function(id)
    local interaction = DataMgr.Player.interactions[id];
    if (interaction ~= nil) then
        local interactionConfig = ConfigFoundationMgr.GetInteractionById(id);
        if (interactionConfig ~= nil) then
            local vendingMachineConfig = ConfigMgr.Config.VendingMachineList[interactionConfig.Level];
            if (vendingMachineConfig ~= nil) then
                return interaction.TodayCount < vendingMachineConfig.Frequency;
            end
        end
    end
    return false;
end


PlayerFoundationMgr.IsVendingMachineBuy = function()
    local config = PlayerFoundationMgr.GetBuildingConfigByType(4);
    if (config ~= nil) then
        if (PlayerFoundationMgr.IsUpLevel(config.Id)) then
            return false;
        end
        if (PlayerFoundationMgr.IsVendingMachineInStock(config.Id)) then
            return false;
        end
        if (PlayerFoundationMgr.IsVendingMachineCount(config.Id)) then
            return true;
        end
    end
    return false;
end


PlayerFoundationMgr.VendingBuy = function(id)
    ApiMgr.Request("vending/buy", {Interaction = id}, true, this.VendingBuyResponse, nil, true, true);
end


this.VendingBuyResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        if (not IsNull(data.result.Rewards)) then
            local reward = json.encode(data.result.Rewards);
            LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationVendingBuy, data.result.IsJackpot, reward);
        end
    end
end


PlayerFoundationMgr.WeaponMadeGather = function()
    ApiMgr.Request("weaponmade/gather", {Orders="*"}, true, function(result)
        local re = json.decode(result);
        local rewards = json.encode(re.result.Reward);
        LuaMgr.ShowItemRewared(rewards);
    end, nil, true);
end


PlayerFoundationMgr.LogBiliEvent = function(data)
    ApiMgr.Request("log_bili_event", data, true, nil, nil, false, false);
end


PlayerFoundationMgr.GetRoomCharacterInteractionId = function(roomId)
    if (FoundationMgr.IsVisitor()) then
        
    else
        local interactionConfig;
        local interactions = DataMgr.Player.interactions;
        for k, _ in pairs(interactions) do
            interactionConfig = ConfigFoundationMgr.GetInteractionById(k);
            if (interactionConfig ~= nil and interactionConfig.Room == roomId and interactionConfig.Type == 12) then
                return k;
            end
        end
    end
    return "";
end


PlayerFoundationMgr.GetRoomStaminaInteractionId = function(roomId)
    local interactionConfig;
    local interactions = DataMgr.Player.interactions;
    for k, _ in pairs(interactions) do
        interactionConfig = ConfigFoundationMgr.GetInteractionById(k);
        if (interactionConfig ~= nil and interactionConfig.Room == roomId and interactionConfig.Type == 13) then
            return k;
        end
    end
    return "";
end


PlayerFoundationMgr.GetRoomStaminaInteraction = function()
    local interactionConfig;
    local stamina = 0;
    local interactions = DataMgr.Player.interactions;
    for k, _ in pairs(interactions) do
        interactionConfig = ConfigFoundationMgr.GetInteractionById(k);
        if (interactionConfig ~= nil and interactionConfig.Type == 13) then
            stamina = stamina + interactionConfig.YieldsLimit;
        end
    end
    if stamina>ConfigMgr.Config.constants.VitalityStorageLimit then
        stamina=ConfigMgr.Config.constants.VitalityStorageLimit;
    end
    return stamina;
end


PlayerFoundationMgr.GetExtraStamina = function(callback)
    ApiMgr.Request("foundation/get_extra_stamina", {}, true, callback, nil, true, true);
end


PlayerFoundationMgr.SetComposeChoices = function(composeChoices)
    this.composeChoices = {};
    if (composeChoices ~= nil) then
        local len = #composeChoices;
        for i = 1, len do
            this.composeChoices[i] = composeChoices[i];
        end
    end
end


PlayerFoundationMgr.GetComposeChoices = function()
    return this.composeChoices;
end


PlayerFoundationMgr.GetVisitData = function()
    return this.visitData;
end


PlayerFoundationMgr.GetVisitRoom = function(roomId)
    if (this.visitData ~= nil) then
        local roomData;
        local len = #this.visitData.Rooms;
        for i = 1, len do
            roomData = this.visitData.Rooms[i];
            if (roomData.RoomId == roomId) then
                return roomData;
            end
        end
    end
    return nil;
end


PlayerFoundationMgr.VisitFriend = function(uid,isNext)
    this.isVisitNext=isNext;
    this.visitUid = uid;
    ApiMgr.Request("friends/visit_friend", {Uid=uid}, true, this.VisitFriendResponse, nil, true, true);
end


this.VisitFriendResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        this.visitData = data.result;
        data.result = nil;
        if (#this.visitData.Rooms > 0) then
            local roomData = this.visitData.Rooms[1];
            if (roomData ~= nil) then
                FoundationMgr.SetRoomId(roomData.RoomId);
                FoundationMgr.Visitor(FoundationMgr.Room, this.isVisitNext);
            end
        end
    end
end


PlayerFoundationMgr.VisitLeaveMessage = function(msg, callback)
    ApiMgr.Request("friends/visit_leave_message", {Uid=this.visitUid, Msg=msg}, true, callback, nil, true, true);
end


PlayerFoundationMgr.VisitLeaveMessageAnswer = function(uid, msg, callback)
    ApiMgr.Request("friends/visit_leave_message_answer", {Id=uid, Msg=msg}, true, callback, nil, true, true);
end


PlayerFoundationMgr.VisitLeaveMessageList = function(uid, reset)
    if (uid == nil) then
        uid = this.visitUid;
    end
    ApiMgr.Request("friends/visit_leave_message_list", {Uid=uid}, true, function(result)
        local data = json.decode(result);
        if (data ~= nil and data.result ~= nil) then
            PlayerFoundationMgr.SetSettingFriend(data.result.Friend);
            PlayerFoundationMgr.SetSettingStranger(data.result.Stranger);
            FoundationMsgMgr.SetData(data.result.LeaveMgs);
            LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationMsgBoardRefresh, reset);
        end
    end, nil, true, true);
end


PlayerFoundationMgr.GetSettingFriend = function()
   return this.settingFriend;
end


PlayerFoundationMgr.SetSettingFriend = function(settingFriend)
   this.settingFriend = settingFriend;
end


PlayerFoundationMgr.GetSettingStranger = function()
   return this.settingStranger;
end


PlayerFoundationMgr.SetSettingStranger = function(settingStranger)
   this.settingStranger = settingStranger;
end


PlayerFoundationMgr.VisitLike = function(callback)
    ApiMgr.Request("friends/visit_like", {Uid=this.visitUid}, true, callback, nil, true, true);
end


PlayerFoundationMgr.VisitLikeAward = function()
    ApiMgr.Request("friends/visit_like_award", {}, true, this.VisitLikeAwardResponse, nil, true, true);
end


this.VisitLikeAwardResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        this.likePoint = 0;
        LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationLikeRefresh);
        if (not IsNull(data.result.Rewards)) then
            local reward = json.encode(data.result.Rewards);
            LuaMgr.ShowItemRewared(reward);
        end
    end
end


PlayerFoundationMgr.VisitRecord = function()
    ApiMgr.Request("friends/visit_record", {}, true, this.VisitRecordResponse, nil, true, true);
end


this.VisitRecordResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        LuaMgr.ShowLuaPanel(UIName.FoundationFriendLikeViewModel, data.result.Visitors);
    end
end


PlayerFoundationMgr.VisitRemoveMessage = function(id, callback)
    ApiMgr.Request("friends/visit_remove_message", {Id=id}, true, callback, nil, true, true);
end


PlayerFoundationMgr.SetMessageTop = function(id, top, callback)
    ApiMgr.Request("friends/set_message_top", {Id=id, Top=top}, true, callback, nil, true, true);
end


PlayerFoundationMgr.SetLeaveMessage = function(callback)
    ApiMgr.Request("friends/set_leave_message", {Friend=this.settingFriend, Stranger=this.settingStranger}, true, callback, nil, true, true);
end


PlayerFoundationMgr.BuyGoods = function(goods, count, itemId, callback)
    ApiMgr.Request("buy_goods", {goods=goods, count=count, itemId=itemId}, true, callback, nil, true, true);
end


PlayerFoundationMgr.BuyGoods_Multi = function(goodsList, itemId, callback)
    ApiMgr.Request("buy_goods_multi", {goods=goodsList, itemId=itemId}, true, callback, nil, true, true);
end


PlayerFoundationMgr.VisitGetLike = function()
    ApiMgr.Request("friends/visit_get_like", {}, true, this.VisitGetLikeResponse, nil, true, true);
end


this.VisitGetLikeResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        this.likePoint = data.result.LikePoint;
        this.alyUseLikePoint = data.result.AlyUseLikePoint;
        LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationLikeRefresh);
    end
end


PlayerFoundationMgr.GetLikePoint = function()
    return this.likePoint;
end


PlayerFoundationMgr.GetAlyUseLikePoint = function()
    return this.alyUseLikePoint;
end


PlayerFoundationMgr.VisitNextFriend=function()
    local friendList=FriendChatMgr.GetFriendList()
    if #friendList==0 then return end;
    local visitIndex=nil;
    for i,v in ipairs(friendList) do
        if v.Uid==this.visitUid then
            visitIndex=i;
        end
    end
    visitIndex=visitIndex+1;
    if visitIndex>#friendList then
        visitIndex=1;
    end
    PlayerFoundationMgr.VisitFriend(friendList[visitIndex].Uid,true);
end


PlayerFoundationMgr.IsCat = function(roomId)
    local eggs = DataMgr.Player.surpriseEggs.Eggs;
    if (eggs == nil or #eggs <= 0) then return false end

    local eggId = eggs[1];
    local surpriseEgg = ConfigMgr.Config.SurpriseEggsMap[eggId];
    if (surpriseEgg == nil or surpriseEgg.Room ~= roomId) then return false end

    return true;
end


PlayerFoundationMgr.EnterDunHuangRoom = function(callback)
    PlayerPrefs.SetInt("FristActivityRoom_" .. DataMgr.Player.uid, 0);
    ApiMgr.Request("furniture/enterDunHuangRoom", {}, true, callback, nil, true, true);
end


PlayerFoundationMgr.SetShowAnimator = function(isShowAnimator)
    this.isShowAnimator = isShowAnimator;
end


PlayerFoundationMgr.IsShowAnimator = function()
    return this.isShowAnimator;
end


PlayerFoundationMgr.Interact = function(type, callback, uid, extra)
    if (uid == nil) then
        uid = this.activityVisitUid;
    end
    ApiMgr.Request("furniture/interact", {Typ=type, Uid=uid, Extra=extra}, true, callback, nil, true, true);
end


PlayerFoundationMgr.SetRoomAngle = function(roomId, angle)
    ApiMgr.Request("furniture/setRoomAngle", {RoomId=roomId, Angle=angle}, true, this.SetRoomAngleResponse, nil, true, true);
end


this.SetRoomAngleResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        
    end
end


PlayerFoundationMgr.ShareRewards = function(callback)
    ApiMgr.Request("furniture/shareRewards", {}, true, callback, nil, true, true);
end


PlayerFoundationMgr.Visit = function(player)
    this.activityVisitUid = player.Uid;
    this.activityVisitPlayer = player;
    ApiMgr.Request("furniture/visit", {Uid=this.activityVisitUid}, true, this.VisitResponse, nil, true, true);
end


this.VisitResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        this.activityVisitData = data.result.Visitor;
        FoundationMgr.Visitor(FoundationMgr.ActivityRoom);
    end
end


PlayerFoundationMgr.GetActivityVisitPlayer = function()
    return this.activityVisitPlayer;
end


PlayerFoundationMgr.VisitList = function()
    ApiMgr.Request("furniture/visitList", {}, true, this.VisitListResponse, nil, true, true);
end


this.VisitListResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        LuaMgr.ShowLuaPanel(UIName.ActivityRoomVisitorViewModel, data.result);
    end
end


PlayerFoundationMgr.GetActivityRoomScore = function(roomId)
    local interactionConfig;
    local score = 0;
    local furnitures = DataMgr.Player.furnitures;
    if (furnitures ~= nil) then
        for _, v in pairs(furnitures) do
            if (v.Room == roomId) then
                interactionConfig = ConfigFoundationMgr.GetInteractionById(v.BuildingId);
                if (interactionConfig ~= nil) then
                    score = score + interactionConfig.Comfort;
                end
            end
        end
    end
    return score;
end


PlayerFoundationMgr.GetActivityVisitData = function()
    return this.activityVisitData;
end


PlayerFoundationMgr.GetActivityVisitRoom = function(roomId)
    if (this.activityVisitData ~= nil) then
        return this.activityVisitData[roomId];
    end
    return nil;
end