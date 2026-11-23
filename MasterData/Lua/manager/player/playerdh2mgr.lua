require("DH2/DH2Const")
PlayerDH2Mgr = {}

local this = {
isInit = false,
levelType = 0,

};

PlayerDH2Mgr.Init = function()
    if (this.isInit) then return end
    this.isInit = true; 
end

PlayerDH2Mgr.Clear = function()   
    this.isInit = false;
end


PlayerDH2Mgr.SetLevelType = function(levelType)
    this.levelType = levelType;
end


PlayerDH2Mgr.GetLevelType = function()
    if (this.levelType == 0 or this.levelType == nil) then
        for i = 1, 3 do
            local type = "JJ0" .. i;
            local eventList = DataExHelper.EX_GetEventListByArea(type);
            for j, v in ipairs(eventList) do
                local eventData = PlayerDH2Mgr.GetActivityMapEvent(type, v.id);
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


PlayerDH2Mgr.GetActivityMapEvent = function(type, id)
    local data = DataMgr.Player.activityMaps[type];
    if (data ~= nil) then
        return data.activityEvents[id];
    end
    return nil;
end




PlayerDH2Mgr.CheckEntranceRedDot = function()
    local bStory = PlayerDH2Mgr.CheckStoryEntranceRedDot()
    local bStage = PlayerDH2Mgr.CheckStageEntranceRedDot()

    if (bStory or bStage) then
        return 1
    else
        return 0
    end
end


PlayerDH2Mgr.CheckStoryEntranceRedDot = function()
    local storyRed = false
    for k, v in ipairs(ConfigMgr.Config.activityMapEventList) do
        if (v.area == "JJ04") then
            storyRed = PlayerDH2Mgr.CheckStoryRedDot("JJ04", v.id)
            if (storyRed) then
                break
            end
        end
    end
    if (storyRed) then
        RedMgr.Singleton:UpdateClientRedData("16131", 1)
    else
        RedMgr.Singleton:UpdateClientRedData("16131", 0)
    end
    return storyRed
end

PlayerDH2Mgr.CheckStoryRedDot = function(_area, _id)
    local eventData = nil
    local cacheData = DataMgr.Player.activityMaps[_area];
    if (cacheData ~= nil) then
        eventData = cacheData.activityEvents[_id];
    end
    if (eventData ~= nil) then   
        if (eventData.complete) then
            return false
        end
        return true
    end
    return false
end

PlayerDH2Mgr.CheckStageEntranceRedDot = function()
    local bRed = false
    if (RedMgr.Singleton:CheckRedCondition("16132")) then        
        for k, v in ipairs(ConfigMgr.Config.activityMapEventList) do
            for i = 1, 3 do
                if (v.area == "JJ0" .. i) then
                    bRed = PlayerDH2Mgr.CheckStoryRedDot("JJ0" .. i, v.id)
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
        RedMgr.Singleton:UpdateClientRedData("16132", 1)
    else
        RedMgr.Singleton:UpdateClientRedData("16132", 0)
    end
    return bRed
end


