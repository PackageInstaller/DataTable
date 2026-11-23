






local this = {
    vm = nil;
    data = {
        cfgCharge={};
        cfgMissionMap={};
        cfgTask={};
        dataFundMissions={};
        init=false;
        chargeId=nil;
        order=nil;
        shopRecords=nil;
        paying=false;
    }
};

local data = {
    secondBuyPanel=false,
    playAnimName = "",
    joiningBool=false,
    joinedBool=false,
    diamondIcon=DefaultTexture,
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
        if this.data.paying then return end;
          this.data.paying=true;
        LuaMgr.LuaOnAskPay(this.data.chargeId);
      end
    },
    RewardFreeBtn={
      type=XLuaCommandType.Void,
      execute=function(vm,param)
          local index=tonumber(param)+1;
          local id=this.vm.data.taskList[index].idFree;
          local data={missionId=id,tab=""};
          ApiMgr.Request("complete_mission", data, true, function(data)
              local result=json.decode(data);
              local dataString=json.encode(result.result);
              LuaMgr.ShowItemRewared(dataString);
              this.ParseData();
              HeroRedDataHelper.FrushMainShopRed();
          end,nil,true);
      end
    },
    RewardPayBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param)+1;
            local id=this.vm.data.taskList[index].idPay;
            local data={missionId=id,tab=""};
            ApiMgr.Request("complete_mission", data, true, function(data)
                local result=json.decode(data);
                local dataString=json.encode(result.result);
                LuaMgr.ShowItemRewared(dataString);
                this.ParseData();
                HeroRedDataHelper.FrushMainShopRed();
            end,nil,true);
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
        local data=vm.behaviour.Params;
        this.data.chargeId=tostring(data[0]);
        this.data.cfgCharge=ConfigMgr.Config.charge[this.data.chargeId];
        this.data.cfgMissionMap=ConfigMgr.Config.missionMap;
        this.vm.data.playAnimName = "ani_ShopPush_Fund_BG"
        this.data.init=false;
        this.vm.data.diamondIcon=ConfigHelper.GetItemTexture(this.data.cfgCharge.Reward[1].id)
        this.vm.data.nowDiamondNum= this.data.cfgCharge.Reward[1].count;
        this.vm.data.nowDiamondNum_x="X".. this.data.cfgCharge.Reward[1].count;
        this.vm.data.totalDiamondNum= this.data.cfgCharge.Parameter;
        this.vm.data.remainDiamondNum_x="X"..( this.data.cfgCharge.Parameter- this.data.cfgCharge.Reward[1].count);
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


this.ParseData=function()
    this.data.paying=false;

    this.data.dataFundMissions=DataMgr.Player.fundMissions;
    this.data.shopRecords=DataMgr.Player.shop.records;
    this.vm.data.secondBuyPanel=false;
    local isJoining=this.NotEnoughPayCount();
    this.vm.data.joiningBool=isJoining;
    this.vm.data.joinedBool=not isJoining;
    
    local chargeChannel=ConfigHelper.GetChargeChannel(this.data.cfgCharge.ChargeGroup);
    this.vm.data.priceSymbol=chargeChannel.CurrencySymbol;
    this.vm.data.buyPrice=chargeChannel.PriceShow;

    this.SetFundTask();
   
end

this.NotEnoughPayCount=function()
    local fristPay=this.data.shopRecords[this.data.chargeId];
    if fristPay~=nil then
        if this.data.cfgCharge.RefreshCount<=fristPay then
            return false;
        end
    end
    return true;
end

this.GetFreeTask=function()

    local freeList={}
    for i,v in pairs(this.data.cfgMissionMap) do
        if v.tab=="fund" and v.type=="514" then
            table.insert(freeList,v)
        end
    end
    table.sort(freeList,function(a, b) return a.id<b.id end)
    return freeList;
end


this.SetFundTask=function()
    if this.data.cfgCharge.Task==nil or #this.data.cfgCharge.Task==0 then return end;
    this.vm.data.taskContentAnchor=Vector2(0,0);
    this.vm.data.taskList={};
    local freeTask=this.GetFreeTask();
    local list={};
    local isNoPay= this.NotEnoughPayCount();
    for i,v in ipairs(freeTask) do
        local stateFree,text,slider=this.RewardState(v.id);
        local payTask=this.data.cfgMissionMap[this.data.cfgCharge.Task[i]];
        local statePay=this.RewardState(payTask.id);
        local rewardFree=v.rewards;
        local rewardList_pay={}
        local rewardList_free={}
        for p,m in ipairs(payTask.rewards) do
            local goodItem=ConfigHelper.CreateGoodsItem(m.itemId,m.count,0.55,true,true)
            goodItem.isLock=isNoPay;
            goodItem.isReward=not isNoPay and statePay==3
            goodItem.isRewarding=not isNoPay and statePay==1
            goodItem.goodAlpha=(statePay==3 or isNoPay) and 0.5 or 1.0
            table.insert(rewardList_pay,goodItem);
        end

        for p,m in ipairs(rewardFree) do
            local goodItem=ConfigHelper.CreateGoodsItem(m.itemId,m.count,0.55,true,true)
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
            color="262429";
        elseif state==2 then
            color="c1c0c0";
        elseif state==1 then
            color="ece6d3";
        end
        local taskItem={
            bg = LuaMgr.GetSprite("ShopRare","ui_shop_cb_rwdi0"..state),
            des = string.format("<color=#%s>%s</color>",color,LuaMgr.GetLangText(payTask.NameLan)),
            sliderText=text;
            goodsList_free=rewardList_free,
            goodsList_pay=rewardList_pay,
            alpha=state==3  and 0.5 or 1.0,
            sliderValue=slider,
            idFree=v.id,
            idPay=payTask.id,
            state=state,
            isBtnFree=stateFree==1,
            isBtnPay=not isNoPay and statePay==1,
            
        }
        table.insert(list,taskItem);
    end
    table.sort(list,function(a, b)
        if a.state==b.state then
            return tonumber(a.idFree)<tonumber(b.idFree);
        else
            return a.state<b.state
        end
    end)
    this.vm.data.taskList=list;
   
end

this.RewardState=function(id)
    local re=1;
    local tag=nil;
    local slider=0;
    if this.data.dataFundMissions[id]==nil then
        return re;
    end
    
    if  this.data.dataFundMissions[id].completed then

        re=3;
    elseif  this.data.dataFundMissions[id].current>= this.data.dataFundMissions[id].target then

        re=1;
    else

        re=2;
    end
    slider= this.data.dataFundMissions[id].current/ this.data.dataFundMissions[id].target;
    tag=string.format("<color=#d3c8ab>%s</color>/%s", tostring( this.data.dataFundMissions[id].current),tostring( this.data.dataFundMissions[id].target));
    return re,tag,slider;
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
DataReportMgr.NetClickGoodsAndPage (this.data.chargeId,ShopType.Push,"3001003")
end

return vm({
    data = data,
    command = command,
    hook = hook
})