require("ViewModel/CrisisContract3/CrisisContract3SeriesItem")
require("ViewModel/CrisisContract3/CrisisContract3DungeonItem")
require("ViewModel/CrisisContract3/CrisisContract3RewardItem")
require("ViewModel/CrisisContract3/CrisisContract3SimpleBuffItem")

local this = {
    vm = nil,
    activityData = nil,
    leftTime = 0,
    dungeonTimerList = {},

    dungeonList = {},
    seriesScrollView = nil,
    seriesItemTemplate = nil,

    buffScrollView = nil,
    buffItemTemplate = nil,

    curScore = 0,
    rewardListView = nil,
    rewardItemTemplate = nil,
    uiRect = nil,
    rewardPreviewRect = nil,

    curChooseDungeonPlotId = "",
    curChooseDungeonPlotCfg = nil,
}

local data = {
    leftTimeStr = "",
    leftTimesStr = "",
    totalScore = "",
    showDungeonInfo = false,
    curDungeonName = "",
    buffIsEmpty = false,
    rewardTipsList = { {} },
    showRewardTips = false,
    showNoBattleCountTips = false,
}

local command = {
    taskBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.CrisisContract3TaskPopup, this.UpdateRed);
        end
    },
    dungeonInfoMask = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickDungeon(0)
        end
    },
    rewardTipsMask = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.showRewardTips = false
        end
    },
    startBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local leftTimes = ConfigMgr.Config.constants.Contract3Limit - DataMgr.Player.contract3Plot.contractPlotCount
            if leftTimes <= 0 then
                this.vm.data.showNoBattleCountTips = true
            else
                LuaMgr.ShowLuaPanel(UIName.CrisisContract3BuffViewModel, this.curChooseDungeonPlotId);
            end
        end
    },
    noBattleConfirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.showNoBattleCountTips = false
            LuaMgr.ShowLuaPanel(UIName.CrisisContract3BuffViewModel, this.curChooseDungeonPlotId);
        end
    },
    noBattleCancelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.showNoBattleCountTips = false
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        RedMgr.Singleton:RegisterViewModel(UIName.CrisisContract3LevelViewModel);
        this.seriesScrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/ScrollView").gameObject)
        this.seriesItemTemplate = vm.behaviour.transform:Find("template/SeriesItem").gameObject

        this.buffScrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/UI/DungeonInfo/Buff/BuffList/ScrollView").gameObject)
        this.buffItemTemplate = vm.behaviour.transform:Find("template/BuffItem").gameObject

        local dungeonRewardContent = vm.behaviour.transform:Find("root/Middle/UI/DungeonInfo/Reward/RewardList"):GetComponent("RectTransform");
        this.rewardItemTemplate = vm.behaviour.transform:Find("template/RewardItem").gameObject;
        this.rewardListView = UIListView.New(dungeonRewardContent)

        this.uiRect = vm.behaviour.transform:Find("root/Middle/UI"):GetComponent("RectTransform");
        this.rewardPreviewRect = vm.behaviour.transform:Find("root/Middle/UI/RewardPreviewTips"):GetComponent("RectTransform");
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.InitData()
        this.UpdateRed()
        this.RefreshData()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        LuaMgr.RemoveTimer(TimerConst.CrisisContract3Timer)
    end,
    before_destroy = function(vm)
        this = nil
        UIScrollView.ClearItem("CrisisContract3SeriesItem")
        UIScrollView.ClearItem("CrisisContract3SimpleBuffItem")
        UIListView.ClearItem("CrisisContract3RewardItem")
        RedMgr.Singleton:RemoveViewModel(UIName.CrisisContract3LevelViewModel);
    end,
}
this.InitData = function()
    this.dungeonTimerList = {}
    this.curChooseDungeonPlotId = ""
    this.InitDungeonListData()
    this.ShowDungeonInfo()
end

this.InitDungeonListData = function()
    this.dungeonList = {}
    local contractPlotCfgs = ConfigMgr.Config.Contract3Plots
    for i, v in ipairs(contractPlotCfgs) do
        local dungeonItem = {
            plotId = v.Id,
            select = false,
            unlockTime = CrisisContract3Mgr.GetDungeonUnlockTime(v.Id),
            addTimer = this.AddTimer,
            getChoosePlotId = this.GetCurChooseDungeonPlotId,
            callBack = this.OnClickDungeon,
            redId = "17012_" .. v.Id,
        }
        table.insert(this.dungeonList, dungeonItem)
    end
    table.sort(this.dungeonList, function(a, b)
        return a.plotId < b.plotId
    end)

    local len = #this.dungeonList
    for i = 1, len do
        this.dungeonList[i].index = i
    end
