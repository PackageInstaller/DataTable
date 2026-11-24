local this =
{
    vm = nil,
}

local data =
{
    text_time = ""
}

local command =
{
    enterBtn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.YJSYZEntryPopupViewModel)
            LuaMgr.ShowLuaPanel(UIName.YJSYZPanelViewModel)
        end
    }
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
    this.gameObject = this.vm.behaviour.gameObject

    this.set_text_time()

    LuaMgr.RemoveTimer(TimerConst.YJSYZEntryPopupTimer)
    LuaMgr.AddTimer(TimerConst.YJSYZEntryPopupTimer, this.set_text_time, 60, -1, true)
end

function this.on_before_deactive()
    LuaMgr.RemoveTimer(TimerConst.YJSYZEntryPopupTimer)
end

function this.set_text_time()
    this.vm.data.text_time = YJSYZHelper.get_time_left_str()
end

function this.OnBack()
    LuaMgr.Back()
end

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)