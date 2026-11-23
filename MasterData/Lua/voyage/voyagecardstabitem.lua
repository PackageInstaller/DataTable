VoyageCardsTabItem = {};

VoyageCardsTabItem.__index = VoyageCardsTabItem;

local objs = {
    button = { path = "", type = "Button" },
    normal = { path = "Normal", type = "GameObject" },
    select = { path = "Select", type = "GameObject" },
};

function VoyageCardsTabItem.New(gameObject)
    local self = {};
    setmetatable(self, VoyageCardsTabItem);
    self.gameObject = gameObject;
    self.transform = gameObject.transform;
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageCardsSelectTab, self.data);
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
    return self;
end

function VoyageCardsTabItem:SetData(index, isSelect)
    self.data = index;
    SetActive(self.normal, not isSelect);
    SetActive(self.select, isSelect);
end

function VoyageCardsTabItem:Clear()
    self.data = nil;
end

function VoyageCardsTabItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end