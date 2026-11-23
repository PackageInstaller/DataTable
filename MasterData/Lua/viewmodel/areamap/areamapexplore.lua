AreaMapExplore = {};

AreaMapExplore.__index = AreaMapExplore;

local path = "Assets/_BundleResources/UI/Area/AreaMapExplore.prefab";

AreaMapExplore.New = function(parent)
    local self = {};
    setmetatable(self, AreaMapExplore);
    self.gameObject = LuaMgr.GetPrefab(path);
    if self.gameObject==nil then 
        return self
    end;
    self.transform = self.gameObject:GetComponent("RectTransform");
    LuaMgr.AddPrefabRefCount(path);
    self.transform:SetParent(parent, false);
    self.button = self.transform:GetComponent("Button");
    self.light = self.transform:Find("Light"):GetComponent("Image");
    self.iconTF = self.transform:Find("Icon"):GetComponent("RectTransform");
    self.icon = self.iconTF:GetComponent("Image");
    self.time = self.transform:Find("Time"):GetComponent("Text");
    self.currentArea = "";
    self.data = nil;
    self.OnClick = function()
        LuaMgr.ShowLuaPanel(UIName.AreaExploreResultViewModel, self.currentArea, self.data.exploreId);
        self:Goto();
    end
    self.Update=function ()
        if (self.data == nil or self.data.expireTime <= 0) then return end

        local t = self.data.expireTime - LuaMgr.Timestamp();
        if (t <= 0) then
            PlayerAreaMapMgr.RemoveCurrentExplore(self.currentArea, self.data.exploreId);
            self.time.text = "";
            LuaMgr.InvokeUIEventListeners(UIEventConst.AreaMapExploreChanged);
            return;
        end
        self.time.text = AreaMapSceneMgr.GetTimeDHM(t);
    end
    LuaMgr.AddClick(self.button, self.OnClick);
    LuaMgr.AddUpdate(self.Update);
    return self;
end

function AreaMapExplore:SetData(currentArea, data)
    if self.gameObject==nil then return end;
    self.currentArea = currentArea;
    self.data = data;
    local config = ConfigMgr.Config.areaEvents[data.eventId];
    if (config ~= nil) then
        local exploreConfig = ConfigMgr.Config.areaExplores[data.exploreId];
        local iconRes = "";
        if(config.type == 1) then
            iconRes = "ui_dc_qp_shu" .. exploreConfig.rare;
        elseif(config.type == 2) then
            iconRes = "ui_dc_qp_zd" .. exploreConfig.rare;
        elseif(config.type == 3) then
            iconRes = "ui_dc_qp_lw" .. exploreConfig.rare;
        end
        self.icon.sprite = LuaMgr.GetSprite("ExploreRes", iconRes);
        self.icon:SetNativeSize();
        self.light.sprite = LuaMgr.GetSprite("ExploreRes", "ui_dc_zb_g" .. exploreConfig.rare);
    end
    self.time.text = "";
    SetActive(self.gameObject, true);
end

function AreaMapExplore:Clear()
    self.data = nil;
    SetActive(self.gameObject, false);
    LuaMgr.RemoveUpdate(self.Update);
end

function AreaMapExplore:Destroy()
    LuaMgr.RemovePrefabRefCount(path);
    if (self.OnClick ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClick);
        self.OnClick = nil;
    end
    if (self.gameObject ~= nil) then
        LuaMgr.DestroyImmediateGO(self.gameObject);
        self.gameObject = nil;
    end
    LuaMgr.RemoveUpdate(self.Update);
end

function AreaMapExplore:Goto()
    if (self.data ~= nil) then
        AreaMapSceneMgr.SetBuildingId(tostring(self.data.posIndex));
    end
    LuaMgr.InvokeUIEventListeners(UIEventConst.AreaMapLookAt, self.transform);
end