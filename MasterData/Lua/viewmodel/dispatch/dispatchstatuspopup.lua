







require("ViewModel/Dispatch/ListViewItem/DispatchDataCell")
require("ViewModel/Dispatch/ListViewItem/DispatchingDataCell")
require("ViewModel/Dispatch/ListViewItem/DispatchStageToggle")

local objs = {
    dispatchDataCell = {path = "template/DispatchDataCell", type = UITool.GameObject},
    dispatchingDataCell = {path = "template/DispatchingDataCell", type = UITool.GameObject},
    exitBtn = {path = "root/Mask", type = UITool.Button},
    maskCloseBtn = {path = "root/Middle/CloseBtn", type = UITool.Button},

    dispatchBeforeObj = {path = "root/Middle/DispatchWaitObj", type = UITool.GameObject},
    beforeSelectTimeTxt = {path = "root/Middle/DispatchWaitObj/TopGroup/SelectTimeTxt", type = UITool.Text},
    beforeStageToggleGroup = {path = "root/Middle/DispatchWaitObj/TopGroup/StageToggleGroup", type = UITool.ToggleGroup},
    beforeStageToggleTemplete = {path = "root/Middle/DispatchWaitObj/TopGroup/StageToggleGroup/StageTemplate", type = UITool.GameObject},
    beforeScrollView = {path = "root/Middle/DispatchWaitObj/ScrollView", type = UITool.GameObject},
    beforeCancelBtn = {path = "root/Middle/DispatchWaitObj/CancelBtn", type = UITool.Button},
    beforeConfirmBtn = {path = "root/Middle/DispatchWaitObj/ConfirmBtn", type = UITool.Button},

    dispatchingObj = {path = "root/Middle/DispatchingObj", type = UITool.GameObject},
    ingSelectTimeTxt = {path = "root/Middle/DispatchingObj/TopGroup/SelectTimeTxt", type = UITool.Text},
    ingScrollView = {path = "root/Middle/DispatchingObj/ScrollView", type = UITool.GameObject},

    dispatchEndObj = {path = "root/Middle/DispatchEndObj", type = UITool.GameObject},
    endScrollView = {path = "root/Middle/DispatchEndObj/ScrollView", type = UITool.GameObject},
    endCloseBtn = {path = "root/Middle/DispatchEndObj/CloseBtn", type = UITool.Button}
}

local this = {
    beforeSelectStage = 1,

    lastToggle = nil,

    toggleNodes = {}
}

this.before_awake = function()
    this.beforeScrollViewUI = UIScrollView.New(this.beforeScrollView)
    this.ingScrollViewUI = UIScrollView.New(this.ingScrollView)
    this.endScrollViewUI = UIScrollView.New(this.endScrollView)
end

this.before_active = function()
    if this.isInit == nil and (this.dispatchStatus == DispatchData.StrongholdStatus.DispatchWait or this.dispatchStatus == DispatchData.StrongholdStatus.Dispatching) then
        this.InitDispatchWaitView()
        this.isInit = true
    end
    SetActive(this.dispatchBeforeObj, false)
    SetActive(this.dispatchingObj, false)
    SetActive(this.dispatchEndObj, false)
    if this.dispatchStatus == DispatchData.StrongholdStatus.DispatchWait then
        SetActive(this.dispatchBeforeObj, true)
        this.RefreshDispatchWaitView()
    elseif this.dispatchStatus == DispatchData.StrongholdStatus.Dispatching then
        SetActive(this.dispatchingObj, true)
        this.RefreshDispatchingView()
    elseif this.dispatchStatus == DispatchData.StrongholdStatus.DispatchEnd then
        SetActive(this.dispatchEndObj, true)
        this.RefreshDispatchEndView()
    end
end



this.InitDispatchWaitView = function()
    local toggleOptionCfg = ConfigMgr.Config.DispatchConstants.DispatchTimeOption
    local hourStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_23715")
    for i = 1, #toggleOptionCfg do
        local value = toggleOptionCfg[i]

        local toggleNode = DispatchStageToggle.New(this.beforeStageToggleTemplete, this.beforeStageToggleGroup.transform, true, i, this.ClickTimeOptionToggle)
        this.toggleNodes[tostring(i)] = toggleNode
        local data = {}
        local hourNum = math.floor(value / 3600)
        data.nocheckText = hourNum .. hourStr
        data.checkText = tostring(hourNum)
        toggleNode:SetData(data)
        if i == #toggleOptionCfg then
            this.lastToggle = toggleNode
            this.beforeSelectStage = i
            this.lastToggle.toggle.isOn = true
            this.lastToggle:SetIsOn(true)
        else
            toggleNode.toggle.isOn = false
            toggleNode:SetIsOn(false)
        end
    end
end

