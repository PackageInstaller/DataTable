FoundationBuildingInteract = {};

FoundationBuildingInteract.__index = FoundationBuildingInteract;

local objs = {
    animator = { path = "container/Dormitory010_terrain14_22_p", type = "ModelAnimator" },
}

FoundationBuildingInteract.New = function(building)
    local self = {};
    setmetatable(self, FoundationBuildingInteract);
    print(building.group.gameObject.name);
    UITool.Parse(building.group.gameObject, self, objs);
    self.data = nil;
    self.onComplete = function(aniName)
        
    end
    return self;
end

function FoundationBuildingInteract:Play(data)
    self.data = data;
    self.animator:Play("ani_Dormitory010_terrain14_22", false, self.onComplete);
end

function FoundationBuildingInteract:Clear()
    self.data = nil;
end