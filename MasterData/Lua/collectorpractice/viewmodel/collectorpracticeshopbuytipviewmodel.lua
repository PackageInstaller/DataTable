





local this = { vm = nil };

local animator = nil;
local anima_CLOSE = "ani_ui_BuyTipPanel_02"
local anima_OPEN = "ani_ui_BuyTipPanel_01"
local buyNum = 1;
local buyScucessHandler = nil;
local limitTypes = {}
local stopClick = false;
local goods = nil;
local shopId = nil
local itemIndex = nil
local data = {
    goodsName = "",
    goodsCount = "",
    goodsDes = "",
    goodsRare = DefaultSprite,
    goodsIcon = DefaultTexture,
    goodsStack = "",
    priceIcon = DefaultTexture,
    price = "",
    limitBuy = "",
    buyCount = "",
    limitBool = false,
    limitCount = "",
    contentAnchorPos = Vector2(0, 0),
    desContentSizeFilter = false,


    buyTipAnchorPos = Vector2(0, 0),
    buyBgSizeData = Vector2(0, 0),
    dropDown = false,
}

local command = {
    minBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            buyNum = 1;
            this.RefreshPrice();
        end
    },
    maxBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            buyNum = this.GetMaxBuyNum();
            buyNum = buyNum > 0 and buyNum or 1;
            this.RefreshPrice();
        end
    },
    addBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if buyNum < this.GetMaxBuyNum() then
                buyNum = buyNum + 1;
                this.RefreshPrice();
            end
        end
    },
    subtractBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if buyNum > 1 then
                buyNum = buyNum - 1;
                this.RefreshPrice();
            end
        end
    },
    buyBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.CheckCosTNum()
        end
    },
    buyInput = {
        type = XLuaCommandType.String,
        execute = function(vm, value, param)
            local num = 0;
            if value == "" or value == "-" then
                num = 1
            else
                num = tonumber(value);
                local maxNum = this.GetMaxBuyNum();
                if num > maxNum then
                    num = maxNum;
                elseif num < 1 then
                    num = 1;
                end
            end
            buyNum = num;
            this.RefreshPrice();
        end
    },
    closeBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.DelayHidePanel();
        end
    },

}
local hook = {
    before_awake = function(vm)
        this.vm = vm;
        print("before_awake");
        limitTypes = { LuaMgr.GetLangText("BuyTipViewModel_0"),
            LuaMgr.GetLangText("BuyTipViewModel_1"),
            LuaMgr.GetLangText("BuyTipViewModel_2"),
            LuaMgr.GetLangText("BuyTipViewModel_3") }
        animator = vm.behaviour.transform:Find("root"):GetComponent("Animator")
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params == nil) then return end
        this.vm.data.contentAnchorPos = Vector2(0, 0);
        goods = vm.behaviour.Params[0];
        local limitType = vm.behaviour.Params[1];
        buyScucessHandler = vm.behaviour.Params[2];
        shopId = vm.behaviour.Params[3];
        this.ParseData(limitType);
        this.vm.data.desContentSizeFilter = false;
        LuaMgr.NextFrame(function()
            this.vm.data.desContentSizeFilter = true;
        end)
    end,
    before_deactive = function(vm)
        print("before_deactive");
    end,
}

this.AdjustScreen = function(isDropDown)
    this.vm.data.dropDown = isDropDown;
    if isDropDown then
        this.vm.data.buyTipAnchorPos = Vector2(0, 0);
        this.vm.data.buyBgSizeData = Vector2(530, 528);
    else
        this.vm.data.buyTipAnchorPos = Vector2(0, -90);
        this.vm.data.buyBgSizeData = Vector2(538, 340);
    end
end

