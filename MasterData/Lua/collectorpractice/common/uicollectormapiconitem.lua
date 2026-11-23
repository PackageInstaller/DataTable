
UICollectorMapIconItem = {}
UICollectorMapIconItem.__index = UICollectorMapIconItem
function UICollectorMapIconItem.New(prefab, parent)
    local self = {}
    setmetatable(self, UICollectorMapIconItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    self.transform = self.gameObject:GetComponent("RectTransform")
    local uiLink = self.gameObject:GetComponent("UILink");
    self.btnClickMapIcon = uiLink:Get("btnClickMapIcon"):GetComponent("Button");
    self.goIsSelected = uiLink:Get("goIsSelected");
    self.goLock = uiLink:Get("goLock");
    self.imgMapIcon=uiLink:Get("imgMapIcon"):GetComponent("Image")
    self.textMapIcon=uiLink:Get("textMapIcon"):GetComponent("Text");
    self.redPoint=uiLink:Get("goGroup"):GetComponent("RedIconListener");
    self.mapId = nil;
    self.fun = nil;
    self.isLock=false;
    uiLink:AddClickEvent("btnClickMapIcon", function()
        if self.fun ~= nil and (not self.isLock) then
            self.fun(self,false);
        end
    end)
    return self
end

function UICollectorMapIconItem:SetData(mapId, ClickFun)
    SetActive(self.gameObject, true)
    self.mapId = mapId;
    if self.mapId == "Unknow" then
        SetActive(self.goLock, true);
        self.isLock=true;
        self.imgMapIcon.sprite =LuaMgr.GetSprite("CollectorMapIcon", "ui_sx_ztxz_zt_Unknow");
        self.textMapIcon.text=ConfigMgr.LangGlobal("7206")
    else
        self.redPoint.RedId="1221_"..tostring(mapId);
        if CollectorPracticeAllMgr.IsMapOpen(mapId) then
            SetActive(self.goLock, false);
            self.isLock=false;
        else
            SetActive(self.goLock, true);
            self.isLock=true;
        end
        self.imgMapIcon.sprite =LuaMgr.GetSprite("CollectorMapIcon", "ui_sx_ztxz_zt_"..self.mapId);
        self.textMapIcon.text=LuaMgr.GetLangText(ConfigMgr.Config.PracticePeriodMaps[mapId].mapnamelan);
    end
    self.fun = ClickFun;
end

function UICollectorMapIconItem:SetSelect(Select)
    SetActive(self.goIsSelected, Select);
end

function UICollectorMapIconItem:Hide()
    SetActive(self.gameObject, false)
end

function UICollectorMapIconItem:Destroy()
    self.gameObject = nil
    self.transform = nil
    self.btnClickMapIcon = nil;
    self.goIsSelected = nil;
    self.goLock = nil;
    self.mapId = nil;
    self.fun = nil;
    self.textMapIcon=nil;
    self.redPoint=nil;
end