GuideTeachGoodsItem = {};

GuideTeachGoodsItem.__index = GuideTeachGoodsItem;

local objs = {
    itemTF = { path = "", type = "Transform" },
}

function GuideTeachGoodsItem.New()
    local self = {};
    setmetatable(self, GuideTeachGoodsItem);
    return self;
end

function GuideTeachGoodsItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.item = nil;
end

function GuideTeachGoodsItem:SetData(data)
    self:SetItem(data.data);
end

function GuideTeachGoodsItem:SetItem(data)
    if (self.item == nil) then
        self.item = GoodsDataItem.New(self.itemTF);
        self.item.transform.localPosition = Vector3(-3, -3, 0);
    end
    local itemData = table.Copy(ConfigItemMgr.GetItemById(data.id));
    itemData.count0 = data.count;
    self.item:SetData(1, itemData, 1, false, Vector3(0.8, 0.8, 0.8));
end

function GuideTeachGoodsItem:Clear()
    if (self.item ~= nil) then
        self.item:Hide();
    end
end

function GuideTeachGoodsItem:Destroy()
    if (self.item ~= nil) then
        self.item:Clear();
        self.item = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end