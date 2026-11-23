require("Voyage/VoyageTradeBuyShopItem")
require("Voyage/VoyageTradeShopItem")

local this = {
    buyList = nil,
    shopList = nil,
};

local objs = {
    animator = { path = "root", type = "UIAnimator" },
    buyShopItem = { path = "template/BuyShopItem", type = "GameObject" },
    buysTF = { path = "root/Middle/Shops/Buys/ScrollView/Viewport/Content", type = "Transform" },
    buyTitle = { path = "root/Middle/Shops/Buys/BuyTitle", type = "GameObject" },
    sellTitle = { path = "root/Middle/Shops/Buys/SellTitle", type = "GameObject" },
    moneyText = { path = "root/Middle/Shops/Buys/Money/Text", type = "Text" },
    moneyIcon = { path = "root/Middle/Shops/Buys/Money/Text/Icon", type = "RawImage" },
    confirmBtn = { path = "root/Middle/Shops/Buys/Confirm", type = "Button" },
    buyBg = { path = "root/Middle/Shops/BuyBg", type = "GameObject" },
    buyTime = { path = "root/Middle/Shops/BuyBg/BuyTime/Text", type = "Text" },
    sellBg = { path = "root/Middle/Shops/SellBg", type = "GameObject" },
    sellTime = { path = "root/Middle/Shops/SellBg/SellTime/Text", type = "Text" },
    shopItem = { path = "template/ShopItem", type = "GameObject" },
    shopSVTF = { path = "root/Middle/Shops/ScrollView/Viewport/Content", type = "Transform" },
    buyAllBtn = { path = "root/Middle/Shops/BuyAll", type = "Button" },
    buyAllGO = { path = "root/Middle/Shops/BuyAll", type = "GameObject" },
    sellAllBtn = { path = "root/Middle/Shops/SellAll", type = "Button" },
    sellAllGO = { path = "root/Middle/Shops/SellAll", type = "GameObject" },
    switchBtn = { path = "root/Middle/Shops/Switch", type = "Button" },
    switchBuy = { path = "root/Middle/Shops/Switch/Buy", type = "GameObject" },
    switchSell = { path = "root/Middle/Shops/Switch/Sell", type = "GameObject" },
    msgContent = { path = "root/Left/Msg/Content", type = "UIText" },
    spineCharacter = { path = "root/Middle/Body/Character", type = "UISpineCharacter" },
    drawingAdjustTool = { path = "root/Middle/Body/Character", type = "DrawingAdjustTool" },
    bodyBtn = { path = "root/Middle/Body/Click", type = "Button" },
};


this.SetData = function()
    this.SwitchPanel(true);
    this.SetBuyShops();
    this.SetShops();
    this.SetResetTime();
    this.SetCharacter();
end


this.SetCharacter = function()
    local path = HeroManager.SetCharacterDrawing(this.spineCharacter, "A0156", "A0156001");
    if (path ~= "") then
        this.drawingAdjustTool.Sprite = path;
    end
    this.SetCharacterMsg(10467, 10467);
end


this.SetResetTime = function()
    LuaMgr.AddTimer(TimerConst.VoyageTradeResetTime, this.OnResetTime, 1, -1, true);
end


this.OnResetTime = function()
    local nowTime = PlayerVoyageMgr.isBuy and PlayerVoyageMgr.buyResetTime or PlayerVoyageMgr.sellResetTime;
    local time = nowTime - LuaMgr.Timestamp();
    if (time <= 0) then
        time = 0;
        LuaMgr.RemoveTimer(TimerConst.VoyageTradeResetTime);
        PlayerVoyageMgr.CancelBuyAllShop();
        LuaMgr.HidePanel(UIName.VoyageTradeBuyViewModel);
        PlayerVoyageMgr.GetSailingGoodsPrice();
    end
    if (PlayerVoyageMgr.isBuy) then
        this.buyTime.text = this.GetTimeStr(time);
    else
        this.sellTime.text = this.GetTimeStr(time);
    end
