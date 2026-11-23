
require("ViewModel/Activity/CrisisContractTaskItem")
local this = {
    vm = nil,
    data = {
        taskList = {
            {
                desc = "",
                showAppointBuffList = false,
                appointBuffList = {
                    icon = DefaultSprite,
                },
                showLevelRatingList = false,
                levelRatingList = {
                    type = 1, icon = DefaultSprite,
                },
                rewardList = {
                    {id = "", count = 0},
                },
                isCanGet = false, isProgress = false, isFinish = false,
            }
        },
        buffCfgMap = {}
    },
    scrollView = nil,
    coroutine_key = nil,
    closeCallback = nil,
}

local data = {
    
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.CrisisContractTaskPopup)
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.scrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/Group/ScrollView").gameObject)
        this.itemTemplate = vm.behaviour.transform:Find("template/TaskItem").gameObject
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.closeCallback = nil
        if vm.behaviour.Params.Length > 0 then
            this.closeCallback = vm.behaviour.Params[0]
        end
        this.RefreshData()
        this.SetTaskList()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if this.closeCallback ~= nil then
            this.closeCallback()
        end
        this.scrollView:Clear(false)
        if this.coroutine_key ~= nil then
            coroutine_runner.stop(this.coroutine_key)
        end
    end,
    before_destroy = function(vm)
        this = nil
        UIScrollView.ClearItem("CrisisContractTaskItem")
    end,
}

this.RefreshData = function()
    this.data.taskList = {}
    this.data.buffCfgMap = {}
    local buffCfgList = ActivityMgr.GetActivityBuffList(ActivityKey.crisiscontract)
    for i, v in ipairs(buffCfgList) do
        this.data.buffCfgMap[v.Id] = v
    end
    local cfgCheckInQuest = DataExHelper.Check_ConfigQuestEventByGroupId(2000);
    table.sort(cfgCheckInQuest,function(a,b) return tonumber(a.id)<tonumber(b.id); end)
    for i,cfg in ipairs(cfgCheckInQuest) do
        local state=DataExHelper.Check_RewardState(cfg.id)
        local taskData = {
            id = cfg.id,
            desc = LuaMgr.GetLangText(cfg.namelan),
            showAppointBuffList = false,
            appointBuffList = {},
            showLevelRatingList = false,
            levelRatingList = {},
            rewardList = cfg.showReward,
            isProgress = state == 1,
            isCanGet = state == 2,
            isFinish = state == 3,
            animBool = true,
        }

if cfg.eventType == 601 then
            taskData.showLevelRatingList = true
            taskData.levelRatingList = {}
            if cfg.conditionArgs ~= nil and #cfg.conditionArgs > 0 then
                local scoreSpriteList = this.GetScoreSpriteList(tonumber(cfg.conditionArgs[1]))
                for j, sprite in ipairs(scoreSpriteList) do
                    table.insert(taskData.levelRatingList, { type = 1, icon = sprite })
                end
            end
            if cfg.conditionArgs ~= nil and #cfg.conditionArgs > 1 then
                table.insert(taskData.levelRatingList, { type = 2, icon = ActivityMgr.GetCrisisContractRatingImg(tonumber(cfg.conditionArgs[2]), false) })
            end
elseif cfg.eventType == 602 then
            taskData.showAppointBuffList = true
            taskData.appointBuffList = {}
            if cfg.conditionArgs ~= nil then
                for j, buffKey in ipairs(cfg.conditionArgs) do
                    local buffCfg = this.data.buffCfgMap[buffKey]
                    if buffCfg ~= nil then
                        table.insert(taskData.appointBuffList, { icon = LuaMgr.GetSprite("BuffIcon", buffCfg.BuffIcon) })
                    end
                end
            end
        end
        taskData.callBack = this.OnTaskBtnClick
        table.insert(this.data.taskList, taskData)
    end
    table.sort(this.data.taskList, function(a, b)
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
    for i, v in ipairs(this.data.taskList) do
        this.data.taskList[i].index = i
        this.data.taskList[i].animBool = i > 5
    end
end

this.SetTaskList = function()
    this.scrollView:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    for i, v in ipairs(this.data.taskList) do
        groupData = v
        groupData.index = i
        scrollData = UIScrollData.GetData(this.itemTemplate,"CrisisContractTaskItem",908, 84, v)
        table.insert(scrollDatas,scrollData)
    end
    this.scrollView:SetParams(921, 415)
    this.scrollView:SetData(scrollDatas, true)
    
    if this.coroutine_key ~= nil then
        coroutine_runner.stop(this.coroutine_key)
    end
    this.coroutine_key = coroutine_runner.start(function()
        for i = 1, #this.scrollView.dataList do
            this.scrollView.dataList[i].data.animBool = true
            if this.scrollView.itemMap[i] ~= nil then
                SetActive(this.scrollView.itemMap[i].animatorObj,true)
            end
            coroutine_runner.wait(0.05)
        end
    end)
end

this.GetScoreSpriteList = function(score)
    local spriteList = {}
    if score < 10 then
        table.insert(spriteList, ActivityMgr.GetCrisisContractNumSprite(score))
    else
        local num_1 = math.floor(score / 10)
        local num_2 = score - num_1 * 10
        table.insert(spriteList, ActivityMgr.GetCrisisContractNumSprite(num_1))
        table.insert(spriteList, ActivityMgr.GetCrisisContractNumSprite(num_2))
    end
    return spriteList
end

this.OnTaskBtnClick = function(index)
    local taskData = this.data.taskList[index]
    if not taskData.isCanGet then
        return
    end
    local askData={questId = taskData.id}
    ApiMgr.Request("ex/get_award", askData, true, function(result)
        local re=json.decode(result)
        local data=json.encode(re.result)
        LuaMgr.ShowItemRewared(data)
        this.RefreshData()
        this.SetTaskList()
    end,nil,true)
end
    
return vm({
    data = data,
    command = command,
    hook = hook
})