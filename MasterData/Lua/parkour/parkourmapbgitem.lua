ParkourMapBgItem = {};

ParkourMapBgItem.__index = ParkourMapBgItem;

local objs = {
    image = { path = "", type = "RawImage" },
}

function ParkourMapBgItem.New(prefab, parent)
    local self = {};
    setmetatable(self, ParkourMapBgItem);
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    UITool.Parse(self.gameObject, self, objs);
    self.transform = self.gameObject:GetComponent("RectTransform");
    self.pos = Vector3(0, 0, 0);
    return self;
end

function ParkourMapBgItem:SetData(texture, x)
    self.image.texture = texture;
    self.pos.x = x;
    self.transform.localPosition = self.pos;
end

function ParkourMapBgItem:Move(ox)
    self.pos.x = self.pos.x - ox;
    self.transform.localPosition = self.pos;
end

function ParkourMapBgItem:Destroy()
    self.pos = nil;
    self.image.texture = nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end