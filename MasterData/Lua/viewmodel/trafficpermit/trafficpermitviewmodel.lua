




require("ViewModel/TrafficPermit/TrafficPermit_RewardItemGroup")
require("ViewModel/TrafficPermit/TrafficPermit_RewardItem")
local this = {vm=nil};

local rewardItemGroupObj=nil;
local rewardItemObj=nil;
local rewardScrollView=nil;
local high_norUIList=nil
local high_speUIList=nil;
local trafficPermitExp=nil;
local trafficPermitLevels=nil;



local cfgThemePass={};
local cfgDayTask={};
local cfgWeekTask={};
local cfgAchievementTask={};
local cfgRewards={};
local reward_ScrollView=nil;
local spineCharacter=nil;
local dataPasses=nil;

local highIndex=nil;
local taskBarIndex=nil;
local barIndex=nil;
local isMaxLevel=false;
local isExpRewarding=false;
local isTaskRewarding=false;
local startIndex=nil;
local isInit=false;
local lastLoc=nil;
local lastLevel=nil;;
local lastExp=nil;
local trafficLevel=nil;


local rewards= {
    nor = {};
    high = {};
}


local taskBarColor1=UnityEngine.Color(255/255,255/255,255/255,1);
local taskBarColor2=UnityEngine.Color(37/255,36/255,42/255,1);



local data = {

    barList={
        {isOn=false},
        {isOn=false}
    },

    trafficPermitList={
        {
            isOn=true,
            lock=false,
            icon=DefaultTexture,
        },
        {
            isOn=false,
            lock=true,
            icon=DefaultTexture,
        }
    },
   
    goodsList={
        {
          
        }
    },
    
    taskBarList={
        {
            isOn=true,
            color=taskBarColor1,
            time="",
        },
        {
            isOn=false,
            color=taskBarColor2,
            time="",
        },
        {
            isOn=true,
            color=taskBarColor2,
            time="",
        },
    },
    
    taskList={
        {
            id="",
            jumpId="",
            bg = DefaultSprite,
            des = "",
            rewarding = false,
            rewarded = false,
            rewardno = false,
            sliderValue = 0.0,
            sliderText = "",
            isTime=false,
            timeText="",
            goods = { {} },
        }
        
    },
    
    
    middle_rewardBool=false,
    middle_taskBool=false,
    rewardExpContentSizeData=Vector2(0,0);
    rewardExpContentAnchor=Vector2(0,0);
    taskContentAnchor=Vector2(0,0);
    
    top_Level="",
    top_Exp="",
    top_MaxExp="",
    top_slider=0.0,
    
    high_Num1="",
    high_Num2="",
    
    time="";
    rewardAllBtnBool=false;
    activeTrafficBool=true;
    buyExpBool=false;
    
    rewardContentBool=true;
    left_rootAnimater="";
    bodyPath="";
    offBodyPos=Vector2.zero;
    offBodyScale=Vector3.zero;
    
    
}

local command = {

    expAllBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if not this.PassesIsRuning() then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("TrafficPermitViewModel_48"));
                return;
            end
            if barIndex==1 and not isExpRewarding then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("TrafficPermitViewModel_49"));
                return;
            elseif barIndex==2 and not isTaskRewarding then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("TrafficPermitViewModel_50"));
                return;
            end
            if barIndex==1 then
                this.OnAskLevelReward("all",2,function()
                    this.ParseData();
                end)
            else
                this.OnAskMissionReward("all",taskBarIndex,function()
                    this.ParseData();
                end)
            end
        end
    },
    rewardBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if not this.PassesIsRuning() then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("TrafficPermitViewModel_53"));
                return;
            end
            local index=tonumber(param)+1;
            local id=this.vm.data.taskList[index].id;
            this.OnAskMissionReward(id,taskBarIndex,function()
                this.ParseData();
            end)
        end
    },
    jumpBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index=tonumber(param)+1;
            local jumpId=this.vm.data.taskList[index].jumpId;
            if jumpId~=nil and jumpId~="" then
                FeatureManager.GotoViewModel(jumpId);
                HeroParameter.TrafficPermitTabIndex=2;
            end
        end
    },
    buyExpBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if not this.PassesIsRuning() then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("TrafficPermitViewModel_54"));
                return
            end
            if isMaxLevel then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("TrafficPermitViewModel_55"));
                return
            end
            LuaMgr.ShowLuaPanel(UIName.TrafficPermitBuyTipViewModel,rewards,function()
                    this.ParseData();
            end);
        end
    },
    activePayBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if not this.PassesIsRuning() then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("TrafficPermitViewModel_56"));
                return;
            end
           LuaMgr.ShowLuaPanel(UIName.TrafficPermitPayViewModel);
            RedMgr.Singleton:FrushRedCondition("1131");
        end
    },
  
    taskBarBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index=tonumber(param);
            taskBarIndex=index;
            this.SetTaskBar(index);
        end
    },
    
    
    barBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if not this.PassesIsRuning() then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("TrafficPermitViewModel_51"));
                return;
            end
            local index=tonumber(param);
            barIndex=index;
            taskBarIndex=2;
            dataPasses=DataMgr.Player.passes
            this.SetBarState(index);
            
        end
        
    },
}


