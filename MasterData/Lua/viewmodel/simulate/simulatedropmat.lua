SimulateDropMat = {};

SimulateDropMat.__index = SimulateDropMat;

local objs={
    imgIcon={path="root/icon",type="Image"},
    txtName={path="root/name",type="Text"},
}

SimulateDropMat.New = function(container)
    local self = {};
    setmetatable(self, SimulateDropMat);
    self.prefabPath ="Assets/_BundleResources/UI/Simulate/DropMatItem.prefab";
    self.gameObject = LuaMgr.GetPrefab(self.prefabPath)
    LuaMgr.AddPrefabRefCount(self.prefabPath)
    self.transform=self.gameObject.transform;
    self.transform:SetParent(container, false);
    self.transform.localPosition=Vector3.zero;
    self.transform.localScale=Vector3.one;
    UITool.Parse(self.gameObject, self, objs);
    return self;
end
function SimulateDropMat:SetPosition(pos)
    self.transform.localPosition=pos;
end

function SimulateDropMat:DODrop(dropY)
    self.transform.localPosition=self.transform.localPosition-Vector3(0,dropY,0)
end

function SimulateDropMat:SetScale(scale)
    self.transform.localScale=Vector3.one*scale;
end


function SimulateDropMat:SetData(id)
    local matConfig=ConfigMgr.Config.SimulateCatchMaterialMap[id];
    if matConfig==nil then
        LuaDebug.error("matConfig is nil")
    end
    self.imgIcon.sprite=LuaMgr.GetSprite("Simulate",matConfig.Icon);

end

function SimulateDropMat:Clear()
    self.data=nil;
end

function SimulateDropMat:Destroy()
    if not IsNullOrEmpty(self.prefabPath) then
        LuaMgr.RemovePrefabRefCount(self.prefabPath)
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
end 