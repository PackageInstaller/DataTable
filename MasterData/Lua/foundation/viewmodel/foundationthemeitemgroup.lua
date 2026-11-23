FoundationThemeItemGroup = {};

FoundationThemeItemGroup.__index = FoundationThemeItemGroup;

function FoundationThemeItemGroup.New()
    local self = {};
    setmetatable(self, FoundationThemeItemGroup);
    return self;
end

function FoundationThemeItemGroup:Init()
    self.item1 = nil;
    self.item2 = nil;
end

function FoundationThemeItemGroup:SetData(data)
    self.data = data.data;
    if (self.data.theme1 ~= nil) then
        if (self.item1 == nil) then
            self.item1 = FoundationThemeItem.New(self.data.item, self.transform);
            self.item1.transform.anchoredPosition = Vector2(0, 93);
        end
        self.item1:SetData(self.data.theme1);
    end
    if (self.data.theme2 ~= nil) then
        if (self.item2 == nil) then
            self.item2 = FoundationThemeItem.New(self.data.item, self.transform);
            self.item2.transform.anchoredPosition = Vector2(0, -93);
        end
        self.item2:SetData(self.data.theme2);
    end
end

function FoundationThemeItemGroup:Clear()
    self.data = nil;
    if (self.item1 ~= nil) then
        self.item1:Clear();
    end
    if (self.item2 ~= nil) then
        self.item2:Clear();
    end
end

function FoundationThemeItemGroup:Destroy()
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