this.ExpNorCommand=function(index)
    if not this.PassesIsRuning() then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("TrafficPermitViewModel_51"));
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
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("TrafficPermitViewModel_52"));
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
    local passesRewards=DataMgr.Player.passesRewards;
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





this.OnAskMissionReward=function(pid,ptab,callBack)
    local tag="daily";
    if ptab==2 then
        tag="weekly"
    elseif ptab==3 then
        tag="period"
    end
    local askData={
        id=pid,
        tab=tag
    }
    ApiMgr.Request("passes/get_mission_award",askData,true,function(result)
        local re=json.decode(result);
        local data=json.encode(re.result);
        LuaMgr.ShowItemRewared(data);
        if callBack~=nil then
            callBack();
        end
    end,nil,true)
end

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        local tf=this.vm.behaviour.transform;
        RedMgr.Singleton:RegisterViewModel(UIName.TrafficPermitViewModel);
        reward_ScrollView=tf:Find("root/Left/Left_root/Middle_rewards/ScrollView"):GetComponent("ScrollRect");
        spineCharacter=tf:Find("root/Middle/right/Character/offset/body"):GetComponent("UISpineCharacter");
        rewardItemGroupObj=tf:Find("template/rewardItemGroup").gameObject
        rewardItemObj=tf:Find("template/rewardItem").gameObject
        rewardScrollView=UIScrollView.New(reward_ScrollView.gameObject)
        rewardScrollView.scrollCallBack=this.ScrollCallBack;
        
        high_norUIList=UIListView.New(tf:Find("root/Left/Left_root/Middle_rewards/High_1/normalReward"));
        high_speUIList=UIListView.New(tf:Find("root/Left/Left_root/Middle_rewards/High_1/highRewards"));
        print("before_awake");
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params == nil) then return end
        lastLevel=nil;
        lastExp=nil;
        isInit=true;
        barIndex=1;
        taskBarIndex=2;
        this.ParseData();
    end,
   
    before_deactive = function(vm)
        print("before_deactive");
        if (vm.behaviour.Params == nil) then return end
        if (spineCharacter~= nil) then
            spineCharacter:Clear();
        end
        rewardScrollView:Clear(true)
    end,
    
    before_destroy=function()
        spineCharacter=nil;
        reward_ScrollView=nil;
        UIScrollView.ClearItem("TrafficPermit_RewardItemGroup")
        UIScrollView.ClearItem("TrafficPermit_RewardItem")
    end
}
this.ParseCfg=function()
    cfgThemePass={};
    cfgDayTask={};
    cfgWeekTask={};
    trafficPermitExp={};
    cfgAchievementTask={};
    cfgRewards={};
    for i,v in pairs(DataMgr.Player.passesMissions.daily) do
        table.insert(cfgDayTask,ConfigMgr.Config.PassesTaskMap[v.id])
    end
    for i,v in pairs(DataMgr.Player.passesMissions.weekly) do
        table.insert(cfgWeekTask,ConfigMgr.Config.PassesTaskMap[v.id])
    end
    for i,v in pairs(DataMgr.Player.passesMissions.period) do
        table.insert(cfgAchievementTask,ConfigMgr.Config.PassesTaskMap[v.id])
    end

    for i,v in pairs(DataMgr.Player.passesRewards) do
        table.insert(cfgRewards,ConfigMgr.Config.PassesRewardMap[v.id])
    end
    
    cfgThemePass=ConfigMgr.Config.PassesMap[DataMgr.Player.passes.id];
    table.insert(trafficPermitExp,cfgThemePass.MaxLevel);
    table.insert(trafficPermitExp,cfgThemePass.Exp);
    trafficPermitLevels=ConfigMgr.Config.constants.TrafficPermitLevels;
 
    table.sort(cfgDayTask,function(a, b) return a.Id<b.Id end);
    table.sort(cfgWeekTask,function(a, b) return a.Id<b.Id end);
    table.sort(cfgAchievementTask,function(a, b) return a.Id<b.Id end);
    table.sort(cfgRewards,function(a, b) return a.Id<b.Id end);
