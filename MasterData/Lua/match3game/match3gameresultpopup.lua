local objs = {
    animator = {path = "root", type = UITool.Animator},
    maskCloseBtn = {path = "root/Mask", type = UITool.Button},
    victoryObj = {path = "root/Middle/SuccObj", type = UITool.GameObject},
    victoryEffectObj = {path = "root/Middle/SuccObj/EffectGroup", type = UITool.GameObject},
    victoryRewardObj = {path = "root/Middle/SuccObj/RewardGroup", type = UITool.GameObject},
    failedObj = {path = "root/Middle/FailedObj", type = UITool.GameObject},
    curScoreText = {path = "root/Middle/SuccObj/RewardGroup/CurScoreGroup/CurScoreTxt", type = UITool.Text},
    historyScoreText = {path = "root/Middle/SuccObj/RewardGroup/HistoryScoreGroup/HistoryScoreTxt", type = UITool.Text},
    breakRecordObj = {path = "root/Middle/SuccObj/RewardGroup/HistoryScoreGroup/BreakRecordObj", type = UITool.GameObject},
    noChangeObj = {path = "root/Middle/SuccObj/RewardGroup/HistoryScoreGroup/NoChangeObj", type = UITool.GameObject}
}

local this = {
    rewardItemCount = 3,

    rewardItems = {},
    internalData = {}
}

this.InitParseObj = function()
    for i = 1, this.rewardItemCount do
        local tempData = {}
        tempData.path = "root/Middle/SuccObj/RewardGroup/ItemParent" .. i
        tempData.type = UITool.GameObject
        objs["rewardTemplate" .. i] = tempData
    end
end

this.InitObjItems = function()
    for i = 1, this.rewardItemCount do
        local rewardItem = CommonRewardItem.New(this["rewardTemplate" .. i], true)
        this.rewardItems[i] = rewardItem
    end
end

this.before_awake = function()
end

this.before_active = function()
    SetActive(this.failedObj, this.gameResult == Match3Const.ResultType.Failed)
    SetActive(this.victoryObj, this.gameResult == Match3Const.ResultType.Victory)
    if this.gameResult == Match3Const.ResultType.Victory then
        Match3Const.PlaySound(Match3Const.AudioNameIndex.EliminateWin)
        this.SetVictoryUI()
    else
        Match3Const.PlaySound(Match3Const.AudioNameIndex.EliminateLost)
        this.animator:Play(Match3Const.GameFaildAniName)
    end
end

this.OnCalScoreEnd = function(params)
    if this.victoryCoroutine ~= nil then
        coroutine_runner.stop(this.victoryCoroutine)
        this.victoryCoroutine = nil
    end
    local func = function()
        coroutine_runner.wait(1.5)
        this.maskCloseBtn.interactable = true
        SetActive(this.victoryEffectObj, false)
        SetActive(this.victoryRewardObj, true)
        local data = params[0]
        this.ShowRewardUI(data.finalScore)
        this.animator:Play(Match3Const.GameRewardAniName)
    end
    this.victoryCoroutine = coroutine_runner.start(func)
end

this.SetVictoryUI = function()
    SetActive(this.victoryEffectObj, true)
    SetActive(this.victoryRewardObj, false)
    this.animator:Play(Match3Const.GameSuccAniName)
    this.maskCloseBtn.interactable = false
end

this.ShowRewardUI = function(finalScore)
    local severDatas = DataMgr.Player.Eliminate
    if type(severDatas) ~= "table" then
        severDatas = {}
    end
    local scoreMap = severDatas.ScoreMap
    if type(scoreMap) ~= "table" then
        scoreMap = {}
    end

    local rewards = severDatas.Rewards
    if type(rewards) ~= "table" then
        rewards = {}
    end
    local rewardConfig = this.internalData.reward
    for i = 1, #this.rewardItems do
        local rewardConfig = rewardConfig[i]
        local rewardItem = this.rewardItems[i]
        rewardItem:SetData1(rewardConfig)
        if rewards[tostring(this.internalData.passID)] then
            rewardItem:SetStatus(CommonRewardItem.Status.Got)
        end
    end
    this.curScoreText.text = tostring(finalScore)
    local historyScore = scoreMap[this.internalData.passID] or 0
    this.historyScoreText.text = tostring(historyScore)
    SetActive(this.noChangeObj, historyScore >= finalScore)
    SetActive(this.breakRecordObj, historyScore < finalScore)

    this.OnGetReward(finalScore)
end

this.OnGetReward = function(finalScore)
    local data = {}
    data.Id = this.internalData.passID
    data.Score = finalScore
    local callback = function(result)
        local res = json.decode(result)
        if res.code ~= 0 then
            return
        end
        local resultData = res.result
        this.rewardItemDatas = {}
        if type(resultData) == "table" and type(resultData.Items) == "table" then
            local rewards = resultData.Items
            for i, v in pairs(rewards) do
                local item = {ID = v.id, Count = v.count}
                table.insert(this.rewardItemDatas, item)
            end
        end
    end
    ApiMgr.Request("eliminate/settlement", data, true, callback, nil, true)
end

this.OnClose = function()
    LuaMgr.HidePanel(UIName.Match3GameResultPopup)
    this.internalData.onExistCallback()
    if this.rewardItemDatas ~= nil and #this.rewardItemDatas > 0 then
        local func = function()
            LuaMgr.ShowItemGetPanel(this.rewardItemDatas)
            this.rewardItemDatas = {}
        end
        LuaMgr.NextFrame(func)
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.InitParseObj()
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.InitObjItems()
        LuaMgr.AddClick(this.maskCloseBtn, this.OnClose)
        LuaMgr.AddUIEventListener(UIEventConst.Match3CalStatusEnd, this.OnCalScoreEnd)
        this.before_awake()
    end,
    before_active = function(vm)
        if vm.behaviour.Params and vm.behaviour.Params.Length > 0 then
            this.internalData = vm.behaviour.Params[0]
            this.gameResult = this.internalData.gameResult
        end
        if this.internalData == nil then
            LuaDebug.error("Match3GameResultPopup hook.before_active data is Null")
            return
        end
        this.before_active()
    end,
    before_deactive = function(vm)
        if this.victoryCoroutine ~= nil then
            coroutine_runner.stop(this.victoryCoroutine)
            this.victoryCoroutine = nil
        end
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.maskCloseBtn, this.OnClose)
        LuaMgr.RemoveUIEventListener(UIEventConst.Match3CalStatusEnd, this.OnCalScoreEnd)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)