




local this = {
    vm=nil,
    taskList={},
    dataQuests={},
 
              
};
local data = {
    taskList={
        {
            info="",
            isUpLine=false,
            isRewarded=false,
            isRewarding=false,
            isReward=false,
            proSlider=0.0,
            proValue="",
            goodsAlpha=1.0,
            goodsList={
                {
                }
            }
        }
    },
    contentAnchorPos=Vector2(0,0),
    isAllRewardBtnActive=false,
}

local command = {
    taskBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param+1);
            local rewardId=this.vm.data.taskList[index].id;
            DataExHelper.EX_GetAward(rewardId,function()
                this.ParseData();
            end)
        end
    },
    rewardAllBtn = {
        type=XLuaCommandType.Void,
        execute=function(vm,param)

            DataExHelper.EX_GetGroupAward(211,function()
                this.ParseData();
            end)
        end
    },
    taskJumpBtn = {
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=param+1;
            local jumpId=this.vm.data.taskList[index].jumpId;
            if jumpId~=nil and jumpId~="" then
                FeatureManager.GotoViewModel(jumpId)
            end
        end
    },
    

}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            ChanganMgr.InitData();
            this.taskList=ChanganMgr.changanTaskQuestEventList;
            this.vm.data.contentAnchorPos=Vector2(0,0)
            this.ParseData()
        end 
        
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
        end
    end,
    before_destroy=function()
         this.Clear();
    end
        
    
}

this.Clear=function()
    this.taskList=nil;
    this.dataQuests=nil;
end
this.ParseData=function()
    this.dataQuests=DataMgr.Player.quests;
    this.SetTask();
end

this.SetTask=function()
    local list={}
    local taskItem=nil;
    local rewardList={}
    local isCanReward=false;
    for i,v in ipairs(this.taskList) do
        local rewardState,pro=this.CheckTaskState(v.id)
        isCanReward=isCanReward or rewardState==1
        taskItem={
            jumpId=v.skipPage,
            id=v.id,
            isUpLine=false;
            info=rewardState~=3 and string.format("<color=#2a1919>%s</color>",LuaMgr.GetLangText(v.namelan))
                or string.format("<color=#4d413a>%s</color>",LuaMgr.GetLangText(v.namelan)),
            isRewarded=rewardState==3,
            isRewarding=rewardState==1,
            isReward=rewardState==2,
            proSlider=pro/v.progress,
            proValue=string.format("<color=#ffffff><size=28>%s</size></color>/%s",pro,v.progress),
            goodsAlpha=rewardState==3 and 0.8 or 1.0,
            sortNum=rewardState,
            goodsList={
                {
                }
            }
        }
        rewardList={}
        for p,m in ipairs(v.reward) do
            local rewardItem=ConfigHelper.CreateGoodsItem(m.id,m.count,0.55,true,true)
            table.insert(rewardList,rewardItem);
        end
        taskItem.goodsList=rewardList;
        table.insert(list,taskItem);
    end
    table.sort(list,function(a, b)
        if a.sortNum==b.sortNum then
            return a.id<b.id;
        else
            return a.sortNum<b.sortNum;
        end
    end)
    list[1].isUpLine=true;
    this.vm.data.taskList=list;
    this.vm.data.isAllRewardBtnActive=isCanReward;
    
end


this.CheckTaskState=function(taskId)
    local dataTask= this.dataQuests[taskId];
    if dataTask~=nil then
        local state=0;
        if dataTask.state==1 then
            state=2;
        elseif dataTask.state==2 then
            state=1;
        else
            state=dataTask.state;
        end
        return state,dataTask.progress
    else
        return 2,0;
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})