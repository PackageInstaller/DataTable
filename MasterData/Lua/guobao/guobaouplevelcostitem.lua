GuoBaoUpLevelCostItem = {};

GuoBaoUpLevelCostItem.__index = GuoBaoUpLevelCostItem;

local objs = {
    itemTF = { path = "Item", type = "Transform" },
};

function GuoBaoUpLevelCostItem.New()
    local self = {};    
    setmetatable(self, GuoBaoUpLevelCostItem);
    return self;
end

function GuoBaoUpLevelCostItem:Init()    
    UITool.Parse(self.gameObject, self, objs);
    self.item = nil;
end

function GuoBaoUpLevelCostItem:SetData(data)
    if (self.item == nil) then
        self.item = GoodsDataItem.New(self.itemTF);
    end
    local cost = data.data;
    local itemConfig = table.Copy(ConfigMgr.Config.itemMap[cost.id]);
    itemConfig.count0 = cost.count;
    self.item:SetData(1, itemConfig, 1, false, Vector3(0.6,0.6,1), false);
end

function GuoBaoUpLevelCostItem:Clear()
    if (self.item ~= nil) then
        self.item:Hide();
    end
end

function GuoBaoUpLevelCostItem:Destroy()
    if (self.item ~= nil) then
        self.item:Clear();
        self.item = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end