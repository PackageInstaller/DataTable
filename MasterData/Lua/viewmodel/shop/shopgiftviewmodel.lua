





local this = {
    data = {
        paying=false;
        order=nil;
        shelfIndex=nil;
        chargeId=nil;
        coroutine_Key=nil;
        buyWay=nil;
        tarGoodsId=nil;
        curShowGiftPageName = nil;
    }
};

require("ViewModel/Shop/UIShlefItem")
require("ViewModel/Shop/UIShopGiftItem")
require("ViewModel/Shop/UIShopGiftGoodItem")

local tarGameObject = nil;
local tarRect = nil;
local uiShlefItem = nil;
local rectShelf = nil;
local shelfItems ={};
local shopGiftItems={};
local rectContent=nil;
local uiShopGiftItem=nil;
local goodItems={};
local uiGoodsItem=nil;
local rectGood=nil;
local scrollViewShelf=nil;
local rectAin=nil;
local goSecondBuyPanel;
local imgIcon=nil;
local goLeftLine=nil;
local textLimitInfo=nil;
local textName=nil;
local goGoods=nil;
local rawImagePrice=nil;
local textPrice=nil;
local goFree=nil;
local textPrice2=nil;
local goPrice=nil;
local textTag=nil;
local goZhekou=nil;
local textDisCount=nil;
local goTuiJian=nil;
local goXianshi=nil;
local goRemainTime=nil;
local textTime=nil;
local animator=nil;
local btnBuy=nil;
local btnSellOut=nil;
local scrollViewRect = nil;
local pageRect = nil;
local textTip=nil;
local btnJump=nil;

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    uiShlefItem = uiLink:Get("UIShlefItem");
    SetActive(uiShlefItem,false);
    rectShelf = uiLink:Get("rectShelf"):GetComponent("RectTransform");
    rectContent=uiLink:Get("rectContent"):GetComponent("RectTransform");
    uiShopGiftItem=uiLink:Get("UIShopGiftItem")
    uiGoodsItem=uiLink:Get("uiGoodsItem"):GetComponent("GoodsViewModel");
    rectGood=uiLink:Get("rectGood"):GetComponent("RectTransform");
    animator=uiLink:Get("scrollViewShopGift"):GetComponent("Animator");
    scrollViewRect=uiLink:Get("scrollViewShopGift"):GetComponent("RectTransform");
    pageRect=uiLink:Get("rectPage"):GetComponent("RectTransform");
    scrollViewShelf=uiLink:Get("scrollViewShelf"):GetComponent("ScrollRect")
    rectAin=uiLink:Get("root"):GetComponent("Animator");
    goSecondBuyPanel=uiLink:Get("root").transform:Find("BuyTip").gameObject;
    imgIcon=uiLink:Get("imgIcon"):GetComponent("Image");
    goLeftLine=uiLink:Get("goLeftLine");
    textLimitInfo=uiLink:Get("textLimitInfo"):GetComponent("Text");
    textName=uiLink:Get("textName"):GetComponent("Text");
    goGoods=uiLink:Get("goGoods");
    rawImagePrice=uiLink:Get("rawImagePrice"):GetComponent("RawImage");
    textPrice=uiLink:Get("textPrice"):GetComponent("Text");
    goFree=uiLink:Get("goFree");
    textPrice2=uiLink:Get("textPrice2"):GetComponent("Text");
    goPrice=uiLink:Get("goPrice"):GetComponent("Text");
    textTag=uiLink:Get("textTag"):GetComponent("Text");
    goZhekou=uiLink:Get("goZhekou");
    textDisCount=uiLink:Get("textDisCount"):GetComponent("Text");
    goTuiJian=uiLink:Get("goTuiJian");
    goXianshi=uiLink:Get("goXianshi");
    goRemainTime=uiLink:Get("goRemainTime")
    textTime=uiLink:Get("textTime"):GetComponent("Text");
    btnBuy=uiLink:Get("btnBuy"):GetComponent("Button");
    btnSellOut=uiLink:Get("btnSellOut"):GetComponent("Button");
    textTip=uiLink:Get("textTip"):GetComponent("Text");
    btnJump=uiLink:Get("btnJump"):GetComponent("Button");
    
    table.insert(goodItems,uiGoodsItem)
    SetActive(uiShopGiftItem,false);
    
    uiLink:AddClickEvent("btnBuy",function()
        if this.data.paying or this.data.buyWay==nil then
            return
        end;
        local charge=ConfigMgr.Config.charge[this.data.chargeId];

        if charge~=nil and charge.Shelf=="4001008" and this.CheckCycleBagBuyTips(charge.Id)  then
            LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,ConfigMgr.LangGlobal("23685"),this.BtnBuyExecute,nil);
        else
            this.BtnBuyExecute();
        end
    end)

    uiLink:AddClickEvent("btnSellOut",function()
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("10006"))
    end)

    uiLink:AddClickEvent("btnClose",function()
        SetActive(goSecondBuyPanel,false);
    end)
    uiLink:AddClickEvent("btnJump",function()
        if this.jumpInfo~=nil then
            HeroParameter.giftJump="gift";
            LuaMgr.HidePanel(UIName.ShopGiftViewModel);
            LuaMgr.ShowLuaPanel(UIName.HeroSkinViewModel,this.jumpInfo.id, this.jumpInfo.skinId)
        end
    end)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    uiShlefItem = nil;
    rectShelf = nil;
