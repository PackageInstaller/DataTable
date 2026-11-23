QinRewardItemGroup = {};

QinRewardItemGroup.__index = QinRewardItemGroup;

function QinRewardItemGroup.New()
    local self = {};
    setmetatable(self, QinRewardItemGroup);
    return self;
end

function QinRewardItemGroup:Init()
    self.itemList = {};
end

function QinRewardItemGroup:SetData(data)
    data = data.data;
    self:ClearItems();
    local item;
    local list = data.list;
    local len = #list;
    for i = 1, len do
        item = self.itemList[i];
        if (item == nil) then
            item = QinRewardItem.New(data.item, self.transform);
            self.itemList[i] = item;
        end
        item:SetData(list[i]);
    end
end

function QinRewardItemGroup:ClearItems()
    if (self.itemList ~= nil) then
        local len = #self.itemList;
        for i = 1, len do
            self.itemList[i]:Clear();
        end
    end
end

function QinRewardItemGroup:Clear()
    self:ClearItems();
end

function QinRewardItemGroup:Destroy()
    if (self.itemList ~= nil) then
        local len = #self.itemList;
        for i = 1, len do
            self.itemList[i]:Destroy();
        end
        self.itemList = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end