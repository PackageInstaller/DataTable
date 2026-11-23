FoundationEditor = {};

local this = {
    gameObject = nil,
    transform = nil,
    camera = nil,
    container = nil,
    gridsTF = nil,
    grids = nil,
    building = nil,
    buildingConfigMap = nil,
    gridOccupy = nil,
    gridMove = nil,
    gridSeat = nil,
    gridType = 0,
    buildingConfig = nil,
    renderers = nil,
};

FoundationEditor.Init = function()
    this.gameObject = GameObject.Find(FoundationMgr.Editor);
    this.transform = this.gameObject.transform;
    this.container = this.transform:Find("Container");
    this.gridsTF = this.transform:Find("Container/Grids");
    this.camera = this.transform:Find("Camera/Main Camera"):GetComponent("Camera");
end

FoundationEditor.Show = function()
    this.transform.localPosition = Vector3.zero;
    this.gameObject:SetActive(true);
    this.ReadConfig();
    FoundationEditor.InitGrids("101");
    LuaMgr.ShowLuaPanel(UIName.FoundationEditorViewModel);
    LuaMgr.AddUpdate(this.OnUpdate);
end

FoundationEditor.Hide = function()
    FoundationEditor.Clear();
    this.gameObject:SetActive(false);
end

FoundationEditor.Clear = function()
    LuaMgr.RemoveUpdate(this.OnUpdate);
    this.ClearBuilding();
    this.buildingConfig = nil;
    this.gridOccupy = nil;
    this.gridMove = nil;
    this.gridSeat = nil;
    this.buildingConfigMap = nil;
end

FoundationEditor.Destroy = function()
    if (this.grids ~= nil) then
        this.grids:Clear();
        this.grids = nil;
    end
    this.gameObject = nil;
    this.transform = nil;
    this.container = nil;
end

FoundationEditor.GetThis = function()
    return this;
end


FoundationEditor.SetBuilding = function(id, scale)
    this.buildingConfig = this.buildingConfigMap[id];
    if (this.buildingConfig == nil) then
        this.buildingConfig = {id = id, x = 6, y = 5, grids = {}, moves = {}, seats = {}};
        this.buildingConfigMap[id] = this.buildingConfig;
    end
    this.ClearBuilding();
    this.building = FoundationBuilding.New(id, this.container);
    this.building.transform.localScale = Vector3(scale, scale, scale);
    this.MoveBuilding(this.buildingConfig.x, this.buildingConfig.y);
end


FoundationEditor.SetAngle = function(angle)
    local grid, grid2;
    local gridX, gridY;
    local key;
    this.grids:SetAllGridType(0);
    this.building:SetAngle(angle);
    local len = #this.buildingConfig.grids;
    for i = 1, len do
        grid = this.buildingConfig.grids[i];
        if (angle > 0) then
            grid2 = FoundationTool.RectRotation(grid.x, grid.y, angle);
            gridX = this.building.x + math.floor(grid2.x + 0.5);
            gridY = this.building.y + math.floor(grid2.z + 0.5);
        else
            gridX = this.building.x + grid.x;
            gridY = this.building.y + grid.y;
        end
        key = string.format("%d_%d", gridX, gridY);
        this.grids:SetGridType(key, grid.type);
    end
    
end


FoundationEditor.SetGridType = function(type)
    this.gridType = type;
end


this.MoveBuilding = function(x, y)
    FoundationEditor.ClearGrids();
    this.buildingConfig.x = x;
    this.buildingConfig.y = y;
    this.building:SetPosition(x, y);
    local len = #this.buildingConfig.grids;
    for i = 1, len do
        local grid = this.buildingConfig.grids[i];
        local key = string.format("%d_%d", x + grid.x, y + grid.y);
        this.gridOccupy[key] = grid.type;
        this.grids:SetGridType(key, grid.type);
    end
    len = #this.buildingConfig.moves;
    for i = 1, len do
        local move = this.buildingConfig.moves[i];
        local key = string.format("%d_%d", x + move.x, y + move.y);
        this.gridMove[key] = move.type;
        this.grids:SetGridType(key, move.type);
    end
    LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationEditorMoveBuilding, x, y);
end


this.ClearBuilding = function()
    if (this.building ~= nil) then
        this.building:Clear();
        this.building = nil;
    end
end


FoundationEditor.ClearGrids = function()
    this.gridOccupy = {};
    this.gridMove = {};
    this.gridSeat = {};
    this.grids:SetAllGridType(0);
end


FoundationEditor.SetSeatGrids = function(grids)
    if (this.gridMove ~= nil) then
        for k, _ in pairs(this.gridMove) do
            this.grids:SetGridType(k, 0);
        end
    end
    local len = #grids;
    for i = 1, len do
        local grid = grids[i];
        local x = grid.x + this.buildingConfig.x;
        local y = grid.y + this.buildingConfig.y;
        local k = string.format("%d_%d", x, y);
        this.gridSeat[k] = 4;
        this.grids:SetGridType(k, 4);
    end
