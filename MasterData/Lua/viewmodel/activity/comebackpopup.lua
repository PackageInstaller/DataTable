





local this = {
    vm = nil,
}

local data = {
    letterName_1 = "",letterName_2 = "",letterName_3 = "",letterName_4 = "",
    timeText = "",signInText = "",missionText = "",letterRed = false,
    signInRed = false,missionRed = false,
}

local command = {
    letterCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.ComeBackLetterPopup)
        end
    },
    signInCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            FeatureManager.GotoPanel("3221")
            LuaMgr.HidePanel(UIName.ComeBackPopup)
        end
    },
    missionCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            FeatureManager.GotoPanel("3222")
            LuaMgr.HidePanel(UIName.ComeBackPopup)
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.InitParameter()
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
    LuaMgr.AddUIEventListener(UIEventConst.ComeBackLetterRedPoint, this.UpdateLetterRed)
end
this.RemoveUIEvent = function()
    LuaMgr.RemoveUIEventListener(UIEventConst.ComeBackLetterRedPoint, this.UpdateLetterRed)
end


this.InitParameter = function()
    if not DataExHelper.Check_ComeBackActivity() then
        return
    end
    this.SetLanguageText()
    this.SetTime()
    this.vm.data.letterRed = DataExHelper.Check_ComeBackLetter()
    
    local redCount = HeroRedDataHelper.ComeBackSignInRed()
    this.vm.data.signInRed = redCount > 0
    
    redCount = HeroRedDataHelper.ComeBackMissionRed()
    if redCount == 0 then
        redCount = HeroRedDataHelper.ComeBackPhaseRed()
    end
    this.vm.data.missionRed = redCount > 0
end


this.SetLanguageText = function()
    this.vm.data.letterName_1 = ConfigMgr.LangGlobal("10902")
    this.vm.data.letterName_2 = ConfigMgr.LangGlobal("10903")
    this.vm.data.letterName_3 = ConfigMgr.LangGlobal("10904")
    this.vm.data.letterName_4 = ConfigMgr.LangGlobal("10905")
    this.vm.data.signInText = ConfigMgr.LangGlobal("10906")
    this.vm.data.missionText = ConfigMgr.LangGlobal("10907")
end


this.SetTime = function()
    local groupId = ActivityMgr.groupKeyList[ActivityKey.backPlayer]
    local activityData = DataMgr.Player.variables[groupId]
    if activityData == nil then
        return
    end
    local endTime = activityData.delTime
    local surplusTime = endTime - LuaMgr.Timestamp()
    local tipStr = ConfigMgr.LangGlobal("10901")
    local timeFormat = ConfigMgr.LangGlobal("10908")
    local d,h,m = GetTimeDHM2(surplusTime)
    this.vm.data.timeText = tipStr..string.format(timeFormat,d,h,m)
end

this.UpdateLetterRed = function(args)
    this.vm.data.letterRed = false
    local status = ActivityMgr.ActivityCanFinish(ActivityKey.backPlayer)
    RedMgr.Singleton:UpdateClientRedData("1500", status and 1 or 0)
end

return vm({
    data = data,
    command = command,
    hook = hook
})