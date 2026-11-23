





local this = {vm=nil};
local confrimAction=nil;
local cancelAction=nil;


local data = {
    icon=DefaultTexture,
    infoText="";
}

local command = {
    confrimBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if confrimAction~=nil then
                confrimAction();
            end
        end
    },
  
    cancelBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if cancelAction~=nil then
                cancelAction();
            end
            LuaMgr.HidePanel(UIName.TrafficPermitBuyTipSecondViewModel)
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
        if  vm.behaviour.Params.Length>2 then
            local data=vm.behaviour.Params;
            this.vm.data.infoText=data[0];
            confrimAction=data[1];
            cancelAction=data[2];
        end
       
        
    end,
    before_deactive = function(vm)
        print("before_deactive");
        
    end,
}

return vm({
    data = data,
    command = command,
    hook = hook
})