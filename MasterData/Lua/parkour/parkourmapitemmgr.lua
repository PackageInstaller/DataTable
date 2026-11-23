ParkourMapItemMgr = {};

local this = {
    levelConfig = nil,
    itemMap = nil,
    container = nil,
    poolMap = nil,
    dataList = nil,
    showList = nil,
    resultData = nil,
};

ParkourMapItemMgr.Init = function(levelConfig, itemMap, container)
    this.levelConfig = levelConfig;
    this.itemMap = itemMap;
    this.container = container;
    this.poolMap = {};
    this.InitData();
end

ParkourMapItemMgr.Clear = function()
    this.levelConfig = nil;
    this.dataList = nil;
    if (this.showList ~= nil) then
        local len = #this.showList;
        for i = 1, len do
            this.AddPool(this.showList[i]);
        end
        this.showList = nil;
    end
end

ParkourMapItemMgr.Destroy = function()
    ParkourMapItemMgr.Clear();
    this.DestroyPool();
    this.itemMap = nil;
    this.container = nil;
end

ParkourMapItemMgr.Update = function(rectX, rectMinX, rectMaxX, showMinX)
    if (this.resultData == nil) then return end
    if (this.CheckResult(rectX)) then return end
    
    this.CheckData(rectX, rectMinX, rectMaxX);
    this.CheckShow(rectX, showMinX);
end


this.InitData = function()
    this.dataList = {};
    this.showList = {};
    local ox = 0;
    local parkourMaps = ConfigMgr.Config.DHParkourMaps;
    for _, v in pairs(this.levelConfig.LevelGroup) do
        local list = {};
        local parkourMap = parkourMaps[v];
        local items = parkourMap.ItemMap;
        local len = #items;
        for i = 1, len do
            local item = items[i];
            local obj = {id=item[1], x=tonumber(item[2]) + ox, y=tonumber(item[3])};
            if (item[1] == ParkourMapItem.Result) then
                this.resultData = obj;
            else
                table.insert(list, obj);
            end
        end
        table.sort(list, this.DataSort);
        local index = #this.dataList;
        len = #list;
        for i = 1, len do
            this.dataList[index + i] = list[i];
        end
        ox = ox + parkourMap.MapLength;
    end
end


this.DataSort = function(a, b)
    return a.x < b.x;
end


this.CheckResult = function(rectX)
    local realX = this.resultData.x - rectX;
    if (realX <= 0) then
        ParkourMapItemMgr.Clear();
        ParkourMap.Stop();
        LuaMgr.ShowLuaPanel(UIName.ParkourTipsViewModel, 2);
        this.resultData = nil;
        return true;
    end
    return false;
end


this.CheckData = function(rectX, rectMinX, rectMaxX)
    local data;
    local item;
    local realX;
    local index = 1;
    local count = 0;
    local len = #this.dataList;
    while (index <= len) do
        data = this.dataList[index];
        realX = data.x - rectX;
        if (data.x > rectMinX and data.x < rectMaxX) then
            table.remove(this.dataList, index);
            len = len - 1;
            item = this.GetPool(data.id);
            if (item ~= nil) then
                item:SetData(data, realX, data.y);
                table.insert(this.showList, item);
            end
        else
            index = index + 1;
            count = count + 1;
            if (count >= 100) then
                break;
            end
        end
    end
end


this.CheckShow = function(rectX, minX)
    local item;
    local realX;
    local characterTF = ParkourCharacter.GetCharacterTF();
    local isMagnet = ParkourCharacter.IsMagnet();
    local index = 1;
    local len = #this.showList;
    while (index <= len) do
        item = this.showList[index];
        if (item.isLive) then
            if (item.isFadeOut) then
                item:OnFadeOut();
                index = index + 1;
            else
                if (not item.isMove) then
                    item:Move(characterTF, isMagnet or item:IsBox());
                end
                if (item.isMove) then
                    item:OnMove();
                    index = index + 1;
                else
                    realX = item.data.x - rectX;
                    item:SetPosX(realX);
                    if (realX < minX) then
                        table.remove(this.showList, index);
                        len = len - 1;
                        this.AddPool(item);
                    else
                        index = index + 1;
                    end
                end
            end
        else
            table.remove(this.showList, index);
            len = len - 1;
            this.AddPool(item);
        end
    end
end


this.AddPool = function(item)
    if (item.data ~= nil) then
        local list = this.poolMap[item.data.id];
        if (list == nil) then
            list = {};
            this.poolMap[item.data.id] = list;
        end
        table.insert(list, item);
        item:Clear();
    end
end


this.GetPool = function(id)
    local list = this.poolMap[id];
    if (list ~= nil) then
        local len = #list;
        if (len > 0) then
            local item = list[len];
            list[len] = nil;
            return item;
        end
    end
    local obj = this.itemMap[id];
    if (obj ~= nil) then
        return ParkourMapItemItem.New(obj, this.container);
    end
    return nil;
end


this.DestroyPool = function()
    if (this.poolMap ~= nil) then
        for _, v in pairs(this.poolMap) do
            local len = #v;
            for i = 1, len do
                v[i]:Destroy();
            end
        end
        this.poolMap = nil;
    end
end