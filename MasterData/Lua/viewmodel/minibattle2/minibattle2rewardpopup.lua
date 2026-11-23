local this = {
    vm=nil,
    canAchieveIds = {},
    updateCallback = nil,
};

local data = {
    curScore = "",
    taskList = {
        {
            desc = "",
            rewardList = {
                {id = "", count = 0},
            },
            isCanGet = false, 
            isProgress = false, 
            isFinish = false,
            progressText = "",
            progressSlider = 0.0,
            animatorObj = false,
        }
    },
    tips = "",
}

local command = {
    getALLRewardBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if #this.canAchieveIds == 0 then
                return
            end
            DataExHelper.EX_GetAwards(this.canAchieveIds, function()
                this.Refresh()
                if this.updateCallback ~= nil then
                    this.updateCallback()
                end
            end)
        end
    },

    getRewardItemBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index = tonumber(param) + 1
            if this.vm.data.taskList[index].isCanGet then
                DataExHelper.EX_GetAward(this.vm.data.taskList[index].id, function()
                    this.Refresh()
                    if this.updateCallback ~= nil then
                        this.updateCallback()
                    end
                end)
            elseif this.vm.data.taskList[index].isProgress then
                
            end
        end
    },
    
    closeBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.Close()
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.updateCallback = nil
        if vm.behaviour.Params.Length > 0 then
            this.updateCallback = vm.behaviour.Params[0]
        end
        this.Refresh()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.RemoveTimer(TimerConst.MiniBattleNewRewardShowDelay)
    end,
    before_destroy=function(vm)
        this = nil;
    end
}

this.Refresh = function()
    local questData;
    local questConfig;
    local questEvent = ConfigMgr.Config.questEvent;
    local questEvents = DataExHelper.Check_DataExByGroupId(MiniBattle2Mgr.activityGroupId);
    table.sort(questEvents, this.SortQuestEvent);
    this.canAchieveIds = {}
    local tempList = {}
    local len = #questEvents;
    for i = 1, len do
        questData = questEvents[i];
        questConfig = questEvent[questData.id];

        local state=DataExHelper.Check_RewardState(questConfig.id)
        local taskData = {
            id = questConfig.id,
            desc = LuaMgr.GetLangText(questConfig.remarksLan),
            rewardList = this.GetRewardList(questConfig.showReward),
            isProgress = state == 1,
            isCanGet = state == 2,
            isFinish = state == 3,
            progressText = string.format("<color=#ffffff><size=28>%d/</size></color>%d", questData.progress, questConfig.progress),
            progressSlider = questData.progress / questConfig.progress,
            animatorObj = false,
        }
        if taskData.isCanGet then
            table.insert(this.canAchieveIds, taskData.id)
        end
        table.insert(tempList, taskData)
    end
    
    table.sort(tempList, function(a, b)
        if a.isFinish == b.isFinish then
            if a.isCanGet == b.isCanGet then
                return tonumber(a.id)<tonumber(b.id)
            else
                return a.isCanGet
            end
        else
            return not a.isFinish
        end
    end)
    this.vm.data.curScore = MiniBattle2Mgr.GetTotalScore()
    this.vm.data.tips = string.format(LuaMgr.GetLangText("MiniBattle2RewardPopup_0"), ConfigMgr.Config.constants.MiniBattleNewLimit)
    this.vm.data.taskList = tempList

    local listCount = #tempList
    local index = 1
    LuaMgr.RemoveTimer(TimerConst.MiniBattleNewRewardShowDelay)
    LuaMgr.AddTimer(TimerConst.MiniBattleNewRewardShowDelay,function()
        if index > listCount then
            LuaMgr.RemoveTimer(TimerConst.MiniBattleNewRewardShowDelay)
            return
        end
        this.vm.data.taskList[index].animatorObj = true
        index = index + 1
    end,0.1,-1,false)
end


this.SortQuestEvent = function(a, b)
    return a.id < b.id;
end

this.GetRewardList = function(award)
    local list = {}
    if award ~= nil and #award > 0 then
        for i = 1, #award do
            local rewardItem = ConfigMgr.Config.itemMap[award[i].id];
            local goods = {
                id = rewardItem.id,
                count = tostring(award[i].count),
                rareSort = rewardItem.rare,
                rare = ActivityMgr.GetRareSprite(rewardItem.rare),
                icon = ActivityMgr.GetItemTexture(rewardItem.id),
                showType = ItemShowType.NONE,
                sizeDelta = Vector2(128,128),
                scale = Vector3(0.52, 0.52, 1),
                isClick = true,
                isCount = true,
                isShow = false,
            }
            table.insert(list, goods)
        end
    end

    table.sort(list, this.RewardItemSort);
    return list
end


this.RewardItemSort = function(a, b)
    return a.rareSort > b.rareSort;
end

this.Close = function()
    LuaMgr.HidePanel(UIName.MiniBattle2RewardPopup);
end

return vm({
    data = data,
    command = command,
    hook = hook
})