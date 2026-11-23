
UIShopTagPropItem = {}
UIShopTagPropItem.__index = UIShopTagPropItem


function UIShopTagPropItem.New(prefab, parent)
    local self = {}
    setmetatable(self, UIShopTagPropItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    self.transform = self.gameObject:GetComponent("RectTransform")
    local uiLink = self.gameObject:GetComponent("UILink");
    self.goTagPropLight = uiLink:Get("goTagPropLight");
    self.goTagPropDark = uiLink:Get("goTagPropDark");
    self.textTagLightName = uiLink:Get("textTagLightName"):GetComponent("Text");
    self.textTagDarkName = uiLink:Get("textTagDarkName"):GetComponent("Text");
    self.fun=nil;
    self.tabId=nil;
    uiLink:AddClickEvent("goTagPropDark", function()
        if self.fun ~= nil then
            self.fun(self.tabId);
        end
    end)
    return self
end

function UIShopTagPropItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil
    self.transform = nil
    self.goTagPropLight = nil;
    self.goTagPropDark = nil;
    self.textTagLightName = nil;
    self.textTagDarkName = nil;
end

function UIShopTagPropItem:SetSelect(Select)
    SetActive(self.goTagPropLight,Select);
    SetActive(self.goTagPropDark,not Select);
end

function UIShopTagPropItem:SetData(tabId,ClickFun)
    self.tabId=tabId;
    self.fun=ClickFun;
    self.textTagDarkName.text=LuaMgr.GetLangText(ConfigMgr.Config.RandShopMap[tabId].Namelan);
    self.textTagLightName.text=LuaMgr.GetLangText(ConfigMgr.Config.RandShopMap[tabId].Namelan);
end

function UIShopTagPropItem:Hide()
    SetActive(self.gameObject, false)
end