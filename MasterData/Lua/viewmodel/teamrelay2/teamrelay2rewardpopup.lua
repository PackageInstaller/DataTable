require("Tools/UITool")
require("ViewModel/TeamRelay2/TeamRelay2TaskItem")

local objs = {
    levelTabOffGo = { path = "root/Middle/Group/SwitchTab/LevelTabBtn/Off", type = UITool.GameObject },
    scoreTabOffGo = { path = "root/Middle/Group/SwitchTab/ScoreTabBtn/Off", type = UITool.GameObject },
    levelScrollViewGo = { path = "root/Middle/Group/ScrollView/LevelScrollView", type = UITool.GameObject },
    scoreScrollViewGo = { path = "root/Middle/Group/ScrollView/TaskScrollView", type = UITool.GameObject },
    taskItemTemplate = { path = "template/TaskItem", type = UITool.GameObject },
    rewardTemplate = { path = "template/RewardItem", type = UITool.GameObject },
}

local this = {
    vm = nil,
    curTab = 1,
    coroutine = nil,

    levelDataList = {},
    levelScrollView = nil,
    levelTemplate = nil,
    canClaimLevelIds = {},

    scoreDataList = {},
    levelScrollView = nil,
    levelTemplate = nil,
    canClaimTaskIds = {},
};

local data = {}

local command = {
    closeBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.TeamRelay2RewardPopup)
        end
    },
    levelTabBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickLevelTabBtn()
        end
    },
    scoreTabBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickScoreTabBtn()
        end
    },
    getAllBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickGetAllBtn()
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        UITool.Parse(vm.behaviour, this, objs);
        RedMgr.Singleton:RegisterViewModel(UIName.TeamRelay2RewardPopup)
        this.levelScrollView = UIScrollView.New(this.levelScrollViewGo)
        this.scoreScrollView = UIScrollView.New(this.scoreScrollViewGo)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.InitParameter()
        this.RefreshData(true)
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        if this.coroutine ~= nil then
            coroutine_runner.stop(this.coroutine)
        end
        this.levelScrollView:Clear()
        this.scoreScrollView:Clear()
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("TeamRelay2TaskItem")
        this = nil;
    end
}

this.InitParameter = function()
    this.curTab = 1
end

this.RefreshData = function(playAnim)
    SetActive(this.levelScrollViewGo, this.curTab == 1)
    SetActive(this.levelTabOffGo, this.curTab == 2)
    SetActive(this.scoreScrollViewGo, this.curTab == 2)
    SetActive(this.scoreTabOffGo, this.curTab == 1)
    if this.curTab == 1 then
        this.SetLevelScoreView(playAnim)
    else
        this.SetScoreTaskList(playAnim)
    end
    if playAnim then
        this.PlayScrollViewAnim()
    end
end


this.SetLevelScoreView = function(playAnim)
    this.levelDataList = {}
    this.canClaimLevelIds = {}
    local teamRelayMap = ConfigMgr.Config.TeamRelayMap
    for k, plotCfg in pairs(teamRelayMap) do
        if plotCfg.ActivityGroup == TeamRelay2Mgr.activityGroupId then
            for _, levelId in ipairs(plotCfg.Group) do
                local levelCfg = TeamRelay2Mgr.GetLevelCfg(levelId)
                if not IsNull(levelCfg.Reward) then
                    local levelData = {
                        id = levelId,
                        desc = LuaMgr.GetLangText(levelCfg.DiffDescLan),
                        rewards = this.GetRewardList(levelCfg.Reward),
                        status = TeamRelay2Mgr.GetLevelStatus(levelId),
                        progressStr = LuaMgr.GetLangText("TeamRelay2RewardPopup_0"),
                        animBool = not playAnim,
                        rewardTemplate = this.rewardTemplate,
                        onClickCallBack = this.OnClickLevelTaskItem,
                    }
                    if levelData.status ~= TeamRelay2Mgr.LevelStatus.Locked then
                        table.insert(this.levelDataList, levelData)
                        if levelData.status == TeamRelay2Mgr.LevelStatus.CanClaim then
                            table.insert(this.canClaimLevelIds, levelId)
                        end
                    end
                end
            end
        end
    end
    table.sort(this.levelDataList, function(a, b)
        if a.status == b.status then
            return a.id < b.id
        end
        return a.status < b.status
    end)

    local scrollData, scrollDataList = {}, {}
    for i, v in ipairs(this.levelDataList) do
        local groupData = v
        scrollData = UIScrollData.GetData(this.taskItemTemplate, "TeamRelay2TaskItem", 891, 99, groupData)
        table.insert(scrollDataList, scrollData)
    end

    this.levelScrollView:Clear(false)
    this.levelScrollView:SetParams(856, 275)
    this.levelScrollView:SetPadding(0, 0, -20, 0)
    this.levelScrollView:SetData(scrollDataList, true)
