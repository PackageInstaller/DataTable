




ScrollRectInfinite = {}
ScrollRectInfinite.__index = ScrollRectInfinite

ScrollRectInfinite.New = function(gameObject1,gameObject2,itemTemplate)
    local self = {}
    setmetatable(self, ScrollRectInfinite)
    self.itemTemplate = itemTemplate
    
    self.gameObject_1 = gameObject1
    self.scrollRect_1 = gameObject1:GetComponent("OnDragBehaviour")
    self.content_1 = self.scrollRect_1.content
    self.viewport_1 = self.scrollRect_1.viewport
    self.currentContent_1Y = self.content_1.transform.anchoredPosition.y
    self.scrollRect_1.scrollSensitivity = 0.5
    
    self.gameObject_2 = gameObject2
    self.scrollRect_2 = gameObject2:GetComponent("OnDragBehaviour")
    self.content_2 = self.scrollRect_2.content
    self.viewport_2 = self.scrollRect_2.viewport
    self.currentContent_2Y = self.content_2.transform.anchoredPosition.y
    self.scrollRect_2.scrollSensitivity = 0.5

    self.dataList = {}
    self.minDataIndex_1 = 0
    self.maxDataIndex_1 = 0
    self.minDataIndex_2 = 0
    self.maxDataIndex_2 = 0
    
    self.itemList_1 = {}
    self.minIndex_1 = nil
    self.maxIndex_1 = nil
    
    self.itemList_2 = {}
    self.minIndex_2 = nil
    self.maxIndex_2 = nil
    
    self.scrollCallBack = function(eventData) self:OnBeginDrag(eventData) end
    self.scrollRect_1.onBeginDrag = self.scrollCallBack
    self.scrollRect_2.onBeginDrag = self.scrollCallBack
    
    self.scroll_1CallBack = function() self:Scroll_1OnValueChange() end
    self.scroll_2CallBack = function() self:Scroll_2OnValueChange() end
    return self
end
ScrollRectInfinite.tableRemove = table.remove
ScrollRectInfinite.tableInsert = table.insert
function ScrollRectInfinite:SetData(dataList)
    if dataList == nil then return end
    self.scrollRect_1.onValueChanged:RemoveListener(self.scroll_1CallBack)
    self.scrollRect_2.onValueChanged:RemoveListener(self.scroll_2CallBack)
    self.scrollRect_1:StopMovement()
    self.content_1.transform.anchoredPosition = Vector2.zero
    self.scrollRect_2:StopMovement()
    self.content_2.transform.anchoredPosition = Vector2.zero
    self.dataList = dataList
    local tempItem = nil
    for i = 1, 7 do
        if #self.itemList_1 < i then
            tempItem = ActivityItemModel.New(self.itemTemplate,self.content_1)
            self.tableInsert(self.itemList_1,tempItem)
        end
        self.itemList_1[i].transform.anchoredPosition = Vector2(-35, -100 + (i - 1) * -260)
        self.itemList_1[i].transform.localScale = Vector3.one
        self.itemList_1[i]:SetData(self.dataList[i],i)
    end
    self.minDataIndex_1 = 1
    self.maxDataIndex_1 = 7
    self.minIndex_1 = 1
    self.maxIndex_1 = 7
    local index = 1
    for i = 8, 13 do
        if #self.itemList_2 < index then
            tempItem = ActivityItemModel.New(self.itemTemplate,self.content_2)
            self.tableInsert(self.itemList_2,tempItem)
        end
        self.itemList_2[index].transform.anchoredPosition = Vector2(-28,-80 + (index - 1) * -208)
        self.itemList_2[index].transform.localScale = Vector3(0.8,0.8,0.8)
        self.itemList_2[index]:SetData(self.dataList[i],i)
        index = index + 1
    end
    self.minDataIndex_2 = 8
    self.maxDataIndex_2 = 13
    self.minIndex_2 = 1
    self.maxIndex_2 = 6
end

function ScrollRectInfinite:OnBeginDrag(eventData)
    if eventData.pointerDrag.gameObject.name == "ScrollView_1" then
        self.scrollRect_2.onValueChanged:RemoveListener(self.scroll_2CallBack)
        self.scrollRect_1.onValueChanged:RemoveListener(self.scroll_1CallBack)
        self.scrollRect_1.onValueChanged:AddListener(self.scroll_1CallBack)
    elseif eventData.pointerDrag.gameObject.name == "ScrollView_2" then
        self.scrollRect_1.onValueChanged:RemoveListener(self.scroll_1CallBack)
        self.scrollRect_2.onValueChanged:RemoveListener(self.scroll_2CallBack)
        self.scrollRect_2.onValueChanged:AddListener(self.scroll_2CallBack)
    end
end

function ScrollRectInfinite:Scroll_1OnValueChange()
    self.scrollRect_2.verticalNormalizedPosition = self.scrollRect_1.verticalNormalizedPosition
    self:CalculateScroll_1()
    self:CalculateScroll_2()
end

function ScrollRectInfinite:Scroll_2OnValueChange()
    self.scrollRect_1.verticalNormalizedPosition = self.scrollRect_2.verticalNormalizedPosition
    self:CalculateScroll_1()
    self:CalculateScroll_2()
end

