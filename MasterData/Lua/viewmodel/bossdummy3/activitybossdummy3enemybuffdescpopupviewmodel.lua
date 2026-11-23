local this =
{
    vm = nil,
}

local data = 
{
    text_buff_name      = "Buff",
    text_buff_desc      = "Desc",
    texture_buff_icon   = DefaultSprite,
}

local command =
{
    on_click_back_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_back_btn()
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
    local id = this.vm.behaviour.Params[0]
    for i, v in ipairs(ConfigMgr.Config.BossDummy3BuffDesc) do
        if v.Id == id then
            this.vm.data.text_buff_name     = LuaMgr.GetLangText(v.BuffNameLan)
            this.vm.data.text_buff_desc     = LuaMgr.GetLangText(v.BuffDesLan)
            this.vm.data.texture_buff_icon  = LuaMgr.GetSprite("BuffIcon", v.BuffIcon)
            break
        end
    end
end

function this.on_before_deactive()

end

function this.on_click_back_btn()
    LuaMgr.HidePanel(UIName.ActivityBossDummy3EnemyBuffDescPopupViewModel)
end

return vm
(
    {
        data    = data,
        command = command,
        hook    = hook
    }
)