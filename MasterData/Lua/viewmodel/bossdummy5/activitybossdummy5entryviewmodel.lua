local this = 
{
    vm = nil,
}

local data = 
{
    
}

local command =
{
    enterBtn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.ActivityBossDummy5EntryViewModel)
            LuaMgr.ShowLuaPanel(UIName.BossDummy5ViewModel)
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
}

function this.on_before_active()

end

function this.on_before_deactive()
    
end

return vm
(
    {
        data    = data,
        command = command,
        hook    = hook
    }
)