end

this.RefreshData = function()
    this.activityData = DataExHelper.GetDataExByTag(ActivityKey.crisiscontract3)
    if this.activityData == nil then

        LuaMgr.HidePanel(UIName.CrisisContract3LevelViewModel)
        return
    end
    this.SetPageInfo()
    this.SetDungeonList()
end

this.SetPageInfo = function()
    this.vm.data.totalScore = CrisisContract3Mgr.GetTotalScore()
    local leftTimes = ConfigMgr.Config.constants.Contract3Limit - DataMgr.Player.contract3Plot.contractPlotCount
    this.vm.data.leftTimesStr = string.format("<color=#FFFFFF><size=26>%d</size></color>/%d", leftTimes, ConfigMgr.Config.constants.Contract3Limit)
    this.SetLeftTime()
end

this.SetDungeonList = function()
    local scrollData, scrollDatas = {}, {}
    local groupData = nil
    local len = #this.dungeonList
    local index = 1
    while (index <= len - 1) do
        groupData = {
            dungeon1Data = this.dungeonList[index],
            dungeon2Data = this.dungeonList[index + 1]
        }
        scrollData = UIScrollData.GetData(this.seriesItemTemplate, "CrisisContract3SeriesItem", 337, 720, groupData)
        table.insert(scrollDatas, scrollData)
        index = index + 2
    end

    this.seriesScrollView:Clear(false)
    this.seriesScrollView:SetPadding(170, 0, 0, 0)
    this.seriesScrollView:SetParams(LuaMgr.GetScreenWidth(), 720)
    this.seriesScrollView:SetData(scrollDatas, true)
end

this.OnClickDungeon = function(index)
    local chooseDungeonPlotId = ""
    if index > 0 then
        local dungeonData = this.dungeonList[index]
        if dungeonData == nil or dungeonData.select then
            return
        end

        local leftTime = dungeonData.unlockTime - LuaMgr.Timestamp()
        if leftTime > 0 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(ConfigMgr.LangGlobal("25003"), CrisisContract3Mgr.GetLeftTimeStr(leftTime)))
            return
        end

        chooseDungeonPlotId = this.dungeonList[index].plotId
    end
    if this.curChooseDungeonPlotId == chooseDungeonPlotId then
        return
    end
    this.curChooseDungeonPlotId = chooseDungeonPlotId
    this.ShowDungeonInfo()
    this.seriesScrollView:Refresh()
end

this.ShowDungeonInfo = function()
    if this.curChooseDungeonPlotId == "" then
        this.vm.data.showDungeonInfo = false
        this.vm.data.showRewardTips = false
        return
    end

    this.curChooseDungeonPlotCfg = CrisisContract3Mgr.GetPlotConfig(this.curChooseDungeonPlotId)
    this.vm.data.curDungeonName = LuaMgr.GetLangText(this.curChooseDungeonPlotCfg.NameLan)
    this.curScore = CrisisContract3Mgr.GetCurPlotScore(this.curChooseDungeonPlotId)
    this.SetBuffList()
    this.SetDungeonRewardList()
    this.vm.data.showDungeonInfo = true
    this.vm.data.showRewardTips = false
end

this.SetBuffList = function()
    local buffList = CrisisContract3Mgr.GetChooseBuffListByPlotId(this.curChooseDungeonPlotId)
    local scrollData, scrollDatas = {}, {}
    local groupData = nil
    local len = #buffList
    for i = 1, #buffList do
        groupData = buffList[i]
        scrollData = UIScrollData.GetData(this.buffItemTemplate, "CrisisContract3SimpleBuffItem", 386, 52, groupData)
        table.insert(scrollDatas, scrollData)
    end

    this.buffScrollView:Clear(false)
    this.buffScrollView:SetPadding(0, 0, 0, 0)
    this.buffScrollView:SetParams(410, 192)
    this.buffScrollView:SetData(scrollDatas, true)
    local isEmpty = #buffList == 0
    this.vm.data.buffIsEmpty = isEmpty
end

