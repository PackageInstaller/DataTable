require("Match3Game/ElementFactory")
require("Match3Game/Data/GridManager")
require("Match3Game/Data/ComboManager")
require("Match3Game/Data/PropManager")
require("Match3Game/Match3InputHandler")
require("Match3Game/Match3Const")













Match3GameManager = {}
Match3GameManager.__index = Match3GameManager

Match3GameManager.gridMapDatas = nil

function Match3GameManager.New(gridTransform)

    local self = {}
    setmetatable(self, Match3GameManager)
    self.gridTransform = gridTransform.transform
    self.score = 0
    self.moves = 0
    self.targetScore = 0
    self.isPlaying = false
    self.IsComboing = false
self.isCalResStep = false
    self:InitEvents()
    return self
end


function Match3GameManager:InitEvents()

    self.onElementEliminated = function(param)
        local element = param[0]
        self:OnElementEliminated(element)
    end

    self.onComboIncreased = function(param)
        self.IsComboing = true
    end

    self.onComboEnded = function(param)
        self.IsComboing = false
        local data = param[0]
        self:OnComboEnded(data)
    end

    self.onRecycleElementView = function(params)
        local data = params[0]
        if not data then
            return
        end
        self.elementFactory:RecycleElementView(data.cell)
    end

    self.onElementsSwapped = function(params)
        local data = params[0]
        local element1 = data.element1
        local element2 = data.element2
        local isFail = data.isFail
        self:OnElementsSwapped(element1, element2, isFail)
    end

    self.onNewElementSpawn = function(param)
        local data = param[0]
        local element = data.element
        local cell = data.cell
    end

    self.onScoreUpdate = function(param)
        if param.Length <= 0 then
            LuaDebug.error("三消分数计算：参数错误")
            return
        end
        self:OnScoreUpdate(param[0])
    end

    self.onChangeComboStatus = function(param)
        local data = param[0]
        self.comboStatusType = data
    end

    LuaMgr.AddUIEventListener(UIEventConst.ElementEliminated, self.onElementEliminated)
    LuaMgr.AddUIEventListener(UIEventConst.Match3ComboIncreased, self.onComboIncreased)
    LuaMgr.AddUIEventListener(UIEventConst.Match3ComboEnded, self.onComboEnded)
    LuaMgr.AddUIEventListener(UIEventConst.RecycleElementView, self.onRecycleElementView)
    LuaMgr.AddUIEventListener(UIEventConst.ElementsSwapped, self.onElementsSwapped)
    LuaMgr.AddUIEventListener(UIEventConst.NewElementSpawn, self.onNewElementSpawn)
    LuaMgr.AddUIEventListener(UIEventConst.Match3ScoreUpdate, self.onScoreUpdate)
    LuaMgr.AddUIEventListener(UIEventConst.Match3ComboStepStatus, self.onChangeComboStatus)
end


function Match3GameManager:StartGame(elementPrefab, passID)
    if Match3GameManager.gridMapIDDatas == nil then
        Match3GameManager.InitConfig()
    end
    self.passData = Match3GameManager.gridMapIDDatas[passID]

    self.score = 0
    self.moves = self.passData.config.Limittimes
    self.targetScore = self.passData.config.Rewardcredit
    self.isPlaying = true
    self.isCalResStep = false
    self.IsComboing = false
    if self.elementFactory == nil then
        self.elementFactory = ElementFactory.New(elementPrefab, self.gridTransform)
    end

    if self.gridManager == nil then
        self.gridManager = GridManager.New(self.elementFactory, self.gridTransform)
    end
    self.gridManager:Init(self.passData)
    self.gridManager:InitGrid(self.passData)

    if self.propManager == nil then
        self.propManager = PropManager.New(self.gridManager)
    end
    self.propManager:Init(self.passData.specialitemData)

    if self.comboManager == nil then
        self.comboManager = ComboManager.New(self.gridManager)
    end

    if self.inputHandler == nil then
        self.inputHandler = Match3InputHandler.New(self.gridManager)
    end

    local data = {}
    data.status = Match3Const.GameStatus.Started
    data.passData = self.passData
    LuaMgr.InvokeUIEventListeners(UIEventConst.Match3GameStatus, data)
    LuaMgr.InvokeUIEventListeners(UIEventConst.Match3OperateLimitChange, false)
