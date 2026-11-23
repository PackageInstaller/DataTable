






local this = {vm=nil};

local goodId=nil;
local cfgCharge={};
local cfgMissionMap={};
local cfgTask={};
local dataFundMissions={};
local init=false;
local dayMissionId=nil;
local chargeId=nil;
local order=nil;
local shopRecords=nil;
local paying=false;
local textConetentRect=nil;
local data = {
    firstDayIsOn=false,
    secondDayIsOn=false,
    thridDayInOn=false,
    secondBuyPanel=false,
    playAnimName = "",

    showPrice="",
    buyPrice="",
    priceSymbol="",
    
    fristBuyBool=false;
    rewardBtnBool=false;
    hasRewardBool=false;
    noRewardBool=false;
    dayList={{alpha=1.0,goodList={}}};
    buyGoodList={{}};
    
    BG_1_Pos=Vector2(282,-60);
    BG_2_Pos=Vector2(113,-33);
    BG_3_Pos=Vector2(0,0);
    
    red_1Bool=false;
    red_2Bool=false;
    red_3Bool=false;
    
    buyTipsContentAnchorPos=Vector2(0,0);
}

local command = {
    CheckDetailsBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)

            local characterId="V0065";
            LuaMgr.ShowPanel("Laigu.ViewModel.TakeCard.HeroAttrPreviewViewModel",characterId);
        end
    },
    BuyFirstBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.vm.data.secondBuyPanel=true;
            this.vm.data.buyTipsContentAnchorPos=Vector2(0,0);
            this.vm.data.playAnimName = "UI_ShopPush_Frist_02"
            this.ShowBuyReward();
            RectTool.RebuildLayoutImmediate(textConetentRect);
        end
    },
    BuySecondBtn={
      type=XLuaCommandType.Void,
      execute=function(vm,param)
        if paying then return end;
        paying=true;
        LuaMgr.LuaOnAskPay(chargeId);
      end
    },
    RewardBtn={
      type=XLuaCommandType.Void,
      execute=function(vm,param)
          local data={missionId=dayMissionId,tab=""};
          ApiMgr.Request("complete_mission", data, true, function(data)
              local result=json.decode(data);
              local dataString=json.encode(result.result);
              LuaMgr.ShowItemRewared(dataString);
              this.ParseData();
              HeroRedDataHelper.FrushMainShopRed();
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
        this.vm=vm;
        print("before_awake");
        textConetentRect=vm.behaviour.transform:Find("root/Middle/BuyTip/Content/Image/top"):GetComponent("RectTransform");
    end,
    before_active = function(vm)
        print("before_active");
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
        goodId=tostring(data[0]);
        chargeId=goodId;
        cfgCharge=ConfigMgr.Config.charge[goodId];
        for i,v in pairs(ConfigMgr.Config.missionMap) do
            if v.type==ShopTaskType.firstPay then
                cfgMissionMap[v.id]=v;
            end
        end
        this.vm.data.playAnimName = "UI_ShopPush_Frist_01"
        init=false;

        local chargeChannel=ConfigHelper.GetChargeChannel(cfgCharge.ChargeGroup);
        this.vm.data.priceSymbol=chargeChannel.CurrencySymbol;
        this.vm.data.buyPrice=chargeChannel.PriceShow;
        this.vm.data.showPrice=string.format("<size=56>%s</size>%s",chargeChannel.CurrencySymbol,chargeChannel.PriceShow);
        this.ParseData();
        DataReportMgr.ClickPayView(this.data.goodId,3);
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder,this.PayOrder);
        LuaMgr.RemoveTimer(TimerConst.FristPayRechargeStatus)
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult,this.OnPayResult);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess);
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartAcrossDay,this.FrushData);
        print("before_deactive");
    end,
}

this.FrushData=function()
    this.ParseData();
end

this.PayOrder=function(data)
    if data.Length==2 then
        local reChargeId=tostring(data[0]);
        order=tostring(data[1]);
        if chargeId~=reChargeId then return end;
        if LuaMgr.GetPlatform()~="EDITOR" then return end;
        LuaMgr.RemoveTimer(TimerConst.FristPayRechargeStatus)
        LuaMgr.AddTimer(TimerConst.FristPayRechargeStatus,this.OnTimer,1,100,true);
    end
   
