ConfigQinMgr = {}

local this = {
    activityMapEvent = nil,
    mainActivityMapEvent = nil,
    redColor = UnityEngine.Color(173/255,36/255,30/255,1),
    greenColor = UnityEngine.Color(0/255,141/255,122/255,1),
    yellowColor = UnityEngine.Color(195/255,144/255,55/255,1),
};

ConfigQinMgr.Init = function()

end

ConfigQinMgr.Clear = function()
    this.activityMapEvent = nil;
    this.mainActivityMapEvent = nil;
end


ConfigQinMgr.InitActivityMapEvent = function(eventList)
    this.activityMapEvent = {};
    local event;
    local len = #eventList;
    for i = 1, len do
        event = eventList[i];
        this.activityMapEvent[event.id] = event;
    end
end


ConfigQinMgr.GetActivityMapEvent = function(id)
    return this.activityMapEvent[id];
end


ConfigQinMgr.GetLevelConfig = function(id)
    local qinLevelMap = ConfigMgr.Config.QinLevelMap;
    for _, v in pairs(qinLevelMap) do
        if (v.MonsterLevel == id) then
            return v;
        end
    end
    return nil;
end


ConfigQinMgr.GetGridType = function(type)
    local qinGridTypeMap = ConfigMgr.Config.QinGridTypeMap;
    for _, v in pairs(qinGridTypeMap) do
        if (v.GridType == type) then
            return v;
        end
    end
    return nil;
end


ConfigQinMgr.InitMainActivityMapEvent = function(eventList)
    this.mainActivityMapEvent = eventList;
end


ConfigQinMgr.GetMainActivityMapEvent = function(id)
    local activityMapEvent;
    local len = #this.mainActivityMapEvent;
    for i = 1, len do
        activityMapEvent = this.mainActivityMapEvent[i];
        if (activityMapEvent.id == id) then
            return activityMapEvent;
        end
    end
    return nil;
end


ConfigQinMgr.GetMainActivityMapEvents = function(classId)
    local activityMapEvent;
    local events = {};
    local len = #this.mainActivityMapEvent;
    for i = 1, len do
        activityMapEvent = this.mainActivityMapEvent[i];
        if (activityMapEvent.classId == classId) then
            table.insert(events, activityMapEvent);
        end
    end
    if (#events == 2) then
        local event1 = events[1];
        local event2 = events[2];
        if (event1.id ~= event2.unlockParam) then
            events[1] = event2;
            events[2] = event1;
        end
    end
    return events;
end


ConfigQinMgr.GetHpColor = function(hpPercent)
    if (hpPercent < 0.2) then
        return this.redColor;
    elseif (hpPercent < 0.5) then
        return this.yellowColor;
    end
    return this.greenColor;
end


ConfigQinMgr.GetBuff = function(id)
    local qinBuff = ConfigMgr.Config.QinBuffMap[id];
    if (qinBuff ~= nil) then
        return ConfigMgr.Config.buffMap[qinBuff.BuffId];
    end
    return nil;
end