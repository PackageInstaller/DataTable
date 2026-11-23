GuoBaoRewardItem = {};

GuoBaoRewardItem.__index = GuoBaoRewardItem;

local objs = {
    itemTF = { path = "Item", type = "Transform" },
};

function GuoBaoRewardItem.New()
    local self = {};    
    setmetatable(self, GuoBaoRewardItem);
    return self;
end

function GuoBaoRewardItem:Init()    
    UITool.Parse(self.gameObject, self, objs);
    self.item = nil;
end

function GuoBaoRewardItem:SetData(data)
    if (self.item == nil) then
        self.item = GoodsDataItem.New(self.itemTF);
    end
    local reward = data.data;
    local itemConfig = table.Copy(ConfigMgr.Config.itemMap[reward.id]);
    itemConfig.count0 = reward.count;
    self.item:SetData(1, itemConfig, 1, false, Vector3(0.6,0.6,1), false);
end

function GuoBaoRewardItem:Clear()
    if (self.item ~= nil) then
        self.item:Hide();
    end
end

function GuoBaoRewardItem:Destroy()
    if (self.item ~= nil) then
        self.item:Clear();
        self.item = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end