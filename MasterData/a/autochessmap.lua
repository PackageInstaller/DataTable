


---@class AutoChessMap
local AutoChessMap = class("AutoChessMap")

local Grid = require ("jumper.grid") -- The grid class
local Pathfinder = require ("jumper.pathfinder") -- The pathfinder class

local showPath = false

---@param gridSize number 地图缩放
function AutoChessMap:ctor(gridSize)
    self.gridSize = gridSize

    ---@type int[][]
    self.map = nil

    self.areaTypeCount = 1
    ---@type table<string, UnityEngine.GameObject>
    self.areaPrefabs = {}

    ---@type table<string, UnityEngine.GameObject[]>
    self.areaObjPool = {}

    ---@type UnityEngine.GameObject[]
    self.areaLineObjs = {}

    ---@type UnityEngine.GameObject
    self.areaPathLine = nil


    self.selectGrid = Vector2.New(0, 0)
    ---@type UnityEngine.GameObject
    self.areaSelectGridObj = nil


    ---@type UnityEngine.GameObject[][]
    self.mapGridObjs = nil

    self.initFinish = false
    ---@type boolean 加载地块是否成功
    self.loadAreaPrefabFinish = false
    self:LoadMapAssets()
end

function AutoChessMap:InvalidateTmpWalkResources()
    self._tmpWalkMap = nil
    self._tmpGrid = nil
    self._tmpFinder = nil
end


---@param w int
---@param h int
function AutoChessMap:InitMapSize(w, h)
    local map = {}
    for y = 1, h do
        map[y] = {}
        for x = 1, w do 
            table.insert(map[y], 0)
        end
    end
    self.mapSize = {x = w, y = h}
    self.map = map
    self.grid = Grid(map)
    self.myFinder = Pathfinder(self.grid, 'JPS', function(val)
        return val == 0
    end)
    self.myFinder:setMode('DIAGONAL')
    self.myFinder:setHeuristic('EUCLIDIAN')
    self:InvalidateTmpWalkResources()
end


