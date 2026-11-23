require("ViewModel/CommonRewardItem")
require("Match3Game/PropTemplate")
require("Match3Game/ArtWordTemplate")

local objs = {
    elementBasePrefab = {path = "template/ElementCell", type = UITool.GameObject},
    passNumParent = {path = "root/Middle/LeftGroup/PassGroup/PassNum", type = UITool.GameObject},
    totalStepNumParent = {path = "root/Middle/LeftGroup/StepGroup", type = UITool.GameObject},
    leftStepNumParent = {path = "root/Middle/RightButtonGroup/StepTips/StepGroup", type = UITool.GameObject},
    gridParent = {path = "root/GridPanel/GridParent", type = UITool.GameObject},
    effectGroupAnim = {path = "root/EffectGroup", type = UITool.Animator},
    comboEffectGroup = {path = "root/EffectGroup/Combo", type = UITool.GameObject},
    xingyunEffectGroup = {path = "root/EffectGroup/Xingyun", type = UITool.GameObject},
    stepTipsObj = {path = "root/Middle/RightButtonGroup/StepTips", type = UITool.GameObject},
    curScoreText = {path = "root/Middle/LeftGroup/PassGroup/CurScoreParent/CurScore", type = UITool.Text},
    goalScore = {path = "root/Middle/LeftGroup/RewardGroup/GoalScore", type = UITool.Text},
    historyScore = {path = "root/Middle/LeftGroup/RewardGroup/HistoryScore", type = UITool.Text},
    propMaskParent = {path = "root/PropMaskParent", type = UITool.Image},
    middleRect = {path = "root/Middle", type = UITool.RectTransform},
    propItemMask = {path = "root/PropMaskParent/PropItemMask", type = UITool.RectTransform},
    propItemIcon = {path = "root/PropMaskParent/Icon", type = UITool.Image},
    propItemNameImg = {path = "root/PropMaskParent/NameImg", type = UITool.Image},
    propItemDesc = {path = "root/PropMaskParent/Desc", type = UITool.Text},
    propMaskParentCloseBtn = {path = "root/Middle/PropMaskParentCloseBtn", type = UITool.Button},
    scoreProgress = {path = "root/Middle/LeftGroup/RewardGroup/RewardParent/ScoreProgressBG/ScoreProgress", type = UITool.Image},
    reshuffleBtn = {path = "root/PropMaskParent/ReshuffleBtn", type = UITool.Button}
}

local this = {
    propUseItemCount = 3,
    rewardItemCount = 3,

    propUseItems = {},

    propUseItemDetails = {},

    rewardItems = {},
    passNumArt = nil,
    totalStepNumArt = nil,
    leftStepNumArt = nil,
    lastLeftMoves = nil,

    currentUsingPropType = nil,

    isInPropUsingState = false,
    passID = nil,
    oldScore = 0
}

this.InitParseObj = function()
    for i = 1, this.propUseItemCount do
        local tempData = {}
        tempData.path = "root/Middle/RightButtonGroup/Item" .. i
        tempData.type = UITool.GameObject
        objs["propTemplate" .. i] = tempData

        local tempData1 = {}
        tempData1.path = "root/DetailGroup" .. i
        tempData1.type = UITool.GameObject
        objs["detailGroup" .. i] = tempData1
    end
    for i = 1, this.rewardItemCount do
        local tempData = {}
        tempData.path = "root/Middle/LeftGroup/RewardGroup/RewardParent/ItemParent" .. i
        tempData.type = UITool.GameObject
        objs["rewardTemplate" .. i] = tempData
    end
    for i = 1, this.rewardItemCount do
        local tempData = {}
        tempData.path = "root/Middle/LeftGroup/RewardGroup/RewardParent/ScoreProgressBG/ProgressTxt" .. i
        tempData.type = UITool.Text
        objs["progressTxt" .. i] = tempData

        local tempData1 = {}
        tempData1.path = "root/Middle/LeftGroup/RewardGroup/RewardParent/ScoreProgressBG/ProgressTxtGray" .. i
        tempData1.type = UITool.Text
        objs["progressTxtGray" .. i] = tempData1
    end
end