end

local hook = {
    before_awake = function(vm)
        this.Init(vm.behaviour.gameObject);
        RedMgr.Singleton:RegisterViewModel(UIName.ShopGiftViewModel);
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
        LuaMgr.RemoveUIEventListener(UIEventConst.ShopGiftPanelRefresh,this.FrushData);
        LuaMgr.AddUIEventListener(UIEventConst.ShopGiftPanelRefresh,this.FrushData);

        rectAin.enabled = false;
        rectAin.enabled = true;
        rectAin:Rebind();
        rectAin:Play("UI_ShopGiftBagPanel_02");
        local _cfgGiftShop= ConfigMgr.Config.shop[ShopType.Gift]
        local data=vm.behaviour.Params;
        if data.Length>0 then
          local shelftName=tostring(data[0]);
            if shelftName~="nil" then
                local index=1;
                for i,v in ipairs(_cfgGiftShop.shelfs) do
                    if v.Id==shelftName then
                        this.data.shelfIndex=i;
                        break;
                    end
                end
                
            end
        end
        this.data.shelfIndex=this.data.shelfIndex or 1;
        if this.data.shelfIndex>1 and not this.CheckIsOnlineShelf(_cfgGiftShop.shelfs[this.data.shelfIndex]) then
            this.data.shelfIndex=1;
        end
        this.data.tarGoodsId=nil;
        if data.Length>1 then
            this.data.tarGoodsId=data[1];
        end
        
        this.ParseData(true);
        scrollViewShelf.normalizedPosition= Vector2.one;
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder,this.PayOrder);
        LuaMgr.RemoveTimer(TimerConst.FristPayRechargeStatus)
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult,this.OnPayResult);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess);
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartAcrossDay,this.FrushData);
        LuaMgr.RemoveUIEventListener(UIEventConst.ShopGiftPanelRefresh,this.FrushData);
        LuaMgr.RemoveTimer(TimerConst.GiftRemainTime);

        if this.data.coroutine_Key~=nil then
            coroutine_runner.stop(this.data.coroutine_Key);
        end
        if not IsNullOrEmpty(this.data.curShowGiftPageName) then
            LuaMgr.HidePanel(this.data.curShowGiftPageName)
            this.data.curShowGiftPageName = ""
            this.data.shelfIndex = 1
        end
    end,
    before_destroy = function(vm)
        this.Clear()
    end,
}


this.BtnBuyExecute=function()
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
end



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
        this.CheckTips();
        this.ParseData();
    end
end

this.OnTimer=function()
    local askData={order=this.data.order}
    ApiMgr.Request("check_recharge_status", askData, true, function(result)
        local re=json.decode(result);
        if re.result.status==2 then
            LuaMgr.RemoveTimer(TimerConst.FristPayRechargeStatus)
            LuaMgr.InvokeUIEventListeners(UIEventConst.ShopGiftBuyEditorSuccess, this.data.order);
            local rewards=re.result.rewards;
            if rewards~=nil then
                local data=json.encode(rewards);
                LuaMgr.ShowItemRewared(data);
            end
            this.CheckTips();
            SetActive(goSecondBuyPanel,false);
            this.data.paying=false;
            this.ParseData();
        end

    end, nil, true);
