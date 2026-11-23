VoyagePortInfoGoodsItem = {};

VoyagePortInfoGoodsItem.__index = VoyagePortInfoGoodsItem;

function VoyagePortInfoGoodsItem.New()
    local self = {};
    setmetatable(self, VoyagePortInfoGoodsItem);
    return self;
end

function VoyagePortInfoGoodsItem:Init()
    self.item = nil;
end

function VoyagePortInfoGoodsItem:SetData(data)
    if (self.item == nil) then
        self.item = GoodsDataItem.New(self.transform);
        self.item.transform.localPosition = Vector3(-3, -3, 0);
    end
    local showItem = data.data;
    local itemData = table.Copy(ConfigMgr.Config.itemMap[showItem.id]);
    itemData.count0 = showItem.count;
    self.item:SetData(1, itemData, 1, false, Vector3(0.6, 0.6, 1));
end

function VoyagePortInfoGoodsItem:Clear()
    if (self.item ~= nil) then
        self.item:Hide();
    end
end

function VoyagePortInfoGoodsItem:Destroy()
    if (self.item ~= nil) then
        self.item:Clear();
        self.item = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end