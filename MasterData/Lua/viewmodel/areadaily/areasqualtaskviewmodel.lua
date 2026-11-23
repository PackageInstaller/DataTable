





local this = { vm = nil,
               cfgTask = {},
               dataMission = {},
               missionIdList={},
}


local theme=nil;
local data = {
  
    taskList={
        {
            id="",
            des="",
            bg=DefaultSprite,
            taging=false,
            taged=false,
            tagno=false,
            proValue=0.0,
            proText="",
            aplha=1.0,
            goods={{}},
        }
    },
    isRewardingBool=false;
    contentAchor=Vector2(0,0);
    bgTexture=DefaultTexture;
}

local command = {

    closeBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
          LuaMgr.HidePanel(UIName.AreaSqualTaskViewModel);
        end
    },
    rewardBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param+1);
            local id=this.vm.data.taskList[index].id;
            this.CompletemMission(id);
        end
    },
    rewardAllBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.CompletemMission("all");
        end
    },
    
    
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params== nil) then return  end

        theme=vm.behaviour.Params[0];
        this.cfgTask={};
        for i,v in pairs(ConfigMgr.Config.missionMap) do
            if v.tab=="weekly" and v.type=="106" then
                table.insert(this.cfgTask,v);
            end
        end
        this.ParseData();
    end,
    before_deactive = function(vm)
     
    end,
    before_destroy=function(vm)
        this=nil
    end
}




this.CompletemMission=function(missionId)
    if missionId~="all" then
        this.missionIdList={missionId}
    end
    local data={missionIds=this.missionIdList,tab="weekly"};
    ApiMgr.Request("complete_mission", data, true, function(data)
        local result=json.decode(data);
        local dataString=json.encode(result.result);
        LuaMgr.ShowItemRewared(dataString);
        HeroRedDataHelper.FrushMoreModRed();
        this.ParseData();
    end,nil,true);
end


this.ParseData=function()
    this.dataMission=DataMgr.Player.missions["weekly"]["106"];
    this.vm.data.bgTexture=LuaMgr.GetTexture(Path.Image..string.format("Squal/ui_dzr_jl_bj_%s.png",theme));
    this.ShowTask();
end


this.GetTaskState=function(id)
    local state=2;
    local proValue=0.0;
    local proText="";
    local task=this.dataMission[id]
    if task~=nil then
        if task.completed then
            state=3;
            proValue=1.0;
            proText="";
        elseif task.current>=MissionHelper.GetTargetCount(task.id) then
            state=1;
            proValue=1.0;
            proText="";
        else
            state=2;
            proValue=task.current/MissionHelper.GetTargetCount(task.id);
            proText=string.format("<color=#ffffff><size=28>%s/</size></color>%s",task.current,MissionHelper.GetTargetCount(task.id));
        end
    end
    return state,proValue,proText;
end


this.ShowTask=function()
    this.vm.data.contentAchor=Vector2(0,0);
    this.missionIdList={};
    local list={};
    local state=1;
    local pro_Vlaue;
    local pro_Text;
    local desString="";
    for i,v in ipairs(this.cfgTask) do
        state,pro_Vlaue,pro_Text=this.GetTaskState(v.id);
        if state==1 then
            table.insert(this.missionIdList,v.id);
            desString=string.format("<color=#ffffff>%s</color>",LuaMgr.GetLangText(v.NameLan));
        elseif state==2 then
            desString=string.format("<color=#ffffff>%s</color>",LuaMgr.GetLangText(v.NameLan));
        elseif state==3 then
            desString=string.format("<color=#262429>%s</color>",LuaMgr.GetLangText(v.NameLan));
        end
        local goodList={};
        for p,m in ipairs(v.rewards) do
            local item=ConfigHelper.CreateGoodsItem(m.itemId,m.count,0.52,true,true);
            table.insert(goodList,item);
        end
        local taskItem={
            id=v.id,
            des=desString,
            bg=LuaMgr.GetSprite("Moresquad","ui_dhz_rw0"..state),
            taging=state==1,
            taged=state==3,
            tagno=state==2,
            proValue=pro_Vlaue,
            proText=pro_Text,
            aplha=state==3 and 0.5 or 1.0,
            goods=goodList,
            state=state;
        }
        table.insert(list,taskItem);
    end
    table.sort(list,function(a, b)
        if a.state==b.state then
            return a.id<b.id;
        else
            return a.state<b.state;
        end
    end)
    
    this.vm.data.isRewardingBool=#this.missionIdList>0;
    this.vm.data.taskList=list;
end





return vm({
    data = data,
    command = command,
    hook = hook
})