end

this.CheckTips=function()
    if this.data.chargeId==nil then return end;
    local charge=ConfigMgr.Config.charge[this.data.chargeId]
    if charge.Shelf=="4001008" then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("23505"))
    end
end

this.ParseData=function()
    HeroRedDataHelper.FrushMainShopRed();
    this.data.paying=false;
    this.data.chargeId=nil;
    SetActive(goSecondBuyPanel,false);
    this.SetShelfBar();
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
        
        local _cfgGiftShop= ConfigMgr.Config.shop[ShopType.Gift]
        local goods= _cfgGiftShop.shelfs[this.data.shelfIndex].goods;
        local shelfId=_cfgGiftShop.shelfs[this.data.shelfIndex].Id;
        local ruleGoods=this.RuleGoods(goods,shelfId);
        for i,v in ipairs(ruleGoods) do
            if v.Id~=nil and v.Id==this.data.tarGoodsId then
                this.ShowBuyReward(v);
                break
            end
        end
    end
end

this.SetShelfBar=function()
    local _cfgGiftShop= ConfigMgr.Config.shop[ShopType.Gift]
    local index=0;

    for i,v in ipairs(_cfgGiftShop.shelfs) do
        if this.CheckIsOnlineShelf(v) then
            index = index + 1
            if index>#shelfItems then
                table.insert(shelfItems,UIShlefItem.New(uiShlefItem,rectShelf))
            end

            if shelfItems[index]~=nil then
                SetActive(shelfItems[index].gameObject,true);
                shelfItems[index]:SetData(v,i,i==this.data.shelfIndex,function(shelfIndex)
                    this.data.shelfIndex=shelfIndex;
                    this.OnSwitchShelfBar()
                    this.SetShelfBar();
                    this.ShowGift(true);
                end);
            else
                print("shelfItems[index] is nil")
            end
        end
    end

    for i = (index+1), #shelfItems do
        if shelfItems[i]~=nil then
            shelfItems[i]:Clear();
        end
    end
    
    scrollViewShelf.vertical=index > 5
end

this.CheckIsOnlineShelf=function(shelf)
    if shelf.EndTime==0 or shelf.StartTime==0 then
        return true;
    end
    if LuaMgr.Timestamp()>=shelf.StartTime and LuaMgr.Timestamp()<shelf.EndTime then
        return true;
    end
    return false;
end

this.RuleGoods=function(cfgGoods,shelfId)
    local goods=table.Copy(cfgGoods);
    local shopCards=DataMgr.Player.shop.records;
    local _cfgChargeMap= ConfigMgr.Config.charge
    local groupMap={}
local overdueStillShowMap = {}

    if shelfId == "4001008" then
        for i = #goods, 1, -1 do
            local charge = _cfgChargeMap[goods[i].Id];
            local reDay, arrayIndex, batchId = DataHelper.GetCycleBagRemainDays(goods[i].Id)
            local cycleBags = ConfigMgr.Config.CycleBagMap[tostring(batchId)]
            if arrayIndex == 1 and reDay >= 0 and cycleBags ~= nil and #cycleBags.ChargeId > 1 then
                table.remove(goods, i);
elseif HeroRedDataHelper.IsOverdue(charge) then
                if reDay >= 0 then
                    goods[i].buyWay = 0
                    overdueStillShowMap[charge.Id] = true
                else
                    table.remove(goods, i);
                end
            end
        end
    end
    

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

            if not HeroRedDataHelper.IsOverdue(charge) or overdueStillShowMap[charge.Id] ~= nil then
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
    local _cfgGiftShop= ConfigMgr.Config.shop[ShopType.Gift]
