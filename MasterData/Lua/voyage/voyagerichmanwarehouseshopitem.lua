VoyageRichManWarehouseShopItem = {};

VoyageRichManWarehouseShopItem.__index = VoyageRichManWarehouseShopItem;

local objs = {
    icon = { path = "Group/Icon", type = "RawImage" },
    num = { path = "Group/Num/Text", type = "Text" },
};

function VoyageRichManWarehouseShopItem.New()
    local self = {};
    setmetatable(self, VoyageRichManWarehouseShopItem);
    return self;
end

function VoyageRichManWarehouseShopItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function VoyageRichManWarehouseShopItem:SetData(data)
    self.data = data.data;
    self.icon.texture = GetItemTexture(self.data.id);
    self.num.text = tostring(self.data.count);
end

function VoyageRichManWarehouseShopItem:Clear()
    self.data = nil;
    self.icon.texture = nil;
end

function VoyageRichManWarehouseShopItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end