end

this.OnPayResult=function(data)
    if data.Length==1 then
        if order~=nil and order~=tostring(data[0]) then return end;
        paying=false;
    end
end

this.OnPaySuccess=function(data)
    if data.Length==1 then
        if  order~=nil and order~=tostring(data[0]) then return end;
        this.vm.data.secondBuyPanel=false;
        HeroRedDataHelper.FrushMainShopRed();
        this.ParseData();
    end
end

this.OnTimer=function()
    local askData={order=order}
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
            paying=false;
            HeroRedDataHelper.FrushMainShopRed();
            this.ParseData();
        end
       
    end, nil, true);
end


this.AdjustScreen=function()
    local offSet=LuaMgr.ScreenOffSet();
    this.vm.data.BG_1_Pos=Vector2(282+offSet/2,-60);
    this.vm.data.BG_2_Pos=Vector2(113-offSet,-33);
    this.vm.data.BG_3_Pos=Vector2(offSet,0);
end

this.ParseData=function()
    paying=false;
    this.AdjustScreen();
    
    dataFundMissions={ };

    local fundMissions=DataMgr.Player.fundMissions;
    
    if fundMissions~=nil then
        for i,v in pairs(fundMissions) do
            local mission=cfgMissionMap[v.id];
            if mission~=nil then
                dataFundMissions[v.id]=v;
            end
        end
    end
    
    shopRecords=DataMgr.Player.shop.records;
    this.vm.data.secondBuyPanel=false;
    this.vm.data.fristBuyBool=this.EnoughPayCount();
    local dayNum=this.GetRewarday();
    this.SetDayReward(dayNum);
    this.ShowRed()
end

this.ShowRed=function()
    if dataFundMissions==nil then
        this.vm.data.red_1Bool=false;
        this.vm.data.red_2Bool=false;
        this.vm.data.red_3Bool=false;
        return;
    end
    local missons={}
    for i,v in pairs(dataFundMissions) do
        table.insert(missons,v);
    end
    if #missons==0 then return end;
    table.sort(missons,function(a,b)return tonumber(a.id)<tonumber(b.id)  end)
    this.vm.data.red_1Bool= this.RewardState(missons[1].id)==2
    this.vm.data.red_2Bool=this.RewardState(missons[2].id)==2
    this.vm.data.red_3Bool=this.RewardState(missons[3].id)==2
end


this.GetRewarday=function()
    if dataFundMissions==nil or NumTool.GetLen(dataFundMissions)==0 then return 1 end;
    local missons={}
    for i,v in pairs(cfgMissionMap) do
        table.insert(missons,v);
    end
    table.sort(missons,function(a,b)return tonumber(a.id)<tonumber(b.id)  end)
    local dataMisson=nil;
    for i,v in ipairs(missons) do
        dataMisson=dataFundMissions[v.id];
        if dataMisson~=nil and  not dataMisson.completed and dataMisson.current>=dataMisson.target then
            return i;
        end
        
    end
    
    return 1;
end


this.EnoughPayCount=function()
    local fristPay=shopRecords[goodId];
    if fristPay~=nil then
        if cfgCharge.RefreshCount<=fristPay then
            return false;
        end
    end
    return true;
end

this.SetDayReward=function(NO)
    this.vm.data.firstDayIsOn=NO==1;
    this.vm.data.secondDayIsOn=NO==2;
    this.vm.data.thridDayInOn=NO==3;
    dayMissionId=cfgCharge.Task[NO];
    cfgTask=cfgMissionMap[dayMissionId];
    local state=this.RewardState(dayMissionId);
    local reward=cfgTask.rewards;
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
    if this.EnoughPayCount() or dataFundMissions[id]==nil  then
        return re;
    end
    if dataFundMissions[id].completed then
        re=3;
    elseif dataFundMissions[id].current>=dataFundMissions[id].target then
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
    for i,v in ipairs(cfgCharge.Task) do
        local mission=cfgMissionMap[v].rewards;
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