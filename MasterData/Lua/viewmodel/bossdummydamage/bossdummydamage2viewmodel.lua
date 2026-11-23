BossDummyDamage2ViewModel = 
{

}

local this =
{
    vm = nil,
}

local data =
{
}

local command =
{
}

local hook =
{
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        this = nil
    end,
}

function BossDummyDamage2ViewModel.GetValue(value)
    return value * 0.1
end

return vm({
    data = data,
    command = command,
    hook = hook
})