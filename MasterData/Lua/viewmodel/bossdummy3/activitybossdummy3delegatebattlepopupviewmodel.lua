local this =
{
    vm = nil,
}

local data = 
{
    text_count      = "1",
    text_score      = "1",
    text_choose     = "1",
    text_preview    = "1",
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

    on_click_btn_dec =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_btn_dec()
        end
    },

    on_click_btn_add =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_btn_add()
        end
    },

    on_click_btn_max = 
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_btn_max()
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
    this.vm.data.text_count = LuaMgr.GetLangText("ActivityBossDummy3DelegateBattlePopupViewModel_0") .. string.format("<color=#B47240>%s</color>/%s", tostring(BossDummy3Mgr.GetBossDummy3TodayEffectScoreCount()), tostring(BossDummy3Mgr.GetBossDummy3TodayLimitScoreCount()))
    this.vm.data.text_score = tostring(BossDummy3Mgr.GetBossDummy3HighestScore())

    this.count = 1
    this.set_count()
end

function this.on_before_deactive()

end

function this.set_count()
    this.count = Clamp(this.count, 1, BossDummy3Mgr.GetBossDummy3TodayEffectScoreCount())
    this.vm.data.text_choose = tostring(this.count)
    this.vm.data.text_preview = LuaMgr.GetLangText("ActivityBossDummy3DelegateBattlePopupViewModel_1") .. tostring(this.count * BossDummy3Mgr.GetBossDummy3HighestScore())
end

function this.on_click_confirm_btn()
    local dungeonConfig = this.vm.behaviour.Params[0]
    local activityData = this.vm.behaviour.Params[1]
    local callBack = this.vm.behaviour.Params[2]
    local enterDungeonParams        = BattlePrepareMgr.GetDefaultEnterDungeonParams()
    enterDungeonParams.eventId      = dungeonConfig.id
    enterDungeonParams.dungeonId    = dungeonConfig.id
    enterDungeonParams.extraParams = { "boss_dummy3", activityData.config.Id }
    local buff_str = ""
    if activityData.selected_buff and #activityData.selected_buff > 0 then
        buff_str = table.concat(activityData.selected_buff, ";")
    end
    table.insert(enterDungeonParams.extraParams, buff_str)
    enterDungeonParams.count = this.count
    
    ApiMgr.Request("enter_leave_dungeon", enterDungeonParams, true, function(result)
        LuaMgr.ShowLuaPanel(UIName.ActivityBossDummy3DelegateBattleResultPopupViewModel, this.count)
        LuaMgr.HidePanel(UIName.ActivityBossDummy3DelegateBattlePopupViewModel)
        if callBack ~= nil then
            callBack()
        end
    end, nil, true, true);
end

function this.on_click_btn_dec()
    this.count = this.count - 1
    this.set_count()
end

function this.on_click_btn_add()
    this.count = this.count + 1
    this.set_count()
end

function this.on_click_btn_max()
    this.count = BossDummy3Mgr.GetBossDummy3TodayEffectScoreCount()
    this.set_count()
end

function this.on_click_back_btn()
    LuaMgr.HidePanel(UIName.ActivityBossDummy3DelegateBattlePopupViewModel)
end

return vm
(
    {
        data    = data,
        command = command,
        hook    = hook
    }
)