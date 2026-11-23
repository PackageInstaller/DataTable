VoyageRichManArrow = {};

VoyageRichManArrow.__index = VoyageRichManArrow;

VoyageRichManArrow.New = function(container, index)
    local self = {};
    setmetatable(self, VoyageRichManArrow);
    local resId = index == 1 and "HH_terrain02_09_p" or "HH_terrain02_10_p";
    self.gameObject = LuaMgr.GetPrefab("Assets/_BundleResources/Voyage/" .. resId ..".prefab");
    self.transform = self.gameObject.transform;
    self.transform:SetParent(container, false);
    self.arrowTF = self.transform:Find("Arrow");
    return self;
end

function VoyageRichManArrow:SetData(data)
    self.arrowTF.name = "Arrow_" .. data.id;
    self.transform.localPosition = data.endGrid.pos;
    local p = data.startGrid.pos - data.endGrid.pos;
    self.transform.localRotation = Quaternion.LookRotation(p.normalized);
    SetActive(self.gameObject, true);
end

function VoyageRichManArrow:Clear()
    SetActive(self.gameObject, false);
end

function VoyageRichManArrow:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.transform = nil;
    self.gameObject = nil;
end