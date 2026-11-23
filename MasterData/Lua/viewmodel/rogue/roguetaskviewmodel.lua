local this = {
    vm = nil,
    showType = 0,
    typeNameList = {},
    taskList = {},
    taskKeyList = { "XHYT1", "XHYT2", "XHYT3" },
};

local data = {
    curScore = "",
    typeList = { { typeId = 0, typeName = "", select = false, red = false } },
    taskList = {
        {
            desc = "", progressStr = "", sliderSizeDelta = Vector2(256, 8), showItemReward = false, showScoreReward = false,
            rewardList = {
                { id = "", count = 0 },
            },
            scoreNum = "",
            isCanGet = false, isProgress = false, isFinish = false,
        }
    },
    rewardList = {
        {
            target = "", isCanGet = false, isFinish = false, rightLine = false, downLine = false, isShow = false,
            rewardList = {
                { id = "", count = 0 },
            },
        }
    },
    showTaskList = false,
    showRewardList = false,
    scrollViewSizeDelta = Vector2(1018, 487),
    showGetAllBtn = false;
    dailyScore="";
    getScoreEffect = false,
}

local command = {
    typeBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = param + 1
            this.ChooseType(index)
        end
    },
    getRewardItemBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local i = param + 1
            local lineIndex = math.ceil(i / 4)
            local isLineOne = lineIndex % 2 == 1
            local taskData = nil
            if isLineOne then
                taskData = this.taskList[this.showType][i]
            else
                local index = 8 * lineIndex - i - 3
                taskData = this.taskList[this.showType][index]
            end
            if not taskData.isCanGet then
                return
            end
            local idList = {}
            table.insert(idList, taskData.id)
            this.GetTaskReward(idList)
        end
    },
    getAllBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local typeTaskList = this.taskList[this.showType]
            local idList = {}
            for i, v in ipairs(typeTaskList) do
                if v.isCanGet then
                    table.insert(idList, v.id)
                end
            end
            this.GetTaskReward(idList)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.typeNameList = { LuaMgr.GetLangText("RogueTaskViewModel_0"), LuaMgr.GetLangText("RogueTaskViewModel_1"), LuaMgr.GetLangText("RogueTaskViewModel_2") }
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.showType = 1
        this.RefreshData()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        LuaMgr.RemoveTimer(TimerConst.RogueTaskGetScoreEffectTimer)
    end,
    before_destroy = function(vm)
        this = nil;
    end
}

this.SetTypeList = function()
    local tempList = {}
    for i, v in ipairs(this.typeNameList) do
        local item = {
            index = i,
            typeName = v,
            select = i == this.showType,
            red = RedMgr.Singleton:GetRedStateById("16855_" .. i) > 0
        }
        table.insert(tempList, item)
    end
    this.vm.data.typeList = tempList
end

this.RefreshData = function()
    local showType = this.showType
    this.taskList = {}
    this.showType = 0
    this.SetTypeList()
    this.ChooseType(showType)
    this.SetCurScore()
end

this.ChooseType = function(type)
    if this.showType == type then
        return
    end
    this.showType = type

    if TableIsNull(this.taskList[type]) then
        this.InitTaskList(type)
    end
    local tempTaskList = this.taskList[type]
    local isCanGet = false
    for i, v in ipairs(tempTaskList) do
        if v.isCanGet then
            isCanGet = true
            break
        end
    end
    for i, v in ipairs(this.vm.data.typeList) do
        v.select = v.index == this.showType
    end
    this.vm.data.showGetAllBtn = isCanGet
    this.vm.data.scrollViewSizeDelta = isCanGet and Vector2(1018, 487) or Vector2(1018, 580)
    if type == 1 or type == 2 then
        this.vm.data.taskList = tempTaskList
        this.vm.data.showTaskList = true
        this.vm.data.showRewardList = false
    elseif type == 3 then
        this.SetRewardList()
        this.vm.data.showTaskList = false
        this.vm.data.showRewardList = true
    end
end

