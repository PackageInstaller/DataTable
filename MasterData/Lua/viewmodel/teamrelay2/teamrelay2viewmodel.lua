require("Tools/UITool")
require("ViewModel/TeamRelay2/TeamRelay2PlotItem")

local objs = {
    leftCountText = { path = "root/Middle/Group/LeftCount/Text", type = UITool.Text },
    leftTimeText = { path = "root/Middle/Group/LeftTime/Text", type = UITool.Text },
    plotItemGo_1 = { path = "root/Middle/Group/PlotList/PlotItem_1", type = UITool.GameObject },
    plotItemGo_2 = { path = "root/Middle/Group/PlotList/PlotItem_2", type = UITool.GameObject },
    plotItemGo_3 = { path = "root/Middle/Group/PlotList/PlotItem_3", type = UITool.GameObject },
    rewardItemTemplate = { path = "template/RewardItem", type = UITool.GameObject },
    rewardBtn = { path = "root/Middle/Group/RewardBtn", type = UITool.Button },
}
local this = {
    vm = nil,
    activityData = nil,
    plotIds = {},
    plotItemList = {},
    nextRefreshTime = nil,
}

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        UITool.Parse(vm.behaviour, this, objs);
        RedMgr.Singleton:RegisterViewModel(UIName.TeamRelay2ViewModel)
        this.plotItemList = {}
        for i = 1, 3 do
            table.insert(this.plotItemList, TeamRelay2PlotItem.New(this["plotItemGo_" .. i]))
        end
        LuaMgr.AddClick(this.rewardBtn, this.OnClickRewardBtn)
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
        LuaMgr.RemoveTimer(TimerConst.TeamRelay2MianPageTimer);
        LuaMgr.RemoveUIEventListener(UIEventConst.TeamRelayRefresh, this.RefreshRed)
    end,
    before_destroy = function(vm)
        for i, v in ipairs(this.plotItemList) do
            v:Destroy()
        end
        this.plotItemList = {}
        LuaMgr.RemoveClick(this.rewardBtn, this.OnClickRewardBtn)
        this = nil
    end
}

this.InitParameter = function()
    this.activityData = DataExHelper.GetDataExByTag(ActivityKey.TeamRelay2)
    if this.activityData == nil or not DataExHelper.CommonActivityCheck(ActivityKey.TeamRelay2) then
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", ConfigMgr.LangGlobal("18344"))
        return
    end

    this.plotIds = TeamRelay2Mgr.GetPlotIds()
    this.InitRed()
    LuaMgr.AddTimer(TimerConst.TeamRelay2MianPageTimer, this.Update, 1, -1, true);
end

this.InitRed = function()
    if (RedMgr.Singleton:CheckRedCondition("17510")) then
        RedMgr.Singleton:FrushRedCondition("17510")
    end
    RedMgr.Singleton:Refresh()
    LuaMgr.AddUIEventListener(UIEventConst.TeamRelayRefresh, this.RefreshRed)
end

this.RefreshData = function()
    this.nextRefreshTime = nil
    local curTime = LuaMgr.Timestamp()
    for i, plotId in ipairs(this.plotIds) do
        local unlockTime = TeamRelay2Mgr.GetPlotUnlockTime(plotId)
        local itemData = {
            plotId = plotId,
            indexSprite = LuaMgr.GetSprite("TeamRelay2", TeamRelay2Mgr.plotIndexSprite[plotId]),
            nameSprite = LuaMgr.GetSprite("TeamRelay2", TeamRelay2Mgr.plotNameSprite[plotId]),
            highestScoreStr = string.format(LuaMgr.GetLangText("TeamRelay2ViewModel_0"), TeamRelay2Mgr.GetPlotHighestScore(plotId)),
            isLock = curTime < unlockTime,
            isClaimed = false,
            rewards = this.GetPlotPreviewRewards(plotId),
            rewardTemplate = this.rewardItemTemplate,
        }
        if itemData.isLock then
            this.nextRefreshTime = math.min(this.nextRefreshTime or unlockTime, unlockTime)
        else
            itemData.isClaimed = true
            local plotCfg = TeamRelay2Mgr.GetPlotCfg(plotId)
            for _, v in ipairs(plotCfg.Group) do
                local status = TeamRelay2Mgr.GetLevelStatus(v)
                if status ~= TeamRelay2Mgr.LevelStatus.Claimed then
                    itemData.isClaimed = false
                    break
                end
            end
        end
        this.plotItemList[i]:SetData(itemData)
    end

    local leftCount, limitCount = TeamRelay2Mgr.GetAllLeftChallengeCount()
    this.leftCountText.text = string.format(LuaMgr.GetLangText("TeamRelay2ViewModel_1"), leftCount, limitCount)
    this.RefreshRed()
end

this.GetPlotPreviewRewards = function(plotId)
    local rewardList = {}
    local rewardMap = {}
    local plotCfg = TeamRelay2Mgr.GetPlotCfg(plotId)
    for _, levelId in ipairs(plotCfg.Group) do
        local levelCfg = TeamRelay2Mgr.GetLevelCfg(levelId)
        if not IsNull(levelCfg.Reward) then
            for _, reward in ipairs(levelCfg.Reward) do
                if rewardMap[reward.id] == nil then
                    local rewardItem = ConfigMgr.Config.itemMap[reward.id];
                    local itemData = {
                        id = reward.id,
                        rareSort = rewardItem.rare,
                        rare = ActivityMgr.GetRareSprite(rewardItem.rare),
                        icon = ActivityMgr.GetItemTexture(reward.id),
                        count = "",
                        isCount = false,
                    }
                    table.insert(rewardList, itemData)
                    rewardMap[reward.id] = true
                end
            end
        end
    end
    table.sort(rewardList, function(a, b)
        return a.rareSort > b.rareSort
    end)
    return rewardList
end

this.Update = function()
    local curTime = LuaMgr.Timestamp()
    if this.activityData ~= nil then
        local leftTime = this.activityData.delTime - curTime
        if leftTime >= 0 then
            local d, h, m = GetTimeDHM(leftTime)
            this.leftTimeText.text = string.format(LuaMgr.GetLangText("TeamRelay2ViewModel_2"), d, h, m)
        end
    end
    if this.nextRefreshTime ~= nil and this.nextRefreshTime < curTime then
        this.RefreshData()
        return
    end
end


this.OnClickRewardBtn = function()
    LuaMgr.ShowLuaPanel(UIName.TeamRelay2RewardPopup)
end


this.RefreshRed = function()
    HeroRedDataHelper.SetTeamRelay2Red()
    RedMgr.Singleton:RefreshOtherViewModel(UIName.TeamRelay2ViewModel)
end

this.OnBack = function()
    LuaMgr.Back()
end

return vm({
    data = data,
    command = command,
    hook = hook
})