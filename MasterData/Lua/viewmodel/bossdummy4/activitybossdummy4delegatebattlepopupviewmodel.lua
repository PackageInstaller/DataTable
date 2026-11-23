local this =
{
    vm = nil,
    plotId = "",
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
        this.plotId = this.vm.behaviour.Params[1].plotCfg.Id
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
    this.vm.data.text_count = LuaMgr.GetLangText("ActivityBossDummy3DelegateBattlePopupViewModel_0") .. 
            string.format("<color=#B47240>%s</color>/%s", BossDummy4Mgr.GetMainDungeonDailyEffectCount(this.plotId), ConfigMgr.Config.constants.BossDummy3BossLimit)
    this.vm.data.text_score = tostring(BossDummy4Mgr.GetDungeonMaxScore(this.plotId))

    this.count = 1
    this.set_count()
end

function this.on_before_deactive()

end

function this.set_count()
    this.count = Clamp(this.count, 1, BossDummy4Mgr.GetMainDungeonDailyEffectCount(this.plotId))
    this.vm.data.text_choose = tostring(this.count)
    this.vm.data.text_preview = LuaMgr.GetLangText("ActivityBossDummy3DelegateBattlePopupViewModel_1") .. tostring(this.count * BossDummy4Mgr.GetDungeonMaxScore(this.plotId))
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
    if activityData.selected_buff ~= nil then
        buff_str = activityData.selected_buff
    end
    table.insert(enterDungeonParams.extraParams, buff_str)
    enterDungeonParams.count = this.count
    
    ApiMgr.Request("enter_leave_dungeon", enterDungeonParams, true, function(result)
        LuaMgr.ShowLuaPanel(UIName.ActivityBossDummy4DelegateBattleResultPopupViewModel, this.count, this.plotId)
        LuaMgr.HidePanel(UIName.ActivityBossDummy4DelegateBattlePopupViewModel)
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
    this.count = BossDummy4Mgr.GetMainDungeonDailyEffectCount(this.plotId)
    this.set_count()
end

function this.on_click_back_btn()
    LuaMgr.HidePanel(UIName.ActivityBossDummy4DelegateBattlePopupViewModel)
end

return vm
(
    {
        data    = data,
        command = command,
        hook    = hook
    }
)