














BalatroChangeForeverItem = {}
BalatroChangeForeverItem.__index = BalatroChangeForeverItem

local objs = {
    dragEvent = {path = "AnimRoot/Icon", type = BalatroUtil.OnDragEvent},
    icon = {path = "AnimRoot/Icon", type = BalatroUtil.Image},
    selectImg = {path = "AnimRoot/SelectImg", type = BalatroUtil.GameObject},
    lockFlag = {path = "AnimRoot/Icon/LockFlag", type = BalatroUtil.GameObject}
}

function BalatroChangeForeverItem.New(prefab, parent, index, parentScroll, longTapCallback)

    local self = {}
    setmetatable(self, BalatroChangeForeverItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    UITool.Parse(self.gameObject, self, objs)
    SetActive(self.gameObject, true)
    self.parentScroll = parentScroll
    self.longTapCallback = longTapCallback
    self.OnClickItem = function()
        local tempSelected = false
        if self.selected == true then
            tempSelected = false
        else
            tempSelected = true
        end
        local callback = function(isValid)
            SetActive(self.selectImg, isValid)
            self.selected = isValid
        end
        local data = {
            selected = tempSelected,
            balatroData = self._data,
            callback = callback
        }
        LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroChooseBalatroBrand, data)
    end
    local onPointerDown = function(index, eventData)
        self:onPointerDown(index, eventData)
    end
    local onBeginDrag = function(eventData)
        self:onBeginDrag(eventData)
    end
    local onDrag = function(eventData)
        self:onDrag(eventData)
    end
    local onEndDrag = function(eventData)
        self:onEndDrag(eventData)
    end
    local onPointerUp = function(eventData)
        self:onPointerUp(eventData)
    end
    self.dragEvent:SetData(index, onPointerDown, onDrag, onPointerUp)
    self.dragEvent:SetDragData(onBeginDrag, onEndDrag)
    return self
end


function BalatroChangeForeverItem:SetData(data, longTapCallback)
    self._data = data
    self.selected = self._data:GetTempSelected()
    SetActive(self.gameObject, true)
    SetActive(self.selectImg, self.selected)
    SetActive(self.lockFlag, data:GetInvalid() == true or data:GetIsDestroy() == true)
    self.icon.sprite = LuaMgr.GetSprite(BalatroUtil.AlataOther, data:GetResName())
end


function BalatroChangeForeverItem:GetData()
    return self._data
end

function BalatroChangeForeverItem:GetGameObject()
    return self.gameObject
end

function BalatroChangeForeverItem:Clear()
    self._data = nil
    SetActive(self.gameObject, false)
end

function BalatroChangeForeverItem:Destroy()
    if (self.OnClickItem ~= nil) then
        self.OnClickItem = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
    self._data = nil
end

function BalatroChangeForeverItem:onPointerDown(index, eventData)
    if eventData.pointerEnter then
        self.downTime = CS.UnityEngine.Time.realtimeSinceStartup
    end
end

function BalatroChangeForeverItem:onBeginDrag(eventData)
    if self.parentScroll == nil then
        return
    end
    self.parentScroll:OnBeginDrag(eventData)
end

function BalatroChangeForeverItem:onDrag(eventData)
    if self.parentScroll == nil then
        return
    end
    self.parentScroll:OnDrag(eventData)
end

function BalatroChangeForeverItem:onEndDrag(eventData)
    if self.parentScroll == nil then
        return
    end
    self.parentScroll:OnEndDrag(eventData)
end

function BalatroChangeForeverItem:onPointerUp(eventData)
    if self.downTime == 0 or self.downTime == nil then
        return
    end
    local deltaTime = CS.UnityEngine.Time.realtimeSinceStartup - self.downTime
    if deltaTime < 0.2 then
        self.OnClickItem()
    else
        if self.longTapCallback ~= nil then
            self.longTapCallback(self)
        end
    end
    self.downTime = 0
end