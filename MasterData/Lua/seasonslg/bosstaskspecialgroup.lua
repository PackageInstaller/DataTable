
BossTaskSpecialGroup = {}
BossTaskSpecialGroup.__index = BossTaskSpecialGroup

function BossTaskSpecialGroup.New()
    local self = {}
    setmetatable(self, BossTaskSpecialGroup)
    return self
end

function BossTaskSpecialGroup:Init()
    self.itemList = {}
end

function BossTaskSpecialGroup:SetData(data)
    self.data = data.data
    self:ClearItems()
    local list = self.data.list
    local len = #list
    local normalItemCallBack=function(index)
        self.data.groupCallback(self.data.rowIndex,index);
    end
    for i = 1, len do
        local item = self.itemList[i]
        if item == nil then
            item = BossTaskSpecialItem.New(self.data.item, self.transform)
            self.itemList[i] = item
        else
            SetActive(item.gameObject, true)
        end
        local tempData = list[i]
        tempData.isLast = i == len
        tempData.colIndex=i;
        tempData.callBack=normalItemCallBack,
        item:SetData(list[i])
    end
end

function BossTaskSpecialGroup:ClearItems()
    if (self.itemList ~= nil) then
        local len = #self.itemList
        for i = 1, len do
            self.itemList[i]:Clear()
        end
    end
end

function BossTaskSpecialGroup:Clear()
    self:ClearItems()
end

function BossTaskSpecialGroup:Destroy()
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