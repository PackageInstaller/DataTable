








GameGridInput = {}
GameGridInput.__index = GameGridInput

local objs = {
    onDragEvent = {path = "", type = UITool.OnDragEvent}
}

function GameGridInput.New(gridTrans)

    local self = {}
    setmetatable(self, GameGridInput)
    self.isDragging = false
    self.startPos = nil
    self.gridTransRect = gridTrans:GetComponent(UITool.RectTransform)
    UITool.Parse(self.gridTransRect.gameObject, self, objs)
    self:InitInputEvents()
    self.useItemType = ManagementConst.ItemType.None
    return self
end



function GameGridInput:SetUsePropType(type)
    self.useItemType = type
end


function GameGridInput:InitInputEvents()
    local onPointerDown = function(index, eventData)
        self:OnPointerDown(RaycastTool.GetMousePosition())
    end
    local onPointerUp = function(eventData)
        self:OnPointerUp(RaycastTool.GetMousePosition())
    end
    local onBeginDrag = function(eventData)
        self:OnBeginDrag(RaycastTool.GetMousePosition())
    end
    local onDrag = function(eventData)
        self:OnDrag(RaycastTool.GetMousePosition())
    end
    local onEndDrag = function(eventData)
    end
    self.onDragEvent:SetData(1, onPointerDown, onDrag, onPointerUp)
    self.onDragEvent:SetDragData(onBeginDrag, onEndDrag)
end

function GameGridInput:OnPointerDown(screenPos)
    if ManagementGameData.GetGameStatus() ~= ManagementConst.GameStatus.Gaming then
        return
    end
    if self.isDragging == true then
        LuaDebug.error("GameGridInput:OnBeginDrag已经在拖动中")
        return
    end
    if self.useItemType ~= ManagementConst.ItemType.None and self.useItemType ~= ManagementConst.ItemType.Swap then
        return
    end
    local gridPosSmall = ManagementGameData.ScreenToGridPosition(screenPos, self.gridTransRect, true)
    local gridPosBig = ManagementGameData.ScreenToGridPosition(screenPos, self.gridTransRect, false)
    local cellItem = ManagementGameData.GetSmallGridElement(gridPosBig, gridPosSmall)
    local bigCellData = ManagementGameData.GetBigGridElements(gridPosBig)
    if cellItem == nil or cellItem:IsEmpty() then
        return
    end
    if bigCellData == nil then
        LuaDebug.error("GameGridInput:OnBeginDrag没有获取到大格子位置")
        return
    end
    self.startBigCellData = bigCellData
    self.startCellItem = cellItem
    if self.useItemType == ManagementConst.ItemType.None then
        self.isDragging = true
        local localPosResult = RectTool.Screen2Local(Vector2(screenPos.x, screenPos.y), self.gridTransRect)
        local localPos = localPosResult.pos
        self.startCellItem.transform.localPosition = Vector3(localPos.x, localPos.y, 0)
        self.startCellItem.transform:SetAsLastSibling()
    end
end

function GameGridInput:OnBeginDrag(screenPos)
end

function GameGridInput:OnDrag(screenPos)
    if self.useItemType ~= ManagementConst.ItemType.None then
        return
    end
    if ManagementGameData.GetGameStatus() ~= ManagementConst.GameStatus.Gaming then
        return
    end
    if self.isDragging == false then
        return
    end
    if self.startCellItem == nil or self.startCellItem:IsEmpty() then
        return
    end
    local localPosResult = RectTool.Screen2Local(Vector2(screenPos.x, screenPos.y), self.gridTransRect)
    local localPos = localPosResult.pos
    self.startCellItem.transform.localPosition = Vector3(localPos.x, localPos.y, 0)
end

function GameGridInput:OnPointerUp(screenPos)
    if self.useItemType == ManagementConst.ItemType.None then
        self:OnDragEnd(screenPos)
    else
        self:OnUseSwapProps(screenPos)
    end
end

