require("ViewModel/JiYeChangSheng/ViewItem/JYCSGameBlock")
require("ViewModel/JiYeChangSheng/ViewItem/JYCSGameRoleItem")
local objs = {
    rootAnim = {path = "root", type = UITool.Animator},
    monsterBGEffect = {path = "root/Middle/GridParent/eff_camera", type = UITool.GameObject},
    monsterSleepEffect = {path = "root/Middle/GridParent/MonsterObj/eff_sleep", type = UITool.GameObject},
    gridParent = {path = "root/Middle/GridParent", type = UITool.Transform},
    progressText = {path = "root/Middle/Progress/ProgressText", type = UITool.Text},
    progressSlider = {path = "root/Middle/Progress/Slider", type = UITool.Slider},
    passName = {path = "root/Middle/Name/name_txt", type = UITool.Text},
    totalScore = {path = "root/Right/TotalScoreBG/TotalScore", type = UITool.Text},
    playerObj = {path = "root/Middle/GridParent/PlayerObj", type = UITool.GameObject},
    monsterObj = {path = "root/Middle/GridParent/MonsterObj", type = UITool.GameObject},
    rollNumPanel = {path = "root/Right/RollNumPanel", type = UITool.GameObject},
    rollBtn = {path = "root/Right/FixRollBtn", type = UITool.Button},
    rollCount = {path = "root/Right/FixRollBtn/RemainTimes", type = UITool.Text},
    fixRollBtn = {path = "root/Right/RollBtn", type = UITool.Button},
    fixRollCount = {path = "root/Right/RollBtn/RemainTimes", type = UITool.Text},
    jumpBtn = {path = "root/Right/JumpBtn", type = UITool.Button},
    lateastCalBtn = {path = "root/Left/LateastCalBtn", type = UITool.Button},
    bgBtn = {path = "root/BG", type = UITool.Button},
    introAnimGroup = {path = "root/IntroAnimGroup", type = UITool.GameObject},

    gmPanel = {path = "root/GM", type = UITool.GameObject},
    fixRollToggle = {path = "root/GM/IsFixRollToggle", type = UITool.Toggle},
    fixRollNumField = {path = "root/GM/InputField", type = UITool.InputField}

}

local this = {
    blockNum = 44,

    blockItems = {},
    skipWaitTime = 0,
    fixRollBtnCallback = {},
    roleMoveData = nil,
    roleRotateElapsed = 0,
    isRoleRotating = false,
    isRoleTweenMoving = false,
    directDatas = {
        [1] = {1, 8},
        [2] = {33, 44},
        [3] = {23, 32},
        [4] = {9, 22}
    },

    curGameStep = JYCSConst.GameStep.None,
    moveElapsed = 0,
    moveDelay = JYCSConst.RoleMoveDelay,
    roleMoveAnimName = "ani_JYCSGamePanel_move",
    rootAnimName = "ani_JYCSGamePanel_root"
}



this.before_awake = function()
    this.playerItem = JYCSGameRoleItem.New(this.playerObj)
    this.monsterItem = JYCSGameRoleItem.New(this.monsterObj)
    this.InitBlockItem()
end

this.BatchInitNode = function()
    for i = 1, this.blockNum do
        local name = string.format("Block%d", i)
        local path = string.format("root/Middle/GridParent/%s", name)
        objs[name] = {path = path, type = UITool.GameObject}
    end

    for i = 1, 6 do
        local name = string.format("FixRoll%d", i)
        local path = string.format("root/Right/RollNumPanel/" .. name)
        objs[name] = {path = path, type = UITool.Button}
    end
end

this.InitBlockItem = function()
    for i = 1, this.blockNum do
        local name = string.format("Block%d", i)
        local blockObj = this[name]
        if blockObj ~= nil then
            local blockItem = JYCSGameBlock.New()
            blockItem.gameObject = blockObj
            blockItem:Init()
            this.blockItems[i] = blockItem
        end
    end
    SetActive(this.playerItem.gameObject, false)
    this.SetMonsterVisible(false)
end

this.SetMonsterVisible = function(visible)
    local showMonster = visible == true
    SetActive(this.monsterItem.gameObject, showMonster)
    SetActive(this.monsterBGEffect, showMonster)
    SetActive(this.monsterSleepEffect, showMonster and JYCSData.IsMonsterSleeping(this.mapData))
end

this.SetRollLocked = function(isLocked)
    this.isRollLocked = isLocked == true
end

this.IsRollLocked = function()
    return this.isRollLocked == true
end

this.RefreshTotalScore = function()
    local _, totalScore = JYCSData.GetScore()
    this.totalScore.text = tostring(totalScore)
end

this.RefreshSkipButton = function(skipWaitTime)
    LuaMgr.RemoveTimer(TimerConst.JYCSGameSkipTimer)
    this.skipWaitTime = math.max(0, tonumber(skipWaitTime) or 0)
    SetActive(this.jumpBtn.gameObject, false)
    if this.mapData == nil or JYCSData.IsEndlessMap(this.mapData) == true then
        return
    end
    local skipTime = math.max(0, tonumber(this.mapData.Config.SkipTime) or 0)
    if this.skipWaitTime >= skipTime then
        SetActive(this.jumpBtn.gameObject, true)
        return
    end
    LuaMgr.AddTimer(TimerConst.JYCSGameSkipTimer, this.OnShowGameSkipBtn, 1, -1, true)
end

this.RefreshGamePanel = function(keepRollLocked)
    this.EndTurn(keepRollLocked)
    local mapData = JYCSData.GetMapData()
    if mapData == nil then
        return false
    end
    this.isSkipRequesting = false
    this.mapData = mapData
    local blockDatas = mapData.BlockDatas
    if #blockDatas ~= #this.blockItems then
        LuaDebug.error("JYCSGamePanel: blockDatas length is not equal to blockItems length")
    end
    for i = 1, #this.blockItems do
        this.blockItems[i]:SetData(blockDatas[i])
    end
    this.curPlayerBlockIndex = JYCSData.GetBlockIndex(mapData, JYCSData.GetCurBlock()) or 1
    this.turnCount = JYCSData.GetServerRound()
    this.curMonsterBlockIndex = JYCSData.GetMonsterBlockIndex(mapData, this.turnCount)
    this.SetRoleBlock(this.playerItem, this.curPlayerBlockIndex)
    local showMonster = JYCSData.ShouldShowMonster(mapData, this.turnCount)
    this.SetMonsterVisible(showMonster)
    if showMonster == true then
        this.SetRoleBlock(this.monsterItem, this.curMonsterBlockIndex)
    end
    this.curGameStep = JYCSConst.GameStep.None
    this.eventChainCount = 0
    this.moveDelay = JYCSConst.RoleMoveDelay
    this.moveElapsed = 0
    this.passName.text = LuaMgr.GetLangText(mapData.Config.NameLan)
    this.RefreshProgress()
    this.RefreshRollTimes()
    this.RefreshTotalScore()
    this.SetPanelVisible()
    this.RefreshSkipButton(0)
    return true