end


FoundationEditor.ClearSeatGrids = function()
    if (this.gridSeat ~= nil) then
        for k, _ in pairs(this.gridSeat) do
            this.grids:SetGridType(k, 0);
        end
        this.gridSeat = {};
    end
end


FoundationEditor.InitGrids = function(roomId)
    local roomConfig = ConfigMgr.Config.roomMap[roomId];
    if (roomConfig ~= nil) then
        local styleConfig = ConfigMgr.Config.RoomStyleMap[roomConfig.RoomStyleId];
        if (styleConfig ~= nil) then
		    FoundationMgr.SetGridSize(styleConfig.Cell);
            local roomPosConfig = ConfigMgr.Config.roomPosMap[styleConfig.Ground];
            if (roomPosConfig ~= nil) then
                this.container.localPosition = Vector3(roomPosConfig.Start[1], roomPosConfig.Start[2], roomPosConfig.Start[3]);
                if (this.grids ~= nil) then
                    this.grids:Clear();
                    this.grids = nil;
                end
                this.grids = FoundationGrids.New(this.gridsTF);
                this.grids:Generate(roomPosConfig.Area[2], roomPosConfig.Area[1], 1);
            end
        end
    end
end


this.ReadConfig = function()
    local path = LuaMgr.GetAssetsPath();
    local str = FileTool.ReadFile(path .. "/_BundleResources/Foundation/BuildingConfig.bytes");
    if (str ~= "") then
        this.buildingConfigMap = json.decode(str);
    else
        this.buildingConfigMap = {};
    end
end


FoundationEditor.SaveConfig = function(seats)
    local grids = {};
    for k, v in pairs(this.gridOccupy) do
        local list = NumTool.split(k, "_");
        local x = tonumber(list[1]) - this.buildingConfig.x;
        local y = tonumber(list[2]) - this.buildingConfig.y;
        table.insert(grids, {x = x, y = y, type = v});
    end
    local moves = {};
    for k, v in pairs(this.gridMove) do
        local list = NumTool.split(k, "_");
        local x = tonumber(list[1]) - this.buildingConfig.x;
        local y = tonumber(list[2]) - this.buildingConfig.y;
        table.insert(moves, {x = x, y = y, type = v});
    end
    this.buildingConfig.grids = grids;
    this.buildingConfig.moves = moves;
    if (seats ~= nil) then
        this.buildingConfig.seats = {};
        local len = #seats;
        for i = 1, len do
            table.insert(this.buildingConfig.seats, seats[i]);
        end
    end
    local path = LuaMgr.GetAssetsPath();
    local str = json.encode(this.buildingConfigMap);
    FileTool.WriteFile(path .. "/_BundleResources/Foundation/BuildingConfig.bytes", str);
    print("save config success.");
end


this.OnUpdate = function()
    this.CheckClick();
end


this.CheckClick = function()
    if (RaycastTool.IsPointerOverGameObject()) then return end

    if (this.gridType == 0) then
        if (this.building ~= nil and RaycastTool.GetMouseButton(0)) then
            local obj = RaycastTool.GetClickInfo(this.camera, 100, "Floor");
            if (obj ~= nil) then
                local name = obj.name;
                local list = NumTool.split(name, "_");
                local x = tonumber(list[1]);
                local y = tonumber(list[2]);
                if (x ~= this.building.x or y ~= this.building.y) then
                    this.MoveBuilding(x, y);
                end
            end
        end
        return;
    end
    if (RaycastTool.GetMouseButtonUp(0)) then
        local obj = RaycastTool.GetClickInfo(this.camera, 100, "Floor");
        if (obj ~= nil) then
            local name = obj.name;
            if (this.gridType == 1) then
                local type = this.gridMove[name];
                if (type ~= nil) then
                    this.gridMove[name] = nil;
                    this.grids:SetGridType(name, 0);
                else
                    this.gridMove[name] = 1;
                    this.grids:SetGridType(name, 1);
                end
                this.gridOccupy[name] = nil;
            elseif (this.gridType == 2) then
                local type = this.gridOccupy[name];
                if (type ~= nil) then
                    this.gridOccupy[name] = nil;
                    this.grids:SetGridType(name, 0);
                else
                    this.gridOccupy[name] = 2;
                    this.grids:SetGridType(name, 2);
                end
                this.gridMove[name] = nil;
            elseif (this.gridType == 4) then
                local type = this.gridSeat[name];
                if (type ~= nil) then
                    this.gridSeat[name] = nil;
                    this.grids:SetGridType(name, 0);
                else
                    this.gridSeat[name] = 4;
                    this.grids:SetGridType(name, 4);
                end
            end
        end
    end
end