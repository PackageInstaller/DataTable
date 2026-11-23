local data = {};

local this = {};


this.OnBack = function()
    FoundationMgr.StopVoice();
    FoundationMgr.Enter(FoundationMgr.Outside);
end

local command = {
    
}

local hook = {
    before_awake = function(vm)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        vm.behaviour:UpdateTopBar(FoundationMgr.ExpoHall, this.OnBack);
    end,
    before_deactive = function(vm)
        
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})