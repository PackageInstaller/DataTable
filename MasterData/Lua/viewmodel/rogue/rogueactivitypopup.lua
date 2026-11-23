local this = {
    vm = nil,
    activityData = nil,
}

local data = {
    leftTimeStr = "",
}

local command = {
    gotoCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.RogueMain1ViewModel);
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.Refresh()
        LuaMgr.AddTimer(TimerConst.RogueMainTimer, this.Timer, 1, -1, true);
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        LuaMgr.RemoveTimer(TimerConst.RogueMainTimer)
    end,
}

this.Refresh = function()
    this.activityData = DataExHelper.GetDataExByTag(ActivityKey.RogueLike);
    if this.activityData == nil or not DataExHelper.CommonActivityCheck(ActivityKey.RogueLike) then
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", ConfigMgr.LangGlobal("18344"))
        return
    end

    this.expireTime = this.activityData.expireTime
end

this.Timer = function()
    if this.expireTime == nil then
        return
    end
    this.vm.data.leftTimeStr = RogueMgr.GetActivityLeftTimeStr_1(this.expireTime)
end

return vm({
    data = data,
    command = command,
    hook = hook
})