local this =
{
    vm              = nil,
    gameObject      = nil,
    stage_1_go      = nil,
    stage_2_go      = nil,
    stage_3_go      = nil,
    stage_4_go      = nil,
    stage_5_go      = nil,
    stage_boss_go   = nil,
}

local data =
{
    text_today_effect_score_count   = "2/6",
    text_highest_score              = "123",
    text_total_score                = "456",
    text_end_time                   = "1",
}

local command =
{
    on_click_stage_1_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_stage_1_btn(vm, param)
        end
    },

    on_click_stage_2_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_stage_2_btn(vm, param)
        end
    },

    on_click_stage_3_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_stage_3_btn(vm, param)
        end
    },

    on_click_stage_4_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_stage_4_btn(vm, param)
        end
    },

    on_click_stage_boss_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_stage_boss_btn(vm, param)
        end
    },

    on_click_stage_1_close_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_stage_1_close_btn(vm, param)
        end
    },

    on_click_stage_2_close_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_stage_2_close_btn(vm, param)
        end
    },

    on_click_stage_3_close_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_stage_3_close_btn(vm, param)
        end
    },

    on_click_stage_4_close_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_stage_4_close_btn(vm, param)
        end
    },

    on_click_stage_boss_close_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_stage_boss_close_btn(vm, param)
        end
    },

    on_click_highest_score_reward_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_highest_score_reward_btn(vm, param)
        end
    },

    on_click_total_score_reward_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_total_score_reward_btn(vm, param)
        end
    },
}

local hook =
{
    before_awake = function(vm)
        this.vm = vm
        RedMgr.Singleton:RegisterViewModel(UIName.ActivityBossDummy3ViewModel);
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
    this.gameObject = this.vm.behaviour.gameObject

    this.stage_1_go     = this.gameObject.transform:Find("root/Middle/stage_1").gameObject
    this.stage_2_go     = this.gameObject.transform:Find("root/Middle/stage_2").gameObject
    this.stage_3_go     = this.gameObject.transform:Find("root/Middle/stage_3").gameObject
    this.stage_4_go     = this.gameObject.transform:Find("root/Middle/stage_4").gameObject
    this.stage_boss_go  = this.gameObject.transform:Find("root/Middle/stage_boss").gameObject

    this.set_stage()
    this.set_totay_effect_score_count()
    this.set_highest_score()
    this.set_total_score()
    this.set_text_end_time()
    
    LuaMgr.AddUIEventListener(UIEventConst.HeartAcrossDay, this.on_heart_beat)
    LuaMgr.AddUIEventListener(UIEventConst.HeartBeat, this.on_heart_beat)
    this.init_red()
    
    BossDummy3Mgr.SaveEnterTimeStamp()
end

function this.init_red()
    RedMgr.Singleton:FrushRedCondition("16851_1")
    RedMgr.Singleton:FrushRedCondition("16851_2")
    RedMgr.Singleton:FrushRedCondition("16851_3")
    RedMgr.Singleton:FrushRedCondition("16851_4")
    RedMgr.Singleton:FrushRedCondition("16851_5")
    RedMgr.Singleton:FrushRedCondition("16851_6")
    RedMgr.Singleton:UpdateClientRedData("16851_1", BossDummy3Mgr.GetNormalLevelRewardStatus("1001"))
    RedMgr.Singleton:UpdateClientRedData("16851_2", BossDummy3Mgr.GetNormalLevelRewardStatus("1002"))
    RedMgr.Singleton:UpdateClientRedData("16851_3", BossDummy3Mgr.GetNormalLevelRewardStatus("1003"))
    RedMgr.Singleton:UpdateClientRedData("16851_4", BossDummy3Mgr.GetNormalLevelRewardStatus("1004"))
    RedMgr.Singleton:UpdateClientRedData("16851_5", BossDummy3Mgr.GetHighestScoreRewardStatus())
    RedMgr.Singleton:UpdateClientRedData("16851_6", BossDummy3Mgr.GetTotalScoreRewardStatus())
    RedMgr.Singleton:Refresh()
    RedMgr.Singleton:SetRedState("16851_5", BossDummy3Mgr.GetHighestScoreRewardStatus())
    RedMgr.Singleton:SetRedState("16851_6", BossDummy3Mgr.GetTotalScoreRewardStatus())
end

function this.on_before_deactive()
    LuaMgr.RemoveUIEventListener(UIEventConst.HeartAcrossDay, this.on_heart_beat)
    LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat, this.on_heart_beat)
end