this.ClickTimeOptionToggle = function(index, value)
    if value == true then
        this.beforeSelectStage = index
        this.RefreshDispatchWaitScrollView()
        local configValue = ConfigMgr.Config.DispatchConstants.DispatchTimeOption[index]
        this.beforeSelectTimeTxt.text = tostring(math.floor(configValue / 3600))
        for key, data in pairs(this.allDispatchBeforeDatas) do
            DispatchData.RefreshRewardData(data.strongholdData, this.beforeSelectStage)
        end
        this.beforeScrollViewUI:Refresh()
        for key, value in pairs(this.toggleNodes) do
            value:SetIsOn(key == tostring(index))
        end
    end
end

this.RefreshDispatchWaitView = function()
    this.RefreshDispatchWaitScrollView()
end

this.RefreshDispatchWaitScrollView = function()
    local curTime = LuaMgr.Timestamp()
    if this.lastRefreshTime ~= nil and curTime - this.lastRefreshTime < 1 then
        return
    end
    this.lastRefreshTime = curTime
    this.beforeScrollViewUI:Clear()
    this.allDispatchBeforeDatas = {}
    local allDatas = this.dispatchPreviewData
    local scrollDatas = {}
    local datasLen = #allDatas
    this.tempHeroDic = {}
    for i = 1, datasLen do
        local data = allDatas[i]
        data.reputation = this.GetStrongholdReputation(data.strongholdData, data.heroList)
        data.timeOptionIndex = this.beforeSelectStage
        DispatchData.RefreshRewardData(data.strongholdData, this.beforeSelectStage)
        this.tempHeroDic[tostring(data.strongholdData.id)] = data.heroList
        local tempData = UIScrollData.GetData(this.dispatchDataCell, "DispatchDataCell", 925.5, 145, data)
        table.insert(scrollDatas, tempData)
        table.insert(this.allDispatchBeforeDatas, data)
    end
    this.beforeScrollViewUI:SetParams(925.5, 349)
    this.beforeScrollViewUI:SetData(scrollDatas, true)
end

this.OnBeforeCancelBtn = function()
    this.OnClickBack()
end

