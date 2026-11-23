FoundationQuickSetItem = {};

FoundationQuickSetItem.__index = FoundationQuickSetItem;

local objs = {
    name = { path = "Name", type = "Text" },
    pic = { path = "Pic", type = "RawImage" },
    count = { path = "Count/Text", type = "Text" },
}

function FoundationQuickSetItem.New(prefab, parent)
    local self = {};
    setmetatable(self, FoundationQuickSetItem);
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    UITool.Parse(self.gameObject, self, objs);
    self.transform = self.gameObject:GetComponent("RectTransform");
    LuaMgr.SetFont(self.transform);
    return self;
end

function FoundationQuickSetItem:SetData(data)
    self.data = data;
    local furniture = ConfigFoundationMgr.GetInteractionById(data.Furniture);
    if (furniture ~= nil) then
        self.pic.texture = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/ItemIcons/%s", furniture.Icon));
        local count, putCount = FoundationMgr.GetThemeFurniturePutCount(data.Room, data.Furniture);
        self.count.text = string.format("%d/%d", count, putCount);
        self.name.text = LuaMgr.GetLangText(furniture.NameLan);
    end
    SetActive(self.gameObject, true);
end

function FoundationQuickSetItem:Clear()
    self.data = nil;
    self.pic.texture = nil;
    SetActive(self.gameObject, false);
end

function FoundationQuickSetItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end