this.InitObjItems = function()
    for i = 1, this.propUseItemCount do
        local propUseItem = PropTemplate.New(this["propTemplate" .. i], i, this.OnOpenUsePropMask, this.OnLookPropDetail)
        this.propUseItems[3000 + i] = propUseItem

        local detailGroup = PropTemplate.New(this["detailGroup" .. i], i, this.OnOpenUsePropMask, this.OnLookPropDetail)
        this.propUseItemDetails[3000 + i] = detailGroup
    end

    for i = 1, this.rewardItemCount do
        local data = {}

        data.rewardItem = CommonRewardItem.New(this["rewardTemplate" .. i], true, 0.5)
        data.progressTxt = this["progressTxt" .. i]
        data.progressTxtGray = this["progressTxtGray" .. i]
        this.rewardItems[i] = data
    end
    this.passNumArt = ArtWordTemplate.New(this.passNumParent, 3, "Match3Game", "ui_hd_hw_sx_guan")
    this.totalStepNumArt = ArtWordTemplate.New(this.totalStepNumParent, 3, "Match3Game", "ui_hd_hw_sx_sybs")
    this.leftStepNumArt = ArtWordTemplate.New(this.leftStepNumParent, 3, "Match3Game", "ui_hd_hw_sx_sybs")
    SetActive(this.stepTipsObj, false)
    this.offsetHalfX = LuaMgr.ScreenOffSet() / 2
    local orginPos = this.propItemMask.anchoredPosition
    this.propItemMaskPosX = orginPos.x
    SetActive(this.comboEffectGroup, false)
    SetActive(this.xingyunEffectGroup, false)
end

this.before_awake = function()
end

this.before_active = function()
    this.StartGame()
end

this.StartGame = function()
    if this.passID == nil then
        return
    end
    if this.gameManager == nil then
        this.gameManager = Match3GameManager.New(this.gridParent)
    else
        this.gameManager:Cleanup()
    end
    this.gameManager:StartGame(this.elementBasePrefab, this.passID)
    LuaMgr.AddUpdate(this.OnUpdate)
end

this.OnUpdate = function()
    this.gameManager:Update()
end

this.RefreshGameStatus = function(params)
    local data = params[0]
    local passData = data.passData
    if data.status == Match3Const.GameStatus.Started then
        this.passNumArt:SetNum(passData.ID - 10000)
        this.totalStepNumArt:SetNum(passData.totalStep)
        this.leftStepNumArt:SetNum(passData.totalStep)
        this.goalScore.text = tostring(passData.goalScore)
        local severDatas = DataMgr.Player.Eliminate
        if type(severDatas) ~= "table" then
            severDatas = {}
        end
        local scoreMap = severDatas.ScoreMap
        if type(scoreMap) ~= "table" then
            scoreMap = {}
        end
        this.historyScore.text = scoreMap[this.passID] or "0"
        SetActive(this.propMaskParent.gameObject, false)
        SetActive(this.propMaskParentCloseBtn.gameObject, false)
        for key, propUseItem in pairs(this.propUseItems) do
            local data = {}
            data.ID = key
            data.count = passData.specialitemData[key] or 0
            data.remainCount = this.gameManager.propManager:GetPropCount(key)
            propUseItem:SetData(data)
        end
        for key, propUseItem in pairs(this.propUseItemDetails) do
            local data = {}
            data.ID = key
            data.count = passData.specialitemData[key] or 0
            data.remainCount = this.gameManager.propManager:GetPropCount(key)
            propUseItem:SetData(data)
        end
        this.RewardItemData(passData.config)
        this.curScoreText.text = tostring(0)
        this.oldScore = 0
    elseif data.status == Match3Const.GameStatus.GameEnd then
        if not LuaMgr.IsPanelOpen(UIName.Match3GameResultPopup) then
            data.onExistCallback = function()
                LuaMgr.Back()
            end
            LuaMgr.ShowLuaPanel(UIName.Match3GameResultPopup, data)
        end
    end
end

this.OnMatch3ComboIncreased = function(params)
    local comboCount = params[0]
    if comboCount == 0 then
        return
    end
    SetActive(this.comboEffectGroup, true)
    this.effectGroupAnim:Play(Match3Const.ComboAnimName)
