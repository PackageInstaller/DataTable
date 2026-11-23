require("ViewModel/CrisisContract2/CrisisContract2SeriesItem")
require("ViewModel/CrisisContract2/CrisisContract2DungeonItem")
require("ViewModel/CrisisContract2/CrisisContract2RewardItem")
require("ViewModel/CrisisContract2/CrisisContract2SimpleEnemyBuffItem")

local this = {
    vm = nil,
    activityData = nil,
    leftTime = 0,
    dungeonTimerList = {},

    dungeonList = {},
    seriesScrollView = nil,
    seriesItemTemplate = nil,

    enemyBuffScrollView = nil,
    buffItemTemplate = nil,
    curShowBuffType = 0,

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
    curDungeonMaxScore = "",
    curDungeonMaxScoreShow = false,
    curDungeonNoScore = false,
    buffIsEmpty = false,
    buffIsNotEmpty = false,
    selfBuffList = {
        { icon = DefaultSprite, name = "" },
    },
    showEnemyBuffList = false,
    showSelfBuffList = false,
    rewardTipsList = { {} },
    showRewardTips = false,
    showNoBattleCountTips = false,
}

local command = {
    taskBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.CrisisContract2TaskPopup, this.UpdateRed);
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
    enemyBuffCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SetCurShowBuffList(1)
        end
    },
    selfBuffCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SetCurShowBuffList(2)
        end
    },
    startBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local leftTimes = ConfigMgr.Config.constants.ContractLimit - DataMgr.Player.contractPlotCount
            if leftTimes <= 0 then
                this.vm.data.showNoBattleCountTips = true
            else
                LuaMgr.ShowLuaPanel(UIName.CrisisContract2BuffViewModel, this.curChooseDungeonPlotId);
            end
        end
    },
    noBattleConfirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.showNoBattleCountTips = false
            LuaMgr.ShowLuaPanel(UIName.CrisisContract2BuffViewModel, this.curChooseDungeonPlotId);
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
        RedMgr.Singleton:RegisterViewModel(UIName.CrisisContract2LevelViewModel);
        this.seriesScrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/ScrollView").gameObject)
        this.seriesItemTemplate = vm.behaviour.transform:Find("template/SeriesItem").gameObject

        this.enemyBuffScrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/UI/DungeonInfo/Buff/NoEmpty/BuffList/EnemyScrollView").gameObject)
        this.buffItemTemplate = vm.behaviour.transform:Find("template/EnemyBuffItem").gameObject

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
        LuaMgr.RemoveTimer(TimerConst.CrisisContract2Timer)
    end,
    before_destroy = function(vm)
        this = nil
        UIScrollView.ClearItem("CrisisContract2SeriesItem")
        UIScrollView.ClearItem("CrisisContract2SimpleEnemyBuffItem")
        UIListView.ClearItem("CrisisContract2RewardItem")
        RedMgr.Singleton:RemoveViewModel(UIName.CrisisContract2LevelViewModel);
    end,
}
this.InitData = function()
    this.dungeonTimerList = {}
    this.curChooseDungeonPlotId = ""
    this.curShowBuffType = 0
    this.InitDungeonListData()
    this.ShowDungeonInfo()
end

this.InitDungeonListData = function()
    this.dungeonList = {}
    local contractPlotCfgs = ConfigMgr.Config.ContractPlots
    for i, v in ipairs(contractPlotCfgs) do
        local dungeonItem = {
            plotId = v.Id,
            select = false,
            unlockTime = CrisisContract2Mgr.GetDungeonUnlockTime(v.Id),
            addTimer = this.AddTimer,
            getChoosePlotId = this.GetCurChooseDungeonPlotId,
            callBack = this.OnClickDungeon,
            redId = "16831_" .. v.Id,
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
    this.activityData = DataExHelper.GetDataExByTag(ActivityKey.crisiscontract2)
    if this.activityData == nil then

        LuaMgr.HidePanel(UIName.CrisisContract2LevelViewModel)
        return
    end
    this.SetPageInfo()
    this.SetDungeonList()
end

this.SetPageInfo = function()
    this.vm.data.totalScore = CrisisContract2Mgr.GetTotalScore()
    local leftTimes = ConfigMgr.Config.constants.ContractLimit - DataMgr.Player.contractPlotCount
    this.vm.data.leftTimesStr = string.format("<color=#FFFFFF><size=26>%d</size></color>/%d", leftTimes, ConfigMgr.Config.constants.ContractLimit)
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
        scrollData = UIScrollData.GetData(this.seriesItemTemplate, "CrisisContract2SeriesItem", 337, 720, groupData)
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
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(ConfigMgr.LangGlobal("25003"), CrisisContract2Mgr.GetLeftTimeStr(leftTime)))
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
        return
    end

    this.curChooseDungeonPlotCfg = CrisisContract2Mgr.GetPlotConfig(this.curChooseDungeonPlotId)
    this.vm.data.curDungeonName = LuaMgr.GetLangText(this.curChooseDungeonPlotCfg.NameLan)
    this.curScore = CrisisContract2Mgr.GetCurPlotScore(this.curChooseDungeonPlotId)
    this.vm.data.curDungeonMaxScore = this.curScore
    this.vm.data.curDungeonMaxScoreShow = this.curScore > 0
    this.vm.data.curDungeonNoScore = this.curScore == 0
    this.curShowBuffType = 0
    this.SetCurShowBuffList(1)
    this.SetDungeonRewardList()
    this.vm.data.showDungeonInfo = true
    this.vm.data.showRewardTips = false