end

this.before_active = function()
    SetActive(this.introAnimGroup, false)
    if this.RefreshGamePanel(true) == true and this.CheckMonsterCollisionOnEnter() == true then
        return
    end
    this.SetRollLocked(false)
end

this.RefreshProgress = function()
    if this.mapData == nil then
        return
    end
    local maxProgress = 100
    local curValue = JYCSData.GetDangerValue()
    this.progressText.text = string.format(LuaMgr.GetLangText("JYCSGamePanel_0"), curValue, maxProgress)
    this.progressSlider.value = curValue / maxProgress
end

this.RefreshRollTimes = function()
    if this.mapData == nil then
        return
    end
    local remainRollTimes, maxRollTimes = JYCSData.GetCostRollRemainTimes(this.mapData)
    this.fixRollCount.text = string.format("%d/%d", remainRollTimes, maxRollTimes)
end

this.CheckCanUseCostRoll = function()
    if JYCSData.CanUseCostRoll(this.mapData) == true then
        return true
    end
    this.SetPanelVisible(false)
    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("JYCSGamePanel_1"))
    return false
end

this.OnShowGameSkipBtn = function()
    if this.mapData == nil then
        return
    end
    if JYCSData.IsEndlessMap(this.mapData) == true then
        LuaMgr.RemoveTimer(TimerConst.JYCSGameSkipTimer)
        SetActive(this.jumpBtn.gameObject, false)
        return
    end
    this.skipWaitTime = this.skipWaitTime + 1
    if this.skipWaitTime < this.mapData.Config.SkipTime then
        return
    end
    LuaMgr.RemoveTimer(TimerConst.JYCSGameSkipTimer)
    SetActive(this.jumpBtn.gameObject, true)
end





this.OnGameStepUpdate = function()
    if this.isRoleRotating == true then
        this.roleRotateElapsed = this.roleRotateElapsed + UnityEngine.Time.deltaTime
        local rotateDelay = tonumber(JYCSConst.RoleRotateDelay) or 0
        if this.roleRotateElapsed >= rotateDelay then
            this.StartRoleTweenMove()
        end
        return
    end
    if this.isRoleTweenMoving == true then
        return
    end
    if this.curGameStep == JYCSConst.GameStep.None then
        return
    elseif this.curGameStep == JYCSConst.GameStep.PlayerMove or this.curGameStep == JYCSConst.GameStep.MonsterMove then
        local isPlayer = this.curGameStep == JYCSConst.GameStep.PlayerMove
        this.RoleMove(isPlayer)
    elseif this.curGameStep == JYCSConst.GameStep.PlayerMoveEnd then
        this.curGameStep = JYCSConst.GameStep.TriggerEvent
        if this.CheckPlayerMeetMonster() == true then
            return
        end
        this.TriggerBlockEvent()
    elseif this.curGameStep == JYCSConst.GameStep.TriggerEventEnd then
    elseif this.curGameStep == JYCSConst.GameStep.MonsterMoveEnd then
        this.CheckMonsterBattle()
    end
end

this.OnCommonPopupClose = function(params)
    if params == nil or params.Length == 0 then
        return
    end
    if this.mapData == nil then
        return
    end
    local data = params[0]
    if data.Type == JYCSConst.GameCommonPopupType.Roll then
        this.curPlayerBlockIndex = JYCSData.GetBlockIndex(this.mapData, JYCSData.GetCurBlock()) or 1
        this.eventChainCount = 0
        local targetIndex = JYCSData.GetTargetBlockIndex(this.mapData, this.curPlayerBlockIndex, data.RollNum)
        this.StartPlayerMove(targetIndex, data.IsCostRoll, nil, data.RollNum)
    elseif data.Type == JYCSConst.GameCommonPopupType.Event then
        this.ShowEventResult(data)
    end
end

this.OnSkipMapIntroComplete = function()
    this.RefreshGamePanel()
end

this.OnEventPopupClose = function(params)
    if params == nil or params.Length == 0 then
        return
    end
    if this.mapData == nil then
        return
    end
    local data = params[0]
    if data.IsSkipMapResult == true then
        this.SetIntroAnim(this.OnSkipMapIntroComplete)
        return
    end
    if data.Type == JYCSConst.GameEventPopupType.Success and data.BlockData ~= nil and JYCSData.CheckIsMapLastBlock(data.BlockData.ID) == true then
        local callback = function()
            this.SubmitBlockEvent(data)
        end
        this.SetIntroAnim(callback)
        return
    end
    if data.Type == JYCSConst.GameEventPopupType.Lose or data.Type == JYCSConst.GameEventPopupType.Success then
        this.SubmitBlockEvent(data)
    end
end





