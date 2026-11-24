HeroCardGroupItemSeason = {}

HeroCardGroupItemSeason.__index = HeroCardGroupItemSeason

function HeroCardGroupItemSeason.New()
    local self = {}
    setmetatable(self, HeroCardGroupItemSeason)
    return self
end

function HeroCardGroupItemSeason:Init()
    self.itemList = {}
end

function HeroCardGroupItemSeason:SetData(data)
    self.data = data.data
    local tempItem = nil
    for i = 1, #self.data.hero do
        if i > #self.itemList then
            tempItem = HeroCardItemSeason.New(self.transform)
            table.insert(self.itemList,tempItem)
        end
        self.itemList[i].transform.anchoredPosition = Vector2(0, i == 1 and 158 or -155)
        self.itemList[i]:SetData(i,self.data.hero[i],false, true)
        self.itemList[i]:CallBackFun(self.data.callBack)
    end
end

function HeroCardGroupItemSeason:Clear()
    self.data = nil
    for i = 1, #self.itemList do
        self.itemList[i]:Hide()
    end
end

function HeroCardGroupItemSeason:Destroy()
    for i = 1, #self.itemList do
        self.itemList[i]:Clear()
    end
    self.itemList = nil
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end