function AutoChessMap:SetMapData(mapData)
    self.mapSize = {x = #mapData[1], y = #mapData}
    self.map = mapData
    self.grid = Grid(mapData)
    self.myFinder = Pathfinder(self.grid, 'JPS', function(val)
        return val == 0
    end)
    self.myFinder:setMode('DIAGONAL')
    self.myFinder:setHeuristic('EUCLIDIAN')
    self:InvalidateTmpWalkResources()
end


---@param excludeUid integer? 寻路时忽略该单位占位（通常为寻路者自身）
function AutoChessMap:EnsureTmpWalkResources()
    if self._tmpFinder ~= nil then
        return
    end
    local base = self.map
    if base == nil then
        return
    end
    local tmp = {}
    for y = 1, #base do
        tmp[y] = {}
        for x = 1, #base[y] do
            tmp[y][x] = base[y][x]
        end
    end
    self._tmpWalkMap = tmp
    self._tmpGrid = Grid(self._tmpWalkMap)
    self._tmpFinder = Pathfinder(self._tmpGrid, 'JPS', function(val)
        return val == 0
    end)
    self._tmpFinder:setMode('DIAGONAL')
    self._tmpFinder:setHeuristic('EUCLIDIAN')
end

---将地形复制到临时可走图，并把敌方占格标为障碍
---@param excludeUid integer
---@param destGx integer?
---@param destGy integer?
function AutoChessMap:RefreshTmpWalkMap(excludeUid, destGx, destGy)
    self:EnsureTmpWalkResources()
    if self._tmpWalkMap == nil or self._tmpFinder == nil then
        return
    end
    local base = self.map
    local tmp = self._tmpWalkMap
    for y = 1, #base do
        for x = 1, #base[y] do
            tmp[y][x] = base[y][x]
        end
    end
    AutoChessManager.instance():ApplyUnitOccupancyBlocks(tmp, excludeUid, destGx, destGy)
end

---@param excludeUid integer? 传入时会把其他单位占格当作障碍，避免路径穿过单位
---@param noFilter boolean? true 时保留逐格路点（AI 单步移动需要）
function AutoChessMap:FindPath(sx, sy, ex, ey, excludeUid, noFilter)
    local finder = self.myFinder
    if excludeUid ~= nil then
        self:RefreshTmpWalkMap(excludeUid, ex, ey)
        finder = self._tmpFinder
    end
    if finder == nil then
        return nil
    end
    local path = finder:getPath(sx, sy, ex, ey)
    if path == nil or path:getLength() == 0 then
        return nil
    end

    if not noFilter and path:getLength() > 3 then
        path:filter()
    end

    local waypoints = {}
    for node, count in path:nodes() do
        waypoints[count] = Vector3.New(node:getX() * self.gridSize, 0, node:getY() * self.gridSize)
    end
    if showPath then
        self:ShowPath(waypoints)
    end
    return waypoints
end

function AutoChessMap:GetMapSize()
    if self.map == nil then
       return 0, 0
    end
    return self.mapSize.x, self.mapSize.y
end

---格子中心世界坐标（与 FindPath 路点、地块摆放一致）
---@return number, number
function AutoChessMap:GridToWorldPos(gx, gy)
    return gx * self.gridSize, gy * self.gridSize
end

function AutoChessMap:LoadMapAssets()
    local root = AutoChessManager.instance().sceneRoot
    if IsNull(root) then
        return
    end
    local mapRoot = root.transform:Find("MapRoot")
    if IsNull(mapRoot) then
       return 
    end
    self.mapRoot = mapRoot
    for i = 0, self.areaTypeCount do
        local path = string.format(Config.PrefabPath.AutoChessMapArea, i)
        local type = "Area_" .. i
        ResMgr:LoadPrefabAsyncInOwner(path, BindCallback(self, self.OnLoadMapAreaCallback, path, type), root) 
    end

    ResMgr:LoadPrefabAsyncInOwner(Config.PrefabPath.AutoChessMapAreaLine, function(obj)
        local type = "Area_Line"
        self.areaPrefabs[type] = obj
    end, root)

    ResMgr:LoadPrefabAsyncInOwner(Config.PrefabPath.AutoChessMapSelect, function(obj)
        local sObj = GameObject.Instantiate(obj, mapRoot)
        self.areaSelectGridObj = sObj
        self:SetSelectMapActive(self.selectGrid.x, self.selectGrid.y)
    end, root)
end


function AutoChessMap:OnLoadMapAreaCallback(path, type, obj)
    self.areaPrefabs[type] = obj
    for i = 0, self.areaTypeCount do
        local type = "Area_" .. i
        if self.areaPrefabs[type] == nil then
           return 
        end
    end
    if self.map == nil then
        return
    end
    self.loadAreaPrefabFinish = true
    self:CreateMapGrid()
end

function AutoChessMap:CreateMapGrid()

    if not self.loadAreaPrefabFinish then
       return 
    end

    if self.mapGridObjs ~= nil then
        for y = 1, #self.mapGridObjs do
            for x = #self.mapGridObjs[y], 1, -1 do
                local v = self.mapGridObjs[y][x]
                self:RecycleAreaObj(v)
                self.mapGridObjs[y][x] = nil
            end
        end
    end
    self.mapGridObjs = {}
    for y = 1, #self.map do
        local len = self.map[y]
        self.mapGridObjs[y] = {}
        for x = 1, #len do
            local val = len[x]
            local obj = self:GetOrCreateAreaObj("Area_" .. val)
            if obj == nil then
                LuaLogger.es("创建地图格子错误 type:" .. val)
                return 
            end
            local trs = obj.transform
            trs:SetParent(self.mapRoot.transform)
            obj.transform.localScale = Vector3.one * self.gridSize
            obj.transform.localRotation = Quaternion.identity
            trs.localPosition = Vector3.New(x * self.gridSize, 0, y * self.gridSize)
            self.mapGridObjs[y][x] = obj
        end
    end
end

---@param type string
---@return UnityEngine.GameObject?
function AutoChessMap:GetOrCreateAreaObj(type)
    if self.areaObjPool == nil then
       return
    end
    if self.areaPrefabs == nil then
       return 
    end
    local tab = self.areaObjPool[type]
    if tab == nil then
       self.areaObjPool[type] = {}
       tab = self.areaObjPool[type] 
    end
    if #tab ~= 0 then
        local obj = tab[#tab]
        obj:SetActive(true)
        table.remove(tab, #tab)
        return obj
    end

    local prefab = self.areaPrefabs[type]
    if prefab == nil then
       return 
    end
    ---@type UnityEngine.GameObject
    local obj = GameObject.Instantiate(prefab, self.mapRoot.transform)
    obj.name = type
    return obj
end


function AutoChessMap:RecycleAreaObj(gridObj)
    if IsNull(gridObj) then
       return 
    end
    local type = gridObj.name
    if self.areaObjPool[type] == nil then
       self.areaObjPool[type] = {} 
    end
    table.insert(self.areaObjPool[type], gridObj)
    gridObj:SetActive(false)
end

function AutoChessMap:GetMapBlockVal(x, y)
    local yl = self.map[y]
    if yl == nil then
       return nil 
    end
    local v = yl[x]
    return v
end

function AutoChessMap:SetMapBlockVal(x, y, val)
    local v = self:GetMapBlockVal(x, y)
    if v == nil or v == val then
       return 
    end
    self.map[y][x] = val
    self:InvalidateTmpWalkResources()
    if self.mapGridObjs == nil then
       return 
    end

    ---更新显示
    local gridObj = self.mapGridObjs[y][x]
    if not IsNull(gridObj) then
        self:RecycleAreaObj(gridObj)
    else
        LuaLogger.es("===>>> gridObj isNull x:" .. x .. "  y:" .. y) 
    end

    gridObj = nil
    gridObj = self:GetOrCreateAreaObj("Area_" .. val)
    if gridObj ~= nil then
        gridObj.transform.localPosition = Vector3.New(x * self.gridSize, 0, y * self.gridSize)
        self.mapGridObjs[y][x] = gridObj
    end
end


function AutoChessMap:ShowPath(waypoints)
    if waypoints == nil then
        return
    end

    for i = 1, #self.areaLineObjs do
        local obj = self.areaLineObjs[i]
        self:RecycleAreaObj(obj)
    end
    self.areaLineObjs = {}

    for i = 1, #waypoints - 1 do
        local pos = waypoints[i]
        local nPos = waypoints[i + 1]
        local obj = self:GetOrCreateAreaObj("Area_Line")
        if obj == nil then
           return
        end

        local lenPos = nPos - pos
        local dis = Vector3.Distance(pos, nPos)
        local dir = Vector3.Normalize(lenPos)
      
        local trs = obj.transform
        trs:SetParent(self.mapRoot.transform)
        trs.localPosition = pos
        trs.localScale = Vector3.New(dis, 1, 1)
        trs.right = dir

        table.insert(self.areaLineObjs, obj)
    end
end


function AutoChessMap:SetSelectMapActive(x, y)
    self.selectGrid:Set(x, y)
    if IsNull(self.areaSelectGridObj) then
        return
    end
    if x == nil or x == 0 then
        self.areaSelectGridObj:SetActive(false)
        return
    end
    self.areaSelectGridObj:SetActive(true)
    local px, py = AutoChessManager.instance():GridPosToWorldPos(x, y)
    self.areaSelectGridObj.transform.position = Vector3.New(px, 0.01, py)
end




return AutoChessMap