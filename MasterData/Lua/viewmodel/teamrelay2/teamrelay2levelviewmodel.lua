require("Tools/UITool")
require("ViewModel/TeamRelay2/TeamRelay2LevelItem")
require("ViewModel/TeamRelay2/TeamRelay2TeamInfoItem")
require("ViewModel/TeamRelay2/TeamRelay2BuffItem")

local PageStatus = {
    Preparing = 1,
    Progress = 2,
}

local objs = {
    buffContentTr_1 = { path = "root/Middle/Group/BuffGroup_1/Scroll View/Viewport/Content", type = UITool.Transform },
    buffContentTr_2 = { path = "root/Middle/Group/BuffGroup_2/Scroll View/Viewport/Content", type = UITool.Transform },
    buffItemTemplate = { path = "template/BuffItem", type = UITool.GameObject },
    levelScrollViewGo = { path = "root/Middle/Group/LevelList/LevelScrollView", type = UITool.GameObject },
    levelItemTemplate = { path = "template/LevelItem", type = UITool.GameObject },
    rewardItemTemplate = { path = "template/RewardItem", type = UITool.GameObject },
    levelInfoGo = { path = "root/Middle/Group/LevelInfo/LevelItem", type = UITool.GameObject },
    teamInfoGo_1 = { path = "root/Middle/Group/LevelInfo/TeamList/TeamInfo_1", type = UITool.GameObject },
    teamInfoGo_2 = { path = "root/Middle/Group/LevelInfo/TeamList/TeamInfo_2", type = UITool.GameObject },
    teamInfoGo_3 = { path = "root/Middle/Group/LevelInfo/TeamList/TeamInfo_3", type = UITool.GameObject },
}
local this = {
    vm = nil,
    pageStatus = PageStatus.Preparing,
    curPlotId = "",
    curPlotCfg = nil,
curSelectLevelId = 0,
curChallengeLevelId = 0,
curChallengeStep = 1,
    curActivityDungeonId = "",

    buffDataList_1 = {},
    buffListView_1 = nil,
    buffDataList_2 = {},
    buffListView_2 = nil,
    buffCoroutine = nil,

    levelDataList = {},
    levelScrollView = nil,
    levelCoroutine = nil,

    levelInfoItem = nil,
    teamInfoItems = {}
}

local data = {
    plotIndexImg = DefaultSprite,
    plotNameImg = DefaultSprite,
    plotHightestScore = "",
    leftCountStr = "",

    showPage_1 = false,
    showPage_2 = false,
}

local command = {
    recordCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.plotData == nil or IsNull(this.plotData.Records) or TableIsNull(this.plotData.Records) then

            end
            LuaMgr.ShowLuaPanel(UIName.TeamRelay2RecordPopup, this.curPlotId);
        end
    },
    delegateCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if TeamRelay2Mgr.GetPlotHighestScore(this.curPlotId) == 0 then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("29653"))
                return
            end
            if not TeamRelay2Mgr.CheckPlotIsCanDelegate(this.curPlotId) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("29672"))
                return
            end
            if this.CheckLeftCount() then
                LuaMgr.ShowLuaPanel(UIName.TeamRelay2DelegatePopup, this.curPlotId);
            end
        end
    },
    simulationCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.TeamRelay2TipsPopup, 1, function()
                TeamRelay2Mgr.StartEndTeamRelay(2, this.curPlotId, this.curSelectLevelId, this.RefreshData)
            end)
        end
    },
    startCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.CheckLeftCount() then
                LuaMgr.ShowLuaPanel(UIName.TeamRelay2TipsPopup, 2, function()
                    TeamRelay2Mgr.StartEndTeamRelay(0, this.curPlotId, this.curSelectLevelId, this.RefreshData)
                end)
            end
        end
    },
    continueCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            ActivityBattlePrepareMgr.SetMembers(ActivityKey.TeamRelay2, this.curActivityDungeonId)
            LuaMgr.ShowLuaPanel(UIName.ActivityBattlePrepareViewModel, ActivityKey.TeamRelay2, this.curPlotId, this.curSelectLevelId, this.curActivityDungeonId)
        end
    },
    finishCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.TeamRelay2TipsPopup, 3, function()
                TeamRelay2Mgr.StartEndTeamRelay(1, this.curPlotId, this.curSelectLevelId, this.RefreshData)
            end)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        UITool.Parse(vm.behaviour, this, objs);
        this.levelScrollView = UIScrollView.New(this.levelScrollViewGo)
        this.buffListView_1 = UIListView.New(this.buffContentTr_1)
        this.buffListView_2 = UIListView.New(this.buffContentTr_2)
        this.levelInfoItem = TeamRelay2LevelItem.New(this.levelInfoGo)
        this.teamInfoItems = {}
        table.insert(this.teamInfoItems, TeamRelay2TeamInfoItem.New(this.teamInfoGo_1))
        table.insert(this.teamInfoItems, TeamRelay2TeamInfoItem.New(this.teamInfoGo_2))
        table.insert(this.teamInfoItems, TeamRelay2TeamInfoItem.New(this.teamInfoGo_3))
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
        if this.buffCoroutine ~= nil then
            coroutine_runner.stop(this.buffCoroutine)
        end
        if this.levelCoroutine ~= nil then
            coroutine_runner.stop(this.levelCoroutine)
        end
        this.levelScrollView:Clear(true)
        this.buffListView_1:Clear()
        this.buffListView_2:Clear()
        this.levelInfoItem:Clear()
        for i, v in ipairs(this.teamInfoItems) do
            v:Clear()
        end
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("TeamRelay2LevelItem")
        UIListView.ClearItem("TeamRelay2BuffItem")
        this.levelInfoItem:Destroy()
        for i, v in ipairs(this.teamInfoItems) do
            v:Destroy()
        end
        this.teamInfoItems = {}
        this = nil
    end
}

