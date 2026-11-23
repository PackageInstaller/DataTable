




require("ViewModel/Passes/Passes_RewardItemGroup")
require("ViewModel/Passes/Passes_RewardItem")
local this = {vm=nil,
            
};

local rewardItemGroupObj=nil;
local rewardItemObj=nil;
local rewardScrollView=nil;
local high_norUIList=nil
local high_speUIList=nil;
local trafficPermitExp=nil;
local trafficPermitLevels=nil;
local payNowUIList=nil;
local payContinueousUIList=nil;
local payLockUIList=nil;
local chargeId=nil;
local order=nil;
local paying=false;


local cfgThemePass={};
local cfgRewards={};
local reward_ScrollView=nil;
local dataPasses=nil;
local isExpRewarding=false;
local startIndex=nil;
local isInit=false;
local lastLoc=nil;
local lastLevel=nil;;
local lastExp=nil;
local trafficLevel=nil;

local tarGameObject = nil;
local tarRect = nil;
local good = nil;
local root = nil;
local Left = nil;
local goPayLock = nil;
local Right = nil;
local Middle = nil;
local goPopBuy = nil;
local ScrollView = nil;
local ScrollViewNow = nil;
local ScrollViewContinuous = nil
local ScrollViewLock = nil;
local tranContent = nil;
local tranNowContent = nil;
local tranContinuousContent = nil;
local tranLockContent = nil;
local txtTime = nil;
local txtNum = nil;
local txtPrice = nil;
local btnBuy = nil;
local btnTask = nil;
local btnReward = nil;
local btnMask = nil;
local btnPay = nil;
local curScoreNum = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    good = uiLink:Get("good");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    goPayLock = uiLink:Get("goPayLock");
    Right = uiLink:Get("Right");
    Middle = uiLink:Get("Middle");
    goPopBuy = uiLink:Get("goPopBuy");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ScrollViewNow = uiLink:Get("ScrollViewNow"):GetComponent("ScrollRect");
    ScrollViewContinuous = uiLink:Get("ScrollViewContinuous"):GetComponent("ScrollRect");
    ScrollViewLock = uiLink:Get("ScrollViewLock"):GetComponent("ScrollRect");
    tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    tranNowContent = uiLink:Get("tranNowContent"):GetComponent("RectTransform");
    tranContinuousContent = uiLink:Get("tranContinuousContent"):GetComponent("RectTransform");
    tranLockContent = uiLink:Get("tranLockContent"):GetComponent("RectTransform");
    txtTime = uiLink:Get("txtTime"):GetComponent("Text");
    txtNum = uiLink:Get("txtNum"):GetComponent("Text");
    txtPrice = uiLink:Get("txtPrice"):GetComponent("Text");
    btnBuy = uiLink:Get("btnBuy"):GetComponent("Button");
    btnTask = uiLink:Get("btnTask"):GetComponent("Button");
    btnReward = uiLink:Get("btnReward"):GetComponent("Button");
    btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    btnPay = uiLink:Get("btnPay"):GetComponent("Button");
    curScoreNum = uiLink:Get("txtLevel"):GetComponent("Text");
    this.AddRigister(uiLink);
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    good = nil;
    root = nil;
    Left = nil;
    goPayLock = nil;
    Right = nil;
    Middle = nil;
    goPopBuy = nil;
    ScrollView = nil;
    ScrollViewNow = nil;
    ScrollViewContinuous = nil;
    ScrollViewLock = nil;
    tranContent = nil;
    tranNowContent = nil;
    tranContinuousContent = nil;
    tranLockContent = nil;
    txtTime = nil;
    txtNum = nil;
    txtPrice = nil;
    btnBuy = nil;
    btnTask = nil;
    btnReward = nil;
    btnMask = nil;
    btnPay = nil;

end



this.AddRigister=function(uiLink)
    uiLink:AddClickEvent("btnReward",function()
        if not this.PassesIsRuning() then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("18002"));
            return;
        end
        if  not isExpRewarding then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("TrafficPermitViewModel_49"));
            return;
        end
        this.OnAskLevelReward("all",2,function()
            this.ParseData();
        end)
    end)
    uiLink:AddClickEvent("btnTask",function()
       LuaMgr.ShowLuaPanel(UIName.PassesTaskViewModel,cfgThemePass.Id, this.IsChargeRecord())
    end)
    uiLink:AddClickEvent("btnMask",function()
        SetActive(goPopBuy,false);
    end)
    uiLink:AddClickEvent("btnBuy",function()
        if not this.IsChargeRecord() then
            SetActive(goPopBuy,true);
            this.SetPayInfo();
        end
    end)
    uiLink:AddClickEvent("btnPay",function()
        this.OnAskPay();
    end)
