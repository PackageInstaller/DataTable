UICollectorPracticeTag = {}
UICollectorPracticeTag.__index = UICollectorPracticeTag
local PREFAB_PATH = "Assets/_BundleResources/UI/CollectorPractice/UICollectorPracticeTag.prefab";

function UICollectorPracticeTag.New(parent)
    local self = {}
    setmetatable(self, UICollectorPracticeTag)
    self.gameObject =  LuaMgr.GetPrefab(PREFAB_PATH)
    LuaMgr.AddPrefabRefCount(PREFAB_PATH);
    self.transform = self.gameObject:GetComponent("RectTransform")
    self.transform:SetParent(parent);
    self.transform.localScale =Vector3(1,1,1);
    self.transform.localPosition=Vector3.zero;
    self.transform.anchoredPosition=Vector2.zero;
    local uiLink = self.gameObject:GetComponent("UILink");
    self.goSelect = uiLink:Get("goSelect");
    self.goUnselect = uiLink:Get("goUnselect");
    self.redPoint=self.gameObject:GetComponent("RedIconListener");
    uiLink:AddClickEvent("goUnselect",function()
        if  self.fun~=nil then
            self.fun(self.data);
        end
    end)
    
    return self
end

function UICollectorPracticeTag:Destroy()
    if self.gameObject~=nil then
        LuaMgr.RemovePrefabRefCount(PREFAB_PATH);
        LuaMgr.DestroyImmediateGO(self.gameObject);
        self.gameObject = nil
        self.transform = nil
        self.goSelect = nil;
        self.goUnselect = nil;
    end
end

function UICollectorPracticeTag:Select(select)
    SetActive( self.goSelect,select);
    SetActive( self.goUnselect, not select);
end

function UICollectorPracticeTag:SetData(keys,select,fun)
    self.data=keys;
    self.redPoint.RedId="1219_"..tostring(keys);
    self.fun=fun;
    self.goSelect:GetComponent("Image").sprite = LuaMgr.GetSprite("CollectorGalleryTag",
    keys .. "_01");
    self.goUnselect:GetComponent("Image").sprite = LuaMgr.GetSprite("CollectorGalleryTag",
    keys .. "_02");
    SetActive( self.goSelect,select);
    SetActive( self.goUnselect, not select);
end


function UICollectorPracticeTag:Clear()
    self.data = nil
    SetActive(self.gameObject, false)
end