this.StartPlayerMove = function(targetIndex, isCostRoll, pendingTriggerBlockID, moveStep)
    local blockCount = #this.blockItems
    local startIndex = this.curPlayerBlockIndex
    if blockCount <= 0 or startIndex == nil or targetIndex == nil then
        this.EndTurn()
        return
    end
    local step = JYCSData.GetPlayerMoveStep(this.mapData, startIndex, moveStep)
    if step ~= nil then
        targetIndex = JYCSData.GetTargetBlockIndex(this.mapData, startIndex, step)
        if pendingTriggerBlockID ~= nil then
            pendingTriggerBlockID = JYCSData.GetBlockIDByIndex(this.mapData, targetIndex)
            JYCSData.UpdateCurBlock(pendingTriggerBlockID)
        end
    end
    this.curPlayerTargetIndex = math.max(1, math.min(math.floor(tonumber(targetIndex) or startIndex), blockCount))
    this.pendingTriggerBlockID = pendingTriggerBlockID
    this.currentEventIsCostRoll = isCostRoll == true
    this.moveElapsed = 0
    local isEndlessMap = JYCSData.IsEndlessMap(this.mapData)
    if isEndlessMap == true and step ~= nil and step ~= 0 then
        local expectedTargetIndex = JYCSData.GetTargetBlockIndex(this.mapData, startIndex, step)
        this.curPlayerMoveDirection = step > 0 and 1 or -1
        if expectedTargetIndex == this.curPlayerTargetIndex then
            this.curPlayerMoveRemainStep = math.abs(step)
        elseif this.curPlayerMoveDirection > 0 then
            this.curPlayerMoveRemainStep = (this.curPlayerTargetIndex - startIndex) % blockCount
        else
            this.curPlayerMoveRemainStep = (startIndex - this.curPlayerTargetIndex) % blockCount
        end
    else
        local indexOffset = this.curPlayerTargetIndex - startIndex
        this.curPlayerMoveDirection = indexOffset >= 0 and 1 or -1
        this.curPlayerMoveRemainStep = math.abs(indexOffset)
    end
    if this.curPlayerMoveRemainStep <= 0 then
        this.curGameStep = JYCSConst.GameStep.PlayerMoveEnd
    else
        this.curGameStep = JYCSConst.GameStep.PlayerMove
    end
end

this.TriggerBlockEvent = function()
    this.eventChainCount = this.eventChainCount + 1
    if this.eventChainCount > JYCSConst.MaxEventChainCount then
        LuaDebug.error("this.TriggerBlockEvent 事件链超过最大次数")
        this.EndTurn()
        return
    end
    local blockItem = this.blockItems[this.curPlayerBlockIndex]
    if blockItem == nil or blockItem.data == nil then
        LuaDebug.error("this.TriggerBlockEvent 当前地块事件数据错误")
        this.EndTurn()
        return
    end
    local ignoreBlockStatus = this.pendingTriggerBlockID == blockItem.data.ID
    this.currentEventIsMoveEvent = ignoreBlockStatus
    this.pendingTriggerBlockID = nil
    if ignoreBlockStatus == false and blockItem.data.BlockStatus == JYCSConst.BlockStatus.Finish then
        if this.currentEventIsCostRoll == true then
            this.SubmitEmptyIconBlock(blockItem.data)
        else
            this.EndEventChain()
        end
        return
    end
    local blockConfig = blockItem.data.Config
    if blockConfig ~= nil and (blockConfig.Icon == nil or blockConfig.Icon == "") then
        this.SubmitEmptyIconBlock(blockItem.data)
        return
    end
    local eventData = JYCSData.GetEventConfigByBlock(blockItem.data, ignoreBlockStatus)
    if eventData == nil then
        if this.currentEventIsCostRoll == true then
            this.SubmitEmptyIconBlock(blockItem.data)
        else
            this.EndEventChain()
        end
        return
    end
    local data = {
        Type = JYCSConst.GameCommonPopupType.Event,
        BlockData = blockItem.data,
        EventData = eventData,
        IsCostRoll = this.currentEventIsCostRoll == true,
        IsMoveEvent = this.currentEventIsMoveEvent == true,
        SelectIndex = 1
    }
    this.currentEventIsCostRoll = false
    this.currentEventIsMoveEvent = false
    local eventType = tonumber(eventData.Type) or eventData.Type
    if eventType == JYCSConst.MapEventType.Select then
        LuaMgr.ShowLuaPanel(UIName.JYCSGameCommonPopup, data)
    elseif eventType == JYCSConst.MapEventType.Battle then
        this.EnterBlockBattle(data)
    else
        this.ShowEventResult(data)
    end
end

this.SubmitEmptyIconBlock = function(blockData)
    local isCostRoll = this.currentEventIsCostRoll == true
    local isMoveEvent = this.currentEventIsMoveEvent == true
    this.currentEventIsCostRoll = false
    this.currentEventIsMoveEvent = false
    local requestData = JYCSData.BuildEmptyBlockEventRequest(this.mapData, blockData, isCostRoll, isMoveEvent)
    this.curGameStep = JYCSConst.GameStep.TriggerEventEnd
    local eventData = {
        Id = JYCSConst.EmptyIconEventID,
        Type = JYCSConst.MapEventType.Empty
    }
    this.DealBlockEvent(requestData, eventData)
end

this.EnterBlockBattle = function(data)
    local eventData = data.EventData
    local blockData = data.BlockData
    local dungeonID = JYCSData.GetEventDungeonID(eventData)
    if eventData == nil or blockData == nil or dungeonID == nil or dungeonID == "" then
        LuaDebug.error("this.EnterBlockBattle battle event config error")
        this.EndTurn()
        return
    end
    local extraParams = JYCSData.BuildBattleExtraParams(blockData.ID, eventData.Type, data.IsCostRoll, eventData.Id, data.IsMoveEvent)
    this.currentEventIsMoveEvent = data.IsMoveEvent == true
    this.SaveBattleTurnState("BlockBattle")
    this.PauseTurnForBattle()
    this.EnterBattle(dungeonID, dungeonID, extraParams)
end

this.ShowEventResult = function(data)
    local eventData = data.EventData
    if eventData == nil then
        this.EndTurn()
        return
    end
    local eventType = tonumber(eventData.Type) or eventData.Type
    if eventType == JYCSConst.MapEventType.Finish and JYCSData.IsEndlessMap(this.mapData) == true then
        this.SubmitBlockEvent(data)
        return
    end
    local popupType = eventType == JYCSConst.MapEventType.Finish and JYCSConst.GameEventPopupType.Success or JYCSConst.GameEventPopupType.Lose
    local paramData = {
        Type = popupType,
        BlockData = data.BlockData,
        EventData = eventData,
        SelectIndex = data.SelectIndex or 1,
        IsCostRoll = data.IsCostRoll == true,
        IsMoveEvent = data.IsMoveEvent == true,
        Score = JYCSData.GetScore(),
        Name = LuaMgr.GetLangText(eventData.NameLan),
        Desc = LuaMgr.GetLangText(eventData.StoryLan)
    }
    if eventData.Type == JYCSConst.MapEventType.Select then
        paramData.Desc = LuaMgr.GetLangText(eventData.ResultLan[paramData.SelectIndex])
    end
    LuaMgr.ShowLuaPanel(UIName.JYCSGameEventPopup, paramData)
