




local this = {vm=nil};
local goodItemLocalPos={Vector2(-394,233),Vector2(-387,83),Vector2(-319,-50), Vector2(-202,-145),
                        Vector2(-58,-183),Vector2(90,-161),Vector2(214,-78),Vector2(296,45)}
local spineUICharacter=nil;
local cfgOnlineReward={}
local dataOnlineReward={}
local endTimer=nil;
local curSelectIndex=nil;
local stopOnClick=false;
local stopClose=false;
local data = {
   goodItemList={{locPos=Vector2(0,0),icon=DefaultSprite,select=false,hasReward=false,light=true,
                  loop=false,iconBool=true, nameBool=false,name="",
                 onClick_1=false,onClick_2=false,onClick_3=false,onClick_4=false,onClick_5=false,
                  onClick_6=false,onClick_7=false,onClick_8=false}},
   goodsList={{id="1",count=tostring(0),sizeDelta=Vector2(0,0),isCount=true,rare=DefaultSprite,icon=DefaultTexture,scale=Vector3(0,0,0),isClick=true}};
   rewardBtnMask=true;
   rewardBtn=false;
   msgConent="";
   timerText="";
   rewardTipBool=false;
   rewardTipAnchor=Vector2(0,0);
   characterPath="";
}

local command = {

    closeBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if stopClose then
                return;
            end
            LuaMgr.HidePanel("ActivitySnacksViewModel");
        end
    },
    
    goodItemBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if stopOnClick then return end;
            local index=tonumber(param)+1;
            if this.vm.data.goodItemList[index].select then
                stopOnClick=true;
                this.AskReward();
                return;
            end
            this.SetItemTip(index);
            AudioHelper.PlayUISFX(AudioNames.EButtonLight)
        end
        
    },
    rewardBtn= {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.AskReward();
        end
    },
    closeTipBtn={
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.rewardTipBool=false;
        end
    }


}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
        print("before_awake");
        spineUICharacter=vm.behaviour.transform:Find("root/Middle/group/Character/Group/Body"):GetComponent("UISpineCharacter");
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then

            stopOnClick=false;
            stopClose=false;
            cfgOnlineReward=ConfigMgr.Config.onlineReward;
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        this.Clear();
        HeroRedDataHelper.SnackOnLineRed()
        RedMgr.Singleton:RefreshOtherViewModel(UIName.MainPageViewModel);
    end,
}

this.Clear=function()
    LuaMgr.RemoveTimer(TimerConst.OnlineReward)
    if spineUICharacter~=nil then
        spineUICharacter:Clear();
    end
    cfgOnlineReward={}
    dataOnlineReward={}
    endTimer=nil;
    curSelectIndex=nil;
    stopOnClick=false;
    this.vm.data.characterPath="";
end

this.SnacksComplete=function(num)
    local data={
        status=num,
        days=DataMgr.Player.onlineReward.Days;
        accountId=DataMgr.Player.uid;
    }
    local dataJson=json.encode(data)
    local askData={
        event="onlineactivity",
        log=dataJson,
    }
    ApiMgr.Request("log_client_event",askData,true,nil,nil,false);
end



this.AskReward=function()
    ApiMgr.Request("get_online_reward", {}, true, function(result)
        local re = json.decode(result);
        local data = json.encode(re.result);
        this.SnacksComplete(curSelectIndex);

        AudioHelper.PlayUISFX(AudioNames.EEat_Snack)
        this.vm.data.rewardBtnMask=true;
        this.vm.data.rewardBtn=false;
        this.vm.data.goodItemList[curSelectIndex].select=false;
        this.vm.data.goodItemList[curSelectIndex].loop=false;
        this.vm.data.goodItemList[curSelectIndex].iconBool=false;
        if curSelectIndex==1 then
            this.vm.data.goodItemList[curSelectIndex].onClick_1=true;
        elseif curSelectIndex==2 then
            this.vm.data.goodItemList[curSelectIndex].onClick_2=true;
        elseif curSelectIndex==3 then
            this.vm.data.goodItemList[curSelectIndex].onClick_3=true;
        elseif curSelectIndex==4 then
            this.vm.data.goodItemList[curSelectIndex].onClick_4=true;
        elseif curSelectIndex==5 then
            this.vm.data.goodItemList[curSelectIndex].onClick_5=true;
        elseif curSelectIndex==6 then
            this.vm.data.goodItemList[curSelectIndex].onClick_6=true;
        elseif curSelectIndex==7 then
            this.vm.data.goodItemList[curSelectIndex].onClick_7=true;
        elseif curSelectIndex==8 then
            this.vm.data.goodItemList[curSelectIndex].onClick_8=true;
        end
        coroutine_runner.start(function()
            stopClose=true;
            coroutine_runner.wait(2);
            LuaMgr.ShowItemRewared(data);
            this.ParseData();
            stopOnClick=false;
            stopClose=false;
        end)
    end, nil, true);
