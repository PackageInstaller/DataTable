





local this = {vm=nil};
local confirmHandler=nil;

local data = {
    titleText="";
    contentText="";
    
}

local command = {
    confirmBtn={
      type=XLuaCommandType.Void,
      execute=function(vm,param)
          if confirmHandler~=nil then
              confirmHandler();
          end
          LuaMgr.HidePanel(UIName.NoticeTipViewModel);
      end
    },
   
  
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
       
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        if  vm.behaviour.Params.Length>0 then
            local data=vm.behaviour.Params;
            this.vm.data.titleText=data[0];
            this.vm.data.contentText=data[1];
            confirmHandler=data[2];
        end

    end,
    before_deactive = function(vm)
    
    end,
}

return vm({
    data = data,
    command = command,
    hook = hook
})