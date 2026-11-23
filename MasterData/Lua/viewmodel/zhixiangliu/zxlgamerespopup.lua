local objs = {
    commonItemPrefab = {path = "template/ItemParent", type = UITool.GameObject},
    rewardParent = {path = "root/Middle/Success/RewardParent", type = UITool.Transform},
    successGroup = {path = "root/Middle/Success", type = UITool.GameObject},
    failGroup = {path = "root/Middle/Faild", type = UITool.GameObject},
    goalGroup = {path = "root/Middle/GoalGroup", type = UITool.Transform},
    exitBtn = {path = "root/Middle/ButtonGroup/ExitBtn", type = UITool.Button},
    restartBtn = {path = "root/Middle/ButtonGroup/RestartBtn", type = UITool.Button},
    closeBtn = {path = "root/Middle/CloseBtn", type = UITool.Button},
    maskCloseBtn = {path = "root/Mask", type = UITool.Button},
    faildCostTimeStr = {path = "root/Middle/Faild/CostTime", type = UITool.Text},
    succCostTimeStr = {path = "root/Middle/Success/CostTimeBG/CostTime", type = UITool.Text}
}

local this = {

passData = nil,

    rewardItems = {},

    rewardItemChache = {}
}

this.before_awake = function()
end

this.before_active = function()
    SetActive(this.successGroup, false)
    SetActive(this.failGroup, false)
    SetActive(this.restartBtn.gameObject, this.gameRes == ZXLConst.GameResult.Fail)
    local tipsStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29402")
    if this.gameRes == ZXLConst.GameResult.Success then
        SetActive(this.successGroup, true)
        this.succCostTimeStr.text = string.format(tipsStr, this.useTime)
        this.RefreshReward()
        this.OnGetReward()
        for i = 1, 3 do
            local starName = "Star" .. i
            SetActive(this[starName], i <= this.starLevel)
        end
    else
        this.faildCostTimeStr.text = string.format(tipsStr, this.useTime)
        SetActive(this.failGroup, true)
    end
end

this.RefreshReward = function()
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
        local item = this.GetRewardItemByCache()
        item:SetData1(tempData)
        table.insert(this.rewardItems, item)
    end
end

this.GetRewardItemByCache = function()
    local rewardItem = table.remove(this.rewardItemChache)
    if rewardItem == nil then
        rewardItem = CommonRewardItem.New(this.commonItemPrefab, false, 0.6, nil, this.rewardParent)
    end
    SetActive(rewardItem.gameObject, true)
    return rewardItem
end

this.RecycleRewardItem = function()
    local rewardItemsLen = #this.rewardItems
    for i = 1, rewardItemsLen do
        local rewardItem = table.remove(this.rewardItems)
        if rewardItem then
            table.insert(this.rewardItemChache, rewardItem)
            SetActive(rewardItem.gameObject, false)
        end
    end
end

this.ClearRewardItem = function()
    local rewardItemsLen = #this.rewardItems
    for i = 1, rewardItemsLen do
        local rewardItem = this.rewardItems[i]
        rewardItem:Destroy()
    end

    local rewardItemCacheLen = #this.rewardItemChache
    for i = 1, rewardItemCacheLen do
        local rewardItem = this.rewardItemChache[i]
        rewardItem:Destroy()
    end
    this.rewardItems = {}
    this.rewardItemChache = {}
end

this.InitGoalNode = function()
    for i = 1, 3 do
        local data = {}
        data.path = string.format("root/Middle/Success/ScoreLevel/Level%d/LightObj", i)
        data.type = UITool.GameObject
        local cellName = "Star" .. i
        objs[cellName] = data
    end
end

this.OnGetReward = function()
    if type(this.passData) ~= "table" then
        return
    end
    local data = {}
    data.Id = this.passData.ID
    data.Star = this.starLevel
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
    ApiMgr.Request("puzzlegame/completed", data, true, callback, nil, true)
end

this.OnClickClose = function()
    LuaMgr.HidePanel(UIName.ZXLGameResPopup)
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
    LuaMgr.HidePanel(UIName.ZXLGameResPopup)
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
    LuaMgr.HidePanel(UIName.ZXLGameResPopup)
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
        this.gameRes = paramData.gameRes or ManagementConst.GameResult.Fail
        this.isPass = this.gameRes == ManagementConst.GameResult.Success
        this.useTime = this.passData.Limittimes - paramData.remainTime
        this.name = paramData.name
        this.starLevel = paramData.star
        this.onExistCallback = paramData.onExistCallback
        this.onReplayCallback = paramData.onReplayCallback
        this.before_active()
    end,
    before_deactive = function(vm)
        this.RecycleRewardItem()
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickClose)
        LuaMgr.RemoveClick(this.maskCloseBtn, this.OnClickClose)
        LuaMgr.RemoveClick(this.exitBtn, this.OnClickExitBtn)
        LuaMgr.RemoveClick(this.restartBtn, this.OnClickRestartBtn)
        this.ClearRewardItem()
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)