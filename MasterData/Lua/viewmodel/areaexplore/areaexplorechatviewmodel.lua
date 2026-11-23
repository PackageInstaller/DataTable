local this = {vm = nil}

local data = {
    content = "",
}

local command = {
    maskCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.AreaExploreBoxViewModel, vm.behaviour.Params[1], vm.behaviour.Params[2])
            LuaMgr.HidePanel(UIName.AreaExploreChatViewModel)
            LuaMgr.InvokeUIEventListeners(UIEventConst.AreaExploreResultRefresh)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then return end

        local config = ConfigMgr.Config.areaRewardMap[vm.behaviour.Params[0]];
        if config == nil then
            return
        end 

        this.vm.data.content = LuaMgr.GetLangText(config.TestShowLan)
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAnimatorPlayFinish)
        LuaMgr.RemoveTimer(TimerConst.AreaExploreBoxEffect);
        LuaMgr.RemoveTimer(TimerConst.AreaExploreBoxTreasureDrop);
    end,
}

return vm({
data = data,
command = command,
hook = hook,
})