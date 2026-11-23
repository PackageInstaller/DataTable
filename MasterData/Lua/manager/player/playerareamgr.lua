
PlayerAreaMgr = {
   
}
AreaModel={
    Normal=0,
    Novel=1,
}
local areaModel=AreaModel.Normal;
local curDungeonId=nil;


function PlayerAreaMgr.GetChallengeCompleteCountByArea(area, areaEventCategory)
    local areaMap = DataMgr.Player.areaMaps[area]
    local areaEventsCfg = ConfigMgr.Config.areaEvents
    if areaMap == nil then
        return 0
    end

    local count = 0
    for key, item in pairs(areaMap.areaEvents or {}) do
        if areaEventsCfg[item.id] ~= nil and areaEventsCfg[item.id].category == areaEventCategory then
            count = count + PlayerAreaMgr.GetChallengeCompleteCountById(item.eventParam)
        end
    end
    return count
end


function PlayerAreaMgr.GetChallengeCompleteCountById(id)
    local list = ConfigMgr.Config.levelChallenges[id]
    if list == nil then
        return 0
    end

    local count = 0
    for i, item in ipairs(list) do
        if DataMgr.Player.completedTags[item] then
            count = count + 1
        end
    end
    return count
end


function PlayerAreaMgr.GetAreaEvent(area, id)
    local map = DataMgr.Player.areaMaps[area]
    if map == nil then
        return nil;
    end
    local event=map.areaEvents[id];
    if event==nil then
        return nil;
    end
    if PlayerAreaMgr.CheckEventIsUnlock(event.id) then
        local curEvent=ConfigMgr.Config.areaEvents[event.id];
        if  curEvent.type<3 and not IsNullOrEmpty(curEvent.groupId) and PlayerAreaMgr.CheckBuildingIsLockByTime(area,curEvent.groupId) then
            return nil;
        end
        return event;
    end
    return nil;
end


function PlayerAreaMgr.CheckBuildingIsLockByTime(area,groupId)
    local mapGroups=ConfigMgr.Config.areaMapGroup[area];
    if mapGroups==nil then return true end;
    for i,v in ipairs(mapGroups) do
        if v.id==groupId then
            if v.unlockmap>0 then
                return LuaMgr.Timestamp()<v.unlockmap;
            else
                return false;
            end
        end
    end
    return true;
end


function PlayerAreaMgr.GetAreaEventByType(area, eventType)
    local map = DataMgr.Player.areaMaps[area]
    if map == nil then
        return
    end
    for key, item in pairs(map.areaEvents) do
        if item.type == eventType then
            return item
        end
    end
    return nil
end

function PlayerAreaMgr.SetDefaultModel()
    areaModel=AreaModel.Normal;
end

function PlayerAreaMgr.SetAreaModel(type)
    areaModel=type;
end 


function PlayerAreaMgr.GetAreaModel()
    return areaModel;
end

function PlayerAreaMgr.SetAreaDungeonId(dungeonId)
    curDungeonId=dungeonId;
end


function PlayerAreaMgr.IsAreaModelNovel()
    if not IsNullOrEmpty(curDungeonId) then
        local dungeon=ConfigMgr.Config.dungeonMap[curDungeonId]
        if dungeon==nil or IsNull(dungeon.easyBuff) or #dungeon.easyBuff==0 then
            return false;
        end
    end
    return areaModel==AreaModel.Novel;
end 

function PlayerAreaMgr.CheckAreaUnlock(area)
    if DataMgr.Player.areaMaps[area]==nil or DataMgr.Player.areaMaps[area].lock then
        return false;
    end
    local areaMap = ConfigMgr.Config.areas[area];
    if not IsNullOrEmpty(areaMap.unlockParam) and  ConfigMgr.Config.areaEvents[areaMap.unlockParam].type==1 then
        return PlayerAreaMgr.CheckEventIsUnlock(areaMap.unlockParam);
    end
    return true;
end 


function PlayerAreaMgr.CheckEventIsUnlock(eventId)
    if eventId==nil then return false end;
    local cfgAreaEvents=ConfigMgr.Config.areaEvents;

    local curEvent=cfgAreaEvents[eventId];
    if IsNullOrEmpty(curEvent.unlockParam) then
        return true;
    end
    local curEventUnlock=DataMgr.Player.completedAreaEvents[curEvent.unlockParam]~=nil;
    if not curEventUnlock then
        return false 
    end;
    if curEvent.type==1 then
        return curEventUnlock ;
    else
        local preEvent=cfgAreaEvents[curEvent.unlockParam];
        if IsNullOrEmpty(preEvent.unlockParam) then
            return true;
        end
        return DataMgr.Player.completedAreaEvents[preEvent.unlockParam];







    end
end