DataReportMgr.NetClickGoodsAndPage ("",ShopType.Gift,_cfgGiftShop.shelfs[this.data.shelfIndex].Id)
    local shop_sub_name = LuaMgr.GetLangText(_cfgGiftShop.shelfs[this.data.shelfIndex].NameLan)
    DataReportMgr.OpenShopView(ShopType.Gift,_cfgGiftShop.shelfs[this.data.shelfIndex].Id,shop_sub_name,_cfgGiftShop.shelfs[this.data.shelfIndex].goods,3,true)
    DataReportMgr.OpenShopShowView(ShopType.Gift,_cfgGiftShop.shelfs[this.data.shelfIndex].Id,shop_sub_name,_cfgGiftShop.shelfs[this.data.shelfIndex].goods,3,true)
    rectContent.anchoredPosition=Vector2(0,0);
if _cfgGiftShop.shelfs[this.data.shelfIndex].Type == 6 then
        SetActive(pageRect.gameObject, true)
        SetActive(scrollViewRect.gameObject, false)
        if not IsNull(_cfgGiftShop.shelfs[this.data.shelfIndex].Jump) then
            local panelName = _cfgGiftShop.shelfs[this.data.shelfIndex].Jump[1]
            if not IsNullOrEmpty(panelName) then
                this.data.curShowGiftPageName = panelName
                LuaMgr.ShowLuaPanel(panelName, _cfgGiftShop.shelfs[this.data.shelfIndex].goods, this.ShowBuyReward);
            end
        end
    else
        SetActive(pageRect.gameObject, false)
        SetActive(scrollViewRect.gameObject, true)
        local goods= _cfgGiftShop.shelfs[this.data.shelfIndex].goods;
        local shelfId=_cfgGiftShop.shelfs[this.data.shelfIndex].Id;
        local ruleGoods=this.RuleGoods(goods,shelfId);
        local index=0;
        for i,v in ipairs(ruleGoods) do
            index=index+1;
            if index>#shopGiftItems then
                table.insert(shopGiftItems, UIShopGiftItem.New(uiShopGiftItem,rectContent))
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


    if _cfgGiftShop.shelfs[this.data.shelfIndex].Id == "4001007" then
        PlayerPrefs.SetInt(DataMgr.Player.uid .. "Shop_Shelf_4001007", 1)
        HeroRedDataHelper.FrushMainShopRed()
        RedMgr.Singleton:RefreshOtherViewModel(UIName.ShopGiftViewModel);
    end
end

this.ShowBuyReward=function(good, hideBuyBtn)
    local _cfgGiftShop= ConfigMgr.Config.shop[ShopType.Gift]
    local _cfgChargeMap= ConfigMgr.Config.charge
    local charge=_cfgChargeMap[good.Id];

    this.jumpInfo=nil;
    if not IsNullOrEmpty(charge.Preview) then
        local characterId=string.sub(charge.Preview, 1,5);
        if DataMgr.Player.characters[characterId]~=nil then
            SetActive(btnJump.gameObject,true)
            this.jumpInfo={id=characterId,skinId=charge.Preview}
        else
            SetActive(btnJump.gameObject,false)
        end
    else
        SetActive(btnJump.gameObject,false)
    end
    

    if charge.Shelf=="4001008" and charge.RefreshCycle==6 then
        local reDayNum=DataHelper.GetCycleBagRemainDays(charge.Id)
        if reDayNum+charge.Days>charge.MaxDays then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("23504"));
            return;
        end
    end
    SetActive(goSecondBuyPanel,true);
    rectAin.enabled = false;
    rectAin.enabled = true;
    rectAin:Rebind();
    rectAin:Play("ani_ShopPush_Fund_BuyTip");
    rectGood.anchoredPosition=Vector2(0,0);
    SetActive(goPrice.gameObject,false);
    SetActive(goGoods,false);
    SetActive(goFree,false);
    this.data.buyWay=nil;

    textName.text=LuaMgr.GetLangText(charge.NameLan);
    imgIcon.sprite= LuaMgr.GetSprite("Shop",charge.Icon);
    this.data.buyWay=good.BuyWay;
    this.data.chargeId= good.Id;
