




local this = {vm=nil};

local cfgTask={};
local dataQuests={};
local remainTime=nil;
local tweener=nil;
local isIntervaling=false;
local data = {
    taskList={
        {
            pos=Vector2(0,0);
            id="",
            bgSprite=DefaultSprite,
            des="",
            costInfo="",
            proValue="",
            proSlider=0.0,
            rewardingBool=false,
            jumpBool=false,
            rewardedBool=false;
            lineBool=false,
            alpha=1.0,
            skipPage="",
            goods={
                {
                    
                }
            }
        }
    },
    time="";
    contentAnchorPos=Vector2(0,0);
}

local command = {

    rewardBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if not DataExHelper.Check_TravelRunning() then
                LuaMgr.ShowLuaPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("TravelTaskViewModel_12"));
                return;
            end
            if isIntervaling then return end;
            isIntervaling=true;
            local index=tonumber(param)+1;
            local questId=this.vm.data.taskList[index].id;

            local askData={questId=questId}
            ApiMgr.Request("ex/get_award", askData, true, function(result)
                local re=json.decode(result);
                local data=json.encode(re.result);
                this.DoMove(index,function()
                    this.ParseData();
                    LuaMgr.ShowItemRewared(data,function()
                        isIntervaling=false;
                    end);
                end);

            end,nil,true);
        end
        
    },
    jumpBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if not DataExHelper.Check_TravelRunning() then
                LuaMgr.ShowLuaPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("TravelTaskViewModel_13"));
                return;
            end
            local index=tonumber(param)+1;
            local skipPage=this.vm.data.taskList[index].skipPage;
            FeatureManager.GotoViewModel(skipPage);
        end
    }

}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
       
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            cfgTask=DataExHelper.Check_ConfigQuestEventByText("Traveltask");
            table.sort(cfgTask,function(a, b) return a.id<b.id end);
            isIntervaling=false;
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if tweener~=nil then
            tweener:Kill();
        end
    end,
}


this.DoMove=function(index,callBack)
    local curTask=this.vm.data.taskList[index];
    if tweener~=nil then
        tweener:Kill();
    end
    tweener=DOTWeen.To(function() return Vector2(0,0)  end,function(vector)
        curTask.pos=vector;
    end,Vector2(900,0),0.2);
    tweener.onComplete=function()
        DOTWeen.To(function() return Vector2(0,0)  end,function(vector)
            for i,v in ipairs(this.vm.data.taskList) do
                if i>index then
                    v.pos=vector;
                end
            end
        end,Vector2(0,100),0.15):SetEase(Ease.Linear).onComplete=callBack;
    end;
end





this.ParseData=function()
    this.vm.data.contentAnchorPos=Vector2(0,0)
    this.vm.data.taskList={};
    local list={};
    dataQuests=DataMgr.Player.quests;
    for i,v in ipairs(cfgTask) do
        if dataQuests[v.id]~=nil  then
            local dataQuest=dataQuests[v.id];
            local taskItem={
                pos=Vector2(0,0);
                id=v.id,
                bgSprite=LuaMgr.GetSprite("Travel","ui_lx_lcqd_tiao_0"..dataQuest.state);
                des=LuaMgr.GetLangText(v.namelan),
                costInfo=LuaMgr.GetLangText(v.remarksLan),
                proValue=dataQuest.progress.."/"..v.progress,
                proSlider=dataQuest.progress/v.progress,
                rewardingBool=dataQuest.state==2,
                jumpBool=dataQuest.state==1,
                rewardedBool=dataQuest.state==3;
                lineBool=i~=1,
                alpha=dataQuest.state==3 and 0.5 or 1.0,
                skipPage=v.skipPage,
                sortNum=dataQuest.state==2 and 0 or dataQuest.state;
                goods={
                }
            }
            for p,m in ipairs(v.showReward) do
                local goodItem=ConfigHelper.CreateGoodsItem(m.id,m.count,0.55,true,true)
                table.insert(taskItem.goods,goodItem);
            end
            table.insert(list,taskItem);
        end
        
    end
    table.sort(list,function(a, b)
        if a.sortNum==b.sortNum then
            return a.id<b.id;
        else
            return a.sortNum<b.sortNum;
        end
    end)
    this.vm.data.taskList=list;
    this.ShowTime();
    
end

this.ShowTime=function()
    local actMap=ConfigMgr.Config.activityMapList
    for i,v in ipairs(actMap) do
        if v.area=="Travel" then
            actTravel=v;
        end
    end
    local curTime=LuaMgr.Timestamp();
    local endTime=actTravel.closeDate;
    remainTime=endTime-curTime;
    LuaMgr.RemoveTimer(TimerConst.TravalTimer);
    LuaMgr.AddTimer(TimerConst.TravalTimer,this.Timer,1,-1,true);
end

this.Timer=function()
    if remainTime<=0 then
        LuaMgr.RemoveTimer(TimerConst.TravalTimer);
        this.vm.data.time=LuaMgr.GetLangText("TravelTaskViewModel_14");
    end
    local day=math.floor(remainTime/(24*60*60));
    local daySec=remainTime%(24*60*60);
    local hour=math.floor(daySec/(60*60));
    local min=math.floor(daySec%(60*60)/60);
   
    this.vm.data.time=string.format(LuaMgr.GetLangText("TravelTaskViewModel_15"),day,hour,min);
    remainTime=remainTime-1;
end



return vm({
    data = data,
    command = command,
    hook = hook
})