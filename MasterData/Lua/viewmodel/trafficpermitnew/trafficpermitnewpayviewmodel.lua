






local this = {vm=nil};


local chargeId=nil;
local order=nil;
local cfgCharge={};
local shopRecords=nil;
local cfgThemePass=nil;
local paying=false;
local passPay1=nil;
local passPay2=nil;
local passPay3=nil;
local highPass=nil;
local spineCharacter=nil;

local data = {
    chargeList={
        {
            nowGoods={{}},
            unlockGoods={{}},
            continuousGoods={{}},
            price="";
        },
        {
            nowGoods={{}},
            unlockGoods={{}},
            continuousGoods={{}},
            price="";
        },
    },
    bodyPath="";
    highUnlockRewardBool=false;
    levelInfo="";
    offBodyPos=Vector2.zero;
    offBodyScale=Vector3.zero;
    highOrigPrice="";
    highOrigBool=false;
    specialOrigPrice="";
    specialOrigBool=false;
}

local command = {
    norPayBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if not this.PassesIsRuning() or  not this.CheckPayOnLine()then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("TrafficPermitPayViewModel_16"));
                return;
            end
            if paying then return end;
            chargeId=cfgThemePass.Charge1[1]
            local pass2_chargeId=cfgThemePass.Charge2[1]
            if not this.IsPayCharge(chargeId) or not this.IsPayCharge(pass2_chargeId) then
                return;
            end
            paying=true;
            LuaMgr.LuaOnAskPay(chargeId);

        end

    },
    highPayBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if not this.PassesIsRuning() or not this.CheckPayOnLine() then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("TrafficPermitPayViewModel_17"));
                return;
            end
            if paying then return end;
            chargeId=highPass[1]
            if not this.IsPayCharge(chargeId) then
                return;
            end
            paying=true;
            LuaMgr.LuaOnAskPay(chargeId);
        end
    },
}


local hook = {
    before_awake = function(vm)
        this.vm=vm;

    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params == nil) then return end
        spineCharacter=this.vm.behaviour.transform:Find("root/Middle/BG/character/offset/body"):GetComponent("UISpineCharacter")
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder,this.PayOrder);
        LuaMgr.AddUIEventListener(UIEventConst.PayOrder,this.PayOrder);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult,this.OnPayResult);
        LuaMgr.AddUIEventListener(UIEventConst.OnPayResult,this.OnPayResult);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess);
        LuaMgr.AddUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess);
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat,this.FrushData);
        LuaMgr.AddUIEventListener(UIEventConst.HeartBeat,this.FrushData);
        cfgCharge=ConfigMgr.Config.charge;
        cfgThemePass=ConfigMgr.Config.PassesMap[DataMgr.Player.passes.id];
        passPay1=ActivityMgr.trafficPermit_passPay1;
        passPay2=ActivityMgr.trafficPermit_passPay2;
        passPay3=ActivityMgr.trafficPermit_passPay3;


        this.ParseData();

        DataReportMgr.ClickPayView("",5);
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder,this.PayOrder);
        LuaMgr.RemoveTimer(TimerConst.FristPayRechargeStatus)
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult,this.OnPayResult);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess);
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat,this.FrushData);

        if (spineCharacter~= nil) then
            spineCharacter:Clear();
        end
        print("before_deactive");
    end,
}


this.PassesIsRuning=function()
    return not IsNull(DataMgr.Player.passes) and not IsNullOrEmpty(DataMgr.Player.passes.id)
end

this.CheckPayOnLine=function()
    local expireTime=DataMgr.Player.passes.endTime;
    return LuaMgr.Timestamp()<expireTime
end


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
            paying=false;
            this.ParseData();
        end

    end, nil, true);
end

this.ParseData=function()
    paying=false;
    shopRecords=DataMgr.Player.shop.records;
    this.SetCharacter();
    this.SetChargeInfo();

end

this.SetCharacter=function()
    local characterId = cfgThemePass.CharacterInfos[2][1];
    local skinId = cfgThemePass.CharacterInfos[2][2];
    local path = HeroManager.SetCharacterDrawing(spineCharacter, characterId,skinId);
    if (path ~= "") then
        this.vm.data.bodyPath = path;
    end
    this.vm.data.offBodyPos=Vector2(tonumber(cfgThemePass.CharacterInfos[2][3]),tonumber(cfgThemePass.CharacterInfos[2][4]))
    this.vm.data.offBodyScale=Vector3.one*tonumber(cfgThemePass.CharacterInfos[2][5])
end


this.IsPayHistory=function(chargeId)
    return DataMgr.Player.shop.records[chargeId]==nil;
end


this.IsPayCharge=function(charge_Id)
    if IsNull(DataMgr.Player.passes.payRecord) then return true end;
    return DataMgr.Player.passes.payRecord[charge_Id]==nil;
end


this.CheckRelateDiscount=function()
    if IsNull(cfgThemePass.relate) or #cfgThemePass.relate==0 then
        return false;
    end
    for i,v in ipairs(cfgThemePass.relate) do
        if this.CheckIsDiscount(v) then
            return true;
        end
    end
    return false;
end

this.CheckIsDiscount=function(themIds)
    if themIds==nil or #themIds==0 then
        return false;
    end
    for i,v in ipairs(themIds) do
        if ConfigMgr.Config.PassesMap[v]~=nil then
            local relatePasses=ConfigMgr.Config.PassesMap[v];
            if this.IsPayHistory(relatePasses.Charge1[1]) and this.IsPayHistory(relatePasses.Charge2[1]) then
                return false;
            end
        end
    end
    return true;
