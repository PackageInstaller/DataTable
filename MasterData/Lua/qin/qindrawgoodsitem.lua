QinDrawGoodsItem = {};

QinDrawGoodsItem.__index = QinDrawGoodsItem;

local objs = {
    itemTF = { path = "Item", type = "Transform" },
    count = { path = "Count", type = "Text" },
    finishObj = { path = "finishObj", type = "GameObject" },
};

function QinDrawGoodsItem.New(prefab, parent)
    local self = {};
    setmetatable(self, QinDrawGoodsItem);
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    UITool.Parse(self.gameObject, self, objs);
    self.item = nil;
    return self;
end

function QinDrawGoodsItem:SetData(data)
    if (self.item == nil) then
        self.item = GoodsDataItem.New(self.itemTF);
        self.item.transform.localPosition = Vector3(-9, -3, 0);
    end
    local showItem = data.showReward;
    local itemData = table.Copy(ConfigMgr.Config.itemMap[showItem.id]);
    itemData.count0 = showItem.count;
    self.item:SetData(1, itemData, 1, false, Vector3(0.55, 0.55, 1), false);
    self.item:SetIconBg(false);
    self.count.text = data.count.."/"..data.totalCount;
    SetActive(self.finishObj,data.bFinish)
end

function QinDrawGoodsItem:Clear()
    if (self.item ~= nil) then
        self.item:Hide();
    end
end

function QinDrawGoodsItem:Destroy()
    if (self.item ~= nil) then
        self.item:Clear();
        self.item = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end