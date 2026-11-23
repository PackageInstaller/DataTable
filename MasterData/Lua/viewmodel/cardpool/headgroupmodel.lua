





HeadGroupModel = {}

HeadGroupModel.__index = HeadGroupModel

function HeadGroupModel.New()
    local self = {}
    setmetatable(self, HeadGroupModel)
    return self
end

function HeadGroupModel:Init()
    self.itemList = {}
end

function HeadGroupModel:SetData(data)
    self.data = data.data
    self.transform.sizeDelta = Vector2(data.width,self.transform.sizeDelta.y)
    local tempItem = nil
    local posx = 0
    for i = 1, #self.data.head do
        if i > #self.itemList then
            tempItem = HeadItemModel.New(self.data.item,self.transform)
            table.insert(self.itemList,tempItem)
        end
        posx = (i - 1) * (112 + self.data.spaceX)
        self.itemList[i].gameObject.transform.anchoredPosition = Vector2(posx, 0)
        self.itemList[i]:SetData(self.data.head[i])
    end
end

function HeadGroupModel:Clear()
    self.data = nil
    for i = 1, #self.itemList do
        self.itemList[i]:Clear()
    end
    self.gameObject:SetActive(false)
end

function HeadGroupModel:Destroy()
    for i = 1, #self.itemList do
        self.itemList[i]:Destroy()
    end
    self.itemList = nil
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end