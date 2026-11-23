DHAllusionItem = {};

DHAllusionItem.__index = DHAllusionItem;

local objs = {
    btnSelect = { path = "btnSelect", type = "Button" },
    goSelectBG = { path = "goSelectBG", type = "GameObject" },
    selectTips = { path = "goSelectBG/textSelectTips", type = "Text" },
    goUnselectBG = { path = "goUnselectBG", type = "GameObject" },
    unSelectTips = { path = "goUnselectBG/textUnSelectTips", type = "Text" },
};

function DHAllusionItem.New()
    local self = {};
    setmetatable(self, DHAllusionItem);
    return self;
end

function DHAllusionItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.playAnimator = true   
    self.OnClickItem = function()
        if (self.Callback ~= nil) then
            self.Callback(self.data.curIndex)
        end
    end
    LuaMgr.AddClick(self.btnSelect, self.OnClickItem);
end

function DHAllusionItem:SetData(data)
    self.data = data.data;
    local id = self.data.Info[1]
    local config = ConfigMgr.Config.DHTextMaps[id]
    self.selectTips.text = LuaMgr.GetLangText(config.TextLan)
    self.unSelectTips.text =  LuaMgr.GetLangText(config.TextLan)
    self.Callback = self.data.ClickCallback
    SetActive(self.goSelectBG, self.data.bSelected)
    SetActive(self.goUnselectBG, not self.data.bSelected)
end

function DHAllusionItem:Clear()
    self.data = nil;
end

function DHAllusionItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.btnSelect, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end