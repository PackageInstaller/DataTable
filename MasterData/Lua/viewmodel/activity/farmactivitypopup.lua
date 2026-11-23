local this = {
    vm = nil,
    data = {
        activityData = nil,
    }
}

local data = {
    timeText = "",
    ratingSprite = DefaultSprite
}

local command = {
    gotoCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if ActivityMgr.ActivityRuning(ActivityKey.Seed) == false then
                return
            end
            LuaMgr.HidePanel(UIName.FarmActivityPopupViewModel)
            FarmRoom.Open()
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if DataMgr.Player.crisisContracts == nil then
            return
        end
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
    end,
}


this.InitParameter = function()
    this.data.activityData = DataExHelper.GetDataExByTag(ActivityKey.Seed)
    if this.data.activityData == nil then
        return
    end
    this.SetActivityTime()
end


this.SetActivityTime = function()
    local curTime = LuaMgr.Timestamp()
    local leftTime = this.data.activityData.delTime - curTime
    if leftTime >= 0 then
        local d, h, m, s = GetTimeDHMS2(leftTime)
        local timeStr = ""
        timeStr = timeStr .. string.format(LuaMgr.GetLangText("FarmActivityPopup_0"), d, ConfigMgr.LangGlobal("10365"), h, ConfigMgr.LangGlobal("2121"), m, ConfigMgr.LangGlobal("10367"), s, ConfigMgr.LangGlobal("10368"));
        this.vm.data.timeText = timeStr
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})