end


this.SetScoreTaskList = function(playAnim)
    this.scoreDataList = {}
    this.canClaimTaskIds = {}
    local questData;
    local questConfig;
    local questEvent = ConfigMgr.Config.questEvent;
    local questEvents = DataExHelper.Check_DataExByGroupId(TeamRelay2Mgr.activityGroupId);
    local tempList = {}
    local len = #questEvents;
    for i = 1, len do
        questData = questEvents[i];
        questConfig = questEvent[questData.id];
        local state = DataExHelper.Check_RewardState(questConfig.id)
        local taskData = {
            id = questConfig.id,
            desc = LuaMgr.GetLangText(questConfig.remarksLan),
            rewards = this.GetRewardList(questConfig.showReward),
            status = this.GetStatusByQuestEventState(state),
            progressStr = string.format("%d/%d", questData.progress, questConfig.progress),
            animBool = not playAnim,
            rewardTemplate = this.rewardTemplate,
            onClickCallBack = this.OnClickScoreTaskItem,
        }
        table.insert(this.scoreDataList, taskData)
        if taskData.status == TeamRelay2Mgr.LevelStatus.CanClaim then
            table.insert(this.canClaimTaskIds, taskData.id)
        end
    end

    table.sort(this.scoreDataList, function(a, b)
        if a.status == b.status then
            return tonumber(a.id) < tonumber(b.id)
        end
        return a.status < b.status
    end)

    local scrollData, scrollDataList = {}, {}
    for i, v in ipairs(this.scoreDataList) do
        local groupData = v
        scrollData = UIScrollData.GetData(this.taskItemTemplate, "TeamRelay2TaskItem", 891, 99, groupData)
        table.insert(scrollDataList, scrollData)
    end

    this.scoreScrollView:Clear(false)
    this.scoreScrollView:SetParams(856, 275)
    this.scoreScrollView:SetPadding(0, 0, -20, 0)
    this.scoreScrollView:SetData(scrollDataList, true)
end

this.PlayScrollViewAnim = function()
    if this.coroutine ~= nil then
        coroutine_runner.stop(this.coroutine)
    end
    this.coroutine = coroutine_runner.start(function()
        coroutine_runner.wait(0.1)
        local scrollView = this.curTab == 1 and this.levelScrollView or this.scoreScrollView
        for i = 1, #scrollView.dataList do
            scrollView.dataList[i].data.animBool = true
            if scrollView.itemMap[i] ~= nil then
                SetActive(scrollView.itemMap[i].animGo, true)
            end
            coroutine_runner.wait(0.1)
        end
    end)
end

this.GetRewardList = function(award)
    local list = {}
    if award ~= nil and #award > 0 then
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

this.GetStatusByQuestEventState = function(state)
    local status = TeamRelay2Mgr.LevelStatus.CanClaim
    if state == 0 then
        status = TeamRelay2Mgr.LevelStatus.Locked
    elseif state == 1 then
        status = TeamRelay2Mgr.LevelStatus.NotCompleted
    elseif state == 2 then
        status = TeamRelay2Mgr.LevelStatus.CanClaim
    elseif state == 3 then
        status = TeamRelay2Mgr.LevelStatus.Claimed
    end
    return status
end


this.OnClickLevelTabBtn = function()
    this.curTab = 1
    this.RefreshData(false)
end

this.OnClickScoreTabBtn = function()
    this.curTab = 2
    this.RefreshData(false)
end

this.OnClickGetAllBtn = function()
    if this.curTab == 1 then
        if TableIsNull(this.canClaimLevelIds) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("TeamRelay2RewardPopup_1"))
            return
        end
        TeamRelay2Mgr.GetRewards(this.canClaimLevelIds, function()
            this.RefreshData(false)
            LuaMgr.InvokeUIEventListeners(UIEventConst.TeamRelayRefresh)
        end)
    elseif this.curTab == 2 then
        if TableIsNull(this.canClaimTaskIds) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("TeamRelay2RewardPopup_2"))
            return
        end
        DataExHelper.EX_GetAwards(this.canClaimTaskIds, function()
            this.RefreshData(false)
            LuaMgr.InvokeUIEventListeners(UIEventConst.TeamRelayRefresh)
        end)
    end
end

this.OnClickLevelTaskItem = function(levelId)
    TeamRelay2Mgr.GetRewards({ levelId }, function()
        this.RefreshData(false)
        LuaMgr.InvokeUIEventListeners(UIEventConst.TeamRelayRefresh)
    end)
end

this.OnClickScoreTaskItem = function(questId)
    DataExHelper.EX_GetAward(questId, function()
        this.RefreshData(false)
        LuaMgr.InvokeUIEventListeners(UIEventConst.TeamRelayRefresh)
    end)
end

return vm({
    data = data,
    command = command,
    hook = hook
})