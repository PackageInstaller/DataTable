




BuffGroupViewModel = {}

BuffGroupViewModel.__index = BuffGroupViewModel

function BuffGroupViewModel.New()
    local self = {}
    setmetatable(self, BuffGroupViewModel)
    return self
end


function BuffGroupViewModel:Init()
    self.itemList = {}
end

function BuffGroupViewModel:SetData(data)
    self.data = data.data
    self.transform.sizeDelta = Vector2(data.width,data.height)
    local tempItem = nil
    local posx = 0
    for i = 1, #self.data.buff do
        if i > #self.itemList then
            tempItem = BuffItemViewModel.New(self.data.item,self.transform)
            table.insert(self.itemList,tempItem)
        end
        posx = (i - 1) * (340 + 7)
        self.itemList[i].transform.anchoredPosition = Vector2(posx, 0)
        self.itemList[i]:SetData(self.data.buff[i],self.data.call,self.data.indexRow,i,self.data.isPreview)
    end
end

function BuffGroupViewModel:Clear()
    self.data = nil
    for i = 1, #self.itemList do
        self.itemList[i]:Clear()
    end
end

function BuffGroupViewModel:Destroy()
    for i = 1, #self.itemList do
        self.itemList[i]:Destroy()
    end
    self.itemList = nil
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end