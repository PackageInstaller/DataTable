local this =
{
    vm = nil,
    confirm_callback = nil,
}

local data =
{
    text = "",
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

    on_click_cancel_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_cancel_btn()
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
    this.confirm_callback = nil
    if this.vm.behaviour.Params ~= nil then
        this.confirm_callback = this.vm.behaviour.Params[0]
    end

    local team_index = 0
    if DataMgr ~= nil and DataMgr.Player ~= nil and DataMgr.Player.BossTower ~= nil and DataMgr.Player.BossTower.Teams ~= nil then
        for k, _ in pairs(DataMgr.Player.BossTower.Teams) do
            if tonumber(k) > team_index then
                team_index = tonumber(k)
            end
        end
    end

    team_index = math.floor(team_index)

    this.vm.data.text = LuaMgr.GetLangText("YJSYZWarning2PopupViewModel_0") .. tostring(team_index + 1) .. LuaMgr.GetLangText("YJSYZWarning2PopupViewModel_1")
end

function this.on_before_deactive()
    this.confirm_callback = nil
end

function this.on_click_confirm_btn()
    if this.confirm_callback ~= nil then
        this.confirm_callback()
    end

    LuaMgr.HidePanel(UIName.YJSYZWarning2PopupViewModel)
end

function this.on_click_cancel_btn()
    LuaMgr.HidePanel(UIName.YJSYZWarning2PopupViewModel)
end

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)