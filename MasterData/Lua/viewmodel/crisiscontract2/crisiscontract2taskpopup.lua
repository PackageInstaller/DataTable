require("ViewModel/CrisisContract2/CrisisContract2TaskItem")

local this = {
    vm = nil,
    data = {
        taskList = {
            {
                desc = "",
                rewardList = {
                    { id = "", count = 0 },
                },
                isCanGet = false,
                isProgress = false,
                isFinish = false,
            }
        },
        buffCfgMap = {},
        allCanGetTaskList = {},
    },
    scrollView = nil,
    coroutine_key = nil,
    updateCallback = nil,
}

local data = {
    totalScore = "",
    isShowGetAllBtn = false
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.CrisisContract2TaskPopup)
        end
    },
    getAllBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if #this.data.allCanGetTaskList <= 0 then
                return
            end
            local askData = { questIds = this.data.allCanGetTaskList }
            ApiMgr.Request("ex/get_award", askData, true, function(result)
                local re = json.decode(result)
                local data = json.encode(re.result)
                LuaMgr.ShowItemRewared(data)
                this.RefreshData()
                this.SetTaskList()

                if this.updateCallback ~= nil then
                    this.updateCallback()
                end
            end, nil, true)
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
        if (vm.behaviour.Params == nil) then
            return
        end
        this.updateCallback = nil
        if vm.behaviour.Params.Length > 0 then
            this.updateCallback = vm.behaviour.Params[0]
        end
        this.RefreshData()
        this.SetTaskList()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.scrollView:Clear(false)
        if this.coroutine_key ~= nil then
            coroutine_runner.stop(this.coroutine_key)
        end
    end,
    before_destroy = function(vm)
        this = nil
        UIScrollView.ClearItem("CrisisContract2TaskItem")
    end,
}

this.RefreshData = function()
    this.data.taskList = {}
    this.data.allCanGetTaskList = {}
    local cfgCheckInQuest = DataExHelper.Check_ConfigQuestEventByGroupId(4005);
    table.sort(cfgCheckInQuest, function(a, b)
        return tonumber(a.id) < tonumber(b.id);
    end)
    for i, cfg in ipairs(cfgCheckInQuest) do
        local state = DataExHelper.Check_RewardState(cfg.id)
        local taskData = {
            id = cfg.id,
            target = cfg.progress,
            rewardList = cfg.showReward,
            isProgress = state == 1,
            isCanGet = state == 2,
            isFinish = state == 3,
            animBool = true,
        }
        taskData.callBack = this.OnTaskBtnClick
        if taskData.isCanGet then
            table.insert(this.data.allCanGetTaskList, taskData.id)
        end
        table.insert(this.data.taskList, taskData)
    end
    table.sort(this.data.taskList, function(a, b)
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
    for i, v in ipairs(this.data.taskList) do
        this.data.taskList[i].index = i
        this.data.taskList[i].animBool = i > 4
    end

    this.vm.data.isShowGetAllBtn = #this.data.allCanGetTaskList > 0
    this.vm.data.totalScore = CrisisContract2Mgr.GetTotalScore()
end

this.SetTaskList = function()
    this.scrollView:Clear(false)
    local scrollData, scrollDatas = {}, {}
    local groupData = nil
    for i, v in ipairs(this.data.taskList) do
        groupData = v
        groupData.index = i
        scrollData = UIScrollData.GetData(this.itemTemplate, "CrisisContract2TaskItem", 903, 96, v)
        table.insert(scrollDatas, scrollData)
    end
    if #this.data.allCanGetTaskList > 0 then
        this.scrollView:SetParams(935, 318)
    else
        this.scrollView:SetParams(935, 380)
    end
    this.scrollView:SetData(scrollDatas, true)

    if this.coroutine_key ~= nil then
        coroutine_runner.stop(this.coroutine_key)
    end
    this.coroutine_key = coroutine_runner.start(function()
        for i = 1, #this.scrollView.dataList do
            this.scrollView.dataList[i].data.animBool = true
            if this.scrollView.itemMap[i] ~= nil then
                SetActive(this.scrollView.itemMap[i].animatorObj, true)
            end
            coroutine_runner.wait(0.05)
        end
    end)
end

this.OnTaskBtnClick = function(index)
    local taskData = this.data.taskList[index]
    if not taskData.isCanGet then
        return
    end
    local askData = { questId = taskData.id }
    ApiMgr.Request("ex/get_award", askData, true, function(result)
        local re = json.decode(result)
        local data = json.encode(re.result)
        LuaMgr.ShowItemRewared(data)
        this.RefreshData()
        this.SetTaskList()
        if this.updateCallback ~= nil then
            this.updateCallback()
        end
    end, nil, true)
end

return vm({
    data = data,
    command = command,
    hook = hook
})