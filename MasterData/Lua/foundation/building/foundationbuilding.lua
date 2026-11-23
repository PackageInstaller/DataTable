FoundationBuilding = {};

FoundationBuilding.__index = FoundationBuilding;

FoundationBuilding.New = function(bid, container)
    local self = {};
    setmetatable(self, FoundationBuilding);
    self.id = "";
    self.config = nil;
    self.bid = bid;
    self.x = 0;
    self.y = 0;
    self.angle = 0;
    self.gameObject = LuaMgr.GetPrefab(string.format("Assets/_BundleResources/Foundation/Building/%s.prefab", bid));
    self.transform = self.gameObject.transform;
    self.transform:SetParent(container, false);
    local videoTF = self.transform:Find("Video");
    if (videoTF ~= nil) then
        self.video = videoTF:GetComponent("UIVideoPlayer");
    end
    self.group = self.transform:Find("Group");
    self.groupPos = Vector3(0, 0, 0);
    self.groupDrag = false;
    self.buildOperate = nil;
    self.isExt = false;
    self.groupDelay = 0;
    self.groupUpdate = function()
        if (self.groupDrag) then
            if (os.time() > self.groupDelay) then
                if (self.config.FurnitureType == 3) then
                    if (self.isExt) then
                        self.groupPos.x = self.groupPos.x + 0.01;
                        if (self.groupPos.x >= 0.1) then
                            self.groupPos.x = 0.1;
                            LuaMgr.RemoveUpdate(self.groupUpdate);
                            self:BuildOperate();
                        end
                    else
                        self.groupPos.z = self.groupPos.z + 0.01;
                        if (self.groupPos.z >= 0.1) then
                            self.groupPos.z = 0.1;
                            LuaMgr.RemoveUpdate(self.groupUpdate);
                            self:BuildOperate();
                        end
                    end
                else
                    self.groupPos.y = self.groupPos.y + 0.01;
                    if (self.groupPos.y >= 0.1) then
                        self.groupPos.y = 0.1;
                        LuaMgr.RemoveUpdate(self.groupUpdate);
                        self:BuildOperate();
                    end
                end
            end
        else
            if (self.config.FurnitureType == 3) then
                if (self.isExt) then
                    self.groupPos.x = self.groupPos.x - 0.01;
                    if (self.groupPos.x <= 0) then
                        self.groupPos.x = 0;
                        LuaMgr.RemoveUpdate(self.groupUpdate);
                    end
                else
                    self.groupPos.z = self.groupPos.z - 0.01;
                    if (self.groupPos.z <= 0) then
                        self.groupPos.z = 0;
                        LuaMgr.RemoveUpdate(self.groupUpdate);
                    end
                end
            else
                self.groupPos.y = self.groupPos.y - 0.01;
                if (self.groupPos.y <= 0) then
                    self.groupPos.y = 0;
                    LuaMgr.RemoveUpdate(self.groupUpdate);
                end
            end
        end
        self.group.localPosition = self.groupPos;
    end
    self.occupy = nil;
    self.info = nil;
    self.effect = nil;
    self.upgrade = nil;
    return self;
end

function FoundationBuilding:SetData(id, config)
    self.id = id;
    self.config = config;
    self.gameObject.name = tostring(id);
    self.group.name = tostring(id);
end

function FoundationBuilding:SetInfo(info)
    self.info = info;
    self.info:SetData(self);
end

function FoundationBuilding:SetEffect(effect)
    self.effect = effect;
end

function FoundationBuilding:SetUpgrade(upgrade)
    self.upgrade = upgrade;
    if (PlayerFoundationMgr.IsUpLevel(self.config.Id)) then
        upgrade:SetData(2);
    else
        upgrade:SetData(0);
    end
end

function FoundationBuilding:SetPosition(x, y, ext)
    self.x = x;
    self.y = y;
    if (self.config ~= nil) then
        local furnitureType = self.config.FurnitureType;
        if (furnitureType == 1 or furnitureType == 2) then
            self.transform.localPosition = FoundationMgr.GetGridPos(x, y);
            return;
        elseif (furnitureType == 3) then
            if (ext ~= nil) then
                self.isExt = true;
                local pos = FoundationMgr.GetWall2GridPos(x, y);
                pos.x = pos.x + ext.offX;
                pos.z = pos.z + ext.offZ;
                self.transform.localPosition = pos;
                self.group.localRotation = UnityEngine.Quaternion.Euler(0, ext.angle, 0);
            else
                self.isExt = false;
                self.transform.localPosition = FoundationMgr.GetWallGridPos(x, y);
                self.group.localRotation = UnityEngine.Quaternion.Euler(0, 0, 0);
            end
            return;
        end
    end
    self.transform.localPosition = FoundationMgr.GetGridPos(x, y);
end

function FoundationBuilding:SetGroup(isDrag, buildOperate)
    if (self.groupDrag ~= isDrag) then
        self.groupPos.x = 0;
        self.groupPos.y = 0;
        self.groupPos.z = 0;
        LuaMgr.RemoveUpdate(self.groupUpdate);
        LuaMgr.AddUpdate(self.groupUpdate);
        self.groupDrag = isDrag;
        self.buildOperate = buildOperate;
        if (isDrag) then
            self:SetGroupDelay(os.time() + 0.2);
        end
    end
end

function FoundationBuilding:SetGroupDelay(delay)
    self.groupDelay = delay;
end

function FoundationBuilding:BuildOperate()
    local callback = self.buildOperate;
    self.buildOperate = nil;
    if (callback ~= nil) then
        callback(false);
    end
end

function FoundationBuilding:SetAngle(angle)
    self.angle = angle;
    if (angle == 90) then
        angle = -90;
    elseif (angle == 270) then
        angle = 90;
    end
    self.group.localRotation = UnityEngine.Quaternion.Euler(0, angle, 0);
end

function FoundationBuilding:PlayVideo()
    if (self.video ~= nil and not IsNullOrEmpty(self.config.Video)) then
        self.video:SetVolume(0);
        self.video:Load(self.config.Video);
    end
end

function FoundationBuilding:StopVideo()
    if (self.video ~= nil) then
        self.video:Stop();
    end
end

function FoundationBuilding:Clear()
    if (self.groupUpdate ~= nil) then
        LuaMgr.RemoveUpdate(self.groupUpdate);
        self.groupUpdate = nil;
    end
    self:StopVideo();
    self.video = nil;
    self.config = nil;
    self.occupy = nil;
    self.groupPos = nil;
    self.buildOperate = nil;
    if (self.info ~= nil) then
        self.info:Clear();
        self.info = nil;
    end
    if (self.effect ~= nil) then
        self.effect:Clear();
        self.effect = nil;
    end
    if (self.upgrade ~= nil) then
        self.upgrade:Clear();
        self.upgrade = nil;
    end
    if (self.gameObject ~= nil) then
        LuaMgr.DestroyImmediateGO(self.gameObject);
        self.transform = nil;
        self.gameObject = nil;
    end
end