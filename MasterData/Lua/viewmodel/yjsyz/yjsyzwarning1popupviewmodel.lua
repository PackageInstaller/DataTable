local this =
{
    vm = nil,
}

local data =
{

}

local command =
{
    on_click_confirm_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_confirm_btn()
        end
    },
}

local hook =
{
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        this.on_before_active()
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        this.on_before_deactive()
    end,
    before_destroy = function(vm)

    end
}

function this.on_before_active()

end

function this.on_before_deactive()

end

function this.on_click_confirm_btn()
    LuaMgr.HidePanel(UIName.YJSYZWarning1PopupViewModel)
end

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)
