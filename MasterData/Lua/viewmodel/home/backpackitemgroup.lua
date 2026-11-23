





BackpackItemGroup = {}

BackpackItemGroup.__index = BackpackItemGroup

function BackpackItemGroup.New()
    local self = {}
    setmetatable(self, BackpackItemGroup)
    return self
end

function BackpackItemGroup:Init()
    self.itemList = {}
end

function BackpackItemGroup:SetData(data)
    self.data = data.data
    self.transform.sizeDelta = Vector2(data.width,self.transform.sizeDelta.y)
    local tempItem = nil
    local posx = 0
    for i = 1, #self.data.item do
        if i > #self.itemList then
            tempItem = GoodsDataItem.New(self.transform,self.data.object)
            table.insert(self.itemList,tempItem)
        end
        posx = (i - 1) * (128 + self.data.spaceX)
        self.itemList[i].transform.anchoredPosition = Vector2(posx, 0)
        self.itemList[i]:SetData(i,self.data.item[i],self.data.labelType,self.data.isSplitStatus,nil,nil,nil,false)
    end
end

function BackpackItemGroup:Clear()
    self.data = nil
    for i = 1, #self.itemList do
        self.itemList[i]:Hide()
    end
end

function BackpackItemGroup:Destroy()
    for i = 1, #self.itemList do
        self.itemList[i]:Clear()
    end
    self.itemList = nil
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end