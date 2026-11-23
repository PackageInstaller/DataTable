




local this = {vm=nil};
local groupFlower="group.201";
local data = {
   openTime="",

}

local command = {

    GotoBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if not this.CheckFlowerOpen() then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("ActivityFlowerViewModel_0"));
                return;
            end
            LuaMgr.HidePanel(UIName.ActivityFlowerViewModel)
            LuaMgr.ShowLuaPanel(UIName.FlowerFestivalViewModel);
        end
    }

}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
        print("before_awake");
        RedMgr.Singleton:RegisterViewModel(UIName.ActivityFlowerViewModel);
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
    end,
}


this.ParseData=function()
    local groupId = ActivityMgr.groupKeyList["huazhao"]
    local dataGroup_flower=DataMgr.Player.variables[groupId];
    local startTime=os.date("*t",dataGroup_flower.startTime);
    local endTime=os.date("*t",dataGroup_flower.expireTime);
    local startTimeString=string.format(LuaMgr.GetLangText("ActivityFlowerViewModel_1"), startTime.month,startTime.day,startTime.hour,startTime.min);
    local endTimeString=string.format(LuaMgr.GetLangText("ActivityFlowerViewModel_2"), endTime.month,endTime.day,endTime.hour,endTime.min)
    this.vm.data.openTime=string.format("%s-%s",startTimeString,endTimeString);
end

this.CheckFlowerOpen=function()
    local groupId = ActivityMgr.groupKeyList["huazhao"]
    local dataGroup_flower=DataMgr.Player.variables[groupId];
    local curStampTime=LuaMgr.Timestamp();
    return curStampTime<dataGroup_flower.expireTime
end



return vm({
    data = data,
    command = command,
    hook = hook
})