UIScrollView = {}

UIScrollView.__index = UIScrollView

local poolMap = {}
local scale = Vector3.one
local position = Vector3.zero
local contentSize = Vector2.zero

local function GetItem(this, data)
    local list = poolMap[data.class]
    if (list ~= nil) then
        local len = #list
        if (len > 0) then
            local item = list[len]
            list[len] = nil
            if (this.content ~= item.transform.parent) then
                item.transform:SetParent(this.content, false)
                item.transform.localScale = scale
            end
            if (this.scrollDir) then
                position.x = data.position
                position.y = 0
                item.transform.localPosition = position
            else
                position.x = 0
                position.y = data.position
                item.transform.localPosition = position
            end
            item.gameObject:SetActive(true)
            return item
        end
    end
    local obj = LuaMgr.InstantiateGO(data.prefab)
    if (obj ~= nil) then
        local objTF = obj.transform
        objTF:SetParent(this.content, false)
        objTF.localScale = scale
        if (this.scrollDir) then
            position.x = data.position
            position.y = 0
            objTF.localPosition = position
        else
            position.x = 0
            position.y = data.position
            objTF.localPosition = position
        end
        local class = _G[data.class]
        if (class ~= nil) then
            local item = class.New()
            item.class = data.class
            item.gameObject = obj
            item.transform = objTF
            item:Init()
            return item
        end
    end
    LuaMgr.DestroyImmediateGO(obj)
    return nil
end

