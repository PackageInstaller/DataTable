ParkourMapItemItem = {};

ParkourMapItemItem.__index = ParkourMapItemItem;

local objs = {
    image = { path = "", type = "Image" },
    collider = { path = "", type = "ImageCollider" },
}

function ParkourMapItemItem.New(prefab, parent)
    local self = {};
    setmetatable(self, ParkourMapItemItem);
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    UITool.Parse(self.gameObject, self, objs);
    self.transform = self.gameObject:GetComponent("RectTransform");
    self.pos = Vector3(0, 0, 0);
    self.isLive = true;
    self.target = nil;
    self.startTime = 0;
    self.endTime = 0;
    self.isMove = false;
    self.isFadeOut = false;
    self.fadeColor = UnityEngine.Color(1,1,1,1);
    self.fadeAngle = 0;
    self.moveToPos = nil;
    self.OnCollider = function(current, target)
        if (current == ParkourMapItem.Coins1) then
            ParkourCharacter.AddScore(current);
            ParkourMap.PlayAudio("DH_parkour_1");
            self:MoveTo(-100, 50);
            return;
        elseif (current == ParkourMapItem.Coins2) then
            ParkourCharacter.AddScore(current);
            ParkourMap.PlayAudio("DH_parkour_1");
            self:MoveTo(-100, 50);
            return;
        end
        self.isLive = false;
        if (current == ParkourMapItem.Box) then
            ParkourCharacter.AddScore(current);
            ParkourMap.PlayAudio("DH_parkour_1");
        elseif (current == ParkourMapItem.SpeedUp) then
            ParkourCharacter.SpeedUp();
            ParkourCharacter.Invincible();
            ParkourMap.PlayAudio("DH_parkour_2");
        elseif (current == ParkourMapItem.AddHp) then
            ParkourCharacter.AddHp(1);
            ParkourMap.PlayAudio("DH_parkour_4");
        elseif (current == ParkourMapItem.Invincible) then
            ParkourCharacter.Invincible();
            ParkourMap.PlayAudio("DH_parkour_3");
        elseif (current == ParkourMapItem.Magnet) then
            ParkourCharacter.Magnet();
            ParkourMap.PlayAudio("DH_parkour_5");
        end
    end
    self.collider.callback = self.OnCollider;
    return self;
end

function ParkourMapItemItem:SetData(data, x, y)
    self.data = data;
    self.gameObject.name = data.id;
    self.isLive = true;
    self.isMove = false;
    self.isFadeOut = false;
    self.pos.x = x;
    self.pos.y = y;
    self.transform.localPosition = self.pos;
    self.fadeColor.a = 1.0;
    self.image.color = self.fadeColor;
    self.fadeAngle = 0;
    self.transform.localRotation = Quaternion.Euler(0, self.fadeAngle, 0);
end

function ParkourMapItemItem:IsBox()
    return self.data ~= nil and self.data.id == "MapBox1";
end

function ParkourMapItemItem:SetPosX(x)
    self.pos.x = x;
    self.transform.localPosition = self.pos;
end

function ParkourMapItemItem:Move(target, force)
    local p = self.pos - target.localPosition;
    local distance = p.magnitude;
    if (force) then
        if (distance <= ConfigMgr.Config.DHConstants.ParkourAdsorbRange) then
            self.target = target;
            self.startTime = ParkourMap.TimestampMS();
            self.endTime = self.startTime + distance * 0.003;
            self.isMove = true;
        end
    else
        if (distance <= ConfigMgr.Config.DHConstants.ParkourAdsorbRange2) then
            self.target = target;
            self.startTime = ParkourMap.TimestampMS();
            self.endTime = self.startTime + distance * 0.003;
            self.isMove = true;
        end
    end
end

function ParkourMapItemItem:OnMove()
    local time = ParkourMap.TimestampMS();
    if (time < self.endTime) then
        local pos = self.transform.localPosition;
        local p;
        if (self.target ~= nil) then
            p = pos - self.target.localPosition;
        else
            p = pos - self.moveToPos;
        end
        local moveDistance = (time - self.startTime) / (self.endTime - self.startTime) * p.magnitude;
        pos = pos - p.normalized * moveDistance;
        if (pos.x > 10000 or pos.x < -10000 or pos.y > 10000 or pos.y < -10000) then
            pos.y = 3000;
        end
        self.transform.localPosition = pos;
    else
        if (self.target ~= nil) then
            self.transform.localPosition = self.target.localPosition;
            self.target = nil;
        end
        if (self.moveToPos ~= nil) then
            self.transform.localPosition = self.moveToPos;
            self.moveToPos = nil;
        end
        self.isMove = false;
        if (self.data.id == ParkourMapItem.Coins1 or self.data.id == ParkourMapItem.Coins2) then
            self.isFadeOut = true;
            self.fadeColor.a = 1.0;
        else
            self.isLive = false;
        end
    end
end

function ParkourMapItemItem:MoveTo(offX, offY)
    self.startTime = ParkourMap.TimestampMS();
    self.endTime = self.startTime + 0.01;
    self.moveToPos = self.transform.localPosition;
    self.moveToPos.x = self.moveToPos.x + offX;
    self.moveToPos.y = self.moveToPos.y + offY;
    self.isMove = true;
    self.target = nil;
end

function ParkourMapItemItem:OnFadeOut()
    local pos = self.transform.localPosition;
    local alpha = self.fadeColor.a - 0.05;
    self.fadeColor.a = alpha;
    self.image.color = self.fadeColor;
    pos.x = pos.x - 5;
    pos.y = pos.y + 5;
    self.transform.localPosition = pos;
    self.fadeAngle = self.fadeAngle + 15;
    self.transform.localRotation = Quaternion.Euler(0, self.fadeAngle, 0);
    if (self.fadeAngle > 180) then
        self.isLive = false;
    end
end

function ParkourMapItemItem:Clear()
    self.data = nil;
    self.pos.y = 3000;
    self.transform.localPosition = self.pos;
end

function ParkourMapItemItem:Destroy()
    self.pos = nil;
    self.collider.callback = nil;
    self.OnCollider = nil;
    self.fadeColor = nil;
    self.moveToPos = nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end