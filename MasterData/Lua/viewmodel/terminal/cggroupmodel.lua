




CGGroupModel = {}

CGGroupModel.__index = CGGroupModel

function CGGroupModel.New()
    local self = {}
    setmetatable(self, CGGroupModel)
    return self
end

function CGGroupModel:Init()
    self.itemList = {}
end

function CGGroupModel:SetData(data)
    self.data = data.data
    self.transform.sizeDelta = Vector2(data.width,self.transform.sizeDelta.y)
    local tempItem = nil
    local posx = 0
    for i = 1, #self.data.cg do
        if i > #self.itemList then
            tempItem = CGItemModel.New(self.data.item,self.transform)
            table.insert(self.itemList,tempItem)
        end
        posx = (i - 1) * (312 + self.data.spaceX)
        self.itemList[i].transform.anchoredPosition = Vector2(posx, 0)
        self.itemList[i]:SetData(self.data.cg[i])
    end
end

function CGGroupModel:Clear()
    self.data = nil
    for i = 1, #self.itemList do
        self.itemList[i]:Clear()
    end
end

function CGGroupModel:Destroy()
    for i = 1, #self.itemList do
        self.itemList[i]:Destroy()
    end
    self.itemList = nil
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end