VoyageTradeShopItem = {};

VoyageTradeShopItem.__index = VoyageTradeShopItem;

local objs = {
    button = { path = "", type = "Button" },
    icon = { path = "Group/Icon", type = "RawImage" },
    num = { path = "Group/Num/Text", type = "Text" },
    rise = { path = "Group/Rise", type = "GameObject" },
    riseText = { path = "Group/Rise/Text", type = "Text" },
    riseUp = { path = "Group/Rise/Up", type = "GameObject" },
    riseDown = { path = "Group/Rise/Down", type = "GameObject" },
    costText = { path = "Group/Cost/Text", type = "Text" },
    name = { path = "Group/Name", type = "Text" },
    moneyIcon = { path = "Group/Money", type = "RawImage" },
    moneyText = { path = "Group/Money/Text", type = "Text" },
};

function VoyageTradeShopItem.New()
    local self = {};
    setmetatable(self, VoyageTradeShopItem);
    return self;
end

function VoyageTradeShopItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnConfirm = function(id, count)
        if (PlayerVoyageMgr.BuyShop(id, count)) then
            local hasShop = PlayerVoyageMgr.HasShop(id);
            LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageTradeBuyShop, hasShop);
        end
    end
    self.OnClickItem = function()
        LuaMgr.ShowLuaPanel(UIName.VoyageTradeBuyViewModel, self.data, self.OnConfirm);
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
end

function VoyageTradeShopItem:SetData(data)
    self.data = data.data;
    self.icon.texture = GetItemTexture(self.data.GoodsID);
    if (PlayerVoyageMgr.isBuy) then
        self.num.text = tostring(self.data.BuyAccountRemaining);
    else
        local count = PlayerVoyageMgr.GetGoods(self.data.GoodsID);
        local sellCount = PlayerVoyageMgr.GetSellShopCount(self.data.GoodsID);
        self.num.text = tostring(count - sellCount);
    end
    local itemConfig = ConfigItemMgr.GetItemById(self.data.GoodsID);
    if (itemConfig ~= nil) then
        self.name.text = LuaMgr.GetLangText(itemConfig.nameLan);
    end
    local price = self.data.CurrentPrice - self.data.OriginalPrice;
    if (price == 0) then
        self.riseText.text = "";
        SetActive(self.riseUp, false);
        SetActive(self.riseDown, false);
    else
        self.riseText.text = self.data.PriceRate;
        if (price > 0) then
            SetActive(self.riseUp, true);
            SetActive(self.riseDown, false);
        elseif (price < 0) then
            SetActive(self.riseUp, false);
            SetActive(self.riseDown, true);
        end
    end
    self.costText.text = tostring(self.data.OriginalPrice);
    self.moneyIcon.texture = GetItemHomeIcon("5130");
    self.moneyText.text = tostring(self.data.CurrentPrice);
end

function VoyageTradeShopItem:Clear()
    self.data = nil;
    self.icon.texture = nil;
    self.moneyIcon.texture = nil;
end

function VoyageTradeShopItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end