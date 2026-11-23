local this = {
    vm = nil,
    upPlotIds = { "2001", "2002", "2003", "2004" },
    downPlotIds = { "2005", "2006", "2007", "2008" },
    plotDelayTimeMap = {},
    curSeriesIndex = 1,
    nextRefreshTime = 0,
};

local data = {

    upSeriesOn = false,
    upSeriesOff = false,
    upSeriesTips = "",
    upSeriesLock = false,

    downSeriesOn = false,
    downSeriesOff = false,
    downSeriesTips = "",
    downSeriesLock = false,

    leftCountStr = "",
    bestScoreStr = "",
    totalScoreStr = "",

    connectOn_1 = false,
    connectOff_1 = false,
    connectOn_2 = false,
    connectOff_2 = false,

    dungeonLock_main = false,
    dungeonLock_1 = false,
    dungeonLock_2 = false,
    dungeonLock_3 = false,

    dungeonUnlock_main = false,
    dungeonUnlock_1 = false,
    dungeonUnlock_2 = false,
    dungeonUnlock_3 = false,

    dungeonName_main = "",
    dungeonName_1 = "",
    dungeonName_2 = "",
    dungeonName_3 = "",

    dungeonShowRating_1 = false,
    dungeonShowRating_2 = false,
    dungeonShowRating_3 = false,

    dungeonRatingStr_1 = "",
    dungeonRatingStr_2 = "",
    dungeonRatingStr_3 = "",

    dungeonLockTips_main = "",
    dungeonLockTips_1 = "",
    dungeonLockTips_2 = "",
    dungeonLockTips_3 = "",

    leftTimeStr = "",
}

local command = {
    seriesBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = tonumber(param)
            if index == this.curSeriesIndex then
                return
            end
            this.SetCurShowSeries(index)
        end
    },
    rewardBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.BossDummy4RewardPopup);
        end
    },
    dungeonBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = tonumber(param)
            local plotId = ""
            if this.curSeriesIndex == 1 then
                plotId = this.upPlotIds[index]
            elseif this.curSeriesIndex == 2 then
                plotId = this.downPlotIds[index]
            end
            local delayTime = this.plotDelayTimeMap[plotId]
            if delayTime ~= nil then
                local tips = this.GetLockTips(delayTime)
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tips);
                return
            end
            if index == 4 then
                if this.vm.data.dungeonLock_main then
                    LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", LuaMgr.GetLangText("BossDummy4ViewModel_0"))
                    return
                end
                LuaMgr.ShowLuaPanel(UIName.BossDummy4BuffViewModel, plotId);
            else
                LuaMgr.ShowLuaPanel(UIName.BossDummy4LevelViewModel, plotId);
            end
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        RedMgr.Singleton:RegisterViewModel(UIName.BossDummy4ViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        if (RedMgr.Singleton:CheckRedCondition("17022")) then
            RedMgr.Singleton:FrushRedCondition("17022")
        end
        RedMgr.Singleton:Refresh()
        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.Refresh()
        LuaMgr.AddUIEventListener(UIEventConst.BossDummy4RedRefresh, this.UpdateRed)
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        LuaMgr.RemoveTimer(TimerConst.BossDummy4Timer)
        LuaMgr.RemoveUIEventListener(UIEventConst.BossDummy4RedRefresh, this.UpdateRed);
    end,
    before_destroy = function(vm)
        this = nil;
        RedMgr.Singleton:RemoveViewModel(UIName.BossDummy4ViewModel);
    end
}

this.Refresh = function()
    this.activityData = DataExHelper.GetDataExByTag(ActivityKey.BossDummy4);
    if this.activityData == nil or not DataExHelper.CommonActivityCheck(ActivityKey.BossDummy4) then
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", ConfigMgr.LangGlobal("18344"))
        return
    end

    this.RefreshInfo()
    this.SetCurShowSeries(this.curSeriesIndex)
