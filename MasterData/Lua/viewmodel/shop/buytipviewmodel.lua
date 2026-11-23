





local this = {vm=nil};

local animator=nil;
local anima_CLOSE="ani_ui_BuyTipPanel_02"
local anima_OPEN="ani_ui_BuyTipPanel_01"
local buyNum=1;
local buyScucessHandler=nil;
local limitTypes={}
local stopClick=false;
local goods=nil;
local twoPrice = nil;
local secondSureNum=nil;

local data = {
    goodsName="";
    goodsCount="";
    goodsDes="";
    goodsRare=DefaultSprite;
    goodsIcon=DefaultTexture;
    goodsStack="";
    priceIcon=DefaultTexture;
    price="";
    limitBuy="";
    buyCount="";
    limitBool=false;
    limitCount="";
    contentAnchorPos=Vector2(0,0);
    desContentSizeFilter=false;
    
    bugButton2 = false;
    priceIcon2 = DefaultTexture;
    price2 = "";

    buyTipAnchorPos=Vector2(0,0);
    buyBgSizeData=Vector2(0,0);
    dropDown=false;
}

local command = {
    minBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            buyNum=1;
            this.RefreshPrice();
        end
    },
    maxBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            buyNum=this.GetMaxBuyNum();
            buyNum=buyNum>0 and buyNum or 1;
            this.RefreshPrice();
        end
    },
    addBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if buyNum<this.GetMaxBuyNum() then
                buyNum=buyNum+1;
                this.RefreshPrice();
            end

        end
    },
    subtractBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if buyNum>1 then
                buyNum=buyNum-1;
                this.RefreshPrice();
            end

        end
    },
    buyBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClick_Buy(param);
        end
    },
    buyInput = {
        type = XLuaCommandType.String,
        execute = function(vm,value,param)
           local num=0;
            if value=="" or value=="-" then
                num=1
            else
                num=tonumber(value);
                local maxNum=this.GetMaxBuyNum();
                if num>maxNum then
                    num=maxNum;
                elseif num<1 then
                    num=1;
                end
            end
            buyNum=num;
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
        this.vm=vm;
        print("before_awake");
        limitTypes={LuaMgr.GetLangText("BuyTipViewModel_0"),
                    LuaMgr.GetLangText("BuyTipViewModel_1"),
                    LuaMgr.GetLangText("BuyTipViewModel_2"),
                    LuaMgr.GetLangText("BuyTipViewModel_3"),
                    LuaMgr.GetLangText("BuyTipViewModel_4"),}
        animator=vm.behaviour.transform:Find("root"):GetComponent("Animator")
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params == nil) then return end
        this.vm.data.contentAnchorPos=Vector2(0,0);
        goods=vm.behaviour.Params[0];
        local limitType=vm.behaviour.Params[1];
        buyScucessHandler=vm.behaviour.Params[2];
        secondSureNum=0;
        if goods.SecondSure~=nil and goods.SecondSure>0 then
            secondSureNum=goods.SecondSure;
        end

        if vm.behaviour.Params.Length >= 4 then
            twoPrice = vm.behaviour.Params[3]
        end
        this.vm.data.bugButton2 = not TableIsNull(twoPrice)
        
        this.ParseData(limitType);
        this.vm.data.desContentSizeFilter=false;
        LuaMgr.NextFrame(function()
            this.vm.data.desContentSizeFilter=true;
        end)
    end,
    before_deactive = function(vm)
        twoPrice = nil
        print("before_deactive");
    end,
}

this.AdjustScreen=function(isDropDown)
    this.vm.data.dropDown=isDropDown;
    if isDropDown then
        this.vm.data.buyTipAnchorPos=Vector2(0,0);
        this.vm.data.buyBgSizeData=Vector2(530,528);
    else
        this.vm.data.buyTipAnchorPos=Vector2(0,-90);
        this.vm.data.buyBgSizeData=Vector2(538,340);
    end
end

this.ParseData=function(limitType)
    buyNum=1;
    this.AdjustScreen(false);
    local item=ConfigHelper.GetItemById(goods.Item)
    this.vm.data.goodsName=LuaMgr.GetLangText(item.nameLan);
    local goodsNum=DataHelper.GetItemCountById(goods.Item);
    this.vm.data.goodsCount=LuaMgr.NumFormat(goodsNum);
    this.vm.data.goodsDes=LuaMgr.GetLangText(item.DescriptionLan);
    this.vm.data.goodsStack="X"..goods.Stack;
    this.vm.data.goodsRare=LuaMgr.GetSprite("ItemRare","itemRare"..item.rare);
    this.vm.data.goodsIcon=LuaMgr.GetTexture(ConfigHelper.GetItemIconPath(goods.Item))
    this.vm.data.limitBool=goods.RefreshCount>0;
    this.vm.data.priceIcon=LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(goods.Currency));
    this.vm.data.limitCount=string.format("%s: %s/%s",limitTypes[tonumber(limitType)],
            DataHelper.GetShopRecordByGoodsId(goods.Id),goods.RefreshCount);
    if not TableIsNull(twoPrice) then
        this.vm.data.priceIcon2 = LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(twoPrice[1]));
    end
    this.RefreshPrice();
    
