




UICollectorBuildingItem = {}
UICollectorBuildingItem.__index = UICollectorBuildingItem
require("CollectorPractice/Common/UICollectorBuildingTipsItem")
local PREFAB_PATH = "Assets/_BundleResources/UI/CollectorPractice/UICollectorBuildingItem.prefab";

function UICollectorBuildingItem.New(parent,tipsParent)
    local self = {}
    setmetatable(self, UICollectorBuildingItem)
    self.gameObject = LuaMgr.GetPrefab(PREFAB_PATH)
    LuaMgr.AddPrefabRefCount(PREFAB_PATH);
    self.transform = self.gameObject:GetComponent("RectTransform")
    self.transform:SetParent(parent);
    self.transform.localRotation = Quaternion.Euler(0, 0, 0);
    local uiLink = self.gameObject:GetComponent("UILink");
    self.rawImage = uiLink:Get("rawImage"):GetComponent("RawImage");
    self.startMaterial=self.rawImage.material;
    self.goSugguestionLevel = uiLink:Get("goSugguestionLevel");
    self.textLevel = uiLink:Get("textLevel"):GetComponent("Text");
    self.animationCo = nil;











    uiLink:AddClickEvent("btnClick", function()
        if self.fun ~= nil then
            self.fun(self.allIndex, self.columnIndex);
        end
    end)
    return self
end

function UICollectorBuildingItem:Destroy()
    if self.gameObject ~= nil then
        LuaMgr.RemovePrefabRefCount(PREFAB_PATH);
        LuaMgr.DestroyImmediateGO(self.gameObject);
        self.gameObject = nil
        self.transform = nil
        self.rawImage = nil;
        self.btnClick = nil;
        self.goSugguestionLevel = nil;
        self.textLevel = nil;










    end
end

function UICollectorBuildingItem:SetData(index, cIndex, tabId, pos, fun)
    self.allIndex = index;
    self.columnIndex = cIndex;
    self.fun = fun;
    self.pos = pos;
    self.internEventKV = ConfigMgr.Config.InternEventKV[tabId];
    if self.internEventKV.EventType==21 then
        SetActive(self.goSugguestionLevel,true);
        self.textLevel.text=LuaMgr.GetLangText(self.internEventKV.LevelShowLan);
    else
        SetActive(self.goSugguestionLevel,false);
    end



    self.transform.localPosition = Vector3.zero;
    self.transform.anchoredPosition = Vector2(pos[1], pos[2]);
    self.transform.localScale = Vector3(0.8, 0.8, 0.8);
    self.rawImage.texture = LuaMgr.GetTexture(string.format("Images/CollectorBuilding/%s.png", self.internEventKV.Model));




































end

function UICollectorBuildingItem:FirstAnimation()
    local mat = self.startMaterial;
    local tempMat = GameObject.Instantiate(mat)
    if self.animationCo~=nil then
        local destroyMat=self.rawImage.material;
        LuaMgr.Destroy(destroyMat)
       coroutine_runner.stop(self.animationCo);
       self.animationCo=nil;
    end
    self.rawImage.material = tempMat;
self.animationCo = coroutine_runner.start(function()
        tempMat:SetFloat("_ShowID", 0);
        for i = 1, 7, 1 do
            coroutine_runner.wait(0.05)
            tempMat:SetFloat("_ShowID", i);
        end
        self.rawImage.material = mat;
        LuaMgr.Destroy(tempMat)
        self.animationCo=nil;
    end)
end


function UICollectorBuildingItem:Clear()
    self.data = nil
    SetActive(self.gameObject, false)

end

function UICollectorBuildingItem:Hide()
    SetActive(self.gameObject, false)

end