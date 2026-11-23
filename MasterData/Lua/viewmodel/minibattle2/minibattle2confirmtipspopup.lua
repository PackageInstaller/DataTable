local this = {
    confirmFunc = nil,
};

local data = {
}

local command = {
    cancelBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.MiniBattle2ConfirmTipsPopup)
        end
    },

    confirmBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.confirmFunc ~= nil then
                this.confirmFunc()
            end
            LuaMgr.HidePanel(UIName.MiniBattle2ConfirmTipsPopup)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.confirmFunc = vm.behaviour.Params[0]
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

return vm({
    data = data,
    command = command,
    hook = hook
})