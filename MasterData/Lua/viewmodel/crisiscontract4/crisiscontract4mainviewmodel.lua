
local this = {
    vm = nil,
    activityData = nil,
    leftTime = 0,
    medalList = {},
}

local data = {
    leftTimeStr = "",
    totalScoreStr = "",
    achievementStr = "",
}

local command = {
    taskBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.CrisisContract4TaskPopup, this.UpdateRed);
        end
    },
    levelBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.CrisisContract4LevelViewModel);
        end
    },
    medalBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.CrisisContract2MedalPopup, this.medalList);
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        RedMgr.Singleton:RegisterViewModel(UIName.CrisisContract4MainViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.RefreshData()
        PlayerMedalMgr.CheckMedalPopup("4202")
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        LuaMgr.RemoveTimer(TimerConst.CrisisContract4Timer)
    end,
    before_destroy = function(vm)
        this = nil
        RedMgr.Singleton:RemoveViewModel(UIName.CrisisContract4MainViewModel);
    end,
}

this.RefreshData = function()
    this.activityData = DataExHelper.GetDataExByTag(ActivityKey.TeamRelay3)
    if this.activityData == nil then

        LuaMgr.HidePanel(UIName.CrisisContract4MainViewModel)
        return
    end

    local curScore = CrisisContract4Mgr.GetTotalScore()
    this.medalList = CrisisContract4Mgr.GetMedalList()
    this.vm.data.totalScoreStr = curScore
    local finishMedalCount = 0
    for i, v in ipairs(this.medalList) do
        if curScore >= v.target then
            finishMedalCount = finishMedalCount + 1
        end
    end
    this.vm.data.achievementStr = string.format(LuaMgr.GetLangText("CrisisContract2MainViewModel_0"), finishMedalCount, #this.medalList)
    this.SetLeftTime()
end

this.SetLeftTime = function()
    this.leftTime = this.activityData.expireTime - LuaMgr.Timestamp();
    LuaMgr.AddTimer(TimerConst.CrisisContract4Timer, this.UpdateLeftTimer, 1, -1, true)
end

this.UpdateLeftTimer = function()
    if this.leftTime <= 0 then
        LuaMgr.HidePanel(UIName.CrisisContract4MainViewModel)
        return
    end

    this.vm.data.leftTimeStr = CrisisContract4Mgr.GetLeftTimeStr(this.leftTime)
    this.leftTime = this.leftTime - 1
end

this.UpdateRed = function()
    HeroRedDataHelper.SetCrisisContract4Red()
end

return vm({
    data = data,
    command = command,
    hook = hook
})