end

this.SubmitBlockEvent = function(data)
    local blockData = data.BlockData
    local eventData = data.EventData
    if blockData == nil or eventData == nil then
        LuaDebug.error("this.SubmitBlockEvent 事件数据错误")
        this.EndTurn()
        return
    end
    local selectIndex = data.SelectIndex or 1
    local requestData = JYCSData.BuildBlockEventRequest(this.mapData, blockData, eventData, selectIndex, data.IsCostRoll, data.IsMoveEvent)
    this.curGameStep = JYCSConst.GameStep.TriggerEventEnd
    this.DealBlockEvent(requestData, eventData)
end





this.ClearRoleMoveData = function()
    if this.playerItem ~= nil then
        this.playerItem:ClearMoveTween()
    end
    if this.monsterItem ~= nil then
        this.monsterItem:ClearMoveTween()
    end
    this.roleMoveData = nil
    this.roleRotateElapsed = 0
    this.isRoleRotating = false
    this.isRoleTweenMoving = false
end

this.GetRoleDirectByPos = function(curPos, targetPos)
    if curPos.x < targetPos.x and curPos.y < targetPos.y then
        return 1
    elseif curPos.x > targetPos.x and curPos.y < targetPos.y then
        return 4
    elseif curPos.x > targetPos.x and curPos.y > targetPos.y then
        return 3
    elseif curPos.x < targetPos.x and curPos.y > targetPos.y then
        return 2
    end
    return nil
end

this.SetRoleDirectByBlockIndex = function(roleItem, curBlockIndex, targetBlockIndex)
    local curBlockItem = this.blockItems[curBlockIndex]
    local targetBlockItem = this.blockItems[targetBlockIndex]
    if roleItem == nil or curBlockItem == nil or targetBlockItem == nil then
        return
    end
    local curPos = curBlockItem:GetAnchoredPos()
    local targetPos = targetBlockItem:GetAnchoredPos()
    if curPos == nil or targetPos == nil then
        return
    end
    local direct = this.GetRoleDirectByPos(curPos, targetPos)
    if direct ~= nil then
        roleItem:SetRoleDirect(direct)
    end
end

this.SetRoleInitDirect = function(roleItem, blockIndex)
    local targetBlockIndex = nil
    if roleItem == this.monsterItem then
        targetBlockIndex = blockIndex % #this.blockItems + 1
    elseif blockIndex < #this.blockItems then
        targetBlockIndex = blockIndex + 1
    elseif blockIndex > 1 then
        this.SetRoleDirectByBlockIndex(roleItem, blockIndex - 1, blockIndex)
        return
    end
    if targetBlockIndex ~= nil then
        this.SetRoleDirectByBlockIndex(roleItem, blockIndex, targetBlockIndex)
    end
end

this.RefreshRoleSibling = function()
    local mainRolePos = this.playerItem.rectTrans.anchoredPosition
    local monsterRolePos = this.monsterItem.rectTrans.anchoredPosition
    if mainRolePos.y <= monsterRolePos.y then
        this.playerItem.gameObject.transform:SetAsLastSibling()
    else
        this.monsterItem.gameObject.transform:SetAsLastSibling()
    end
end

this.SetRoleMoveData = function(roleItem, targetPos, callback)
    this.roleMoveData = {
        RoleItem = roleItem,
        TargetPos = targetPos,
        Callback = callback
    }
end

this.StartRoleTweenMove = function()
    local moveData = this.roleMoveData
    if moveData == nil then
        this.ClearRoleMoveData()
        return
    end
    this.isRoleRotating = false
    this.roleRotateElapsed = 0
    this.isRoleTweenMoving = true
    local roleItem = moveData.RoleItem
    if roleItem == nil or roleItem.gameObject == nil then
        this.OnRoleMoveFail(moveData.Callback)
        return
    end
    roleItem:MoveToPos(moveData.TargetPos, this.moveDelay, this.roleMoveAnimName, this.CompleteRoleMove)
end

this.CompleteRoleMove = function()
    local moveData = this.roleMoveData
    this.roleMoveData = nil
    this.roleRotateElapsed = 0
    this.isRoleRotating = false
    this.isRoleTweenMoving = false
    if moveData == nil then
        return
    end
    if moveData.Callback ~= nil then
        moveData.Callback()
    end
end

this.OnRoleMoveFail = function(callback)
    this.ClearRoleMoveData()
    if callback ~= nil then
        callback()
    end
end

this.SetRoleBlock = function(roleItem, blockIndex, lastBlockIndex, callback)
    local blockItem = this.blockItems[blockIndex]
    if roleItem == nil or blockItem == nil then
        this.OnRoleMoveFail(callback)
        return
    end
    local targetPos = blockItem:GetAnchoredPos()
    if targetPos == nil then
        this.OnRoleMoveFail(callback)
        return
    end
    SetActive(roleItem.gameObject, true)
    local lastBlockItem = this.blockItems[lastBlockIndex]
    if lastBlockItem == nil then
        this.SetRoleInitDirect(roleItem, blockIndex)
        roleItem:SetTransPos(targetPos)
        if callback ~= nil then
            callback()
        end
        return
    end
    this.SetRoleMoveData(roleItem, targetPos, callback)
    local curPos = lastBlockItem:GetAnchoredPos()
    local direct = this.GetRoleDirectByPos(curPos, targetPos)
    if direct == nil then
        roleItem:SetTransPos(targetPos)
        if callback ~= nil then
            callback()
        end
        return
    end
    this.isRoleRotating = true
    this.roleRotateElapsed = 0
    roleItem:SetRoleDirect(direct)
    this.RefreshRoleSibling()
end