end


local data = {
}


this.ExpNorCommand=function(index)
    if not this.PassesIsRuning() then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("18002"));
        return;
    end
    local id=cfgRewards[index].Id;
    if not this.IsCanReward(id,false) then
        return
    end
    this.OnAskLevelReward(id,0,function()
        this.ParseData();
    end)
end

this.ExpHighCommand=function(index)
    if not this.PassesIsRuning() then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("18002"));
        return;
    end
    local id=cfgRewards[index].Id;
    if not this.IsCanReward(id,true) then
        return
    end
    this.OnAskLevelReward(id,1,function()
        this.ParseData();
    end)
end

this.ScrollCallBack=function(screenList)
    if IsNull(screenList) or #screenList==0 then return end;
    local index=screenList[#screenList].data.index
     index=math.ceil(index/10)*10
    if lastLoc==nil or lastLoc~=index then
        lastLoc=index
        this.SetHighReward(index);
    end
end




this.OnAskLevelReward=function(pid,ptype,callBack)
    local askData={
        passesID=cfgThemePass.Id,
        id=pid,
        type=ptype,
    }
    ApiMgr.Request("passes/get_level_award",askData,true,function(result)
        local re=json.decode(result);
        local data=json.encode(re.result);
        LuaMgr.ShowItemRewared(data);
        if callBack~=nil then
            callBack();
        end
    end,nil,true)
    
end
    


this.IsCanReward=function(id,isHigh)
    if isHigh and  not this.IsChargeRecord() then
        return false;
    end
    local passesRewards=DataMgr.Player.passesRewardsMultiple[cfgThemePass.Id];
    if passesRewards[id]==nil or passesRewards[id].level>trafficLevel then
        return false
    end
    if isHigh and passesRewards[id].payReceiveTime>0 then
        return false;
    end
    if not isHigh and passesRewards[id].freeReceiveTime>0 then
        return false;
    end
    return true;
end

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(this.vm.behaviour)
        local tf=this.vm.behaviour.transform;
        RedMgr.Singleton:RegisterViewModel(UIName.PassesMainViewModel);
        reward_ScrollView=tf:Find("root/Left/passes/rewards/ScrollView"):GetComponent("ScrollRect");
        rewardItemGroupObj=tf:Find("template/rewardItemGroup").gameObject
        rewardItemObj=tf:Find("template/rewardItem").gameObject
        rewardScrollView=UIScrollView.New(reward_ScrollView.gameObject)
        rewardScrollView.scrollCallBack=this.ScrollCallBack;
        high_norUIList=UIListView.New(tf:Find("root/Right/High/normalReward"));
        high_speUIList=UIListView.New(tf:Find("root/Right/High/highRewards"));
        payNowUIList=UIListView.New(tranNowContent);
        payContinueousUIList = UIListView.New(tranContinuousContent);
        payLockUIList=UIListView.New(tranLockContent)
        this.buyUIGray=btnBuy.transform:GetComponent("UIGray");
        print("before_awake");
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params == nil) then return end
        lastLevel=nil;
        lastExp=nil;
        isInit=true;
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder,this.PayOrder);
        LuaMgr.AddUIEventListener(UIEventConst.PayOrder,this.PayOrder);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult,this.OnPayResult);
        LuaMgr.AddUIEventListener(UIEventConst.OnPayResult,this.OnPayResult);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess);
        LuaMgr.AddUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess);
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat,this.FrushData);
        LuaMgr.AddUIEventListener(UIEventConst.HeartBeat,this.FrushData);

        HeroRedDataHelper.SetZGCXRed();
        this.ParseData();
    end,
   
    before_deactive = function(vm)
        print("before_deactive");
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder,this.PayOrder);
        LuaMgr.RemoveTimer(TimerConst.FristPayRechargeStatus)
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult,this.OnPayResult);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess);
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat,this.FrushData);
        high_norUIList:Clear();
        high_speUIList:Clear();
        rewardScrollView:Clear(true)
        payLockUIList:Clear();
        payContinueousUIList:Clear()
        payNowUIList:Clear();
    end,
    
    before_destroy=function()
        reward_ScrollView=nil;
        this.Clear();
        UIScrollView.ClearItem("Passes_RewardItemGroup")
        UIListView.ClearItem("Passes_RewardItem")
    end
}


