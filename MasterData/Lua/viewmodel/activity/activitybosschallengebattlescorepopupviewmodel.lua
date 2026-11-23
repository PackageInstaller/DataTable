local this = 
{
    vm = nil,
}

local data = 
{
    text_damage     = "",
    text_percent    = "",
    text_round      = "",
    text_hero_count = "",
    text_score      = "",
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

        local data = vm.behaviour.Params[0]
        this.vm.data.text_damage        = tostring(data.damage)
        this.vm.data.text_round         = tostring(data.round)
        this.vm.data.text_hero_count    = tostring(data.hero_count)
        this.vm.data.text_score         = LuaMgr.GetLangText("ActivityBossChallengeBattleScorePopupViewModel_0") .. tostring(data.score)
        
        local cfg = nil
        for i, v in ipairs(ConfigMgr.Config.ChallengeBosses) do
            if v.Id == tostring(data.id) then
                cfg = v
                break
            end
        end
        if cfg ~= nil then
            local percent = tonumber(data.damage) / tonumber(cfg.Hp)
            percent = percent * 100.0
            if percent >= 100.0 then
                this.vm.data.text_percent = "(100%)"
            else
                this.vm.data.text_percent = "(" .. string.format("%.2f", percent) .. "%)"
            end
        else
            this.vm.data.text_percent = ""
        end
    end,
}

function this.init(vm)
    this.vm = vm
end

function this.on_click_back_btn()
    LuaMgr.HidePanel(UIName.ActivityBossChallengeBattleScorePopupViewModel)
end

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)