this.StartMonsterMove = function()
    if this.mapData == nil or JYCSData.GetMonsterDungeonID(this.mapData) == nil then
        this.EndTurn()
        return
    end
    local lastRound = this.turnCount or 0
    local serverRound = JYCSData.GetServerRound()
    local config = this.mapData.Config
    local isPassRunMonster = JYCSData.IsPassRunMonster(this.mapData)
    local targetIndex = JYCSData.GetMonsterBlockIndex(this.mapData, serverRound)
    if targetIndex == nil then
        this.EndTurn()
        return
    end

    if isPassRunMonster == false then
        if serverRound <= lastRound then
            this.EndTurn()
            return
        end
        this.turnCount = serverRound
        if serverRound < config.Round then
            this.SetMonsterVisible(false)
            this.EndTurn()
            return
        end
        this.SetMonsterVisible(true)
        if lastRound < config.Round then
            this.curMonsterBlockIndex = JYCSData.GetMonsterBlockIndex(this.mapData, config.Round)
            this.SetRoleBlock(this.monsterItem, this.curMonsterBlockIndex)
        elseif this.curMonsterBlockIndex == nil then
            this.curMonsterBlockIndex = JYCSData.GetMonsterBlockIndex(this.mapData, lastRound)
            this.SetRoleBlock(this.monsterItem, this.curMonsterBlockIndex)
        end
        if serverRound == config.Round then
            this.EndTurn()
            return
        end
        this.curMonsterMoveStepNum = config.Speed
    else
        this.turnCount = serverRound
        this.SetMonsterVisible(true)
        if this.curMonsterBlockIndex == nil then
            this.curMonsterBlockIndex = targetIndex
            this.SetRoleBlock(this.monsterItem, this.curMonsterBlockIndex)
        end
        local forwardStep = JYCSData.GetForwardBlockStepCount(this.mapData, this.curMonsterBlockIndex, targetIndex)
        this.curMonsterMoveStepNum = math.min(forwardStep, config.Speed)
    end

    if this.curMonsterMoveStepNum <= 0 then
        this.curMonsterBlockIndex = targetIndex
        this.SetRoleBlock(this.monsterItem, this.curMonsterBlockIndex)
        this.CheckMonsterBattle()
        return
    end
    this.moveElapsed = 0
    this.curGameStep = JYCSConst.GameStep.MonsterMove
end

this.EndEventChain = function()
    JYCSData.ClearGameBattleResumeData()
    this.eventChainCount = 0
    this.StartMonsterMove()
end

this.CheckMonsterBattle = function()
    if JYCSData.GetMonsterDungeonID(this.mapData) ~= nil and this.curMonsterBlockIndex == this.curPlayerBlockIndex then
        this.EnterMonsterBattle()
    else
        this.EndTurn()
    end
end

this.CheckMonsterCollisionOnEnter = function()
    if this.mapData == nil or JYCSData.GetMonsterDungeonID(this.mapData) == nil then
        return false
    end
    local isMovePathCollision = JYCSData.IsBlockInCurrentMonsterMovePath(this.mapData, this.curPlayerBlockIndex)
    local isSameBlockCollision = this.curMonsterBlockIndex ~= nil and this.curMonsterBlockIndex == this.curPlayerBlockIndex and JYCSData.ShouldShowMonster(this.mapData, this.turnCount) == true and JYCSData.IsMonsterSleeping(this.mapData) == false
    if isMovePathCollision == false and isSameBlockCollision == false then
        return false
    end
    this.curMonsterBlockIndex = this.curPlayerBlockIndex
    this.SetMonsterVisible(true)
    this.SetRoleBlock(this.monsterItem, this.curMonsterBlockIndex)
    this.SetPanelVisible(false)
    this.SetRollLocked(true)
    this.EnterMonsterBattle()
    return true
end

this.CheckPlayerMeetMonster = function()
    if JYCSData.GetMonsterDungeonID(this.mapData) == nil then
        return false
    end
    if JYCSData.IsPassRunMonster(this.mapData) == false then
        if (this.turnCount or 0) <= this.mapData.Config.Round then
            return false
        end
    end
    if this.curMonsterBlockIndex ~= this.curPlayerBlockIndex then
        return false
    end
    this.EnterPlayerMeetMonsterBattle()
    return true
end

this.SaveBattleTurnState = function(resumeType)
    local resumeData = {
        ResumeType = resumeType,
        CurGameStep = this.curGameStep,
        CurPlayerBlockIndex = this.curPlayerBlockIndex,
        CurPlayerTargetIndex = this.curPlayerTargetIndex,
        CurPlayerMoveDirection = this.curPlayerMoveDirection,
        CurPlayerMoveRemainStep = this.curPlayerMoveRemainStep,
        CurMonsterBlockIndex = this.curMonsterBlockIndex,
        CurMonsterMoveStepNum = this.curMonsterMoveStepNum,
        TurnCount = this.turnCount,
        CurrentEventIsCostRoll = this.currentEventIsCostRoll,
        CurrentEventIsMoveEvent = this.currentEventIsMoveEvent,
        EventChainCount = this.eventChainCount,
        SkipWaitTime = this.skipWaitTime,
        IsRollLocked = this.IsRollLocked()
    }

    JYCSData.SaveGameBattleResumeData(resumeData)
end

