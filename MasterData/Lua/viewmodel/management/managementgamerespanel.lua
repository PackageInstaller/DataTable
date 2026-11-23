local objs = {
    commonItemPrefab = {path = "template/ItemParent", type = UITool.GameObject},
    goalName = {path = "root/Middle/Name", type = UITool.Text},
    curReputation = {path = "root/Middle/Success/AddReputation", type = UITool.Text},
    totalReputation = {path = "root/Middle/Success/TotalReputation", type = UITool.Text},
    rewardParent = {path = "root/Middle/Success/RewardScroll", type = UITool.ScrollRect},
    successGroup = {path = "root/Middle/Success", type = UITool.GameObject},
    failGroup = {path = "root/Middle/Faild", type = UITool.GameObject},
    goalGroup = {path = "root/Middle/GoalGroup", type = UITool.Transform},
    exitBtn = {path = "root/Middle/Faild/ExitBtn", type = UITool.Button},
    restartBtn = {path = "root/Middle/Faild/RestartBtn", type = UITool.Button},
    closeBtn = {path = "root/Middle/CloseBtn", type = UITool.Button},
    maskCloseBtn = {path = "root/Mask", type = UITool.Button},
    succEffect = {path = "root/Middle/vfx_reward", type = UITool.GameObject}
}

local this = {

passData = nil,
    goalCellItems = {}
}

this.before_awake = function()
    this.scrollViewUI = UIScrollView.New(this.rewardParent)
end

this.before_active = function()
    this.RefreshGoalItem()
    this.goalName.text = this.name
    SetActive(this.successGroup, false)
    SetActive(this.failGroup, false)
    if this.gameRes == ManagementConst.GameResult.Success then
        SetActive(this.succEffect, true)
        local maxGetRewardCount = this.passData.config.limit[1].count
        local serverData = ManagementData.GetMiniGameData(this.passData.ID)
        local reputation = this.passReputation
        if serverData ~= nil then
            reputation = serverData.reputation + this.passReputation
            reputation = math.min(reputation, maxGetRewardCount)
        end
        this.curReputation.text = string.format("+%d/%d", reputation, maxGetRewardCount)
        if reputation >= maxGetRewardCount then
            local lanStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_27121")
            this.curReputation.text = string.format(lanStr, reputation, maxGetRewardCount)
        end
        this.totalReputation.text = string.format("%d/%d", DataMgr.Player.SmallShopData.Level, ManagementData.GetMaxReputationLevel())
        SetActive(this.successGroup, true)
        this.RefreshReward()
        this.OnGetReward()
    else
        SetActive(this.succEffect, false)
        SetActive(this.failGroup, true)
    end
end

this.RefreshReward = function()
    this.scrollViewUI:Clear()
    local scrollDatas = {}
    local data = this.passData
    if data == nil then
        return
    end
    local len = NumTool.GetLen(data.Reward)
    local rewardStatus = CommonRewardItem.Status.Got
    if this.rewardItemDatas ~= nil and #this.rewardItemDatas > 0 then
        rewardStatus = CommonRewardItem.Status.None
    end
    for i = 1, len do
        local tempData = data.Reward[i]
        tempData.scale = 0.6
        tempData.status = rewardStatus
        local scrollData = UIScrollData.GetData(this.commonItemPrefab, "CommonRewardItem", 80, 80, tempData)
        table.insert(scrollDatas, scrollData)
    end
    this.scrollViewUI:SetParams(530, 90)
    this.scrollViewUI:SetData(scrollDatas, true)
end

this.InitGoalNode = function()
    for i = 1, 3 do
        local data = {}
        data.path = "root/Middle/GoalGroup/Goal" .. i
        data.type = UITool.GameObject
        local cellName = "Goal" .. i
        objs[cellName] = data

        local data1 = {}
        data1.path = string.format("root/Middle/GoalGroup/Goal%d/GoalNum/Text", i)
        data1.type = UITool.Text
        local cellName1 = "GoalNum" .. i
        objs[cellName1] = data1
    end
end

this.InitGoalCellItem = function()
    for i = 1, 3 do
        local cellName = "Goal" .. i
        local obj = this[cellName]
        local cellItem = ManagementGameCell.New(obj)
        this.goalCellItems[i] = cellItem
    end
