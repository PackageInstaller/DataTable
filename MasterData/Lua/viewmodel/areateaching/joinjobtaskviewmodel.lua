





local this = {vm = nil}
local curBar=nil;
local _cfgTaskOpens=nil;
local _cfgMissionMap=nil;
local curTabId=nil;
local tweener=nil;
local data = {
   barList={
       {
           day="",
           suo=false,
           redPoint="",
           tabId="",
           isNor=false,
           isCur=false,
           isDay=false,
       }
   },
   livenessList={
       {
           missionID="",
           num="",
           done=false,
           getreward=false,
           slider=0.0,
       }
   },
   taskList={
       {
           tab="",
           missionID="",
           bg=DefaultSprite,
           des="",
           proBg=DefaultSprite,
           pro=0.0,
           proValue="",
           noCompleted=false,
           interactable=false,
           mask=false,
           completeValue="",
           completeState=0,
           complete_no=false;
           complete_ing=false;
           complete_ed=false;
           alpha=1.0,
           goodslist={{}},
           
       }
   },
   curliveness="";
   totalLiveness="",
   remainTime="";
   bodyPath="";
   allRewardBtnBool=false;
   contentAnchor=Vector2(0,0);

   livenessSizeData=Vector2(355,244);
   livenessContentAnchor=Vector2(0,0);
   isTaskPanel=false;
   taskMaskBool=false,
   taskPanelPos=Vector2(0,0),
   bgPos=Vector2(100,0),
   szBool=false;
   szTar="",
   szMax="",
   szProValue=0.0,
   szPro=""
}

local command = {
    barBtn={
      type=XLuaCommandType.Void,
      execute=function(vm,param)
          local index=tonumber(param)+1;
          if index==curBar and this.vm.data.isTaskPanel then return end;
          if this.vm.data.barList[index].suo then
              local tip=LuaMgr.GetLangText("ActivityTaskEightViewModel_1")
              LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(tip,index));
              return;
          end
          for i,v in ipairs(this.vm.data.barList) do
              v.isNor=i~=index
              v.isCur=i==index;
          end
          curBar=index;
          curTabId=this.vm.data.barList[index].tabId;
          this.InitTask()
          RedMgr.Singleton:Refresh();
      end
    },
    jumpBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index=tonumber(param)+1;
            local taskItem=this.vm.data.taskList[index]
            if taskItem==nil then return end;
            if taskItem.noCompleted then
                local panelId=_cfgMissionMap[taskItem.missionID].pageSkip;
                if panelId~=nil then
                    FeatureManager.GotoViewModel(panelId);
                end
            else
                local askData={missionId=taskItem.missionID,tab=taskItem.tab}
                ApiMgr.Request("complete_mission",askData,true,function(result)
                    this.OnAskComplete_missionRep(result);
                end,nil,true);
            end
        end
    
    },
    livenessRewordBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index=tonumber(param)+1;
            local livenessItem=this.vm.data.livenessList[index]; 
            if livenessItem==nil then return end;
            local askData={missionId=livenessItem.missionID,tab="8dayPhase"}
            ApiMgr.Request("complete_mission",askData,true,function(result)
               if result==nil then return end;
                local re=json.decode(result);
                local data=json.encode(re.result);
                LuaMgr.ShowItemRewared(data);
                this.InitLiveness();
            end,nil,true);
        end

    },
    allDayRewardsBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local askData={missionId="all",tab="8day"..curBar}
            ApiMgr.Request("complete_mission",askData,true,function(result)
                this.OnAskComplete_missionRep(result);
            end,nil,true);
            
        end
    },
    teachingBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            FeatureManager.GotoViewModel("3080")
        end
    },
    ClimbBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.AreaTeachingViewModel,true)
        end
    },
    
    checkInBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.ActivitySignInViewModel)
        end
    },
    novelBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)

            LuaMgr.ShowLuaPanel(UIName.JoinJobLoadingViewModel)
            coroutine_runner.start(function()
                coroutine_runner.wait(1)
                LuaMgr.ShowLuaPanel(UIName.JoinJobNovelViewModel)
            end)
        end
    },
    taskEightBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
           if this.vm.data.isTaskPanel then return end;
            this.vm.data.barList[curBar].isCur=true
            this.vm.data.barList[curBar].isNor=false
            this.vm.data.isTaskPanel=false
           this.InitTask();
        end
    },
    closeBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if not this.vm.data.isTaskPanel then return end;
            this.vm.data.taskMaskBool=false
            this.bgDoMoveAnimation(1);
            this.vm.data.isTaskPanel=false
            this.vm.data.barList[curBar].isCur=false
            this.vm.data.barList[curBar].isNor=true
        end
    },
   
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        RedMgr.Singleton:RegisterViewModel(UIName.JoinJobTaskViewModel);
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then return end
        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.ParseData();
        HeroRedDataHelper.SetJoinJobRed();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.Task8RemainTime);
    end,
}

