require("Match3Game/ElementCell")








ElementFactory = {}
ElementFactory.__index = ElementFactory

function ElementFactory.New(prefab, cellParent)

    local self = {}
    setmetatable(self, ElementFactory)
    self.viewPools = {}
    self.prefabs = {}
    self.cellSize = Match3Const.CellSize
    self.cellParent = cellParent
    self.elementToCellMap = {}
    self.nullElementCellMap = {}
    self:InitPrefabs(prefab)
    return self
end


function ElementFactory:InitPrefabs(prefab)
    self.prefabs[Match3Const.ElementType.None] = LuaMgr.InstantiateGO(prefab, self.cellParent, false)

    for i = 1, 5 do
        self.prefabs[Match3Const.ElementType["Normal" .. i]] = LuaMgr.InstantiateGO(prefab, self.cellParent, false)
    end

    self.prefabs[Match3Const.ElementType.Horizontal] = LuaMgr.InstantiateGO(prefab, self.cellParent, false)
    self.prefabs[Match3Const.ElementType.Vertical] = LuaMgr.InstantiateGO(prefab, self.cellParent, false)
    self.prefabs[Match3Const.ElementType.ColorBall] = LuaMgr.InstantiateGO(prefab, self.cellParent, false)
    self.prefabs[Match3Const.ElementType.SuperColorBall] = LuaMgr.InstantiateGO(prefab, self.cellParent, false)

    self.prefabs[Match3Const.ElementType.WoodenBox] = LuaMgr.InstantiateGO(prefab, self.cellParent, false)

    for key, value in pairs(self.prefabs) do
        value.name = string.format("Element_%d", key)
        SetActive(value.gameObject, false)
    end
end




function ElementFactory:GetElementView(elementType, isIce)
    if not self.viewPools[elementType] then
        self.viewPools[elementType] = {}
    end
    local pool = self.viewPools[elementType]

    local poolItem
    if #pool > 0 then
        poolItem = table.remove(pool)
        poolItem.elementFactory = self
    else
        local prefab = self.prefabs[elementType]
        if prefab then
            poolItem = ElementCell.New(elementType, isIce, prefab, self.cellParent, self.cellSize)
            poolItem.elementFactory = self
        end
    end
    local transformChildCount = self.cellParent.transform.childCount
    if not self.gameObjectCount then
        self.gameObjectCount = transformChildCount
    else
        self.gameObjectCount = self.gameObjectCount + 1
    end
    poolItem.gameObject.transform:SetSiblingIndex(transformChildCount - 1)
    return poolItem
end



function ElementFactory:GetElementCellByPos(pos)
    if not pos then
        return nil
    end
    return self.elementToCellMap[pos:ToString()]
end



function ElementFactory:CacheCellByPosKey(pos, cell)
    self.elementToCellMap[pos:ToString()] = cell
end


function ElementFactory:GetCacheCellMap()
    return self.elementToCellMap
end



function ElementFactory:RecycleElementView(view)
    if not view then
        return
    end
    if view.CurrentElement == nil then
        view:Recycle()
        return
    end
    self:CacheCellByPosKey(view.CurrentElement.Pos, nil)
    local elementType = view.CurrentElement.Type
    if not self.viewPools[elementType] then
        self.viewPools[elementType] = {}
    end
    view:Recycle()
    table.insert(self.viewPools[elementType], view)
end


function ElementFactory:ClearPools()
    self:RecycleAllValidCell()
    for key, view in pairs(self.nullElementCellMap) do
        local elementType = nil
        if view.CurrentElement ~= nil then
            elementType = view.CurrentElement.Type
        end
        view:Recycle()
        if elementType ~= nil and self.viewPools ~= nil and self.viewPools[elementType] ~= nil then
            table.insert(self.viewPools[elementType], view)
        end
    end

    for _, pool in pairs(self.viewPools) do
for i = #pool, 1, -1 do
            local view = pool[i]
            if view and view.gameObject and not IsObjectNull(view.gameObject) then
                view:Recycle()
                LuaMgr.DestroyImmediateGO(view.gameObject)
            end
            pool[i] = nil
        end
    end
    self.viewPools = {}
    self.elementToCellMap = {}
    self.nullElementCellMap = {}
end

function ElementFactory:RecycleAllValidCell()
    for key, view in pairs(self.elementToCellMap) do
        local elementType = nil
        if view.CurrentElement ~= nil then
            elementType = view.CurrentElement.Type
        end
        view:Recycle()
        if elementType ~= nil and self.viewPools ~= nil and self.viewPools[elementType] ~= nil then
            table.insert(self.viewPools[elementType], view)
        end
    end
end