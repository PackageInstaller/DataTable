RhythmGameShopItem = {};

RhythmGameShopItem.__index = RhythmGameShopItem;

local objs = {
    button = { path = "", type = "Button" },
    name = { path = "group/Name", type = "Text" },
    goods = { path = "group/Goods", type = "Transform" },
    rare = { path = "group/Goods/Rare", type = "Image" },
    Icon = { path = "group/Goods/Icon", type = "RawImage" },
    goodsCount = { path = "group/Goods/Count/Text", type = "Text" },
    count = { path = "group/Count", type = "Text" },
    money = { path = "group/Money", type = "Text" },
    moneyIcon = { path = "group/Money/Icon", type = "RawImage" },
    mask = { path = "group/Mask", type = "GameObject" },
}

function RhythmGameShopItem.New(prefab, parent)
    local self = {};
    setmetatable(self, RhythmGameShopItem);
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    UITool.Parse(self.gameObject, self, objs);
    self.transform = self.gameObject:GetComponent("RectTransform");
    LuaMgr.SetFont(self.transform);
    self.OnClickItem = function()
        if(self.data.maxBuyCount <= 0)then return end
        local rewardId = self.data.quesId;
        local item = self.data.goods;
        local maxCount = self.data.maxBuyCount;
        local cost = self.data.cost;
        LuaMgr.ShowLuaPanel(UIName.ActivityBuyTipViewModel, item, cost, maxCount, function(count)
            DataExHelper.EX_ShopConvert(rewardId, count, function()
                LuaMgr.InvokeUIEventListeners(UIEventConst.RhythmGameShopTitle);
            end)
        end)
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
    return self;
end

function RhythmGameShopItem:SetData(data)
    self.data = data;
    self.gameObject:SetActive(true);
    self.name.text = data.name
    self.count.text = data.limitNum
    self.money.text = data.price
    self.rare.sprite = LuaMgr.GetSprite("ItemRare", "itemRare" .. data.rare)
    self.Icon.texture = LuaMgr.GetTexture(data.icon)
    self.goodsCount.text = data.count
    self.moneyIcon.texture = LuaMgr.GetTexture(data.priceIcon)
    SetActive(self.mask, data.maxBuyCount <= 0)
end

function RhythmGameShopItem:Clear()
    self.data = nil;
    self.gameObject:SetActive(false);
end

function RhythmGameShopItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end