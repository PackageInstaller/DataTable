






local this = {
    vm=nil,
    
    data= {
        goodId = nil,
        cfgCharge={},
        cfgMissionMap={},
        cfgTask={},
        dataFundMissions={},
        init=false,
        dayMissionId=nil,
        chargeId=nil,
        order=nil,
        shopRecords=nil,
        paying=false,
    }
};


local data = {
    firstDayIsOn=false,
    secondDayIsOn=false,
    thridDayInOn=false,
    secondBuyPanel=false,
    playAnimName = "",

    showPrice="",
    buyPrice="",
    priceSymbol="",

    getItemBool=false;
    fristBuyBool=false;
    rewardBtnBool=false;
    hasRewardBool=false;
    noRewardBool=false;
    dayList={{alpha=1.0,goodList={}}};
    buyGoodList={{}};

    red_1Bool=false;
    red_2Bool=false;
    red_3Bool=false;

    buyTipsContentAnchorPos=Vector2(0,0);


    name1="";
    name2="";
    name3="";
    
}

local command = {
    CheckDetailsBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)

            local characterId=tostring(param);

            LuaMgr.ShowPanel("Laigu.ViewModel.TakeCard.HeroAttrPreviewViewModel",characterId);
        end
    },
    
    BuyFirstBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.vm.data.secondBuyPanel=true;
            this.vm.data.buyTipsContentAnchorPos=Vector2(0,0);
            this.vm.data.playAnimName = "ani_ShopPush_Fund_BuyTip"
            this.ShowBuyReward();
DataReportMgr.NetClickGoodsAndPage (this.data.chargeId,ShopType.Push,"3001101")
        end
    },
    
    GetItemBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)

            if this.vm.data.getItemBool~=true then
                return
            end
            
            this.CheckTreasureChest(true);
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
    RewardBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local data={missionId=this.data.dayMissionId,tab=""};
            ApiMgr.Request("complete_mission", data, true, function(data)
                local result=json.decode(data);
                local dataString=json.encode(result.result);
                LuaMgr.ShowItemRewared(dataString,function()
                    if this==nil then
                        return;
                    end

                    this.CheckTreasureChest(true)
                end);
                
                this.ParseData();
                HeroRedDataHelper.FrushMainShopRed();
                if (not DataHelper.CheckFristPay(this.data.cfgCharge.Shelf)) then
                    LuaMgr.InvokeUIEventListeners(UIEventConst.PropUse);
                end
            end,nil,false);
        end
    },
    dayToggle={
        type=XLuaCommandType.Bool,
        execute=function(vm,isOn,param)
            if isOn then
                local index=tonumber(param);
                this.SetDayReward(index);
            end
        end
    },
    closeSecondPanelBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.vm.data.secondBuyPanel=false;
            this.vm.data.playAnimName="";
        end
    },

}
local hook = {
    before_awake = function(vm)
        this.vm = vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder, this.PayOrder);
        LuaMgr.AddUIEventListener(UIEventConst.PayOrder, this.PayOrder);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult, this.OnPayResult);
        LuaMgr.AddUIEventListener(UIEventConst.OnPayResult, this.OnPayResult);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess, this.OnPaySuccess);
        LuaMgr.AddUIEventListener(UIEventConst.OnPaySuccess, this.OnPaySuccess);
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartAcrossDay, this.FrushData);
        LuaMgr.AddUIEventListener(UIEventConst.HeartAcrossDay, this.FrushData);
        LuaMgr.RemoveTimer(TimerConst.FristNewPayTime)
        LuaMgr.AddTimer(TimerConst.FristNewPayTime, function()
            this.CheckTreasureChest(false);
        end, 1, -1, true);

        LuaMgr.AddUIEventListener(UIEventConst.PropUse, HeroRedDataHelper.FrushMainShopRed);
        
        local data = vm.behaviour.Params;
        this.data.goodId = tostring(data[0]);
        this.data.chargeId = this.data.goodId;
        this.data.cfgCharge = ConfigMgr.Config.charge[this.data.goodId];
        for i, v in pairs(ConfigMgr.Config.missionMap) do
            if v.type == ShopTaskType.newfirstPay then
                this.data.cfgMissionMap[v.id] = v;
            end
        end
        this.vm.data.playAnimName = "UI_ShopPush_Frist_01"
        this.data.init = false;

        local chargeChannel = ConfigHelper.GetChargeChannel(this.data.cfgCharge.ChargeGroup);
        if chargeChannel ~= nil then
            this.vm.data.priceSymbol = chargeChannel.CurrencySymbol;
            this.vm.data.buyPrice = chargeChannel.PriceShow;
            this.vm.data.showPrice = string.format("<size=56>%s</size>%s", chargeChannel.CurrencySymbol, chargeChannel.PriceShow);
        end
        this.ParseData();

        this.vm.data.name1 =LuaMgr.GetLangText(ConfigMgr.Config.characterTable["V0065"].namelan);
        this.vm.data.name2 =LuaMgr.GetLangText(ConfigMgr.Config.characterTable["A0061"].namelan);
        this.vm.data.name3 =LuaMgr.GetLangText(ConfigMgr.Config.characterTable["D0032"].namelan);
        DataReportMgr.ClickPayView(this.data.goodId,3);
    end,

    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder, this.PayOrder);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult, this.OnPayResult);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess, this.OnPaySuccess);
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartAcrossDay, this.FrushData);
        LuaMgr.RemoveTimer(TimerConst.FristNewPayTime)
        LuaMgr.RemoveTimer(TimerConst.FristPayRechargeStatus)
        LuaMgr.RemoveUIEventListener(UIEventConst.PropUse, HeroRedDataHelper.FrushMainShopRed);
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
        if  this.data.order~=nil and this.data.order~=tostring(data[0]) then return end;
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
                LuaMgr.ShowItemRewared(data)
            end
            
            this.vm.data.secondBuyPanel=false;
            this.data.paying=false;
            HeroRedDataHelper.FrushMainShopRed();
            this.ParseData();
        end

    end, nil, true);
