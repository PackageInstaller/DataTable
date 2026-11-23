PlayerAreaMapMgr = {}

local this = {
areaMapBuildingStatusDic = nil,
areaMapBuildingEventDic = nil,
areaMapSurveyEventDic = nil,
};


PlayerAreaMapMgr.InitAreaMapBuildingStatus = function()
    this.areaMapBuildingStatusDic = {};
    if PlayerAreaMgr.GetAreaModel()==AreaModel.Novel then
        this.areaMapBuildingStatusDic=PlayerAreaMgr_NovelModel.areaMapBuildingStatus;
        return
    end
    local areaMaps = DataMgr.Player.areaMaps;
    for k, v in pairs(areaMaps) do
        for _, item in pairs(v.mapGroups) do
            this.CheckBuildIsLock(v.area,item);
            this.areaMapBuildingStatusDic[string.format("%s_%s", k, item.id)] = item.lock;
        end
    end
end


this.CheckBuildIsLock=function(area,groupInfo)
    if groupInfo.lock then return end;
    local curAreaMapGroup=ConfigMgr.Config.areaMapGroup[area];
    if curAreaMapGroup==nil then return end;
    for i,v in ipairs(curAreaMapGroup) do
        if v.id==groupInfo.id then
            local unLockEvent=ConfigMgr.Config.areaEvents[v.unlockParam];
            if unLockEvent~=nil and unLockEvent.type==1 then
                if ConfigMgr.Config.areaEvents[unLockEvent.unlockParam].type==2 then
                    local eventParam=ConfigMgr.Config.areaEvents[unLockEvent.unlockParam].eventParam
                    groupInfo.lock=DataMgr.Player.dungeonRecords[eventParam]==nil or DataMgr.Player.dungeonRecords[eventParam].completeCount==0;
                end
            end
            return;
        end
    end
    
end


PlayerAreaMapMgr.CheckAreaMapBuildingStatus = function(area, id)
    if PlayerAreaMgr.GetAreaModel()==AreaModel.Novel then
        local key=string.format("%s_%s", area, id);
        return this.areaMapBuildingStatusDic[key]~=PlayerAreaMgr_NovelModel.areaMapBuildingStatus[key];
    end
    local areaMap = DataMgr.Player.areaMaps[area];
    if (areaMap == nil) then return false end

    local mapGroup = areaMap.mapGroups[id];
    if (mapGroup == nil) then return false end
    if not mapGroup.lock then
        PlayerAreaMapMgr.CheckMapBuildingUnlock(area,mapGroup)
    end
    local isLock = this.areaMapBuildingStatusDic[string.format("%s_%s", area, id)];
    return isLock ~= mapGroup.lock;
end


PlayerAreaMapMgr.ModifyAreaMapBuildingStatus = function(area, id)
    if PlayerAreaMgr.GetAreaModel()==AreaModel.Novel then
        local key=string.format("%s_%s", area, id);
        this.areaMapBuildingStatusDic[key] = PlayerAreaMgr_NovelModel.areaMapBuildingStatus[key];
        return;
    end
    local areaMap = DataMgr.Player.areaMaps[area];
    if (areaMap == nil) then return end

    local mapGroup = areaMap.mapGroups[id];
    if (mapGroup == nil) then return end

    this.areaMapBuildingStatusDic[string.format("%s_%s", area, id)] = mapGroup.lock;
end


PlayerAreaMapMgr.InitAreaMapSurveyEvent = function()
    ConfigAreaMgr.InitAreaMapSurveyEvent();
end


PlayerAreaMapMgr.GetAreaMapSurveyEvent = function(key)
    return this.areaMapSurveyEventDic[key];
end


