require("ViewModel/Shop/FirstPayExtendHeadItem");

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
    },
    characterItemMap = nil,
    headItem = nil,
    characterList = nil,
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
    isExtend2=false,
    isExtend3=false,
    extend2DetailsText = "",
    extend2Banner = false,
    extend3DetailsText = "",
    extend3Banner = false,
    buyTipTitle = "",
    isCharacter = false,
    buyBtnColor = UnityEngine.Color(1,1,1,1),
}

local command = {
    CheckDetailsBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local isCharacter = not this.vm.data.isCharacter;
            this.vm.data.isCharacter = isCharacter;
            if (isCharacter) then
                this.SetCharacters();
            else
                this.characterList:Clear();
            end
        end
    },
    
    BuyFirstBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local shelf = this.data.cfgCharge.Shelf;
            local payId = "";
            local msgId = "";
            if (shelf == "3001102") then
                payId = "3001101";
                msgId = "10157";
            else
                payId = "3001102";
                msgId = "10158";
            end
            if (not DataHelper.CheckBuyFristPay(payId)) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal(msgId));
                return;
            end
            this.vm.data.secondBuyPanel=true;
            this.vm.data.buyTipsContentAnchorPos=Vector2(0,0);
            this.vm.data.playAnimName = "ani_ShopPush_Fund_BuyTip"
            this.ShowBuyReward();
DataReportMgr.NetClickGoodsAndPage (this.data.chargeId,ShopType.Push, this.data.cfgCharge.Shelf)
            this.vm.data.isCharacter = false;
            this.characterList:Clear();
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
                LuaMgr.ShowItemRewared(dataString);
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
        this.headItem = vm.behaviour.transform:Find("template/HeadItem").gameObject;
        this.characterList = UIListView.New(vm.behaviour.transform:Find("root/Characters/ScrollView/Viewport/Content"));
        this.InitCharacterItemId();
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

        LuaMgr.AddUIEventListener(UIEventConst.PropUse, HeroRedDataHelper.FrushMainShopRed);
        
        local data = vm.behaviour.Params;
        this.data.goodId = tostring(data[0]);
        this.data.chargeId = this.data.goodId;
        this.data.cfgCharge = ConfigMgr.Config.charge[this.data.goodId];
        local shelf = this.data.cfgCharge.Shelf;
        if (shelf == "3001102") then
            this.vm.data.isExtend2 = true;
            this.vm.data.isExtend3 = false;
            this.vm.data.extend2DetailsText = ConfigMgr.LangGlobal("10152");
            this.vm.data.extend2Banner = true;
            this.vm.data.extend3Banner = false;
            this.vm.data.buyTipTitle = ConfigMgr.LangGlobal("10150");
            local isBuy = DataHelper.CheckBuyFristPay("3001101");
            this.vm.data.buyBtnColor = isBuy and UnityEngine.Color(1,1,1,1) or UnityEngine.Color(0.6,0.6,0.6,1);
        elseif (shelf == "3001103") then
            this.vm.data.isExtend2 = false;
            this.vm.data.isExtend3 = true;
            this.vm.data.extend3DetailsText = ConfigMgr.LangGlobal("10153");
            this.vm.data.extend2Banner = false;
            this.vm.data.extend3Banner = true;
            this.vm.data.buyTipTitle = ConfigMgr.LangGlobal("10151");
            local isBuy = DataHelper.CheckBuyFristPay("3001102");
            this.vm.data.buyBtnColor = isBuy and UnityEngine.Color(1,1,1,1) or UnityEngine.Color(0.6,0.6,0.6,1);
        end
        for _, v in pairs(ConfigMgr.Config.missionMap) do
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
        DataReportMgr.ClickPayView(this.data.goodId, 3);
    end,

    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder, this.PayOrder);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult, this.OnPayResult);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess, this.OnPaySuccess);
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartAcrossDay, this.FrushData);
        LuaMgr.RemoveTimer(TimerConst.FristNewPayTime)
        LuaMgr.RemoveTimer(TimerConst.FristPayRechargeStatus)
        LuaMgr.RemoveUIEventListener(UIEventConst.PropUse, HeroRedDataHelper.FrushMainShopRed);
        this.characterList:Clear();
        this.vm.data.isCharacter = false;
    end,

    before_destroy = function(vm)
        this.vm.data = nil;
        this.vm.behaviour = nil;
        this.vm = nil;
        this.data = nil;
        UIListView.ClearItem("FirstPayExtendHeadItem");
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

this.ParseData=function()
    this.data.paying=false;
    this.data.dataFundMissions={ };
    local fundMissions=DataMgr.Player.fundMissions;
    if fundMissions~=nil then
        local cfgCharge = this.data.cfgCharge;
        local len = #cfgCharge.Task;
        for i = 1, len do
            local missionId = cfgCharge.Task[i];
            this.data.dataFundMissions[missionId] = fundMissions[missionId];
        end
    end
    this.data.shopRecords=DataMgr.Player.shop.records;
    this.vm.data.secondBuyPanel=false;
    this.vm.data.fristBuyBool=this.EnoughPayCount();
    local dayNum=this.GetRewarday();
    this.SetDayReward(dayNum);
    this.ShowRed()
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
    for k,_ in pairs(this.data.dataFundMissions) do
        table.insert(missons, this.data.cfgMissionMap[k]);
    end
    table.sort(missons,function(a,b)return tonumber(a.id)<tonumber(b.id)  end)
    local dataMisson=nil;
    for i,v in ipairs(missons) do
        dataMisson= this.data.dataFundMissions[v.id];
        if dataMisson~=nil and  not dataMisson.completed and dataMisson.current>=dataMisson.target then
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
    for _,v in ipairs(reward) do
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


this.SetCharacters = function()
    this.characterList:Clear();
    local dayMissionId = this.data.cfgCharge.Task[1];
    local cfgTask = this.data.cfgMissionMap[dayMissionId];
    local itemId = cfgTask.rewards[1].itemId;
    local itemConfig = ConfigMgr.Config.itemMap[itemId];
    if (itemConfig == nil) then return end

    local dropConfig = ConfigMgr.Config.dropMap[tostring(itemConfig.drop)];
    if (dropConfig == nil) then return end
    
    local itemData;
    local characterConfig;
    local listData;
    local listDatas = {};
    local len = #dropConfig.items;
    for i = 1, len do
        itemData = dropConfig.items[i];
        characterConfig = this.characterItemMap[itemData.id];
        if (characterConfig ~= nil) then
            listData = UIListData.GetData(this.headItem, "FirstPayExtendHeadItem", characterConfig);
            table.insert(listDatas, listData);
        end
    end
    this.characterList:SetData(listDatas);
end


this.InitCharacterItemId = function()
    this.characterItemMap = {};
    local characterTable = ConfigMgr.Config.characterTable;
    for _, v in pairs(characterTable) do
        this.characterItemMap[v.mapItem] = v;
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})