RhythmGameShopItemGroup = {};

RhythmGameShopItemGroup.__index = RhythmGameShopItemGroup;

function RhythmGameShopItemGroup.New()
    local self = {};
    setmetatable(self, RhythmGameShopItemGroup);
    return self;
end

function RhythmGameShopItemGroup:Init()
    self.items = {}   
end

function RhythmGameShopItemGroup:SetData(data)
    self.data = data.data;
    for i, v in ipairs(self.data.config) do
        local item = RhythmGameShopItem.New(self.data.item, self.transform);
        item:SetData(v)
        table.insert(self.items,item)       
    end    
end

function RhythmGameShopItemGroup:Clear()
    self.data = nil;
    for i,v in ipairs(self.items) do
        v:Clear();
    end   
end

function RhythmGameShopItemGroup:Destroy()
    for i,v in ipairs(self.items) do
        v:Destroy();
    end
    self.items = nil    
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end