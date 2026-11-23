require("ViewModel/MiniBattle4/MiniBattle4EnemyItem")
require("ViewModel/MiniBattle4/MiniBattle4SeriesItem")
require("ViewModel/MiniBattle4/MiniBattle4PlotItem")

local this = {
    vm = nil,


    seriesScrollView = nil,
    seriesItemTemplate = nil,
    curSeriesId = "",


    plotItemList = {},
    curPlotId = "",


    bossId = "",
    enemysListView = nil,
    enemyItemTemplate = nil,
    rewardContent = nil,
    rewardItems = {},
}

local data = {
    leftCountTipsStr = "",
    leftTimeTipsStr = "",
    totalScoreStr = "",
    bossNameStr = "",
    highestLevelStr = "",
}

local command = {
    rewardBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.MiniBattle4RewardPopup)
        end
    },
    bossBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local monsterInfoJson = MiniBattle4Mgr.GetMonsterDataJson(this.bossId)
            LuaMgr.ShowPanel("Laigu.ViewModel.TakeCard.HeroAttrPreviewViewModel", this.bossId, ActivityKey.DualBattle2, monsterInfoJson);
        end
    },
    helpChaBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.MiniBattle4HelpCharactersPopup, this.curSeriesId)
        end
    },
    startBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.MiniBattle4BuffViewModel, this.curPlotId)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        RedMgr.Singleton:RegisterViewModel(UIName.MiniBattle4ViewModel)
        this.seriesScrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Left/SeriesList/ScrollView").gameObject)
        this.seriesItemTemplate = vm.behaviour.transform:Find("template/SeriesItem").gameObject

        local plotItemGo_1 = vm.behaviour.transform:Find("root/Middle/PlotGroup/Plot_1").gameObject
        local plotItemGo_2 = vm.behaviour.transform:Find("root/Middle/PlotGroup/Plot_2").gameObject
        local plotItemGo_3 = vm.behaviour.transform:Find("root/Middle/PlotGroup/Plot_3").gameObject
        table.insert(this.plotItemList, MiniBattle4PlotItem.New(plotItemGo_1))
        table.insert(this.plotItemList, MiniBattle4PlotItem.New(plotItemGo_2))
        table.insert(this.plotItemList, MiniBattle4PlotItem.New(plotItemGo_3))
        for i, v in ipairs(this.plotItemList) do
            v:Init()
        end

        local enemysListTF = vm.behaviour.transform:Find("root/Right/DungeonInfo/Enemy/Bg/EnemyList/List")
        this.enemysListView = UIListView.New(enemysListTF)
        this.enemyItemTemplate = vm.behaviour.transform:Find("template/EnemyItem").gameObject
        
        this.rewardContent = vm.behaviour.transform:Find("root/Right/DungeonInfo/Reward/Bg/RewardScrollView/Viewport/Content")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        vm.behaviour:UpdateTopBar("", this.OnBack)

        this.InitParameter()
        this.RefreshData()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end

        for i, v in ipairs(this.plotItemList) do
            v:Clear()
        end
        for i = 1, #this.rewardItems do
            this.rewardItems[i]:Clear()
        end
        this.seriesScrollView:Clear()
        this.enemysListView:Clear()

        LuaMgr.RemoveTimer(TimerConst.MiniBattle4MainPageTimers)
        LuaMgr.RemoveUIEventListener(UIEventConst.MiniBattle4RedRefresh, this.OnRedRefresh)
    end,
    before_destroy = function(vm)
        if this.plotItemList ~= nil then
            for i, v in ipairs(this.plotItemList) do
                v:Destroy()
            end
            this.plotItemList = {}
        end
        this.rewardItems = {}
        this = nil
        UIScrollView.ClearItem("MiniBattle4SeriesItem")
        UIListView.ClearItem("MiniBattle4EnemyItem")
    end
}

this.InitParameter = function()
    this.activityData = DataExHelper.GetDataExByTag(ActivityKey.DualBattle2)
    if this.activityData == nil or not DataExHelper.CommonActivityCheck(ActivityKey.DualBattle2) then
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", ConfigMgr.LangGlobal("18344"))
        return
    end

    this.rewardItems = {}
    this.curSeriesId = MiniBattle4Mgr.GetSelectedSeriesId()
    this.InitRed()
    this.InitSeriesList()
    LuaMgr.AddTimer(TimerConst.MiniBattle4MainPageTimers, this.OnTimer, 1, -1, true)
end

