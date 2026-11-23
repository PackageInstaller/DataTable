















ZXLBaseShape = {}
ZXLBaseShape.__index = ZXLBaseShape

local objs = {
    rectTrans = {path = "", type = UITool.RectTransform},
    onDragevent = {path = "Group", type = UITool.OnDragBehaviour},
    lightBG1 = {path = "Group/LightIcon1", type = UITool.GameObject},
    lightBG2 = {path = "Group/LightIcon2", type = UITool.GameObject},
    darkBG1 = {path = "Group/DarkIcon1", type = UITool.GameObject},
    darkBG2 = {path = "Group/DarkIcon2", type = UITool.GameObject},
    icon = {path = "Group/Icon", type = UITool.Image},
    iconRect = {path = "Group/Icon", type = UITool.RectTransform},
    effect = {path = "Group/Vfx_GridCell", type = UITool.GameObject},
}


function ZXLBaseShape.New(prefab, parent, canOperate)

    local self = {}
    setmetatable(self, ZXLBaseShape)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    UITool.Parse(self.gameObject, self, objs)
    self.transform = self.gameObject.transform
    self.canOperate = canOperate or false
    SetActive(self.darkBG1.gameObject, false)
    SetActive(self.darkBG2.gameObject, false)
    return self
end

function ZXLBaseShape:SetData(data)
    self.data = data
    self:SetIsBePlace(false)
    SetActive(self.icon.gameObject, false)
    if data.valid then
        SetActive(self.darkBG1.gameObject, false)
        SetActive(self.darkBG2.gameObject, false)
        if data.darkType == 1 then
            SetActive(self.lightBG1.gameObject, true)
            SetActive(self.lightBG2.gameObject, false)
        else
            SetActive(self.lightBG1.gameObject, false)
            SetActive(self.lightBG2.gameObject, true)
        end
    else
        SetActive(self.lightBG1.gameObject, false)
        SetActive(self.lightBG2.gameObject, false)
        SetActive(self.darkBG1.gameObject, false)
        SetActive(self.darkBG2.gameObject, false)
    end
    self:ResetPos(data.position)
    self:SetOccupy(self.data.occupy)
end

function ZXLBaseShape:IsValid()
    return self.data.valid
end

function ZXLBaseShape:SetIcon(iconID)
    self.iconID = iconID
    SetActive(self.icon.gameObject, true)
    SetActive(self.lightBG1.gameObject, false)
    SetActive(self.lightBG2.gameObject, false)
    SetActive(self.darkBG1.gameObject, false)
    SetActive(self.darkBG2.gameObject, false)
    self.icon.sprite = LuaMgr.GetSprite(ZXLConst.AtlaName, iconID)
    return self.icon
end

function ZXLBaseShape:SetGridIcon(iconID)
    local data = self.data
    if data.valid then
        SetActive(self.icon.gameObject, true)
        self.icon.sprite = LuaMgr.GetSprite(ZXLConst.AtlaName, iconID)
        SetActive(self.darkBG1.gameObject, data.darkType == 1)
        SetActive(self.darkBG2.gameObject, data.darkType ~= 1)
    end
end

function ZXLBaseShape:ResetGrid()
    local data = self.data
    if data.valid then
        SetActive(self.icon.gameObject, false)
        SetActive(self.darkBG1.gameObject, false)
        SetActive(self.darkBG2.gameObject, false)
    end
end

function ZXLBaseShape:ResetPos(pos)
    self.transform.localPosition = pos
end

function ZXLBaseShape:ResetSize(size)
    local size = Vector2(size, size)
    self.rectTrans.sizeDelta = size
    self.iconRect.sizeDelta = size
end

function ZXLBaseShape:SetIsSparkle(isSparkle)
    SetActive(self.effect, isSparkle)
end

function ZXLBaseShape:GetWorldPosition()
    return self.transform.position
end

function ZXLBaseShape:GetLocalPosition()
    return Vector2(self.transform.localPosition.x, self.transform.localPosition.y)
end

function ZXLBaseShape:SetOccupy(occupy)
    self.occupy = occupy
end

function ZXLBaseShape:GetOccupy()
    return self.occupy
end

function ZXLBaseShape:SetIsBePlace(isPlace)
    self.isBePlace = isPlace
end

function ZXLBaseShape:IsBePlace()
    return self.isBePlace or false
end


function ZXLBaseShape:InitInputEvents(onPointerDown, onPointerUp, onBeginDrag, onDrag, onEndDrag)
    self.onDragevent.onPointerDown = onPointerDown
    self.onDragevent.onPointerUp = onPointerUp
    self.onDragevent.onBeginDrag = onBeginDrag
    self.onDragevent.onDrag = onDrag
    self.onDragevent.onEndDrag = onEndDrag
end


function ZXLBaseShape:Destroy()
    LuaMgr.DestroyGO(self.gameObject)
    self.gameObject = nil
    self.transform = nil
    self.rectTrans = nil
end