end

function Match3GameManager:GetCurPassID()
    if self.passData == nil then
        LuaDebug.error("Match3GameManager 获取关卡ID错误." .. debug.traceback())
        return nil
    end
    return self.passData.ID
end


function Match3GameManager:ResetGame()
    self:Cleanup()
    self.IsComboing = false
    self.isCalResStep = false
    self.score = 0
    self.moves = self.passData.config.Limittimes
    self.isPlaying = true
    self.gridManager:InitGrid(self.passData)

    local viewData = {}
    viewData.score = self.score
    viewData.moves = self.moves
    LuaMgr.InvokeUIEventListeners(UIEventConst.Match3GameViewRefresh, viewData)
    self.propManager:Init(self.passData.specialitemData)

    local data = {}
    data.status = Match3Const.GameStatus.Started
    data.passData = self.passData
    LuaMgr.InvokeUIEventListeners(UIEventConst.Match3GameStatus, data)
    LuaMgr.InvokeUIEventListeners(UIEventConst.Match3OperateLimitChange, false)
end



function Match3GameManager:EndGame(isVictory)
    if not self.isPlaying then
        return
    end
    self.isPlaying = false
    if isVictory then
        if self.moveToScoreCoroutine ~= nil then
            coroutine_runner.stop(self.moveToScoreCoroutine)
            self.moveToScoreCoroutine = nil
        end

        local data = {}
        data.finalScore = self.score
        data.passID = self.passData.ID
        data.status = Match3Const.GameStatus.GameEnd
        data.gameResult = Match3Const.ResultType.Victory
        data.targetScore = self.targetScore
        data.reward = self.passData.config.Reward
        LuaMgr.InvokeUIEventListeners(UIEventConst.Match3GameStatus, data)

        local func = function()
            self:MovesToScore()
        end
        self.moveToScoreCoroutine = coroutine_runner.start(func)
    else
        local data = {}
        data.passID = self.passData.ID
        data.status = Match3Const.GameStatus.GameEnd
        data.gameResult = isVictory == true and Match3Const.ResultType.Victory or Match3Const.ResultType.Failed
        data.targetScore = self.targetScore
        data.reward = self.passData.config.Reward
        data.finalScore = self.score
        LuaMgr.InvokeUIEventListeners(UIEventConst.Match3GameStatus, data)
    end
end

function Match3GameManager:MovesToScore()
    LuaMgr.InvokeUIEventListeners(UIEventConst.Match3OperateLimitChange, true)

    local toScoreAnimTime = 0.2
    while self.moves >= 0 do
        self.moves = self.moves - 1
        local data = {}
        data.score = self.score
        data.moves = self.moves
        data.isMoveToScore = true
        LuaMgr.InvokeUIEventListeners(UIEventConst.Match3GameViewRefresh, data)
        self.gridManager:ForceChangeElementType()
        coroutine_runner.wait(toScoreAnimTime)
    end

    self.gridManager:EliminateAllSpecial()
    while true do
        if self.IsComboing == false then
            break
        end
        coroutine_runner.waitForEndOfFrame()
    end
    LuaMgr.InvokeUIEventListeners(UIEventConst.Match3OperateLimitChange, false)
    local data1 = {}
    data1.finalScore = self.score
    LuaMgr.InvokeUIEventListeners(UIEventConst.Match3CalStatusEnd, data1)
end

function Match3GameManager:Update()
    if not self.isPlaying then
        return
    end
    self:CheckGameState()
end



