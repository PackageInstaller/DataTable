local this = {
    vm = nil,
    data = {
        shelfGoods = {},
        allChooseCount = 0,
        showPrice = 0,
        currency = "",
    },
    contentRect = nil,
}

local data={
    goodsList = {
        {
            goodsId = "",
            rare=DefaultSprite,
            icon=DefaultTexture,
            isCount=false,
            count="",
            price="",
            orderNum=0,
            originPrice = 0,
            name="",
            showChoose = false,
            chooseCount = 0,
            leftCount = 0,
            chooseText = "",
            animaName="";
        }
    },
    priceIcon = DefaultTexture,
    priceStr = "",
    priceTips = "",
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.FurnitureShopOrderPopup)
        end
    },
    goodsAddCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = param + 1
            this.RefreshGoodsChooseNum(index, 1)
        end
    },
    goodsDeleteCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = param + 1
            this.RefreshGoodsChooseNum(index, -1)
        end
    },
    priceCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local myPrice=DataHelper.GetItemCountById(this.data.currency)
            if this.data.showPrice == 0 then
                
            elseif this.data.showPrice <= myPrice then
                local chooseGoodsList = {}
                for i, v in ipairs(this.vm.data.goodsList) do
                    if v.chooseCount > 0 then
                        table.insert(chooseGoodsList, {goods = v.goodsId, count = v.chooseCount})
                    end
                end
                PlayerFoundationMgr.BuyGoods_Multi(chooseGoodsList, this.data.currency, this.BuyGoodsResponse)
            else
                local currencyCfg = ConfigHelper.GetItemById(this.data.currency)

                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("21003"));
            end
        end
    },
}


local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.contentRect = vm.behaviour.transform:Find("root/Middle/Obj/Scroll View/Viewport/Content"):GetComponent("RectTransform")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length > 0 then
            this.data.shelfGoods = vm.behaviour.Params[0];
            this.data.buyScucessHandler=vm.behaviour.Params[1];
            this.ParseData();
            this.DefaultChoose();
        end
    end,
   
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
    end,
    
    before_destroy=function()
    end
}

this.ParseData = function()
    this.data.currency = this.data.shelfGoods[1].Currency 
    this.data.allChooseCount = 0
    this.data.showPrice = 0
    this.vm.data.priceIcon=LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(this.data.currency))
    this.SetGoodsList()
end

this.SetGoodsList = function()
    local list = {}
    for i,v in ipairs(this.data.shelfGoods) do
        local item=ConfigHelper.GetItemById(v.Item);
        local isSellOut = v.RefreshCount>0 and v.RefreshCount-DataHelper.GetShopRecordByGoodsId(v.Id)<=0;
        if not isSellOut then
            local leftCount = v.RefreshCount-DataHelper.GetShopRecordByGoodsId(v.Id)
            local goodItem={
                goodsId = v.Id,
                rare=LuaMgr.GetSprite("ItemRare","itemRare"..item.rare),
                icon=LuaMgr.GetTexture(ConfigHelper.GetItemIconPath(v.Item)),
                isCount=v.Stack>1,
                count=LuaMgr.NumFormat(v.Stack),
                price=LuaMgr.NumFormat(v.Price),
                orderNum=v.Order,
                originPrice = v.Price,
                name=LuaMgr.GetLangText(item.nameLan),
                showChoose = false,
                chooseCount = 0,
                leftCount = leftCount,
                chooseText = string.format("%s/%s", 0, leftCount),
                animaName="ani_FurnitureShopOrderGoodItem",
            }
            table.insert(list,goodItem)
        end
    end
    table.sort(list,function(a, b)
        return a.orderNum>b.orderNum;
    end)
    this.vm.data.goodsList=list;
    list=nil;
    
    LuaMgr.NextFrame(function()
        RectTool.RebuildLayoutImmediate(this.contentRect)
        this.contentRect.anchoredPosition = Vector2(0, 0);
    end)
end

this.RefreshGoodsChooseNum = function(index, changeNum)
    local oldChooseNum = this.vm.data.goodsList[index].chooseCount
    local chooseNum = oldChooseNum + changeNum
    local maxNum = this.vm.data.goodsList[index].leftCount
    local goodsPrice = this.vm.data.goodsList[index].originPrice
    if chooseNum < 0 then
        chooseNum = 0
    elseif chooseNum > maxNum then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("FurnitureShopOrderPopup_0"));
        chooseNum = maxNum
    end
    this.vm.data.goodsList[index].chooseCount = chooseNum
    this.vm.data.goodsList[index].chooseText = string.format("%s/%s", chooseNum, maxNum)
    this.vm.data.goodsList[index].showChoose = chooseNum > 0
    local newChangeNum = chooseNum - oldChooseNum
    this.data.allChooseCount = this.data.allChooseCount + newChangeNum
    this.data.showPrice = this.data.showPrice + newChangeNum * goodsPrice

    local myPrice=DataHelper.GetItemCountById(this.data.currency)
    local allChooseCountStr = string.format(LuaMgr.GetLangText("FurnitureShopOrderPopup_1"), this.data.allChooseCount)
    if this.data.showPrice <= myPrice then
        this.vm.data.priceTips = allChooseCountStr
        this.vm.data.priceStr = tostring(this.data.showPrice)
    else
        this.vm.data.priceTips = string.format(LuaMgr.GetLangText("FurnitureShopOrderPopup_2"), allChooseCountStr)
        this.vm.data.priceStr = string.format("<color=#EC3839>%s</color>", this.data.showPrice)
    end
end


this.BuyGoodsResponse = function(result)
    local re=json.decode(result);
    local data=json.encode(re.result);
    LuaMgr.ShowItemRewared(data);
    if this.data.buyScucessHandler~=nil then
        this.data.buyScucessHandler();
    end
    LuaMgr.HidePanel(UIName.FurnitureShopOrderPopup)
end

this.DefaultChoose = function()
    local allMoney = DataHelper.GetItemCountById(this.data.currency)
    for i, goods in ipairs(this.vm.data.goodsList) do
        local leftMoney = allMoney - this.data.showPrice
        local chooseCount = 0
        for j = goods.leftCount, 0, -1 do
            if j * goods.originPrice <= leftMoney then
                chooseCount = j
                break
            end
        end
        this.RefreshGoodsChooseNum(i, chooseCount)
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})