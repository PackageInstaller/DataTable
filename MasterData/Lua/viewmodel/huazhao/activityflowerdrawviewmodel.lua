




local this = {vm=nil};
local data = {
    startTime="",
    endTime="",

}

local command = {

    flowerBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if not DataExHelper.Check_FlowerRuning() then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("ActivityFlowerDrawViewModel_0"));
                return;
            end
            LuaMgr.HidePanel(UIName.ActivityFlowerDrawViewModel)
            LuaMgr.ShowLuaPanel(UIName.FlowerFestivalViewModel);
        end
    },
    drawCardBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if not DataExHelper.Check_FlowerRuning() then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("ActivityFlowerDrawViewModel_1"));
                return;
            end
            LuaMgr.HidePanel(UIName.ActivityFlowerDrawViewModel)
            FeatureManager.ShowCardPoolPanel("2005");
        end
    },
    closeBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.HidePanel(UIName.ActivityFlowerDrawViewModel);
        end
        
    },

}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
        print("before_awake");
        RedMgr.Singleton:RegisterViewModel(UIName.ActivityFlowerDrawViewModel);
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
    local dataGroup_flower=DataExHelper.GetDataExByTag(ActivityKey.huazhao)
    local startTime=os.date("*t",dataGroup_flower.startTime);
    local endTime=os.date("*t",dataGroup_flower.expireTime);
    this.vm.data.startTime=string.format("%.2d.%.2d", startTime.month,startTime.day);
    this.vm.data.endTime=string.format("%.2d.%.2d", endTime.month,endTime.day)
end


return vm({
    data = data,
    command = command,
    hook = hook
})