this.InitParameter = function()
    this.curPlotId = this.vm.behaviour.Params[0]
    this.curPlotCfg = TeamRelay2Mgr.GetPlotCfg(this.curPlotId)
    this.vm.data.plotIndexImg = LuaMgr.GetSprite("TeamRelay2", TeamRelay2Mgr.plotIndexSprite[this.curPlotId])
    this.vm.data.plotNameImg = LuaMgr.GetSprite("TeamRelay2", TeamRelay2Mgr.plotNameSprite[this.curPlotId])
    this.SetDefaultSelectLevelId()
end

this.SetDefaultSelectLevelId = function()
    this.curChallengeLevelId = 0
    this.curSelectLevelId = this.curPlotCfg.Group[#this.curPlotCfg.Group]
    for _, v in ipairs(this.curPlotCfg.Group) do
        local status = TeamRelay2Mgr.GetLevelStatus(v)
        if status == TeamRelay2Mgr.LevelStatus.Locked or status == TeamRelay2Mgr.LevelStatus.Claimed then
            break
        else
            this.curSelectLevelId = v
        end
    end
end

this.RefreshData = function()
    this.plotData = TeamRelay2Mgr.GetPlotData(this.curPlotId)
    this.curChallengeLevelId = this.plotData ~= nil and this.plotData.DungeonGroupId or 0
    this.vm.data.plotHightestScore = string.format(LuaMgr.GetLangText("TeamRelay2LevelViewModel_0"), TeamRelay2Mgr.GetPlotHighestScore(this.curPlotId))
    local leftCount, limitCount = TeamRelay2Mgr.GetAllLeftChallengeCount()
    this.vm.data.leftCountStr = string.format(LuaMgr.GetLangText("TeamRelay2LevelViewModel_1"), leftCount, limitCount)
    this.CheckChallengeFinish()
    this.RefreshPageStatus()
    this.PlayAnim()
end

this.CheckChallengeFinish = function()
    local lastChallengePlotId = TeamRelay2Mgr.GetCurChallengePlotId()
    if not IsNullOrEmpty(lastChallengePlotId) and lastChallengePlotId == this.curPlotId and this.curChallengeLevelId == 0 then
        LuaMgr.ShowLuaPanel(UIName.TeamRelay2ChallengeResultPopup, this.curPlotId)
        TeamRelay2Mgr.SaveCurChallengePlotId("")
    end
end

this.RefreshPageStatus = function()
    this.pageStatus = this.curChallengeLevelId == 0 and PageStatus.Preparing or PageStatus.Progress
    this.vm.data.showPage_1 = this.pageStatus == PageStatus.Preparing
    this.vm.data.showPage_2 = this.pageStatus == PageStatus.Progress
    if this.pageStatus == PageStatus.Preparing then
        this.RefreshLevelScrollView()
        TeamRelay2Mgr.SaveCurChallengePlotId()
    elseif this.pageStatus == PageStatus.Progress then
        this.RefreshProgressPage()
        TeamRelay2Mgr.SaveCurChallengePlotId(this.curPlotId)
    end
    this.RefreshBuffList()
end

this.RefreshBuffList = function()
    this.buffDataList_1 = {}
    this.buffDataList_2 = {}
    local buffIdMap = {}
    if this.pageStatus == PageStatus.Preparing then
        local levelCfg = TeamRelay2Mgr.GetLevelCfg(this.curSelectLevelId)
        for _, v in ipairs(levelCfg.DungeonGroupId) do
            local dungeonCfg = TeamRelay2Mgr.GetDungeonCfg(v)
            for _, buffId in ipairs(dungeonCfg.BuffGroup) do
                buffIdMap[buffId] = true
            end
        end
    elseif this.pageStatus == PageStatus.Progress then
        local levelCfg = TeamRelay2Mgr.GetLevelCfg(this.curChallengeLevelId)
        local dungeonCfg = TeamRelay2Mgr.GetDungeonCfg(levelCfg.DungeonGroupId[this.curChallengeStep])
        if dungeonCfg ~= nil then
            for _, buffId in ipairs(dungeonCfg.BuffGroup) do
                buffIdMap[buffId] = true
            end
        end
    end
    for k, v in pairs(buffIdMap) do
        local buffCfg = TeamRelay2Mgr.GetBuffDescCfg(k)
        local buffData = {
            buffDescId = k,
            icon = LuaMgr.GetSprite("BuffIcon", buffCfg.BuffIcon),
            name = LuaMgr.GetLangText(buffCfg.BuffNameLan),
            iconType = 1
        }
        local buffType = IsNullOrEmpty(buffCfg.IconType) and 0 or tonumber(buffCfg.IconType)
        if buffType == 0 then
            table.insert(this.buffDataList_1, buffData)
        elseif buffType == 1 then
            table.insert(this.buffDataList_2, buffData)
        end
    end
    this.SetBuffListView(this.buffListView_1, this.buffDataList_1)
    this.SetBuffListView(this.buffListView_2, this.buffDataList_2)
end

this.SetBuffListView = function(listView, dataList)
    listView:Clear();
    local listData, listDataList = {}, {}
    for _, v in ipairs(dataList) do
        listData = UIListData.GetData(this.buffItemTemplate, "TeamRelay2BuffItem", v);
        table.insert(listDataList, listData);
    end
    listView:SetData(listDataList);
end

this.RefreshLevelScrollView = function()
    this.levelDataList = {}
    local moveToIndex = 0
    for i, levelId in ipairs(this.curPlotCfg.Group) do
        local levelCfg = TeamRelay2Mgr.GetLevelCfg(levelId)
        local levelData = {
            levelId = levelId,
            desc = LuaMgr.GetLangText(levelCfg.DiffDescLan),
            recommendLevel = this.GetRecommendLevelStr(levelCfg),
            rewards = this.GetRewardList(levelCfg.Reward),
            status = TeamRelay2Mgr.GetLevelStatus(levelId),
            animBool = false,
            rewardTemplate = this.rewardItemTemplate,
            onClickCallBack = this.OnClickLevelTaskItem,
            isSelected = levelId == this.curSelectLevelId,
        }
        table.insert(this.levelDataList, levelData)
    end
    table.sort(this.levelDataList, function(a, b)
        if a.status == b.status then
            return a.levelId < b.levelId
        end
        return a.status < b.status
    end)
    local scrollData, scrollDataList = {}, {}
    for i, v in ipairs(this.levelDataList) do
        local groupData = v
        scrollData = UIScrollData.GetData(this.levelItemTemplate, "TeamRelay2LevelItem", 645, 125, groupData)
        table.insert(scrollDataList, scrollData)

        if v.status == TeamRelay2Mgr.LevelStatus.NotCompleted then
            moveToIndex = i
        end
    end

    this.levelScrollView:Clear(false)
    this.levelScrollView:SetParams(645, 416)
    this.levelScrollView:SetPadding(0, 0, 0, 0)
    this.levelScrollView:SetData(scrollDataList, true)
    this.levelScrollView:MoveToIndex(moveToIndex)
end

this.RefreshProgressPage = function()
    this.curSelectLevelId = this.curChallengeLevelId
    this.curChallengeStep = 1
    if not TableIsNull(this.plotData.Teams) then
        for i = 1, 3 do
            if not TableIsNull(this.plotData.Teams[tostring(i)]) then
                this.curChallengeStep = i + 1
            end
        end
    end
    if this.curChallengeStep > 3 then
        this.curChallengeStep = 3
    end
    local levelCfg = TeamRelay2Mgr.GetLevelCfg(this.curSelectLevelId)
    this.curActivityDungeonId = levelCfg.DungeonGroupId[this.curChallengeStep]
    this.SetLevelInfoItem()
    this.SetTeamInfoList()
end

this.SetLevelInfoItem = function()
    local levelCfg = TeamRelay2Mgr.GetLevelCfg(this.curChallengeLevelId)
    local levelData = {
        levelId = this.curChallengeLevelId,
        desc = LuaMgr.GetLangText(levelCfg.DiffDescLan),
        recommendLevel = this.GetRecommendLevelStr(levelCfg),
        rewards = this.GetRewardList(levelCfg.Reward),
        status = TeamRelay2Mgr.LevelStatus.NotCompleted,
        animBool = false,
        rewardTemplate = this.rewardItemTemplate,
        isSelected = false
    }
    this.levelInfoItem:SetData({ data = levelData })
end

this.SetTeamInfoList = function()
    for i, v in ipairs(this.teamInfoItems) do
        local teamData = {
            name = string.format(LuaMgr.GetLangText("TeamRelay2LevelViewModel_2"), NumTool.GetMaxNum(i)),
            value = LuaMgr.GetLangText("TeamRelay2LevelViewModel_3"),
            isSelected = false,
            animBool = false,
        }
        if i < this.curChallengeStep then
            teamData.value = this.plotData.Teams[tostring(i)].Score
        elseif i == this.curChallengeStep then
            teamData.value = LuaMgr.GetLangText("TeamRelay2LevelViewModel_4")
            teamData.isSelected = true
        end
        v:SetData(teamData)
    end
end

this.PlayAnim = function()














    if this.levelCoroutine ~= nil then
        coroutine_runner.stop(this.levelCoroutine)
    end
    if this.pageStatus == PageStatus.Preparing then
        this.levelCoroutine = coroutine_runner.start(function()
            coroutine_runner.wait(0.1)
            local len = #this.levelScrollView.dataList
            for i = 1, len do
                this.levelScrollView.dataList[i].data.animBool = true
                if this.levelScrollView.itemMap[i] ~= nil then
                    SetActive(this.levelScrollView.itemMap[i].animGo, true)
                    coroutine_runner.wait(0.1)
                end
            end
        end)
    elseif this.pageStatus == PageStatus.Progress then
        this.levelCoroutine = coroutine_runner.start(function()
            coroutine_runner.wait(0.1)
            SetActive(this.levelInfoItem.animGo, true)
            for i, v in ipairs(this.teamInfoItems) do
                coroutine_runner.wait(0.1)
                v.data.animBool = true
                SetActive(v.animGo, true)
            end
        end)
    end
end

this.CheckLeftCount = function()
    local leftCount, limitCount = TeamRelay2Mgr.GetAllLeftChallengeCount()
    if leftCount == 0 then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("29654"))
        return false
    end
    return true
