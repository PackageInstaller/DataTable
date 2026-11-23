FoundationRoomSeat = {}

local this = nil;
local triggerMap = nil;
local seatMap = nil;
local bit16 = 65536;

local P2V = function(x, y)
    return x * bit16 + y;
end

FoundationRoomSeat.Init = function()
    this = FoundationRoom.GetThis();
    triggerMap = {};
    seatMap = {};
end

FoundationRoomSeat.Clear = function()
    this = nil;
    triggerMap = nil;
    seatMap = nil;
end

FoundationRoomSeat.Add = function(building)
    local config = FoundationMgr.GetBuildingConfig(building.bid);
    if (config == nil or config.seats == nil) then return end
    
    local seat;
    local grid;
    local key;
    local seatData;
    local seatDatas = {};
    local len = #config.seats;
    for i = 1, len do
        seat = config.seats[i];
        if (seat.angle == building.angle) then
            seatData = {config = seat, keys = {}, bx = building.x, by = building.y, character = nil};
            table.insert(seatDatas, seatData);
            len = #seat.grids;
            for j = 1, len do
                grid = seat.grids[j];
                key = P2V(grid.x + building.x, grid.y + building.y);
                triggerMap[key] = building.id;
                seatData.keys[j] = key;
            end
        end
    end
    if (#seatDatas > 0) then
        seatMap[building.id] = seatDatas;
    end
end

FoundationRoomSeat.Remove = function(building)
    local seatDatas = seatMap[building.id];
    if (seatDatas == nil) then return end
    
    local seatData;
    local kLen;
    local len = #seatDatas;
    for i = 1, len do
        seatData = seatDatas[i];
        kLen = #seatData.keys;
        for j = 1, kLen do
            triggerMap[seatData.keys[j]] = nil;
        end
    end
    seatMap[building.id] = nil;
end

FoundationRoomSeat.IsTrigger = function(character, x, y)
    local key = P2V(x, y);
    local buildingId = triggerMap[key];
    if (buildingId == nil) then return nil end
    
    local seatData;
    local kLen;
    local seatDatas = seatMap[buildingId];
    local len = #seatDatas;
    for i = 1, len do
        seatData = seatDatas[i];
        if (seatData.character == nil) then
            kLen = #seatData.keys;
            for j = 1, kLen do
                if (seatData.keys[j] == key) then
                    seatData.character = character;
                    return seatData;
                end
            end
        end
    end
    return nil;
end

FoundationRoomSeat.SitEnd = function(character, x, y)
    local key = P2V(x, y);
    local buildingId = triggerMap[key];
    if (buildingId == nil) then return end

    local seatData;
    local seatDatas = seatMap[buildingId];
    local len = #seatDatas;
    for i = 1, len do
        seatData = seatDatas[i];
        if (seatData.character == character) then
            seatData.character = nil;
            break;
        end
    end
end