this.ResumeBattleTurnState = function(resumeData)
    JYCSData.ClearGameBattleResumeData()
    if resumeData == nil then
        this.RefreshGamePanel()
        return
    end
    local mapData = JYCSData.GetMapData()
    if mapData == nil then
        this.RefreshGamePanel()
        return
    end
    this.mapData = mapData
    this.isSkipRequesting = false
    this.StopIntroAnim()
    SetActive(this.introAnimGroup, false)
    for i = 1, #this.blockItems do
        this.blockItems[i]:SetData(mapData.BlockDatas[i])
    end
    this.curGameStep = resumeData.CurGameStep
    this.curPlayerBlockIndex = JYCSData.GetBlockIndex(mapData, JYCSData.GetCurBlock()) or 1
    this.curPlayerTargetIndex = resumeData.CurPlayerTargetIndex
    this.curPlayerMoveDirection = resumeData.CurPlayerMoveDirection
    this.curPlayerMoveRemainStep = resumeData.CurPlayerMoveRemainStep
    this.curMonsterBlockIndex = resumeData.CurMonsterBlockIndex
    if this.curMonsterBlockIndex == nil and JYCSData.IsPassRunMonster(mapData) == true and JYCSData.GetMonsterPosition(mapData) ~= nil then
        this.curMonsterBlockIndex = JYCSData.GetMonsterBlockIndex(mapData)
    end
    this.curMonsterMoveStepNum = resumeData.CurMonsterMoveStepNum
    this.turnCount = resumeData.TurnCount
    this.currentEventIsCostRoll = resumeData.CurrentEventIsCostRoll
    this.currentEventIsMoveEvent = resumeData.CurrentEventIsMoveEvent == true
    this.eventChainCount = resumeData.EventChainCount or 0
    local isRollLocked = resumeData.IsRollLocked
    if isRollLocked == nil then
        isRollLocked = resumeData.IsTurnRunning
    end
    this.SetRollLocked(isRollLocked == true)
    this.moveDelay = JYCSConst.RoleMoveDelay
    this.SetRoleBlock(this.playerItem, this.curPlayerBlockIndex)
    local showMonster = JYCSData.ShouldShowMonster(mapData, JYCSData.GetServerRound())
    this.SetMonsterVisible(showMonster)
    if showMonster == true and this.curMonsterBlockIndex ~= nil then
        this.SetRoleBlock(this.monsterItem, this.curMonsterBlockIndex)
    end
    this.passName.text = LuaMgr.GetLangText(mapData.Config.NameLan)
    this.RefreshProgress()
    this.RefreshRollTimes()
    this.RefreshTotalScore()
    this.SetPanelVisible(false)
    this.RefreshSkipButton(resumeData.SkipWaitTime)
    if resumeData.ResumeType == "PlayerMeetMonster" then

        this.EndTurn()
    elseif resumeData.ResumeType == "BlockBattle" then

        this.EndEventChain()
    else
        this.EndTurn()
    end
end

this.EnterPlayerMeetMonsterBattle = function()
    local dungeonID = JYCSData.GetMonsterDungeonID(this.mapData)
    local blockID = JYCSData.GetBlockIDByIndex(this.mapData, this.curPlayerBlockIndex)
    if dungeonID == nil or blockID == nil then
        this.EndEventChain()
        return
    end
    local isMoveEvent = this.pendingTriggerBlockID == blockID
    this.currentEventIsMoveEvent = isMoveEvent
    this.SaveBattleTurnState("PlayerMeetMonster")
    this.curGameStep = JYCSConst.GameStep.None
    local eventID = this.mapData.Config.EventId
    local extraParams = JYCSData.BuildBattleExtraParams(blockID, JYCSConst.MapEventType.RunFight, this.currentEventIsCostRoll, eventID, isMoveEvent)
    this.EnterBattle(dungeonID, dungeonID, extraParams)
end

this.EnterMonsterBattle = function()
    local dungeonID = JYCSData.GetMonsterDungeonID(this.mapData)
    local blockID = JYCSData.GetBlockIDByIndex(this.mapData, this.curMonsterBlockIndex)
    if dungeonID == nil or blockID == nil then
        this.EndTurn()
        return
    end
    local eventID = this.mapData.Config.EventId
    local needStep = JYCSConst.EventNeedStep.IgnoreMonsterRound
    local extraParams = JYCSData.BuildBattleExtraParams(blockID, JYCSConst.MapEventType.RunFight, false, eventID, false, needStep)
    this.PauseTurnForBattle()
    this.EnterBattle(dungeonID, dungeonID, extraParams)
end

this.EnterBattle = function(eventID, dungeonID, extraParams)
    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
    enterDungeonParams.eventId = eventID or dungeonID
    enterDungeonParams.dungeonId = dungeonID
    enterDungeonParams.extraParams = extraParams
    local dungeonBuffID = JYCSData.GetDungeonBuffID()
    if dungeonBuffID ~= nil and dungeonBuffID ~= "" then
        table.insert(enterDungeonParams.extraParams, dungeonBuffID)
    end
    local forbidData = {}
    forbidData.BackCallback = this.CloseBattleCallback
    forbidData.Params = enterDungeonParams
    BattlePrepareMgr.BattlePrepare(enterDungeonParams, nil, forbidData)
end

this.CloseBattleCallback = function(_, paramData)
    local data = {
        Type = JYCSConst.GameCommonPopupType.ExistBattle,
        Callback = this.BattleFaildEvent,
        ParamData = paramData
    }
    LuaMgr.ShowLuaPanel(UIName.JYCSGameCommonPopup, data)
end

this.BattleFaildEvent = function(data)
    if LuaMgr.IsPanelOpen(UIName.BattlePrepareViewModel) then
        LuaMgr.HidePanel(UIName.BattlePrepareViewModel)
    end
    if data == nil or data.ParamData == nil or data.ParamData.Params == nil then
        this.OpenGamePanel()
        return
    end
    local mapData = JYCSData.GetMapData()
    if mapData == nil then
        this.OpenGamePanel()
        return
    end
    local battleData = data.ParamData.Params
    local requestData = JYCSData.BuildBattleFailEventRequest(mapData, battleData)
    this.DealBlockEvent(requestData, {Type = requestData.EventTyp})
end

this.PauseTurnForBattle = function()
    this.curGameStep = JYCSConst.GameStep.None
    this.moveElapsed = 0
    this.ClearRoleMoveData()
end

this.EndTurn = function(keepRollLocked)
    this.PauseTurnForBattle()
    this.SetRollLocked(keepRollLocked == true)
    this.curPlayerTargetIndex = nil
    this.curPlayerMoveDirection = nil
    this.curPlayerMoveRemainStep = nil
    this.curMonsterMoveStepNum = nil
    this.pendingTriggerBlockID = nil
    this.currentEventIsCostRoll = false
    this.currentEventIsMoveEvent = false
end

this.OnPlayerStepMoveComplete = function()
    if this.curPlayerMoveRemainStep == nil or this.curPlayerMoveRemainStep <= 0 then
        this.curGameStep = JYCSConst.GameStep.PlayerMoveEnd
    end
end

this.OnMonsterStepMoveComplete = function()
    if this.curMonsterBlockIndex == this.curPlayerBlockIndex then
        this.curMonsterMoveStepNum = 0
        this.CheckMonsterBattle()
        return
    end
    if this.curMonsterMoveStepNum <= 0 then
        this.curGameStep = JYCSConst.GameStep.MonsterMoveEnd
    end
end

