FoundationThemeItem = {};

FoundationThemeItem.__index = FoundationThemeItem;

local objs = {
    button = { path = "", type = "Button" },
    pic = { path = "Pic", type = "RawImage" },
    count = { path = "Count/Text", type = "Text" },
    comfort = { path = "Comfort/Text", type = "Text" },
    name = { path = "Name", type = "Text" },
    select = { path = "Select", type = "GameObject" },
}

function FoundationThemeItem.New(prefab, parent)
    local self = {};
    setmetatable(self, FoundationThemeItem);
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    UITool.Parse(self.gameObject, self, objs);
    self.transform = self.gameObject:GetComponent("RectTransform");
    LuaMgr.SetFont(self.transform);
    self.OnClickItem = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationThemeClick, self.data);
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
    return self;
end

function FoundationThemeItem:SetData(data)
    self.data = data;
    self.pic.texture = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/Foundation/foundation_theme_%s.png", data.Id));
    local putCount, maxCount = FoundationMgr.GetThemePutCount(data.Roomputid);
    self.count.text = string.format("%d/%d", putCount, maxCount);
    self.comfort.text = ConfigFoundationMgr.GetThemeFurnitureComfort(data.Roomputid);
    self.name.text = LuaMgr.GetLangText(data.NameLan);
    local theme = FoundationMgr.GetSelectTheme();
    SetActive(self.select, data.Id == theme);
    SetActive(self.gameObject, true);
end

function FoundationThemeItem:Clear()
    self.data = nil;
    self.pic.texture = nil;
    SetActive(self.gameObject, false);
end

function FoundationThemeItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end