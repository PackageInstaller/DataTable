FoundationOccupy = {};

FoundationOccupy.__index = FoundationOccupy;

FoundationOccupy.New = function()
    local self = {};
    setmetatable(self, FoundationOccupy);
    self.occupys = {};
    self.moveGrids = {};
    return self;
end


function FoundationOccupy:InitMoveGrids(areaX, areaY)
    local list;
    local obj;
    for i = 1, areaY do
        list = self.moveGrids[i];
        if (list == nil) then
            list = {};
            self.moveGrids[i] = list;
        end
        for j = 1, areaX do
            obj = list[j];
            if (obj == nil) then
                obj = {x = j - 1, y = i - 1, type = 0};
                list[j] = obj;
            else
                obj.type = 0;
            end
        end
    end
end


function FoundationOccupy:SetMoveGrid(key, x, y)
    local list = self.moveGrids[y + 1];
    if (list ~= nil) then
        local obj = list[x + 1];
        if (obj ~= nil) then
            local occupy = self.occupys[key];
            if (occupy ~= nil and #occupy > 0) then
                obj.type = 1;
            else
                obj.type = 0;
            end
        end
    end
end


function FoundationOccupy:BanMoveGrid(key, x, y)
    local list = self.moveGrids[y + 1];
    if (list ~= nil) then
        local obj = list[x + 1];
        if (obj ~= nil) then
            obj.type = 1;
        end
    end
end


function FoundationOccupy:AddOccupyId(key, id)
    local list = self.occupys[key];
    if (list == nil) then
        list = {};
        self.occupys[key] = list;
    end
    table.insert(list, id);
end


function FoundationOccupy:RemoveOccupyId(key, id)
    local list = self.occupys[key];
    if (list ~= nil) then
        local len = #list;
        for i = 1, len do
            if (list[i] == id) then
                table.remove(list, i);
                len = len - 1;
                break;
            end
        end
    end
end


function FoundationOccupy:IsLegal(key)
    local occupy = self.occupys[key];
    return occupy == nil or #occupy <= 1;
end

function FoundationOccupy:Clear()
    self.occupys = {};
    self.moveGrids = {};
end