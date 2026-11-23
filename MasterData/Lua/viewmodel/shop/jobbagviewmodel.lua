





local this = {
    data = {
        paying=false;
        order=nil;
        shelfIndex=nil;
        chargeId=nil;
        coroutine_Key=nil;
        buyWay=nil;
        tarGoodsId=nil;
        curShelfData=nil;
        
    }
};

require("ViewModel/Shop/UIShopGiftItem")
require("ViewModel/Shop/UIShopGiftGoodItem")

local goodItems={};
local shopGiftItems={};
local rectAin=nil;
local animator=nil;


local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Middle = nil;
local uiShopGiftItem = nil;
local goSecondBuyPanel = nil;
local goLeftLine = nil;
local goGoods = nil;
local goFree = nil;
local goZhekou = nil;
local goTuiJian = nil;
local goXianshi = nil;
local goRemainTime = nil;
local uiGoodsItem = nil;
local imgZheZhao = nil;
local imgLeftBg = nil;
local imgIcon = nil;
local imgBg = nil;
local imgRightBg = nil;
local imgLine = nil;
local imgLine2 = nil;
local imgTitle = nil;
local scrollViewShopGift = nil;
local scrollView = nil;
local rectContent = nil;
local rectGood = nil;
local btnClose = nil;
local btnBuy = nil;
local btnSellOut = nil;
local textLimitInfo = nil;
local textName = nil;
local textPrice = nil;
local textPrice2 = nil;
local textPrice3 = nil;
local textTag = nil;
local textDisCount = nil;
local textDes = nil;
local textTime = nil;
local textTitle = nil;
local rawImagePrice = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Middle = uiLink:Get("Middle");
    uiShopGiftItem = uiLink:Get("UIShopGiftItem");
    goSecondBuyPanel = uiLink:Get("goSecondBuyPanel");
    goLeftLine = uiLink:Get("goLeftLine");
    goGoods = uiLink:Get("goGoods");
    goFree = uiLink:Get("goFree");
    goZhekou = uiLink:Get("goZhekou");
    goTuiJian = uiLink:Get("goTuiJian");
    goXianshi = uiLink:Get("goXianshi");
    goRemainTime = uiLink:Get("goRemainTime");
    uiGoodsItem = uiLink:Get("uiGoodsItem");
    imgZheZhao = uiLink:Get("imgZheZhao"):GetComponent("Image");
    imgLeftBg = uiLink:Get("imgLeftBg"):GetComponent("Image");
    imgIcon = uiLink:Get("imgIcon"):GetComponent("Image");
    imgBg = uiLink:Get("imgBg"):GetComponent("Image");
    imgRightBg = uiLink:Get("imgRightBg"):GetComponent("Image");
    imgLine = uiLink:Get("imgLine"):GetComponent("Image");
    imgLine2 = uiLink:Get("imgLine2"):GetComponent("Image");
    imgTitle = uiLink:Get("imgTitle"):GetComponent("Image");
    scrollViewShopGift = uiLink:Get("scrollViewShopGift"):GetComponent("ScrollRect");
    scrollView = uiLink:Get("scrollView"):GetComponent("ScrollRect");
    rectContent = uiLink:Get("rectContent"):GetComponent("RectTransform");
    rectGood = uiLink:Get("rectGood"):GetComponent("RectTransform");
    btnClose = uiLink:Get("btnClose"):GetComponent("Button");
    btnBuy = uiLink:Get("btnBuy"):GetComponent("Button");
    btnSellOut = uiLink:Get("btnSellOut"):GetComponent("Button");
    textLimitInfo = uiLink:Get("textLimitInfo"):GetComponent("Text");
    textName = uiLink:Get("textName"):GetComponent("Text");
    textPrice = uiLink:Get("textPrice"):GetComponent("Text");
    textPrice2 = uiLink:Get("textPrice2"):GetComponent("Text");
    textPrice3 = uiLink:Get("textPrice3"):GetComponent("Text");
    textTag = uiLink:Get("textTag"):GetComponent("Text");
    textDisCount = uiLink:Get("textDisCount"):GetComponent("Text");
    textDes = uiLink:Get("textDes"):GetComponent("Text");
    textTime = uiLink:Get("textTime"):GetComponent("Text");
    textTitle = uiLink:Get("textTitle"):GetComponent("Text");
    rawImagePrice = uiLink:Get("rawImagePrice"):GetComponent("RawImage");
    this.Register(uiLink);
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Middle = nil;
    uiShopGiftItem = nil;
    goSecondBuyPanel = nil;
    goLeftLine = nil;
    goGoods = nil;
    goFree = nil;
    goZhekou = nil;
    goTuiJian = nil;
    goXianshi = nil;
    goRemainTime = nil;
    uiGoodsItem = nil;
    imgZheZhao = nil;
    imgLeftBg = nil;
    imgIcon = nil;
    imgBg = nil;
    imgRightBg = nil;
    imgLine = nil;
    imgLine2 = nil;
    imgTitle = nil;
    scrollViewShopGift = nil;
    scrollView = nil;
    rectContent = nil;
    rectGood = nil;
    btnClose = nil;
    btnBuy = nil;
    btnSellOut = nil;
    textLimitInfo = nil;
    textName = nil;
    textPrice = nil;
    textPrice2 = nil;
    textPrice3 = nil;
    textTag = nil;
    textDisCount = nil;
    textDes = nil;
    textTime = nil;
    textTitle = nil;
    rawImagePrice = nil;

