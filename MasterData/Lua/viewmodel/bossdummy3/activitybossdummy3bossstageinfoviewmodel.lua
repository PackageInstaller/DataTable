local this =
{
    vm = nil,
}

local data = 
{

}

local command =
{
    on_click_next_step_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_next_step_btn()
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
}

function this.on_before_active()
    this.vm.behaviour:UpdateTopBar("", this.OnBack)
end

function this.on_before_deactive()

end

function this.on_click_next_btn()
    
end

function this.OnBack()
    LuaMgr.Back()
end

return vm
(
    {
        data    = data,
        command = command,
        hook    = hook
    }
)