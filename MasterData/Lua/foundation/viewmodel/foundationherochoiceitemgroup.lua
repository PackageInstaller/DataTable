FoundationHeroChoiceItemGroup = {};

FoundationHeroChoiceItemGroup.__index = FoundationHeroChoiceItemGroup;

function FoundationHeroChoiceItemGroup.New()
    local self = {};
    setmetatable(self, FoundationHeroChoiceItemGroup);
    return self;
end

function FoundationHeroChoiceItemGroup:Init()
    self.item1 = nil;
    self.item2 = nil;
end

function FoundationHeroChoiceItemGroup:SetData(data)
    self.data = data.data;
    if (self.data.hero1 ~= nil) then
        if (self.item1 == nil) then
            self.item1 = FoundationHeroChoiceItem.New(self.data.item, self.transform);
            self.item1.transform.anchoredPosition = Vector2(0, 161);
        end
        self.item1:SetData(self.data.hero1);
    end
    if (self.data.hero2 ~= nil) then
        if (self.item2 == nil) then
            self.item2 = FoundationHeroChoiceItem.New(self.data.item, self.transform);
            self.item2.transform.anchoredPosition = Vector2(0, -145);
        end
        self.item2:SetData(self.data.hero2);
    end
end

function FoundationHeroChoiceItemGroup:Clear()
    self.data = nil;
    if (self.item1 ~= nil) then
        self.item1:Clear();
    end
    if (self.item2 ~= nil) then
        self.item2:Clear();
    end
end

function FoundationHeroChoiceItemGroup:Destroy()
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