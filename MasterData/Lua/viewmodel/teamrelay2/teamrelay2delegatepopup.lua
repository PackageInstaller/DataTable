require("Tools/UITool")

local objs = {
    highestScoreTxt = { path = "root/Middle/Group/HighestScore", type = UITool.Text },
    countTxt = { path = "root/Middle/Group/Count/Count/Text", type = UITool.Text },
    scorePreviewTxt = { path = "root/Middle/Group/ScorePreview", type = UITool.Text },
}

local this = {
    vm = nil,
    plotId = "",
    singleScore = 0,
    count = 0,
    maxCount = 0,
};

local data = {}

local command = {
    closeBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.TeamRelay2DelegatePopup)
        end
    },
    delCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.count = math.max(1, this.count - 1)
            this.RefreshData()
        end
    },
    addCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.count = math.min(this.maxCount, this.count + 1)
            this.RefreshData()
        end
    },
    maxCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.count = this.maxCount
            this.RefreshData()
        end
    },
    cancelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.TeamRelay2DelegatePopup)
        end
    },
    confirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            TeamRelay2Mgr.EnterLeaveDungeon(this.plotId, this.count, function(re)
                LuaMgr.HidePanel(UIName.TeamRelay2DelegatePopup)
                LuaMgr.ShowLuaPanel(UIName.TeamRelay2DelegateResultViewModel, this.singleScore, this.count)
            end)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        UITool.Parse(vm.behaviour, this, objs);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.InitParameter()
        this.RefreshData()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
    end,
    before_destroy = function(vm)
        this = nil;
    end
}

this.InitParameter = function()
    this.plotId = this.vm.behaviour.Params[0]
    this.singleScore = TeamRelay2Mgr.GetPlotHighestScore(this.plotId)
    this.count = 1
    local leftCount, limitCount = TeamRelay2Mgr.GetAllLeftChallengeCount()
    this.maxCount = leftCount
    this.highestScoreTxt.text = tostring(this.singleScore)
end

this.RefreshData = function()
    this.countTxt.text = tostring(this.count)
    this.scorePreviewTxt.text = string.format(LuaMgr.GetLangText("TeamRelay2DelegatePopup_0"), this.singleScore * this.count)
end


this.SetLevelScoreView = function()
    this.levelDataList = {}
    this.canClaimPlotIds = {}
    local teamRelayMap = ConfigMgr.Config.TeamRelayMap
    for k, plotCfg in pairs(teamRelayMap) do
        if plotCfg.ActivityGroup == TeamRelay2Mgr.activityGroupId then
            for _, levelId in ipairs(plotCfg.Group) do
                local levelCfg = TeamRelay2Mgr.GetLevelCfg(levelId)
                local levelData = {
                    id = k,
                    levelId = levelId,
                    desc = LuaMgr.GetLangText(levelCfg.DiffDescLan),
                    rewards = this.GetRewardList(levelCfg.Reward),
                    status = TeamRelay2Mgr.GetLevelStatus(levelId),
                    animBool = false,
                    rewardTemplate = this.rewardTemplate,
                    onClickCallBack = this.OnClickLevelTaskItem,
                }
                if levelData.status ~= TeamRelay2Mgr.LevelStatus.Locked then
                    table.insert(this.levelDataList, levelData)
                    if levelData.status == TeamRelay2Mgr.LevelStatus.CanClaim then
                        table.insert(this.canClaimPlotIds, levelData.id)
                    end
                end
            end
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
            scrollData = UIScrollData.GetData(this.taskItemTemplate, "TeamRelay2TaskItem", 891, 275, groupData)
            table.insert(scrollDataList, scrollData)
        end

        this.levelScrollView:Clear(false)
        this.levelScrollView:SetParams(856, 99)
        this.levelScrollView:SetPadding(0, 0, -20, 0)
        this.levelScrollView:SetData(scrollDataList, true)
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})