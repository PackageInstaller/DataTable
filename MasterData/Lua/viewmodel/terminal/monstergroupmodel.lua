




MonsterGroupModel = {}

MonsterGroupModel.__index = MonsterGroupModel

function MonsterGroupModel.New()
    local self = {}
    setmetatable(self, MonsterGroupModel)
    return self
end

function MonsterGroupModel:Init()
    self.itemList = {}
end

function MonsterGroupModel:SetData(data)
    self.data = data.data
    self.transform.sizeDelta = Vector2(data.width,self.transform.sizeDelta.y)
    local tempItem = nil
    local posx = 0
    for i = 1, #self.data.monster do
        if i > #self.itemList then
            tempItem = MonsterItemModel.New(self.data.item,self.transform)
            table.insert(self.itemList,tempItem)
        end
        posx = (i - 1) * (156 + self.data.spaceX)
        self.itemList[i].transform.anchoredPosition = Vector2(posx, 0)
        self.itemList[i]:SetData(self.data.monster[i])
    end
end

function MonsterGroupModel:Clear()
    self.data = nil
    for i = 1, #self.itemList do
        self.itemList[i]:Clear()
    end
end

function MonsterGroupModel:Destroy()
    for i = 1, #self.itemList do
        self.itemList[i]:Destroy()
    end
    self.itemList = nil
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end