this.InitTaskList = function(type)
    this.taskList[type] = {}
    local cfgCheckInQuest = DataExHelper.Check_ConfigQuestEventByText(this.taskKeyList[type]);
    table.sort(cfgCheckInQuest, function(a, b)
        return tonumber(a.id) < tonumber(b.id);
    end)
    for i, cfg in ipairs(cfgCheckInQuest) do
        local questData = DataMgr.Player.quests[cfg.id];
        if questData~=nil then
            local state = questData.state == nil and -1 or questData.state
            local colorStr = state == 2 and "fff5d6" or "8e8d8d"
            local taskData = {
                id = cfg.id,
                desc = LuaMgr.GetLangText(cfg.remarksLan),
                progressStr = string.format("( <color=#%s>%d/</color>%d )", colorStr, questData.progress, cfg.progress),
                sliderSizeDelta = Vector2(256 * questData.progress / cfg.progress, 8),
                showItemReward = cfg.eventType ~= 812,
                showScoreReward = cfg.eventType == 812,
                rewardList = {},
                scoreNum = tostring(cfg.activeValue),
                target = cfg.progress,
                isProgress = state == 1,
                isCanGet = state == 2,
                isFinish = state == 3,
                animBool = true,
            }
            if taskData.showItemReward then
                taskData.rewardList = this.GetRewardList(cfg.showReward)
            end
            table.insert(this.taskList[type], taskData)
        end
    end
    if type ~= 3 then
        table.sort(this.taskList[type], function(a, b)
            if a.isFinish == b.isFinish then
                if a.isCanGet == b.isCanGet then
                    return tonumber(a.id) < tonumber(b.id)
                else
                    return a.isCanGet
                end
            else
                return not a.isFinish
            end
        end)
    end
    for i, v in ipairs(this.taskList[type]) do
        this.taskList[type][i].index = i
        this.taskList[type][i].animBool = i > 5
    end
end

this.SetRewardList = function()
    local tempList = {}
    local rewardList = this.taskList[3]
    local taskCount = #rewardList
    local maxLine = math.ceil(taskCount / 4)
    local maxItemCount = maxLine * 4
    for i = 1, maxItemCount do
        local lineIndex = math.ceil(i / 4)
        local isLineOne = lineIndex % 2 == 1
        local taskData = nil
        if isLineOne then
            taskData = rewardList[i]
        else
            local index = 8 * lineIndex - i - 3
            taskData = rewardList[index]
        end
        local rewardItem = {
            target = "",
            isCanGet = false,
            isFinish = false,
            rightLine = false,
            downLine = false,
            isShow = false,
            rewardList = {},
        }
        if taskData ~= nil then
            rewardItem.id = taskData.id
            rewardItem.target = tostring(taskData.target)
            rewardItem.isCanGet = taskData.isCanGet
            rewardItem.isFinish = taskData.isFinish
            if isLineOne then
                rewardItem.rightLine = i % 4 ~= 0 and i < taskCount
                rewardItem.downLine = i % 4 == 0 and lineIndex ~= maxLine
            else
                rewardItem.rightLine = i % 4 ~= 0
                rewardItem.downLine = i % 4 == 1 and lineIndex ~= maxLine
            end
            rewardItem.isShow = true
            rewardItem.rewardList = taskData.rewardList
        end
        table.insert(tempList, rewardItem)
    end
    this.vm.data.rewardList = tempList
end

this.SetCurScore = function()
    local cfgCheckInQuest = DataExHelper.Check_ConfigQuestEventByText(this.taskKeyList[3]);
    table.sort(cfgCheckInQuest, function(a, b)
        return tonumber(a.id) < tonumber(b.id);
    end)
    local maxScoreTaskCfg = cfgCheckInQuest[#cfgCheckInQuest]
    local questData = DataMgr.Player.quests[maxScoreTaskCfg.id];
    if questData~=nil then
        this.vm.data.curScore = string.format("%d/%d", questData.progress, maxScoreTaskCfg.progress)
    else
        this.vm.data.curScore = string.format("%d/%d", 0, maxScoreTaskCfg.progress)
    end
    this.vm.data.dailyScore=string.format(ConfigMgr.LangGlobal("26524"),DataMgr.Player.RogueDailyScore,ConfigMgr.Config.RogueConstants.RogueDailyCreditLimit);
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
                sizeDelta = Vector2(68, 68),
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

this.GetTaskReward = function(taskIdList)
    this.vm.data.getScoreEffect = false
    LuaMgr.RemoveTimer(TimerConst.RogueTaskGetScoreEffectTimer)
    local askData = { questIds = taskIdList }
    ApiMgr.Request("ex/get_award", askData, true, function(result)
        HeroRedDataHelper.SetRogueRed()
        local re = json.decode(result)
        local data = json.encode(re.result)
        LuaMgr.ShowItemRewared(data)
        this.RefreshData()
        this.PlayGetScoreEffect()
    end, nil, true)
end

this.PlayGetScoreEffect = function()
    if this.showType ~= 2 then
        return
    end
    this.vm.data.getScoreEffect = true
    LuaMgr.AddTimer(TimerConst.RogueTaskGetScoreEffectTimer, function()
        this.vm.data.getScoreEffect = false
    end, 1);
end

return vm({
    data = data,
    command = command,
    hook = hook
})