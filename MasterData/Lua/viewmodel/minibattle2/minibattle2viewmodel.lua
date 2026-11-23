require("ViewModel/MiniBattle2/MiniBattle2SeriesItem")
require("ViewModel/MiniBattle2/MiniBattle2DungeonItem")

local this = {
    vm = nil,
    dungeonList = {},
    seriesScrollView = nil,
    seriesItemTemplate = nil,
};

local data = {
    totalScore = "",
    leftCountStr = "",
    leftTimeStr = "",
}

local command = {
    rewardBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.MiniBattle2RewardPopup, this.UpdateRed);
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        RedMgr.Singleton:RegisterViewModel(UIName.MiniBattle2ViewModel);
        this.seriesScrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/ScrollView").gameObject)
        this.seriesItemTemplate = vm.behaviour.transform:Find("template/DungeonGroup").gameObject
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        if (RedMgr.Singleton:CheckRedCondition("16430")) then
            RedMgr.Singleton:FrushRedCondition("16430")
        end
        RedMgr.Singleton:Refresh()
        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.InitData()
        this.UpdateRed()
        this.RefreshData()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        LuaMgr.RemoveTimer(TimerConst.MiniBattleNewTimer)
    end,
    before_destroy = function(vm)
        this = nil;
        UIScrollView.ClearItem("MiniBattle2SeriesItem")
    end
}

this.InitData = function()
    this.dungeonList = {}
    this.dungeonTimerList = {}
    local battleCfgs = MiniBattle2Mgr.GetMiniBattleCfgs()
    local curTime = LuaMgr.Timestamp()
    for i, v in ipairs(battleCfgs) do
        local dungeonItem = {
            plotId = v.ID,
            seriesId = v.seriesId,
            showName = this.GetDungeonShowName(i),
            groupIndex = this.GetDungeonGroupIndex(i),
            score = MiniBattle2Mgr.GetDungeonScore(v.ID),
            unlockTime = MiniBattle2Mgr.GetDungeonUnlockTime(v.ID),
            redId = "16431_" .. v.ID,
            onClickCommand = this.OnClickDungeon,
        }
        dungeonItem.isLock = dungeonItem.unlockTime > curTime
        table.insert(this.dungeonList, dungeonItem)
        if dungeonItem.unlockTime > curTime then
            this.dungeonTimerList[dungeonItem.plotId] = dungeonItem.unlockTime
        end
    end

    local len = #this.dungeonList
    for i = 1, len do
        this.dungeonList[i].index = i
    end
end

this.RefreshData = function()
    this.activityData = DataExHelper.GetDataExByTag(ActivityKey.MiniBattlenew);
    if this.activityData == nil or not DataExHelper.CommonActivityCheck(ActivityKey.MiniBattlenew) then
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", ConfigMgr.LangGlobal("18344"))
        LuaMgr.HidePanel(UIName.MiniBattle2ViewModel);
        return
    end

    this.SetPageInfo()
    this.SetDungeonList()
end

this.SetPageInfo = function()
    this.vm.data.totalScore = MiniBattle2Mgr.GetTotalScore()

    local dailyTotalCount = ConfigMgr.Config.constants.MiniBattleNewLimit
    local dailyUseCount = MiniBattle2Mgr.GetDailyBattleCount()
    this.vm.data.leftCountStr = string.format(LuaMgr.GetLangText("MiniBattle2ViewModel_0"),
            dailyTotalCount - dailyUseCount, dailyTotalCount)

    local str = LuaMgr.GetLangText("MiniBattle2ViewModel_1")
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
        scrollData = UIScrollData.GetData(this.seriesItemTemplate, "MiniBattle2SeriesItem", 379, 400, groupData)
        table.insert(scrollDatas, scrollData)
        index = index + 2
    end

    this.seriesScrollView:Clear(false)
    local screenWidth = LuaMgr.GetScreenWidth()
    local leftPadding = screenWidth / 2 - 350
    this.seriesScrollView:SetPadding(leftPadding + 17, 0, 0, 0)
    this.seriesScrollView:SetParams(screenWidth, 400)
    this.seriesScrollView:SetData(scrollDatas, true)
end

this.GetDungeonShowName = function(index)
    if index == 1 or index == 2 then
        return LuaMgr.GetLangText("MiniBattle2ViewModel_2")
    elseif index == 3 or index == 4 then
        return LuaMgr.GetLangText("MiniBattle2ViewModel_3")
    elseif index == 5 or index == 6 then
        return LuaMgr.GetLangText("MiniBattle2ViewModel_4")
    elseif index == 7 or index == 8 then
        return LuaMgr.GetLangText("MiniBattle2ViewModel_5")
    end
end

this.GetDungeonGroupIndex = function(index)
    return math.ceil(index / 2)
end

this.UpdateLeftTimer = function()
    if this.leftTime <= 0 then
        LuaMgr.HidePanel(UIName.MiniBattle2ViewModel)
        return
    end
    local curTime = LuaMgr.Timestamp()
    for k, unlockTime in pairs(this.dungeonTimerList) do
        if unlockTime < curTime then
            this.dungeonTimerList = {}
            this.RefreshData()
            break
        end
    end

    this.leftTime = this.leftTime - 1
end

this.UpdateRed = function()
    for i, v in ipairs(this.dungeonList) do
        RedMgr.Singleton:UpdateClientRedData(v.redId, MiniBattle2Mgr.CheckDungeonRewardRed(v.plotId) and 1 or 0);
    end
    HeroRedDataHelper.SetMiniBattle2Red()
end

this.OnBack = function()
    LuaMgr.Back();
end

return vm({
    data = data,
    command = command,
    hook = hook
})