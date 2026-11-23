GuoBaoBuilding = {};

GuoBaoBuilding.__index = GuoBaoBuilding;

GuoBaoBuilding.New = function(bid, container)
    local self = {};
    setmetatable(self, GuoBaoBuilding);
    local simulatedShopData = PlayerGuoBaoMgr.GetSimulatedShop(bid);
    if (simulatedShopData ~= nil) then
        self.config  = ConfigMgr.Config.SimulatedShopMap[simulatedShopData.id];
    else
        self.config = ConfigGuoBaoMgr.GetSimulatedShop(bid, 1);
    end
    self.gameObject = LuaMgr.GetPrefab(string.format("Assets/_BundleResources/GuoBao/%s.prefab", self.config.Model));
    self.transform = self.gameObject.transform;
    self.transform:SetParent(container, false);
    self.group = self.transform:Find("Group");
    self.effect = nil;
    self.effectTime = 0;
    return self;
end

function GuoBaoBuilding:SetData()
    self.gameObject.name = tostring(self.config.ID);
    self.group.name = tostring(self.config.ID);
    local pos = self.config.Pos;
    self.transform.localPosition = Vector3(pos[1], pos[2], pos[3]);
end

function GuoBaoBuilding:UpgradeEffect()
    self.effect = LuaMgr.GetPrefab("Assets/_BundleResources/GuoBao/GuoBaoShengji.prefab");
    self.effect.transform:SetParent(self.group, false);
    self.effectTime = os.time() + 3;
end

function GuoBaoBuilding:ClearEffect()
    self.effectTime = 0;
    if (self.effect ~= nil) then
        LuaMgr.DestroyImmediateGO(self.effect);
        self.effect = nil;
    end
end

function GuoBaoBuilding:CheckEffect()
    if (self.effectTime > 0 and os.time() > self.effectTime) then
        self:ClearEffect();
    end
end

function GuoBaoBuilding:Destroy()
    self.config = nil;
    self:ClearEffect();
    if (self.gameObject ~= nil) then
        LuaMgr.DestroyImmediateGO(self.gameObject);
        self.transform = nil;
        self.gameObject = nil;
    end
end