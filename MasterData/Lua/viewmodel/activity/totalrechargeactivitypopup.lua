local this = {
    vm = nil,
    data = {
    }
}

local data = {
}

local command = {
    gotoCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.TotalRechargeActivityPopup)
            LuaMgr.ShowLuaPanel(UIName.MainShopViewModel, "totalRecharge")
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
    end,
}

return vm({
    data = data,
    command = command,
    hook = hook
})