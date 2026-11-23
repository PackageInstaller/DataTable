ParkourMapObstacleMgr = {};

local this = {
    levelConfig = nil,
    obstacleMap = nil,
    container = nil,
    poolMap = nil,
    dataList = nil,
    showList = nil,
};

ParkourMapObstacleMgr.Init = function(levelConfig, obstacleMap, container)
    this.levelConfig = levelConfig;
    this.obstacleMap = obstacleMap;
    this.container = container;
    this.poolMap = {};
    this.InitData();
end

ParkourMapObstacleMgr.Clear = function()
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

ParkourMapObstacleMgr.Destroy = function()
    ParkourMapObstacleMgr.Clear();
    this.DestroyPool();
    this.obstacleMap = nil;
    this.container = nil;
end

ParkourMapObstacleMgr.Update = function(rectX, rectMinX, rectMaxX, showMinX)
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
        local obstacles = parkourMap.ObstacleMap;
        local len = #obstacles;
        for i = 1, len do
            local obstacle = obstacles[i];
            table.insert(list, {id=obstacle[1], x=tonumber(obstacle[2]) + ox, y=tonumber(obstacle[3])});
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


this.CheckData = function(rectX, rectMinX, rectMaxX)
    local data;
    local item;
    local realX;
    local index = 1;
    local count = 0;
    local resistType = this.levelConfig.ResistType;
    local len = #this.dataList;
    while (index <= len) do
        data = this.dataList[index];
        realX = data.x - rectX;
        if (data.x > rectMinX and data.x < rectMaxX) then
            table.remove(this.dataList, index);
            len = len - 1;
            item = this.GetPool(data.id);
            if (item ~= nil) then
                item:SetData(data, resistType, realX, data.y);
                table.insert(this.showList, item);
            end
        else
            index = index + 1;
            count = count + 1;
            if (count >= 60) then
                break;
            end
        end
    end
end


this.CheckShow = function(rectX, minX)
    local item;
    local realX;
    local index = 1;
    local len = #this.showList;
    while (index <= len) do
        item = this.showList[index];
        if (item.isLive) then
            realX = item.data.x - rectX;
            item:SetPosX(realX);
            if (realX < minX) then
                table.remove(this.showList, index);
                len = len - 1;
                this.AddPool(item);
            else
                index = index + 1;
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
    local obj = this.obstacleMap[id];
    if (obj ~= nil) then
        return ParkourMapObstacleItem.New(obj, this.container);
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