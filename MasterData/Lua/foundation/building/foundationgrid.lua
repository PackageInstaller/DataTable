FoundationGrid = {};

FoundationGrid.__index = FoundationGrid;

local rotation = UnityEngine.Quaternion.Euler(Vector3(90, 0, 0))
local rotation2 = UnityEngine.Quaternion.Euler(Vector3(90, 90, 0))
local rotation90 = UnityEngine.Quaternion.Euler(Vector3(0, 0, 0))

FoundationGrid.New = function(container, gridSize)
    local self = {};
    setmetatable(self, FoundationGrid);
    self.gameObject = LuaMgr.GetPrefab("Assets/_BundleResources/Foundation/FoundationGrid.prefab");
    self.transform = self.gameObject.transform;
    self.transform:SetParent(container, false);
	local size = gridSize * 2+0.02;
    self.transform.localScale = Vector3(size, size, size);
    self.renderer = self.gameObject:GetComponent("Renderer");
    return self;
end

function FoundationGrid:SetData(key, x, y, type, ext)
    self.gameObject.name = key;
if (type == 1 or type == 2) then
        self.transform.localPosition = FoundationMgr.GetGridPos(x, y);
        self.transform.localRotation = rotation90;
elseif (type == 3 or type == 4) then
        if (ext ~= nil) then
            local pos = FoundationMgr.GetWall2GridPos(x, y);
            pos.x = pos.x + ext.offX;
            pos.z = pos.z + ext.offZ;
            self.transform.localPosition = pos;
            self.transform.localRotation = rotation2;
        else
            self.transform.localPosition = FoundationMgr.GetWallGridPos(x, y);
            self.transform.localRotation = rotation;
        end
    end
    self:SetActive(true);
end

function FoundationGrid:SetMaterial(material)
    self.renderer.sharedMaterial = material;
end

function FoundationGrid:SetActive(active)
    if (self.gameObject.activeSelf ~= active) then
        self.gameObject:SetActive(active);
    end
end

function FoundationGrid:Clear()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.transform = nil;
    self.gameObject = nil;
end