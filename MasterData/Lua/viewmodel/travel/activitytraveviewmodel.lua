




local this = {vm=nil};
local remainTime=nil;
local actTravel=nil;

local data = {
    time="";

}

local command = {
    
    enterBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if not DataExHelper.Check_TravelRunning() then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("TravelMainViewModel_1"));
                return;
            end
            LuaMgr.HidePanel(UIName.ActivityTraveViewModel)
            LuaMgr.ShowLuaPanel(UIName.TravelMainViewModel);
        end
    }

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
       
    end,
}

this.ParseData=function()
    local groupId = ActivityMgr.groupKeyList["travel"]
    local time=DataMgr.Player.variables[groupId]
    local startTime=os.date("*t", time.startTime);
    local endTime=os.date("*t", time.expireTime);
    this.vm.data.time=string.format(LuaMgr.GetLangText("ActivityTraveViewModel_0"),startTime.month,startTime.day,endTime.month,endTime.day);
    
     
end


return vm({
    data = data,
    command = command,
    hook = hook
})