PlayerAreaMapMgr.InitAreaMapBuildingEvent = function()
    local eventDic;
    local config;
    local key;
    this.areaMapBuildingEventDic = {};
    local areaEventMap = ConfigMgr.Config.areaEvents;
    local areaMaps = DataMgr.Player.areaMaps;
    for k, v in pairs(areaMaps) do
        for _, item in pairs(v.areaEvents) do
            config = areaEventMap[item.id];
            if (config ~= nil) then
                key = string.format("%s_%s", k, config.groupId);                
                eventDic = this.areaMapBuildingEventDic[key];
                if (eventDic == nil) then
                    eventDic = {};
                    this.areaMapBuildingEventDic[key] = eventDic;
                end
                eventDic[item.id] = 0;
            end
        end
    end
end

PlayerAreaMapMgr.CheckAreaCanFight = function(type)
    local curAreaConfig = nil
    local minLockConfig = nil
    local maxSort = 0
    local minSort = 10000
    for i, v in pairs(ConfigMgr.Config.areas) do
        if DataMgr.Player.areaMaps ~= nil and v.world == type then
            if (DataMgr.Player.areaMaps[v.area] ~= nil and not DataMgr.Player.areaMaps[v.area].lock) then
                if v.sortNum > maxSort then
                    maxSort = v.sortNum
                    curAreaConfig = v;
                end
            else
                if v.sortNum < minSort then
                    minSort = v.sortNum
                    minLockConfig = v;
                end
            end
        end
    end
    return curAreaConfig,minLockConfig    
end


PlayerAreaMapMgr.CheckAreaMapBuildingEvent = function(area, id)
    local areaMap = DataMgr.Player.areaMaps[area];
    if (areaMap == nil) then return false end

    local key = string.format("%s_%s", area, id);
    local eventDic = this.areaMapBuildingEventDic[key];
    if (eventDic == nil) then
        eventDic = {};
        this.areaMapBuildingEventDic[key] = eventDic;
    end
    local config;
    local areaEventMap = ConfigMgr.Config.areaEvents;
    for _, v in pairs(areaMap.areaEvents) do
        config = areaEventMap[v.id];
        if (config ~= nil and config.groupId == id) then
            if (eventDic[v.id] == nil) then
                return true;
            end
            if (eventDic[v.id] == 1) then
                return true;
            end
        end
    end
    return false;
end


PlayerAreaMapMgr.CheckAreaMapBuildingEvent = function(area, id, eid)
    local areaMap = DataMgr.Player.areaMaps[area];
    if (areaMap == nil) then return false end

    local key = string.format("%s_%s", area, id);
    local eventDic = this.areaMapBuildingEventDic[key];
    if (eventDic == nil) then
        eventDic = {};
        this.areaMapBuildingEventDic[key] = eventDic;
    end
    local eventData = areaMap.areaEvents[eid];
    if (eventData == nil) then return false end

    local config = ConfigMgr.Config.areaEvents[eventData.id];
    if (config == nil) then return false end

    if (config.groupId == id) then
        if (eventDic[eventData.id] == nil) then
            return true;
        end
        if (eventDic[eventData.ID] == 1) then
            return true;
        end
    end
    return false;
end


PlayerAreaMapMgr.CheckAreaMapBuildingNewEvent = function(area, id, eid)
    local areaMap = DataMgr.Player.areaMaps[area];
    if (areaMap == nil) then return false end

    local key = string.format("%s_%s", area, id);
    local eventDic = this.areaMapBuildingEventDic[key];
    if (eventDic == nil) then
        eventDic = {};
        this.areaMapBuildingEventDic[key] = eventDic;
    end
    local eventData = areaMap.areaEvents[eid];
    if (eventData == nil) then return false end

    local config = ConfigMgr.Config.areaEvents[eventData.id];
    if (config == nil) then return false end

    if (config.groupId == id) then
        return eventDic[eventData.id] == nil;
    end
    return false;
end


