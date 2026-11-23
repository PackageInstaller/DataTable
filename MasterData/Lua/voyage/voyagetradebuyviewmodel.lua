local this = {
    item = nil,
    count = 0,
    maxCount = 0,
    itemId = "",
    price = 0,
    callback = nil,
};

local objs = {
    maskBtn = { path = "root/Mask", type = "Button" },
    name = { path = "root/Middle/TradeBuy/Name", type = "Text" },
    haveCount = { path = "root/Middle/TradeBuy/HaveCount/Text", type = "Text" },
    itemTF = { path = "root/Middle/TradeBuy/Item", type = "Transform" },
    content = { path = "root/Middle/TradeBuy/Content", type = "Text" },
    countText = { path = "root/Middle/TradeBuy/Count/Text", type = "Text" },
    minBtn = { path = "root/Middle/TradeBuy/MinBtn", type = "Button" },
    subBtn = { path = "root/Middle/TradeBuy/SubBtn", type = "Button" },
    addBtn = { path = "root/Middle/TradeBuy/AddBtn", type = "Button" },
    maxBtn = { path = "root/Middle/TradeBuy/MaxBtn", type = "Button" },
    limit = { path = "root/Middle/TradeBuy/Limit", type = "Text" },
    confirmBtn = { path = "root/Middle/TradeBuy/ConfirmBtn", type = "Button" },
    confirmMoney = { path = "root/Middle/TradeBuy/ConfirmBtn/Money", type = "Text" },
    confirmMoneyIcon = { path = "root/Middle/TradeBuy/ConfirmBtn/Money/Icon", type = "RawImage" },
};


this.SetData = function(params)
    local itemData = params[0];
    this.itemId = itemData.GoodsID;
    this.price = itemData.CurrentPrice;
    this.callback = params[1];
    if (PlayerVoyageMgr.isBuy) then
        this.maxCount = this.BuyMaxCount();
        this.count = this.maxCount >= 1 and 1 or 0;
    else
        local sellCount = PlayerVoyageMgr.GetSellShopCount(itemData.GoodsID);
        this.maxCount = PlayerVoyageMgr.GetGoods(itemData.GoodsID) - sellCount;
        this.count = this.maxCount >= 1 and 1 or 0;
    end
    this.SetGoods();
    this.SetHaveCount();
    this.SetCount();
    this.SetItem();
end


this.SetGoods = function()
    local goods = ConfigMgr.Config.SailingGoodsMap[this.itemId];
    if (goods ~= nil) then
        this.name.text = LuaMgr.GetLangText(goods.NameLan);
        this.content.text = LuaMgr.GetLangText(goods.DesLan);
    end
end


this.SetHaveCount = function()
    local count = DataMgr.Player.SailingCargos[this.itemId];
    if (count == nil) then
        count = 0;
    end
    if (not PlayerVoyageMgr.isBuy) then
        count = count - PlayerVoyageMgr.GetSellShopCount(this.itemId);
    end
    this.haveCount.text = tostring(count);
end


this.SetCount = function()
    this.countText.text = tostring(this.count);

    local money = this.price * this.count;
    this.confirmMoney.text = tostring(money);
    this.confirmMoneyIcon.texture = GetItemHomeIcon("5130");
end


this.SetItem = function()
    if (this.item == nil) then
        this.item = GoodsDataItem.New(this.itemTF);
    end
    local itemData = table.Copy(ConfigMgr.Config.itemMap[this.itemId]);
    itemData.count0 = 0;
    this.item:SetData(1, itemData, 1, false, Vector3(0.8, 0.8, 1), false, true);
end


this.BuyMaxCount = function()
    local count = 0;
    local shop = PlayerVoyageMgr.GetShop(this.itemId);
    if (shop ~= nil) then
        while (shop.BuyAccountRemaining > 0) do
            if (PlayerVoyageMgr.IsBuyShop(shop.GoodsID, count + 1)) then
                count = count + 1;
            else
                break;
            end
        end
    end
    return count;
end


this.OnClickMask = function()
    LuaMgr.HidePanel(UIName.VoyageTradeBuyViewModel);
end


this.OnClickMin = function()
    if (PlayerVoyageMgr.isBuy) then
        this.count = this.maxCount >= 1 and 1 or 0;
        this.SetCount();
    else
        this.count = this.maxCount >= 1 and 1 or 0;
        this.SetCount();
    end
end


this.OnClickSub = function()
    if (this.count > 1) then
        this.count = this.count - 1;
        this.SetCount();
    end
end


this.OnClickAdd = function()
    if (this.count < this.maxCount) then
        if (PlayerVoyageMgr.isBuy) then
            if (PlayerVoyageMgr.IsBuyShop(this.itemId, this.count + 1)) then
                this.count = this.count + 1;
                this.SetCount();
            else
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("10495"));
            end
        else
            this.count = this.count + 1;
            this.SetCount();
        end
    end
end


this.OnClickMax = function()
    if (PlayerVoyageMgr.isBuy) then
        if (PlayerVoyageMgr.IsBuyShop(this.itemId, this.maxCount)) then
            this.count = this.maxCount;
            this.SetCount();
        else
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("10495"));
        end
    else
        this.count = this.maxCount;
        this.SetCount();
    end
end


this.OnClickConfirm = function()
    local callback = this.callback;
    local itemId = this.itemId;
    local count = this.count;
    if (PlayerVoyageMgr.isBuy) then
        if (PlayerVoyageMgr.IsBuyShop(itemId, count)) then
            LuaMgr.HidePanel(UIName.VoyageTradeBuyViewModel);
            if (callback ~= nil) then
                callback(itemId, count);
            end
        else
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("10495"));
        end
    else
        LuaMgr.HidePanel(UIName.VoyageTradeBuyViewModel);
        if (callback ~= nil) then
            callback(itemId, count);
        end
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.maskBtn, this.OnClickMask);
        LuaMgr.AddClick(this.minBtn, this.OnClickMin);
        LuaMgr.AddClick(this.subBtn, this.OnClickSub);
        LuaMgr.AddClick(this.addBtn, this.OnClickAdd);
        LuaMgr.AddClick(this.maxBtn, this.OnClickMax);
        LuaMgr.AddClick(this.confirmBtn, this.OnClickConfirm);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        
        this.SetData(vm.behaviour.Params);
    end,
    before_deactive = function(vm)
        this.itemId = "";
        this.callback = nil;
        if (this.item ~= nil) then
            this.item:Hide();
        end
        this.confirmMoneyIcon.texture = nil;
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickMask);
        LuaMgr.RemoveClick(this.minBtn, this.OnClickMin);
        LuaMgr.RemoveClick(this.subBtn, this.OnClickSub);
        LuaMgr.RemoveClick(this.addBtn, this.OnClickAdd);
        LuaMgr.RemoveClick(this.maxBtn, this.OnClickMax);
        LuaMgr.RemoveClick(this.confirmBtn, this.OnClickConfirm);
        if (this.item ~= nil) then
            this.item:Clear();
            this.item = nil;
        end
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})