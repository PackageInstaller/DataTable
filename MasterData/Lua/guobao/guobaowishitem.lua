GuoBaoWishItem = {};

GuoBaoWishItem.__index = GuoBaoWishItem;

local objs = {
    button = { path = "", type = "Button" },
    normal = { path = "Normal", type = "GameObject" },
    select = { path = "Select", type = "GameObject" },
    text = { path = "Text", type = "Text" },
};

function GuoBaoWishItem.New()
    local self = {};    
    setmetatable(self, GuoBaoWishItem);
    return self;
end

function GuoBaoWishItem:Init()    
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.GuoBaoWishSelect, self);
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
end

function GuoBaoWishItem:SetData(data)
    self.data = data.data;
    SetActive(self.normal, not self.data.select);
    SetActive(self.select, self.data.select);
    self.text.text = ConfigMgr.LangGlobal(self.data.text);
end

function GuoBaoWishItem:Clear()
    self.data = nil;
end

function GuoBaoWishItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end