function Match3GameManager:OnElementEliminated(element)
    local data = {}
    data.score = self.score
    data.moves = self.moves
    LuaMgr.InvokeUIEventListeners(UIEventConst.Match3GameViewRefresh, data)
end

function Match3GameManager:OnScoreUpdate(data)
    local tempScore = data.eliminateNum * data.eliminateNum * (ConfigMgr.Config.constants.EliminateBaseCredit or 1)
    if data.comboCount ~= nil and data.comboCount > 1 then
        tempScore = math.floor(tempScore * (1 + ConfigMgr.Config.constants.EliminateComboAdd / 10000.0))
    elseif data.specialType == Match3Const.ElementType.Vertical or data.specialType == Match3Const.ElementType.Horizontal then
        tempScore = tempScore * ConfigMgr.Config.constants.EliminateSpecialAdd1
    elseif data.specialType == Match3Const.ElementType.SuperColorBall then
        tempScore = tempScore * ConfigMgr.Config.constants.EliminateSpecialAdd2
    elseif data.specialType == Match3Const.ElementType.ColorBall then
        tempScore = tempScore * ConfigMgr.Config.constants.EliminateSpecialAdd3
    end
    self.score = self.score + tempScore
    local tempData = {}
    tempData.moves = self.moves
    tempData.score = self.score
    LuaMgr.InvokeUIEventListeners(UIEventConst.Match3GameViewRefresh, tempData)
end



function Match3GameManager:OnComboEnded(data)
    if data.usePropType == nil then
        self.moves = self.moves - 1
    end
    local data = {}
    data.moves = self.moves
    data.score = self.score
    LuaMgr.InvokeUIEventListeners(UIEventConst.Match3GameViewRefresh, data)
end


function Match3GameManager:CheckGameState()
    if self.IsComboing == true or self.isCalResStep == true then
        return
    end
    if self.comboStatusType == Match3Const.ComboStatus.Start then
        return
    end
    if self.score >= self.targetScore then
        self.isCalResStep = true
        self:EndGame(true)
    elseif self.moves <= 0 then
        self.isCalResStep = true
        self:EndGame(false)
    end
end


function Match3GameManager:Cleanup()
    if self.moveToScoreCoroutine ~= nil then
        coroutine_runner.stop(self.moveToScoreCoroutine)
        self.moveToScoreCoroutine = nil
    end
    if self.gridManager then
        self.gridManager:ClearGrid()
    end
    if self.elementFactory then
        self.elementFactory:ClearPools()
    end
end





function Match3GameManager:UseProp(propType, ...)
    if not self.isPlaying then
        return false
    end
    if propType == Match3Const.PropType.Eliminate then
        return self.propManager:UseEliminateProp(...)
    elseif propType == Match3Const.PropType.Swap then
        return self.propManager:UseSwapProp(...)
    elseif propType == Match3Const.PropType.Reshuffle then
        return self.propManager:UseReshuffleProp()
    end
    return false
end