end

this.PassesIsRuning=function()
    return not IsNull(DataMgr.Player.passes) and not IsNullOrEmpty(DataMgr.Player.passes.id)
end


this.ParseData=function()
    this.ParseCfg();
    local width=(trafficPermitExp[1]*95)+50
    this.vm.data.rewardExpContentSizeData=Vector2(width,522);
    this.SetCharacter();
    dataPasses=DataMgr.Player.passes;
    this.SetLevelExp()
    if lastLoc~=nil then
        this.SetHighReward(lastLoc);
    end
    if HeroParameter.TrafficPermitTabIndex~=nil then
        barIndex=HeroParameter.TrafficPermitTabIndex
        HeroParameter.TrafficPermitTabIndex=nil;
    end
    this.SetBarState(barIndex);
    this.SetTrafficPermitState();
    
end

this.SetCharacter=function()
    local characterId = cfgThemePass.CharacterInfos[1][1];
    local skinId = cfgThemePass.CharacterInfos[1][2];
    local path = HeroManager.SetCharacterDrawing(spineCharacter, characterId,skinId);
    if (path ~= "") then
        this.vm.data.bodyPath = path;
    end
    this.vm.data.offBodyPos=Vector2(tonumber(cfgThemePass.CharacterInfos[1][3]),tonumber(cfgThemePass.CharacterInfos[1][4]))
    this.vm.data.offBodyScale=Vector3.one*tonumber(cfgThemePass.CharacterInfos[1][5])
end

this.SetBarState=function(index)
    for i,v in ipairs(this.vm.data.barList) do
        v.isOn=i==index;
    end
    this.vm.data.middle_rewardBool=index==1;
    this.vm.data.middle_taskBool=index==2;
    if index==1 then
        this.vm.data.left_rootAnimater="UI_Middle_rewards_appear";
        this.ShowRewards();
        HeroRedDataHelper.FrushTrafficPermitNewRed();
    else
        this.vm.data.left_rootAnimater="UI_Middle_Task_appear";




        this.SetTaskBar(taskBarIndex);
    end
end

this.SetLevelExp=function()

    local count=DataHelper.GetItemCountById("19");
    trafficLevel=math.floor(count/trafficPermitExp[2]);

    isMaxLevel=trafficLevel >= trafficPermitExp[1];
    if isMaxLevel then
        trafficLevel=trafficPermitExp[1];
    end
    local curExp=count-(trafficLevel*trafficPermitExp[2]);
    curExp=isMaxLevel and 0 or curExp;
    
  
    local num=lastLevel~=nil and (trafficLevel-lastLevel) or 0;

    if lastLevel~=nil and num>0 then
        
        DOTWeen.To(function() return this.vm.data.top_Level  end,function(value)
            this.vm.data.top_Level=math.floor(value);
        end,trafficLevel,0.1*num).onComplete=function()
            this.vm.data.top_Exp=0;
            this.vm.data.top_slider=0;
            DOTWeen.To(function() return 0 end,function(value)
                this.vm.data.top_Exp=math.floor(value);
            end,curExp,0.1);
            DOTWeen.To(function() return 0 end,function(value)
                this.vm.data.top_slider=value;
            end,curExp/trafficPermitExp[2],0.1)
        end
        
        DOTWeen.To(function() return 0 end,function(value)
            this.vm.data.top_Exp=math.floor(value);
        end,trafficPermitExp[2],0.1):SetLoops(num);
        DOTWeen.To(function() return 0 end,function(value)
            this.vm.data.top_slider=value;
        end,1,0.1):SetLoops(num);
    elseif lastLevel~=nil and curExp~=lastExp then
        DOTWeen.To(function() return this.vm.data.top_Exp end,function(value)
            this.vm.data.top_Exp=math.floor(value);
        end,curExp,0.1);
        DOTWeen.To(function() return this.vm.data.top_slider end,function(value)
            this.vm.data.top_slider=value;
        end,curExp/trafficPermitExp[2],0.1)
    else
        this.vm.data.top_Level=trafficLevel;
        this.vm.data.top_Exp=curExp
        this.vm.data.top_MaxExp="/"..trafficPermitExp[2];
        this.vm.data.top_slider=isMaxLevel and 0 or curExp/trafficPermitExp[2];
    end
    lastLevel=trafficLevel;
    lastExp=curExp;

   
    this.vm.data.activeTrafficBool=not this.IsChargeRecord();
    local curTime=LuaMgr.Timestamp();
    local endTime=0;
    if not IsNullOrEmpty(DataMgr.Player.passes.id) then
        endTime=DataMgr.Player.passes.endTime;
    end
    local remainTime=endTime-curTime
    if remainTime<0 then
        remainTime=0;
    end
    this.vm.data.time=TimeString(remainTime)..ConfigMgr.LangGlobal("10210")