end

this.RefreshGoalItem = function()
    local goalConfigs = this.passData.GoalPasscondition
    if goalConfigs == nil then
        LuaDebug.error("442======" .. debug.traceback())
        return
    end
    for i = 1, #this.goalCellItems do
        local goalConfig = goalConfigs[i]
        local cellItem = this.goalCellItems[i]
        if goalConfig == nil then
            SetActive(cellItem.gameObject, false)
        else
            SetActive(cellItem.gameObject, true)
            local data = {}
            data.elementID = goalConfig[1]
            cellItem:SetDataOnly(data)

            local needCount = goalConfig[2]
            local cellName1 = "GoalNum" .. i
            local curReachCount = this.passData.CurGoalPasscondition[data.elementID]
            local curCount = curReachCount or 0
            curCount = math.min(curCount, needCount)
            this[cellName1].text = string.format("%d/%d", curCount, needCount)
        end
    end
end

this.OnGetReward = function()
    if type(this.passData) ~= "table" then
        return
    end
    local data = {}
    data.id = this.passData.ID
    data.pass = this.isPass
    data.reputation = this.passReputation
    local callback = function(result)
        local res = json.decode(result)
        if res.code ~= 0 then
            return
        end
        local resultData = res.result
        this.rewardItemDatas = {}
        if type(resultData) == "table" and type(resultData.Reward) == "table" and type(resultData.Reward.Items) == "table" then
            for i, v in pairs(resultData.Reward.Items) do
                local item = {ID = v.id, Count = v.count}
                table.insert(this.rewardItemDatas, item)
            end
        end
    end
    ApiMgr.Request("casualsGame/settlement", data, true, callback, nil, true)
end

this.OnClickClose = function()
    LuaMgr.HidePanel(UIName.ManagementGameResPanel)
    if this.onExistCallback then
        this.onExistCallback()
    end
    if this.rewardItemDatas ~= nil and #this.rewardItemDatas > 0 then
        local func = function()
            LuaMgr.ShowItemGetPanel(this.rewardItemDatas)
            this.rewardItemDatas = {}
        end
        LuaMgr.NextFrame(func)
    end
end

this.OnClickExitBtn = function()
    LuaMgr.HidePanel(UIName.ManagementGameResPanel)
    if this.onExistCallback then
        this.onExistCallback()
    end
    if this.rewardItemDatas ~= nil and #this.rewardItemDatas > 0 then
        local func = function()
            LuaMgr.ShowItemGetPanel(this.rewardItemDatas)
            this.rewardItemDatas = {}
        end
        LuaMgr.NextFrame(func)
    end
end
this.OnClickRestartBtn = function()
    LuaMgr.HidePanel(UIName.ManagementGameResPanel)
    if this.onReplayCallback then
        this.onReplayCallback()
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.InitGoalNode()
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.InitGoalCellItem()
        this.before_awake()
        LuaMgr.AddClick(this.closeBtn, this.OnClickClose)
        LuaMgr.AddClick(this.maskCloseBtn, this.OnClickClose)
        LuaMgr.AddClick(this.exitBtn, this.OnClickExitBtn)
        LuaMgr.AddClick(this.restartBtn, this.OnClickRestartBtn)
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil or vm.behaviour.Params.Length < 1 then
            return
        end
        local paramData = vm.behaviour.Params[0]
        this.passData = paramData.passData
        this.passReputation = paramData.curReputation
        this.gameRes = paramData.gameRes or ManagementConst.GameResult.Fail
        this.isPass = this.gameRes == ManagementConst.GameResult.Success
        this.name = paramData.name
        this.onExistCallback = paramData.onExistCallback
        this.onReplayCallback = paramData.onReplayCallback
        this.before_active()
    end,
    before_deactive = function(vm)
        UIScrollView.ClearItem("CommonRewardItem")
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickClose)
        LuaMgr.RemoveClick(this.maskCloseBtn, this.OnClickClose)
        LuaMgr.RemoveClick(this.exitBtn, this.OnClickExitBtn)
        LuaMgr.RemoveClick(this.restartBtn, this.OnClickRestartBtn)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)