end

this.CheckTreasureChest=function(showPanel)
    if this ==nil then
        return;
    end
    
    this.vm.data.getItemBool=HeroRedDataHelper.GetRedPointByItemId_3301();
    
    if showPanel then
        if  this.vm.data.getItemBool then
            LuaMgr.ShowPanel(UIName.GiftPageViewPanel,"3301");
        end
    end
    
end

this.ParseData=function()
    this.data.paying=false;
    this.data.dataFundMissions={ };

    local dataFundMissions=DataMgr.Player.fundMissions;

    if dataFundMissions~=nil then
        for i,v in pairs(dataFundMissions) do
            local mission=this.data.cfgMissionMap[v.id];
            if mission~=nil then
                this.data.dataFundMissions[v.id]=v;
            end
        end
    end

    this.data.shopRecords=DataMgr.Player.shop.records;
    this.vm.data.secondBuyPanel=false;
    this.vm.data.fristBuyBool=this.EnoughPayCount();
    local dayNum=this.GetRewarday();
    this.SetDayReward(dayNum);
    this.ShowRed()
    this.CheckTreasureChest(false);
end

this.ShowRed=function()
    if  this.data.dataFundMissions==nil then
        this.vm.data.red_1Bool=false;
        this.vm.data.red_2Bool=false;
        this.vm.data.red_3Bool=false;
        return;
    end
    local missons={}
    for i,v in pairs( this.data.dataFundMissions) do
        table.insert(missons,v);
    end
    if #missons==0 then return end;
    table.sort(missons,function(a,b)return tonumber(a.id)<tonumber(b.id)  end)
    this.vm.data.red_1Bool= this.RewardState(missons[1].id)==2
    this.vm.data.red_2Bool=this.RewardState(missons[2].id)==2
    this.vm.data.red_3Bool=this.RewardState(missons[3].id)==2
end