this.FrushData=function()
    this.ParseData();
end


this.SetPayInfo=function()
    local curCharge=ConfigMgr.Config.charge[chargeId];
    local chargeChannel=ConfigHelper.GetChargeChannel(curCharge.ChargeGroup);
    txtPrice.text=chargeChannel.CurrencySymbol..chargeChannel.PriceShow;

    local nowRewards=curCharge.Reward;
    local nowList={}
    if not IsNull(nowRewards) then
        for i,v in ipairs(nowRewards) do
            local item= { item = v,
                          isLock = false,
                          isRed = false,
                          isRewarded =false,
                          alpha = 1,
                          scale=0.6,
            }
            local itemData=UIListData.GetData(rewardItemObj,"Passes_RewardItem",item);
            table.insert(nowList,itemData);
        end
        payNowUIList:SetData(nowList);
        
    end

    local continuousReward = cfgThemePass.ShowRewards2
    local continuousScrollList = {}
    if not IsLua(continuousReward) then
        for i,v in ipairs(continuousReward) do
            local item= { item = v,
                          isLock = false,
                          isRed = false,
                          isRewarded =false,
                          alpha = 1,
                          scale=0.6,
            }
            local itemData=UIListData.GetData(rewardItemObj,"Passes_RewardItem",item);
            table.insert(continuousScrollList,itemData);
        end
        payContinueousUIList:SetData(continuousScrollList);
    end

    local lockList={}
    local unLockRewards=cfgThemePass.ShowRewards
    if not IsNull(unLockRewards) then
        for i,v in ipairs(unLockRewards) do
            local item= { item = {id=v[1],count=v[2]},
                          isLock = false,
                          isRed = false,
                          isRewarded =false,
                          alpha = 1,
                          scale=0.6,
            }
            local itemData=UIListData.GetData(rewardItemObj,"Passes_RewardItem",item);
            table.insert(lockList,itemData);
        end
        payLockUIList:SetData(lockList);
    end
end

this.OnAskPay=function()
    if not this.PassesIsRuning() then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("18002"));
        return;
    end
    if paying then return end;
    if  this.IsChargeRecord()  then
        return;
    end
    paying=true;
    LuaMgr.LuaOnAskPay(chargeId);
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


this.ParseCfg=function()
    cfgThemePass={};
    trafficPermitExp={};
    cfgRewards ={};
    for i,v in pairs(DataMgr.Player.passesMultiple) do
        if ConfigMgr.Config.PassesMap[v.id].type==2 then
            cfgThemePass=ConfigMgr.Config.PassesMap[v.id];
            dataPasses=v;
            break;
        end
    end
    if not IsNull(cfgThemePass.Charge1) and #cfgThemePass.Charge1>0 then
        chargeId=cfgThemePass.Charge1[1];
    end
    for i,v in pairs(DataMgr.Player.passesRewardsMultiple[cfgThemePass.Id]) do
        table.insert(cfgRewards,ConfigMgr.Config.PassesRewardMap[v.id])
    end
    
    table.insert(trafficPermitExp,cfgThemePass.MaxLevel);
    table.insert(trafficPermitExp,cfgThemePass.Exp);
    trafficPermitLevels=ConfigMgr.Config.constants.TrafficPermitLevels;
    table.sort(cfgRewards,function(a, b) return a.Id<b.Id end);
end

this.PassesIsRuning=function()
    return not IsNull(dataPasses) and LuaMgr.Timestamp()<dataPasses.endTime;
end