end

this.IsChargeRecord=function()
    if DataMgr.Player.passes.payRecord[cfgThemePass.Charge1[1]]~=nil or DataMgr.Player.passes.payRecord[cfgThemePass.Charge2[1]]~=nil then
        return true;
    end
    return false;
end

this.SetTrafficPermitState=function()
    local isOn=this.IsChargeRecord();
    this.vm.data.trafficPermitList[2].isOn=isOn;
    this.vm.data.trafficPermitList[2].lock= not isOn;
end

this.SetHighReward=function(index) ;
    this.vm.data.high_Num1=string.format("%.2d",index);
    local norReward=this.GetRewardItem(cfgRewards[index],true)
    local sepReward=this.GetRewardItem(cfgRewards[index],false)
    local norList={}
    for i,v in ipairs(norReward) do
        local dataItem=UIListData.GetData(rewardItemObj,"TrafficPermit_RewardItem",v)
        table.insert(norList,dataItem);
    end
    high_norUIList:SetData(norList,true)
    local highList={}
    for i,v in ipairs(sepReward) do
        local dataItem=UIListData.GetData(rewardItemObj,"TrafficPermit_RewardItem",v)
        table.insert(highList,dataItem);
    end
    high_speUIList:SetData(highList,true)
end


this.ShowRewards=function()
    startIndex=0;
    rewards= {
        nor = {};
        high = {};
    }
    local norRewardsList={};
    local highRewardsList={};
    isExpRewarding=false;
    local dataList={};
    for i=1,trafficPermitExp[1],1 do
        if IsNull(cfgRewards[i].FreeReward) then
            table.insert(norRewardsList,{});
        else
            table.insert(norRewardsList,cfgRewards[i].FreeReward);
        end
        if IsNull(cfgRewards[i].FreeReward) then
            table.insert(highRewardsList,{});
        else
            table.insert(highRewardsList,cfgRewards[i].PayReward);
        end
        local norItems,norIsRewarding=this.GetRewardItem(cfgRewards[i],true);
        local speItems,speIsRewarding=this.GetRewardItem(cfgRewards[i],false);
        local rewardItem= {
            index=i,
            num_1 = string.format("%.2d",i),

            normalItems = norItems,
            specialItems=speItems,
            rewardItemObj=rewardItemObj;
            callBackNor=this.ExpNorCommand,
            callBackSpe=this.ExpHighCommand,
            isNorRewarding=norIsRewarding,
            isSpeRewarding=speIsRewarding,
        }
        local rewardData=UIScrollData.GetData(rewardItemGroupObj,"TrafficPermit_RewardItemGroup",90,412,rewardItem)
        table.insert(dataList,rewardData);
    end

    for i,v in ipairs(dataList) do
        if #v.data.normalItems>0 and not v.data.normalItems[1].isRewarded then
            startIndex=i
            break
        end
    end
    rewards.nor=norRewardsList;
    rewards.high=highRewardsList;
    rewardScrollView:SetParams(490,522)
    rewardScrollView:SetData(dataList,false,startIndex+4)
    this.vm.data.rewardAllBtnBool=isExpRewarding;
    if isInit then
        coroutine_runner.start(function()
            for i,v in ipairs(rewardScrollView.screenList) do
                v:DOAlphaAnimation(0.03*i)
            end
        end)
        isInit=false;
    end
end

this.CreateRewardItem=function(norRewardsList,highRewardsList,i,num,num1,num2,state)
local normal=cfgRewards[i].FreeReward;
    local special=cfgRewards[i].PayReward;
    if IsNull(normal) then
        table.insert(norRewardsList,{});
    else
        table.insert(norRewardsList,normal.showReward);
    end
    table.insert(highRewardsList,special.showReward)
    
    num=tostring(i);
    if #num<2 then
        num1="0";
        num2=num;
    else
        num1=string.format("<color=#B14747>%s</color>",string.sub(num,1,1));
        num2=string.sub(num,2,2);
    end

    local rewardItem= {
        num_1 = num1,
        num_2 = num2,
        alpha=0.0,
        specialItems = this.GetRewardItem(cfgRewards[i],true),
        normalItems=this.GetRewardItem(cfgRewards[i],false),
    }
    return rewardItem