function ScrollRectInfinite:CalculateScroll_1()
    local cellRect = nil
    if self.currentContent_1Y < self.content_1.transform.anchoredPosition.y then
        cellRect = self.itemList_1[1]
    elseif self.currentContent_1Y > self.content_1.transform.anchoredPosition.y then
        cellRect = self.itemList_1[7]
    end
    if cellRect == nil then return end
    local maxTop = cellRect.transform.rect.height / 2
    local minBottom = cellRect.transform.rect.height * 2
    local position = RectTransformTool.ToContainer(cellRect.transform,self.viewport_1)
    if position.y < -self.viewport_1.rect.height - minBottom then
        self.minIndex_1 = self.minIndex_1 - 1
        self.maxIndex_1 = self.maxIndex_1 - 1
        self.minDataIndex_1 = self.minDataIndex_1 - 1 <= 0 and #self.dataList or self.minDataIndex_1 - 1
        self.maxDataIndex_1 = self.maxDataIndex_1 - 1 <= 0 and #self.dataList or self.maxDataIndex_1 - 1
        cellRect.transform.anchoredPosition = Vector2(-35, -100 + (self.minIndex_1 - 1) * -260)
        self.tableRemove(self.itemList_1,7)
        self.tableInsert(self.itemList_1,1,cellRect)
        cellRect:SetData(self.dataList[self.minDataIndex_1],cellRect.index)
    elseif position.y > maxTop then
        self.minIndex_1 = self.minIndex_1 + 1
        self.maxIndex_1 = self.maxIndex_1 + 1
        self.minDataIndex_1 = self.minDataIndex_1 + 1 > #self.dataList and 1 or self.minDataIndex_1 + 1
        self.maxDataIndex_1 = self.maxDataIndex_1 + 1 > #self.dataList and 1 or self.maxDataIndex_1 + 1
        cellRect.transform.anchoredPosition = Vector2(-35, -100 + (self.maxIndex_1 - 1) * -260)
        self.tableRemove(self.itemList_1,1)
        self.tableInsert(self.itemList_1,cellRect)
        cellRect:SetData(self.dataList[self.maxDataIndex_1],cellRect.index)
    end
    self.currentContent_1Y = self.content_1.transform.anchoredPosition.y
end

function ScrollRectInfinite:CalculateScroll_2()
    local cellRect = nil
    if self.currentContent_2Y < self.content_2.transform.anchoredPosition.y then
        cellRect = self.itemList_2[1]
    elseif self.currentContent_2Y > self.content_2.transform.anchoredPosition.y then
        cellRect = self.itemList_2[6]
    end
    if cellRect == nil then return end
    local maxTop = cellRect.transform.rect.height / 2
    local minBottom = (cellRect.transform.rect.height * 2) + maxTop
    local position = RectTransformTool.ToContainer(cellRect.transform,self.viewport_2)
    if position.y < -self.viewport_2.rect.height - minBottom then
        self.minIndex_2 = self.minIndex_2 - 1
        self.maxIndex_2 = self.maxIndex_2 - 1
        self.minDataIndex_2 = self.minDataIndex_2 - 1 <= 0 and #self.dataList or self.minDataIndex_2 - 1
        self.maxDataIndex_2 = self.maxDataIndex_2 - 1 <= 0 and #self.dataList or self.maxDataIndex_2 - 1
        cellRect.transform.anchoredPosition = Vector2(-28,-80 + (self.minIndex_2 - 1) * -208)
        self.tableRemove(self.itemList_2,6)
        self.tableInsert(self.itemList_2,1,cellRect)
        cellRect:SetData(self.dataList[self.minDataIndex_2],cellRect.index)
    elseif position.y > maxTop then
        self.minIndex_2 = self.minIndex_2 + 1
        self.maxIndex_2 = self.maxIndex_2 + 1
        self.minDataIndex_2 = self.minDataIndex_2 + 1 > #self.dataList and 1 or self.minDataIndex_2 + 1
        self.maxDataIndex_2 = self.maxDataIndex_2 + 1 > #self.dataList and 1 or self.maxDataIndex_2 + 1
        cellRect.transform.anchoredPosition = Vector2(-28,-80 + (self.maxIndex_2 - 1) * -208)
        self.tableRemove(self.itemList_2,1)
        self.tableInsert(self.itemList_2,cellRect)
        cellRect:SetData(self.dataList[self.maxDataIndex_2],cellRect.index)
    end
    self.currentContent_2Y = self.content_2.transform.anchoredPosition.y
end

function ScrollRectInfinite:Close()
    self.itemTemplate = nil
    self.gameObject_1 = nil
    self.scrollRect_1 = nil
    self.content_1 = nil
    self.viewport_1 = nil
    self.minIndex_1 = nil
    self.maxIndex_1 = nil
    
    self.gameObject_2 = nil
    self.scrollRect_2 = nil
    self.content_2 = nil
    self.viewport_2 = nil
    self.minIndex_2 = nil
    self.maxIndex_2 = nil
    
    self.currentContent_1Y = nil
    self.currentContent_2Y = nil
    self.dataList = nil
    for i = 1, #self.itemList_1 do
        self.itemList_1[i]:Destroy()
    end
    self.itemList_1 = nil
    for i = 1, #self.itemList_2 do
        self.itemList_2[i]:Destroy()
    end
    self.itemList_2 = nil
end