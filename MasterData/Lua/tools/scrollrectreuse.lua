




ScrollRectReuse = {}
ScrollRectReuse.__index = ScrollRectReuse
ScrollRectReuse.rowCount = 0
ScrollRectReuse.colCount = 0
ScrollRectReuse.padding = {}
ScrollRectReuse.spacingX = 0
ScrollRectReuse.spacingY = 0
ScrollRectReuse.templateHeight = 0
ScrollRectReuse.templateWidth = 0
ScrollRectReuse.templateList = nil
ScrollRectReuse.New = function(content,typeClass)
    local self = {}
    setmetatable(self, ScrollRectReuse)
    self.content = content
    self.typeClass = typeClass
    self.rectTransform = content.transform.parent.parent:GetComponent("RectTransform")
    self.scrollRect = content.transform.parent.parent:GetComponent("ScrollRect")
    self.itemObject = content.transform:GetChild(0):GetComponent("RectTransform")

    self.padding = {}
    self.templateList = {}
    return self
end

function ScrollRectReuse:InitContent(length,offset)
    self.length = length
    if self.length <= #self.templateList then
        for i = self.length + 1, #self.templateList do
            self.templateList[i]:Hide()
        end
    end
    local hLayout = self.content:GetComponent("HorizontalLayoutGroup")
    local vLayout = self.content:GetComponent("VerticalLayoutGroup")
    local gLayout = self.content:GetComponent("GridLayoutGroup")
    if hLayout ~= nil then
        self.onValueCallBack = function(pos) self:HorizontalOnValueChange(pos) end
    end
    if vLayout ~= nil then
        self.onValueCallBack = function(pos) self:VerticalOnValueChange(pos) end
    end
    if gLayout ~= nil then
        self.padding.Left = gLayout.padding.left
        self.padding.Right = gLayout.padding.right
        self.padding.Top = gLayout.padding.top
        self.padding.Bottom = gLayout.padding.bottom
        self.spacingX = gLayout.spacing.x
        self.spacingY = gLayout.spacing.y
        self.templateHeight = self.itemObject.rect.height + self.spacingY
        self.templateWidth = self.itemObject.rect.width + self.spacingX
    end
    if self.scrollRect.vertical then
        self.rowCount = math.ceil((self.rectTransform.rect.height + self.spacingY) / self.templateHeight)
        self.colCount = math.floor((self.rectTransform.rect.width + self.spacingX) / self.templateWidth)
        self.rowCount = self.rowCount + 2
        local contentHeight = self.templateHeight * math.ceil(self.length / self.colCount)
        if offset ~= nil then
            contentHeight = contentHeight + offset
        end
        self.content.sizeDelta = Vector2(self.content.sizeDelta.x, contentHeight + (self.padding.Top + self.padding.Bottom))
        self.onValueCallBack = function(pos) self:VerticalOnValueChange(pos) end
    end
    if self.scrollRect.horizontal then
        self.rowCount = math.floor((self.rectTransform.rect.height + self.spacingY) / self.templateHeight)
        self.colCount = math.ceil((self.rectTransform.rect.width + self.spacingX) / self.templateWidth)
        self.colCount = self.colCount + 2
        local contentWidth = self.templateWidth * math.ceil(self.length / self.rowCount)
        self.content.sizeDelta = Vector2(contentWidth + (self.padding.Left + self.padding.Right), self.content.sizeDelta.y)
        self.onValueCallBack = function(pos) self:HorizontalOnValueChange(pos) end
    end
    if gLayout ~= nil and gLayout.startAxis.value__ == 1 then
        self:VerticalCreateTemplate()
    else
        self:HorizontalCreateTemplate()
    end
end

local TableInsert = table.insert

function ScrollRectReuse:VerticalCreateTemplate()
    local index = 0
    local template = nil
    local tempX,tempY = 0,0
    for i = 0, self.colCount - 1 do
        for j = 0, self.rowCount - 1 do
            index = i * self.rowCount + j

            tempY = self.spacingY * j + self.padding.Top
            tempX = self.spacingX * i + self.padding.Left
            if index < self.length then
                if #self.templateList <= index then
                    template = self.typeClass.New(self.content)
                    template.rectTransform.anchorMin = Vector2(0, 1)
                    template.rectTransform.anchorMax = Vector2(0, 1)
                    local x = template.rectTransform.rect.width / 2 + i * template.rectTransform.rect.width
                    local y = -j * template.rectTransform.rect.height - template.rectTransform.rect.height / 2
                    template.rectTransform.anchoredPosition = Vector2(x + tempX, y - tempY)
                    TableInsert(self.templateList,template)
                end
                self:HorizontalUpdateTemplate(self.templateList[index + 1])
            end
        end
    end
    self.scrollRect.onValueChanged:RemoveListener(self.onValueCallBack)
    self.scrollRect.onValueChanged:AddListener(self.onValueCallBack)