end

this.OnMatch3ComboEnded = function(params)
    SetActive(this.comboEffectGroup, false)
end

this.OnMatch3GameViewRefresh = function(params)
    local data = params[0]
    this.SetScoreChangeAnim(data.score)
    this.SetRewardCondProgress(data.score)
    if data.moves ~= this.lastLeftMoves then
        this.totalStepNumArt:SetNum(data.moves)
        this.lastLeftMoves = data.moves
        if data.moves <= 10 and data.moves > 0 and data.isMoveToScore ~= true then
            this.leftStepNumArt:SetNum(data.moves)
            SetActive(this.stepTipsObj, true)
            local func = function()
                SetActive(this.stepTipsObj, false)
                this.stepTisSequence = nil
            end
            if this.stepTisSequence ~= nil then
                this.stepTisSequence:Kill()
            end
            this.stepTisSequence = DOTWeen:Sequence()
            this.stepTisSequence:AppendInterval(1.05):OnComplete(func)
        end
    end
end

this.SetScoreChangeAnim = function(score)
    if this.oldScore == score then
        return
    end
    this.oldScore = score
    if this.scaleTweenSquence ~= nil then
        this.scaleTweenSquence:Kill()
        this.scaleTweenSquence = nil
        this.curScoreText.transform.localScale = Vector3.one
        this.curScoreText.text = tostring(score)
    end
    local onComplete = function ()
        this.curScoreText.text = tostring(this.oldScore)
    end
    this.scaleTweenSquence = DOTWeen:Sequence()
    this.scaleTweenSquence:Append(this.curScoreText.transform:DOScale(Vector3.one * 1.3, 0.3))
    this.scaleTweenSquence:Append(this.curScoreText.transform:DOScale(Vector3.one, 0.1))
    this.scaleTweenSquence:OnComplete(onComplete)
end


this.OnPropUseResult = function(params)
    local data = params[0]
    local remainCount = this.gameManager.propManager:GetPropCount(data.type)
    this.propUseItemDetails[data.type]:SetCount(remainCount)
    this.propUseItems[data.type]:SetCount(remainCount)
    this.OnClosePropRelation()
end

this.OnOperateLimitChange = function(params)
    this.isLimitOpeate = params[0]
end

this.OnSuperColorBallTrigger = function(params)
    local isShowSuperColorBallEffect = params[0]
    SetActive(this.xingyunEffectGroup, isShowSuperColorBallEffect)
end


this.OnOpenUsePropMask = function(propTemplate)
    if this.isLimitOpeate == true then
        return
    end
    local data = propTemplate.data
    if data.count < 1 then
        local tipsTxt = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_25205")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsTxt)
        return
    end
    if data.remainCount < 1 then
        local tipsTxt = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_25206")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsTxt)
        return
    end
    if this.lastLookPropDetailID ~= nil then
        SetActive(this.propUseItemDetails[this.lastLookPropDetailID].gameObject, false)
    end
    SetActive(this.propMaskParent.gameObject, true)
    SetActive(this.propMaskParentCloseBtn.gameObject, true)
    local atlaName = "Match3Game"
    local spriteName = "ui_hd_hw_sx_djzt"
    this.propItemIcon.sprite = LuaMgr.GetSprite(atlaName, string.format("%s_icon_%d", spriteName, propTemplate.itemIndex))
    this.propItemNameImg.sprite = LuaMgr.GetSprite(atlaName, string.format("%s_name_%d", spriteName, propTemplate.itemIndex))
    local elementConfig = ConfigMgr.Config.EliminateElementMap[tostring(data.ID)]
    this.propItemDesc.text = LuaMgr.GetLangText(elementConfig.DescLan)

    this.currentUsingPropType = data.ID
    this.isInPropUsingState = true

    local tempData = {}
    tempData.propType = this.currentUsingPropType
    tempData.isActive = this.isInPropUsingState
    LuaMgr.InvokeUIEventListeners(UIEventConst.PropPreUseStateChanged, tempData)
    this.SetUsePropMaskPos(propTemplate)