PlayerAreaMapMgr.ModifyAreaMapBuildingEvent = function(area, id, eid, status)
    local areaMap = DataMgr.Player.areaMaps[area];
    if (areaMap == nil) then return end

    local key = string.format("%s_%s", area, id);
    local eventDic = this.areaMapBuildingEventDic[key];
    if (eventDic == nil) then
        eventDic = {};
        this.areaMapBuildingEventDic[key] = eventDic;
    end
    local eventData = areaMap.areaEvents[eid];
    if (eventData == nil) then return end

    local config = ConfigMgr.Config.areaEvents[eventData.id];
    if (config == nil) then return end

    if (config.groupId == id) then
        local temp = eventDic[eventData.id];
        if (temp == nil or temp ~= 0) then
            eventDic[eventData.id] = status;
        end
    end
end


PlayerAreaMapMgr.ModifyAreaMapBuildingEvents = function(area, id)
    local areaMap = DataMgr.Player.areaMaps[area];
    if (areaMap ~= nil) then
        local config;
        local areaEventMap = ConfigMgr.Config.areaEvents;
        for k, _ in pairs(areaMap.areaEvents) do
            config = areaEventMap[k];
            if (config ~= nil and config.groupId == id) then
                PlayerAreaMapMgr.ModifyAreaMapBuildingEvent(area, id, k, 1);
            end
        end
    end
end

PlayerAreaMapMgr.RemoveAreaEvent = function(area, id)
    local areaMap = DataMgr.Player.areaMaps[area];
    if (areaMap == nil) then
        return;
    end
    areaMap.areaEvents[id] = nil;
end


PlayerAreaMapMgr.RemoveCurrentExplore = function(area, id)
    local areaExplore = DataMgr.Player.areaExplores[area];
    if (areaExplore ~= nil) then
        areaExplore.currentExplores[id] = nil;
    end
end

PlayerAreaMapMgr.GetAreaEvent = function(area, type)
    local map = DataMgr.Player.areaMaps[area];
    if (map == nil) then return nil end

    for _, v in pairs(map.areaEvents) do
        if (v.type == type) then
            return v;
        end
    end
    return nil;
end

PlayerAreaMapMgr.GetAreaEvent = function(area, groupId, type)
    local map = DataMgr.Player.areaMaps[area];
    if (map == nil) then return nil end

    local config;
    local areaEventMap = ConfigMgr.Config.areaEvents;
    for _, v in pairs(map.areaEvents) do
        config = areaEventMap[v.id];
        if (config ~= nil) then
            if (config.groupId == groupId and v.type == type) then
                return v;
            end
        end
        return nil;
    end
end

PlayerAreaMapMgr.GetAreaEvent = function(area, id)
    local map = DataMgr.Player.areaMaps[area];
    if (map == nil) then return nil end

    return map.areaEvents[id];
end

PlayerAreaMapMgr.CheckDungeonRecords = function(dungeonId)
    local record= DataMgr.Player.dungeonRecords[dungeonId];
    return record~=nil and record.completeCount>0;
end

PlayerAreaMapMgr.CheckMapBuildingUnlock=function(area,mapGroupData)
    if mapGroupData.lock then return end;
    local mapGroup = ConfigAreaMapMgr.GetAreaMapGroup(area,mapGroupData.id);
    local cfgAreaEvents=ConfigMgr.Config.areaEvents;
    local curEvent=cfgAreaEvents[mapGroup.unlockParam];
    if curEvent==nil or IsNullOrEmpty(curEvent.unlockParam) then
        return
    end;
    mapGroupData.lock=not PlayerAreaMgr.CheckEventIsUnlock(curEvent.id);











end

PlayerAreaMapMgr.CheckBuildUnLock=function(area,buildingId)
    local mapGroup = ConfigAreaMapMgr.GetAreaMapGroup(area,buildingId);
    local cfgEvent=ConfigMgr.Config.areaEvents[mapGroup.unlockParam];
    if cfgEvent==nil or IsNullOrEmpty(cfgEvent.unlockParam) then
        return true
    end;
    if cfgEvent.type~=1 then
        return true
    end
    return PlayerAreaMapMgr.CheckDungeonRecords(cfgEvent.unlockParam);
end