end

this.ParseData=function()
    dataOnlineReward=DataMgr.Player.onlineReward;
    if dataOnlineReward.RewardID==0 then
        LuaMgr.InvokeUIEventListeners(UIEventConst.MainActivityFrush)
        LuaMgr.HidePanel(UIName.ActivitySnacksViewModel);
        return;
    end
    this.SetOnlineRewared();
    this.SetTimerText();
    this.SetCharacterSpine();
end


this.SetCharacterSpine=function()
    local characterId="V0078";
    local skinId=characterId.."001";
    local path = HeroManager.SetCharacterDrawing(spineUICharacter, characterId,skinId);
    if (path ~= "") then
        this.vm.data.characterPath=path;
    end
end
this.SetOnlineRewared=function()
    local curDayRewards=cfgOnlineReward[dataOnlineReward.Days];
    if(curDayRewards==nil) then
        LuaMgr.HidePanel("ActivitySnacksViewModel");
        return
    end;
    this.vm.data.goodItemList={};
    local list={};

    local lastTime=dataOnlineReward.EndTime-LuaMgr.Timestamp();
    local btnMask=lastTime>0;
    for i,v in ipairs(curDayRewards) do
        local rewardItem={
            locPos=goodItemLocalPos[i],
            icon=LuaMgr.GetSprite("SnacksItem",v.Icon),
            name=LuaMgr.GetLangText(v.NameLan),
            hasReward=v.ID<dataOnlineReward.RewardID or dataOnlineReward.RewardID==0,
            light=v.ID>=dataOnlineReward.RewardID and dataOnlineReward.RewardID~=0 ,
            select = v.ID==dataOnlineReward.RewardID and lastTime<=0,
            loop=true,iconBool=true,
            onClick_1=false,onClick_2=false,onClick_3=false,onClick_4=false,
            onClick_5=false,onClick_6=false,onClick_7=false,onClick_8=false,
        };
        if v.ID==dataOnlineReward.RewardID then
            curSelectIndex=i;
        end
        table.insert(list,rewardItem);
    end
    this.vm.data.rewardBtnMask=btnMask;
    this.vm.data.rewardBtn=not btnMask;
    
    local line=this.FindLines(curDayRewards,btnMask);
    if(line~=nil) then
        this.vm.data.msgConent=LuaMgr.GetLangText(line);
    end
    this.vm.data.goodItemList=list;
    this.SetTimerText();
end


this.FindLines=function(dayReward,nofinished)
    for i,v in ipairs(dayReward) do
        if(v.ID==dataOnlineReward.RewardID) then
            return nofinished and v.UnfinishedLan or v.DescriptionLan;
        end
    end
    return nil;
end

this.SetItemTip=function(index)
    local dayrewards=cfgOnlineReward[dataOnlineReward.Days];
    local rewards=dayrewards[index].Reward;
    if(rewards==nil) then return end;
    this.vm.data.rewardTipBool=true;
    this.vm.data.rewardTipAnchor=Vector2(goodItemLocalPos[index].x,goodItemLocalPos[index].y-110);
    local list={}
    for i,v in ipairs(rewards) do
        local item =ConfigMgr.Config.itemMap[v.id];
        local rewardItem={id=v.id,count=LuaMgr.NumFormat(v.count),isCount=true,
                          rare=ActivityMgr.GetRareSprite(item.rare),
                          icon=ActivityMgr.GetItemTexture(v.id),
                          scale=Vector3(0.7,0.7,0.7),
                          sizeDelta=Vector2(90,90),
                          isClick=true}
        table.insert(list,rewardItem);
    end
    this.vm.data.goodsList=list;
    
end

this.SetTimerText=function()
    local curTime=LuaMgr.Timestamp();
    endTimer= dataOnlineReward.EndTime-curTime;
    if(endTimer>0) then
        LuaMgr.RemoveTimer(TimerConst.OnlineReward)
        LuaMgr.AddTimer(TimerConst.OnlineReward,this.frushShowTimer,1,72000,true);
    else
        this.vm.data.timerText="00:00:00";
    end
    
end

this.frushShowTimer=function()
    local timer=os.date("!%X", endTimer);
    this.vm.data.timerText=timer;
    if(endTimer<=0) then
        LuaMgr.RemoveTimer(TimerConst.OnlineReward)
        this.ParseData();
    end
    endTimer=endTimer-1;
end

return vm({
    data = data,
    command = command,
    hook = hook
})