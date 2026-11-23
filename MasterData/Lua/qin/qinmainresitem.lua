QinMainResItem = {};

QinMainResItem.__index = QinMainResItem;

local objs = {
    btn = { path = "", type = "Button" },
    icon = { path = "Icon", type = "RawImage" },
    value = { path = "Text", type = "Text" },
}

function QinMainResItem.New()
    local self = {};
    setmetatable(self, QinMainResItem);
    return self;
end

function QinMainResItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, self.data, false, false, false);
    end
    LuaMgr.AddClick(self.btn, self.OnClickItem);
end

function QinMainResItem:SetData(data)
    self.data = data.data;
    self.icon.texture = GetItemTexture(self.data);
    local itemCount = PlayerItemMgr.GetItemCountById(self.data);
    local maxCount = PlayerSlgMgr.GetResourcesMax(self.data);
    self.value.text = string.format("%s/%s", LuaMgr.NumFormat(itemCount), LuaMgr.NumFormat(maxCount));
end

function QinMainResItem:Clear()
end

function QinMainResItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.btn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end