end


this.Register=function(uiLink)
    uiLink:AddClickEvent("btnBuy",function()

        if this.data.paying or this.data.buyWay==nil then
            return
        end;

        this.data.paying=true;

        if this.data.buyWay==1 then
            LuaMgr.LuaOnAskPay(this.data.chargeId);
        elseif this.data.buyWay==0 then
            LuaDebug.error("buyWay==0 is Error,giftShop not contains buyWay ==0");
            this.data.paying=false;
            return;
        elseif this.data.buyWay==2 then
            this.ShopDirectBuy()
        end

    end)

    uiLink:AddClickEvent("btnSellOut",function()
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("10006"))
    end)

    uiLink:AddClickEvent("btnClose",function()
        SetActive(goSecondBuyPanel,false);
    end)
end


local hook = {
    before_awake = function(vm)
        this.Init(vm.behaviour.gameObject);
        RedMgr.Singleton:RegisterViewModel(UIName.ShopGiftViewModel);
        rectAin=vm.behaviour.transform:Find("root/goSecondBuyPanel"):GetComponent("Animator")
        animator=vm.behaviour.transform:Find("root/Middle/scrollViewShopGift"):GetComponent("Animator")
        local goodsItemVM=uiGoodsItem:GetComponent("GoodsViewModel");
        table.insert(goodItems,goodsItemVM)
        SetActive(uiGoodsItem,false);
        SetActive(uiShopGiftItem,false);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder,this.PayOrder);
        LuaMgr.AddUIEventListener(UIEventConst.PayOrder,this.PayOrder);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult,this.OnPayResult);
        LuaMgr.AddUIEventListener(UIEventConst.OnPayResult,this.OnPayResult);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess);
        LuaMgr.AddUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess);
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartAcrossDay,this.FrushData);
        LuaMgr.AddUIEventListener(UIEventConst.HeartAcrossDay,this.FrushData);

        rectAin.enabled = false;
        rectAin.enabled = true;
        rectAin:Rebind();
        rectAin:Play("UI_ShopGiftBagPanel_02");
        local data=vm.behaviour.Params;
        if data.Length>0 then
            local shelfId=tostring(data[0]);
            local _cfgGiftShop= ConfigMgr.Config.shop[ShopType.Push]
            for i,v in ipairs(_cfgGiftShop.shelfs) do
                if v.Id==shelfId then
                    this.data.curShelfData=v;
                    break;
                end
            end
        end
        this.data.tarGoodsId=nil;
        if data.Length>1 then
            this.data.tarGoodsId=data[1];
        end
        this.ParseData(true);
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder,this.PayOrder);
        LuaMgr.RemoveTimer(TimerConst.FristPayRechargeStatus)
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult,this.OnPayResult);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess);
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartAcrossDay,this.FrushData);
        LuaMgr.RemoveTimer(TimerConst.GiftRemainTime);

        if this.data.coroutine_Key~=nil then
            coroutine_runner.stop(this.data.coroutine_Key);
        end
    end,
    before_destroy = function(vm)
        this.Clear()
    end,
}