this.GetRewarday=function()
    if  this.data.dataFundMissions==nil or NumTool.GetLen( this.data.dataFundMissions)==0 then return 1 end;
    local missons={}
    local task = this.data.cfgCharge.Task;
    local len = #task;
    for i = 1, len do
        local missionConfig = this.data.cfgMissionMap[task[i]];
        if (missionConfig ~= nil) then
            table.insert(missons, missionConfig);
        end
    end
    table.sort(missons,function(a,b)return tonumber(a.id)<tonumber(b.id)  end)
    for i, v in ipairs(missons) do
        local dataMisson = this.data.dataFundMissions[v.id];
        if dataMisson~=nil and not dataMisson.completed and dataMisson.current>=dataMisson.target then
            return i;
        end
    end
    return 1;
end

this.EnoughPayCount=function()
    local fristPay=this.data.shopRecords[this.data.goodId];
    if fristPay~=nil then
        if  this.data.cfgCharge.RefreshCount<=fristPay then
            return false;
        end
    end
    return true;
end

this.SetDayReward=function(NO)
    this.vm.data.firstDayIsOn=NO==1;
    this.vm.data.secondDayIsOn=NO==2;
    this.vm.data.thridDayInOn=NO==3;
    this.data.dayMissionId= this.data.cfgCharge.Task[NO];
    this.data.cfgTask= this.data.cfgMissionMap[this.data.dayMissionId];
    local state=this.RewardState(this.data.dayMissionId);
    local reward=this.data.cfgTask.rewards;
    this.vm.data.dayList={};
    local list={}
    for i,v in ipairs(reward) do
        local goods={};
        local item =ConfigMgr.Config.itemMap[tostring(v.itemId)];
        if item~=nil then
            local rewardItem={id=tostring(v.itemId),count=LuaMgr.NumFormat(v.count),isCount=true,
                              rare=ActivityMgr.GetRareSprite(item.rare),
                              icon=ActivityMgr.GetItemTexture(tostring(v.itemId)),
                              scale=Vector3(1,1,1),
                              sizeDelta=Vector2(128,128),
                              isClick=true}
            table.insert(goods,rewardItem);
            local rewardItem={
                alpha=state>2 and 0.3 or 1.0,
                goodList=goods,

            }
            table.insert(list,rewardItem);

        end
    end
    this.vm.data.dayList=list;
    this.SetButtonState(state);
end

this.RewardState=function(id)
    local re=0;
    if this.EnoughPayCount() or  this.data.dataFundMissions[id]==nil  then
        return re;
    end
    if  this.data.dataFundMissions[id].completed then
        re=3;
    elseif  this.data.dataFundMissions[id].current>= this.data.dataFundMissions[id].target then
        re=2;
    else
        re=1;
    end
    return re;
end

this.SetButtonState=function(state)
    this.vm.data.rewardBtnBool=state==2;
    this.vm.data.hasRewardBool=state==3;
    this.vm.data.noRewardBool=state==1;
end

this.ShowBuyReward=function()
    this.vm.data.buyGoodList={};
    local totalRewards={};
    for i,v in ipairs( this.data.cfgCharge.Task) do
        local mission= this.data.cfgMissionMap[v].rewards;
        for _i,_v in ipairs(mission) do
            table.insert(totalRewards,_v);
        end
    end
    local list={};
    for i,v in ipairs(totalRewards) do
        local item =ConfigMgr.Config.itemMap[tostring(v.itemId)];
        local rewardItem={id=tostring(v.itemId),count=tostring(v.count),isCount=true,
                          rare=ActivityMgr.GetRareSprite(item.rare),
                          icon=ActivityMgr.GetItemTexture(tostring(v.itemId)),
                          scale=Vector3(0.62,0.62,0.62),
                          sizeDelta=Vector2(80,80),
                          isClick=true}
        table.insert(list,rewardItem);
    end
    this.vm.data.buyGoodList=list;
end

return vm({
    data = data,
    command = command,
    hook = hook
})