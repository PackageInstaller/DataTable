MiniBattle5BuffCardGroup = {}

MiniBattle5BuffCardGroup.__index = MiniBattle5BuffCardGroup

function MiniBattle5BuffCardGroup.New()
    local self = {}
    setmetatable(self, MiniBattle5BuffCardGroup)
    return self
end

function MiniBattle5BuffCardGroup:Init()
    self.itemList = {}
end

function MiniBattle5BuffCardGroup:SetData(data)
    self.data = data.data
    local tempItem = nil
    local posx = 0
    for i = 1, #self.data.itemDataList do
        if i > #self.itemList then
            tempItem = MiniBattle5BuffCardItem.New(self.data.itemTemplate, self.transform)
            tempItem:Init()
            table.insert(self.itemList, tempItem)
        end
        self.itemList[i].transform.anchoredPosition = Vector2((i - 1) * 221, -2)
        self.itemList[i]:SetData(self.data.itemDataList[i])
    end
    for i = #self.data.itemDataList + 1, #self.itemList do
        self.itemList[i]:Hide()
    end
end

function MiniBattle5BuffCardGroup:Clear()
    self.data = nil
    for i = 1, #self.itemList do
        self.itemList[i]:Clear()
    end
end

function MiniBattle5BuffCardGroup:Destroy()
    for i = 1, #self.itemList do
        self.itemList[i]:Destroy()
    end
    self.itemList = nil
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end