this.InitRed = function()
    if (RedMgr.Singleton:CheckRedCondition("17220")) then
        RedMgr.Singleton:FrushRedCondition("17220")
    end
    RedMgr.Singleton:Refresh()
    LuaMgr.AddUIEventListener(UIEventConst.MiniBattle4RedRefresh, this.OnRedRefresh)
end

this.InitSeriesList = function()
    local seriesCfgs = ConfigMgr.Config.DualBattleSetiesidMap
    local seriesList = {}
    for k, v in pairs(seriesCfgs) do
        if v.ActivityGroup == MiniBattle4Mgr.activityGroupId then
            local unlockTime = MiniBattle4Mgr.GetSeriesUnlockTime(v.SeriesId)
            local seriesData = {
                seriesId = v.SeriesId,
                nameStr = LuaMgr.GetLangText(v.NameLan),
                unlockTime = unlockTime,
                redId = "17222_" .. v.SeriesId,
                isSelected = false,
                onClick = this.OnClickSeriesItem,
            }
            table.insert(seriesList, seriesData)
        end
    end
    table.sort(seriesList, function(a, b)
        return a.seriesId < b.seriesId
    end)
    
    if IsNullOrEmpty(this.curSeriesId) then
        this.curSeriesId = seriesList[1].seriesId
    end

    this.seriesScrollView:Clear(false)
    local scrollData, scrollDatas = {}, {}
    local groupData = nil
    local spacing = 10
    if #scrollDatas <= 2 then
        this.seriesScrollView:SetPadding(0, 0, -61.5, 0)
        spacing = 30
    else
        this.seriesScrollView:SetPadding(0, 0, 0, 0)
    end
    
    for i, v in ipairs(seriesList) do
        groupData = v
        scrollData = UIScrollData.GetData(this.seriesItemTemplate, "MiniBattle4SeriesItem", 260, 117 + spacing, groupData)
        table.insert(scrollDatas, scrollData)
    end

    this.seriesScrollView:SetParams(260, 370)
    this.seriesScrollView:SetData(scrollDatas, true)
end

this.RefreshData = function()
    this.OnClickSeriesItem(this.curSeriesId)
    this.vm.data.totalScoreStr = MiniBattle4Mgr.GetTotalScore()
    this.OnRedRefresh()
end

this.RefreshPlotList = function()
    if IsNullOrEmpty(this.curSeriesId) then
        return
    end

    local plotCfgs = MiniBattle4Mgr.GetPlotCfgList(this.curSeriesId)
    for i, v in ipairs(plotCfgs) do
        this.plotItemList[i]:SetData({
            plotId = v.ID,
            redId = "17222_" .. v.ID,
            isSelected = false,
            onClick = this.OnClickPlotItem
        })
    end
    this.curPlotId = MiniBattle4Mgr.GetSelectedPlot(this.curSeriesId)
    if IsNullOrEmpty(this.curPlotId) then
        this.curPlotId = this.plotItemList[1].data.plotId
    end
    local leftCount, totalCount = MiniBattle4Mgr.GetSeriesLeftChallengeCount(this.curSeriesId)
    this.vm.data.leftCountTipsStr = string.format(LuaMgr.GetLangText("MiniBattle4ViewModel_0"), leftCount, totalCount)
end

this.RefreshPlotInfo = function()
    this.SetEnemy()
    this.SetReward()
    this.SetHighestLevel()
end

