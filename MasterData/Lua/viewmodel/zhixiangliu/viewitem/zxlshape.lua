require("ViewModel/ZhiXiangLiu/ViewItem/ZXLBaseShape")





















ZXLShape = {}
ZXLShape.__index = ZXLShape

ZXLShape.Padding = 8
ZXLShape.TempCanvans = nil
ZXLShape.TempMainCamera = nil
ZXLShape.SmallCellDefaultSize = nil
local RenderTexture = UnityEngine.RenderTexture
local objs = {
    rectTrans = {path = "", type = UITool.RectTransform},
    onDragevent = {path = "Group", type = UITool.OnDragBehaviour},
    gridCellRoot = {path = "Group", type = UITool.Transform},
    rawImage = {path = "Group/RawImage", type = UITool.RawImage},
    iconParent = {path = "Group/IconParent", type = UITool.Transform}
}


function ZXLShape.New(obj, parent)

    local self = {}
    setmetatable(self, ZXLShape)
    self.smallCells = {}
    if obj ~= nil then
        self.gameObject = LuaMgr.InstantiateGO(obj, parent, false)
        self.transform = self.gameObject.transform
        UITool.Parse(self.gameObject, self, objs)
        self:InitInputEvents()
        self:InitParams()
    end
    return self
end

function ZXLShape:InitParams()
    ZXLShape.mainCanvas = true
end

function ZXLShape:SetData(data, fromScroll)
    self.data = data.data or data
    self.gameObject.name = "Shape_" .. self.data.configData.ID
    self.isPlaceSucc = false
    if fromScroll then
        self:SetSmallItem()
    end
end