this.OnOneKeyDispatch = function()
    local maxCount = ConfigMgr.Config.DispatchConstants.DispatchDailyLimit
    local remainCount = maxCount - (DataMgr.Player.dailyCount.dispatchRegular or 0)
    if remainCount <= 0 then
        local tips = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_23717")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tips)
        return
    end
    local allDatas = DispatchData.GetAllDatas()
    local datasLen = #allDatas
    local data = {}
    data.Items = {}
    this.heroList = {}
    local tempDispatchTeam = 0
    for i = 1, datasLen do
        local strongholdData = allDatas[i]
        if tempDispatchTeam < remainCount and strongholdData.status == DispatchData.StrongholdStatus.DispatchWait then
            local heroList = this.tempHeroDic[tostring(strongholdData.id)] or {}
            local members = {}
            local pos = 0
            for key, value in pairs(heroList) do
                members[tostring(pos)] = value.heroID
                pos = pos + 1
                table.insert(this.heroList, #this.heroList + 1, value)
            end
            if #heroList > 0 then
                data.Items[tostring(strongholdData.id)] = {
                    Stage = this.beforeSelectStage - 1,
                    Members = members
                }
                tempDispatchTeam = tempDispatchTeam + 1
            end
        end
    end
    if NumTool.GetLen(data.Items) == 0 then
        return
    end
    local callback = function(result)
        local res = json.decode(result)
        if res.code ~= 0 then
            return
        end
        DispatchData.RefreshDispatchedHero()
        local configValue = ConfigMgr.Config.DispatchConstants.DispatchTimeOption[this.beforeSelectStage]
        local data = {}
        data.status = DispatchData.StatusChangeType.DispatchSucc
        data.heroList = this.heroList
        data.dispatchTime = configValue
        LuaMgr.InvokeUIEventListeners(UIEventConst.DispatchStatusChange, data)
        this.OnClickBack()
    end
    ApiMgr.Request("dispatchRegular/start", data, true, callback, nil, true)
end





this.RefreshDispatchingView = function()
    this.ingScrollViewUI:Clear()
    local allDatas = DispatchData.GetAllDatas()
    local scrollDatas = {}
    local datasLen = #allDatas
    for i = 1, datasLen do
        local data = {}
        data.heroList = DispatchData.GetHeroList()
        if data.status == DispatchData.StrongholdStatus.Dispatching then
            local tempData = UIScrollData.GetData(this.dispatchDataCell, "DispatchingDataCell", 946, 156, data)
            table.insert(scrollDatas, tempData)
        end
    end
    this.ingScrollViewUI:SetParams(925.5, 405)
    this.ingScrollViewUI:SetData(scrollDatas, true)
end





this.RefreshDispatchEndView = function()
    this.endScrollViewUI:Clear()
    local allDatas = DispatchData.GetAllDatas()
    local scrollDatas = {}
    local datasLen = #allDatas
    for i = 1, datasLen do
        local data = {}
        data.strongholdData = allDatas[i]
        if data.strongholdData.status == DispatchData.StrongholdStatus.DispatchEnd then
            data.heroList = DispatchData.GetHeroList(data.strongholdData.id)
            data.reputation = this.GetStrongholdReputation(data.strongholdData, data.heroList)
            data.timeOptionIndex = data.strongholdData.timeOptionIndex
            DispatchData.RefreshRewardData(data.strongholdData, data.strongholdData.timeOptionIndex)
            local tempData = UIScrollData.GetData(this.dispatchDataCell, "DispatchDataCell", 925.5, 145, data)
            table.insert(scrollDatas, tempData)
        end
    end
    this.endScrollViewUI:SetParams(925.5, 394)
    this.endScrollViewUI:SetData(scrollDatas, true)
end

this.OnEndCloseBtn = function()
    local allDatas = DispatchData.GetAllDatas()
    local datasLen = #allDatas
    local data = {}
    data.Ids = {}
    for i = 1, datasLen do
        local strongholdData = allDatas[i]
        if strongholdData.status == DispatchData.StrongholdStatus.DispatchEnd then
            table.insert(data.Ids, strongholdData.id)
        end
    end
    this.OnClickBack()
    if #data.Ids == 0 then
        return
    end
    local callback = function(result)
        local res = json.decode(result)
        if res.code ~= 0 then
            return
        end
        local reward = json.encode(res.result.Rewards)
        LuaMgr.ShowItemRewared(reward)
        DispatchData.RefreshDispatchedHero()
        local data = {}
        data.status = DispatchData.StatusChangeType.GetRewardSucc
        data.storyID = res.result.StoryId
        LuaMgr.InvokeUIEventListeners(UIEventConst.DispatchStatusChange, data)
    end
    ApiMgr.Request("dispatchRegular/taskReward", data, true, callback, nil, true)
end





this.GetStrongholdReputation = function(dispatchData, heroList)
    local baseData = this.GetBaseCondData(dispatchData, heroList)
    local extraData = this.GetExtraCondData(dispatchData, heroList)
    return baseData.fullCondScore + extraData.fullCondScore
end

this.GetBaseCondData = function(dispatchData, heroList)
    local data = {}
    local conditionData = {}
    data.fullCondNum = 0
    data.conditionData = conditionData
    data.fullCondScore = dispatchData.curTaskConfig.BaseReputation
    for key, condCfg in pairs(dispatchData.curTaskConfig.BaseCond) do
        local tempData = {}
        tempData.isFull = DispatchData.CheckCondition(heroList, condCfg, true)
        tempData.index = key
        tempData.isBaseCond = true
        if tempData.isFull == true then
            data.fullCondNum = data.fullCondNum + 1
        end
        conditionData[key] = tempData
    end
    return data
end

this.GetExtraCondData = function(dispatchData, heroList)
    local data = {}
    local conditionData = {}
    data.conditionData = conditionData
    data.fullCondScore = 0
    local extraCondConfig = dispatchData.curTaskConfig.ExtraCredit
    for key, condCfg in pairs(dispatchData.curTaskConfig.ExtraCond) do
        local tempData = {}
        tempData.isFull = DispatchData.CheckCondition(heroList, condCfg, false)
        tempData.index = key
        tempData.isBaseCond = false
        tempData.score = extraCondConfig[key]
        conditionData[key] = tempData
        if tempData.isFull == true then
            data.fullCondScore = data.fullCondScore + tempData.score
        end
    end
    return data
end



this.OnClickBack = function()
    LuaMgr.HidePanel(UIName.DispatchStatusPopup)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
        LuaMgr.AddClick(this.exitBtn, this.OnClickBack)
        LuaMgr.AddClick(this.maskCloseBtn, this.OnClickBack)
        LuaMgr.AddClick(this.beforeCancelBtn, this.OnBeforeCancelBtn)
        LuaMgr.AddClick(this.beforeConfirmBtn, this.OnOneKeyDispatch)
        LuaMgr.AddClick(this.endCloseBtn, this.OnEndCloseBtn)
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil or vm.behaviour.Params.Length < 1 then
            return
        end
        this.dispatchStatus = vm.behaviour.Params[0]
        if this.dispatchStatus == DispatchData.StrongholdStatus.DispatchWait then
            this.dispatchPreviewData = vm.behaviour.Params[1]
        end
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.exitBtn, this.OnClickBack)
        LuaMgr.RemoveClick(this.maskCloseBtn, this.OnClickBack)
        LuaMgr.RemoveClick(this.beforeCancelBtn, this.OnBeforeCancelBtn)
        LuaMgr.RemoveClick(this.beforeConfirmBtn, this.OnOneKeyDispatch)
        LuaMgr.RemoveClick(this.endCloseBtn, this.OnEndCloseBtn)
        UIScrollView.ClearItem("DispatchDataCell")
        UIScrollView.ClearItem("DispatchingDataCell")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)