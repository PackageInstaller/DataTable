local this = 
{
    vm = nil,
}

local data = 
{
    time_text = "",
}

local command =
{
    enterBtn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.ActivityBossChallengeEntryViewModel)
            LuaMgr.ShowLuaPanel(UIName.ActivityBossChallengeViewModel, "ActivityBossChallengeEntryViewModel")
        end
    }
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
        this.set_time_text()
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params == nil then 
            return 
        end
    end, 
}

function this.set_time_text()
    local group_id = ActivityMgr.groupKeyList["BossChallenge"]
    if IsNullOrEmpty(group_id) then
        return
    end

    local activity_data = DataMgr.Player.variables[group_id]
    if activity_data == nil then
        return
    end

    local current_timestamp = LuaMgr.Timestamp()
    local is_expired = false
    if current_timestamp < activity_data.startTime or current_timestamp >= activity_data.delTime then
       is_expired = true 
    end

    if is_expired then
        return
    end

    local startTimeStr  = os.date(LuaMgr.GetLangText("CollectActivityPopup_6"),activity_data.startTime)
    local delayTimeStr  = os.date(LuaMgr.GetLangText("CollectActivityPopup_7"),activity_data.delTime)
    local timeStr       = string.format("%s-%s",startTimeStr,delayTimeStr)

    this.vm.data.time_text = timeStr
end

return vm
(
    {
        data    = data,
        command = command,
        hook    = hook
    }
)