function Match3GameManager.InitConfig()
    if Match3Const.StandardLine ~= #Match3Const.ConfigColFields then
        LuaDebug.error("Match3GameManager:GetMGridMapData Match3Const 中字段配置有误")
        return
    end
    if Match3GameManager.gridMapDatas ~= nil then
        return
    end
    Match3GameManager.gridMapDatas = {}
    Match3GameManager.gridMapIDDatas = {}
    local totalGridMapConfigs = ConfigMgr.Config.EliminateGameMap
    local gridElementConfigs = ConfigMgr.Config.EliminateMaps
    local mapGroupDataDic = {}
    for key, config in pairs(gridElementConfigs) do
        local mapGroup = mapGroupDataDic[config.MapId]
        if mapGroup == nil then
            mapGroup = {}
            mapGroupDataDic[config.MapId] = mapGroup
        end
        table.insert(mapGroup, #mapGroup + 1, config)
    end

    for key, config in pairs(totalGridMapConfigs) do
        local data = {}
        data.ID = config.Id
        data.MapId = config.MapId
        data.config = config
        data.unlock = config.Unlocktype == Match3Const.PassUnlockType.None
        data.rowCol = {}
        data.colRow = {}
        data.gridWidth = Match3Const.StandardLine
        data.gridHeight = Match3Const.StandardLine
        data.cellSize = Match3Const.CellSize
        data.totalStep = config.Limittimes
        data.goalScore = config.Rewardcredit
        data.specialitemData = {}
        Match3GameManager.gridMapDatas[data.MapId] = data
        Match3GameManager.gridMapIDDatas[data.ID] = data
        if data.config.Specialitem ~= nil then
            for key, itemData in pairs(data.config.Specialitem) do
                if #itemData > 1 then
                    data.specialitemData[itemData[1]] = itemData[2]
                end
            end
        end

        local mapGroup = mapGroupDataDic[config.MapId]
        if mapGroup == nil then
            LuaDebug.error("Match3GameManager:GetMGridMapData mapID和EliminateMaps的MapID对应错误. ID:" .. config.MapId)
            break
        end
        for key, lineConfig in pairs(mapGroup) do
            local rowData = data.rowCol[lineConfig.Line]
            if rowData == nil then
                rowData = {}
                data.rowCol[lineConfig.Line] = rowData
            end
            for i = 1, #Match3Const.ConfigColFields do
                local fieldName = Match3Const.ConfigColFields[i]
                if type(lineConfig[fieldName]) ~= "function" then
                    rowData[i] = lineConfig[fieldName]
                else
                    rowData[i] = nil
                end
            end
        end
        for i = 1, #Match3Const.ConfigColFields do
            local colData = data.colRow[i]
            if colData == nil then
                colData = {}
                data.colRow[i] = colData
            end
            local fieldName = Match3Const.ConfigColFields[i]
            for key, lineConfig in pairs(mapGroup) do
                if type(lineConfig[fieldName]) ~= "function" then
                    colData[lineConfig.Line] = lineConfig[fieldName]
                else
                    colData[lineConfig.Line] = nil
                end
            end
        end
    end
end

function Match3GameManager:OnElementsSwapped(element1, element2, isFail)
    if element1 and element2 and element1.Pos and element2.Pos then
        self:PlaySwapAnimation(element1, element2, isFail)
    end
end





function Match3GameManager:PlaySwapAnimation(element1, element2, isFail)
    local cell1 = self.elementFactory:GetElementCellByPos(element1.Pos)
    local cell2 = self.elementFactory:GetElementCellByPos(element2.Pos)
    if not cell1 or not cell2 then
        LuaDebug.error("287======" .. tostring(not cell1) .. tostring(not cell2))
        return
    end


    local startPos1 = cell1.transform.localPosition
    local startPos2 = cell2.transform.localPosition


    local targetPos1 = cell2.transform.localPosition
    local targetPos2 = cell1.transform.localPosition
    local durationSucc = 0.3
    local durationFaild = 0.2
    local animCallback = function()
    end
    if self.tweenSequence ~= nil then
        self.tweenSequence:Kill()
        self.tweenSequence = nil
    end
    self.tweenSequence = DOTWeen:Sequence()
    if isFail then
        self.tweenSequence:Insert(0, cell1.transform:DOLocalMove(targetPos1, durationSucc))
        self.tweenSequence:Insert(0, cell2.transform:DOLocalMove(targetPos2, durationSucc))
        self.tweenSequence:Append(cell1.transform:DOLocalMove(startPos1, durationFaild))
        self.tweenSequence:Join(cell2.transform:DOLocalMove(startPos2, durationFaild))
    else
        self.tweenSequence:Insert(0, cell1.transform:DOLocalMove(targetPos1, durationSucc))
        self.tweenSequence:Insert(0, cell2.transform:DOLocalMove(targetPos2, durationSucc))
    end
    self.tweenSequence:OnComplete(animCallback)
end

function Match3GameManager:RemoveUIEvent()
    LuaMgr.RemoveUIEventListener(UIEventConst.ElementEliminated, self.onElementEliminated)
    LuaMgr.RemoveUIEventListener(UIEventConst.Match3ComboIncreased, self.onComboIncreased)
    LuaMgr.RemoveUIEventListener(UIEventConst.Match3ComboEnded, self.onComboEnded)
    LuaMgr.RemoveUIEventListener(UIEventConst.RecycleElementView, self.onRecycleElementView)
    LuaMgr.RemoveUIEventListener(UIEventConst.ElementsSwapped, self.onElementsSwapped)
    LuaMgr.RemoveUIEventListener(UIEventConst.NewElementSpawn, self.onNewElementSpawn)
    LuaMgr.RemoveUIEventListener(UIEventConst.Match3ScoreUpdate, self.onScoreUpdate)
    LuaMgr.RemoveUIEventListener(UIEventConst.Match3ComboStepStatus, self.onChangeComboStatus)
    if self.propManager then
        self.propManager:RemoveUIEvent()
    end
    if self.comboManager then
        self.comboManager:RemoveUIEvent()
    end
    if self.gridManager then
        self.gridManager:RemoveUIEvent()
    end
end

function Match3GameManager:Destroy()
    self:Cleanup()
    self:RemoveUIEvent()
    if self.moveToScoreCoroutine ~= nil then
        coroutine_runner.stop(self.moveToScoreCoroutine)
        self.moveToScoreCoroutine = nil
    end
    if self.propManager then
        self.propManager:Destroy()
    end
    if self.comboManager then
        self.comboManager:Destroy()
    end
    if self.gridManager then
        self.gridManager:Destroy()
    end
    if self.inputHandler then
        self.inputHandler:Destroy()
    end
end

function Match3GameManager.GotPassReward(passID)
    local severDatas = DataMgr.Player.Eliminate
    if type(severDatas) ~= "table" then
        severDatas = {}
    end
    local rewardDatas = severDatas.Rewards
    if type(rewardDatas) ~= "table" then
        rewardDatas = {}
    end
    return rewardDatas[passID] ~= nil and rewardDatas[passID] ~= 0
end

function Match3GameManager.PassIsUnlock(activityMapEvent)
    local severDatas = DataMgr.Player.Eliminate
    if type(severDatas) ~= "table" then
        severDatas = {}
    end
    local scoreMap = severDatas.ScoreMap
    if type(scoreMap) ~= "table" then
        scoreMap = {}
    end
    local passID = activityMapEvent.eventParam
    local passData = Match3GameManager.gridMapIDDatas[passID]
    if passData == nil then
        LuaDebug.error("Match3GameManager 关卡ID错误. Line 457." .. passID .. debug.traceback())
        return false
    end
    local passConfig = passData.config
    if passConfig == nil then
        return false
    elseif passConfig.Unlocktype == 0 then
        return true
    else
        if passConfig.Unlocktype == 1 then
            local passIDNum = tonumber(passID) or 0
            if passIDNum <= 0 then
                LuaDebug.error("PassID 错误。" .. passID)
                return false
            end
            local prePassID = tostring(passIDNum - 1)
            local preHistoryScore = scoreMap[prePassID] or 0
            local needPrePassScore = tonumber(passConfig.Unlockpara)
            if preHistoryScore < needPrePassScore then
                local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_25209")
                return false, string.format(tipsContent, needPrePassScore)
            end
            return true
        elseif passConfig.Unlocktype == 2 then
            local curTimeStamp = LuaMgr.Timestamp()
            local actStartTime = activityMapEvent.openDate
            local deltaTime = curTimeStamp - actStartTime
            local day = GetTimeDHM2(deltaTime)
            local needDelayDay = tonumber(passConfig.Unlockpara)
            if day < needDelayDay then
                local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_25208")
                return false, string.format(tipsContent, needDelayDay)
            end
            return true
        end
    end
end