this.SetEnemy = function()
    this.enemysListView:Clear()
    local plotCfg = MiniBattle4Mgr.GetPlotCfg(this.curPlotId)
    local listData
    local listDatas = {}
    local monsterMap = ConfigMgr.Config.monsterMap
    local bossList = plotCfg.ExMonsterId
    if not TableIsNull(bossList) then
        for _, v in ipairs(bossList) do
            local monster = monsterMap[v]
            if (monster ~= nil and not monster.hideShowinfo) then
                listData = UIListData.GetData(this.enemyItemTemplate, "MiniBattle4EnemyItem", monster)
                table.insert(listDatas, listData)
                if (#listDatas >= 3) then
                    break
                end
            end
        end
        this.enemysListView:SetData(listDatas)
        
        this.bossId = bossList[1]
        local bossCfg = monsterMap[this.bossId]
        if bossCfg ~= nil then
            this.vm.data.bossNameStr = LuaMgr.GetLangText(bossCfg.NameLan)
        end
    end
end


this.SetReward = function()
    local rewards = this.GetRewardList(this.curPlotId)
    local itemConfig = nil
    for i = 1, #rewards do
        if #this.rewardItems < i then
            table.insert(this.rewardItems, GoodsDataItem.New(this.rewardContent))
        end
        itemConfig = table.Copy(ConfigMgr.Config.itemMap[rewards[i].id])
        itemConfig["count0"] = rewards[i].count
        this.rewardItems[i]:SetData(i, itemConfig, 1, false, Vector3(0.55, 0.55, 0.55), false)
    end
    for i = #rewards + 1, #this.rewardItems do
        this.rewardItems[i]:Hide()
    end
    itemConfig = nil
end

this.GetRewardList = function(plotId)
    local itemMap = ConfigMgr.Config.itemMap;
    local plotCfg = MiniBattle4Mgr.GetPlotCfg(plotId)
    local allRewardMap = {}
    local allRewardList = {}
    for i, levelId in ipairs(plotCfg.EnemyOption) do
        local levelCfg = MiniBattle4Mgr.GetLevelCfg(levelId)
        for _, reward in ipairs(levelCfg.Reward) do
            if allRewardMap[reward.id] == nil then
                allRewardMap[reward.id] = reward.count
            else
                allRewardMap[reward.id] = allRewardMap[reward.id] + reward.count
            end
        end
    end
    for k, v in pairs(allRewardMap) do
        table.insert(allRewardList, {
            id = k,
            count = v
        })
    end
    table.sort(allRewardList, function(a, b)
        local aCfg, bCfg = itemMap[a.id], itemMap[b.id]
        if aCfg.rare == bCfg.rare then
            return aCfg.id < bCfg.id
        end
        return aCfg.rare > bCfg.rare
    end)
    return allRewardList
end

this.SetHighestLevel = function()
    local plotCfg = MiniBattle4Mgr.GetPlotCfg(this.curPlotId)
    local highestLevelId = MiniBattle4Mgr.GetPlotHighestLevel(this.curPlotId)
    local highestLevelStr = LuaMgr.GetLangText("MiniBattle4ViewModel_1")
    if not IsNullOrEmpty(highestLevelId) then
        local highestLevelCfg = MiniBattle4Mgr.GetLevelCfg(highestLevelId)
        if highestLevelCfg.Credit > 0 then
            local radio = math.floor(highestLevelCfg.Credit / 5)
            highestLevelStr = radio * 100 .. "%"
        end
    end
    
    this.vm.data.highestLevelStr = highestLevelStr
end


this.OnClickSeriesItem = function(seriesId)
    this.curSeriesId = seriesId
    for i = 1, #this.seriesScrollView.dataList do
        this.seriesScrollView.dataList[i].data.isSelected = this.seriesScrollView.dataList[i].data.seriesId == this.curSeriesId
        if this.seriesScrollView.itemMap[i] ~= nil then
            this.seriesScrollView.itemMap[i]:Refresh()
        end
    end
    this.RefreshPlotList()
    this.OnClickPlotItem(this.curPlotId)
    MiniBattle4Mgr.SaveSelectedSeriesId(this.curSeriesId)
    RedMgr.Singleton:Refresh()
end

this.OnClickPlotItem = function(plotId)
    this.curPlotId = plotId
    for i, v in ipairs(this.plotItemList) do
        v.data.isSelected = v.data.plotId == this.curPlotId
        v:Refresh()
    end
    this.RefreshPlotInfo()
    MiniBattle4Mgr.SaveSelectedPlot(this.curSeriesId, this.curPlotId)
end

this.OnTimer = function()
    if this.activityData == nil then
        return
    end
    local curTime = LuaMgr.Timestamp()
    local leftTime = this.activityData.delTime - curTime
    if leftTime >= 0 then
        local d, h, m = GetTimeDHM(leftTime)
        if leftTime < 3600 then
            h = "01"
        end
        this.vm.data.leftTimeTipsStr = string.format(LuaMgr.GetLangText("MiniBattle4ViewModel_2"), d, h)
    end
    for i = 1, #this.seriesScrollView.dataList do
        if this.seriesScrollView.dataList[i].data.isLock and this.seriesScrollView.itemMap[i] ~= nil then
            this.seriesScrollView.itemMap[i]:Refresh()
        end
    end
end

this.OnRedRefresh = function()
    HeroRedDataHelper.SetMiniBattle4Red()
end

this.OnBack = function()
    LuaMgr.Back()
end

return vm({
    data = data,
    command = command,
    hook = hook
})