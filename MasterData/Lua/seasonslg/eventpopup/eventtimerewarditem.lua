EventTimeRewardItem = {};

EventTimeRewardItem.__index = EventTimeRewardItem;
local objs = {
    tfGoods={ path = "root/goods", type = "Transform" },
    goDone = { path = "root/done", type = "GameObject" },
};

function EventTimeRewardItem.New()
    local self = {};
    setmetatable(self, EventTimeRewardItem);
    return self;
end

function EventTimeRewardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end




function EventTimeRewardItem:SetData(data)
    self.data = data.data;
    SetActive(self.goDone, self.data.isComplete);
    if self.rewardItem == nil then
       self.rewardItem=GoodsDataItem.New(self.tfGoods);
    end
    local itemData = table.Copy(ConfigMgr.Config.itemMap[self.data.item.id]);
    itemData.count0 = self.data.item.count;
    self.rewardItem:SetData(1, itemData, 1, false, Vector3(0.6,0.6,0.6), false);
end

function EventTimeRewardItem:Clear()
    self.data = nil;
end

function EventTimeRewardItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end