end


this.GetTimeStr = function(time)
    local seconds = time % 60;
    time = seconds > 0 and time + 60 or time;
    local minute = math.floor((time % 3600) / 60);
    local hour = math.floor((time % 86400) / 3600);
    local day = math.floor(time / 86400);
    day = day <= 0 and "" or tostring(day);
    hour = hour < 10 and "0" .. hour or tostring(hour);
    minute = minute < 10 and "0" .. minute or tostring(minute);
    if (day ~= "") then
        return string.format(LuaMgr.GetLangText("VoyageTradeViewModel_0"), day, hour);
    end
    return string.format(LuaMgr.GetLangText("VoyageTradeViewModel_1"), hour, minute);
end


this.SwitchPanel = function(isBuy)
    PlayerVoyageMgr.isBuy = isBuy;
    if (isBuy) then
        SetActive(this.buyTitle, true);
        SetActive(this.sellTitle, false);
        SetActive(this.buyBg, true);
        SetActive(this.sellBg, false);
        SetActive(this.buyAllGO, true);
        SetActive(this.sellAllGO, false);
        SetActive(this.switchBuy, true);
        SetActive(this.switchSell, false);
    else
        SetActive(this.buyTitle, false);
        SetActive(this.sellTitle, true);
        SetActive(this.buyBg, false);
        SetActive(this.sellBg, true);
        SetActive(this.buyAllGO, false);
        SetActive(this.sellAllGO, true);
        SetActive(this.switchBuy, false);
        SetActive(this.switchSell, true);
    end
    this.OnResetTime();
end


this.SetBuyShops = function()
    this.buyList:Clear();
    local buyShop;
    local listData;
    local listDatas = {};
    local buyShops = PlayerVoyageMgr.GetBuyShops();
    local len = #buyShops;
    for i = 1, len do
        buyShop = buyShops[i];
        if (buyShop.count > 0) then
            listData = UIListData.GetData(this.buyShopItem, "VoyageTradeBuyShopItem", buyShop);
            table.insert(listDatas, listData);
        end
    end
    this.buyList:SetData(listDatas);
    this.moneyIcon.texture = GetItemHomeIcon("5130");
    this.moneyText.text = tostring(PlayerVoyageMgr.CalcBuyShopPrice());
end


this.SetShops = function()
    this.shopList:Clear();
    local shop;
    local listData;
    local listDatas = {};
    local shops = PlayerVoyageMgr.GetShops(PlayerVoyageMgr.isBuy);
    local len = #shops;
    if (PlayerVoyageMgr.isBuy) then
        for i = 1, len do
            shop = shops[i];
            if (shop.BuyAccountRemaining > 0) then
                listData = UIListData.GetData(this.shopItem, "VoyageTradeShopItem", shop);
                table.insert(listDatas, listData);
            end
        end
    else
        local count;
        for i = 1, len do
            shop = shops[i];
            if (shop.SoldAccount > 0) then
                count = PlayerVoyageMgr.GetGoods(shop.GoodsID);
                if (count > 0) then
                    count = count - PlayerVoyageMgr.GetSellShopCount(shop.GoodsID);
                    if (count > 0) then
                        listData = UIListData.GetData(this.shopItem, "VoyageTradeShopItem", shop);
                        table.insert(listDatas, listData);
                    end
                end
            end
        end
    end
    this.shopList:SetData(listDatas);
end


this.OnBack = function()
    PlayerVoyageMgr.ClearShops();
    PlayerVoyageMgr.ClearBuyShop();
    LuaMgr.ShowLuaPanel(UIName.VoyageViewModel, false);
end


