






local this = {
    vm = nil;
    data = {
        cfgCharge={};
        init=false;
        chargeId=nil;
        order=nil;
        paying=false; 
        itemId=nil;
    }
};

local data = {
    secondBuyPanel=false,
    playAnimName = "",
    joiningBool=false,
    joinedBool=false,
    diamondIcon=DefaultTexture,
    totalIcon=DefaultTexture,
    totalDiamondNum="",
    nowDiamondNum="",
    nowDiamondNum_x="",
    remainDiamondNum_x="",
    buyPrice="",
    priceSymbol="",
    
    rewardBtnBool=false;
    hasRewardBool=false;
    noRewardBool=false;
    
    taskContentAnchor=Vector2(0,0);
    
    taskList={
        {
            bg = DefaultSprite,
            des = "",
            goodsList_free={{}},
            goodsList_pay={{}},
            alpha=1.0,
            sliderValue=0.0,
            sliderText="",
            isBtnFree=false,
            isBtnPay=false,
            isPass=false;
        }
    },
    goodList={
        {
            isLock=false,
            isReward=false,
            isRewarding=false,
            goodAlpha=1.0,
        }
    },
    goodList2={
        {
            isLock=false,
            isReward=false,
            isRewarding=false,
            goodAlpha=1.0,
        }
    },
    remainTime="";
  
}

local command = {
    BuyFirstBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.vm.data.secondBuyPanel=true;
            this.vm.data.playAnimName = "ani_ShopPush_Fund_BuyTip"
            this.ShowBuyReward();
        end
    },
    BuySecondBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if this.CheckPassesIsExpired() then
                return
            end
            if this.data.paying then return end;
            this.data.paying=true;
            LuaMgr.LuaOnAskPay(this.data.chargeId);
        end
    },
    RewardFreeBtn={
      type=XLuaCommandType.Void,
      execute=function(vm,param)
          local index=tonumber(param)+1;
          local id=this.vm.data.taskList[index].id;
          this.OnAskReward("all",2);
      end
    },
    RewardPayBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param)+1;
            local id=this.vm.data.taskList[index].id;
            this.OnAskReward("all",2);
        end
    },
    closeSecondPanelBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.vm.data.secondBuyPanel=false;
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
          

        this.SetCurWheelDrawPasses();
        if this.data.cfgDrawPasses==nil then
            return
        end
        this.data.chargeId=this.data.cfgDrawPasses.Charge1[1];
        this.data.cfgCharge=ConfigMgr.Config.charge[this.data.chargeId];
        this.vm.data.playAnimName = "ani_ShopPush_Fund_BG"
        this.data.init=false;
        this.vm.data.diamondIcon=ConfigHelper.GetItemTexture(this.data.cfgCharge.Reward[1].id)
        this.vm.data.nowDiamondNum= this.data.cfgCharge.Reward[1].count;
        this.vm.data.nowDiamondNum_x="X".. this.data.cfgCharge.Reward[1].count;
        this.ParseData();
        DataReportMgr.ClickPayView(this.data.chargeId,4);
    end ,
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





this.OnAskReward=function(pid,ptype)
    if this.CheckPassesIsExpired() then
        return
    end
    local askData={
        passesID=this.data.cfgDrawPasses.Id,
        id=pid,
        type=ptype,
    }
    ApiMgr.Request("passes/get_level_award",askData,true,function(result)
        local re=json.decode(result);
        local data=json.encode(re.result);
        LuaMgr.ShowItemRewared(data);
        this.ParseData();
        HeroRedDataHelper.FrushMainShopRed();
    end,nil,true)
end



this.SetCurWheelDrawPasses=function()
    this.data.drawPasses=nil;
    for i,v in pairs(DataMgr.Player.passesMultiple) do
        if ConfigMgr.Config.PassesMap[v.id].type==3 then
            this.data.cfgDrawPasses=ConfigMgr.Config.PassesMap[v.id];
            break;
        end
    end
    if this.data.cfgDrawPasses==nil then 
        return
    end;
    local costItemId=this.data.cfgDrawPasses.Expitems;
    local count=DataHelper.GetItemCountById(costItemId);
    this.data.drawLevel=math.floor(count/this.data.cfgDrawPasses.Exp);
    UnityEngine.PlayerPrefs.SetInt(DataMgr.Player.uid.."_"..this.data.cfgDrawPasses.Id,1);
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
        this.vm.data.secondBuyPanel=false;
        HeroRedDataHelper.FrushMainShopRed();
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
            this.vm.data.secondBuyPanel=false;
            this.data.paying=false;
            this.ParseData();
        end
       
    end, nil, true);
end



this.CheckPassesIsExpired=function()
    local dataPasses=DataMgr.Player.passesMultiple[this.data.cfgDrawPasses.Id];
    if dataPasses==nil then

        return true
    end
    if LuaMgr.Timestamp()>= dataPasses.endTime then
        DataMgr.FrushPlayerData()
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("18001"));
        return true;
    end
    return false;
end



this.ParseData=function()
    this.data.paying=false;
    this.data.dataPasses=DataMgr.Player.passesMultiple[this.data.cfgDrawPasses.Id];
    if  this.data.dataPasses==nil then return end;
    local isNotJoining=this.data.dataPasses.payRecord[this.data.chargeId]==nil
    this.vm.data.joiningBool=isNotJoining;
    this.vm.data.joinedBool=not isNotJoining;

    local chargeChannel=ConfigHelper.GetChargeChannel(this.data.cfgCharge.ChargeGroup);
    this.vm.data.priceSymbol=chargeChannel.CurrencySymbol;
    this.vm.data.buyPrice=chargeChannel.PriceShow;
    this.SetFundTask();
    local remainTime=this.data.dataPasses.endTime-LuaMgr.Timestamp();;
    if remainTime<0 then remainTime=0 end;
    local d, h, m = GetTimeDHM(remainTime);
    if IsNullOrEmpty(d) then
        d="0";
    end
    this.vm.data.remainTime=string.format(ConfigMgr.LangGlobal("15506"),d,h,m);;
   
