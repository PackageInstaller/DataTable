PlayerAreaMgr_NovelModel = {
completedAreaEvents={},
areaState={};
areaMapBuildingStatus={}
}


PlayerAreaMgr_NovelModel.UpdateAreasData=function()
    PlayerAreaMgr_NovelModel.InitAreaMapEventState();
    PlayerAreaMgr_NovelModel.InitAreaMapBuildingStatus();
    PlayerAreaMgr_NovelModel.InitAreaState();
end



PlayerAreaMgr_NovelModel.InitAreaState=function()
    PlayerAreaMgr_NovelModel.areaState={}
    for key,v in pairs(ConfigMgr.Config.areas) do
        if v.unlockType==0 then
            PlayerAreaMgr_NovelModel.areaState[key]={lock=false,complete=false};
        elseif v.unlockType==1 then
            local state=PlayerAreaMgr_NovelModel.completedAreaEvents[v.unlockParam];
            if state==nil then
                LuaDebug.error("config is error");
                PlayerAreaMgr_NovelModel.areaState[key]={lock=true,complete=false};
            else
                PlayerAreaMgr_NovelModel.areaState[key]={lock=not state,complete=false};
            end
        end
    end
end



PlayerAreaMgr_NovelModel.InitAreaMapBuildingStatus=function()
    PlayerAreaMgr_NovelModel.areaMapBuildingStatus={};
    for k,v in pairs(ConfigMgr.Config.areas) do
        local areaGroups=ConfigMgr.Config.areaMapGroup[k];
        if areaGroups~=nil then
            for _,item in ipairs(areaGroups) do
                if item.unlockType==0 then
                    PlayerAreaMgr_NovelModel.areaMapBuildingStatus[string.format("%s_%s", k, item.id)] =true;
                elseif item.unlockType==1 then
                    PlayerAreaMgr_NovelModel.areaMapBuildingStatus[string.format("%s_%s", k, item.id)] = PlayerAreaMgr_NovelModel.completedAreaEvents[item.unlockParam];
                end
            end
        end
    end
end

PlayerAreaMgr_NovelModel.CheckAreaBuildingEventsIsComplete=function(area,buildingId)
    local areaBuilding=string.format("%s_%s", area, buildingId)
    if not PlayerAreaMgr_NovelModel.areaMapBuildingStatus[areaBuilding] then
        return false;
    end
    for _,event in pairs(ConfigMgr.Config.areaEvents) do
        if area==event.area and buildingId==event.groupId then
            if not PlayerAreaMgr_NovelModel.completedAreaEvents[event.id] then
                return false;
            end
        end
    end
    return true;
end


PlayerAreaMgr_NovelModel.CheckAreaAllBuildingsEventsComplete=function(area)
    if PlayerAreaMgr_NovelModel.areaState[area].lock then
        return false;
    end
    local mapGroups=ConfigMgr.Config.areaMapGroup[area];
    if mapGroups==nil then
        return false;
    end
    for i,v in ipairs(mapGroups) do
        if not PlayerAreaMgr_NovelModel.CheckAreaBuildingEventsIsComplete(area,v.id) then
            return false;
        end
    end
    return true;
end


PlayerAreaMgr_NovelModel.InitAreaMapEventState=function()
    PlayerAreaMgr_NovelModel.completedAreaEvents={};
    local areaEventMap = ConfigMgr.Config.areaEvents;

    for i,v in pairs(areaEventMap) do
        if v.type==1 then
            local state=DataHelper.CheckNovelComplete(v.eventParam);
            if state then

                if areaEventMap[v.unlockParam]~=nil and areaEventMap[v.unlockParam].type==2 then
                    state=DataHelper.CheckDungeonComplete_NovelModel(areaEventMap[v.unlockParam].eventParam);
                end
            end
            PlayerAreaMgr_NovelModel.completedAreaEvents[v.id]=state;
        elseif v.type==2 then
            local state=DataHelper.CheckDungeonComplete_NovelModel(v.eventParam);
            PlayerAreaMgr_NovelModel.completedAreaEvents[v.id]=state;
        end
    end
end


PlayerAreaMgr_NovelModel.CheckDungeonRecords=function(dungeonId)
    if IsNull(DataMgr.Player.storyModeDungeonRecords) then
        return false
    end;
    return DataMgr.Player.storyModeDungeonRecords[dungeonId]~=nil;
end

PlayerAreaMgr_NovelModel.GetBuildingUnlockEvents=function(area,buildingId)
    local list={}
    for i,value in pairs(ConfigMgr.Config.areaEvents) do
        if value.area==area and value.groupId==buildingId then
            if value.unlockType==0 or PlayerAreaMgr_NovelModel.completedAreaEvents[value.unlockParam] then
                table.insert(list,value);
            end
        end
    end
    return list;
end


PlayerAreaMgr_NovelModel.AreaBuildingUnlocking=function(area,building)
    return PlayerAreaMgr_NovelModel.areaMapBuildingStatus[string.format("%s_%s", area, building)];
end


PlayerAreaMgr_NovelModel.CurrentFlagArea = function()
    local areas = ConfigMgr.Config.areas;
    local areaMaps = {};
    for _, v in pairs(areas) do
        if v.world=="zhengzhuan" then
            table.insert(areaMaps, v)
        end
    end
    table.sort(areaMaps, function(a, b)
        return a.sortNum<b.sortNum;
    end);
    local dataAreaMaps = PlayerAreaMgr_NovelModel.areaState;
    local unlockMaxIndex = 0;
    local len = #areaMaps;
    for i = 1, len do
        local area = areaMaps[i].area;
        if (dataAreaMaps[area].lock) then
            break;
        end
        unlockMaxIndex = unlockMaxIndex + 1;
    end
    return areaMaps[unlockMaxIndex].area;
end

PlayerAreaMgr_NovelModel.CheckAreaBuildingIsFlag=function(area,buildingId)
    if PlayerAreaMgr_NovelModel.CurrentFlagArea()~=area then
        return false;
    end
   local areaBuilding=string.format("%s_%s", area, buildingId)
    if PlayerAreaMgr_NovelModel.areaMapBuildingStatus[areaBuilding] and not PlayerAreaMgr_NovelModel.CheckAreaBuildingEventsIsComplete(area,buildingId) then
        return true;
    else
        return false;
    end
    
end