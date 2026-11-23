





local this = {vm=nil};
local cfgThemePass=nil;
local cfgRewards=nil;
local dataPasses=nil;
local buyCount=1;
local maxBuyCount=nil;
local callBack=nil;
local curLevel=nil;
local passesExpExchange=nil;
local  isEnough=false;


local rewards= {
    nor = {};
    high = {};
}


local data = {
    curLevel="",
    tarLevel="",
    costIcon=DefaultTexture,
    costCount="",
    buyNum="",
    
    goodsList={{}},
    
}

local command = {
    addBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            buyCount=buyCount+1;
            buyCount=buyCount>maxBuyCount and maxBuyCount or buyCount;
            this.UpdateBuyInfo();
        end
    },
    subtractBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            buyCount=buyCount-1;
            buyCount=buyCount<1 and 1 or buyCount;
            this.UpdateBuyInfo();
        end
    },
    buyBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if not this.PassesIsRuning() then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("18002"));
                return;
            end
            if not isEnough then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("TrafficPermitBuyTipViewModel_13"));
                return;
            end
            local askData={passesID=cfgThemePass.Id,id=tostring(passesExpExchange[1]),total=buyCount*passesExpExchange[2]}
            ApiMgr.Request("passes/exchange", askData, true, function(result)
                if callBack~=nil then
                    callBack();
                end
                LuaMgr.HidePanel(UIName.PassesBuyTip2ViewModel)
            end, nil, true);
            
        end
                
          
        
    },
    buyInput = {
        type = XLuaCommandType.String,
        execute = function(vm,value,param)
            local num=0;
            if value=="" or value=="-" then
                num=1
            else
                num=tonumber(value);
                local maxNum=maxBuyCount;
                if num>maxNum then
                    num=maxNum;
                elseif num<1 then
                    num=1;
                end
            end
            buyCount=num;
            this.UpdateBuyInfo()
        end
    },
    closeBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.PassesBuyTip2ViewModel);
        end
    },
    
}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
        print("before_awake");
    end,
    before_active = function(vm)
        print("before_active");
        if vm.behaviour.Params==nil then return end;
        if  vm.behaviour.Params.Length>1 then
            local themId=vm.behaviour.Params[0];
            callBack=vm.behaviour.Params[1];
            cfgThemePass=ConfigMgr.Config.PassesMap[themId];
            buyCount=1;
            passesExpExchange=ConfigMgr.Config.constants.PassesExpExchange;
            cfgRewards={}
            for i,v in pairs(DataMgr.Player.passesRewardsMultiple[cfgThemePass.Id]) do
                table.insert(cfgRewards,ConfigMgr.Config.PassesRewardMap[v.id])
            end
            table.sort(cfgRewards,function(a, b) return a.Id<b.Id end);
            this.ParseData();
            
        end
        
    end,
    before_deactive = function(vm)
        print("before_deactive");
        rewards={};
    end,
}


this.PassesIsRuning=function()
    return not IsNull(dataPasses) and LuaMgr.Timestamp()<dataPasses.endTime;
end


this.ParseData=function()
    dataPasses=DataMgr.Player.passesMultiple[cfgThemePass.Id]
    
    local count=DataHelper.GetItemCountById(cfgThemePass.Expitems);
    curLevel=math.floor(count/cfgThemePass.Exp);
    if curLevel>cfgThemePass.MaxLevel then 
        curLevel=cfgThemePass.MaxLevel
    end;
    this.vm.data.curLevel=tostring(curLevel*cfgThemePass.Exp);
    this.vm.data.costIcon=ConfigHelper.GetItemTexture(tostring(passesExpExchange[1]))
    maxBuyCount=math.floor(DataHelper.GetItemCountById(tostring(passesExpExchange[1]))/passesExpExchange[2]);
    isEnough=maxBuyCount>0;
    this.UpdateBuyInfo()
    
    local limitLevel=cfgThemePass.MaxLevel-curLevel
    if maxBuyCount<1 then
        maxBuyCount=1;
    elseif maxBuyCount>limitLevel then
        maxBuyCount=limitLevel;
    end
    
end


this.IsCharged=function()
    return dataPasses.payRecord[cfgThemePass.Charge1[1]]~=nil
end
    



this.UpdateBuyInfo=function()
    local costText=isEnough and "%s" or "<color=#EA0D22>%s</color>"
    this.vm.data.buyNum=tostring(buyCount);
    this.vm.data.costCount=string.format(costText,buyCount*passesExpExchange[2]);
    this.vm.data.tarLevel=tostring((curLevel+buyCount)*cfgThemePass.Exp);
    this.ShowRewards();
end

this.MergeRewads=function(startIndex,endIndex)
    local unlock=this.IsCharged();
    local mergeRewards={}
    local rewardNor={};
    local rewardHigh={};
    for i=startIndex+1,endIndex,1 do
        rewardNor=rewards.nor[i];
        if not IsNull(rewardNor) then
            for p,m in ipairs(rewardNor) do
                if mergeRewards[m.id]==nil then
                    mergeRewards[m.id]={id=m.id,count=m.count};
                else
                    mergeRewards[m.id].count=mergeRewards[m.id].count+m.count;
                end
            end
            
        end
       rewardHigh=unlock and rewards.high[i] or nil;
        if not IsNull(rewardHigh) and rewardHigh~=nil then
            for p,m in ipairs(rewardHigh) do
                if mergeRewards[m.id]==nil then
                    mergeRewards[m.id]={id=m.id,count=m.count};
                else
                    mergeRewards[m.id].count=mergeRewards[m.id].count+m.count;
                end
            end

        end
        
    end
    return mergeRewards;
    
end

this.ShowRewards=function()
    rewards= {
        nor = {};
        high = {};
    }
    local norRewardsList={};
    local highRewardsList={};
    for i,v in ipairs(cfgRewards) do
        if IsNull(v.FreeReward) then
            table.insert(norRewardsList,{});
        else
            table.insert(norRewardsList,v.FreeReward);
        end
        if IsNull(v.PayReward) then
            table.insert(highRewardsList,{});
        else
            table.insert(highRewardsList,v.PayReward);
        end
    end
    rewards.nor=norRewardsList;
    rewards.high=highRewardsList;
    
    local startIndex=curLevel;
    local endIndex=curLevel+buyCount;
    local list={};
    local mergeRewards=this.MergeRewads(startIndex,endIndex)
    for i,v in pairs(mergeRewards) do
        local item=ConfigHelper.CreateGoodsItem(v.id,v.count,0.8,true,true);
        table.insert(list,item);
    end
    this.vm.data.goodsList=list;
    list=nil;
end


return vm({
    data = data,
    command = command,
    hook = hook
})