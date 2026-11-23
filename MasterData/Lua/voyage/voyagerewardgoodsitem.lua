VoyageRewardGoodsItem = {};

VoyageRewardGoodsItem.__index = VoyageRewardGoodsItem;

VoyageRewardGoodsItem.status = false;

local objs = {
    itemTF = { path = "Item", type = "Transform" },
    status = { path = "Status", type = "GameObject" },
};

function VoyageRewardGoodsItem.New()
    local self = {};
    setmetatable(self, VoyageRewardGoodsItem);
    return self;
end

function VoyageRewardGoodsItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.item = nil;
end

function VoyageRewardGoodsItem:SetData(data)
    self.data = data.data;
    if (self.item == nil) then
        self.item = GoodsDataItem.New(self.itemTF);
        self.item.transform.localPosition = Vector3(-3, -3, 0);
    end
    local itemData = table.Copy(ConfigMgr.Config.itemMap[self.data.id]);
    itemData.count0 = self.data.count;
    self.item:SetData(1, itemData, 1, false, Vector3(0.56, 0.56, 1));
    SetActive(self.status, VoyageRewardGoodsItem.status);
end

function VoyageRewardGoodsItem:Clear()
    self.data = nil;
    if (self.item ~= nil) then
        self.item:Hide();
    end
end

function VoyageRewardGoodsItem:Destroy()
    if (self.item ~= nil) then
        self.item:Clear();
        self.item = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end