function GameGridInput:OnDragEnd(screenPos)
    self.isDragging = false
    if ManagementGameData.GetGameStatus() ~= ManagementConst.GameStatus.Gaming then
        self.startCellItem = nil
        self.startBigCellData = nil
        return
    end
    if self.startCellItem == nil then
        self.startCellItem = nil
        self.startBigCellData = nil
        return
    end
    if self.startCellItem == nil or self.startCellItem:IsEmpty() then
        self.startCellItem = nil
        self.startBigCellData = nil
        return
    end
    local gridPosSmall = ManagementGameData.ScreenToGridPosition(screenPos, self.gridTransRect, true)
    local gridPosBig = ManagementGameData.ScreenToGridPosition(screenPos, self.gridTransRect, false)
    local cellItem = ManagementGameData.GetSmallGridElement(gridPosBig, gridPosSmall)
    if cellItem == nil or cellItem:IsEmpty() == false then
        self.startCellItem:ResetPos()
        self.startCellItem = nil
        self.startBigCellData = nil
        return
    end
    local bigCellData = ManagementGameData.GetBigGridElements(gridPosBig)
    if bigCellData == nil then
        LuaDebug.error("GameGridInput:OnBeginDrag没有获取到大格子位置")
        self.startCellItem = nil
        self.startBigCellData = nil
        return
    end
    if bigCellData == nil or not bigCellData:GetValid() then
        if bigCellData == nil then
            LuaDebug.error("GameGridInput:OnBeginDrag放下位置大格子不合法，bigPos=" .. gridPosBig:ToString() .. ", smallPos=" .. gridPosSmall:ToString())
        end
        self.startCellItem:ResetPos()
        self.startCellItem = nil
        self.startBigCellData = nil
        return
    end
    if not bigCellData:CanMove() then
        self.startCellItem:ResetPos()
        self.startCellItem = nil
        self.startBigCellData = nil
        return
    end
    self:SwapBigGridOfSmallGrid(bigCellData, cellItem)
    self.startCellItem = nil
    self.startBigCellData = nil
end

function GameGridInput:OnUseSwapProps(screenPos)
    local gridPosSmall = ManagementGameData.ScreenToGridPosition(screenPos, self.gridTransRect, true)
    local gridPosBig = ManagementGameData.ScreenToGridPosition(screenPos, self.gridTransRect, false)
    local cellItem = ManagementGameData.GetSmallGridElement(gridPosBig, gridPosSmall)
    if cellItem == nil then
        return
    end
    local bigCellData = ManagementGameData.GetBigGridElements(gridPosBig)
    if bigCellData == nil then
        return
    end
    if bigCellData == nil or not bigCellData:GetValid() then
        return
    end
    if cellItem:IsEmpty() then
        return
    end
    if self.startPropCellItem ~= nil and cellItem:GetSmallGridPos():ToString() == self.startPropCellItem:GetSmallGridPos():ToString() then
        return
    end
    if self.startPropCellItem == nil then
        self.startPropCellItem = cellItem
        self.startPropBigCell = bigCellData

        self.startBigCellData = bigCellData
        self.startCellItem = cellItem
        self.startCellItem:SetSeleted(true)
    else
        self:SwapBigGridOfSmallGrid(bigCellData, cellItem)
        self.useItemType = ManagementConst.ItemType.None
        cellItem:SetSeleted(true)
        local data = {self.startPropCellItem, cellItem}
        LuaMgr.InvokeUIEventListeners(UIEventConst.ManagementSwapElementPosEnd, data)

        self.startPropCellItem = nil
        self.startPropBigCell = nil
        self.startCellItem = nil
        self.startBigCellData = nil
    end
end




function GameGridInput:SwapBigGridOfSmallGrid(goalBigCellData, goalSmallCellData)
    local startCellItem = self.startCellItem
    local startBigCellData = self.startBigCellData
    if self.useItemType == ManagementConst.ItemType.Swap then
        startCellItem = self.startPropCellItem
        startBigCellData = self.startPropBigCell
    end
    local startSmallGridPos = startCellItem.data.smallGridPos
    local goalSmallGridPos = goalSmallCellData.data.smallGridPos
    local startSmallCellData = startCellItem

    goalBigCellData:SetSmallCell(startCellItem, goalSmallCellData.data.smallGridPos)
    startBigCellData:SetSmallCell(goalSmallCellData, startSmallGridPos)


    startSmallCellData:SetBigGridPos(goalBigCellData.gridPos)
    startSmallCellData:SetSmallGridPos(goalSmallGridPos)
    startSmallCellData:UpdatePos()
    startSmallCellData:SetAsLastSibling()

    goalSmallCellData:SetBigGridPos(startBigCellData.gridPos)
    goalSmallCellData:SetSmallGridPos(startSmallGridPos)
    goalSmallCellData:UpdatePos()
    goalSmallCellData:SetAsLastSibling()


    startSmallCellData:RefreshGameObjectName(true)
    goalSmallCellData:RefreshGameObjectName(true)




    local goalData = goalBigCellData:CheckEliminated()
    local startData = startBigCellData:CheckEliminated()
    local data = {
        goalData = goalData,
        startData = startData
    }
    LuaMgr.InvokeUIEventListeners(UIEventConst.ManagementEliminatedElement, data)
end

function GameGridInput:Destroy()
end