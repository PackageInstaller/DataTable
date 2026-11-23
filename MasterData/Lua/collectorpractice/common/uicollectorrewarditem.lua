




UICollectorRewardItem = {}
UICollectorRewardItem.__index = UICollectorRewardItem
local PREFAB_PATH = "Assets/_BundleResources/UI/CollectorPractice/UICollectorRewardItem.prefab";

function UICollectorRewardItem.New(parent,scale)
    local self = {}
    setmetatable(self, UICollectorRewardItem)
    self.gameObject = LuaMgr.GetPrefab(PREFAB_PATH)
    LuaMgr.AddPrefabRefCount(PREFAB_PATH);
    self.transform = self.gameObject:GetComponent("RectTransform")
    self.transform:SetParent(parent);
    self.transform.localScale=scale;
    self.transform.localPosition=Vector3.zero;
    self.transform.anchoredPosition=Vector2.zero;
    local uiLink = self.gameObject:GetComponent("UILink");
    self.rawImage = uiLink:Get("rawImage"):GetComponent("RawImage");
    self.textCount = uiLink:Get("textCount"):GetComponent("Text");
    self.goSelect = uiLink:Get("goSelect");

    uiLink:AddClickEvent("btnClick", function()
        if self.fun~=nil then
            self:SetSelect(false);
            self.fun(self.data1, self.data2,self.data3)
        end
    end)
    
    return self
end

function UICollectorRewardItem:Destroy()
    if self.gameObject~=nil then
        LuaMgr.RemovePrefabRefCount(PREFAB_PATH);
        LuaMgr.DestroyImmediateGO(self.gameObject);
        self.gameObject = nil
        self.transform = nil
        self.btnBg = nil;
        self.rawImage = nil;
        self.textCount = nil;
        self.goSelect = nil;
    end
end

function UICollectorRewardItem:SetData(index,id,count,fun,icon)
    self.data1=index;
    self.data2=id;
    self.data3=count;
    self.fun=fun;
    self.textCount.text = tostring(count);
    local texture=GetItemTexture(id);
    if IsObjectNull(texture) then
        self.rawImage.texture = GetItemTexture(icon)
    else
        self.rawImage.texture = GetItemTexture(id)
    end
    self:SetSelect(false)
end

function UICollectorRewardItem:SetSelect(isShow)
    SetActive(self.goSelect.gameObject,isShow);
end

function UICollectorRewardItem:Clear()
    self.data = nil
    SetActive(self.gameObject, false)
end

