require("ViewModel/CrisisContract4/CrisisContract4LevelItem")
require("ViewModel/CrisisContract4/CrisisContract4DungeonItem")
require("ViewModel/CrisisContract2/CrisisContract2RewardItem")
require("ViewModel/CrisisContract2/CrisisContract2SimpleEnemyBuffItem")

local this = {
    vm = nil,
    activityData = nil,
    leftTime = 0,
    nextRefreshTime = 0,

levelListView = nil,
    levelItemTemplate = nil,
dungeonItemList = {},

    enemyBuffScrollView = nil,
    buffItemTemplate = nil,
    curShowBuffType = 0,

    curScore = 0,
    rewardListView = nil,
    rewardItemTemplate = nil,
    uiRect = nil,
    rewardPreviewRect = nil,

curLevelId = "",
curDungeonId = "",
}

local data = {
    leftTimeStr = "",
    leftTimesStr = "",
    totalScore = "",
    dungeonName = "",
    dungeonRecommendLevel = "",
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
            LuaMgr.ShowLuaPanel(UIName.CrisisContract4TaskPopup, this.UpdateRed);
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
            local leftTimes = CrisisContract4Mgr.GetDailyLeftTimes()
            if leftTimes <= 0 then
                this.vm.data.showNoBattleCountTips = true
            else
                LuaMgr.ShowLuaPanel(UIName.CrisisContract4BuffViewModel, this.curDungeonId);
            end
        end
    },
    noBattleConfirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.showNoBattleCountTips = false
            LuaMgr.ShowLuaPanel(UIName.CrisisContract4BuffViewModel, this.curDungeonId);
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
        RedMgr.Singleton:RegisterViewModel(UIName.CrisisContract4LevelViewModel);
        this.levelListView = UIListView.New(vm.behaviour.transform:Find("root/Middle/LevelGroup/LevelScrollView/Viewport/Content"))
        this.levelItemTemplate = vm.behaviour.transform:Find("template/LevelItem").gameObject

        this.enemyBuffScrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/DungeonInfo/Buff/NoEmpty/BuffList/EnemyScrollView").gameObject)
        this.buffItemTemplate = vm.behaviour.transform:Find("template/EnemyBuffItem").gameObject

        local dungeonRewardContent = vm.behaviour.transform:Find("root/Middle/DungeonInfo/Reward/RewardList"):GetComponent("RectTransform");
        this.rewardItemTemplate = vm.behaviour.transform:Find("template/RewardItem").gameObject;
        this.rewardListView = UIListView.New(dungeonRewardContent)

        this.uiRect = vm.behaviour.transform:Find("root/Middle"):GetComponent("RectTransform");
        this.rewardPreviewRect = vm.behaviour.transform:Find("root/Middle/RewardPreviewTips"):GetComponent("RectTransform");
        this.InitDungeonListData()
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
        this.levelListView:Clear()
        this.enemyBuffScrollView:Clear()
        for i, v in ipairs(this.dungeonItemList) do
            v:Clear()
        end
        LuaMgr.RemoveTimer(TimerConst.CrisisContract4Timer)
        UIScrollView.ClearItem("CrisisContract2SimpleEnemyBuffItem")
    end,
    before_destroy = function(vm)
        UIListView.ClearItem("CrisisContract4LevelItem")
        for i, v in ipairs(this.dungeonItemList) do
            v:Destroy()
        end
        UIScrollView.ClearItem("CrisisContract2SimpleEnemyBuffItem")
        UIListView.ClearItem("CrisisContract2RewardItem")
        RedMgr.Singleton:RemoveViewModel(UIName.CrisisContract4LevelViewModel);
        this = nil
    end,
}
this.InitData = function()
    this.nextRefreshTime = 9999999
    this.curLevelId = ""
    this.curDungeonId = ""
    this.curShowBuffType = 0
    this.InitLevelList()
end

this.InitLevelList = function()
    local paramLevelId = "";
    local teamRelayMap = ConfigMgr.Config.TeamRelayMap
    local levelDataList = {}
    local curTime = LuaMgr.Timestamp()
    for k, v in pairs(teamRelayMap) do
        if v.ActivityGroup == CrisisContract4Mgr.activityGroupId then
            for i, levelId in ipairs(v.Group) do
                local levelCfg = CrisisContract4Mgr.GetLevelCfg(levelId)
                local itemData = {
                    levelId = levelId,
                    nameStr = LuaMgr.GetLangText(levelCfg.DiffDesc),
                    isSelected = this.vm.behaviour.Params.Length > 0 and CrisisContract4Mgr.GetPlotIdByDungeonId(tostring(this.vm.behaviour.Params[0])) == levelCfg.TeamRelayId,
                    isRed = CrisisContract4Mgr.CheckLevelDungeonsRewardRed(levelId),
                    isLock = false,
                    onClick = this.OnClickLevelItem,
                }
                if this.vm.behaviour.Params.Length > 0 and CrisisContract4Mgr.GetPlotIdByDungeonId(tostring(this.vm.behaviour.Params[0])) == levelCfg.TeamRelayId then
                    paramLevelId = levelId
                end
                local leftTime = CrisisContract4Mgr.GetLevelUnlockTime(levelId) - curTime
                if leftTime > 0 then
                    this.nextRefreshTime = math.min(this.nextRefreshTime, leftTime)
                    itemData.isLock = true
                end
                local listData = UIListData.GetData(this.levelItemTemplate, "CrisisContract4LevelItem", itemData);
                table.insert(levelDataList, listData);
            end
        end
    end
    table.sort(levelDataList, function(a, b)
        return a.data.levelId < b.data.levelId
    end)
    if IsNullOrEmpty(this.curLevelId) then
        this.curLevelId = levelDataList[1].data.levelId
    end
    this.levelListView:SetData(levelDataList);
    if not IsNullOrEmpty(paramLevelId) then
        this.OnClickLevelItem(paramLevelId)
    end