end


this.GetDrawTask=function()
    local list={}
    for i,v in pairs(ConfigMgr.Config.PassesRewardMap) do
        if v.Passes==this.data.cfgDrawPasses.Id then
            table.insert(list,v);
        end
    end
    return list;
end


this.SetFundTask=function()
    this.vm.data.taskContentAnchor=Vector2(0,0);
    this.vm.data.taskList={};
    local totalCount=0;
    local drawTask=this.GetDrawTask();
    local list={};
    this.data.itemId=nil;
    local isNoPay= this.data.dataPasses.payRecord[this.data.chargeId]==nil
    for i,v in ipairs(drawTask) do
        this.data.itemId=v.FreeReward[1].id;
        local stateFree,statePay=this.RewardState(v.Id);
        local rewardList_pay={}
        local rewardList_free={}
        for p,m in ipairs(v.PayReward) do
            local goodItem=ConfigHelper.CreateGoodsItem(m.id,m.count,0.55,true,true)
            goodItem.isLock=isNoPay;
            goodItem.isReward=not isNoPay and statePay==3
            goodItem.isRewarding=not isNoPay and statePay==1
            goodItem.goodAlpha=(statePay==3 or isNoPay) and 0.5 or 1.0
            table.insert(rewardList_pay,goodItem)
            totalCount=totalCount+m.count;
        end

        for p,m in ipairs(v.FreeReward) do
            local goodItem=ConfigHelper.CreateGoodsItem(m.id,m.count,0.55,true,true)
            goodItem.isLock=false;
            goodItem.isReward=stateFree==3
            goodItem.isRewarding=stateFree==1
            goodItem.goodAlpha=stateFree==3 and 0.5 or 1.0
            table.insert(rewardList_free,goodItem);
        end
        local state=stateFree;
        if not isNoPay then
            state=stateFree<=statePay and stateFree or statePay;
        end
        local color="";
        if state==3 then
            color="c1c0c0";
        elseif state==2 then
            color="616060";
        elseif state==1 then
            color="ece6d3";
        end
        local missionsMultiple=DataMgr.Player.passesMissionsMultiple[this.data.cfgDrawPasses.Id]
        local dataMission=missionsMultiple.period[v.TaskId];
        local taskItem={
            bg = LuaMgr.GetSprite("ShopRare","ui_shop_zjpx_lb_0"..state),
            des = string.format("<color=#%s>%s</color>",color,LuaMgr.GetLangText(v.NameLan)),
            sliderText=string.format("<color=#262429>%s</color>/%s",dataMission.current,dataMission.target);
            goodsList_free=rewardList_free,
            goodsList_pay=rewardList_pay,
            alpha=state==3  and 0.5 or 1.0,
            sliderValue=dataMission==nil and 0 or dataMission.current/dataMission.target,
            id=v.Id,
            state=state,
            isBtnFree=stateFree==1,
            isBtnPay=not isNoPay and statePay==1,
            isPass=state==3
            
        }
        table.insert(list,taskItem);
    end
    table.sort(list,function(a, b)
        if a.state==b.state then
            return tonumber(a.id)<tonumber(b.id);
        else
            return a.state<b.state
        end
    end)
    this.vm.data.taskList=list;
    this.vm.data.totalDiamondNum= totalCount;
    this.vm.data.remainDiamondNum_x="X"..totalCount;
    this.vm.data.totalIcon=ConfigHelper.GetItemTexture(this.data.itemId)
end

this.RewardState=function(id)
    local reFree,rePay=2,2;
    local dataRewards=DataMgr.Player.passesRewardsMultiple[this.data.cfgDrawPasses.Id];
    if dataRewards==nil then 
        return reFree,rePay;
    end;
    local reward=dataRewards[id];

    if reward.freeReceiveTime>0 then
        reFree=3;
    elseif this.data.drawLevel>=reward.level then
        reFree=1;
    else
        reFree=2;
    end


    if reward.payReceiveTime>0 then
        rePay=3;
    elseif this.data.drawLevel>=reward.level then
        rePay=1;
    else
        rePay=2;
    end
    return reFree,rePay;
end


this.ShowBuyReward=function()
    this.vm.data.goodList={};
    local reward=this.data.cfgCharge.Reward[1];
    local list={};
    local goodItem=ConfigHelper.CreateGoodsItem(reward.id,0,0.62,false,true);
    goodItem.isLock=false;
    goodItem.isRewarding=false;
    goodItem.isReward=false;
    table.insert(list,goodItem);
    this.vm.data.goodList=list;
    
    this.vm.data.goodList2={};
    local list2={};
    local goodItem2=ConfigHelper.CreateGoodsItem(this.data.itemId,0,0.62,false,true);
    goodItem2.isLock=false;
    goodItem2.isRewarding=false;
    goodItem2.isReward=false;
    table.insert(list2,goodItem2);
    this.vm.data.goodList2=list2;
    
DataReportMgr.NetClickGoodsAndPage (this.data.chargeId,ShopType.Push,"3001006")
end

return vm({
    data = data,
    command = command,
    hook = hook
})