end

this.GetRewardList = function(award)
    local list = {}
    if not IsNull(award) and #award > 0 then
        for i = 1, #award do
            local rewardItem = ConfigMgr.Config.itemMap[award[i].id];
            local goods = {
                id = rewardItem.id,
                rareSort = rewardItem.rare,
                rare = ActivityMgr.GetRareSprite(rewardItem.rare),
                icon = ActivityMgr.GetItemTexture(rewardItem.id),
                count = tostring(award[i].count),
                isClaimed = false
            }
            table.insert(list, goods)
        end
    end
    table.sort(list, function(a, b)
        return a.rareSort > b.rareSort;
    end);
    return list
end

this.GetRecommendLevelStr = function(levelCfg)
    local totalLevel = 0
    for i, v in ipairs(levelCfg.DungeonGroupId) do
        local teamCfg = TeamRelay2Mgr.GetDungeonCfg(v)
        local dungeonCfg = ConfigMgr.Config.dungeonMap[teamCfg.DungeonId]
        if dungeonCfg ~= nil then
            totalLevel = totalLevel + dungeonCfg.levelShow
        end
    end
    return math.floor(totalLevel / 3)
end


this.OnClickLevelTaskItem = function(levelId)
    if this.curSelectLevelId == levelId then
        return
    end
    this.curSelectLevelId = levelId

    for i = 1, #this.levelScrollView.dataList do
        this.levelScrollView.dataList[i].data.isSelected = this.levelScrollView.dataList[i].data.levelId == this.curSelectLevelId
        if this.levelScrollView.itemMap[i] ~= nil then
            this.levelScrollView.itemMap[i]:RefreshSelectStatus()
        end
    end

    this.RefreshBuffList()
end

this.OnBack = function()
    LuaMgr.Back()
end

return vm({
    data = data,
    command = command,
    hook = hook
})