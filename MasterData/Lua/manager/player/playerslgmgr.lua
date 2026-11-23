PlayerSlgMgr = {}

local this = {
sysTime = 0,
sysTimeMS = 0,
    quest220MaxPorgress = 0,
eventTime = 0,
eventList = {},
customEventList = {},
buffList = {},
isSpecialReward = false,
dataTime = 0,
dataCallback = nil,
buffResult = nil,
battleWinKey = "SlgBattleWin",
battleWinState = 0,
    tabMapGroupList = { "daqinMap", "daqinMap_normal", "daqinMap_hard" }
};

PlayerSlgMgr.Init = function()
    PlayerSlgMgr.UpdateSysTime();
    this.battleWinState = PlayerPrefs.GetInt(this.battleWinKey, 0);
end

PlayerSlgMgr.Clear = function() 
    this.eventList = {};
    this.customEventList = {};
    this.buffList = {};
    this.isSpecialReward = false;
    this.dataCallback = nil;
    this.buffResult = nil;
end


PlayerSlgMgr.UpdateSysTime = function()
    this.sysTime = LuaMgr.Timestamp();
    this.sysTimeMS = LuaMgr.TimestampMS();
end


PlayerSlgMgr.GetSysTime = function() 
    return this.sysTime;
end


PlayerSlgMgr.GetSysTimeMS = function() 
    return this.sysTimeMS;
end


PlayerSlgMgr.IsMyCity = function(id)
    return DataMgr.Player.qinSelfCities[id] ~= nil;
end


PlayerSlgMgr.GetCityData = function(id)
    return DataMgr.Player.qinSelfCities[id];
end


PlayerSlgMgr.GetEnemyCityData = function(id)
    return DataMgr.Player.qinEnemyCities[id];
end


PlayerSlgMgr.GetQueueData = function(id)
    local buildQueues = DataMgr.Player.qinSandTable.buildQueues;
    if (IsNull(buildQueues)) then return nil end
    
    local len = #buildQueues;
    if (len > 0) then
        local data;
        for i = 1, len do
            data = buildQueues[i];
            if (data.buildId == id) then
                return data;
            end
        end
    end
    return nil;
end


PlayerSlgMgr.GetMarch = function(id)
    local march = DataMgr.Player.qinSandTable.march;
    local len = #march;
    for i = 1, len do
        if (march[i].endCity == id) then
            return march[i];
        end
    end
    return nil;
end


PlayerSlgMgr.GetMarchIndex = function(id)
    local march = DataMgr.Player.qinSandTable.march;
    local len = #march;
    for i = 1, len do
        if (march[i].endCity == id) then
            return i - 1;
        end
    end
    return -1;
end


PlayerSlgMgr.March = function(country, buildId, path, soldiers, strategy)
    this.MarkDataTime();
    local data = {Country = country, BuildId = buildId, Path = path, Soldiers = soldiers, Strategy = strategy};
    ApiMgr.Request("qin/march", data, true, this.OnMarchResponse, nil, true, true);
end


this.OnMarchResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        SlgSceneMgr.RefreshMarch();
    end
    LuaMgr.InvokeUIEventListeners(UIEventConst.SlgMainRefreshData);
    LuaMgr.HidePanel(UIName.SlgBattleArmyViewModel);
end


PlayerSlgMgr.Battle = function(index)
    this.MarkDataTime();
    ApiMgr.Request("qin/battle", {Index=index}, true, this.OnBattleResponse, nil, true, true);
end


this.OnBattleResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
if (data.result.IsTruce) then
            local buildId = data.result.BuildId;
            local cityData = PlayerSlgMgr.GetEnemyCityData(buildId);
            if (cityData ~= nil) then
                local truceTime = cityData.updateTimes[SlgUpdateTimes.truce];
                if (truceTime ~= nil) then
                    this.AddCustomEvent({id=SlgCustomEvent.TruceStart, eventId=buildId, endTime=truceTime});
                end
            end
        end
        LuaMgr.ShowLuaPanel(UIName.SlgBattleViewModel, data.result);
    end
end


PlayerSlgMgr.SetCityEvent = function(config)
    this.cityEvent = config;
end


PlayerSlgMgr.GetCityEvent = function()
    return this.cityEvent;
end


PlayerSlgMgr.UpdateCity = function()
    local cityConfig;
    local storyEvent;
    local qinEnemyCities = DataMgr.Player.qinEnemyCities;
    for _, v in pairs(qinEnemyCities) do
        if (v.curDurability <= 0) then
            cityConfig = ConfigSlgMgr.GetCityConfig(v.id);
            if (cityConfig ~= nil) then
                storyEvent = cityConfig.StoryEvent;
                if (storyEvent[1] == "1") then
                    if (PlayerSlgMgr.IsCompletedChapter(storyEvent[2])) then
                        ApiMgr.Request("qin/update_city", {BuildId=v.id}, true, this.OnUpdateCityResponse, nil, true, true);
                        return;
                    end
                else
                    local record = DataMgr.Player.dungeonRecords[storyEvent[2]];
                    if (record ~= nil and record.historyRating ~= "") then
                        ApiMgr.Request("qin/update_city", {BuildId=v.id}, true, this.OnUpdateCityResponse, nil, true, true);
                        return;
                    end
                end
            end
        end
    end
end


this.OnUpdateCityResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        data.result.Win = true;
        LuaMgr.ShowLuaPanel(UIName.SlgResultViewModel, data.result, 2);
    end