this.SetDungeonRewardList = function()
    local creditList = this.curChooseDungeonPlotCfg.Credit
    local list = {}
    table.insert(list, this.GetDungeonRewardListDataItem(this.curChooseDungeonPlotCfg.CreditReward1, creditList[1]))
    table.insert(list, this.GetDungeonRewardListDataItem(this.curChooseDungeonPlotCfg.CreditReward2, creditList[2]))
    table.insert(list, this.GetDungeonRewardListDataItem(this.curChooseDungeonPlotCfg.CreditReward3, creditList[3]))
    this.rewardListView:SetData(list)
end

this.GetDungeonRewardListDataItem = function(rewardData, credit)
    local item = {
        key = string.format("%s_%s", this.curChooseDungeonPlotId, credit),
        credit = credit,
        rewardItems = rewardData,
        onClick = this.OnClickDungeonReward,
    }
    item.isFinished = CrisisContract3Mgr.CheckDungeonRewardIsDown(item.key)
    item.isCanGet = not item.isFinished and this.curScore >= credit
    local itemData = UIListData.GetData(this.rewardItemTemplate, "CrisisContract3RewardItem", item)
    return itemData
end

this.OnClickDungeonReward = function(item, worldPos)
    if item.isCanGet then
        CrisisContract3Mgr.GetRewards({ item.key }, this.GetRewardsResponse)
        return
    end

    local localPos = LuaMgr.World2Local(worldPos, this.uiRect)
    this.rewardPreviewRect.anchoredPosition = Vector2(localPos.x, localPos.y + 30)
    local rewardItemList = this.GetRewardItemList(item.rewardItems)
    this.vm.data.rewardTipsList = rewardItemList
    this.vm.data.showRewardTips = true
end

this.GetRewardsResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        local reward = json.encode(data.result);
        LuaMgr.ShowItemRewared(reward);
        this.SetDungeonRewardList()
        this.UpdateRed()
        this.seriesScrollView:Refresh()
    end
end

this.GetRewardItemList = function(rewards)
    local tempRewardLis = {}
    for i = 1, #rewards do
        local itemRare = ConfigMgr.Config.itemMap[rewards[i].id].rare
        local rewardItem = {
            id = rewards[i].id,
            count = LuaMgr.NumFormat(rewards[i].count),
            isCount = true,
            rare = ActivityMgr.GetRareSprite(itemRare),
            rareInt = itemRare,
            icon = ActivityMgr.GetItemTexture(rewards[i].id),
            scale = Vector3.one,
            sizeDelta = Vector2(128, 128),
            isClick = true }
        table.insert(tempRewardLis, rewardItem)
    end
    table.sort(tempRewardLis, function(a, b)
        return a.rareInt < b.rareInt
    end)
    return tempRewardLis
end

this.GetCurChooseDungeonPlotId = function()
    return this.curChooseDungeonPlotId
end

this.AddTimer = function(plotId, data)
    this.dungeonTimerList[plotId] = data
end

this.SetLeftTime = function()
    this.leftTime = this.activityData.expireTime - LuaMgr.Timestamp();
    LuaMgr.AddTimer(TimerConst.CrisisContract3Timer, this.UpdateLeftTimer, 1, -1, true)
end

this.UpdateLeftTimer = function()
    if this.leftTime <= 0 then
        LuaMgr.HidePanel(UIName.CrisisContract3LevelViewModel)
        return
    end

    this.vm.data.leftTimeStr = CrisisContract3Mgr.GetLeftTimeStr(this.leftTime)
    this.leftTime = this.leftTime - 1

    for k, timerData in pairs(this.dungeonTimerList) do
        if timerData.tips ~= nil then
            if timerData.leftTime <= 0 then
                this.dungeonTimerList = {}
                this.RefreshData()
                break
            end
            timerData.tips.text = string.format(LuaMgr.GetLangText("CrisisContract3LevelViewModel_0"), CrisisContract3Mgr.GetLeftTimeStr(timerData.leftTime))
            timerData.leftTime = timerData.leftTime - 1
        end
    end
end

this.UpdateRed = function()
    for i, v in ipairs(this.dungeonList) do
        RedMgr.Singleton:UpdateClientRedData(v.redId, CrisisContract3Mgr.CheckDungeonRewardRedByPlotId(v.plotId) and 1 or 0);
    end
    HeroRedDataHelper.SetCrisisContract3Red()
end

return vm({
    data = data,
    command = command,
    hook = hook
})