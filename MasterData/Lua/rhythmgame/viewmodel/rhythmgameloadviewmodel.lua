






local this = {
   
};
local data={}
local command={}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            
        end
    end,
    before_deactive = function(vm)
      
    end,
    before_destroy=function()
       
    end
}



return vm({
    data = data,
    command = command,
    hook = hook
})