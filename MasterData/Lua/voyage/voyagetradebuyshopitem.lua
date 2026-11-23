VoyageTradeBuyShopItem = {};

VoyageTradeBuyShopItem.__index = VoyageTradeBuyShopItem;

local objs = {
    button = { path = "", type = "Button" },
    icon = { path = "Group/Icon", type = "RawImage" },
    num = { path = "Group/Num/Text", type = "Text" },
};

function VoyageTradeBuyShopItem.New()
    local self = {};
    setmetatable(self, VoyageTradeBuyShopItem);
    return self;
end

function VoyageTradeBuyShopItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        if (PlayerVoyageMgr.CancelBuyShop(self.data.id)) then
            LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageTradeBuyShop, false);
        end
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
end

function VoyageTradeBuyShopItem:SetData(data)
    self.data = data.data;
    self.icon.texture = GetItemTexture(self.data.id);
    self.num.text = tostring(self.data.count);
end

function VoyageTradeBuyShopItem:Clear()
    self.data = nil;
    self.icon.texture = nil;
end

function VoyageTradeBuyShopItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end