function this.set_stage()
    for i = 1, 4, 1 do
        local config = BossDummy3Mgr.GetStageConfig(tostring(1000 + i))
        local go = this["stage_" .. i .. "_go"]
        if BossDummy3Mgr.GetIsUnlock(config.Delay) then
            go.transform:Find("status_1").gameObject:SetActive(true)
            go.transform:Find("status_2").gameObject:SetActive(false)
        else
            go.transform:Find("status_1").gameObject:SetActive(false)
            go.transform:Find("status_2").gameObject:SetActive(true)

            go.transform:Find("status_2/btn/Text").gameObject:GetComponent("Text").text = BossDummy3Mgr.GetDelayTimeText(config.Delay)
        end
    end

    local config_1 = BossDummy3Mgr.GetStageConfig(tostring(1000 + 1))
    local config_2 = BossDummy3Mgr.GetStageConfig(tostring(1000 + 2))
    local config_3 = BossDummy3Mgr.GetStageConfig(tostring(1000 + 3))
    local config_4 = BossDummy3Mgr.GetStageConfig(tostring(1000 + 4))

    if BossDummy3Mgr.GetIsUnlock(config_1.Delay) and BossDummy3Mgr.GetIsUnlock(config_2.Delay) then
        this.gameObject.transform:Find("root/Middle/line_1").gameObject:SetActive(false)
        this.gameObject.transform:Find("root/Middle/eff_line_1").gameObject:SetActive(true)
    else
        this.gameObject.transform:Find("root/Middle/line_1").gameObject:SetActive(true)
        this.gameObject.transform:Find("root/Middle/eff_line_1").gameObject:SetActive(false)
    end

    if BossDummy3Mgr.GetIsUnlock(config_3.Delay) and BossDummy3Mgr.GetIsUnlock(config_4.Delay) then
        this.gameObject.transform:Find("root/Middle/line_2").gameObject:SetActive(false)
        this.gameObject.transform:Find("root/Middle/eff_line_2").gameObject:SetActive(true)
    else
        this.gameObject.transform:Find("root/Middle/line_2").gameObject:SetActive(true)
        this.gameObject.transform:Find("root/Middle/eff_line_2").gameObject:SetActive(false)
    end

    local go = this.stage_boss_go
    local config = BossDummy3Mgr.GetStageConfig("1005")
    if BossDummy3Mgr.GetIsUnlock(config.Delay) then
        go.transform:Find("status_1").gameObject:SetActive(true)
        go.transform:Find("status_2").gameObject:SetActive(false)
    else
        go.transform:Find("status_1").gameObject:SetActive(false)
        go.transform:Find("status_2").gameObject:SetActive(true)

        go.transform:Find("status_2/btn/Text").gameObject:GetComponent("Text").text = BossDummy3Mgr.GetDelayTimeText(config.Delay)
    end
end

function this.set_totay_effect_score_count()
    local s = string.format("<color=#B47240>%s</color>/%s", tostring(BossDummy3Mgr.GetBossDummy3TodayEffectScoreCount()), tostring(BossDummy3Mgr.GetBossDummy3TodayLimitScoreCount()))
    this.vm.data.text_today_effect_score_count = s
end

function this.set_highest_score()
    this.vm.data.text_highest_score = LuaMgr.GetLangText("ActivityBossDummy3ViewModel_0") .. tostring(BossDummy3Mgr.GetBossDummy3HighestScore())
end

function this.set_total_score()
    this.vm.data.text_total_score = LuaMgr.GetLangText("ActivityBossDummy3ViewModel_1")  .. tostring(BossDummy3Mgr.GetBossDummy3TotalScore())
end

function this.set_text_end_time()
    local t = ConfigMgr.Config.activityGroup["4090"].endTime


    local y, m, d, H, M, S = t:match("(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
    local timeTable = {
        year  = tonumber(y),
        month = tonumber(m),
        day   = tonumber(d),
        hour  = tonumber(H),
        min   = tonumber(M),
        sec   = tonumber(S),
    }


    local ts = os.time(timeTable)


    local result = os.date(LuaMgr.GetLangText("ActivityBossDummy3ViewModel_2"), ts)
    this.vm.data.text_end_time = LuaMgr.GetLangText("ActivityBossDummy3ViewModel_3") .. result .. LuaMgr.GetLangText("ActivityBossDummy3ViewModel_4")
end

function this.on_heart_beat()
    this.set_stage()
end

function this.on_click_stage_1_btn(vm, param)
    LuaMgr.ShowLuaPanel(UIName.ActivityBossDummy3StageBuffViewModel, "1001")
end

function this.on_click_stage_2_btn(vm, param)
    LuaMgr.ShowLuaPanel(UIName.ActivityBossDummy3StageBuffViewModel, "1002")
end

function this.on_click_stage_3_btn(vm, param)
    LuaMgr.ShowLuaPanel(UIName.ActivityBossDummy3StageBuffViewModel, "1003")
end

function this.on_click_stage_4_btn(vm, param)
    LuaMgr.ShowLuaPanel(UIName.ActivityBossDummy3StageBuffViewModel, "1004")
end

function this.on_click_stage_boss_btn(vm, param)
    LuaMgr.ShowLuaPanel(UIName.ActivityBossDummy3StageBossBuffViewModel, "1005")
end

function this.on_click_stage_1_close_btn(vm, param)
    this.on_click_stage_close_btn("1001")
end

function this.on_click_stage_2_close_btn(vm, param)
    this.on_click_stage_close_btn("1002")
end

function this.on_click_stage_3_close_btn(vm, param)
    this.on_click_stage_close_btn("1003")
end

function this.on_click_stage_4_close_btn(vm, param)
    this.on_click_stage_close_btn("1004")
end

function this.on_click_stage_boss_close_btn(vm, param)
    this.on_click_stage_close_btn("1005")
end

function this.on_click_stage_close_btn(id)
    local config = BossDummy3Mgr.GetStageConfig(id)
    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, BossDummy3Mgr.GetDelayTimeText(config.Delay))
end

function this.on_click_highest_score_reward_btn(vm, param)
    LuaMgr.ShowLuaPanel(UIName.ActivityBossDummy3HighestScorePopupViewModel)
end

function this.on_click_total_score_reward_btn(vm, param)
    LuaMgr.ShowLuaPanel(UIName.ActivityBossDummy3TotalScorePopupViewModel)
end

function this.OnBack()
    if this.entry ~= nil and DataExHelper.CommonActivityCheck(ActivityKey.BossDummy3) then
        LuaMgr.Back(ActivityKey.BossDummy3)
    else
        LuaMgr.Back()
    end
end

return vm
(
    {
        data    = data,
        command = command,
        hook    = hook
    }
)