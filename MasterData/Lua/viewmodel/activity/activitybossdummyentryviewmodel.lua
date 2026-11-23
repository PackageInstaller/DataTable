local this = 
{
    vm = nil,
}

local data = 
{
    remaining_text = ""
}

local command =
{
    enterBtn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.ActivityBossDummyEntryViewModel)
            LuaMgr.ShowLuaPanel(UIName.ActivityBossDummyViewModel, "ActivityBossDummyEntryViewModel")
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
    LuaMgr.RemoveTimer(TimerConst.ActivityBossDummyEntryViewModelTimer1)
    LuaMgr.AddTimer(TimerConst.ActivityBossDummyEntryViewModelTimer1, this.on_timer1, 10.0, -1, false)

    this.set_remaining_text()
end

function this.on_before_deactive()
    LuaMgr.RemoveTimer(TimerConst.ActivityBossDummyEntryViewModelTimer1)
end

function this.on_timer1()
    this.set_remaining_text()
end

function this.set_remaining_text()
    local activity_group_config = ConfigMgr.Config.activityGroup["3080"]
    this.vm.data.remaining_text = this.get_remaining_time(activity_group_config.endTime)
end

function this.get_remaining_time(endtimeStr)

    local pattern = "(%d+)%-(%d+)%-(%d+) (%d+):(%d+):(%d+)"
    local year, month, day, hour, min, sec = endtimeStr:match(pattern)

    if not year then
        return LuaMgr.GetLangText("ActivityBossDummyEntryViewModel_0")
    end


    local endtime = os.time({
        year = tonumber(year),
        month = tonumber(month),
        day = tonumber(day),
        hour = tonumber(hour),
        min = tonumber(min),
        sec = tonumber(sec),
    })


    local now = os.time()

    local diff = endtime - now
    if diff <= 0 then
        return LuaMgr.GetLangText("ActivityBossDummyEntryViewModel_1")
    end


    local days = math.floor(diff / (24 * 3600))
    diff = diff % (24 * 3600)
    local hours = math.floor(diff / 3600)
    diff = diff % 3600
    local minutes = math.floor(diff / 60)

    return string.format(LuaMgr.GetLangText("ActivityBossDummyEntryViewModel_2"), days, hours, minutes)
end


return vm
(
    {
        data    = data,
        command = command,
        hook    = hook
    }
)