end


PlayerSlgMgr.BuildLevel = function(buildId)
    this.MarkDataTime();
    ApiMgr.Request("qin/build_level", {BuildId = buildId}, true, this.OnBuildLevelResponse, nil, true, true);
end


this.OnBuildLevelResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        local buildId = data.result.BuildId;
        SlgSceneMgr.RefreshCitys(buildId, false, false);
    end
    LuaMgr.HidePanel(UIName.SlgCityInfoViewModel);
end


this.MarkDataTime = function()
    this.dataTime = os.time() + 30;
end


PlayerSlgMgr.RefreshData = function(need, callback)
    if (not need and os.time() < this.dataTime) then return end
    
    this.MarkDataTime();
    this.dataCallback = callback;
    ApiMgr.Request("qin/getBuff", {}, true, this.OnDataResponse, nil, true, true);
end


this.OnDataResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        if (data.result.AllResLimit ~= nil) then
            this.buffResult = data.result;
            data.result = nil;
        end
    end
    LuaMgr.InvokeUIEventListeners(UIEventConst.SlgMainRefreshData);
    if (SlgSceneMgr ~= nil and SlgSceneMgr.isRun) then
        SlgSceneMgr.RefreshCitys("", true, false);
    end
    if (this.dataCallback ~= nil) then
        local callback = this.dataCallback;
        this.dataCallback = nil;
        callback();
    end
end


PlayerSlgMgr.GetCityDurability = function(cityData, config)
    if (cityData.curDurability < cityData.fullDurability) then
        local durabilityTimes = cityData.updateTimes[SlgUpdateTimes.durability];
        if (durabilityTimes == nil) then return 0 end
        
        local time = PlayerSlgMgr.GetSysTime() - durabilityTimes;
        local durability = math.floor(time / config.DurabilityAdd[1]) * config.DurabilityAdd[2];
        durability = durability + cityData.curDurability;
        if (durability > cityData.fullDurability) then
            durability = cityData.fullDurability;
        end
        return durability;
    end
    return cityData.fullDurability;
end


PlayerSlgMgr.GetDateByDay = function(timestamp, day)
    local time = timestamp + day * 24 * 3600;
    local date = os.date("%Y/%m/%d", time);
    return date;
end


PlayerSlgMgr.GetTodaySign = function(timestamp, day)
    local time = timestamp + day * 24 * 3600;
    local date = os.date("%Y/%m/%d", time);
    local sysTime = LuaMgr.Timestamp();
    local today = os.date("%Y/%m/%d", sysTime);
    return date == today, sysTime > time;
end


PlayerSlgMgr.GetQuestData = function(id)
    return DataMgr.Player.quests[id];
end


PlayerSlgMgr.IsNoMission = function()
    local quests = DataMgr.Player.quests;
    local questEvent = ConfigMgr.Config.questEvent;
    for _, v in pairs(questEvent) do
        if (v.groupId == 222) then
            if (quests[v.id] == nil) then
                return false;
            end
        end
    end
    return true;
end


PlayerSlgMgr.SetQuest220MaxPorgress = function(questEvents)
    local questData;
    this.quest220MaxPorgress = 0;
    local len = #questEvents;
    for i = 1, len do
        questData = PlayerSlgMgr.GetQuestData(questEvents[i].id);
        if (questData ~= nil and questData.progress > this.quest220MaxPorgress) then
            this.quest220MaxPorgress = questData.progress;
        end
    end
end


PlayerSlgMgr.GetQuest220MaxPorgress = function()
    return this.quest220MaxPorgress;
end


PlayerSlgMgr.GetActivityMapEvent = function(id)
    local daqin = DataMgr.Player.activityMaps.daqinMap;
    if (daqin ~= nil) then
        return daqin.activityEvents[id];
    end
    return nil;
end


PlayerSlgMgr.GetSoldiers = function()
    return DataMgr.Player.qinSandTable.soldiers;
end


PlayerSlgMgr.GetMaxSoldiers = function()
    local soldier = ConfigMgr.Config.QinTimesConstants.PowerInitialMax;
    if (this.buffResult ~= nil) then
        soldier = soldier + this.buffResult.SoldierLimit.Num;
    end
    return soldier;
end


PlayerSlgMgr.ProductSoldier = function(count, callback)
    this.MarkDataTime();
    ApiMgr.Request("qin/productSoldier", {Count = count}, true, callback, nil, true, true);
end


PlayerSlgMgr.GetUnify = function()
    local config;
    local unify = 0;
    local qinSelfCities = DataMgr.Player.qinSelfCities;
    for k, _ in pairs(qinSelfCities) do
        config = ConfigSlgMgr.GetCityConfig(k);
        if (config ~= nil and config.UnifyValue > 0) then
            unify = unify + config.UnifyValue;
        end
    end
    return unify + this.GetSkillUnify();
end


this.GetSkillUnify = function()
    local oId;
    local config, oConfig;
    local unifyValue = 0;
    local groupMap = {};
    local ids = DataMgr.Player.qinSkill.Ids;
    for k, _ in pairs(ids) do
        config = ConfigSlgMgr.GetSkillConfig(k);
        oId = groupMap[config.Group];
        if (oId ~= nil) then
            oConfig = ConfigSlgMgr.GetSkillConfig(oId);
            if (config.Level > oConfig.Level) then
                groupMap[config.Group] = k;
            end
        else
            groupMap[config.Group] = k;
        end
    end
    for _, v in pairs(groupMap) do
        config = ConfigSlgMgr.GetSkillConfig(v);
        unifyValue = unifyValue + config.UnifyValue;
    end
    return unifyValue;