this.RoleMove = function(isPlayer)
    if isPlayer == true then
        if this.curPlayerTargetIndex == nil or this.curPlayerMoveRemainStep == nil or this.curPlayerMoveRemainStep <= 0 then
            this.curGameStep = JYCSConst.GameStep.PlayerMoveEnd
            this.moveElapsed = 0
            return
        end
        local lastBlockIndex = this.curPlayerBlockIndex
        this.curPlayerBlockIndex = JYCSData.GetTargetBlockIndex(this.mapData, this.curPlayerBlockIndex, this.curPlayerMoveDirection)
        this.curPlayerMoveRemainStep = this.curPlayerMoveRemainStep - 1
        this.SetRoleBlock(this.playerItem, this.curPlayerBlockIndex, lastBlockIndex, this.OnPlayerStepMoveComplete)
        this.moveElapsed = 0
        return
    end
    if this.curMonsterMoveStepNum == nil or this.curMonsterMoveStepNum <= 0 then
        this.curGameStep = JYCSConst.GameStep.MonsterMoveEnd
        this.moveElapsed = 0
        return
    end
    local lastBlockIndex = this.curMonsterBlockIndex
    this.curMonsterBlockIndex = this.curMonsterBlockIndex % #this.blockItems + 1
    this.curMonsterMoveStepNum = this.curMonsterMoveStepNum - 1
    this.SetRoleBlock(this.monsterItem, this.curMonsterBlockIndex, lastBlockIndex, this.OnMonsterStepMoveComplete)
    this.moveElapsed = 0
end





this.OnClickBgBtn = function()
    this.SetPanelVisible(false)
end

this.OnClickRollBtn = function()
    if this.IsRollLocked() == true then
        return
    end
    this.SetPanelVisible()
    local rollNum = JYCSData.GetNormalRollNum()
    if this.IsDebug == true and this.isFixRoll == true then
        rollNum = tonumber(this.fixRollNumField.text) or 1
        rollNum = math.min(rollNum, 6)
        rollNum = math.max(rollNum, 1)
    end
    this.OperateRoll(rollNum, false)
end

this.OnClickFixRollBtn = function()
    if this.IsRollLocked() == true then
        return
    end
    if this.CheckCanUseCostRoll() == false then
        return
    end
    this.SetPanelVisible(true)
end

this.OnClickSkipBtn = function()
    if this.IsRollLocked() == true then
        return
    end
    if this.mapData == nil or JYCSData.IsEndlessMap(this.mapData) == true then
        SetActive(this.jumpBtn.gameObject, false)
        return
    end
    this.SetPanelVisible(false)
    local data = {}
    data.Skip = true
    this.SkipMap(data)
end

this.OperateRoll = function(rollNum, isCostRoll)
    if this.IsRollLocked() == true then
        return
    end
    if isCostRoll == true and this.CheckCanUseCostRoll() == false then
        return
    end
    if isCostRoll ~= true then
        rollNum = JYCSData.ClampRollNumToMapEnd(this.mapData, rollNum)
    end
    if rollNum <= 0 then
        return
    end
    this.SetRollLocked(true)
    local data = {
        Type = JYCSConst.GameCommonPopupType.Roll,
        RollNum = rollNum,
        IsCostRoll = isCostRoll
    }
    LuaMgr.ShowLuaPanel(UIName.JYCSGameCommonPopup, data)
    this.SetPanelVisible(false)
end

this.OnClickLateastCalBtn = function()
    if this.IsRollLocked() == true then
        return
    end
    if this.mapData == nil then
        return
    end
    local curBlockID = JYCSData.GetCurBlock()
    if this.mapData.Config.StartPoint == curBlockID then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("JYCSGamePanel_2"))
        return
    end
    local data = {
        Type = JYCSConst.GameCommonPopupType.LatestCal,
        Callback = function()
            local data = {}
            data.Skip = false
            this.SkipMap(data)
        end
    }
    LuaMgr.ShowLuaPanel(UIName.JYCSGameCommonPopup, data)
    this.SetPanelVisible(false)
end




this.SetPanelVisible = function(visible)
    SetActive(this.rollNumPanel.gameObject, visible)
end




this.IsGamePanelReady = function()
    return this.isViewReady == true and LuaMgr.IsPanelOpen(UIName.JYCSGamePanel)
end

this.OpenGamePanel = function()
    if LuaMgr.IsPanelOpen(UIName.JYCSGamePanel) == false then
        LuaMgr.ShowLuaPanel(UIName.JYCSGamePanel)
    end
end

this.DealBlockEvent = function(data, eventData)
    local eventType = tonumber(eventData.Type) or eventData.Type
    local moveTargetWasUnfinished = eventType == JYCSConst.MapEventType.Move and JYCSData.IsBlockFinished(data.BlockId) == false
    local onFail = function()
        JYCSData.ClearGameBattleResumeData()
        if this.IsGamePanelReady() == false then
            this.OpenGamePanel()
            return
        end
        this.curPlayerBlockIndex = JYCSData.GetBlockIndex(this.mapData, JYCSData.GetCurBlock()) or 1
        this.SetRoleBlock(this.playerItem, this.curPlayerBlockIndex)
        this.EndTurn()
    end
    local onSuccess = function(result)
        local res = json.decode(result)
        if res.code ~= 0 then
            onFail()
            return
        end
        local blockID = JYCSData.ApplyStepResponse(res)
        if this.IsGamePanelReady() == false then
            this.OpenGamePanel()
            return
        end
        this.RefreshProgress()
        this.RefreshRollTimes()
        if eventType == JYCSConst.MapEventType.Finish then
            this.RefreshGamePanel()
        elseif eventType == JYCSConst.MapEventType.Move then
            local targetIndex = JYCSData.GetBlockIndex(this.mapData, blockID) or this.curPlayerBlockIndex
            local moveStep = tonumber(data.Param) or 0
            local isEndlessMap = JYCSData.IsEndlessMap(this.mapData)
            if targetIndex == this.curPlayerBlockIndex and (isEndlessMap == false or moveStep == 0) then
                this.EndEventChain()
            else
                local pendingTriggerBlockID = moveTargetWasUnfinished == true and blockID or nil
                this.StartPlayerMove(targetIndex, false, pendingTriggerBlockID, moveStep)
            end
        else
            this.EndEventChain()
        end
        this.RefreshTotalScore()
    end
    ApiMgr.Request("jycsGame/step", data, true, onSuccess, onFail, true)