end


this.SetUsePropMaskPos = function(propTemplate)
    local orginPos = Vector2.zero
    orginPos.x = this.propItemMaskPosX - this.offsetHalfX
    orginPos.y = propTemplate:GetAnchorPosY()
    this.propItemMask.anchoredPosition = orginPos
    SetActive(this.reshuffleBtn.gameObject, propTemplate.data.ID == Match3Const.PropType.Reshuffle)
    local pos = this.propItemMask.transform.localPosition
    local material = this.propMaskParent.material
    material:SetFloat("_ImgX", pos.x)
    material:SetFloat("_ImgY", pos.y)
    if propTemplate.data.ID == Match3Const.PropType.Reshuffle then
        material:SetFloat("_RectW", 0)
        material:SetFloat("_RectH", 0)
    else
        local orginSize = 605
        material:SetFloat("_RectW", orginSize)
        material:SetFloat("_RectH", orginSize)
    end
end


this.OnLookPropDetail = function(propTemplate)
    if this.lastLookPropDetailID ~= nil then
        SetActive(this.propUseItemDetails[this.lastLookPropDetailID].gameObject, false)
    end
    SetActive(this.propMaskParentCloseBtn.gameObject, true)
    this.lastLookPropDetailID = propTemplate.data.ID
    SetActive(this.propUseItemDetails[this.lastLookPropDetailID].gameObject, true)
end


this.OnClosePropRelation = function()
    SetActive(this.propMaskParent.gameObject, false)
    SetActive(this.propMaskParentCloseBtn.gameObject, false)
    if this.lastLookPropDetailID ~= nil then
        SetActive(this.propUseItemDetails[this.lastLookPropDetailID].gameObject, false)
    end
    local tempData = {}
    tempData.isActive = false
    LuaMgr.InvokeUIEventListeners(UIEventConst.PropPreUseStateChanged, tempData)
end

this.OnClickReshuffleConfirm = function()
    if this.isInPropUsingState and this.currentUsingPropType == Match3Const.PropType.Reshuffle then
        LuaMgr.InvokeUIEventListeners(UIEventConst.UseReshuffleProp)
        this.isInPropUsingState = false
        this.currentUsingPropType = nil
    end
end

this.RewardItemData = function(config)
    if config == nil then
        return
    end
    local rewardConfig = config.Reward
    local condPercentConfig = config.Progress
    for i = 1, #this.rewardItems do
        local rewardConfig = rewardConfig[i]
        local condPercent = condPercentConfig[i]
        local rewardItemData = this.rewardItems[i]
        local percentNum = condPercent / 100.0
        rewardItemData.goalScore = percentNum * config.Rewardcredit
        rewardItemData.needTotalScore = config.Rewardcredit
        local item = rewardItemData.rewardItem
        local progressTxt = rewardItemData.progressTxt
        local progressTxtGray = rewardItemData.progressTxtGray
        if rewardConfig ~= nil then
            SetActive(item.gameObject, true)
            item:SetData1(rewardConfig)
            item:SetStatus(CommonRewardItem.Status.None)
            local str = string.format("%.f%%", percentNum)
            progressTxt.text = str
            progressTxtGray.text = str
            SetActive(progressTxt.gameObject, false)
            SetActive(progressTxtGray.gameObject, true)
        else
            SetActive(item.gameObject, false)
        end
    end
    this.scoreProgress.fillAmount = 0
end

this.SetRewardCondProgress = function(score)
    local needTotalScore = 0
    for i = 1, #this.rewardItems do
        local rewardItemData = this.rewardItems[i]
        local progressTxt = rewardItemData.progressTxt
        local progressTxtGray = rewardItemData.progressTxtGray
        SetActive(progressTxt.gameObject, score >= rewardItemData.goalScore)
        SetActive(progressTxtGray.gameObject, score < rewardItemData.goalScore)
        needTotalScore = rewardItemData.needTotalScore

        local item = rewardItemData.rewardItem
        if score >= rewardItemData.goalScore then
            item:SetStatus(CommonRewardItem.Status.CanGet)
        else
            item:SetStatus(CommonRewardItem.Status.None)
        end
    end
    this.scoreProgress.fillAmount = score * 1.0 / needTotalScore