DataReportMgr.NetClickGoodsAndPage (good.Id,ShopType.Gift,_cfgGiftShop.shelfs[this.data.shelfIndex].Id)

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
        SetActive(goPrice.gameObject,true);
        local chargeChannel=ConfigHelper.GetChargeChannel(charge.ChargeGroup);
        textTag.text=chargeChannel.CurrencySymbol;
        textPrice.text=chargeChannel.PriceShow;
        textPrice2.text=chargeChannel.PriceShow;
        goPrice.text=chargeChanel.PriceShow;
    elseif this.data.buyWay==2 and charge.Cost.count~=0 then
        SetActive(goGoods,true);
        textPrice.text=RMBPrice;
        textPrice2.text=RMBPrice;
        goPrice.text=RMBPrice;
        rawImagePrice.texture = price_Icon;
    elseif this.data.buyWay==2 and  charge.Cost.count==0 then
        SetActive(goFree,true);
        textPrice.text=RMBPrice;
        textPrice2.text=RMBPrice;
        goPrice.text=RMBPrice;
    end

    SetActive(goTuiJian,charge.Logo=="1");
    SetActive(goXianshi,charge.Logo=="2")
    SetActive(goRemainTime,charge.RefreshCycle==5);
    textTime.text=HeroRedDataHelper.GetRemianTime(charge);
    if charge.RefreshCycle==6 then
        local dayNum=DataHelper.GetCycleBagRemainDays(charge.Id)
        local tips=dayNum<0 and ConfigMgr.LangGlobal("23501") or ConfigMgr.LangGlobal("23502")
        textLimitInfo.text=dayNum<0 and string.format(tips,charge.MaxDays) or string.format(tips,dayNum);
        textTip.text=ConfigMgr.LangGlobal("23503");
    else
        textTip.text="";
        textLimitInfo.text=charge.RefreshCount>0 and string.format(LuaMgr.GetLangText(charge.DescriptionLan) .." ( <color=#ffffff>%s</color>/%s )",buyCount,charge.RefreshCount) or "";
    end
    local seldOut=charge.RefreshCycle~=6 and charge.RefreshCount~=0 and charge.RefreshCount-buyCount<=0;
    SetActive(goLeftLine,charge.RefreshCount>0 and not seldOut);
    local rewardList=charge.Reward;

    if charge.Shelf=="4001008"  then
        rewardList=charge.DayGoods;
    end
    local len=0;
    if not IsNull(rewardList) then
        len=#rewardList
    end

    for i = 1, len do
        if i>#goodItems then
            table.insert(goodItems,LuaMgr.InstantiateGO(uiGoodsItem.gameObject, rectGood, false):GetComponent("GoodsViewModel"))
        end

        SetActive(goodItems[i].gameObject,true);
        goodItems[i]:SetData(tostring(rewardList[i].id),rewardList[i].count,1,1,true)
    end

    for i = (len+1), #goodItems do
       SetActive(goodItems[i].gameObject,false)
    end
    SetActive(btnSellOut.gameObject,seldOut);
    SetActive(btnBuy.gameObject, not seldOut)
    if hideBuyBtn then
        SetActive(btnBuy.gameObject, false)
    end
end

this.OnSwitchShelfBar = function()
    if not IsNullOrEmpty(this.data.curShowGiftPageName) then
        LuaMgr.HidePanel(this.data.curShowGiftPageName)
        this.data.curShowGiftPageName = ""
        SetActive(pageRect.gameObject, false)
        SetActive(scrollViewRect.gameObject, true)
    end
end

this.CheckCycleBagBuyTips=function(chargeId)
    local remainDay=-1;
    if IsNull(DataMgr.Player.CycleTimeGift) or IsNull(DataMgr.Player.CycleTimeGift.items) then
        return false;
    end
    local batchId=DataHelper.GetCycleBagBatchIDByChargeId(chargeId);
    local itemData=DataMgr.Player.CycleTimeGift.items[tostring(batchId)]
    if itemData==nil then
        return false;
    end
    if itemData.day==0 then
        local date=os.date("*t",LuaMgr.Timestamp());


        local timeStamp_4=os.time({year=date.year,month=date.month,day=date.day,hour=4,min=0,sec=00});
        if itemData.send<timeStamp_4 and LuaMgr.Timestamp()>timeStamp_4 then
            return false;
        end
    end
    remainDay= itemData.day;
    return remainDay>=0;
    
end
    



return vm({
    hook = hook
})