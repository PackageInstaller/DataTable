MiniBattle4BuffCardGroup = {}

MiniBattle4BuffCardGroup.__index = MiniBattle4BuffCardGroup

function MiniBattle4BuffCardGroup.New()
    local self = {}
    setmetatable(self, MiniBattle4BuffCardGroup)
    return self
end

function MiniBattle4BuffCardGroup:Init()
    self.itemList = {}
end

function MiniBattle4BuffCardGroup:SetData(data)
    self.data = data.data
    local tempItem = nil
    local posx = 0
    for i = 1, #self.data.itemDataList do
        if i > #self.itemList then
            tempItem = MiniBattle4BuffCardItem.New(self.data.itemTemplate, self.transform)
            tempItem:Init()
            table.insert(self.itemList, tempItem)
        end
        self.itemList[i]:SetData(self.data.itemDataList[i])
    end
    for i = #self.data.itemDataList + 1, #self.itemList do
        self.itemList[i]:Hide()
    end
end

function MiniBattle4BuffCardGroup:Clear()
    self.data = nil
    for i = 1, #self.itemList do
        self.itemList[i]:Clear()
    end
end

function MiniBattle4BuffCardGroup:Destroy()
    for i = 1, #self.itemList do
        self.itemList[i]:Destroy()
    end
    self.itemList = nil
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end