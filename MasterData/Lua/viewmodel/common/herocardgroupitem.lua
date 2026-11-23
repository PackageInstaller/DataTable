




HeroCardGroupItem = {}

HeroCardGroupItem.__index = HeroCardGroupItem

function HeroCardGroupItem.New()
    local self = {}
    setmetatable(self, HeroCardGroupItem)
    return self
end

function HeroCardGroupItem:Init()
    self.itemList = {}
end

function HeroCardGroupItem:SetData(data)
    self.data = data.data
    local tempItem = nil
    for i = 1, #self.data.hero do
        if i > #self.itemList then
            tempItem = HeroCardItem.New(self.transform)
            table.insert(self.itemList,tempItem)
        end
        self.itemList[i].transform.anchoredPosition = Vector2(-4, i == 1 and 158 or -155)
        self.itemList[i]:SetData(i,self.data.hero[i],false)
        self.itemList[i]:CallBackFun(self.data.callBack)
    end
end

function HeroCardGroupItem:Clear()
    self.data = nil
    for i = 1, #self.itemList do
        self.itemList[i]:Hide()
    end
end

function HeroCardGroupItem:Destroy()
    for i = 1, #self.itemList do
        self.itemList[i]:Clear()
    end
    self.itemList = nil
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end