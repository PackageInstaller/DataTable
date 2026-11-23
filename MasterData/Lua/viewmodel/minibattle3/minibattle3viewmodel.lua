require("ViewModel/MiniBattle3/MiniBattle3SeriesItem")
require("ViewModel/MiniBattle3/MiniBattle3DungeonItem")

local this = {
    vm = nil,
    dungeonList = {},
    seriesScrollView = nil,
    seriesItemTemplate = nil,
    dungeonUnlockTime = 0,
};

local data = {
    totalScore = "",
    upLeftCountStr = "",
    downLeftCountStr = "",
    leftTimeStr = "",
}

local command = {
    rewardBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.MiniBattle3RewardPopup);
        end
    },
    collectBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.MiniBattle3CollectViewModel);
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        RedMgr.Singleton:RegisterViewModel(UIName.MiniBattle3ViewModel);
        this.seriesScrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/DungeonList/ScrollView").gameObject)
        this.seriesItemTemplate = vm.behaviour.transform:Find("template/DungeonGroup").gameObject
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        if (RedMgr.Singleton:CheckRedCondition("16871")) then
            RedMgr.Singleton:FrushRedCondition("16871")
        end
        RedMgr.Singleton:Refresh()
        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.InitData()
        this.UpdateRed()
        this.RefreshData()
        LuaMgr.AddUIEventListener(UIEventConst.MiniBattle3RedRefresh, this.UpdateRed)
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        LuaMgr.RemoveTimer(TimerConst.MiniBattleNewTimer)
        LuaMgr.RemoveUIEventListener(UIEventConst.MiniBattle3RedRefresh, this.UpdateRed);
    end,
    before_destroy = function(vm)
        this = nil;
        UIScrollView.ClearItem("MiniBattle3SeriesItem")
        RedMgr.Singleton:RemoveViewModel(UIName.MiniBattle3ViewModel);
    end
}

this.InitData = function()
    this.dungeonList = {}
    this.dungeonUnlockTime = 0
    local battleCfgs = MiniBattle3Mgr.GetMiniBattleCfgs()
    local curTime = LuaMgr.Timestamp()
    for i, v in ipairs(battleCfgs) do
        local dungeonItem = {
            plotId = v.ID,
            seriesId = v.SeriesId,
            showName = LuaMgr.GetLangText(v.NameLan),
            type = v.Type,
            tips = this.GetDungeonTips(v),
            unlockTime = MiniBattle3Mgr.GetDungeonUnlockTime(v.ID),
            redId = "16871_" .. v.ID,
            onClickCommand = this.OnClickDungeon,
        }
        dungeonItem.isLock = dungeonItem.unlockTime > curTime
        table.insert(this.dungeonList, dungeonItem)
        if dungeonItem.unlockTime > curTime then
            if this.dungeonUnlockTime == 0 then
                this.dungeonUnlockTime = dungeonItem.unlockTime
            else
                this.dungeonUnlockTime = math.min(this.dungeonUnlockTime, dungeonItem.unlockTime)
            end
        end
    end

    table.sort(this.dungeonList, function(a, b)
        if a.seriesId == b.seriesId then
            return a.type < b.type
        else
            return a.seriesId < b.seriesId
        end
    end)

    local len = #this.dungeonList
    for i = 1, len do
        this.dungeonList[i].index = i
    end
end

this.RefreshData = function()
    this.activityData = DataExHelper.GetDataExByTag(ActivityKey.DualBattle);
    if this.activityData == nil or not DataExHelper.CommonActivityCheck(ActivityKey.DualBattle) then
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", ConfigMgr.LangGlobal("18344"))
        return
    end

    this.SetPageInfo()
    this.SetDungeonList()
end

