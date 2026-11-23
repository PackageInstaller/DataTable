local this = {
    confirmFunc = nil,
};

local data = {
    toggleIsOn = false
}

local command = {
    toggleCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.toggleIsOn = not this.vm.data.toggleIsOn
        end
    },
    cancelBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.MiniBattle4ConfirmTipsPopup)
        end
    },

    confirmBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.vm.data.toggleIsOn then
                local curDataStr = os.date("%Y-%m-%d", LuaMgr.Timestamp())
                PlayerPrefs.SetString(DataMgr.Player.uid .. "_MiniBattle4LeftCountWarning", curDataStr);
                PlayerPrefs.Save();
            end
            if this.confirmFunc ~= nil then
                this.confirmFunc()
            end
            LuaMgr.HidePanel(UIName.MiniBattle4ConfirmTipsPopup)
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
        this.vm.data.toggleIsOn = true
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