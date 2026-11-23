ConfigAreaMgr = {}

local areaMapSurveyEventDic
local areaMapEventDic
local areaMapExploreDic
local areaMapBranchEventDic

function ConfigAreaMgr.InitAreaMapSurveyEvent()
    areaMapSurveyEventDic = {}
    for i, item in pairs(ConfigMgr.Config.areaExplores) do
        local key = item.tab
        if not areaMapSurveyEventDic[key] then
            areaMapSurveyEventDic[key] = {}
        end
        table.insert(areaMapSurveyEventDic[key], item)
    end
end

function ConfigAreaMgr.GetAreaMapSurveyEvent(key)
    return areaMapSurveyEventDic[key]
end


function ConfigAreaMgr.GetChallengeCountById(id)
    local list = ConfigMgr.Config.levelChallenges[id]
    local count = list~=nil and #list or 0
    return count
end


function ConfigAreaMgr.GetChallengeCountByArea(area, areaEventCategory)
    local areaEventList = ConfigAreaMgr.GetAreaMapEvents(area)
    local count = 0
    for key, item in pairs(areaEventList) do
        if item.category == areaEventCategory then
            count = count + ConfigAreaMgr.GetChallengeCountById(item.eventParam)
        end
    end
    return count
end


function ConfigAreaMgr.GetAreaMapEvents(area)
    if areaMapEventDic == nil then
        areaMapEventDic = {}
        for key, item in pairs(ConfigMgr.Config.areaEvents) do
            if areaMapEventDic[item.area] == nil then
                areaMapEventDic[item.area] = {}
            end
            local category = item.category
            if category == AreaEventCategory.Main or category == AreaEventCategory.Resource then
                table.insert(areaMapEventDic[item.area], item)
            end
        end

        for k, v in pairs(areaMapEventDic) do
            table.sort(areaMapEventDic[k], function(a, b) return a.sort < b.sort end)
        end
    end
    return areaMapEventDic[area]
end


function ConfigAreaMgr.GetBranchEvents(area)
    if areaMapBranchEventDic == nil then
        areaMapBranchEventDic = {}
        for key, item in ipairs(ConfigMgr.Config.branchEventList) do
            if areaMapBranchEventDic[item.mainLine] == nil then
                areaMapBranchEventDic[item.mainLine] = {}
            end
            table.insert(areaMapBranchEventDic[item.mainLine], item)
        end
    end
    return areaMapBranchEventDic[area]
end


function ConfigAreaMgr.GetAreaMapExplores(area)
    if areaMapExploreDic == nil then
        areaMapExploreDic = {}
        for key, item in pairs(ConfigMgr.Config.areaExplores) do
            if areaMapExploreDic[item.tab] == nil then
                areaMapExploreDic[item.tab] = {}
            end
            table.insert(areaMapExploreDic[item.tab], item)
        end
    end
    return areaMapExploreDic[area]
end


function ConfigAreaMgr.IsMainAreaEvent(id)
    local config = ConfigMgr.Config.areaEvents[id]
    if config ~= nil then
        return config.category == 0
    end
    return false
end



ConfigAreaMgr.GetDungeonName = function(id)
    local dungeon = ConfigMgr.Config.dungeonMap[id];
    if (dungeon ~= nil) then
        return LuaMgr.GetLangText(dungeon.NameLan);
    end
    return "";
end