end


PlayerSlgMgr.EventRewards = function(index)
    this.MarkDataTime();
    ApiMgr.Request("qin/getEventRewards", {Id = index}, true, this.OnEventRewards, nil, true, true);
end


this.OnEventRewards = function(result)
    this.eventTime = 0;
    PlayerSlgMgr.CheckEvents();
    PlayerSlgMgr.ClickEvent();
end


PlayerSlgMgr.GetSpecialReward = function()
    ApiMgr.Request("qin/getSpecialReward", {}, true, this.GetSpecialRewardResponse, nil, true, true);
end


this.GetSpecialRewardResponse = function(result)
    this.eventTime = 0;
    this.isSpecialReward = false;
    LuaMgr.InvokeUIEventListeners(UIEventConst.SlgMainRefreshData);
    PlayerSlgMgr.CheckEvents();
    PlayerSlgMgr.ClickEvent();
end


PlayerSlgMgr.ClickEvent = function()
    LuaMgr.HidePanel(UIName.SlgCollectEventViewModel);
    LuaMgr.HidePanel(UIName.SlgEffectEventViewModel);
    LuaMgr.HidePanel(UIName.SlgAvoidWarViewModel);
    LuaMgr.HidePanel(UIName.SlgTipsViewModel);
    
    local eventCount = #this.eventList;
    local customEventCount = #this.customEventList;
    if (eventCount <= 0 and customEventCount <= 0 and this.isSpecialReward == false) then return end

    if (eventCount > 0) then
        local event = this.eventList[1];
        local eventConfig = ConfigSlgMgr.GetEventConfig(event.eventId);
        if (eventConfig ~= nil) then
            local type = eventConfig.Type;
            if (type == "map" or type == "stage") then
                LuaMgr.ShowLuaPanel(UIName.SlgCollectEventViewModel, event);
            elseif (type == "buff_1" or type == "buff_2") then
                LuaMgr.ShowLuaPanel(UIName.SlgEffectEventViewModel, event, true);
            end
        end
        return;
    end
    if (this.isSpecialReward) then
        LuaMgr.ShowLuaPanel(UIName.SlgCollectEventViewModel, {id=SlgCustomEvent.SpecialReward});
        return;
    end
    if (customEventCount > 0) then
        local event = this.customEventList[1];
        table.remove(this.customEventList, 1);
        LuaMgr.InvokeUIEventListeners(UIEventConst.SlgMainRefreshData);
        if (event.id == SlgCustomEvent.TruceStart) then
            LuaMgr.ShowLuaPanel(UIName.SlgAvoidWarViewModel, event);
        elseif (event.id == SlgCustomEvent.TruceEnd) then
            local cityConfig = ConfigSlgMgr.GetCityConfig(event.eventId);
            if (cityConfig ~= nil) then
                local country = ConfigSlgMgr.GetCountryName(cityConfig.Country);
                local msg = string.format(ConfigMgr.LangGlobal("10315"), cityConfig.CityName, country);
                LuaMgr.ShowLuaPanel(UIName.SlgTipsViewModel, msg);
            end
        elseif (event.id == SlgCustomEvent.CityUpgrade) then
            local cityConfig = ConfigSlgMgr.GetCityConfig(event.eventId);
            if (cityConfig ~= nil) then
                local msg = string.format(ConfigMgr.LangGlobal("10316"), cityConfig.CityName);
                LuaMgr.ShowLuaPanel(UIName.SlgTipsViewModel, msg);
            end
        end
    end
end


PlayerSlgMgr.CheckEvents = function()
    local time = PlayerSlgMgr.GetSysTime();
    if (time < this.eventTime) then return end

    this.eventTime = time + 1;
    local event;
    local eventConfig;
    local eventCount = #this.eventList;
    local buffCount = #this.buffList;
    local isSpecialReward = this.isSpecialReward;
    this.eventList = {};
    this.buffList = {};
    this.specialRewardList = {};
    local events = DataMgr.Player.qinSandTable.events;
    local len = #events;
    for i = 1, len do
        event = events[i];
        eventConfig = ConfigSlgMgr.GetEventConfig(event.eventId);
        if (eventConfig ~= nil) then
            if (time >= event.startTime and (time < event.endTime or event.endTime == 0)) then
                if (not event.prize and not IsNull(eventConfig.Reward)) then
                    table.insert(this.eventList, event);
                end
                if (eventConfig.Type == "buff_1" or eventConfig.Type == "buff_2") then
                    table.insert(this.buffList, event);
                end
            end
        end
    end
    local specialReward = DataMgr.Player.qinSandTable.specialReward;
    if (specialReward ~= nil) then
        for _, _ in pairs(specialReward) do
            this.isSpecialReward = true;
            break;
        end
    end
    if (#this.eventList ~= eventCount or 
            #this.buffList ~= buffCount or 
            this.isSpecialReward ~= isSpecialReward) then
        LuaMgr.HidePanel(UIName.SlgCollectEventViewModel);
        LuaMgr.HidePanel(UIName.SlgEffectEventViewModel);
        LuaMgr.HidePanel(UIName.SlgTipsViewModel);
        LuaMgr.InvokeUIEventListeners(UIEventConst.SlgMainRefreshData);
    end
end