this.SetPageInfo = function()
    this.vm.data.totalScore = MiniBattle3Mgr.GetTotalScore()

    local upDailyTotalCount = ConfigMgr.Config.constants.DualBattleUpLimit
    local upDailyUseCount = MiniBattle3Mgr.GetUpDailyBattleCount()
    this.vm.data.upLeftCountStr = string.format(LuaMgr.GetLangText("MiniBattle3ViewModel_6"),
            upDailyTotalCount - upDailyUseCount, upDailyTotalCount)

    local downDailyTotalCount = ConfigMgr.Config.constants.DualBattleDownLimit
    local downDailyUseCount = MiniBattle3Mgr.GetDownDailyBattleCount()
    this.vm.data.downLeftCountStr = string.format(LuaMgr.GetLangText("MiniBattle3ViewModel_7"),
            downDailyTotalCount - downDailyUseCount, downDailyTotalCount)

    local str = LuaMgr.GetLangText("MiniBattle3ViewModel_2")
    local dataStr = os.date(str, this.activityData.expireTime)
    this.vm.data.leftTimeStr = dataStr
    this.leftTime = this.activityData.expireTime - LuaMgr.Timestamp()
    LuaMgr.AddTimer(TimerConst.MiniBattleNewTimer, this.UpdateLeftTimer, 1, -1, true)
end

this.SetDungeonList = function()
    local scrollData, scrollDatas = {}, {}
    local groupData = nil
    local len = #this.dungeonList
    local index = 1
    while (index <= len - 1) do
        groupData = {
            dungeon1Data = this.dungeonList[index],
            dungeon2Data = this.dungeonList[index + 1],
            showConnect = not this.dungeonList[index].isLock,
        }
        scrollData = UIScrollData.GetData(this.seriesItemTemplate, "MiniBattle3SeriesItem", 344, 450, groupData)
        table.insert(scrollDatas, scrollData)
        index = index + 2
    end

    this.seriesScrollView:Clear(false)
    this.seriesScrollView:SetPadding(9, 0, 0, 0)
    this.seriesScrollView:SetParams(1084, 450)
    this.seriesScrollView:SetData(scrollDatas, true)
end

this.GetDungeonTips = function(plotCfg)
    local tips = ""
    if plotCfg.Type == 1 then
        tips = string.format(LuaMgr.GetLangText("MiniBattle3ViewModel_8"), MiniBattle3Mgr.GetDungeonMaxScore(plotCfg.ID))
    elseif plotCfg.Type == 2 then
        local plotCfg = ConfigMgr.Config.DualBattleMap[plotCfg.ID]
        local enemyLevelList = plotCfg.EnemyOption
        local maxFinishLevelId = ""
        for i = #enemyLevelList, 1, -1 do
            local levelId = enemyLevelList[i]
            if MiniBattle3Mgr.GetDungeonLevelRewardStatus(levelId) ~= 1 then
                maxFinishLevelId = levelId
                break
            end
        end
        if IsNullOrEmpty(maxFinishLevelId) then
            tips = LuaMgr.GetLangText("MiniBattle3ViewModel_9")
        else
            tips = string.format(LuaMgr.GetLangText("MiniBattle3ViewModel_10"), ConfigMgr.Config.DualBattleBuffMap[maxFinishLevelId].Credit)
        end
    end
    return tips
end

this.UpdateLeftTimer = function()
    if this.leftTime <= 0 then
        LuaMgr.HidePanel(UIName.MiniBattle3ViewModel)
        return
    end

    if this.dungeonUnlockTime > 0 then
        local curTime = LuaMgr.Timestamp()
        if this.dungeonUnlockTime <= curTime then
            this.dungeonUnlockTime = 0
            this.RefreshData()
        end
    end

    this.leftTime = this.leftTime - 1
end

this.UpdateRed = function()
    for i, v in ipairs(this.dungeonList) do
        RedMgr.Singleton:UpdateClientRedData(v.redId, MiniBattle3Mgr.CheckDungeonRewardRed(v.plotId) and 1 or 0);
    end
    HeroRedDataHelper.SetMiniBattle3Red()
end

this.OnBack = function()
    LuaMgr.Back();
end

return vm({
    data = data,
    command = command,
    hook = hook
})