this.ShopDirectBuy=function()
    
    local _cfgChargeMap= ConfigMgr.Config.charge
    local charge=_cfgChargeMap[this.data.chargeId]
    
    if charge==nil then
        this.data.paying=false;
        return
    end
    
    if charge.UnlockLv>0 and DataMgr.Player.level<charge.UnlockLv then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("ShopGiftViewModel_3"))
        this.data.paying=false;
        return;
    end
    
    if DataHelper.GetItemCountById(charge.Cost.id)<charge.Cost.count then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("ShopGiftViewModel_4"))
        this.data.paying=false;
        return;
    end
    
    local askData={goods=this.data.chargeId}
    ApiMgr.Request("shop/direct_buy",askData,true,function(result)
        local re=json.decode(result);
        local data=json.encode(re.result);
        LuaMgr.ShowItemRewared(data);

        this.data.tarGoodsId = nil
        this.ParseData();
    end,function()
        this.data.paying=false;
    end,true);
    
end

this.FrushData=function()
    this.ParseData();
end

this.PayOrder=function(data)
    if data.Length==2 then
        local reChargeId=tostring(data[0]);
        this.data.order=tostring(data[1]);
        if this.data.chargeId~=reChargeId then return end;
        if LuaMgr.GetPlatform()~="EDITOR" then return end;
        LuaMgr.RemoveTimer(TimerConst.FristPayRechargeStatus)
        LuaMgr.AddTimer(TimerConst.FristPayRechargeStatus,this.OnTimer,1,100,true);
    end
end

this.OnPayResult=function(data)
    if data.Length==1 then
        if this.data.order~=nil and this.data.order~=tostring(data[0]) then return end;
        this.data.paying=false;
    end
end

this.OnPaySuccess=function(data)
    if data.Length==1 then
        if this.data.order~=nil and this.data.order~=tostring(data[0]) then return end;
        SetActive(goSecondBuyPanel,false);

        this.data.tarGoodsId = nil
        this.ParseData();
    end
end

this.OnTimer=function()
    local askData={order=this.data.order}
    ApiMgr.Request("check_recharge_status", askData, true, function(result)
        local re=json.decode(result);
        if re.result.status==2 then
            LuaMgr.RemoveTimer(TimerConst.FristPayRechargeStatus)
            local rewards=re.result.rewards;
            if rewards~=nil then
                local data=json.encode(rewards);
                LuaMgr.ShowItemRewared(data);
            end

            SetActive(goSecondBuyPanel,false);
            this.data.paying=false;
            this.ParseData();
        end

    end, nil, true);
end

this.ParseData=function()
    this.data.paying=false;
    this.data.chargeId=nil;
    SetActive(goSecondBuyPanel,false);
    this.ShowGift();
    this.ShowTargetGoods();
end

this.ShowTargetGoods=function()
    if this.data.tarGoodsId~=nil then
        SetActive(goSecondBuyPanel,true);
        rectAin.enabled = false;
        rectAin.enabled = true;
        rectAin:Rebind();
        rectAin:Play("ani_ShopPush_Fund_BuyTip");
        
        local ruleGoods=this.RuleGoods(this.data.curShelfData.goods);
        for i,v in ipairs(ruleGoods) do
            if v.Id~=nil and v.Id==this.data.tarGoodsId then
                this.ShowBuyReward(v);
                break
            end
        end
    end
end