this.ParseData=function()
    paying=false;
    this.ParseCfg();
    SetActive(goPopBuy,false);
    local count=DataHelper.GetItemCountById(cfgThemePass.Expitems);
    trafficLevel=math.floor(count/trafficPermitExp[2]);
    curScoreNum.text = count
    if lastLoc~=nil then
        this.SetHighReward(lastLoc);
    end
    this.ShowRewards();
    SetActive(goPayLock, not this.IsChargeRecord())
    local remainTime=dataPasses.endTime-LuaMgr.Timestamp()
    if remainTime<0 then
        remainTime=0;
    end
    txtTime.text=TimeString(remainTime)..ConfigMgr.LangGlobal("10210")
    SetActive(btnBuy.gameObject,not this.IsChargeRecord());
end


this.IsChargeRecord=function()
    return not IsNull(dataPasses) and dataPasses.payRecord[cfgThemePass.Charge1[1]]~=nil
end



this.SetHighReward=function(index) ;
    txtNum.text=string.format("%s",index*cfgThemePass.Exp);
    local norReward=this.GetRewardItem(cfgRewards[index],true)
    local sepReward=this.GetRewardItem(cfgRewards[index],false)
    local norList={}
    for i,v in ipairs(norReward) do
        local dataItem=UIListData.GetData(rewardItemObj,"Passes_RewardItem",v)
        table.insert(norList,dataItem);
    end
    high_norUIList:SetData(norList,true)
    local highList={}
    for i,v in ipairs(sepReward) do
        local dataItem=UIListData.GetData(rewardItemObj,"Passes_RewardItem",v)
        table.insert(highList,dataItem);
    end
    high_speUIList:SetData(highList,true)
end


this.ShowRewards=function()
    startIndex=0;
    isExpRewarding=false;
    local dataList={};
    for i,v in ipairs(cfgRewards) do
        local norItems,norIsRewarding=this.GetRewardItem(v,true);
        local speItems,speIsRewarding=this.GetRewardItem(v,false);
        local rewardItem= {
            index=i,
            num_1 = norItems[1].isLock and string.format("%s",i*cfgThemePass.Exp) or string.format("<color=#95DAF5>%s</color>",i*cfgThemePass.Exp),
            normalItems = norItems,
            specialItems=speItems,
            rewardItemObj=rewardItemObj;
            callBackNor=this.ExpNorCommand,
            callBackSpe=this.ExpHighCommand,
            isNorRewarding=norIsRewarding,
            isSpeRewarding=speIsRewarding,
        }
        local rewardData=UIScrollData.GetData(rewardItemGroupObj,"Passes_RewardItemGroup",190,500,rewardItem)
        table.insert(dataList,rewardData);
    end

    for i,v in ipairs(dataList) do
        if #v.data.normalItems>0 and not v.data.normalItems[1].isRewarded then
            startIndex=i
            break
        end
    end
    local width=LuaMgr.GetScreenWidth()-242-73-136;
    rewardScrollView:SetParams(width,522)
    reward_ScrollView.transform.sizeDelta=Vector2(width,522);
    rewardScrollView:SetData(dataList,false)
    rewardScrollView:MoveToIndex(startIndex);
    SetActive(btnReward.gameObject,isExpRewarding)
    if isInit then
        coroutine_runner.start(function()
            for i,v in ipairs(rewardScrollView.screenList) do
                v:DOAlphaAnimation(0.03*i)
            end
        end)
        isInit=false;
    end
end

this.GetRewardItem=function(rewardItem,isNor)
    local itemList={}
    local state=1;
    local dataPassesRewardsMultiple=DataMgr.Player.passesRewardsMultiple[cfgThemePass.Id];
    local dataReward=dataPassesRewardsMultiple[rewardItem.Id];
    local receiveTime=isNor and dataReward.freeReceiveTime or dataReward.payReceiveTime;
    local rewards=isNor and rewardItem.FreeReward or rewardItem.PayReward;
    if receiveTime>0 then
        state=3;
    elseif trafficLevel>=dataReward.level and (isNor or this.IsChargeRecord()) then
        state=2;
        isExpRewarding=true;
    end
    if not IsNull(rewards) and  #rewards>0 then
        for i,v in ipairs(rewards) do
            local item= { item = v,
                          isLock = state == 1,
                          isRed = state == 2,
                          isRewarded = state == 3,
                          alpha = state == 2 and 1.0 or 0.5,
            }
            table.insert(itemList,item)
        end

    end
    return itemList,state==2;
end



return vm({
    data = data,
    command = command,
    hook = hook
})