end

this.RefreshInfo = function()
    this.plotDelayTimeMap = {}
    this.nextRefreshTime = 0
    local minUpDelayTime = 0
    local minDownDelayTime = 0
    for i, v in ipairs(this.upPlotIds) do
        this.UpdateDelayTimeMap(v)
        this.GetMinDelayTime(v, minUpDelayTime)
    end
    for i, v in ipairs(this.downPlotIds) do
        this.UpdateDelayTimeMap(v)
        this.GetMinDelayTime(v, minDownDelayTime)
    end

    if minUpDelayTime > 0 then
        this.vm.data.upSeriesLock = true
        this.vm.data.upSeriesTips = this.GetLockTips(minUpDelayTime)
        this.nextRefreshTime = minUpDelayTime
    else
        this.vm.data.upSeriesLock = false
        this.vm.data.upSeriesTips = string.format(LuaMgr.GetLangText("BossDummy4ViewModel_1"), BossDummy4Mgr.GetDungeonMaxScore(this.upPlotIds[4]))
    end

    if minDownDelayTime > 0 then
        this.vm.data.downSeriesLock = true
        this.vm.data.downSeriesTips = this.GetLockTips(minDownDelayTime)
        this.nextRefreshTime = minDownDelayTime
    else
        this.vm.data.downSeriesLock = false
        this.vm.data.downSeriesTips = string.format(LuaMgr.GetLangText("BossDummy4ViewModel_2"), BossDummy4Mgr.GetDungeonMaxScore(this.downPlotIds[4]))
    end

    if this.nextRefreshTime > 0 then
        this.nextRefreshTime = math.min(minUpDelayTime > 0 and minUpDelayTime or math.huge, minDownDelayTime > 0 and minDownDelayTime or math.huge)
        LuaMgr.AddTimer(TimerConst.BossDummy4Timer, this.UpdateTime, 1, -1, true)
    end

    this.vm.data.leftTimeStr = os.date(LuaMgr.GetLangText("BossDummy4ViewModel_3"), this.activityData.expireTime)
end

this.UpdateDelayTimeMap = function(plotId)
    local curTime = LuaMgr.Timestamp()
    local unlockTime = BossDummy4Mgr.GetDungeonUnlockTime(plotId)
    local delayTime = unlockTime - curTime
    if delayTime > 0 then
        this.plotDelayTimeMap[plotId] = delayTime
    end
end

this.GetMinDelayTime = function(plotId, minDelayTime)
    local delayTime = this.plotDelayTimeMap[plotId]
    if delayTime ~= nil then
        if minDelayTime == 0 then
            minDelayTime = delayTime
        else
            minDelayTime = math.min(delayTime)
        end
    end
    return minDelayTime
end

this.GetLockTips = function(delayTime)
    local day, hour, minuts = GetTimeDHM2(delayTime)
    local tips = ""
    if day > 0 then
        tips = string.format(LuaMgr.GetLangText("BossDummy4ViewModel_4"), day, hour)
    else
        tips = string.format(LuaMgr.GetLangText("BossDummy4ViewModel_5"), hour, minuts)
    end
    return tips
end

this.SetCurShowSeries = function(index)
    if index == 1 and this.vm.data.upSeriesLock then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, this.vm.data.upSeriesTips);
        return
    elseif index == 2 and this.vm.data.downSeriesLock then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, this.vm.data.downSeriesTips);
        return
    end

    this.curSeriesIndex = index
    this.vm.data.upSeriesOn = index == 1
    this.vm.data.upSeriesOff = index ~= 1
    this.vm.data.downSeriesOn = index == 2
    this.vm.data.downSeriesOff = index ~= 2

    this.SetDungeonInfo()
    this.UpdateRed()
end

