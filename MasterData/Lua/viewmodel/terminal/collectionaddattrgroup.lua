





CollectionAddAttrGroup = {}

CollectionAddAttrGroup.__index = CollectionAddAttrGroup

function CollectionAddAttrGroup.New()
    local self = {}
    setmetatable(self, CollectionAddAttrGroup)
    return self
end

function CollectionAddAttrGroup:Init()
    self.itemList = {}
end

function CollectionAddAttrGroup:SetData(data)
    self.data = data.data
    local tempItem = nil
    local posx = 0
    for i = 1, #self.data.attr do
        if i > #self.itemList then
            tempItem = CollectionAddAttrItem.New(self.data.item,self.transform)
            table.insert(self.itemList,tempItem)
        end
        posx = (i - 1) * (329 + 7)
        self.itemList[i].transform.anchoredPosition = Vector2(posx,0)
        self.itemList[i]:SetData(self.data.attr[i],self.data.callback)
    end
end

function CollectionAddAttrGroup:Clear()
    self.data = nil
    for i = 1, #self.itemList do
        self.itemList[i]:Clear()
    end
end

function CollectionAddAttrGroup:Destroy()
    for i = 1, #self.itemList do
        self.itemList[i]:Destroy()
    end
    self.itemList = nil
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end