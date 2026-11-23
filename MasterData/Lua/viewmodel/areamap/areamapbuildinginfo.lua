AreaMapBuildingInfo = {};

AreaMapBuildingInfo.__index = AreaMapBuildingInfo;

local objs = {
    nameGO = { path = "Name", type = "GameObject" },
    nameImg = { path = "Name", type = "Image" },
    suoTF = { path = "suo", type = "RectTransform" },
    suoLock = { path = "suo/Lock", type = "GameObject" },
    suoUnlockFx = { path = "suo/UnlockFx", type = "GameObject" },
    newGO = { path = "New", type = "GameObject" },
    dotGO = { path = "Dot", type = "GameObject" },
    clearGO = { path = "Clear", type = "GameObject" },
    completeGO = { path = "Complete", type = "GameObject" },
    flagGO = { path = "Flag", type = "GameObject" },
}

AreaMapBuildingInfo.New = function(prefab, parent)
    local self = {};
    setmetatable(self, AreaMapBuildingInfo);
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    self.transform = self.gameObject.transform;
    UITool.Parse(self.gameObject, self, objs);
    self.atlasName = "";
    return self;
end

function AreaMapBuildingInfo:Clear()
    SetActive(self.nameGO, false);
    SetActive(self.suoLock, false);
    SetActive(self.suoUnlockFx, false);
    SetActive(self.newGO, false);
    SetActive(self.dotGO, false);
    SetActive(self.clearGO, false);
    SetActive(self.completeGO, false);
    SetActive(self.flagGO, false);
end

function AreaMapBuildingInfo:Destroy()
    if (self.gameObject ~= nil) then
        LuaMgr.DestroyImmediateGO(self.gameObject);
        self.gameObject = nil;
    end
end 