end

this.OnClickBack = function()
    if this.isLimitOpeate == true then
        return
    end
    local data = {}
    data.onExistCallback = function()
        LuaMgr.HidePanel(UIName.Match3GamePausePopup)
        local func = function()
            this.vmBehaviour:UpdateTopBar("", nil)
            LuaMgr.Back()
        end
        LuaMgr.NextFrame(func)
    end
    data.onReplayCallback = function()
        LuaMgr.HidePanel(UIName.Match3GamePausePopup)
        this.gameManager:ResetGame()
    end
    LuaMgr.ShowLuaPanel(UIName.Match3GamePausePopup, data)
end

this.SetTestFunc = function(obj)
    local replayCallback = function()
        if this.isLimitOpeate == true then
            return
        end
        this.gameManager:ResetGame()
    end
    local replayBtn = obj.transform:Find("root/TestBtn"):GetComponent(UITool.Button)
    LuaMgr.AddClick(replayBtn, replayCallback)
    SetActive(replayBtn.gameObject, LuaMgr.IsDebug())
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        LuaMgr.AddUIEventListener(UIEventConst.Match3GameStatus, this.RefreshGameStatus)
        LuaMgr.AddUIEventListener(UIEventConst.Match3ComboIncreased, this.OnMatch3ComboIncreased)
        LuaMgr.AddUIEventListener(UIEventConst.Match3ComboEnded, this.OnMatch3ComboEnded)
        LuaMgr.AddUIEventListener(UIEventConst.Match3GameViewRefresh, this.OnMatch3GameViewRefresh)
        LuaMgr.AddUIEventListener(UIEventConst.PropUseResult, this.OnPropUseResult)
        LuaMgr.AddUIEventListener(UIEventConst.Match3OperateLimitChange, this.OnOperateLimitChange)
        LuaMgr.AddUIEventListener(UIEventConst.SuperColorBallTriggered, this.OnSuperColorBallTrigger)
        this.InitParseObj()
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.SetTestFunc(vm.behaviour.gameObject)
        this.InitObjItems()
        LuaMgr.AddClick(this.propMaskParentCloseBtn, this.OnClosePropRelation)
        LuaMgr.AddClick(this.reshuffleBtn, this.OnClickReshuffleConfirm)
        this.before_awake()
    end,
    before_active = function(vm)
        this.vmBehaviour = vm.behaviour
        vm.behaviour:UpdateTopBar("", this.OnClickBack)
        if vm.behaviour.Params and vm.behaviour.Params.Length > 0 then
            this.passID = vm.behaviour.Params[0].Id
        end
        this.before_active()
    end,
    before_deactive = function(vm)
        this.OnClosePropRelation()
        LuaMgr.RemoveUpdate(this.OnUpdate)
        this.passID = nil
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.propMaskParentCloseBtn, this.OnClosePropRelation)
        LuaMgr.RemoveClick(this.reshuffleBtn, this.OnClickReshuffleConfirm)
        LuaMgr.RemoveUIEventListener(UIEventConst.Match3GameStatus, this.RefreshGameStatus)
        LuaMgr.RemoveUIEventListener(UIEventConst.Match3ComboIncreased, this.OnMatch3ComboIncreased)
        LuaMgr.RemoveUIEventListener(UIEventConst.Match3ComboEnded, this.OnMatch3ComboEnded)
        LuaMgr.RemoveUIEventListener(UIEventConst.Match3GameViewRefresh, this.OnMatch3GameViewRefresh)
        LuaMgr.RemoveUIEventListener(UIEventConst.PropUseResult, this.OnPropUseResult)
        LuaMgr.RemoveUIEventListener(UIEventConst.Match3OperateLimitChange, this.OnOperateLimitChange)
        LuaMgr.RemoveUIEventListener(UIEventConst.SuperColorBallTriggered, this.OnSuperColorBallTrigger)
        LuaMgr.RemoveUpdate(this.OnUpdate)
        if this.gameManager ~= nil then
            this.gameManager:Destroy()
        end
        ArtWordTemplate.Clear()
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)