





local this = { vm = nil,
               coroutineKey = nil;
}

local data = {

    rewardPanelBool=false,
    donePanelBool=false,
    score="";
    
}

local command = {
   
    scoreBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.AreaSqualTaskViewModel,DataMgr.Player.moreModData.Theme);
        end
    },
    doneCloseBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.HidePanel(UIName.AreaSquadBoxViewModel);
            LuaMgr.ShowLuaPanel(UIName.AreaDailyViewModel);
        end
    },
    rewardCloseBtn= {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.AreaSquadBoxViewModel);
        end
    }
    
    
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params== nil) then return  end
        local data=vm.behaviour.Params;
        local score=data[0];
        this.ParseData(score);
    end,
    before_deactive = function(vm)
        this.coroutineKey=nil;
    end,
    before_destroy=function(vm)
        this=nil
    end
}


this.ParseData=function(score)
    this.vm.data.rewardPanelBool=score==nil;
    this.vm.data.donePanelBool=score~=nil;
    this.vm.data.score=score
    this.coroutineKey=coroutine_runner.start(function()
        coroutine_runner.wait(2)
        LuaMgr.HidePanel(UIName.AreaSquadBoxViewModel);
        LuaMgr.ShowLuaPanel(UIName.AreaDailyViewModel);
    end)
end




return vm({
    data = data,
    command = command,
    hook = hook
})