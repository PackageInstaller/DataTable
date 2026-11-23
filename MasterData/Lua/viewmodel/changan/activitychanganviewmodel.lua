




local this = {
    vm=nil,
    remainTime=0,
              
};

local data = {
    time="";
    
}

local command = {
    changanBtn= {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if not DataExHelper.Check_ChanganRunning() then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("ActivityChanganViewModel_0"));
                return;
            end
           LuaMgr.ShowLuaPanel(UIName.ChanganMainViewModel)
        end
    },
}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
            LuaMgr.RemoveTimer(TimerConst.ChanganTimer);
        end
    end,
    before_destroy=function()
         this.Clear();
    end
        
    
}

this.Clear=function()
    this.remainTime=nil;
end

this.ParseData=function()
    this.SetTime();
end

this.SetTime=function()
    local changanData=DataExHelper.GetDataExByTag("changan");
    if changanData==nil then
        this.vm.data.time=LuaMgr.GetLangText("ActivityChanganViewModel_1");
        return;
    end
    local startTime=os.date(LuaMgr.GetLangText("ActivityChanganViewModel_2"), changanData.startTime);
    local endTime=os.date(LuaMgr.GetLangText("ActivityChanganViewModel_3"), changanData.expireTime);
    this.vm.data.time=string.format("%s-%s",startTime,endTime);
    
end


return vm({
    data = data,
    command = command,
    hook = hook
})