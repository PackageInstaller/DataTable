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
            LuaMgr.HidePanel(UIName.CrisisContractActivityPopup)
            LuaMgr.ShowLuaPanel(UIName.CrisisContractMainViewModel);
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
    this.data.activityData = DataExHelper.GetDataExByTag(ActivityKey.crisiscontract)
    this.vm.data.ratingSprite = ActivityMgr.GetCrisisContractRatingImg(DataMgr.Player.crisisContracts.maxScore, true)
    this.SetActivityTime()
end


this.SetActivityTime = function()
    local startTimeStr = ""
    local delayTimeStr = ""
    if this.data.activityData ~= nil then
        startTimeStr = os.date(LuaMgr.GetLangText("CrisisContractActivityPopup_0"), this.data.activityData.startTime)
        delayTimeStr = os.date(LuaMgr.GetLangText("CrisisContractActivityPopup_1"), this.data.activityData.delTime)
    end
    local tipStr = ConfigMgr.LangGlobal("15014")
    local timeStr = string.format("%s-%s",startTimeStr,delayTimeStr)
    this.vm.data.timeText = tipStr..timeStr
end

return vm({
    data = data,
    command = command,
    hook = hook
})