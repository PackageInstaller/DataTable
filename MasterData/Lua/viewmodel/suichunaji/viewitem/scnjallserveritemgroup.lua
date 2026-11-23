require("ViewModel/SuiChuNaJi/ViewItem/SCNJAllServerItem")

SCNJAllServerItemGroup = {}
SCNJAllServerItemGroup.__index = SCNJAllServerItemGroup

function SCNJAllServerItemGroup.New()
    local self = {}
    setmetatable(self, SCNJAllServerItemGroup)
    return self
end

function SCNJAllServerItemGroup:Init()
    self.itemList = {}
end

function SCNJAllServerItemGroup:SetData(data)
    data = data.data
    self:ClearItems()
    local list = data.list
    local len = #list
    for i = 1, len do
        local item = self.itemList[i]
        if item == nil then
            item = SCNJAllServerItem.New(data.item, self.transform)
            self.itemList[i] = item
        else
            SetActive(item.gameObject, true)
        end
        local tempData = list[i]
        tempData.isLast = i == len
        item:SetData(list[i])
    end
end

function SCNJAllServerItemGroup:ClearItems()
    if (self.itemList ~= nil) then
        local len = #self.itemList
        for i = 1, len do
            self.itemList[i]:Clear()
        end
    end
end

function SCNJAllServerItemGroup:Clear()
    self:ClearItems()
end

function SCNJAllServerItemGroup:Destroy()
    if (self.itemList ~= nil) then
        local len = #self.itemList
        for i = 1, len do
            self.itemList[i]:Destroy()
        end
        self.itemList = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end