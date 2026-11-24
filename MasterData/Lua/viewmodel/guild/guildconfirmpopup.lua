local this = {
    vm = nil,
    confirmAction = nil,
    cancelAction = nil,
}
local objs = {

}
local data = {
    desc = ""
}

local command = {
    ConfirmCommand =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickConfirm()
        end
    },

    ClosePanelCommand =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickCancel()
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        UITool.Parse(vm.behaviour, this, objs);
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        this.vm.data.desc = tostring(vm.behaviour.Params[0] or "")
        this.confirmAction = vm.behaviour.Params.Length > 1 and vm.behaviour.Params[1] or nil
        this.cancelAction = vm.behaviour.Params.Length > 2 and vm.behaviour.Params[2] or nil
    end,
    before_deactive = function(vm)
        this.vm.data.desc = ""
        this.ClearAction()
    end,
    before_destroy = function(vm)
        this = nil
    end,
}

this.OnClickConfirm = function()
    local action = this.confirmAction
    this.ClearAction()
    LuaMgr.HidePanel(UIName.GuildConfirmPopup)
    this.CallAction(action)
end

this.OnClickCancel = function()
    local action = this.cancelAction
    this.ClearAction()
    LuaMgr.HidePanel(UIName.GuildConfirmPopup)
    this.CallAction(action)
end

this.ClearAction = function()
    this.confirmAction = nil
    this.cancelAction = nil
end

this.CallAction = function(action)
    if action == nil then
        return
    end
    local success, errorInfo = pcall(action)
    if not success then
        LuaDebug.error("GuildConfirmPopup action error:" .. tostring(errorInfo))
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})