this.OnAskComplete_missionRep=function(result)
    local re=json.decode(result);
    local data=json.encode(re.result);
    LuaMgr.ShowItemRewared(data);

    local redNum=this.BarRedState(this.vm.data.barList[curBar].tabId,true)
    RedMgr.Singleton:UpdateClientRedData(this.vm.data.barList[curBar].redPoint,redNum);
    RedMgr.Singleton:Refresh();

    this.InitTask();
    this.InitLiveness();
end

this.OnBack=function()
    if DataExHelper.Check_JobInRunning() then
        LuaMgr.Back(ActivityKey.entry);
    else
        LuaMgr.Back();
    end
end

this.ParseData=function()
    this.vm.data.isTaskPanel=false
    this.vm.data.taskMaskBool=false
    this.vm.data.bgPos=Vector2(100,0)
    local width=LuaMgr.GetScreenWidth()-923
    this.vm.data.livenessSizeData=Vector2(width,244)
    _cfgTaskOpens=ConfigMgr.Config.taskOpen;
    _cfgMissionMap=ConfigMgr.Config.missionMap;
    if _cfgMissionMap==nil or _cfgMissionMap==nil then return end;
    this.ShowRemainTime();
    local NO=this.GetCurrentDay();
    curBar=NO;
    this.InitBar(NO);
    this.InitLiveness();
    this.SetActualInfo()
end

