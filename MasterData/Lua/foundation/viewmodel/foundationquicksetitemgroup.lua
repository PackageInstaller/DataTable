FoundationQuickSetItemGroup = {};

FoundationQuickSetItemGroup.__index = FoundationQuickSetItemGroup;

function FoundationQuickSetItemGroup.New()
    local self = {};
    setmetatable(self, FoundationQuickSetItemGroup);
    return self;
end

function FoundationQuickSetItemGroup:Init()
    self.item1 = nil;
    self.item2 = nil;
end

function FoundationQuickSetItemGroup:SetData(data)
    self.data = data.data;
    if (self.data.quickSet1 ~= nil) then
        if (self.item1 == nil) then
            self.item1 = FoundationQuickSetItem.New(self.data.item, self.transform);
            self.item1.transform.anchoredPosition = Vector2(0, 73);
        end
        self.item1:SetData(self.data.quickSet1);
    end
    if (self.data.quickSet2 ~= nil) then
        if (self.item2 == nil) then
            self.item2 = FoundationQuickSetItem.New(self.data.item, self.transform);
            self.item2.transform.anchoredPosition = Vector2(0, -73);
        end
        self.item2:SetData(self.data.quickSet2);
    end
end

function FoundationQuickSetItemGroup:Clear()
    self.data = nil;
    if (self.item1 ~= nil) then
        self.item1:Clear();
    end
    if (self.item2 ~= nil) then
        self.item2:Clear();
    end
end

function FoundationQuickSetItemGroup:Destroy()
    if (self.item1 ~= nil) then
        self.item1:Destroy();
        self.item1 = nil;
    end
    if (self.item2 ~= nil) then
        self.item2:Destroy();
        self.item2 = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end