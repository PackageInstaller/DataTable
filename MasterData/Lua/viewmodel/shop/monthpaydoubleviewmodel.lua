




local this = {
    vm=nil;
    data=
    {
        cfgCharge={};
        cfgMissionMap={};
        purchaseTime={};
        chargeId=nil;
        order=nil;
        paying=false;
    }
};

local data = {
    secondBuyPanel=false;
    rewardList={{}};
    dayRewardList={{}};
    secondRwardList={{}};
    secondDayRewardList={{}};
    priceSymbol="";
    goodOriPrice="";
    goodPrice="";
    remainDayNum="";
    playAnimName = "";
    remainDayNumBool=false;
    discountBool=false;
    rewardBtnBool=false;
    hasRewardBool=false;
    noRewardBool=false;
    buyBtnBool=false;
    noBuyBool=false;
}

local command = {

    firstBuyBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.SetSecondBuyPanel();
        end
    },
    secondBuyBtn={
      type=XLuaCommandType.Void,
      execute=function(vm,param)
          if this.data.paying then return end;
          this.data.paying=true;
          LuaMgr.LuaOnAskPay(this.data.chargeId);
      end
    },
    secondBuyPanelCloseBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.CloseSecondBuyPanel();
        end
    },






}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder,this.PayOrder);
        LuaMgr.AddUIEventListener(UIEventConst.PayOrder,this.PayOrder);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult,this.OnPayResult);
        LuaMgr.AddUIEventListener(UIEventConst.OnPayResult,this.OnPayResult);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess);
        LuaMgr.AddUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess);
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartAcrossDay,this.FrushData);
        LuaMgr.AddUIEventListener(UIEventConst.HeartAcrossDay,this.FrushData);

        this.vm.data.playAnimName = "UI_ShopPush_Month_02";
        local data=vm.behaviour.Params;
        this.data.chargeId=tostring(data[0]);
        this.data.cfgCharge=ConfigMgr.Config.charge[this.data.chargeId];
        this.data.cfgMissionMap=ConfigMgr.Config.missionMap;
        this.ParseData();
        DataReportMgr.ClickPayView(this.data.chargeId,2);
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder,this.PayOrder);
        LuaMgr.RemoveTimer(TimerConst.FristPayRechargeStatus)
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult,this.OnPayResult);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess);
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartAcrossDay,this.FrushData);
    end,

    before_destroy = function(vm)
        this.vm.data = nil;
        this.vm.behaviour = nil;
        this.vm = nil;
        this.data = nil;
    end,
}

this.FrushData=function()
    this.ParseData();
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
            this.data.paying=false;
            LuaMgr.RemoveTimer(TimerConst.FristPayRechargeStatus)
            local rewards=re.result.rewards;
            if rewards~=nil then
                local data=json.encode(rewards);
                LuaMgr.ShowItemRewared(data);
            end
            this.vm.data.secondBuyPanel=false;
            this.ParseData();
        end

    end, nil, true);
end
this.OnPayResult=function()
    this.data.paying=false;
end
this.OnPaySuccess=function()
    this.CloseSecondBuyPanel();
    this.ParseData();
end

this.ParseData=function()
    this.data.paying=false;
    this.data.purchaseTime=DataMgr.Player.shop.purchaseTime;
    this.vm.data.secondBuyPanel=false;
    this.vm.data.rewardList={};
    this.vm.data.dayRewardList={};
    this.vm.data.rewardList=this.SetReward(0.72)
    this.SetButtonState();
end

this.SetButtonState=function()
    this.vm.data.buyBtnBool=this.Che;
    this.vm.data.noBuyBool=false;
    this.vm.data.remainDayNumBool=false

    if not this.CheckHasBuy() then
        this.vm.data.buyBtnBool=true;
        this.vm.data.remainDayNumBool=false
        this.vm.data.noBuyBool=false;
    else
        this.vm.data.buyBtnBool=false;
        this.vm.data.remainDayNumBool=true
        this.vm.data.noBuyBool=true;
        local curTime=LuaMgr.Timestamp()-4*60*60;
        local curDate=os.date("*t",curTime);
        local days=GetDaysByMonth(curDate.year,curDate.month)
        this.vm.data.remainDayNum=days-curDate.day;
    end
    
    local chargeChannel=ConfigHelper.GetChargeChannel(this.data.cfgCharge.ChargeGroup);
    this.vm.data.priceSymbol=chargeChannel.CurrencySymbol;
    this.vm.data.goodOriPrice=chargeChannel.PriceShow;

    if HeroParameter.MonthBuyTipActive~=nil and HeroParameter.MonthBuyTipActive then
        this.SetSecondBuyPanel();
        HeroParameter.MonthBuyTipActive=nil;
    end
end

this.CheckHasBuy=function()
    if IsNull(this.data.purchaseTime) or this.data.purchaseTime[this.data.chargeId]==nil then 
        return false;
    end
    local payTime=this.data.purchaseTime[this.data.chargeId]-4*60*60
    local curTime=LuaMgr.Timestamp()-4*60*60;
    local payDate=os.date("*t",payTime);
    local curDate=os.date("*t",curTime);
    return payDate.year==curDate.year and payDate.month==curDate.month
end


this.SetSecondBuyPanel=function()
    this.vm.data.secondBuyPanel=true;
    this.vm.data.secondRwardList={};
    this.vm.data.secondDayRewardList={};
    this.vm.data.secondRwardList=this.SetReward(0.625)

    this.vm.data.playAnimName = "ani_ShopPush_Fund_BuyTip";
DataReportMgr.NetClickGoodsAndPage (this.data.chargeId,ShopType.Push,"3001005")
end

this.CloseSecondBuyPanel=function()
    this.vm.data.secondBuyPanel=false;
end

this.SetReward=function(scale)
    local reward=this.data.cfgCharge.Reward;
    local list={};
    for i,v in ipairs(reward) do
        local item =ConfigMgr.Config.itemMap[tostring(v.id)];
        local rewardItem={id=tostring(v.id),count=LuaMgr.NumFormat(v.count),isCount=true,
                          rare=ActivityMgr.GetRareSprite(item.rare),
                          icon=ActivityMgr.GetItemTexture(tostring(v.id)),
                          scale=Vector3(scale,scale,scale),
                          sizeDelta=Vector2(128*scale,128*scale),
                          isClick=true}
        table.insert(list,rewardItem);
    end
    return list;
end

this.SetDayReward=function(scale)
    local dayReward=this.data.cfgCharge.DayGoods;
    local list={};
    for i,v in ipairs(dayReward) do
        local item =ConfigMgr.Config.itemMap[tostring(v.id)];
        local rewardItem={id=tostring(v.id),count=LuaMgr.NumFormat(v.count),isCount=true,
                          rare=ActivityMgr.GetRareSprite(item.rare),
                          icon=ActivityMgr.GetItemTexture(tostring(v.id)),
                          scale=Vector3(scale,scale,scale),
                          sizeDelta=Vector2(128*scale,128*scale),
                          isClick=true}
        table.insert(list,rewardItem);
    end
    return list;
end

return vm({
    data = data,
    command = command,
    hook = hook
})