




local this = {vm=nil};
local cfgTaskQuestEvent={};
local dataExQuests={};
local isStop=false;

local data = {

    rewardAllBtnBool=false,
    taskList= { { BGSprite = DefaultSprite, taskPro = "0/0", Info = "",Info_1="", canRewardBool = false, doneRewardBool = false,
                  noRewardBool = false, scale=Vector3.one, pos=Vector2(0,0),alpha=1.0,rewardList ={{}}  }};

    
}

local command = {

    goToBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param+1);
            local skipPage=this.vm.data.taskList[index].skipPage;
            FeatureManager.GotoPanel(skipPage)
            DataReportMgr.AchievementTaskJumpPage(this.vm.data.taskList[index].id,"flowerfestival");
        end
    },
    rewardBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if isStop then return end;
            if not DataExHelper.EX_CheckLocalRunning(ActivityKey.huazhao) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("10211"));
                return
            end
            local index=tonumber(param+1);
            local rewardId=this.vm.data.taskList[index].id;
            DataExHelper.EX_GetAwardData(rewardId,function(data)
                isStop=true;
                local taskItem=this.vm.data.taskList[index]
                DOTWeen.To(function() return 1  end,function(value)
                    taskItem.scale=Vector3.one*value
                    taskItem.alpha=value;
                end,0,0.2).onComplete=function()
                    for i,v in ipairs(this.vm.data.taskList) do
                        if i>index then
                            DOTWeen.To(function() return Vector2(0,0) end,function(value)
                                v.pos=value;
                            end,Vector2(0,120),0.2);
                        end
                    end
                end
                coroutine_runner.start(function()
                    coroutine_runner.wait(0.5);
                    LuaMgr.ShowItemRewared(data);
                    this.ParseData();
                end)
            end)
        end
    },
    rewardAllBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if isStop then return end;
            if not DataExHelper.EX_CheckLocalRunning(ActivityKey.huazhao) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("10211"));
                return
            end
            DataExHelper.EX_GetGroupAward(191,function()
                this.ParseData();
            end)
        end
    }
    
}
local hook = {
    before_awake = function(vm)
        this.vm=vm;

        print("before_awake");
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            cfgTaskQuestEvent=DataExHelper.Check_ConfigQuestEventByText("task");
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
    end,
}


this.ParseData=function()
    isStop=false;
     dataExQuests=DataMgr.Player.quests;
     this.ShowTask();
end

this.ShowTask=function()
    this.vm.data.taskList={};
    local list={};
    local isReward=false;
    local cfgShop=this.formatTable();
    for i,v in ipairs(cfgShop) do
        local task=v;
        local progrssing,state=this.CheckTaskState(v.id);
        isReward=isReward or state==1;
        local subList={};
        local showReward=task.showReward;
        for i,v in ipairs(showReward) do
            local item =ConfigMgr.Config.itemMap[tostring(v.id)];
            local rewardItem={id=tostring(v.id),count=tostring(v.count),isCount=true,
                              rare=ActivityMgr.GetRareSprite(item.rare),
                              icon=ActivityMgr.GetItemTexture(tostring(v.id)),
                              scale=Vector3(0.5,0.5,0.5),
                              sizeDelta=Vector2(64,64),
                              isClick=true
            }
            table.insert(subList,rewardItem);
        end
        local taskItem={
            BGSprite=state==2 and LuaMgr.GetSprite("Flower","ui_hd_hzj_rw_an_lan") or LuaMgr.GetSprite("Flower","ui_hd_hzj_rw_an_bai"),
            taskPro="<color=#efebdf>"..progrssing.."</color>".."<color=#695242>/"..task.progress.."</color>";
            Info=LuaMgr.GetLangText(task.namelan),
            id=task.id;
            sortNum=state;
            skipPage=task.skipPage;
            canRewardBool=state==1,
            doneRewardBool=state==3,
            noRewardBool=state==2,
            pos=Vector2(0,0),
            scale=Vector3.one,
            alpha=1.0,
            rewardList=subList,
        }
        table.insert(list,taskItem);
    end
    this.SortList(list);
    this.vm.data.rewardAllBtnBool=isReward;
    this.vm.data.taskList=list;
end

this.GetPoemText=function(namelan,num)
    local info=LuaMgr.GetLangText(namelan)
    local len=LuaMgr.GetStringLength(info);
    if len>num then
        return LuaMgr.SubstringLen(info,0,num),LuaMgr.SubstringLen(info,num,len-num);
    else
        return info,"";
    end
end

this.SortList=function(list)
    table.sort(list,function(a,b)
      return this.SortRules(a,b);
    end);
end

this.SortRules=function(a,b)
    if tonumber(a.sortNum)==tonumber(b.sortNum) then
        return tonumber(a.id)<tonumber(b.id);
    else
        return tonumber(a.sortNum)<tonumber(b.sortNum);
    end
end




this.formatTable=function()
    local formatTable={};
    for i,v in ipairs(cfgTaskQuestEvent) do
        table.insert(formatTable,v);
    end
    return formatTable;
end


this.CheckTaskState=function(taskId)
    local dataTask= dataExQuests[taskId];
    if dataTask==nil then return nil,nil end;
    local state=0;
    if dataTask.state==1 then
        state=2;
    elseif dataTask.state==2 then
        state=1;
    else
        state=dataTask.state;
    end
    return dataTask.progress,state;
end


return vm({
    data = data,
    command = command,
    hook = hook
})