end


this.RefreshPrice=function()
    local myCount=DataHelper.GetItemCountById(goods.Currency);
    local re=myCount<goods.Price*buyNum;
    this.vm.data.buyCount=buyNum;
    this.vm.data.price=re and string.format("<color=#EE0A0A>%s</color>",LuaMgr.NumFormat(goods.Price*buyNum)) 
            or string.format("<color=#ffffff>%s</color>",LuaMgr.NumFormat(goods.Price*buyNum));
    if not TableIsNull(twoPrice) then
        local myCount2 = DataHelper.GetItemCountById(twoPrice[1]);
        local re2 = myCount2 < tonumber(twoPrice[2]) * buyNum;
        this.vm.data.price2 = re2 and string.format("<color=#EE0A0A>%s</color>",LuaMgr.NumFormat(tonumber(twoPrice[2])*buyNum))
                or string.format("<color=#ffffff>%s</color>",LuaMgr.NumFormat(tonumber(twoPrice[2])*buyNum));
    end
end


this.GetMaxBuyNum=function()
    local maxNum = goods.RefreshCount
    if maxNum <= 0 then

        if TableIsNull(twoPrice) then

            local myCont = DataHelper.GetItemCountById(goods.Currency)
            maxNum = math.floor(myCont / goods.Price)
        else

            local myCont_1 = DataHelper.GetItemCountById(goods.Currency)
            local num_1 = math.floor(myCont_1 / goods.Price)
            local myCont_2 = DataHelper.GetItemCountById(twoPrice[1])
            local num_2 = math.floor(myCont_2 / twoPrice[2])
            maxNum = num_1 > num_2 and num_1 or num_2
        end
    else

        local limitNum = goods.RefreshCount - DataHelper.GetShopRecordByGoodsId(goods.Id)
        if TableIsNull(twoPrice) then

            local limitPrice = limitNum * goods.Price
            local myCont = DataHelper.GetItemCountById(goods.Currency)
            if limitPrice > myCont then
                maxNum = math.floor(myCont / goods.Price)
            else
                maxNum = limitNum
            end
        else

            local myCont_1 = DataHelper.GetItemCountById(goods.Currency)
            local num_1 = math.floor(myCont_1 / goods.Price)
            local myCont_2 = DataHelper.GetItemCountById(twoPrice[1])
            local num_2 = math.floor(myCont_2 / twoPrice[2])
            maxNum = num_1 > num_2 and num_1 or num_2
            maxNum = maxNum > limitNum and limitNum or maxNum
        end
    end
    if maxNum == nil or maxNum <= 0 then
        maxNum = 1
    elseif maxNum > 99999 then
maxNum = 99999
    end
    return maxNum;
end

this.OnClick_Buy=function(param)
    local goodId = ""
    local count = 0
    if param == "1" then
        goodId = goods.Currency
        count = buyNum*goods.Price
    elseif param == "2" then
        goodId = twoPrice[1]
        count = buyNum * tonumber(twoPrice[2])
    end
    if secondSureNum>0 and buyNum>=secondSureNum then
        local tips=string.format(ConfigMgr.LangGlobal("23905"),buyNum,this.vm.data.goodsName);
        LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,tips,function()
            DataHelper.ConditionCheck(goodId,count,function()
                if goods.isRandom==nil then
                    this.NormalBuy(goodId);
                else
                    this.RandomBuy();
                end
            end)
        end,nil);
    else
        DataHelper.ConditionCheck(goodId,count,function()
            if goods.isRandom==nil then
                this.NormalBuy(goodId);
            else
                this.RandomBuy();
            end
        end)
    end
end

this.RandomBuy=function()
    local matchData={shopid=goods.shelfId,index=goods.index,cnt=buyNum}
    ApiMgr.Request("randShop/buy_goods",matchData,true,function(result)
        local re=json.decode(result);
        local data=json.encode(re.result);
        LuaMgr.ShowItemRewared(data);
        if buyScucessHandler~=nil then
            buyScucessHandler();
        end
        this.DelayHidePanel();
    end,nil,true)
end

this.NormalBuy=function(goodId)
    local matchData={goods=goods.Id,count=buyNum,itemId = goodId}
    LuaDebug.error(table.tostring(matchData))
    ApiMgr.Request("buy_goods",matchData,true,function(result)
        local re=json.decode(result);
        local data=json.encode(re.result);
        LuaMgr.ShowItemRewared(data);
        if buyScucessHandler~=nil then
            buyScucessHandler();
        end
        this.DelayHidePanel();
    end,nil,true)
end

this.DelayHidePanel=function()
    animator:Play(anima_CLOSE);
    coroutine_runner.start(function()
        coroutine_runner.wait(0.5);
        LuaMgr.HidePanel(UIName.BuyTipViewModel)
    end)
end

return vm({
    data = data,
    command = command,
    hook = hook
})