PlayerSlgMgr.GetEventCount = function()
    local count = #this.eventList + #this.customEventList;
    if (this.isSpecialReward) then
        count = count + 1;
    end
    return count;
end


PlayerSlgMgr.GetBuffList = function()
    return this.buffList;
end


PlayerSlgMgr.GetSpecialRewardList = function()
    local specialReward = DataMgr.Player.qinSandTable.specialReward;
    if (specialReward ~= nil) then
        local specialRewardList = {};
        for k, v in pairs(specialReward) do
            table.insert(specialRewardList, {id=k, count=v});
        end
        return specialRewardList;
    end
    return nil;
end


this.AddCustomEvent = function(event)
    table.insert(this.customEventList, event);
end


PlayerSlgMgr.CheckCityTruce = function()
    local truceTime;
    local time = PlayerSlgMgr.GetSysTime();
    local qinEnemyCities = DataMgr.Player.qinEnemyCities;
    for k, v in pairs(qinEnemyCities) do
        truceTime = v.updateTimes[SlgUpdateTimes.truce];
        if (truceTime ~= nil and time > truceTime) then
            v.updateTimes[SlgUpdateTimes.truce] = nil;
            this.AddCustomEvent({id=SlgCustomEvent.TruceEnd, eventId=k});
            SlgSceneMgr.RefreshCity(k);
        end
    end
end


PlayerSlgMgr.CityUpgradeEvent = function(id)
    this.AddCustomEvent({id=SlgCustomEvent.CityUpgrade, eventId=id});
    LuaMgr.InvokeUIEventListeners(UIEventConst.SlgMainRefreshData);
    PlayerSlgMgr.RefreshData(true, nil);
end


PlayerSlgMgr.IsCityLock = function(id)
    local cityData = DataMgr.Player.qinEnemyCities[id];
    if (cityData ~= nil) then
        local unlockTime = cityData.updateTimes[SlgUpdateTimes.unlock];
        return unlockTime ~= nil and unlockTime > PlayerSlgMgr.GetSysTime();
    end
    return false;
end


PlayerSlgMgr.GetSkillData = function(group)
    local map = ConfigMgr.Config.QinTimesSkillLvMap[group];
    if (map ~= nil) then
        local result;
        local level = 0;
        local ids = DataMgr.Player.qinSkill.Ids;
        for _, v in pairs(map) do
            if (ids[v.Id] and v.Level > level) then
                level = v.Level;
                result = v;
            end
        end
        return result;
    end
    return nil;
end


PlayerSlgMgr.IsSkillLock = function(id)
    return not DataMgr.Player.qinSkill.Ids[id];
end


PlayerSlgMgr.IsSkillLevelGreater = function(config)
    local map = ConfigMgr.Config.QinTimesSkillLvMap[config.Group];
    if (map ~= nil) then
        local ids = DataMgr.Player.qinSkill.Ids;
        for _, v in pairs(map) do
            if (ids[v.Id] and v.Level >= config.Level) then
                return true;
            end
        end
    end
    return false;
end


PlayerSlgMgr.IsStudySkill = function()
    local qinSkill = DataMgr.Player.qinSkill;
    return qinSkill.StudyId ~= "" and this.sysTime < qinSkill.StudyEndTime;
end


PlayerSlgMgr.IsSkillStudying = function(config)
    local qinSkill = DataMgr.Player.qinSkill;
    if (qinSkill.StudyId ~= "" and this.sysTime < qinSkill.StudyEndTime) then
        local studyConfig = ConfigSlgMgr.GetSkillConfig(qinSkill.StudyId);
        if (studyConfig ~= nil) then
            return studyConfig.Group == config.Group;
        end
    end
    return false;
end


PlayerSlgMgr.IsSkillMaxLevel = function(config)
    local nextConfig = ConfigSlgMgr.GetSkillByGroupAndLevel(config.Group, config.Level + 1);
    return nextConfig == nil;
end


PlayerSlgMgr.IsFillStudyCondition = function(config)
    local condition;
    local len = #config.BeforeLock;
    for i = 1, len do
        condition = ConfigSlgMgr.GetSkillConfig(config.BeforeLock[i]);
        if (condition ~= nil) then
            if (not PlayerSlgMgr.IsSkillLevelGreater(condition)) then
                return false;
            end
        end
    end
    if (#config.OtherLock > 0) then
        local type = config.OtherLock[1];
if (type == "1") then
            if (not PlayerSlgMgr.IsMyCity(config.OtherLock[2])) then
                return false;
            end
elseif (type == "2") then
            local cityData = PlayerSlgMgr.GetCityData(config.OtherLock[2]);
            local level = tonumber(config.OtherLock[3]);
            if (cityData == nil or cityData.lv < level) then
                return false;
            end
        end
    end
    return true;
end


PlayerSlgMgr.IsFillStudyCost = function(config)
    local costItem;
    local count;
    local len = #config.CostItem;
    for i = 1, len do
        costItem = config.CostItem[i];
        count = PlayerItemMgr.GetItemCountById(costItem.id);
        if (count < costItem.count) then
            return false;
        end
    end
    if (config.CostPower > 0) then
        local soldiers = PlayerSlgMgr.GetSoldiers();
        if (soldiers < config.CostPower) then
            return false;
        end
    end
    return true;
end


PlayerSlgMgr.StudySkill = function(id)
    ApiMgr.Request("qin/studySkill", {Id=id}, true, this.OnStudySkillResponse, nil, true, true);
end


this.OnStudySkillResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        LuaMgr.InvokeUIEventListeners(UIEventConst.SlgTechnologyStudy);
    end
end


PlayerSlgMgr.GetCollectProgress = function(type)
    local collectConfig;
    local progress = 0;
    local qinCollect = DataMgr.Player.qinCollect;
    for _, v in pairs(qinCollect) do
        collectConfig = ConfigSlgMgr.GetCollectConfig(v.id);
        if (collectConfig ~= nil and collectConfig.Type == type) then
            progress = progress + 1;
        end
    end
    return progress;
end


PlayerSlgMgr.GetCollectData = function(id)
    return DataMgr.Player.qinCollect[id];
end


PlayerSlgMgr.CollectAward = function(id)
    ApiMgr.Request("qin/getCollectAward", {Id=id}, true, this.GetCollectAwardResponse, nil, true, true);
end


this.GetCollectAwardResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and not IsNull(data.result)) then
        local reward = json.encode(data.result);
        LuaMgr.ShowItemRewared(reward);
        LuaMgr.InvokeUIEventListeners(UIEventConst.SlgCollectReward);
    end