function ZXLShape:SetSmallItem(isDefaultSize, parent)
    self.newParent = parent
    if parent ~= nil then
        self.gameObject.transform:SetParent(parent)
    end
    local data = self.data
    local maxCount = math.max(data.rowCount, data.colCount)
    local minCount = math.min(data.rowCount, data.colCount)
    local validSize = data.cellParentSize - ZXLShape.Padding * 2
    maxCount = isDefaultSize and 1 or maxCount
    local perGridSize = validSize / maxCount
    perGridSize = isDefaultSize and ZXLConst.SmallGridSize or perGridSize
    if self.perGridSize == nil then
        self.perGridSize = validSize / 2
    end
    local perGridHalfSize = perGridSize / 2
    local leftTopTransPosX, leftTopTransPosY = 0, 0
    if data.rowCount == data.colCount then
        leftTopTransPosX = ZXLShape.Padding
        leftTopTransPosY = -ZXLShape.Padding
    elseif data.rowCount == maxCount then
        leftTopTransPosX = ZXLShape.Padding + (maxCount - minCount) * perGridHalfSize
        leftTopTransPosY = -ZXLShape.Padding
    elseif data.colCount == maxCount then
        leftTopTransPosX = ZXLShape.Padding
        leftTopTransPosY = -ZXLShape.Padding - (maxCount - minCount) * perGridHalfSize
    end
    local gridConfigs = data.configData.normalizePosDatas
    self.iconImages = {}
    for i = 1, #gridConfigs do

        local gridPos = gridConfigs[i]
        local tempTransPosX = leftTopTransPosX + (gridPos.X - 1) * perGridSize
        local tempTransPosY = leftTopTransPosY - (gridPos.Y - 1) * perGridSize
        local smallCell = self.smallCells[i]
        if smallCell == nil then
            smallCell = ZXLBaseShape.New(data.gridCellPrefab, self.gridCellRoot, true)
            table.insert(self.smallCells, #self.smallCells + 1, smallCell)
        end
        smallCell:ResetPos(Vector3(tempTransPosX, tempTransPosY, 0))
        smallCell:ResetSize(perGridSize)
        smallCell:SetOccupy(data.configData.orginOccupy[i])
        local iconImage = smallCell:SetIcon(self:GetIconID())
        self.iconImages[i] = iconImage
        self:InitSmallGridInputEvents(smallCell)
    end

end

function ZXLShape:GetSmallCells()
    return self.smallCells
end

function ZXLShape:GetIconID()
    return self.data.configData.config.Icon
end

function ZXLShape:RenderImagesToRT()
    self.renderTexture = RenderTexture.GetTemporary(144, 144, 0, UnityEngine.RenderTextureFormat.ARGB32)
    self.renderTexture.filterMode = UnityEngine.FilterMode.Bilinear
    self.renderTexture.wrapMode = UnityEngine.TextureWrapMode.Clamp
    for i = 1, #self.smallCells do
        local iconTrans = self.iconImages[i].transform
        iconTrans:SetParent(self.iconParent)
    end
    self.iconParent:SetParent(self.data.canvas.transform, false)
    self.iconParent.localPosition = Vector3.zero
    self.data.canvas.enabled = true
    UnityEngine.RenderTexture.active = self.renderTexture
    UnityEngine.GL.Clear(true, true, UnityEngine.Color(0, 0, 0, 0))
    self.data.camera.targetTexture = self.renderTexture
    self.data.camera:Render()
    local func = function()
        self.data.camera.targetTexture = nil
        UnityEngine.RenderTexture.active = nil
        self.data.canvas.enabled = false
        self:RenderOutlineToRT()
        self.rawImage.texture = self.renderTexture
        self.iconParent:SetParent(self.onDragevent.gameObject.transform, false)
    end
    LuaMgr.NextFrame(func)
end

function ZXLShape:RenderOutlineToRT()
    local tempRt = RenderTexture.GetTemporary(144, 144, 0, UnityEngine.RenderTextureFormat.ARGB32)
    tempRt.filterMode = UnityEngine.FilterMode.Bilinear
    UnityEngine.Graphics.Blit(self.renderTexture, tempRt, self.iconImages[1].material)
    UnityEngine.Graphics.Blit(tempRt, self.renderTexture)
    RenderTexture.ReleaseTemporary(tempRt)
end

function ZXLShape:OnDragStartHandle(eventData, screenPos)
    if eventData ~= nil then
        screenPos = eventData.position
    end
    local dragPos = LuaMgr.Screen2Local(Vector2(screenPos.x, screenPos.y), self.newParent)
    self:SetTransPos(dragPos)
end

function ZXLShape:OnDragHandle(eventData, screenPos)
    local dragPos = LuaMgr.Screen2Local(eventData.position, self.newParent)
    self:SetTransPos(dragPos)
end

function ZXLShape:SetTransPos(dragPos)
    local curCellSize = self.data.cellParentSize
    local offseX = curCellSize + curCellSize / 2 + ZXLShape.Padding * 2
    local offseY = -curCellSize
    local data = self.data
    if data.colCount % 2 ~= 0 then
        offseX = curCellSize + curCellSize / 2 + ZXLShape.Padding * 2 + self.perGridSize / 2
    end
    if data.rowCount % 2 ~= 0 then
        offseY = -curCellSize / 2
    end
    self.transform.anchoredPosition = Vector2(dragPos.x + offseX, dragPos.y + offseY)
end

function ZXLShape:SetSiblingIndex(index)
    self.transform:SetSiblingIndex(index)
end

function ZXLShape:SetAsLastSibling()
    self.transform:SetAsLastSibling()
end

function ZXLShape:OnDragEndHandle(eventData, screenPos)
end

function ZXLShape:SetIsPlace(isSucc, data)
    if isSucc == true then
        local offsetX = data.offsetX
        local offsetY = data.offsetY
        local callback = data.callback
        self.isMoving = true
        if self.moveTweener ~= nil then
            self.moveTweener:Kill(true)
            self.moveTweener = nil
        end
        if self.allMatchSuccGrids ~= nil then
            for key, value in pairs(self.allMatchSuccGrids) do
                value:SetIsBePlace(false)
            end
        end
        local getter = function()
            return self.rectTrans.anchoredPosition
        end
        local setter = function(pos)
            self.rectTrans.anchoredPosition = pos
        end
        local targetpos = Vector2(self.rectTrans.anchoredPosition.x + offsetX, self.rectTrans.anchoredPosition.y + offsetY)
        self.moveTweener = DOTWeen.To(getter, setter, targetpos, 0.3)
        self.moveTweener.onComplete = function()
            self.isPlaceSucc = true
            self.isMoving = false
            self.allMatchSuccGrids = data.allMatchSuccGrids
            for key, value in pairs(self.allMatchSuccGrids) do
                value:SetIsBePlace(true)
            end
            if callback ~= nil then
                callback()
            end
        end
        self.onDragevent.enabled = false
    else
        self.isPlaceSucc = isSucc
        if self.allMatchSuccGrids ~= nil then
            for key, value in pairs(self.allMatchSuccGrids) do
                value:SetIsBePlace(false)
            end
        end
        self.allMatchSuccGrids = nil
        for key, value in pairs(self.smallCells) do
            value:SetIsBePlace(false)
        end
        self.onDragevent.enabled = true
    end
end

function ZXLShape:IsPlaceSucc()
    return self.isPlaceSucc
end


function ZXLShape:InitInputEvents()
    local onPointerDown = function(index, eventData)
        if self.placeSucc then
            return
        end
        self:OnPointerDown(RaycastTool.GetMousePosition(), eventData)
    end
    local onPointerUp = function(eventData)
        if self.placeSucc then
            return
        end
        self:OnPointerUp(RaycastTool.GetMousePosition(), eventData)
    end
    local onBeginDrag = function(eventData)
        if self.placeSucc then
            return
        end
        self:OnBeginDrag(RaycastTool.GetMousePosition(), eventData)
    end
    local onDrag = function(eventData)
        if self.placeSucc then
            return
        end
        self:OnDrag(RaycastTool.GetMousePosition(), eventData)
    end
    local onEndDrag = function(eventData)
        if self.placeSucc then
            return
        end
        self:OnEndDrag(RaycastTool.GetMousePosition(), eventData)
    end
    self.onPointerDown = onPointerDown
    self.onPointerUp = onPointerUp
    self.onBeginDrag = onBeginDrag
    self.onDrag = onDrag
    self.onEndDrag = onEndDrag

    self.onDragevent.onPointerDown = onPointerDown
    self.onDragevent.onPointerUp = onPointerUp
    self.onDragevent.onBeginDrag = onBeginDrag
    self.onDragevent.onDrag = onDrag
    self.onDragevent.onEndDrag = onEndDrag
end



function ZXLShape:InitSmallGridInputEvents(smallCell)
    local onPointerDown = self.onPointerDown
    local onPointerUp = self.onPointerUp
    local onBeginDrag = self.onBeginDrag
    local onDrag = self.onDrag
    local onEndDrag = self.onEndDrag
    smallCell:InitInputEvents(onPointerDown, onPointerUp, onBeginDrag, onDrag, onEndDrag)
end

function ZXLShape:OnPointerDown(screenPos, eventData)
    if self.isMoving == true then
        return
    end
    local data = {}
    data.shapeData = self
    data.screenPos = screenPos
    data.eventData = eventData
    LuaMgr.InvokeUIEventListeners(UIEventConst.ZXLGamePointerDown, data)
end

function ZXLShape:OnBeginDrag(screenPos, eventData)
    if self.isMoving == true then
        return
    end
    local data = {}
    data.shapeData = self.data
    data.screenPos = screenPos
    data.eventData = eventData
    LuaMgr.InvokeUIEventListeners(UIEventConst.ZXLGameDragBegin, data)
end

function ZXLShape:OnDrag(screenPos, eventData)
    if self.isMoving == true then
        return
    end
    local data = {}
    data.shapeData = self
    data.screenPos = screenPos
    data.eventData = eventData
    LuaMgr.InvokeUIEventListeners(UIEventConst.ZXLGameDrag, data)
end

function ZXLShape:OnEndDrag(screenPos, eventData)
    if self.isMoving == true then
        return
    end
    local data = {}
    data.shapeData = self
    data.screenPos = screenPos
    data.eventData = eventData
    LuaMgr.InvokeUIEventListeners(UIEventConst.ZXLGameDragEnd, data)
end

function ZXLShape:OnPointerUp(screenPos, eventData)
    if self.isMoving == true then
        return
    end
    local data = {}
    data.shapeData = self
    data.screenPos = screenPos
    data.eventData = eventData
    LuaMgr.InvokeUIEventListeners(UIEventConst.ZXLGamePointerUp, data)
end



function ZXLShape:Clear()
    for i = 1, #self.smallCells do
        self.smallCells[i]:Destroy()
    end
    self.smallCells = {}
    self.data = nil
    RenderTexture.ReleaseTemporary(self.renderTexture)
    SetActive(self.gameObject, false)
end

function ZXLShape:Destroy()
    for i = 1, #self.smallCells do
        self.smallCells[i]:Destroy()
    end
    self.smallCells = nil
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
    self.transform = nil
    self.data = nil
end