this.SetActualInfo=function()
    local cfgUnlockCondition=ConfigMgr.Config.constants.UnlockTeach;
    local isLock=cfgUnlockCondition[3]~="0" and DataMgr.Player.dungeonRecords[cfgUnlockCondition[3]]==nil 
            or DataMgr.Player.dungeonRecords[cfgUnlockCondition[3]].completeCount==0
    this.vm.data.szBool=not isLock;
    if isLock then
        return
    end
    local szDungeouList={}
    for i,v in ipairs(ConfigMgr.Config.activityMapEventList) do
        if v.area=="entry" and v.type==2 then
            table.insert(szDungeouList,ConfigMgr.Config.dungeonMap[v.eventParam])
        end
    end
    table.sort(szDungeouList,function(a, b) return a.id<b.id end)
    local szIndex=nil
    local dungeonRecords=DataMgr.Player.dungeonRecords
    for i,v in ipairs(szDungeouList) do
        if dungeonRecords[v.id]==nil or dungeonRecords[v.id].completeCount==0 then
            szIndex=i;
            break;
        end
    end

    local getCount=0;
    local maxCount=0;
    local records=DataMgr.Player.dungeonRecords
    for _i,_v in ipairs(szDungeouList) do
        local isGet=records[_v.id]~=nil and records[_v.id].completeCount>0
        for i,v in ipairs(_v.firstDrop) do
            if ConfigMgr.Config.dropMap[v.id]==nil then
                print("")
            end
            local items=ConfigMgr.Config.dropMap[v.id].items;
            for p,m in ipairs(items) do
                if m.id=="1" then
                    maxCount=maxCount+m.count;
                    if isGet then
                        getCount=getCount+m.count;
                    end
                end
            end
        end
    end
    
    szIndex=szIndex==nil and #szDungeouList or szIndex-1
    this.vm.data.szTar=tostring(szIndex);
    this.vm.data.szMax=tostring(#szDungeouList);
    this.vm.data.szProValue=szIndex/#szDungeouList
    this.vm.data.szPro=string.format("<color=#EA4E25><size=26>%s</size></color>/%s",getCount,maxCount)
end


this.GetCurrentDay=function()
    local dayNum=0;
    local missions=DataMgr.Player.activityMissions["8day"];
    for i,v in ipairs(missions) do
        if v.tabId=="8dayPhase" then
            table.remove(missions,i);
        end
    end
    table.sort(missions,function(a, b) return a.tabId<b.tabId end);
    for i,v in ipairs(missions) do
        if v.unlock then
            dayNum=dayNum+1;
        end
    end
    return dayNum;
    
end

this.ShowRemainTime=function()
    if _cfgTaskOpens["8dayPhase"]==nil then return end;
    local openDays=tonumber(_cfgTaskOpens["8dayPhase"].CloseParam);
    local registerDate=os.date("*t",DataMgr.Player.registTime);
    local startStamp=os.time({year=registerDate.year,month=registerDate.month,day=registerDate.day,hour=4});
    local endStamp=startStamp+openDays*24*60*60;
    local distanceStamp=endStamp-LuaMgr.Timestamp();
    if distanceStamp<=0 then
        this.vm.data.remainTime=LuaMgr.GetLangText("ActivityTaskEightViewModel_3");
        return;
    end
    LuaMgr.RemoveTimer(TimerConst.Task8RemainTime);
    LuaMgr.AddTimer(TimerConst.Task8RemainTime,function()
        local daySecond=24*60*60;
        local day=math.floor(distanceStamp/daySecond);
        local hour=math.floor(distanceStamp%daySecond/3600);
        local min= math.floor(distanceStamp%daySecond%3600/60); 
        this.vm.data.remainTime=string.format(LuaMgr.GetLangText("TaskEightViewModel_4"),day,hour,min);
        if distanceStamp>0 then
            distanceStamp=distanceStamp-1;
        else
            LuaMgr.RemoveTimer(TimerConst.Task8RemainTime);
        end
       
    end,1,-1,true);
    
end

this.IsUnlockBar=function(tabId)
    local activityMissions_8day=DataMgr.Player.activityMissions["8day"];
    for i,v in ipairs(activityMissions_8day) do
        if v.tabId==tabId then
            return v.unlock;
        end
    end
    return false;
end

this.BarRedState=function(tabId,unlock)
    local red=0;
    if not unlock then return red end;
    local missionMap=DataMgr.Player.missions[tabId]["501"];
    for i,v in pairs(missionMap) do
        if not v.completed and v.current>=v.target then
            red=1;
            break;
        end
    end
    return red;
end

this.InitBar=function(NO)
    local list={};
    for i,v in pairs(_cfgTaskOpens) do
        if v.type=="501" then
            local unlock=this.IsUnlockBar(v.tabID);
            local barIsOn=tonumber(v.openParam)==NO;
            if barIsOn then
                curTabId=v.tabID;
            end
            local barItem={
                    day=v.openParam,
                    isCur=false,
                    isNor=true,
                    isDay=barIsOn;
                    suo=not unlock,
                    redPoint="1065_"..v.tabID,
                    tabId=v.tabID,
            }
            table.insert(list,barItem);
            local redNum=this.BarRedState(v.tabID,unlock)
            RedMgr.Singleton:UpdateClientRedData("1065_"..v.tabID,redNum);
        end
    end
    table.sort(list,function(a, b) return a.tabId<b.tabId end);
    this.vm.data.barList=list;
end

this.GetTaskItemSpriteIndx=function(missionItem)
    local index=0;
    if missionItem.completed then
        index=2;
    elseif missionItem.current>=missionItem.target then
        index=1;
    end
    return tostring(index);
end

this.GetCompleteValue=function(missionRow)
    for i,v in pairs(missionRow.rewards) do
        if v.itemId=="50101" then
            return tostring(v.count);
        end
    end
end

this.bgDoMoveAnimation=function(dir)
    local tarPos=dir>0 and Vector2(100,0) or Vector2(-105,0);
    DOTWeen.To(function()return this.vm.data.bgPos  end,function(vector)
        this.vm.data.bgPos=vector
    end,tarPos,0.6):SetEase(Ease.OutCirc)
end

this.InitTask=function()
    if not this.vm.data.isTaskPanel then
        this.bgDoMoveAnimation(-1);
    end
    AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/SpecialtyStore_switch.mp3");
    this.vm.data.isTaskPanel=true
    this.vm.data.taskMaskBool=true
    this.vm.data.contentAnchor=Vector2(0,0);
    local taskMissionMap=DataMgr.Player.missions[curTabId]["501"];
    local isReward=false;
    local list={};
    for i,v in pairs(taskMissionMap) do
        local proValueText=string.format("<color=#ffffff><size=30>%s</size></color>/%s",LuaMgr.NumFormat(v.current),LuaMgr.NumFormat(v.target))
        local spriteIndex=this.GetTaskItemSpriteIndx(v);
        isReward=isReward or spriteIndex=="1";

        local competeTag=nil;
        if v.completed then
            competeTag=2;
        elseif v.current<v.target then
            competeTag=1;
        else
            competeTag=0;
        end
        local rewards=_cfgMissionMap[v.id].rewards;
        local taskItem={
            tab=curTabId,
            missionID=v.id,
            bg=LuaMgr.GetSprite("JoinJob","ui_rz_brrw_panel"..spriteIndex),
            des=spriteIndex=="1" and string.format("<color=#ffffff>%s</color>",LuaMgr.GetLangText(_cfgMissionMap[v.id].NameLan))
                    or LuaMgr.GetLangText(_cfgMissionMap[v.id].NameLan),
            proBg=LuaMgr.GetSprite("JoinJob","ui_rz_brrw_panel"..spriteIndex.."_button"),
            pro=v.current/v.target,
            proValue=proValueText,
            noCompleted=v.current<v.target,
            interactable=not v.completed,
            mask=v.completed,

            complete_no=competeTag==0;
            complete_ing=competeTag==1;
            complete_ed=competeTag==2;
            completeState=competeTag,
            alpha=v.completed and 0.6 or 1.0,
            goodslist=this.ShowRewardList(rewards),
        }
        table.insert(list,taskItem);
    end
    table.sort(list,function(a, b)
        if a.completeState==b.completeState then
            return a.missionID<b.missionID;
        else
            return a.completeState<b.completeState
        end
    end)
    this.vm.data.taskList=list;
    this.vm.data.allRewardBtnBool=isReward;
    


end

this.ShowRewardList=function(rewards)
    local rewardsList={}
    for p,m in ipairs(rewards) do
        if m.itemId~="50101" then
            local rewardItem=ConfigHelper.CreateGoodsItem(m.itemId,m.count,0.55,true,true)
            table.insert(rewardsList,rewardItem);
        end
    end
    return rewardsList;
end


this.InitLiveness=function()
    local list={}
    local missionlivenessMap =DataMgr.Player.missions["8dayPhase"]["502"]
    local missionlivenesslist={}
    for i,v in pairs(missionlivenessMap) do
        table.insert(missionlivenesslist,v);
    end
    table.sort(missionlivenesslist,function(a, b) return a.id<b.id end);

    local preTarget=0;
    local proIndex=nil;
    local completeProIndex=0;
    for i,v in ipairs(missionlivenesslist) do
        local current= v.current-preTarget;
        local target=v.target-preTarget;
        current=current>0 and current or 0;
        target=target>0 and target or 0;
        local sliderValue=current/target;
        sliderValue=sliderValue>1 and 1 or sliderValue;
        preTarget=v.target;

        local rewardItem=nil;
        local reward=_cfgMissionMap[v.id].rewards[1];
        if reward.itemId~="50101" then
            rewardItem=ConfigHelper.CreateGoodsItem(reward.itemId,reward.count,0.66,true,true)
            rewardItem.missionID=v.id
            rewardItem.num=tostring(v.target)
            rewardItem.done=v.completed
            rewardItem.getreward=not v.completed and v.current==v.target
            rewardItem.slider=sliderValue
        end
        if proIndex==nil and rewardItem.getreward then
            proIndex=i-1;
        end
        if v.completed then
            completeProIndex=completeProIndex+1;
        end
        table.insert(list,rewardItem);
    end
    if proIndex==nil then
        proIndex=completeProIndex;
    end
    this.vm.data.livenessList=list;
    this.vm.data.curliveness= missionlivenesslist[#missionlivenesslist].current;
    this.vm.data.totalLiveness="/"..missionlivenesslist[#missionlivenesslist].target;

    local tar=Vector2(-proIndex*172,0)
    this.vm.data.livenessContentAnchor=Vector2(-proIndex*172,0);
    if tweener~=nil then
        tweener:Kill()
    end
    tweener=DOTWeen.To(function() return Vector2(0,0) end,function(vector)
        this.vm.data.livenessContentAnchor=vector
    end,tar,0.5)
    
end
    

    

    


return vm({
    data = data,
    command = command,
    hook = hook
})