FoundationGrids = {};

FoundationGrids.__index = FoundationGrids;

FoundationGrids.New = function(container)
    local self = {};
    setmetatable(self, FoundationGrids);
    self.container = container;
    self.containerGO = container.gameObject;
    self.gridDic = {};
    self.disableDic = {};
    return self;
end

function FoundationGrids:Generate(areaX, areaY, type, ext)
    local grid;
    local key;
    local gridSize = FoundationMgr.GetGridSize();
    local material = FoundationMgr.GetMaterial(0);
    areaY = areaY - 1;
    local startX = 0;
    if (ext == nil) then
        self.disableDic = {};
        areaX = areaX - 1;
    else
        areaX = ext.areaX + areaX - 1;
        startX = ext.areaX;
    end
    for i = 0, areaY do
        for j = startX, areaX do
            key = string.format("%d_%d", j, i);
            grid = self.gridDic[key];
            if (grid == nil) then
                grid = FoundationGrid.New(self.container, gridSize);
                self.gridDic[key] = grid;
            end
            grid:SetData(key, j, i, type, ext);
            grid:SetMaterial(material);
        end
    end
end

function FoundationGrids:Show()
    self.containerGO:SetActive(true);
end

function FoundationGrids:Hide()
    self.containerGO:SetActive(false);
end

function FoundationGrids:Get(x, y)
    local key = string.format("%d_%d", x, y);
    return self.gridDic[key];
end

function FoundationGrids:SetGridType(key, type)
    if (self.gridDic ~= nil) then
        local material = FoundationMgr.GetMaterial(type);
        local grid = self.gridDic[key];
        if (grid ~= nil) then
            grid:SetMaterial(material);
        end
    end
end

function FoundationGrids:SetAllGridType(type)
    if (self.gridDic ~= nil) then
        local material = FoundationMgr.GetMaterial(type);
        for k, v in pairs(self.gridDic) do
            if (not self.disableDic[k]) then
                v:SetMaterial(material);
            end
        end
    end
end

function FoundationGrids:SetDisableGrid(key)
    self.disableDic[key] = true;
end

function FoundationGrids:IsDisableGrid(key)
    return self.disableDic[key];
end

function FoundationGrids:Reset()
    if (self.gridDic ~= nil) then
        for _, v in pairs(self.gridDic) do
            v:SetActive(false);
        end
    end
end

function FoundationGrids:Clear()
    self.container = nil;
    self.containerGO = nil;
    if (self.gridDic ~= nil) then
        for _, v in pairs(self.gridDic) do
            v:Clear();
        end
        self.gridDic = nil;
    end
    self.disableDic = nil;
end