end

this.InitDungeonListData = function()
    this.dungeonItemList = {}
    for i = 1, 3 do
        local dungeonItem = CrisisContract4DungeonItem.New(this.vm.behaviour.transform:Find("root/Middle/DungeonGroup/DungeonItem" .. i).gameObject)
        dungeonItem:Init()
        table.insert(this.dungeonItemList, dungeonItem)
    end
end

this.RefreshData = function()
    this.activityData = DataExHelper.GetDataExByTag(ActivityKey.TeamRelay3)
    if this.activityData == nil then

        LuaMgr.HidePanel(UIName.CrisisContract4LevelViewModel)
        return
    end
    if IsNullOrEmpty(this.curLevelId) then
        return
    end
    this.SetPageInfo()
    this.RefreshLevelListView()
    this.RefreshDungeonList()
    this.RefreshDungeonInfo()
end

this.SetPageInfo = function()
    this.vm.data.totalScore = CrisisContract4Mgr.GetTotalMaxScore()
    local leftTimes, totalTimes = CrisisContract4Mgr.GetDailyLeftTimes()
    this.vm.data.leftTimesStr = string.format(LuaMgr.GetLangText("CrisisContract4LevelViewModel_0"), leftTimes, totalTimes)
    this.SetLeftTime()
end

this.RefreshLevelListView = function()
    for i, v in ipairs(this.levelListView.dataList) do
        this.levelListView.itemList[i]:SetSelect(v.data.levelId == this.curLevelId)
        this.levelListView.itemList[i]:SetRed(CrisisContract4Mgr.CheckLevelDungeonsRewardRed(v.data.levelId))
    end
end

this.RefreshDungeonList = function()
    if IsNullOrEmpty(this.curLevelId) then
        return
    end
    local levelCfg = CrisisContract4Mgr.GetLevelCfg(this.curLevelId)
    for i, dungeonId in ipairs(levelCfg.DungeonGroupId) do
        if IsNullOrEmpty(this.curDungeonId) then
            this.curDungeonId = dungeonId
        end
        local dungeonItemData = {
            dungeonId = dungeonId,
            isSelected = dungeonId == this.curDungeonId,
            isRed = CrisisContract4Mgr.CheckDungeonRewardRed(dungeonId),
            onClick = this.OnClickDungeon,
        }
        if this.dungeonItemList[i] ~= nil then
            this.dungeonItemList[i]:SetData(dungeonItemData)
        end
    end
end
this.RefreshDungeonInfo = function()
    if IsNullOrEmpty(this.curDungeonId) then
        return
    end

    local dungeonCfg = CrisisContract4Mgr.GetDungeonCfg(this.curDungeonId)
    local battleDungeonCfg = ConfigMgr.Config.dungeonMap[dungeonCfg.DungeonId];
    this.vm.data.dungeonName = LuaMgr.GetLangText(battleDungeonCfg.NameLan)
    this.vm.data.dungeonRecommendLevel = battleDungeonCfg.levelShow
    this.curShowBuffType = 0
    this.SetCurShowBuffList(1)
    this.SetDungeonRewardList()
    this.vm.data.showRewardTips = false
end

this.SetCurShowBuffList = function(type)
    if this.curShowBuffType == type then
        return
    end
    this.curShowBuffType = type
    this.vm.data.showEnemyBuffList = this.curShowBuffType == 1
    this.vm.data.showSelfBuffList = this.curShowBuffType == 2

    local selfBuff, enemyBuff = CrisisContract4Mgr.GetChooseBuffList(this.curDungeonId)
    if this.curShowBuffType == 1 then
        local scrollData, scrollDataList = {}, {}
        local groupData = nil
        for i, v in ipairs(enemyBuff) do
            groupData = v
            scrollData = UIScrollData.GetData(this.buffItemTemplate, "CrisisContract2SimpleEnemyBuffItem", 367, 52, groupData)
            table.insert(scrollDataList, scrollData)
        end
        this.enemyBuffScrollView:Clear(false)
        this.enemyBuffScrollView:SetPadding(0, 0, 0, 0)
        this.enemyBuffScrollView:SetParams(390.5, 150)
        this.enemyBuffScrollView:SetData(scrollDataList, true)
    elseif this.curShowBuffType == 2 then
        local tempList = {}
        for i, v in ipairs(selfBuff) do
            local buffInfo = CrisisContract4Mgr.GetBuffInfoByLevel(v.Id, v.Level)
            table.insert(tempList, { icon = buffInfo.Icon, name = buffInfo.Name })
        end
        this.vm.data.selfBuffList = tempList
    end

    local isEmpty = #selfBuff == 0 and #enemyBuff == 0
    this.vm.data.buffIsEmpty = isEmpty
    this.vm.data.buffIsNotEmpty = not isEmpty
