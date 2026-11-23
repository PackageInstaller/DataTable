HeroUpLevelSelectItem = {};

HeroUpLevelSelectItem.__index = HeroUpLevelSelectItem;

local objs = {
    canvasGroup = { path = "", type = "CanvasGroup" },
    button = { path = "", type = "Button" },
    addNumber = { path = "", type = "UIAddNumber" },
    lightGO = { path = "Light", type = "GameObject" },
    rare = { path = "Rare", type = "Image" },
    icon = { path = "Icon", type = "RawImage" },
    countText = { path = "Count/Text", type = "Text" },
    selectCountGO = { path = "SelectCount", type = "GameObject" },
    selectCountText = { path = "SelectCount/Text", type = "Text" },
    selectCountSub = { path = "SelectCount/SubtractBtn", type = "Button" },
}

function HeroUpLevelSelectItem.New()
    local self = {};
    setmetatable(self, HeroUpLevelSelectItem);
    self.OnClickItem = function()
        if (self.data.OnClickItem ~= nil) then
            self.data.OnClickItem(self.data.index);
        end
    end
    self.OnClickSubtract = function()
        if (self.data.OnClickSubtract ~= nil) then
            self.data.OnClickSubtract(self.data.index);
        end
    end
    return self;
end

function HeroUpLevelSelectItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.button, self.OnClickItem);
    LuaMgr.AddClick(self.selectCountSub, self.OnClickSubtract);
end

function HeroUpLevelSelectItem:SetData(data)
    data = data.data;
    self.data = data;
    self.canvasGroup.alpha = data.alpha;
    SetActive(self.lightGO, data.isLight);
    self.rare.sprite = data.itemRare;
    self.icon.texture = data.itemIcon;
    self.countText.text = data.itemCount;
    SetActive(self.selectCountGO, data.isSelect);
    self.selectCountText.text = data.selectCount;
end

function HeroUpLevelSelectItem:Clear()
    self.data = nil;
    self.rare.sprite = nil;
    self.icon.texture = nil;
end

function HeroUpLevelSelectItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    if (self.OnClickSubtract ~= nil) then
        LuaMgr.RemoveClick(self.selectCountSub, self.OnClickSubtract);
        self.OnClickSubtract = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end