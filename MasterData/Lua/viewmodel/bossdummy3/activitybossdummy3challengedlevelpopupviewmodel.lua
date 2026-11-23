local this =
{
    vm = nil,
}

local data = 
{

}

local objs =
{
    text = { path = "root/Middle/Line/Text", type = "Text" },
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

    on_click_confirm_btn = 
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_confirm_btn()
        end
    },

    on_click_today_btn = 
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_today_btn()
        end
    }
}

local hook =
{
    before_awake = function(vm)
        this.vm = vm
        this.gameObject = this.vm.behaviour.gameObject
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
    UITool.Parse(this.gameObject, this, objs)
    local params            = this.vm.behaviour.Params
    local textId            = params[0]
    this.callback           = params[1]
    this.text.text = LuaMgr.GetLangText(textId)
end

function this.on_before_deactive()

end

function this.on_click_confirm_btn()
    if this.callback ~= nil then
        this.callback();
    end
end

function this.on_click_back_btn()
    LuaMgr.HidePanel(UIName.ActivityBossDummy3ChallengedLevelPopupViewModel)
end

return vm
(
    {
        data    = data,
        command = command,
        hook    = hook
    }
)