end


PlayerSlgMgr.GetMarchCost = function(army, cost, path)
    local powerFightRangeCost = ConfigMgr.Config.QinTimesConstants.PowerFightRangeCost;
    local powerFightCoefficient = ConfigMgr.Config.QinTimesConstants.PowerFightCoefficient;
    local costCount = army * (#path - 1) * powerFightRangeCost;
    costCount = math.floor(costCount * tonumber(cost) * powerFightCoefficient * (1 + this.buffResult.MarchCost.Percent));
    return costCount + this.buffResult.MarchCost.Num;
end


PlayerSlgMgr.IsCompletedChapter = function(id)
    local completedChapters = DataMgr.Player.completedChapters;
    local len = #completedChapters;
    for i = 1, len do
        if (completedChapters[i] == id) then
            return true;
        end
    end
    return false;
end


PlayerSlgMgr.GetResourcesMax = function(id)
    local resource = ConfigSlgMgr.GetResourcesMax(id);
    if (this.buffResult ~= nil) then
        resource = resource + this.buffResult.AllResLimit.Num;
        local itemRes = this.buffResult.ItemResLimit[id];
        if (itemRes ~= nil) then
            resource = resource + itemRes.Num;
        end
    end
    return resource;
end


PlayerSlgMgr.GetReinforcements = function(id)
    local config;
    local sConfig, eConfig;
    local cityData;
    local soldier;
    local reinforcements = {};
    local count = 0;
    local qinTimesLineArray = ConfigMgr.Config.QinTimesLineArray;
    local len = #qinTimesLineArray;
    for i = 1, len do
        config = qinTimesLineArray[i];
        if (id == config.Start or id == config.End) then
            sConfig = ConfigSlgMgr.GetCityConfig(config.Start);
            eConfig = ConfigSlgMgr.GetCityConfig(config.End);
            if (sConfig.Country == eConfig.Country) then
                if (id == config.Start) then
                    cityData = PlayerSlgMgr.GetEnemyCityData(config.End);
                    if (cityData ~= nil and cityData.curDurability > 0 and cityData.soldiers > eConfig.ThresholdHelp) then
                        soldier = cityData.soldiers > eConfig.Help and eConfig.Help or cityData.soldiers - eConfig.ThresholdHelp;
                        if (soldier > 0) then
                            count = count + soldier;
                            table.insert(reinforcements, {id=config.End, name=LuaMgr.GetLangText(eConfig.CityNameLan), value=tostring(soldier)});
                        end
                    end
                else
                    cityData = PlayerSlgMgr.GetEnemyCityData(config.Start);
                    if (cityData ~= nil and cityData.curDurability > 0 and cityData.soldiers > sConfig.ThresholdHelp) then
                        soldier = cityData.soldiers > sConfig.Help and sConfig.Help or cityData.soldiers - sConfig.ThresholdHelp;
                        if (soldier > 0) then
                            count = count + soldier;
                            table.insert(reinforcements, {id=config.Start, name=LuaMgr.GetLangText(sConfig.CityNameLan), value=tostring(soldier)});
                        end
                    end
                end
            end
        end
    end
    return reinforcements, count;
end


PlayerSlgMgr.AdminReset = function()
    ApiMgr.Request("admin/qin/reset", {}, true, function(result)
        this.eventList = {};
        this.buffList = {};
        this.specialRewardList = {};
        this.isSpecialReward = false;
        LuaMgr.HidePanel(UIName.SlgGMViewModel);
        LuaMgr.ShowLuaPanel(UIName.MainPageViewModel);
    end, nil, true, true);
end


PlayerSlgMgr.AdminAddItems = function(count)
    local datas = {{id="6010", count=count},{id="6011", count=count},{id="6012", count=count},{id="6013", count=count}};
    ApiMgr.Request("admin/add_items", datas, true, function(result)
        LuaMgr.InvokeUIEventListeners(UIEventConst.SlgMainRefreshData);
    end, nil, true, true);
end


PlayerSlgMgr.AdminDelItem = function()
    local datas = {"6010","6011","6012","6013"};
    ApiMgr.Request("admin/del_item", {ItemIDs=datas}, true, function(result)
        LuaMgr.InvokeUIEventListeners(UIEventConst.SlgMainRefreshData);
    end, nil, true, true);
end


PlayerSlgMgr.AdminClearSoldier = function()
    ApiMgr.Request("admin/qin/clearSoldier", {ItemIDs=datas}, true, function(result)
        LuaMgr.InvokeUIEventListeners(UIEventConst.SlgMainRefreshData);
    end, nil, true, true);
end


PlayerSlgMgr.AdminAddBuff = function(id, callback)
    ApiMgr.Request("admin/qin/addBuff", {BuffId=id}, true, callback, nil, true, true);
end


PlayerSlgMgr.AdminRemoveBuff = function(id, callback)
    ApiMgr.Request("admin/qin/removeBuff", {BuffId=id}, true, callback, nil, true, true);
end


PlayerSlgMgr.AdminGetBuffList = function(callback)
    ApiMgr.Request("admin/qin/getBuffList", {}, true, function(result)
        local data = json.decode(result);
        if (data ~= nil and data.result ~= nil) then
            callback(data.result.List);
        end
    end, nil, true, true);
end


PlayerSlgMgr.AdminSetDurability = function(durability)
    ApiMgr.Request("admin/qin/setDurability", {Durability=durability}, true, this.OnDataResponse, nil, true, true);
end


PlayerSlgMgr.AdminBattleWin = function(index)
    ApiMgr.Request("admin/qin/battleWin", {Index=index}, true, this.OnDataResponse, nil, true, true);
end


PlayerSlgMgr.AdminFinishTime = function(type)
    ApiMgr.Request("admin/qin/finishTime", {Type=type}, true, this.OnDataResponse, nil, true, true);
end


PlayerSlgMgr.IsBattleWin = function()
    return this.battleWinState == 1;
end


PlayerSlgMgr.ChangedBattleWin = function()
    this.battleWinState = this.battleWinState == 0 and 1 or 0;
    PlayerPrefs.SetInt(this.battleWinKey, this.battleWinState);
end



PlayerSlgMgr.InitSlgNewDotData= function ()
    PlayerSlgMgr.InitTaskNewDotData()
    PlayerSlgMgr.InitChapterNewDotData()
end

PlayerSlgMgr.CheckEntranceRedAndNewDot = function ()
    if not DataExHelper.CommonActivityCheck(ActivityKey.daqin) then       
        return false;
    end   
    local bSign = PlayerSlgMgr.CheckSignEntranceRedDot()
    local bTask = PlayerSlgMgr.CheckTaskEntranceRedDot()   
    local bShop = PlayerSlgMgr.CheckShopEntranceNewDot()
    local bVideo = PlayerSlgMgr.CheckVideoEntranceNewDot()   
    local bChapter = PlayerSlgMgr.CheckChapterEntranceNewDot()  
    local bMain =  PlayerSlgMgr.CheckMainTaskEntranceRedDot() 
    local bReward = PlayerSlgMgr.CheckRewardEntranceNewDot()
    if(bSign or bTask or bShop or bMain or bReward)then
        RedMgr.Singleton:UpdateClientRedData("14012",1)
    else
        RedMgr.Singleton:UpdateClientRedData("14012",0)
    end   
end

PlayerSlgMgr.CheckSignEntranceRedDot = function ()    
    if(this.configQuest221 == nil)then
        this.configQuest221 = DataExHelper.Check_ConfigQuestEventByGroupId(221);
    end    
    for k, v in pairs(this.configQuest221) do
        local data = DataMgr.Player.quests[v.id]
        if(data ~= nil and data.state == 2)then
            RedMgr.Singleton:UpdateClientRedData("14001",1)
            return true
        end
    end
    RedMgr.Singleton:UpdateClientRedData("14001",0)
    return false
end

PlayerSlgMgr.CheckTaskEntranceRedDot = function ()    
    if(this.configQuest222 == nil)then
        this.configQuest222 = DataExHelper.Check_ConfigQuestEventByGroupId(222);
    end      
    for k, v in pairs(this.configQuest222) do
        local data = DataMgr.Player.quests[v.id]
        if(data ~= nil and data.state == 2)then
            if (#v.special <= 0 and data.idx >= 0) then
                RedMgr.Singleton:UpdateClientRedData("14002",1)
                return true     
            end
        end
    end    
    RedMgr.Singleton:UpdateClientRedData("14002",0)    
    return false 
end

PlayerSlgMgr.InitTaskNewDotData = function ()
    if(this.bInitTaskNewDotData == nil)then
        this.bInitTaskNewDotData = true
    else
        return
    end    
    this.taskUnlockDataMap = {}
    this.taskUnlockDataMapShown = {}
    local curPlayerData = DataMgr.Player.activityMaps["daqinMap_main"]
    if(curPlayerData ~= nil)then
        for key, value in pairs(curPlayerData.activityEvents) do
            this.taskUnlockDataMap[key] = true 
            this.taskUnlockDataMapShown[key] = true 
        end 
    end
 end

 PlayerSlgMgr.UpdateTaskNewDotData = function (id)  
    local refresh = false
    if(this.taskUnlockDataMap == nil)then
        this.taskUnlockDataMap = {}
    end
    if(this.taskUnlockDataMap[id] == nil)then
        this.taskUnlockDataMap[id] = true 
        refresh = true     
    end  
    return refresh 
 end

 PlayerSlgMgr.CheckTaskNewDotDataById = function (type,id)
     if this.taskUnlockDataMap==nil then
         this.taskUnlockDataMap={}
     end
    local cache = DataMgr.Player.activityMaps[type]
    if(cache ~= nil)then
        local curPlayerData = cache.activityEvents
        if curPlayerData[tostring(id)] and this.taskUnlockDataMap and this.taskUnlockDataMap[id] == nil then
            return true          
        end        
    end 
    return false
 end

 PlayerSlgMgr.CheckTaskShownById = function (type,id)     
    local bNew = false  
    if(PlayerSlgMgr.CheckTaskNewDotDataById(type,id) and this.taskUnlockDataMapShown[id] == nil)then
        if this.startDelay ~= nil then
            coroutine_runner.stop(this.startDelay)
        end
        this.startDelay = coroutine_runner.start(function()
            coroutine_runner.wait(1)
            this.taskUnlockDataMapShown[id] = true          
        end) 
        bNew = true          
    end    
    return bNew
 end

 PlayerSlgMgr.CheckCollectRedDotData = function ()   
    local bFinish = false
    for k, v in pairs(ConfigMgr.Config.QinTimeCollectTypeMap) do
        local bHasRed = false
        for i,value in ipairs(v) do
            local collectData = PlayerSlgMgr.GetCollectData(value.Id);
            if (collectData ~= nil) then
                if (collectData.status == 0) then
                    bHasRed = true
                end  
            end           
        end
        if(bHasRed)then
            bFinish = true
            RedMgr.Singleton:UpdateClientRedData("14011_"..k, 1);
        else
            RedMgr.Singleton:UpdateClientRedData("14011_"..k, 0);
        end
    end
    if( bFinish )then
        RedMgr.Singleton:UpdateClientRedData("14007", 1);
    else
        RedMgr.Singleton:UpdateClientRedData("14007", 0);
    end   
    return bFinish
 end

 PlayerSlgMgr.CheckUnionEntranceRedDot = function ()    
    if(this.configQuest222 == nil)then
        this.configQuest222 = DataExHelper.Check_ConfigQuestEventByGroupId(222);
    end    
    
    for k, v in pairs(this.configQuest222) do
        local data = DataMgr.Player.quests[v.id]
        if(data ~= nil and data.state == 2)then            
            if(#v.special > 0 and v.special[1] == "mainTask") then
                RedMgr.Singleton:UpdateClientRedData("14009",1)
                return true
            end
        end
    end  
    RedMgr.Singleton:UpdateClientRedData("14009",0)
    return false
end

 PlayerSlgMgr.CheckMainTaskEntranceRedDot = function ()    
    if(this.configDaqinMainMap == nil)then
        this.configDaqinMainMap = DataExHelper.EX_GetEventListByArea("daqinMap_main");
    end 
    local bMain = false   
    local bOnlyPass = false
    for k, v in pairs(this.configDaqinMainMap) do
        if(PlayerSlgMgr.CheckTaskNewDotDataById("daqinMap_main",v.id))then            
            bMain = true
        end 
        local eventData = PlayerQinMgr.GetActivityMapEvent("daqinMap_main", v.id);
        if (eventData ~= nil and eventData.complete) then
            local record = DataMgr.Player.dungeonRecords[v.eventParam];
            if (record ~= nil and not IsNullOrEmpty(record.historyRating) and record.historyRating ~= "S") then
                bOnlyPass = true                    
            end
        end        
    end
    if(bOnlyPass)then
        local num = RedMgr.Singleton:CheckRedCondition("14010") and 1 or 0
        RedMgr.Singleton:UpdateClientRedData("14010", num);
    else
        RedMgr.Singleton:UpdateClientRedData("14010", 0);
    end
    local bCollect =  PlayerSlgMgr.CheckCollectRedDotData()    
    local bUnion = PlayerSlgMgr.CheckUnionEntranceRedDot()
    local showRed = bMain or bOnlyPass or bCollect or bUnion
    if(showRed)then
        RedMgr.Singleton:UpdateClientRedData("14008",1)
    else
        RedMgr.Singleton:UpdateClientRedData("14008",0)
    end   
    return false
end

PlayerSlgMgr.CheckShopEntranceNewDot = function ()    
    local daqin = DataExHelper.GetDataExByTag(ActivityKey.daqin);
    local sysTime = LuaMgr.Timestamp();
    if(this.configQuest220 == nil)then
        this.configQuest220 = DataExHelper.Check_ConfigQuestEventByGroupId(220);
    end    
    local showRed1 = false
    local showRed2 = false
    if (daqin == nil) then
        return false
    end
    for k, v in pairs(this.configQuest220) do
        local startTime = v.startTime * 60 + daqin.startTime;
        local endTime = v.endTime * 60 + daqin.startTime;
        if (sysTime >= startTime and sysTime <= endTime) then            
            if (v.cost ~= nil and #v.cost > 0 and v.cost[1].count == 0) then
                local data = DataMgr.Player.quests[v.id]
                if(data ~= nil and data.progress < v.progress)then                    
                    showRed1 = true
                end
            end
        end        
    end
    local hadExchanged = DataMgr.Player.Qin.HadExchanged;
    local qinExchangeChar = ConfigMgr.Config.constants.QinExchangeChar;
    if (qinExchangeChar ~= nil) then
        local itemsAccumulate = DataMgr.Player.itemsAccumulate[qinExchangeChar[1]];
        itemsAccumulate = itemsAccumulate == nil and 0 or itemsAccumulate;  
        if(itemsAccumulate >= tonumber(qinExchangeChar[2]) and not hadExchanged) then
            showRed2 = true
        end  
    end
    if(showRed1 or showRed2)then
        RedMgr.Singleton:UpdateClientRedData("14003",1)
    else
        RedMgr.Singleton:UpdateClientRedData("14003",0)  
    end   
    return showRed1 or showRed2
end

PlayerSlgMgr.InitChapterNewDotData = function ()
    if(this.bInitChapterNewDotData == nil)then
        this.bInitChapterNewDotData = true
    else
        return
    end    
    this.chapterUnlockDataMap = {}
    this.chapterUnlockDataMapShown = {}
    for i,v in ipairs(this.tabMapGroupList) do
        local curPlayerData = DataMgr.Player.activityMaps[v]
        if(curPlayerData ~= nil)then
            for key, value in pairs(curPlayerData.activityEvents) do
                this.chapterUnlockDataMap[key] = true 
                this.chapterUnlockDataMapShown[key] = true 
            end 
        end
    end
 end

 PlayerSlgMgr.UpdateChapterNewDotData = function (id)  
    local refresh = false
    if(this.chapterUnlockDataMap == nil)then
        this.chapterUnlockDataMap = {}
    end
    if(this.chapterUnlockDataMap[id] == nil)then
        this.chapterUnlockDataMap[id] = true 
        refresh = true     
    end  
    return refresh 
 end

 PlayerSlgMgr.CheckChapterNewDotDataById = function (type,id)      
    local cache = DataMgr.Player.activityMaps[type]
    if(cache ~= nil)then
        local curPlayerData = cache.activityEvents       
        if curPlayerData[tostring(id)] and (this.chapterUnlockDataMap == nil or this.chapterUnlockDataMap[id] == nil) then
            return true          
        end        
    end 
    return false
 end

 PlayerSlgMgr.CheckChapterShownById = function (type,id)     
    local bNew = false  
    if(PlayerSlgMgr.CheckChapterNewDotDataById(type,id) and this.chapterUnlockDataMapShown[id] == nil)then
        if this.startDelay ~= nil then
            coroutine_runner.stop(this.startDelay)
        end
        this.startDelay = coroutine_runner.start(function()       
            coroutine_runner.wait(1)
            this.chapterUnlockDataMapShown[id] = true          
        end) 
        bNew = true          
    end    
    return bNew
 end

 PlayerSlgMgr.CheckVideoEntranceNewDot = function ()    
    if(this.configDaqinMap == nil)then
        this.configDaqinMap = DataExHelper.EX_GetEventListByArea("daqinMap");
    end    
    for k, v in pairs(this.configDaqinMap) do
        if(PlayerSlgMgr.CheckChapterNewDotDataById("daqinMap",v.id))then
            RedMgr.Singleton:UpdateClientRedData("14004",1)
            return true
        end       
    end
    RedMgr.Singleton:UpdateClientRedData("14004",0)
    return false
end

PlayerSlgMgr.CheckRewardEntranceNewDot = function ()   
    local canReward = false 
    local config1 = ConfigMgr.Config.DrawActivityMap["13001"];
    local config2 = ConfigMgr.Config.DrawActivityMap["14001"];
    local cost = config1.Consume[1];
    local itemCount = PlayerItemMgr.GetItemCountById(cost.id);
    local count = cost.count;
    if (itemCount >= count and PlayerSlgMgr.CheckRemainNum(config1)) then
        canReward = true
    end
    cost = config2.Consume[1];
    itemCount = PlayerItemMgr.GetItemCountById(cost.id);
    count = cost.count;
    if (itemCount >= count and PlayerSlgMgr.CheckRemainNum(config2)) then
        canReward = true
    end
    
    if(canReward)then
        RedMgr.Singleton:UpdateClientRedData("14006",1)
        return true    
    end   
    RedMgr.Singleton:UpdateClientRedData("14006",0)
    return false
end

PlayerSlgMgr.CheckRemainNum = function (config)
    local drawMap = ConfigMgr.Config.DrawMap;
    local drawActivity = config
    local len = #drawActivity.Content;
    local bRemain = false
    for i = 1, len do
        local drawConfig = drawMap[drawActivity.Content[i]];
        local count = drawConfig.Time;
        local key = string.format("%s_%s", drawActivity.ID, drawConfig.ID);
        local hasBuyCount = DataMgr.Player.drawRewardRecords[key];
        if (hasBuyCount ~= nil) then
            count = count - hasBuyCount;
        end
        if(count > 0)then
            bRemain = true
        end        
    end
    return bRemain
end

PlayerSlgMgr.CheckChapterEntranceNewDot = function ()    
    if(this.configDaqinMapN == nil)then
        this.configDaqinMapN = DataExHelper.EX_GetEventListByArea("daqinMap_normal");
    end  
    if(this.configDaqinMapH == nil)then
        this.configDaqinMapH = DataExHelper.EX_GetEventListByArea("daqinMap_hard");
    end    
    local bRed = false     
    for k, v in pairs(this.configDaqinMapN) do
        if(PlayerSlgMgr.CheckChapterNewDotDataById("daqinMap_normal",v.id))then           
            bRed = true
            break
        end       
    end
    for k, v in pairs(this.configDaqinMapH) do
        if(PlayerSlgMgr.CheckChapterNewDotDataById("daqinMap_hard",v.id))then           
            bRed = true
            break
        end       
    end    
    if(PlayerSlgMgr.CheckRewardEntranceNewDot())then
        bRed = true
    end

    if(bRed)then
        RedMgr.Singleton:UpdateClientRedData("14005",1)
    else
        RedMgr.Singleton:UpdateClientRedData("14005",0)
    end   
    return bRed
end