end

this.SetCurShowBuffList = function(type)
    if this.curShowBuffType == type then
        return
    end
    this.curShowBuffType = type
    this.vm.data.showEnemyBuffList = this.curShowBuffType == 1
    this.vm.data.showSelfBuffList = this.curShowBuffType == 2

    local selfBuff, enemyBuff = CrisisContract2Mgr.GetChooseBuffListByPlotId(this.curChooseDungeonPlotId)
    if this.curShowBuffType == 1 then
        local scrollData, scrollDatas = {}, {}
        local groupData = nil
        local len = #enemyBuff
        for i = 1, #enemyBuff do
            groupData = enemyBuff[i]
            scrollData = UIScrollData.GetData(this.buffItemTemplate, "CrisisContract2SimpleEnemyBuffItem", 386, 52, groupData)
            table.insert(scrollDatas, scrollData)
        end

        this.enemyBuffScrollView:Clear(false)
        this.enemyBuffScrollView:SetPadding(0, 0, 0, 0)
        this.enemyBuffScrollView:SetParams(410, 150)
        this.enemyBuffScrollView:SetData(scrollDatas, true)
    elseif this.curShowBuffType == 2 then
        local tempList = {}
        for i, v in ipairs(selfBuff) do
            table.insert(tempList, { icon = v.BuffInfo.Icon, name = v.BuffInfo.Name })
        end
        this.vm.data.selfBuffList = tempList
    end

    local isEmpty = #selfBuff == 0 and #enemyBuff == 0
    this.vm.data.buffIsEmpty = isEmpty
    this.vm.data.buffIsNotEmpty = not isEmpty
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
    item.isFinished = CrisisContract2Mgr.CheckDungeonRewardIsDown(item.key)
    item.isCanGet = not item.isFinished and this.curScore >= credit
    local itemData = UIListData.GetData(this.rewardItemTemplate, "CrisisContract2RewardItem", item)
    return itemData
end

this.OnClickDungeonReward = function(item, worldPos)
    if item.isCanGet then
        CrisisContract2Mgr.GetRewards({ item.key }, this.GetRewardsResponse)
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
    LuaMgr.AddTimer(TimerConst.CrisisContract2Timer, this.UpdateLeftTimer, 1, -1, true)
end

this.UpdateLeftTimer = function()
    if this.leftTime <= 0 then
        LuaMgr.HidePanel(UIName.CrisisContract2LevelViewModel)
        return
    end

    this.vm.data.leftTimeStr = CrisisContract2Mgr.GetLeftTimeStr(this.leftTime)
    this.leftTime = this.leftTime - 1

    for k, timerData in pairs(this.dungeonTimerList) do
        if timerData.tips ~= nil then
            if timerData.leftTime <= 0 then
                this.dungeonTimerList = {}
                this.RefreshData()
                break
            end
            timerData.tips.text = string.format(LuaMgr.GetLangText("CrisisContract2LevelViewModel_0"), CrisisContract2Mgr.GetLeftTimeStr(timerData.leftTime))
            timerData.leftTime = timerData.leftTime - 1
        end
    end
end

this.UpdateRed = function()
    for i, v in ipairs(this.dungeonList) do
        RedMgr.Singleton:UpdateClientRedData(v.redId, CrisisContract2Mgr.CheckDungeonRewardRedByPlotId(v.plotId) and 1 or 0);
    end
    HeroRedDataHelper.SetCrisisContract2Red()
end

return vm({
    data = data,
    command = command,
    hook = hook
})