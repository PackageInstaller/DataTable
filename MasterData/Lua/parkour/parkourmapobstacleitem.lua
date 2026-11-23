ParkourMapObstacleItem = {};

ParkourMapObstacleItem.__index = ParkourMapObstacleItem;

local objs = {
    image = { path = "", type = "Image" },
    collider = { path = "", type = "ImageCollider" },
}

function ParkourMapObstacleItem.New(prefab, parent)
    local self = {};
    setmetatable(self, ParkourMapObstacleItem);
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    UITool.Parse(self.gameObject, self, objs);
    self.transform = self.gameObject:GetComponent("RectTransform");
    self.pos = Vector3(0, 0, 0);
    self.isLive = true;
    self.OnCollider = function(current, target)
        if (ParkourCharacter.IsInvincible()) then return end
        
        ParkourMap.SetSpeedStatus(true);
        ParkourCharacter.SubHp(1);
        ParkourMap.PlayAudio("DH_parkour_8");
    end
    self.collider.callback = self.OnCollider;
    return self;
end

function ParkourMapObstacleItem:SetData(data, resistType, x, y)
    self.data = data;
    self.gameObject.name = data.id;
    local resId = string.format("ui_hd_dh_pk_s%d_%s", resistType, data.id);
    self.image.sprite = LuaMgr.GetSprite("Parkour", resId);
    self.isLive = true;
    self.pos.x = x;
    self.pos.y = y;
    self.transform.localPosition = self.pos;
end

function ParkourMapObstacleItem:SetPosX(x)
    self.pos.x = x;
    self.transform.localPosition = self.pos;
end

function ParkourMapObstacleItem:Clear()
    self.data = nil;
    self.image.sprite = nil;
    self.pos.y = 3000;
    self.transform.localPosition = self.pos;
end

function ParkourMapObstacleItem:Destroy()
    self.pos = nil;
    self.collider.callback = nil;
    self.OnCollider = nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end