end
function ScrollRectReuse:HorizontalCreateTemplate()
    local index = 0
    local template = nil
    local tempX,tempY = 0,0
    for i = 0, self.rowCount - 1 do
        for j = 0, self.colCount - 1 do
            index = i * self.colCount + j

            tempY = self.spacingY * i + self.padding.Top
            tempX = self.spacingX * j + self.padding.Left
            if index < self.length then
                if #self.templateList <= index then
                    template = self.typeClass.New(self.content)
                    template.rectTransform.anchorMin = Vector2(0, 1)
                    template.rectTransform.anchorMax = Vector2(0, 1)
                    local x = template.rectTransform.rect.width / 2 + j * template.rectTransform.rect.width
                    local y = -i * template.rectTransform.rect.height - template.rectTransform.rect.height / 2
                    template.rectTransform.anchoredPosition = Vector2(x + tempX, y - tempY)
                    TableInsert(self.templateList,template)
                end
            end
        end
    end
    self.scrollRect.onValueChanged:RemoveListener(self.onValueCallBack)
    self.scrollRect.onValueChanged:AddListener(self.onValueCallBack)
end

function ScrollRectReuse:VerticalOnValueChange(pos)
    local maxTop = self.templateHeight / 2
    local minBottom = -(self.rowCount * self.templateHeight) + self.templateHeight / 2
    for i = 1, #self.templateList do
        local cellRect = self.templateList[i].rectTransform
        local dist = self.content.anchoredPosition.y + cellRect.anchoredPosition.y
        if dist > maxTop then
            local newY = cellRect.anchoredPosition.y - self.rowCount * self.templateHeight
            if newY > -self.content.rect.height then
                cellRect.anchoredPosition = Vector2(cellRect.anchoredPosition.x, newY)
                self:VerticalUpdateTemplate(self.templateList[i])
            end
        elseif dist < minBottom then
            local newY = cellRect.anchoredPosition.y + self.rowCount * self.templateHeight
            if newY < 0 then
                cellRect.anchoredPosition = Vector2(cellRect.anchoredPosition.x, newY)
                self:VerticalUpdateTemplate(self.templateList[i])
            end
        end
    end
end
function ScrollRectReuse:VerticalResetPos()
    for i = 0, self.rowCount - 1 do
        for j = 0, self.colCount - 1 do
            local index = i * self.colCount + j
            local tempY = self.spacingY * i + self.padding.Top
            local tempX = self.spacingX * j + self.padding.Left
            if self.length < index + 1 then return end
            local cellRect = self.templateList[index + 1].rectTransform
            local x = cellRect.rect.width / 2 + j * cellRect.rect.width
            local y = -i * cellRect.rect.height - cellRect.rect.height / 2
            cellRect.anchoredPosition = Vector2(x + tempX, y - tempY)
            self:VerticalUpdateTemplate(self.templateList[index + 1])
        end
    end
end
function ScrollRectReuse:VerticalUpdateTemplate(template)
    local cellRect = template.rectTransform
    local x = math.ceil((cellRect.anchoredPosition.x - self.templateWidth / 2) / self.templateWidth)
    local y = math.abs(math.floor((cellRect.anchoredPosition.y + self.templateHeight / 2) / self.templateHeight))
    local index = (y * self.colCount + x) + 1
    if index > self.length or y > math.ceil(self.length / self.colCount) then
        template:Hide()
    else
        LuaMgr.InvokeUIEventListeners(UIEventConst.ScrollRectReuse,template,index)
    end
end

function ScrollRectReuse:HorizontalOnValueChange(pos)
    local minLeft = -self.templateWidth / 2
    local maxRight = ((self.colCount - 1) * self.templateWidth) + self.templateWidth / 2
    for i = 1, #self.templateList do
        local cellRect = self.templateList[i].rectTransform
        local dist = self.content.anchoredPosition.x + cellRect.anchoredPosition.x
        if dist < minLeft then
            local newX = cellRect.anchoredPosition.x + self.colCount * self.templateWidth
            if newX < self.content.rect.width then
                cellRect.anchoredPosition = Vector2(newX, cellRect.anchoredPosition.y)
                self:HorizontalUpdateTemplate(self.templateList[i])
            end
        elseif dist > maxRight then
            local newX = cellRect.anchoredPosition.x - self.colCount * self.templateWidth
            if newX > 0 then
                cellRect.anchoredPosition = Vector2(newX, cellRect.anchoredPosition.y)
                self:HorizontalUpdateTemplate(self.templateList[i])
            end
        end
    end
end
function ScrollRectReuse:HorizontalResetPos()
    for i = 0, self.colCount - 1 do
        for j = 0, self.rowCount - 1 do
            local index = i * self.rowCount + j
            local tempY = self.spacingY * j + self.padding.Top
            local tempX = self.spacingX * i + self.padding.Left
            if self.length < index + 1 then return end
            local cellRect = self.templateList[index + 1].rectTransform
            local x = cellRect.rect.width / 2 + i * cellRect.rect.width
            local y = -j * cellRect.rect.height - cellRect.rect.height / 2
            cellRect.anchoredPosition = Vector2(x + tempX, y - tempY)
            self:HorizontalUpdateTemplate(self.templateList[index + 1])
        end
    end
end
function ScrollRectReuse:HorizontalUpdateTemplate(template)
    local cellRect = template.rectTransform
    local x = math.floor((cellRect.anchoredPosition.x - self.templateWidth / 2) / self.templateWidth)
    local y = math.abs(math.floor((cellRect.anchoredPosition.y + self.templateHeight / 2) / self.templateHeight))
    local index = (x * self.rowCount + y) + 1
    if index > self.length or y > math.ceil(self.length / self.colCount) then
        template:Hide()
    else
        LuaMgr.InvokeUIEventListeners(UIEventConst.ScrollRectReuse,template,index)
    end
end