end

this.SetDungeonRewardList = function()
    local dungeonCfg = CrisisContract4Mgr.GetDungeonCfg(this.curDungeonId)
    local rewardStatus = CrisisContract4Mgr.GetDungeonRewardStatus(this.curDungeonId)
    local highestScore = CrisisContract4Mgr.GetDungeonHighestScore(this.curDungeonId)
    local list = {}
    table.insert(list, this.GetDungeonRewardListDataItem(this.curDungeonId, dungeonCfg.Reward1, 1, rewardStatus, highestScore))
    table.insert(list, this.GetDungeonRewardListDataItem(this.curDungeonId, dungeonCfg.Reward2, 2, rewardStatus, highestScore))
    table.insert(list, this.GetDungeonRewardListDataItem(this.curDungeonId, dungeonCfg.Reward3, 3, rewardStatus, highestScore))
    this.rewardListView:SetData(list)
end

this.GetDungeonRewardListDataItem = function(dungeonId, rewardData, index, rewardStatus, highestScore)
    local creditList = ConfigMgr.Config.TeamRelayConstants.TeamRelay3Credit
    local credit = creditList[index]
    local isFinished = rewardStatus >= index
    local item = {
        dungeonId = dungeonId,
        credit = credit,
        rewardItems = rewardData,
        isFinished = isFinished,
        isCanGet = not isFinished and highestScore >= credit,
        onClick = this.OnClickDungeonReward,
    }
    local itemData = UIListData.GetData(this.rewardItemTemplate, "CrisisContract2RewardItem", item)
    return itemData
end

this.OnClickLevelItem = function(LevelId)
    if this.curLevelId == LevelId then
        return
    end

    local leftTime = CrisisContract4Mgr.GetLevelUnlockTime(LevelId) - LuaMgr.Timestamp()
    if leftTime > 0 then
        local msg = string.format(LuaMgr.GetLangText("CrisisContract2LevelViewModel_0"), CrisisContract4Mgr.GetLeftTimeStr(leftTime))
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, msg)
        return
    end

    this.curLevelId = LevelId
    this.curDungeonId = ""
    this.RefreshData()
    LuaMgr.NextFrame(function()
        for i, v in ipairs(this.dungeonItemList) do
            v:PlayAnim()
        end
    end)
end

this.OnClickDungeon = function(dungeonId)
    if this.curDungeonId == dungeonId then
        return
    end
    this.curDungeonId = dungeonId
    for i, v in ipairs(this.dungeonItemList) do
        v:SetSelect(v.data.dungeonId == this.curDungeonId)
    end
    this.RefreshDungeonInfo()
    this.levelListView:Refresh()
end

this.OnClickDungeonReward = function(item, worldPos)
    if item.isCanGet then
        CrisisContract4Mgr.GetRewards(item.dungeonId, this.GetRewardsResponse)
        return
    end

    local localPos = LuaMgr.World2Local(worldPos, this.uiRect)
    this.rewardPreviewRect.anchoredPosition = Vector2(localPos.x + 80, localPos.y + 120)
    local rewardItemList = this.GetRewardItemList(item.rewardItems)
    this.vm.data.rewardTipsList = rewardItemList
    this.vm.data.showRewardTips = true
end

this.GetRewardsResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        local reward = json.encode(data.result);
        LuaMgr.ShowItemRewared(reward);
        this.RefreshData()
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

this.SetLeftTime = function()
    this.leftTime = this.activityData.expireTime - LuaMgr.Timestamp();
    LuaMgr.RemoveTimer(TimerConst.CrisisContract4Timer)
    LuaMgr.AddTimer(TimerConst.CrisisContract4Timer, this.UpdateLeftTimer, 1, -1, true)
end

this.UpdateLeftTimer = function()
    if this.leftTime <= 0 then
        LuaMgr.HidePanel(UIName.CrisisContract4LevelViewModel)
        return
    end
    if this.nextRefreshTime < 0 then
        this.nextRefreshTime = 9999999
        this.InitLevelList()
        this.RefreshData()
        return
    end

    this.vm.data.leftTimeStr = CrisisContract4Mgr.GetLeftTimeStr(this.leftTime)
    this.leftTime = this.leftTime - 1
    this.nextRefreshTime = this.nextRefreshTime - 1
end

this.UpdateRed = function()
    HeroRedDataHelper.SetCrisisContract4Red()
end

return vm({
    data = data,
    command = command,
    hook = hook
})