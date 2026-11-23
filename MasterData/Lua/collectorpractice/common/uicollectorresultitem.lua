




UICollectorResultItem = {}
UICollectorResultItem.__index = UICollectorResultItem
local PREFAB_PATH = "Assets/_BundleResources/UI/CollectorPractice/UICollectorResultItem.prefab";

function UICollectorResultItem.New(parent)
    local self = {}
    setmetatable(self, UICollectorResultItem)
    self.gameObject = LuaMgr.GetPrefab(PREFAB_PATH)
    LuaMgr.AddPrefabRefCount(PREFAB_PATH);
    self.transform = self.gameObject:GetComponent("RectTransform")
    self.transform:SetParent(parent);
    self.transform.localScale=Vector3.one;
    self.transform.localPosition=Vector3.zero;
    self.transform.anchoredPosition=Vector2.zero;
    local uiLink = self.gameObject:GetComponent("UILink");
    self.imgRare = uiLink:Get("imgRare"):GetComponent("Image");
    self.rawImage = uiLink:Get("rawImage"):GetComponent("RawImage");
    self.goBg = uiLink:Get("goBg");
    self.textCount = uiLink:Get("textCount"):GetComponent("Text");
    return self
end

function UICollectorResultItem:Destroy()
    if self.gameObject~=nil then
        LuaMgr.RemovePrefabRefCount(PREFAB_PATH);
        LuaMgr.DestroyImmediateGO(self.gameObject);
        self.gameObject = nil
        self.transform = nil
        self.imgRare = nil;
        self.rawImage = nil;
        self.goBg = nil;
        self.textCount = nil;
    end
end

function UICollectorResultItem:SetData(data)
    local itemRare = ConfigMgr.Config.itemMap[data.id].rare

    if itemRare==nil then
        print("itemRare   is null : "..data.id)
        return;
    end
    
    self.imgRare.sprite=ActivityMgr.GetRareSprite(itemRare);
    self.rawImage.texture = ActivityMgr.GetItemTexture(data.id);
    SetActive( self.goBg.gameObject,true);
    self.textCount.text= tostring(data.count);
end

function UICollectorResultItem:Clear()
    self.data = nil
    SetActive(self.gameObject, false)
end