end


this.GetRewardItem=function(rewardItem,isNor)
    local itemList={}
    local state=1;
    local dataReward=DataMgr.Player.passesRewards[rewardItem.Id];
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


this.SetTaskBar=function(index)
    if not this.PassesIsRuning() then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("TrafficPermitViewModel_51"));
        return
    end
    for i,v in ipairs(this.vm.data.taskBarList) do
        v.color=index==i and taskBarColor1 or taskBarColor2;
        v.isOn=index==i;
    end
    
    this.ShowTask(index);
    HeroRedDataHelper.FrushTrafficPermitNewRed();
end

 
this.ShowTask=function(index)
    isTaskRewarding=false;
    this.vm.data.taskContentAnchor=Vector2(0,0);
    this.vm.data.taskList={};
    local list={};
    local tasklist,passesMissions =this.GetCfgTaskListByType(index);
    local colorString="%s";
    for i,v in ipairs(tasklist) do
        local dataTask=passesMissions[v.Id];
        if dataTask~=nil then
            local state=1;
            local sortNum=2;
            if dataTask.completed then
                state=3
                colorString="<color=#182E50>%s</color>"
                sortNum=3
            elseif not dataTask.completed and dataTask.current==dataTask.target then
                isTaskRewarding=true;
                colorString="<color=#6f2846>%s</color>"
                sortNum=1
                state=2;
            else
                colorString="<color=#0f0d17>%s</color>"
                state=1
                sortNum=2
            end
            local goodList={};
            
            local item=ConfigHelper.CreateGoodsItem("19",v.Exp,0.4,true,true);
            table.insert(goodList,item);

            local taskItem=
            {
                bg = LuaMgr.GetSprite("TrafficPermit","ui_txz2_rw_di0"..state),
                des =string.format(colorString,LuaMgr.GetLangText(v.Namelan)),
                rewarding = state==2,
                rewarded = state==3,
                rewardno = state==1,
                sliderValue = dataTask.current/dataTask.target,
                sliderText = string.format("<color=#ffffff><size=24>%s</size></color>/%s",dataTask.current,dataTask.target),
                goods = goodList,
                id=v.Id,
                jumpId=v.PageSkip,
                stateNum=sortNum,
                sort=v.Sort,
                isTime=index==3 and dataTask.expiredTime~=0 and  dataTask.expiredTime~=dataPasses.tabExpired.period;
            }
            if taskItem.isTime then
               local remainTime=dataTask.expiredTime-LuaMgr.Timestamp();
                taskItem.timeText=TimeString(remainTime)
            end
            table.insert(list,taskItem);
        end
    end
    
    table.sort(list,function(a, b)
        if a.stateNum==b.stateNum then
            return a.sort<b.sort;
        end
        return a.stateNum<b.stateNum 
    end)
    this.vm.data.taskList=list;
    list=nil;
    this.vm.data.rewardAllBtnBool=isTaskRewarding;
    
    local weekExpired=0;
    local periodExpired=0;
    if dataPasses.tabExpired.weekly~=nil then
        weekExpired=dataPasses.tabExpired.weekly;
    end
    if dataPasses.tabExpired.period~=nil then
        periodExpired=dataPasses.tabExpired.period;
    end

    local curTime=LuaMgr.Timestamp();
    local weekRemainTime=weekExpired-curTime;
    if weekRemainTime<0 then
        weekRemainTime=0;
    end
    local periodRemainTime=periodExpired-curTime;
    if periodRemainTime<0 then
        periodRemainTime=0;
    end
   

    this.vm.data.taskBarList[2].time=TimeString(weekRemainTime)


    this.vm.data.taskBarList[3].time= TimeString(periodRemainTime)
    
end


this.GetCfgTaskListByType=function(typeIndex)
    local taskList={}
    local taskMap={}
    if typeIndex==1 then
        taskMap=DataMgr.Player.passesMissions.daily;
    elseif typeIndex==2 then
        taskMap=DataMgr.Player.passesMissions.weekly;
    elseif typeIndex==3 then
        taskMap=DataMgr.Player.passesMissions.period;
    end
    for i,v in pairs(taskMap) do
        if ConfigMgr.Config.PassesTaskMap[v.id]~=nil then
            table.insert(taskList,ConfigMgr.Config.PassesTaskMap[v.id])
        end
    end
    table.sort(taskList,function(a, b) return tonumber(a.Id) <tonumber(b.Id) end)
    return taskList,taskMap;
end


return vm({
    data = data,
    command = command,
    hook = hook
})