end

this.SetChargeInfo=function()

    local now1List={}
    local continuous1Goods = {}
    local unlock1List={}
    local itemScale = 0.45
    for i,v in ipairs(cfgCharge[cfgThemePass.Charge1[1]].Reward) do
        local item=ConfigHelper.CreateGoodsItem(v.id,v.count,itemScale,true,true);
        table.insert(now1List,item);
    end
    for i,v in ipairs(cfgThemePass.RenewalBonusDisplay) do
        local item=ConfigHelper.CreateGoodsItem(v[1],tonumber(v[2]),itemScale,true,true);
        table.insert(continuous1Goods,item);
    end
    for i,v in ipairs(cfgThemePass.ShowRewards) do
        local item=ConfigHelper.CreateGoodsItem(v[1],tonumber(v[2]),itemScale,true,true);
        table.insert(unlock1List,item);
    end

    local charge_id=cfgThemePass.Charge1[1];
    local pass2_charge_id=cfgThemePass.Charge2[1];
    local isBuy=not this.IsPayCharge(pass2_charge_id) or not this.IsPayCharge(charge_id)
    local chargeChannel=ConfigHelper.GetChargeChannel(cfgCharge[charge_id].ChargeGroup);
    if not isBuy and this.CheckRelateDiscount() and not IsNullOrEmpty(cfgCharge[charge_id].ChargeGroup2) then
        this.vm.data.highOrigBool=true
        this.vm.data.highOrigPrice=LuaMgr.GetLangText("TrafficPermitPayViewModel_0")..chargeChannel.CurrencySymbol..chargeChannel.PriceShow;
        chargeChannel=ConfigHelper.GetChargeChannel(cfgCharge[charge_id].ChargeGroup2);
    else
        this.vm.data.highOrigBool=false;
    end
    this.vm.data.chargeList[1].nowGoods=now1List;
    this.vm.data.chargeList[1].continuousGoods=continuous1Goods;
    this.vm.data.chargeList[1].unlockGoods=unlock1List;
    this.vm.data.chargeList[1].price=isBuy and  LuaMgr.GetLangText("TrafficPermitPayViewModel_18") or  chargeChannel.CurrencySymbol..chargeChannel.PriceShow;


    this.vm.data.highUnlockRewardBool=true;
    local highShowRewards={};
    if this.IsPayCharge(cfgThemePass.Charge1[1]) or not this.IsPayCharge(cfgThemePass.Charge2[1]) then
        highPass=cfgThemePass.Charge2;
        highShowRewards=cfgThemePass.ShowRewards1
        chargeChannel=ConfigHelper.GetChargeChannel(cfgCharge[highPass[1]].ChargeGroup);
        if this.IsPayCharge(cfgThemePass.Charge2[1]) and this.CheckRelateDiscount() and not IsNullOrEmpty(cfgCharge[highPass[1]].ChargeGroup2) then
            this.vm.data.specialOrigBool=true;
            this.vm.data.specialOrigPrice=LuaMgr.GetLangText("TrafficPermitPayViewModel_0")..chargeChannel.CurrencySymbol..chargeChannel.PriceShow
            chargeChannel=ConfigHelper.GetChargeChannel(cfgCharge[highPass[1]].ChargeGroup2);
        else
            this.vm.data.specialOrigBool=false;
        end
    else
        highPass=cfgThemePass.Charge3;
        highShowRewards=cfgThemePass.ShowRewards2
        this.vm.data.highUnlockRewardBool=false;
        this.vm.data.specialOrigBool=false;
        chargeChannel=ConfigHelper.GetChargeChannel(cfgCharge[highPass[1]].ChargeGroup);
    end

    local nowList={}
    local continuousGoods = {}
    local unlockList={}
    charge_id=highPass[1];

    for i,v in ipairs(cfgCharge[charge_id].Reward) do
        local item=ConfigHelper.CreateGoodsItem(v.id,v.count,itemScale,true,true);
        table.insert(nowList,item);
    end
    local config = isBuy and cfgThemePass.RenewalBonusDisplay2 or cfgThemePass.RenewalBonusDisplay1
    for i,v in ipairs(config) do
        local item=ConfigHelper.CreateGoodsItem(v[1],tonumber(v[2]),itemScale,true,true);
        table.insert(continuousGoods,item);
    end


    if not IsNull(highShowRewards)then
        for i,v in ipairs(highShowRewards) do
            local item=ConfigHelper.CreateGoodsItem(v[1],tonumber(v[2]),itemScale,true,true);
            table.insert(unlockList,item);
        end
    end
    this.vm.data.chargeList[2].nowGoods=nowList;
    this.vm.data.chargeList[2].continuousGoods=continuousGoods;
    this.vm.data.chargeList[2].unlockGoods=unlockList;
    this.vm.data.chargeList[2].price=this.IsPayCharge(charge_id) and chargeChannel.CurrencySymbol..chargeChannel.PriceShow or LuaMgr.GetLangText("TrafficPermitPayViewModel_19");
    this.vm.data.levelInfo=ConfigMgr.LangGlobal("10207")
end




return vm({
    data = data,
    command = command,
    hook = hook

})