




HeroGroupModel = {}

HeroGroupModel.__index = HeroGroupModel

function HeroGroupModel.New()
    local self = {}
    setmetatable(self, HeroGroupModel)
    return self
end

function HeroGroupModel:Init()
    self.itemList = {}
end

function HeroGroupModel:SetData(data)
    self.data = data.data
    self.transform.sizeDelta = Vector2(data.width,self.transform.sizeDelta.y)
    local tempItem = nil
    local posx = 0
    for i = 1, #self.data.hero do
        if i > #self.itemList then
            tempItem = HeroItemModel.New(self.data.item,self.transform)
            table.insert(self.itemList,tempItem)
        end
        posx = (i - 1) * (160 + self.data.spaceX)
        self.itemList[i].transform.anchoredPosition = Vector2(posx, 0)
        self.itemList[i]:SetData(self.data.hero[i])
    end
end

function HeroGroupModel:Clear()
    self.data = nil
    for i = 1, #self.itemList do
        self.itemList[i]:Clear()
    end
end

function HeroGroupModel:Destroy()
    for i = 1, #self.itemList do
        self.itemList[i]:Destroy()
    end
    self.itemList = nil
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end