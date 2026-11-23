





local this = {
    vm = nil,activityData = nil,groupId = nil,activityConfig = nil,
}

local data = {
    timeText = "",animName = "",
    phaseOne = false,phaseTwo = false
}

local command = {
    gotoCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            HeroParameter.SavePanelType("branchprop")
            FeatureManager.GotoPanel("1041")
            LuaMgr.HidePanel(UIName.BranchHeroNewPopup)
        end
    },
    rewardCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.BranchHeroRewardViewModel)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        RedMgr.Singleton:RegisterViewModel(UIName.BranchHeroNewPopup)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.InitParameter()
        HeroRedDataHelper.SetHeroBranchRed()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.RemoveUIEvent()
    end,
    before_destroy = function(vm)
        this = nil
    end,
}

this.AddUIEvent = function()
    LuaMgr.AddUIEventListener(UIEventConst.BranchHeroRedUpDate, this.UpDateRed)
end
this.RemoveUIEvent = function()
    LuaMgr.RemoveUIEventListener(UIEventConst.BranchHeroRedUpDate, this.UpDateRed)
end


this.InitParameter = function()
    HeroParameter.branchHeroItemClick = nil
    this.groupId = ActivityMgr.groupKeyList["Story1"]
    this.activityData = DataMgr.Player.variables[this.groupId]
    this.SetActivityTime()
    local typeId = string.sub(this.groupId,7)
    this.activityConfig = ConfigMgr.Config.activityGroup[typeId]
    if this.activityConfig ~= nil then
        this.vm.data.phaseOne = this.activityConfig.system[2] == 1
        this.vm.data.phaseTwo = this.activityConfig.system[2] == 2
    end
end


this.SetActivityTime = function()
    local startTimeStr = ""
    local delayTimeStr = ""
    if this.activityData ~= nil then
        startTimeStr = os.date(LuaMgr.GetLangText("CollectActivityPopup_6"),this.activityData.startTime)
        delayTimeStr = os.date(LuaMgr.GetLangText("CollectActivityPopup_7"),this.activityData.delTime)
    end
    local tipStr = ConfigMgr.LangGlobal("15014")
    local timeStr = string.format("%s-%s",startTimeStr,delayTimeStr)
    this.vm.data.timeText = tipStr..timeStr
end

this.UpDateRed = function(args)
    HeroRedDataHelper.SetHeroBranchRed()
    RedMgr.Singleton:RefreshOtherViewModel(UIName.ActivityOnViewModel)
end

return vm({
    data = data,
    command = command,
    hook = hook
})