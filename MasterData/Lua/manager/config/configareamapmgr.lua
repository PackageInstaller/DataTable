ConfigAreaMapMgr = {}

local this = {
    areaMapGroupDic = nil,
    areaMapEventDic = nil,
    areaMapExploreDic = nil,
};


ConfigAreaMapMgr.GetAreaMapGroup = function(area, id)
    if (this.areaMapGroupDic == nil) then
        this.areaMapGroupDic = {};
        local len;
        local item;
        local areaMapGroup = ConfigMgr.Config.areaMapGroup;
        for k, v in pairs(areaMapGroup) do
            len = #v;
            for i = 1, len do
                item = v[i];
                this.areaMapGroupDic[string.format("%s_%s", k, item.id)] = item;
            end
        end
    end
    return this.areaMapGroupDic[string.format("%s_%s", area, id)];
end


ConfigAreaMapMgr.GetAreaMapEvents = function(area)
    if (this.areaMapEventDic == nil) then
        this.areaMapEventDic = {};
        local list;
        local areaEventMap = ConfigMgr.Config.areaEvents;
        for _, v in pairs(areaEventMap) do
            list = this.areaMapEventDic[v.area];
            if (list == nil) then
                list = {};
                this.areaMapEventDic[v.area] = list;
            end
            if (v.category == AreaEventCategory.Main or v.category == AreaEventCategory.Resource) then
                table.insert(list, v);
            end
        end
    end
    return this.areaMapEventDic[area];
end


ConfigAreaMapMgr.GetAreaMapExplores = function(area)
    if (this.areaMapExploreDic == nil) then
        this.areaMapExploreDic = {};
        local list;
        local areaExplores = ConfigMgr.Config.areaExplores;
        for _, v in pairs(areaExplores) do
            list = this.areaMapExploreDic[v.tab];
            if (list == nil) then
                list = {};
                this.areaMapExploreDic[v.tab] = list;
            end
            table.insert(list, v);
        end
    end
    return this.areaMapExploreDic[area];
end 