this.SetDungeonInfo = function()
    local plotIds = this.curSeriesIndex == 1 and this.upPlotIds or this.downPlotIds
    local mainDungeonIsLock = true
    for i = 1, 3 do
        local plotId = plotIds[i]
        local plotCfg = BossDummy4Mgr.GetPlotConfig(plotId)
        local bestRating = BossDummy4Mgr.GetDungeonMaxRating(plotId)
        local isLock = this.plotDelayTimeMap[plotId] ~= nil
        this.vm.data["dungeonLock_" .. i] = isLock
        this.vm.data["dungeonUnlock_" .. i] = not isLock
        this.vm.data["dungeonLockTips_" .. i] = isLock and this.GetLockTips(this.plotDelayTimeMap[plotId]) or ""
        this.vm.data["dungeonName_" .. i] = LuaMgr.GetLangText(plotCfg.NameLan)
        this.vm.data["dungeonShowRating_" .. i] = not IsNullOrEmpty(bestRating)
        this.vm.data["dungeonRatingStr_" .. i] = bestRating

        if not IsNullOrEmpty(bestRating) then
            mainDungeonIsLock = false
        end
    end

    local mainPlotId = plotIds[4]
    local plotCfg = BossDummy4Mgr.GetPlotConfig(mainPlotId)
    local isDelay = this.plotDelayTimeMap[mainPlotId] ~= nil
    local isLock = mainDungeonIsLock or isDelay
    local lockTips = ""
    if isDelay then
        lockTips = this.GetLockTips(this.plotDelayTimeMap[mainPlotId])
    elseif mainDungeonIsLock then
        lockTips = LuaMgr.GetLangText("BossDummy4ViewModel_6")
    end
    this.vm.data.dungeonLock_main = isLock
    this.vm.data.dungeonUnlock_main = not isLock
    this.vm.data.dungeonLockTips_main = lockTips
    this.vm.data.dungeonName_main = LuaMgr.GetLangText(plotCfg.NameLan)
    this.vm.data.leftCountStr = string.format(LuaMgr.GetLangText("BossDummy4ViewModel_7"),
            BossDummy4Mgr.GetMainDungeonDailyEffectCount(mainPlotId), ConfigMgr.Config.constants.BossDummy3BossLimit)
    this.vm.data.bestScoreStr = string.format(LuaMgr.GetLangText("BossDummy4ViewModel_8"), BossDummy4Mgr.GetDungeonMaxScore(mainPlotId))
    this.vm.data.totalScoreStr = string.format(LuaMgr.GetLangText("BossDummy4ViewModel_9"), BossDummy4Mgr.GetMainDungeonTotalScore(mainPlotId))

    this.vm.data.connectOn_1 = true
    this.vm.data.connectOn_2 = true
    this.vm.data.connectOff_1 = false
    this.vm.data.connectOff_2 = false
end

this.UpdateTime = function()
    if this.nextRefreshTime <= 0 then
        LuaMgr.RemoveTimer(TimerConst.BossDummy4Timer)
        this.Refresh()
        return
    end

    this.nextRefreshTime = this.nextRefreshTime - 1
end

this.UpdateRed = function()
    local missionRed = BossDummy4Mgr.CheckMissionRed()
    RedMgr.Singleton:UpdateClientRedData("17023", missionRed)
    for i = 1, 2 do
        local redCount = 0
        for j = 1, 3 do
            local curPlotIds = i == 1 and this.upPlotIds or this.downPlotIds
            local red = BossDummy4Mgr.CheckPlotRed(curPlotIds[j]) and 1 or 0
            redCount = redCount + red
            if this.curSeriesIndex == i then
                RedMgr.Singleton:UpdateClientRedData("17021_" .. j, red)
            end
        end
        RedMgr.Singleton:UpdateClientRedData("17021_" .. (i + 3), redCount)
    end
    RedMgr.Singleton:Refresh();
end

this.OnBack = function()
    LuaMgr.Back();
end

return vm({
    data = data,
    command = command,
    hook = hook
})