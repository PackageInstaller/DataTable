local this = {
    vm = nil,
    expireTime = nil,
};

local data = {
    leftTimeStr = "",
    achievementStr = "",
}

local command = {
    startBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.SeasonSLGMapViewModel);
        end
    },
    reviewBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)

        end
    },
    medalBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)

        end
    },
    signInBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)

        end
    },
    shopBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)

        end
    },
    page1Btn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.SeasonSLG1Main1ViewModel)
        end
    },
    page2Btn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
        end
    },
    trafficBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)

        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        RedMgr.Singleton:RegisterViewModel(UIName.SeasonSLG1Main2ViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        RedMgr.Singleton:Refresh()
        this.Refresh()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
    end,
    before_destroy = function(vm)
        this = nil;
    end
}

this.Refresh = function()
    this.activityData = DataExHelper.GetDataExByTag(ActivityKey.SeasonalTwo);
    if this.activityData == nil or not DataExHelper.CommonActivityCheck(ActivityKey.SeasonalTwo) then
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", ConfigMgr.LangGlobal("18344"))
        return
    end
    this.expireTime = this.activityData.expireTime
end

return vm({
    data = data,
    command = command,
    hook = hook
})