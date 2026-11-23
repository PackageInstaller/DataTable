




UI2048Grid = {}
UI2048Grid.__index = UI2048Grid
local PREFAB_PATH = "Assets/_BundleResources/UI/MiniGames/UI2048Grid.prefab";

function UI2048Grid.New(parent)
    local self = {}
    setmetatable(self, UI2048Grid)
    self.gameObject = LuaMgr.GetPrefab(PREFAB_PATH)
    LuaMgr.AddPrefabRefCount(PREFAB_PATH);
    self.transform = self.gameObject:GetComponent("RectTransform")
    self.transform:SetParent(parent);
    self.transform.localScale=Vector3.one;
    self.transform.localPosition=Vector3.zero;
    self.transform.anchoredPosition=Vector2.zero;
    local uiLink = self.gameObject:GetComponent("UILink");
    self.UI2048Grid = uiLink:Get("UI2048Grid");
    self.numberObj=nil;
    
    return self
end

function UI2048Grid:Destroy()
    if self.gameObject~=nil then
        LuaMgr.RemovePrefabRefCount(PREFAB_PATH);
        LuaMgr.DestroyImmediateGO(self.gameObject);
        self.gameObject = nil
        self.transform = nil
        self.UI2048Grid = nil;
    end
end


function UI2048Grid:IsHaveNumberObj()
    return self.numberObj ~= nil
end
    

function UI2048Grid:GetNumberObj()
    return self.numberObj;
end

function UI2048Grid:SetNumberObj(numberObj)
self.numberObj = numberObj;
end

function UI2048Grid:Clear()
    self:OnRecover();
    SetActive(self.gameObject, false)
end

function UI2048Grid:OnRecover()
    if self.numberObj~=nil then
        self.numberObj:OnRecover()
    end 
    
    self.numberObj = nil
end