this.RuleGoods=function(goods)
    local shopCards=DataMgr.Player.shop.records;
    local _cfgChargeMap= ConfigMgr.Config.charge
    local groupMap={}

    local charge=nil;
    for i,v in ipairs(goods) do
         charge=nil;
         charge=_cfgChargeMap[v.Id];
        if groupMap[charge.ShowGroup]==nil then
            groupMap[charge.ShowGroup]={}
        end
        table.insert(groupMap[charge.ShowGroup],v);
    end
    local groupList={}

    for i,v in pairs(groupMap) do
        local group={}
        for p,m in ipairs(v) do
            charge=nil;
            charge=_cfgChargeMap[m.Id];

            if not HeroRedDataHelper.IsOverdue(charge) then
                if charge.ShowGroup==0 then
                    if DataMgr.Player.level>=charge.UnlockLv then
                        table.insert(group,m);
                    end
                else

                    if shopCards[m.Id]==nil then
                        table.insert(group,m);
                        break;
                    end
                end
                
            end
        end
        table.insert(groupList,group);
    end
    

    local reList={}
    for i,v in ipairs(groupList) do
        for p,m in ipairs(v) do
            table.insert(reList,m);
        end
    end

    table.sort(reList,function(a, b) 
        return a.Id<b.Id;
    end)
    
    return reList;
end

this.ShowGift=function(fx)
DataReportMgr.NetClickGoodsAndPage ("",ShopType.Push,this.data.curShelfData.Id)
    local shop_sub_name = LuaMgr.GetLangText(this.data.curShelfData.NameLan)
    DataReportMgr.OpenShopView(ShopType.Push,this.data.curShelfData.Id,shop_sub_name,this.data.curShelfData.goods,3,true)
    DataReportMgr.OpenShopShowView(ShopType.Push,this.data.curShelfData.Id,shop_sub_name,this.data.curShelfData.goods,3,true)
    rectContent.anchoredPosition=Vector2(0,0);
    local ruleGoods=this.RuleGoods(this.data.curShelfData.goods);
    local index=0;
    for i,v in ipairs(ruleGoods) do
        index=index+1;
        if index>#shopGiftItems then
            if uiShopGiftItem~=nil then
                table.insert(shopGiftItems, UIShopGiftItem.New(uiShopGiftItem,rectContent))
            end
        end

        SetActive( shopGiftItems[index].gameObject,true);
        shopGiftItems[index]:SetData(v,function(good)
            this.ShowBuyReward(good);
        end);
    end
    
    for i = (index+1), #shopGiftItems do
        shopGiftItems[i]:Clear();
    end

    table.sort(shopGiftItems,function(a,b)
        if not a.seldOut and b.seldOut then
            return true;
        end
        if not a.seldOut and not b.seldOut  then
            return tonumber(a.sort)< tonumber(b.sort);
        end
        if a.seldOut and b.seldOut then
            return tonumber(a.sort)< tonumber(b.sort);
        end
    end)

    for i = 1, #shopGiftItems do
        shopGiftItems[i].transform:SetSiblingIndex(i);
    end
    
    if fx==nil then return end;

    if this.data.coroutine_Key~=nil then
        coroutine_runner.stop(this.data.coroutine_Key);
    end
    
    coroutine_runner.start(function()
        coroutine_runner.wait(0.05);
        animator.enabled = false;
        animator.enabled = true;
        animator:Rebind();
        animator:Play("ani_scrollViewShopGift_001");
    end)
end

this.ShowBuyReward=function(good)
    SetActive(goSecondBuyPanel,true);
    rectAin.enabled = false;
    rectAin.enabled = true;
    rectAin:Rebind();
    rectAin:Play("ani_ShopPush_Fund_BuyTip");
    
    local _cfgChargeMap= ConfigMgr.Config.charge
    local charge=_cfgChargeMap[good.Id];
    
    rectGood.anchoredPosition=Vector2(0,0);
    
    SetActive(textPrice3.gameObject,false);
    SetActive(goGoods,false);
    SetActive(goFree,false);
    this.data.buyWay=nil;

    textName.text=LuaMgr.GetLangText(charge.NameLan);
    imgIcon.sprite= LuaMgr.GetSprite("Shop",charge.Icon);
    this.data.buyWay=good.BuyWay;
    this.data.chargeId= good.Id;
