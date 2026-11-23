





AchievementGroupViewModel = {}

AchievementGroupViewModel.__index = AchievementGroupViewModel

function AchievementGroupViewModel.New()
    local self = {}
    setmetatable(self, AchievementGroupViewModel)
    return self
end

function AchievementGroupViewModel:Init()
    self.itemList = {}
end

function AchievementGroupViewModel:SetData(data)
    self.data = data.data
    self.transform.sizeDelta = Vector2(data.width,self.transform.sizeDelta.y)
    local tempItem = nil
    local posx = 0
    for i = 1, #self.data.achievement do
        if i > #self.itemList then
            tempItem = AchievementItemViewModel.New(self.data.item,self.transform)
            table.insert(self.itemList,tempItem)
        end
        posx = (i - 1) * (292 + self.data.spaceX)
        self.itemList[i].transform.anchoredPosition = Vector2(posx, 0)
        self.itemList[i]:SetData(self.data.achievement[i])
    end
    tempItem = nil
end

function AchievementGroupViewModel:Clear()
    self.data = nil
    for i = 1, #self.itemList do
        self.itemList[i]:Clear()
    end
end

function AchievementGroupViewModel:Destroy()
    for i = 1, #self.itemList do
        self.itemList[i]:Destroy()
    end
    self.itemList = nil
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end