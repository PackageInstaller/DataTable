local this = 
{
    vm = nil,
}

local data = 
{
    name = LuaMgr.GetLangText("ActivityBossChallengeSkillTipsPopupViewModel_0"),
    desc = LuaMgr.GetLangText("ActivityBossChallengeSkillTipsPopupViewModel_1"),
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
        local params    = vm.behaviour.Params
        local monsterid = params[0]
        local skillid   = params[1]
        local skilltype = params[2]

        if skilltype == 1 then

            local skilldata = ConfigSkillMgr.GetCharacterSkill(skillid .. 1)    
            this.vm.data.name = skilldata.Name
            this.vm.data.desc = LuaMgr.GetMonsterSkillDesc(monsterid, skillid, false)
        else

            local skilldata = ConfigSkillMgr.GetCharacterPassiveSkill(skillid .. 1)    
            this.vm.data.name = skilldata.Name
            this.vm.data.desc = LuaMgr.GetMonsterSkillDesc(monsterid, skillid, true)
        end
    end,
}

function this.init(vm)
    this.vm = vm
end

function this.on_click_back_btn()
    LuaMgr.HidePanel(UIName.ActivityBossChallengeSkillTipsPopupViewModel);
end

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)