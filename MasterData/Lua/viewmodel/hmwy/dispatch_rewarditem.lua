Dispatch_RewardItem = {};

Dispatch_RewardItem.__index = Dispatch_RewardItem;
local objs = {
    goodsTF = { path = "root/goods", type = "Transform" },
   
}

function Dispatch_RewardItem.New()
    local self = {};
    setmetatable(self, Dispatch_RewardItem);
    self.isActive = false;
    return self;
end

function Dispatch_RewardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function Dispatch_RewardItem:SetData(pdata)
    self.data = pdata.data
    if self.item == nil then
        self.item = GoodsDataItem.New(self.goodsTF);
    end
    local itemConfig = ConfigMgr.Config.itemMap[self.data.id]
    itemConfig["count0"] = self.data.count
    self.item:SetData(1, itemConfig, 1, false, Vector3(0.55, 0.55, 1), false)
    
end

function Dispatch_RewardItem:Clear()
    self.data = nil;
end

function Dispatch_RewardItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject=nil;
end