this.OnClickConfirm = function()
    local buyShops = PlayerVoyageMgr.GetBuyShops();
    local len = #buyShops;
    if (len <= 0) then
        if (PlayerVoyageMgr.isBuy) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("VoyageTradeViewModel_2"));
        else
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("VoyageTradeViewModel_3"));
        end
        return;
    end
    if (PlayerVoyageMgr.isBuy) then
        local price = PlayerVoyageMgr.CalcBuyShopPrice();
        local money = PlayerVoyageMgr.GetMoney();
        if (money < price) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("VoyageTradeViewModel_4"));
            return;
        end
    end
    local shop;
    local goods = {};
    for i = 1, len do
        shop = buyShops[i];
        goods[shop.id] = shop.count;
    end
    if (PlayerVoyageMgr.isBuy) then
        PlayerVoyageMgr.Buy(goods);
    else
        PlayerVoyageMgr.Sell(goods);
    end
end


this.OnClickBuyAll = function()
    local status = PlayerVoyageMgr.BuyAllShops();
    if (status == -1) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("10560"));
        return;
    end
    if (status == 0) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("10495"));
        return;
    end
    this.SetShops();
    this.SetBuyShops();
end


this.OnClickSellAll = function()
    PlayerVoyageMgr.SellAllShops();
    this.SetShops();
    this.SetBuyShops();
end


this.OnClickSwitch = function()
    PlayerVoyageMgr.CancelBuyAllShop();
    this.SwitchPanel(not PlayerVoyageMgr.isBuy);
    this.SetShops();
    this.SetBuyShops();
    this.animator.AnimationName = "ani_VoyageTradePanel_root_1to2";
end


this.OnBuyShop = function(args)
    local isRefresh = args[0];
    if (isRefresh) then
        this.shopList:Refresh();
    else
        this.SetShops();
    end
    this.SetBuyShops();
    if (args.Length >= 2) then
        if (args[1]) then
            this.SetCharacterMsg(10474, 10475);
        else
            this.SetCharacterMsg(10476, 10477);
        end
    end
end


this.SetCharacterMsg = function(min, max)
    local lang = math.random(min, max);
    local msg = ConfigMgr.LangGlobal(tostring(lang));
    this.msgContent.text = ConfigHelper.MsgReplacePlayerByName(msg);
end


this.OnClickBody = function()
    this.SetCharacterMsg(10468, 10473);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.buyList = UIListView.New(this.buysTF);
        this.shopList = UIListView.New(this.shopSVTF);
        LuaMgr.AddClick(this.confirmBtn, this.OnClickConfirm);
        LuaMgr.AddClick(this.buyAllBtn, this.OnClickBuyAll);
        LuaMgr.AddClick(this.sellAllBtn, this.OnClickSellAll);
        LuaMgr.AddClick(this.switchBtn, this.OnClickSwitch);
        LuaMgr.AddClick(this.bodyBtn, this.OnClickBody);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        vm.behaviour:UpdateTopBar("", this.OnBack);
        LuaMgr.AddUIEventListener(UIEventConst.VoyageTradeBuyShop, this.OnBuyShop);
        this.SetData();
        this.animator.AnimationName = "ani_VoyageTradePanel_root";
    end,
    refresh = function(vm)
        this.SetData();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.VoyageTradeResetTime);
        LuaMgr.RemoveUIEventListener(UIEventConst.VoyageTradeBuyShop, this.OnBuyShop);
        this.buyList:Clear();
        this.shopList:Clear();
        if (this.spineCharacter ~= nil) then
            this.spineCharacter:Clear();
        end
        this.moneyIcon.texture = nil;
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.confirmBtn, this.OnClickConfirm);
        LuaMgr.RemoveClick(this.buyAllBtn, this.OnClickBuyAll);
        LuaMgr.RemoveClick(this.sellAllBtn, this.OnClickSellAll);
        LuaMgr.RemoveClick(this.switchBtn, this.OnClickSwitch);
        LuaMgr.RemoveClick(this.bodyBtn, this.OnClickBody);
        UIListView.ClearItem("VoyageTradeBuyShopItem");
        UIListView.ClearItem("VoyageTradeShopItem");
        this.spineCharacter = nil;
        this.drawingAdjustTool = nil;
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})