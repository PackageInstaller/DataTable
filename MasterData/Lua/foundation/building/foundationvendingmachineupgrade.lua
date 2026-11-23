FoundationVendingMachineUpgrade = {};

FoundationVendingMachineUpgrade.__index = FoundationVendingMachineUpgrade;

local objs = {
    animator = { path = "animation", type = "ModelAnimator" },
    endGO = { path = "animation/eff/UpgradeEffect/End", type = "GameObject" },
}

FoundationVendingMachineUpgrade.New = function(building)
    local self = {};
    setmetatable(self, FoundationVendingMachineUpgrade);
    UITool.Parse(building.group.gameObject, self, objs);
    self.data = nil;
    self.onBeginComplete = function(aniName)
        self.animator:Stop();
        self:SetData(2);
    end
    self.onEndComplete = function(aniName)
        self.animator:Stop();
        SetActive(self.endGO, false);
    end
    return self;
end

function FoundationVendingMachineUpgrade:SetData(data)
    if (self.data == data) then return end
    
    self.data = data;
    if (data == 0) then
        self.animator:Stop();
    elseif (data == 1) then
        self.animator:Play("ani_Bulding30201_UpgradeBegin", false, self.onBeginComplete);
    elseif (data == 2) then
        self.animator:Play("ani_Bulding30201_Upgrade", true, nil);
    elseif (data == 3) then
        self.animator:Play("ani_Bulding30201_UpgradeBeginEnd", false, self.onEndComplete);
    end
end

function FoundationVendingMachineUpgrade:Clear()
    self.data = nil;
    self.animator:Stop();
    SetActive(self.endGO, false);
end