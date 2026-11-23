





local this = {
    vm=nil,
    data={
        paying=false,
        chargeList={},
        PAGE_ITEMICON_PATH="Assets/_BundleResources/Images/ItemIcons/itemicon_home_",
        chargeId=nil,
        order=nil,
        rectContent=nil,
        rectScrollView=nil,
    }
};

local data = {
    chargeItemList={
        {
            id = "";
            count = "";
            icon = DefaultTexture;
            price = "";
            priceIcon = DefaultTexture;
            doubleBool = false;
            givingBool = false;
            givingValue = "";
            locPos=Vector2(0,0);
            sprite=DefaultSprite;
        }
    },

    layoutWidth=Vector2.one,
    horizontal=true,
}

local command = {

    PayBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.data.paying then
                return
            end ;
            this.data.paying = true;
            local index = tonumber(param) + 1;
            this.data.chargeId =  this.data.chargeList[index].Id;
            if  this.data.chargeId ~= nil then
DataReportMgr.NetClickGoodsAndPage (this.data.chargeId,ShopType.Charge,ShopType.Charge)
                LuaMgr.LuaOnAskPay( this.data.chargeId);
            end
        end

    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        this.data.rectContent=vm.behaviour.transform:Find("root/Middle/ScrollView/Viewport/Content"):GetComponent("RectTransform");
        this.data.rectScrollView=vm.behaviour.transform:Find("root/Middle/ScrollView"):GetComponent("RectTransform");
    end,
    
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder, this.PayOrder);
        LuaMgr.AddUIEventListener(UIEventConst.PayOrder, this.PayOrder);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult, this.OnPayResult);
        LuaMgr.AddUIEventListener(UIEventConst.OnPayResult, this.OnPayResult);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess, this.OnPaySuccess);
        LuaMgr.AddUIEventListener(UIEventConst.OnPaySuccess, this.OnPaySuccess);
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat, this.FrushData);
        LuaMgr.AddUIEventListener(UIEventConst.HeartBeat, this.FrushData);

        local tab = nil;
        if vm.behaviour.Params.Length > 0 then
            local data = vm.behaviour.Params;
            tab = data[0];
        else
            tab = "charge";
        end

        this.data.paying = false;
        this.ParseData();

        DataReportMgr.ClickPayView("",1);
DataReportMgr.NetClickGoodsAndPage ("",ShopType.Charge,ShopType.Charge)
    end,

    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder, this.PayOrder);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult, this.OnPayResult);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess, this.OnPaySuccess);
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat, this.FrushData);
    end,

    before_destroy = function(vm)
        this.vm.data = nil;
        this.vm.behaviour = nil;
        this.vm = nil;
        this.data=nil;
    end,
}



this.FrushData=function()
    this.ParseData();
end


this.ParseData=function()
    this.data.chargeId=nil;
    this.data.order=nil;
    this.SetCharge();
    HeroRedDataHelper.FrushMainShopRed();
end

this.SetCharge=function()
    this.data.chargeList={}
    for i, v in pairs(ConfigMgr.Config.charge) do
        if v.Type==1 then
            table.insert( this.data.chargeList,v);
        end
    end
    if # this.data.chargeList==0 then
        this.vm.data.chargeItemList={};
        return 
    end;

    table.sort( this.data.chargeList,function(a,b) return a.Id<b.Id  end);
    this.vm.data.chargeItemList={};
    local list={}
    local chargeItem=nil
    for i,v in ipairs( this.data.chargeList) do
        local charge=v;
        local fristBonus=charge.FirstBonusCount>0 and DataHelper.GetRechargeCount(charge.Id)==0 ;
        local grvingBonus=charge.NormalBonusCount>0 and DataHelper.GetRechargeCount(charge.Id)>0;
        
        local givingItemID=nil;
        if fristBonus then
            givingItemID=charge.FirstBonusItem;
        elseif grvingBonus then
            givingItemID=charge.NormalBonusItem;
        end
        
        local chargeChanel=ConfigHelper.GetChargeChannel(charge.ChargeGroup);
        local price=chargeChanel~=nil and  chargeChanel.CurrencySymbol..chargeChanel.PriceShow or "";
        local _locPos=Vector2(-76.3,-117.2);

        local _givingBool=fristBonus or grvingBonus;
        if not _givingBool and charge.Counts>=10  then
            _locPos=Vector2(-57.0,-117.2);
        end

        local _sprite=DefaultSprite;
        if charge.FirstBonusCount then
            _sprite=LuaMgr.GetSprite("AreaDialy","ui_shop_cz_z_01");
        end
        
        if charge.NormalBonusCount then
            _sprite=LuaMgr.GetSprite("AreaDialy","ui_shop_cz_bonus2");
        end
        
        chargeItem={
            id=charge.Id;
            count=tostring(charge.Counts);
            icon=LuaMgr.GetTexture(Path.CharageIconPath..charge.ChargeGroup..".png");
            price=price;
            priceIcon=givingItemID~=nil and LuaMgr.GetTexture(this.data.PAGE_ITEMICON_PATH..givingItemID..".png") or DefaultTexture;
            doubleBool=fristBonus;
            givingBool=_givingBool;
            locPos=_locPos;
            givingValue=fristBonus and tostring(charge.FirstBonusCount) or tostring(charge.NormalBonusCount);
            sprite=_sprite;
        }
        table.insert(list,chargeItem);
        
    end
    this.vm.data.chargeItemList=list;
    this.data.rectContent.anchoredPosition=Vector2.zero;
    list=nil;
    
    LuaMgr.NextFrame(function()

        if this.vm==nil then return end;
        local width=LuaMgr.GetScreenWidth();
        if width>1336 then
            local num=#this.vm.data.chargeItemList;
            if num>6 then

            else
                this.data.rectScrollView.pivot=Vector2(0.5,0.5);
                this.data.rectScrollView.anchorMax=Vector2(0.5,0.5);
                this.data.rectScrollView.anchorMin=Vector2(0.5,0.5);
                local x=math.abs(231.666*num)
                this.data.rectScrollView.sizeDelta=Vector2(x,math.abs(this.data.rectContent.sizeDelta.y));
                this.vm.data.horizontal=false
            end
            end
    end)
    DataReportMgr.OpenShopView(ShopType.Charge,"",LuaMgr.GetLangText("MainShopViewModel_27"),this.data.chargeList,1)
    DataReportMgr.OpenShopShowView(ShopType.Charge,"",LuaMgr.GetLangText("MainShopViewModel_27"),this.data.chargeList,1)
end


this.PayOrder=function(data)
    if data.Length==2 then
        local reChargeId=tostring(data[0]);
        this.data.order=tostring(data[1]);
        if  this.data.chargeId~=reChargeId then return end;
        if LuaMgr.GetPlatform()~="EDITOR" then return end;
        LuaMgr.RemoveTimer(TimerConst.FristPayRechargeStatus)
        LuaMgr.AddTimer(TimerConst.FristPayRechargeStatus,this.OnTimer,1,100,true);
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
            this.data.paying=false;
            this.ParseData();
        end

    end, nil, true);
end


this.OnPayResult=function(data)
    if data.Length==1 then
        if this.data.order~=nil and this.data.order~=tostring(data[0]) then return end;
        this.data.paying=false;
    end
end

this.OnPaySuccess=function(data)
    if data.Length==1 then
        if  this.data.order~=nil and this.data.order~=tostring(data[0]) then return end;
        this.data.paying=false;
        this.ParseData();
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})