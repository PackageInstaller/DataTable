





YXTwoBuffGroupViewModel = {}

YXTwoBuffGroupViewModel.__index = YXTwoBuffGroupViewModel

function YXTwoBuffGroupViewModel.New()
    local self = {}
    setmetatable(self, YXTwoBuffGroupViewModel)
    return self
end

function YXTwoBuffGroupViewModel:Init()
    self.itemList = {}
end

function YXTwoBuffGroupViewModel:SetData(data)
    self.data = data.data
    self.transform.anchoredPosition = Vector2(9,self.transform.anchoredPosition.y)
    local tempItem = nil
    local posx = 0
    local tempData = nil
    for i = 1, #self.data.buff do
        if i > #self.itemList then
            tempItem = YXTwoBuffItemViewModel.New(self.data.item,self.transform)
            table.insert(self.itemList,tempItem)
        end
        posx = (i - 1) * (154 + self.data.spaceX)
        self.itemList[i].gameObject.transform.anchoredPosition = Vector2(posx, 0)
        self.itemList[i]:SetData(self.data.buff[i],data.id,i,self.data.fun)
    end
end

function YXTwoBuffGroupViewModel:Clear()
    self.data = nil
    for i = 1, #self.itemList do
        self.itemList[i]:Clear()
    end
end

function YXTwoBuffGroupViewModel:Destroy()
    for i = 1, #self.itemList do
        self.itemList[i]:Destroy()
    end
    self.itemList = nil
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end