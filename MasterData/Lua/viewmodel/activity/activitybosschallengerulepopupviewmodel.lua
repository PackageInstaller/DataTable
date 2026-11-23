local this = 
{
    vm = nil,
}

local data = 
{
    name = '1',
    desc = '2',
}

local command = 
{
    on_click_back_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_back_btn()
        end
    }
}

local hook = 
{
    before_awake = function(vm)
        this.init(vm)
    end,
    before_active = function(vm) 
        if vm.behaviour.Params == nil then 
            return  
        end
        this.vm.data.name = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_104009")
        this.vm.data.desc = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_104010")
    end,
}

function this.init(vm)
    this.vm = vm
end

function this.on_click_back_btn()
    LuaMgr.HidePanel(UIName.ActivityBossChallengeRulePopupViewModel)
end

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)