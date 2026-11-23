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
            LuaMgr.ShowLuaPanel(UIName.TeamRelay2ViewModel);
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        RedMgr.Singleton:RegisterViewModel(UIName.TeamRelay2ActivityPopup);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.activityData = DataExHelper.GetDataExByTag(ActivityKey.TeamRelay2)
        if this.activityData ~= nil then
            this.vm.data.leftTimeStr = string.format(LuaMgr.GetLangText("TeamRelay2ActivityPopup_0"), 
                    os.date(LuaMgr.GetLangText("TeamRelay2ActivityPopup_1"), this.activityData.startTime), os.date(LuaMgr.GetLangText("TeamRelay2ActivityPopup_1"), this.activityData.expireTime))
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
    end,
    before_destroy = function()
        RedMgr.Singleton:RemoveViewModel(UIName.TeamRelay2ActivityPopup);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})