local function AddItem(item)
    if (item.tween ~= nil) then
        item.tween:Kill(false)
        item.tween = nil
    end
    item:Clear()
    item.gameObject:SetActive(false)
    local list = poolMap[item.class]
    if (list == nil) then
        list = {}
        poolMap[item.class] = list
    end
    list[#list + 1] = item
end

UIScrollView.ClearItem = function(class)
    local list = poolMap[class]
    if (list ~= nil) then
        local item
        local len = #list
        for i = 1, len do
            item = list[i]
            item:Destroy()
            LuaMgr.DestroyImmediateGO(item.gameObject)
        end
        poolMap[class] = nil
        list = nil
    end
end

UIScrollView.ClearAll = function()
    for k, _ in pairs(poolMap) do
        UIScrollView.ClearItem(k)
    end
end

UIScrollView.New = function(gameObject)
    local self = {}
    setmetatable(self, UIScrollView)
    self.gameObject = gameObject
    self.rectTransform = gameObject:GetComponent("RectTransform")
    self.scrollRect = gameObject:GetComponent("ScrollRect")
    self.content = self.scrollRect.content
    self.isEnabled = true
    self.isScroll = true
    self.rectWidth = 0
    self.rectHeight = 0
    self.contentX = 0
    self.contentY = 0
    self.currentX = 0
    self.currentY = 0
    self.dataId = 0
    self.itemMap = {}
    self.screenList = {}
    self.dataList = {}
    self.scrollSize = 0
    self.scrollDir = self.scrollRect.horizontal
    self.scrollCallBack = nil
    self.paddingLeft = 0
    self.paddingRight = 0
    self.paddingTop = 0
    self.paddingBottom = 0
    self.updateHandler = function()

        if (self.content == nil or LuaMgr.IsObjectNull(self.content)) then
            return
        end

        local pos = self.content.localPosition
        self.contentX = pos.x
        self.contentY = pos.y
        if (self.contentX ~= self.currentX or self.contentY ~= self.currentY) then
            self.currentX = self.contentX
            self.currentY = self.contentY
            self:SetItems(false)
        end
        if (self.isScroll) then
            if (RaycastTool.GetMouseButtonUp(0)) then
                self:SetEnabled(true)
            end
        end
    end
    return self
end

function UIScrollView:SetParams(width, height)
    if (width ~= nil and height ~= nil) then
        self.rectWidth = width
        self.rectHeight = height
        self.rectTransform.sizeDelta = Vector2(width, height)
    else
        local sizeDelta = self.rectTransform.sizeDelta
        self.rectWidth = sizeDelta.x
        self.rectHeight = sizeDelta.y
    end
    self.scrollDir = self.scrollRect.horizontal and not self.scrollRect.vertical
end

function UIScrollView:SetEnabled(isEnabled)
    if (self.isEnabled ~= isEnabled) then
        self.isEnabled = isEnabled
        if (self.scrollDir) then
            self.scrollRect.horizontal = isEnabled
        else
            self.scrollRect.vertical = isEnabled
        end
    end
end

function UIScrollView:SetScroll(isScroll)
    self.isScroll = isScroll
    self.isEnabled = isScroll
    if (self.scrollDir) then
        self.scrollRect.horizontal = isScroll
    else
        self.scrollRect.vertical = isScroll
    end
end

function UIScrollView:SetPadding(left, right, top, bottom)
    self.paddingLeft = left
    self.paddingRight = right
    self.paddingTop = top
    self.paddingBottom = bottom
end

function UIScrollView:SetData(list, reset, pos)
    self:Clear(reset)
    self.scrollSize = self.scrollDir and self.paddingLeft or self.paddingTop
    local len = #list
    for i = 1, len do
        self:AddData(list[i], false)
    end
    self.scrollSize = self.scrollSize + (self.scrollDir and self.paddingRight or self.paddingBottom)
    self:SetContentSize()
    if (pos ~= nil and len >= pos) then
        local data = self.dataList[pos]
        if (data ~= nil) then
            if (self.scrollDir) then
                self.contentX = -(data.position + data.width - self.rectWidth) - 1
            else
                self.contentY = -(data.position - data.height + self.rectHeight) - 1
            end
        end
    end
    self.content.localPosition = Vector3(self.contentX, self.contentY, 0)
    self:SetItems(true)
    LuaMgr.AddUpdate(self.updateHandler)
end

function UIScrollView:AddData(data, refresh)
    self.dataId = self.dataId + 1
    data.id = self.dataId
    data.position = self.scrollSize
    table.insert(self.dataList, data)
    self.scrollSize = self.scrollSize + (self.scrollDir and data.width or -data.height)
    if (refresh) then
        self:SetContentSize()
        self:SetItems(refresh)
        LuaMgr.AddUpdate(self.updateHandler)
    end
end

function UIScrollView:SetContentSize()
    if (self.scrollDir) then
        contentSize.x = self.scrollSize
        contentSize.y = self.rectHeight
    else
        contentSize.x = self.rectWidth
        contentSize.y = -self.scrollSize
    end
    self.content.sizeDelta = contentSize
end

function UIScrollView:Refresh()
    self:SetItems(true)
end

function UIScrollView:MoveTo(type)
    if (self.scrollDir) then
        if (type == 0) then
            self.content.localPosition = Vector3(0, self.currentY, 0)
        elseif (type == 1) then
            local dx = -(self.scrollSize - self.rectWidth)
            self.content.localPosition = Vector3(dx > 0 and 0 or dx, self.currentY, 0)
        end
    else
        if (type == 0) then
            self.content.localPosition = Vector3(self.currentX, 0, 0)
        elseif (type == 1) then
            local dy = -(self.scrollSize + self.rectHeight)
            self.content.localPosition = Vector3(self.currentX, dy > 0 and dy or 0, 0)
        end
    end
end

function UIScrollView:MoveToIndex(index, center)
    local data = self.dataList[index]
    if (data ~= nil) then
        if (self.scrollDir) then
            if (center) then
                self.contentX = -data.position - data.width / 2 + self.rectWidth / 2
            else
                local dx = -(self.scrollSize - self.rectWidth)
                self.contentX = dx < -data.position and -data.position - 1 or dx
            end
        else
            if (center) then
                self.contentY = -data.position + data.height / 2 - self.rectHeight / 2
            else
                local dy = -(self.scrollSize + self.rectHeight)
                self.contentY = dy > -data.position and -data.position - 1 or dy
            end
        end
        self.content.localPosition = Vector3(self.contentX, self.contentY, 0)
        self:SetItems(true)
    end
end

function UIScrollView:InScreen(index)
    local data = self.dataList[index]
    if (data ~= nil) then
        if (self.scrollDir) then
            local minX = -self.contentX
            local maxX = minX + self.rectWidth
            if (data.position >= minX and data.position + data.width <= maxX) then
                return true
            end
        else
            local maxY = -self.contentY
            local minY = maxY - self.rectHeight
            if (data.position <= maxY and data.position - data.height >= minY) then
                return true
            end
        end
    end
    return false
end

function UIScrollView:GetIndex()
    if (self.scrollDir) then
        return self:GetHorizontalIndex(-self.contentX, self.dataList)
    end
    return self:GetVerticalIndex(-self.contentY, self.dataList)
end

function UIScrollView:SetItems(refresh)
    if (self.scrollDir) then
        self:SetHorizontal(refresh)
    else
        self:SetVertical(refresh)
    end
end

function UIScrollView:SetHorizontal(refresh)
    local item
    local data
    local map = {}
    local minX = -self.contentX
    local maxX = minX + self.rectWidth
    local len = #self.dataList
    local first = self:GetHorizontalIndex(minX, self.dataList)
    self.screenList = {}
    for i = first, len do
        data = self.dataList[i]
        if (data.position + data.width >= minX and data.position <= maxX) then
            item = self.itemMap[data.id]
            if (item ~= nil) then
                if (refresh) then
                    item:SetData(data)
                end
            else
                item = GetItem(self, data)
                item:SetData(data)
            end
            self.itemMap[data.id] = nil
            map[data.id] = item
            table.insert(self.screenList, item)
        elseif (i > 2) then
            break
        end
    end
    for _, v in pairs(self.itemMap) do
        AddItem(v)
    end
    self.itemMap = map
    if self.scrollCallBack ~= nil then
        self.scrollCallBack(self.screenList)
    end
end

function UIScrollView:GetHorizontalIndex(value, datas)
    local len = #datas
    local right = len - 1
    if (right > 0) then
        local data
        local index
        local left = 1
        while (left <= right) do
            index = math.floor((left + right) * 0.5)
            data = datas[index]
            if (data.position <= value and data.position + data.width >= value) then
                return index
            elseif (data.position > value) then
                right = index - 1
            elseif (data.position < value) then
                left = index + 1
            end
        end
        return len - index < index and len or 1
    end
    return 1
end

function UIScrollView:SetVertical(refresh)
    local item
    local data
    local map = {}
    local maxY = -self.contentY
    local minY = maxY - self.rectHeight
    local len = #self.dataList
    local first = self:GetVerticalIndex(maxY, self.dataList)
    self.screenList = {}
    for i = first, len do
        data = self.dataList[i]
        if (data.position - data.height <= maxY and data.position >= minY) then
            item = self.itemMap[data.id]
            if (item ~= nil) then
                if (refresh) then
                    item:SetData(data)
                end
            else
                item = GetItem(self, data)
                item:SetData(data)
            end
            self.itemMap[data.id] = nil
            map[data.id] = item
            table.insert(self.screenList, item)
        elseif (i > 2) then
            break
        end
    end
    for _, v in pairs(self.itemMap) do
        AddItem(v)
    end
    self.itemMap = map
    if self.scrollCallBack ~= nil then
        self.scrollCallBack(self.screenList)
    end
end

function UIScrollView:GetVerticalIndex(value, datas)
    local len = #datas
    local right = len - 1
    if (right > 0) then
        local data
        local index
        local left = 1
        while (left <= right) do
            index = math.floor((left + right) * 0.5)
            data = datas[index]
            if (data.position >= value and data.position - data.height <= value) then
                return index
            elseif (data.position > value) then
                left = index + 1
            elseif (data.position < value) then
                right = index - 1
            end
        end
        return len - index < index and len or 1
    end
    return 1
end

function UIScrollView:GetItemByIndex(index)
    local data = self.dataList[index]
    return GetItem(self, data)
end

function UIScrollView:Clear(reset)
    LuaMgr.RemoveUpdate(self.updateHandler)
    self.dataId = 0
    self.scrollSize = 0
    if (reset) then
        self.currentX = 0
        self.currentY = 0
        self.contentX = 0
        self.contentY = 0
    else
        self.currentX = self.contentX
        self.currentY = self.contentY
    end
    if (self.itemMap ~= nil) then
        for _, v in pairs(self.itemMap) do
            AddItem(v)
        end
        self.itemMap = {}
    end
    if (self.dataList ~= nil) then
        local len = #self.dataList
        for i = 1, len do
            UIScrollData.AddData(self.dataList[i])
        end
        self.dataList = {}
    end
    self.screenList = {}
end

function UIScrollView:Destroy()
    self.dataList = nil
    self.itemMap = nil
end