end

this.ShowSkipMapSuccessPopup = function(score)
    local name = ""
    if this.mapData ~= nil and this.mapData.Config ~= nil then
        name = LuaMgr.GetLangText(this.mapData.Config.NameLan)
    end
    local popupData = {
        Type = JYCSConst.GameEventPopupType.Success,
        IsSkipMapResult = true,
        Name = name,
        Score = score
    }
    LuaMgr.ShowLuaPanel(UIName.JYCSGameEventPopup, popupData)
end

this.SkipMap = function(data)
    if data ~= nil and data.Skip == true and (this.mapData == nil or JYCSData.IsEndlessMap(this.mapData) == true) then
        SetActive(this.jumpBtn.gameObject, false)
        return
    end
    if this.isSkipRequesting == true then
        return
    end
    this.isSkipRequesting = true
    local onFail = function()
        this.isSkipRequesting = false
    end
    local onSuccess = function(result)
        local res = json.decode(result)
        this.isSkipRequesting = false
        if res.code ~= 0 then
            return
        end
        this.ShowSkipMapSuccessPopup(res.result.Score)
    end
    ApiMgr.Request("jycsGame/skip", data, true, onSuccess, onFail, true)
end




this.StopIntroAnim = function()
    if this.introAnimTween ~= nil then
        this.introAnimTween:Kill(false)
        this.introAnimTween = nil
    end
    if this.topBarComp ~= nil and IsObjectNull(this.topBarComp) == false then
        SetActive(this.topBarComp, true)
    end
end

this.SetIntroAnim = function(callBack)
    this.StopIntroAnim()
    SetActive(this.introAnimGroup, true)
    SetActive(this.topBarComp, false)
    this.introAnimTween = DOTWeen:Sequence()
    local tweenCallback = function()
        this.introAnimTween = nil
        if this.IsGamePanelReady() == false then
            return
        end
        SetActive(this.introAnimGroup, false)
        SetActive(this.topBarComp, true)
        this.rootAnim:Play(this.rootAnimName, 0, 0)
        if callBack ~= nil then
            callBack()
        end
    end
    this.introAnimTween:AppendInterval(JYCSConst.IntroAnimTime):OnComplete(tweenCallback)
end





local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.BatchInitNode()
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.fixRollBtnCallback = {}
        LuaMgr.AddUIEventListener(UIEventConst.JYCSCloseCommonPopup, this.OnCommonPopupClose)
        LuaMgr.AddUIEventListener(UIEventConst.JYCSCloseEventPopup, this.OnEventPopupClose)
        LuaMgr.AddClick(this.rollBtn, this.OnClickRollBtn)
        LuaMgr.AddClick(this.jumpBtn, this.OnClickSkipBtn)
        LuaMgr.AddClick(this.fixRollBtn, this.OnClickFixRollBtn)
        LuaMgr.AddClick(this.bgBtn, this.OnClickBgBtn)
        LuaMgr.AddClick(this.lateastCalBtn, this.OnClickLateastCalBtn)
        for i = 1, 6 do
            local index = i
            local name = string.format("FixRoll%d", i)
            local callback = function()
                this.OperateRoll(index, true)
            end
            LuaMgr.AddClick(this[name], callback)
            table.insert(this.fixRollBtnCallback, callback)
        end
        this.IsDebug = LuaMgr.IsDebug()
        SetActive(this.gmPanel, this.IsDebug == true)
        if this.IsDebug == true then
            this.isFixRoll = false
            this.fixRollToggle.isOn = false
            this.fixToggleCallback = function(value)
                this.isFixRoll = value
            end
            this.fixRollToggle.onValueChanged:AddListener(this.fixToggleCallback)
        end
        this.before_awake()
        this.isViewReady = true
    end,
    before_active = function(vm)
        this.EndTurn(true)
        if vm.behaviour.Params == nil then
            this.SetRollLocked(false)
            return
        end
        if this.topBarComp == nil then
            local topBarObj = UnityEngine.GameObject.Find("UIRoot(Clone)/Fixed")
            this.topBarComp = topBarObj
        end
        LuaMgr.AddUpdate(this.OnGameStepUpdate)
        local resumeData = JYCSData.GetGameBattleResumeData()
        if resumeData ~= nil then
            this.ResumeBattleTurnState(resumeData)
        else
            this.before_active()
        end
        if this.IsDebug == true and this.mapData ~= nil and JYCSData.IsEndlessMap(this.mapData) == false then
            SetActive(this.jumpBtn.gameObject, true)
        end
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.JYCSGameSkipTimer)
        this.StopIntroAnim()
        this.ClearRoleMoveData()
        LuaMgr.RemoveUpdate(this.OnGameStepUpdate)
    end,
    before_destroy = function()
        this.isViewReady = false
        LuaMgr.RemoveTimer(TimerConst.JYCSGameSkipTimer)
        this.StopIntroAnim()
        this.ClearRoleMoveData()
        LuaMgr.RemoveUpdate(this.OnGameStepUpdate)
        LuaMgr.RemoveUIEventListener(UIEventConst.JYCSCloseCommonPopup, this.OnCommonPopupClose)
        LuaMgr.RemoveUIEventListener(UIEventConst.JYCSCloseEventPopup, this.OnEventPopupClose)
        LuaMgr.RemoveClick(this.rollBtn, this.OnClickRollBtn)
        LuaMgr.RemoveClick(this.jumpBtn, this.OnClickSkipBtn)
        LuaMgr.RemoveClick(this.fixRollBtn, this.OnClickFixRollBtn)
        LuaMgr.RemoveClick(this.bgBtn, this.OnClickBgBtn)
        LuaMgr.RemoveClick(this.lateastCalBtn, this.OnClickLateastCalBtn)
        for i = 1, 6 do
            local name = string.format("FixRoll%d", i)
            LuaMgr.RemoveClick(this[name], this.fixRollBtnCallback[i])
        end
        this.fixRollBtnCallback = {}
        if this.IsDebug == true then
            this.fixRollToggle.onValueChanged:RemoveListener(this.fixToggleCallback)
        end
    end
}



return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)