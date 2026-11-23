local this = {
    vm = nil,
    data = {
        activityData = nil,
    }
}

local data = {
    leftTimeStr = "",
}

local command = {
    gotoCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.MiniBattle4ViewModel);
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        RedMgr.Singleton:RegisterViewModel(UIName.MiniBattle4ActivityPopup);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.activityData = DataExHelper.GetDataExByTag(ActivityKey.DualBattle2)
        if this.activityData ~= nil then
            this.vm.data.leftTimeStr = string.format("%s-%s", os.date(LuaMgr.GetLangText("MiniBattle3ActivityPopup_0"), this.activityData.startTime), os.date(LuaMgr.GetLangText("MiniBattle3ActivityPopup_0"), this.activityData.expireTime))
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
    end,
    before_destroy = function()
        RedMgr.Singleton:RemoveViewModel(UIName.MiniBattle4ActivityPopup);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})