this.ParseData = function(limitType)
    stopClick = false;
    buyNum = 1;
    this.AdjustScreen(false);
    local item = ConfigHelper.GetItemById(goods.Item)
    this.vm.data.goodsName = LuaMgr.GetLangText(item.nameLan);
    local goodsNum = DataHelper.GetItemCountById(goods.Item);
    this.vm.data.goodsCount = LuaMgr.NumFormat(goodsNum);
    this.vm.data.goodsDes = LuaMgr.GetLangText(item.DescriptionLan);
    this.vm.data.goodsStack = "X" .. goods.Stack;
    this.vm.data.goodsRare = LuaMgr.GetSprite("ItemRare", "itemRare" .. item.rare);
    this.vm.data.goodsIcon = LuaMgr.GetTexture(ConfigHelper.GetItemIconPath(goods.Item))
    this.vm.data.limitBool = goods.RefreshCount > 0;
    this.vm.data.priceIcon = LuaMgr.GetTexture(ConfigHelper.GetItemIconPath(goods.Currency));
    this.vm.data.limitCount = string.format("%s: %s/%s", limitTypes[tonumber(limitType)],
        CollectorPracticeMgr.GetShopRecordByGoodsId(goods.Id, shopId), goods.RefreshCount);

    this.RefreshPrice();
end


this.RefreshPrice = function()
    local myCount = DataHelper.GetItemCountById(goods.Currency);
    local re = myCount < goods.Price * buyNum;
    this.vm.data.buyCount = buyNum;
    this.vm.data.price = re and string.format("<color=#EE0A0A>%s</color>", goods.Price * buyNum)
        or string.format("<color=#ffffff>%s</color>", goods.Price * buyNum);
end


this.GetMaxBuyNum = function()
    local myCont = DataHelper.GetItemCountById(goods.Currency);
    local maxNum = math.floor(myCont / goods.Price);
    if goods.RefreshCount > 0 then
        local limitNum = goods.RefreshCount - CollectorPracticeMgr.GetShopRecordByGoodsId(goods.Id, shopId)
        maxNum = maxNum > limitNum and limitNum or maxNum;
    end
    maxNum = maxNum < 1 and 1 or maxNum;
    return maxNum;
end

this.CheckCosTNum = function()
    DataHelper.ConditionCheck(goods.Currency, buyNum * goods.Price, function()
        this.OnClick_Buy()
    end)
end

this.OnClick_Buy = function()
    if stopClick then return end;
    stopClick = true;

    local canBuyNum = goods.RefreshCount - CollectorPracticeMgr.GetShopRecordByGoodsId(goods.Id, shopId)
    if canBuyNum <= 0 then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("CollectorPracticeShopBuyTipViewModel_7102"));
        return
    end
    local goodIndex = ComData.CollectorPracticeShop[shopId][goods.Id].key
    local matchData = { shopid = shopId, index = goodIndex - 1, cnt = buyNum }
    local beforeBuyTime = LuaMgr.Timestamp();

    ApiMgr.Request("randShop/buy_goods", matchData, true, function(result)
        local re = json.decode(result);
        if re.code == 0 then
            this.ChangeShopRecordByGoodsId(shopId, goods.Id, buyNum)
        end
        local data = json.encode(re.result);
        local result=false;

        for key, value in pairs(ConfigMgr.Config.RelicsMap) do
if DataMgr.Player.relics ~= nil and DataMgr.Player.relics[value.RelicsId] ~= nil and DataMgr.Player.relics[value.RelicsId].Time >= (beforeBuyTime-1) then
                LuaMgr.ShowLuaPanel(UIName.CollectorPracticeFinishEventViewModel, nil, nil, true, beforeBuyTime-1)
                result=true;
                break;
            end
        end

        if not result then
            LuaMgr.ShowItemRewared(data);
        end
        if buyScucessHandler ~= nil then
            buyScucessHandler();
        end
        this.DelayHidePanel();
    end, nil, true)
end

this.DelayHidePanel = function()
    animator:Play(anima_CLOSE);
    coroutine_runner.start(function()
        coroutine_runner.wait(0.5);
        LuaMgr.HidePanel(UIName.CollectorPracticeShopBuyTipViewModel)
    end)
end




this.ChangeShopRecordByGoodsId = function(shopId, goodsId, count)
    local comdatavalue = ComData.CollectorPracticeShop[shopId][goodsId]
    comdatavalue.datavalue = count + comdatavalue.datavalue;
    DataMgr.Player.randShop[shopId].buycnt[comdatavalue.key] = comdatavalue.datavalue
end
return vm({
    data = data,
    command = command,
    hook = hook
})