DataReportMgr.NetClickGoodsAndPage (good.Id,ShopType.Gift,this.data.curShelfData.Id)

    local buyCount=0;
    local _dataShopRecord=DataMgr.Player.shop.records;
    local hasBuy=_dataShopRecord[charge.Id];
    if hasBuy~=nil then
        buyCount=hasBuy;
    end

    local priceStyle=0;
    local RMBPrice=nil;
    local chargeChanel=nil;
    local price_Icon=DefaultTexture;
    if charge.ChargeGroup~=nil and charge.ChargeGroup~="" then
        chargeChanel=ConfigHelper.GetChargeChannel(charge.ChargeGroup);
        RMBPrice=chargeChanel.CurrencySymbol..chargeChanel.PriceShow;
        priceStyle=0
    elseif charge.Cost.count==0 then
        priceStyle=0;
        RMBPrice=LuaMgr.GetLangText("ShopGiftViewModel_5")
    elseif charge.Cost.id~="" and charge.Cost.count~=0  then
        priceStyle=1;
        RMBPrice=tostring(charge.Cost.count);
        price_Icon=ConfigHelper.GetItemTexture_large(charge.Cost.id);
    end
    
    if this.data.buyWay==1 then
        DataReportMgr.ClickPayView(charge.Id,0);
        SetActive(textPrice3.gameObject,true);
        local chargeChannel=ConfigHelper.GetChargeChannel(charge.ChargeGroup);
        textTag.text=chargeChannel.CurrencySymbol;
        textPrice.text=chargeChannel.PriceShow;
        textPrice2.text=chargeChannel.PriceShow;
        textPrice3.text=chargeChanel.PriceShow;
    elseif this.data.buyWay==2 and charge.Cost.count~=0 then
        SetActive(goGoods,true);
        textPrice.text=RMBPrice;
        textPrice2.text=RMBPrice;
        textPrice3.text=RMBPrice;
        rawImagePrice.texture = price_Icon;
    elseif this.data.buyWay==2 and  charge.Cost.count==0 then
        SetActive(goFree,true);
        textPrice.text=RMBPrice;
        textPrice2.text=RMBPrice;
        textPrice3.text=RMBPrice;
    end

    SetActive(goTuiJian,charge.Logo=="1");
    SetActive(goXianshi,charge.Logo=="2")

    SetActive(goRemainTime,charge.RefreshCycle==5);
    textTime.text=HeroRedDataHelper.GetRemianTime(charge);
    
    local seldOut=charge.RefreshCount~=0 and charge.RefreshCount-buyCount==0;
    textLimitInfo.text=charge.RefreshCount>0 and string.format(LuaMgr.GetLangText(charge.DescriptionLan) .." ( <color=#ffffff>%s</color>/%s )",buyCount,charge.RefreshCount) or "";
    SetActive(goLeftLine,charge.RefreshCount>0 and not seldOut);
    
    local len=0;
    if charge.Reward~=nil then
        len=#charge.Reward
    end

    for i = 1, len do
        if i>#goodItems then
            table.insert(goodItems,LuaMgr.InstantiateGO(uiGoodsItem.gameObject, rectGood, false):GetComponent("GoodsViewModel"))
        end

        SetActive(goodItems[i].gameObject,true);
        goodItems[i]:SetData(tostring(charge.Reward[i].id),charge.Reward[i].count,1,1,true)
    end

    for i = (len+1), #goodItems do
       SetActive(goodItems[i].gameObject,false)
    end
    SetActive(btnSellOut.gameObject,seldOut);
    SetActive(btnBuy.gameObject, not seldOut)
end

return vm({
    hook = hook
})