require("ViewModel/Management/GameGridInput")
require("ViewModel/Management/ViewItem/ManagementGameCell")
require("ViewModel/Management/ViewItem/ManagementBigCellData")
require("ViewModel/Management/ViewItem/UsePropsBtnItem")

local objs = {
    gridCell = {path = "template/GridCell", type = UITool.GameObject},
    pauseBtn = {path = "root/Middle/PauseBtn", type = UITool.Button},
    curReputation = {path = "root/Middle/ReputationText", type = UITool.Text},
    remainTime = {path = "root/Middle/RemainTime/Text", type = UITool.Text},
    useItemBtn1 = {path = "root/Middle/GoalGroup/UseItemBtn1", type = UITool.GameObject},
    useItemBtn2 = {path = "root/Middle/GoalGroup/UseItemBtn2", type = UITool.GameObject},
    useItemBtn3 = {path = "root/Middle/GoalGroup/UseItemBtn3", type = UITool.GameObject},
    comboGroup = {path = "root/Middle/ComboGroup", type = UITool.GameObject},
    comboCountText = {path = "root/Middle/ComboGroup/Title", type = UITool.Text},
    comboProgress = {path = "root/Middle/ComboGroup/Progress", type = UITool.Image},
    downTimeGroup = {path = "root/Middle/DownTimeGroup", type = UITool.GameObject},
    propCollectGroup = {path = "root/Middle/PropCollectGroup", type = UITool.Button},
    gridParent = {path = "root/Middle/GameParent", type = UITool.GameObject},
    propMaskParentCloseBtn = {path = "root/Middle/PropMaskParentCloseBtn", type = UITool.Button},
    propMaskParent = {path = "root/PropMaskParent", type = UITool.Image}
}

local this = {

    bigGridCellMaps = {},
    curComboRemainTime = 0,
    curComboCount = 0,
    isComboing = false,

gridCellsCache = {},
shuffleDebug = true,
managementComboCD = {},
baseReputation = {},

usePropItems = {},
    perframeSecond = 1 / 30,
    usePropTimeDic = {},

    goalCellItems = {},

    collectUIItems = {},

    useItemType = ManagementConst.ItemType.None
}

this.before_awake = function()
    this.shuffleDebug = LuaMgr.IsDebug()
    local comboCDConfigs = ConfigMgr.Config.constants.ManagementComboCD
    for i = 1, #comboCDConfigs do
        table.insert(this.managementComboCD, #this.managementComboCD + 1, tonumber(comboCDConfigs[i]))
    end
    for i = 1, 3 do
        local item = UsePropsBtnItem.New(this["useItemBtn" .. i], this["UseItemBtn" .. i])
        this.usePropItems[i] = item
    end
    this.baseReputation = ConfigMgr.Config.constants.ManagementBasicRep[1]
    this.CloseCollectGroup()
    this.InitGoalCellItem()
end

this.before_active = function()
    this.StartGameBefore()
    this.SetUsePropItem()
end


this.StartGameBefore = function()
    this.before_deactive()
    this.vmBehaviour:UpdateTopBar("", this.OnPauseGame)
    SetActive(this.comboCountText.gameObject, false)
    SetActive(this.comboProgress.gameObject, false)
    SetActive(this.comboGroup, false)
    if this.inputUI == nil then
        this.inputUI = GameGridInput.New(this.gridParent)
    end
    this.isComboing = false
    this.curComboCount = 0
    this.passData = ManagementGameData.GetPassData(this.passID)
    ManagementGameData.SetGameStatus(ManagementConst.GameStatus.BeforeStart, this.passID)
    this.SetUsePropItem()
    this.InitGridCell()
    this.startGameTime = ManagementConst.StartGameTime
    LuaMgr.RemoveTimer(TimerConst.ManagementStartGameDelay)
    LuaMgr.RemoveTimer(TimerConst.ManagementTotaTimeDelay)
    LuaMgr.RemoveTimer(TimerConst.ManagementComboTimeDelay)
    this.SetRemainTimeText(this.passData.Limittimes)
    SetActive(this.downTimeGroup, true)
    LuaMgr.AddTimer(TimerConst.ManagementStartGameDelay, this.StartGameTimer, 1, -1, true)
    this.RefreshGoalItem()
    local previewGetRewardCount = ManagementGameData.GetPassReputation()
    local maxGetRewardCount = this.passData.config.limit[1].count
    previewGetRewardCount = math.min(previewGetRewardCount, maxGetRewardCount)
    this.curReputation.text = tostring(previewGetRewardCount)
end

this.InitGridCell = function()
    local mapData = this.passData and this.passData.MapGroup or nil
    if mapData == nil then
        return
    end
    for row = 1, #mapData do
        local rowConfig = mapData[row]
        for col = 1, ManagementConst.BigRowColCount.Col do
            local configColName = "column" .. col
            local layerConfigs = rowConfig[configColName]
            local bigGridPos = GridPosition.New(col, row)
            local posKey = bigGridPos:ToString()
            local bigCellData = ManagementBigCellData.New(bigGridPos)
            ManagementGameData.AddBigCellData(bigGridPos, bigCellData)
            if type(layerConfigs) == "table" and #layerConfigs > 0 then
                local totalLayer = 0
                bigCellData:SetValid(true)
                for layerNum = #layerConfigs, 1, -1 do
                    local bigGridCells = {}
                    local layerConfig = layerConfigs[layerNum]
                    for gridNum = 1, ManagementConst.BigOfSmallCount do
                        local smallGridPosX = (col - 1) * ManagementConst.BigOfSmallCount + gridNum
                        local smallGridPos = GridPosition.New(smallGridPosX, row)
                        local data = {}
                        data.validGrid = true
                        data.bigGridPos = bigGridPos
                        data.smallGridPos = smallGridPos
                        data.elementID = layerConfig[gridNum]
                        data.layerNum = layerNum
                        local gridCell = this.GetCellFromCache()
                        gridCell:SetData(data)
                        gridCell:UpdatePos()
                        gridCell.transform:SetAsLastSibling()
                        table.insert(bigGridCells, #bigGridCells + 1, gridCell)
                        bigCellData:Add(gridCell, layerNum, #bigGridCells)
                    end
                    totalLayer = totalLayer + 1
                end
                bigCellData:RefreshLayer()
                bigCellData:SetTotalLayer(totalLayer)
            else
                bigCellData:SetValid(false)
                local bigGridCells = {}
                for gridNum = 1, ManagementConst.BigOfSmallCount do
                    local smallGridPosX = (col - 1) * ManagementConst.BigOfSmallCount + gridNum
                    local smallGridPos = GridPosition.New(smallGridPosX, row)
                    local data = {}
                    data.validGrid = false
                    data.bigGridPos = bigGridPos
                    data.smallGridPos = smallGridPos
                    local gridCell = this.GetCellFromCache()
                    gridCell:SetData(data)
                    gridCell:UpdatePos()
                    table.insert(bigGridCells, #bigGridCells + 1, gridCell)
                    bigCellData:Add(gridCell, 1, #bigGridCells)
                end
                bigCellData:SetTotalLayer(1)
                bigCellData:RefreshLayer()
            end
        end
    end
end

this.GetCellFromCache = function()
    if this.gridCellsCache == nil then
        this.gridCellsCache = {}
    end
    if #this.gridCellsCache > 0 then
        local gridCell = table.remove(this.gridCellsCache)
        SetActive(gridCell.gameObject, true)
        return gridCell
    end
    return ManagementGameCell.New(this.gridCell, this.gridParent)
end

this.StartGameTimer = function()
    this.startGameTime = this.startGameTime - 1
    if this.startGameTime <= 0 then
        SetActive(this.downTimeGroup, false)
        LuaMgr.RemoveTimer(TimerConst.ManagementStartGameDelay)
        ManagementGameData.SetRemainTime(this.passData.Limittimes)
        this.OnGameStart()
    end
end

this.OnGameStart = function()
    local data = {}
    data.id = this.passID
    ManagementGameData.SetGameStatus(ManagementConst.GameStatus.Gaming)
    local callback = function(res)
        if res.code ~= nil and res.code ~= 0 then
            LuaDebug.error("开始游戏请求失败，错误码：" .. tostring(res.code))
            return
        end
        LuaMgr.AddTimer(TimerConst.ManagementStartGameDelay, this.GameDownTimer, 1, -1, true)
    end
    ApiMgr.Request("casualsGame/start", data, true, callback, nil, true)
end

this.GameDownTimer = function()
    local remainTime = ManagementGameData.GetRemainTime()
    remainTime = remainTime - 1
    this.SetRemainTimeText(remainTime)
    ManagementGameData.SetRemainTime(remainTime)
    if remainTime <= 0 then
        LuaMgr.RemoveTimer(TimerConst.ManagementStartGameDelay)
        this.OnGameOver(ManagementConst.GameResult.Fail)
    end
end

this.SetRemainTimeText = function(remainTime)
    local hour, minute, seconds = GetTimeHMS(remainTime)
    this.remainTime.text = string.format("%s:%s", minute, seconds)
end

this.OnPauseGame = function()
    if this.useItemType == ManagementConst.ItemType.RandomCollect then
        return
    end
    if ManagementGameData.GetGameStatus() ~= ManagementConst.GameStatus.Gaming then
        return
    end
    if this.propCollectGroup.gameObject.activeSelf == true then
        this.CloseCollectGroup()
        return
    end
    if this.propMaskParent.gameObject.activeSelf == true then
        this.OnClosePropUseMask()
        return
    end
    LuaMgr.RemoveTimer(TimerConst.ManagementStartGameDelay)
    ManagementGameData.SetGameStatus(ManagementConst.GameStatus.Pause)
    this.OnClickBack()
end

this.ContinueGame = function()
    this.OnGameStart()
end

this.CloseCollectGroup = function()
    SetActive(this.propCollectGroup.gameObject, false)
end



this.OnGameOver = function(res)
    ManagementGameData.SetGameStatus(ManagementConst.GameStatus.None)
    local data = {}
    data.passData = this.passData
    data.curReputation = ManagementGameData.GetPassReputation()
    data.gameRes = res or ManagementConst.GameResult.Fail
    data.name = this.name
    data.onExistCallback = function()
        local func = function()
            LuaMgr.ShowLuaPanel(UIName.DelegatedPanel)
        end
        ManagementGameData.SetGameStatus(ManagementConst.GameStatus.None)
        this.vmBehaviour:UpdateTopBar("", nil)
        LuaMgr.Back()
        LuaMgr.NextFrame(func)
    end
    data.onReplayCallback = function()
        this.StartGameBefore()
    end
    LuaMgr.RemoveTimer(TimerConst.ManagementStartGameDelay)
    LuaMgr.RemoveTimer(TimerConst.ManagementTotaTimeDelay)
    LuaMgr.RemoveTimer(TimerConst.ManagementComboTimeDelay)
    SetActive(this.comboGroup, false)
    this.vmBehaviour:UpdateTopBar("", nil)
    LuaMgr.ShowLuaPanel(UIName.ManagementGameResPanel, data)
end

this.CheckGameOver = function()
    local isReachGoal = ManagementGameData.CheckReachGoal(this.passID)
    if isReachGoal == true then
        this.OnGameOver(ManagementConst.GameResult.Success)
    end
    return isReachGoal
end




this.SetUsePropItem = function()
    local propDatas = ManagementGameData.GetPropData()
    for key, value in pairs(this.usePropItems) do
        value:SetIsCold(false)
        local data = propDatas[key]
        value:SetData(data)
    end
end




this.UseItemBtn1 = function(item)
    local canUse, status = ManagementGameData.CheckCanUseProp(ManagementConst.ItemType.RandomCollect)
    if canUse == false then
        local tipsContent = ""
        if status == ManagementConst.UseItemStatus.ColdTime then
            tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_27118")
        elseif status == ManagementConst.UseItemStatus.CountLimit then
            tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_27119")
        end
        if status ~= nil then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        end
        return
    end
    if this.CollectElement() == false then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_27117")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    if this.useItemType ~= ManagementConst.ItemType.None then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_27120")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    this.useItemType = ManagementConst.ItemType.RandomCollect
    item:SetIsCold(true)
    item:SetCount(item.count - 1)
    item:SetDownTimer(ManagementGameData.GetUsePropDelay())
    ManagementGameData.UseProp(ManagementConst.ItemType.RandomCollect)
    this.usePropTimeDic[ManagementConst.ItemType.RandomCollect] = LuaMgr.Timestamp()
    LuaMgr.RemoveTimer(TimerConst.ManagementUsePropDelay)
    LuaMgr.AddTimer(TimerConst.ManagementUsePropDelay, this.UsePropDownTimer, 1, -1, false)
    if this.collectElementCor ~= nil then
        coroutine_runner.stop(this.collectElementCor)
        this.collectElementCor = nil
    end
    coroutine_runner.start(this.EliminatedCollectElment)
end

this.CollectElement = function()
    local mapData = this.passData and this.passData.MapGroup or nil

    local topLayerSmallcells = {}
    for row = 1, #mapData do
        for col = 1, ManagementConst.BigRowColCount.Col do
            local bigGridPos = GridPosition.New(col, row)
            local bigCellData = ManagementGameData.GetBigGridElements(bigGridPos)
if bigCellData and bigCellData:GetValid() then
                local smallCells = bigCellData:GetSmallCells()
                for key, smallCell in pairs(smallCells) do
                    table.insert(topLayerSmallcells, smallCell)
                end
            end
        end
    end

    if #topLayerSmallcells < 9 then
        return false
    end
    local needGourpCount = 3
    local groupCellCount = ManagementConst.BigOfSmallCount

    local allTopCellList = {}

    local samleElementDic = {}
    for i = 1, #topLayerSmallcells do
        local smallCell = topLayerSmallcells[i]
        if not smallCell:IsEmpty() then
            local smallCellElmentID = smallCell:GetElementID()
            local samleElementList = samleElementDic[smallCellElmentID] or {}
            table.insert(samleElementList, smallCell)
            table.insert(allTopCellList, smallCell)
            samleElementDic[smallCellElmentID] = samleElementList
        end
    end
    local elementList = {}
    for elementID, samleElementList in pairs(samleElementDic) do
        if #samleElementList >= 3 then
            table.insert(elementList, elementID)
            ShuffleTable(elementList)
        end
    end

    if #allTopCellList < needGourpCount * groupCellCount then
        return false
    end
    Shuffle(#elementList)

    this.resultSmallCellDic = {}
    this.resultElementCellDic = {}

    this.resultSmallCellList = {}
    if #elementList < needGourpCount then

        local selectedElements = {}
        local maxCellCount = 0
        local maxCellCountElementID = 0
        for elementID, samleElementList in pairs(samleElementDic) do
            if #samleElementList > maxCellCount then
                maxCellCountElementID = elementID
            end

            if #samleElementList % groupCellCount ~= 0 then
                return false
            end
        end
        for groupIndex = 1, needGourpCount do
            local elementID = elementList[groupIndex]
            local tempElementList = {}
            if elementID == nil then
                local maxCountCellList = samleElementDic[maxCellCountElementID]
                local startIndex = (selectedElements[maxCellCountElementID] or 0) + 1
                for i = startIndex, #maxCountCellList do
                    table.insert(tempElementList, #tempElementList + 1, maxCountCellList[i])
                end
            else
                tempElementList = samleElementDic[elementID]
            end
            local datas = {}
            local elements = {}
            for j = 1, groupCellCount do
                local cell = tempElementList[j]
                table.insert(datas, #datas + 1, cell)
                local oldElementData = {}
                oldElementData.elementID = cell:GetElementID()
                table.insert(elements, #elements + 1, oldElementData)
                table.insert(this.resultSmallCellList, cell)
                selectedElements[oldElementData.elementID] = (selectedElements[oldElementData.elementID] or 0) + 1
            end
            table.insert(this.resultSmallCellDic, #this.resultSmallCellDic + 1, datas)
            table.insert(this.resultElementCellDic, #this.resultElementCellDic + 1, elements)
        end
    else
        for groupIndex = 1, needGourpCount do
            local elementID = elementList[groupIndex]
            local tempElementList = samleElementDic[elementID]
            local datas = {}
            local elements = {}
            for j = 1, groupCellCount do
                local cell = tempElementList[j]
                table.insert(datas, #datas + 1, cell)
                local oldElementData = {}
                oldElementData.elementID = cell:GetElementID()
                table.insert(elements, #elements + 1, oldElementData)
                table.insert(this.resultSmallCellList, cell)
            end
            table.insert(this.resultSmallCellDic, #this.resultSmallCellDic + 1, datas)
            table.insert(this.resultElementCellDic, #this.resultElementCellDic + 1, elements)
        end
    end
    return true
end

this.EliminatedCollectElment = function()
    local waitSeconds = ManagementConst.EliminateAniTime
    for key, smallCell in pairs(this.resultSmallCellList) do
        ManagementGameData.RefreshGoal(this.passID, smallCell.data.elementID)
        smallCell:SetElement(0, true)
        smallCell:PlayAnim(true)
        this.AddReputation(1, true)
        coroutine_runner.wait(waitSeconds)
        this.RefreshGoalItem()
        local bigCellData = ManagementGameData.GetBigGridElements(smallCell:GetBigGridPos())
        if bigCellData then
            bigCellData:RefreshLayer()
        end
    end
    coroutine_runner.wait(waitSeconds)
    local isGameOver = this.CheckGameOver()
    if isGameOver == false then
        this.SetCollectRes()
    end
    this.resultSmallCellDic = nil
    this.resultSmallCellList = nil
    this.useItemType = ManagementConst.ItemType.None
end

this.SetCollectRes = function()
    SetActive(this.propCollectGroup.gameObject, true)
    for i = 1, #this.collectUIItems do
        local cells = this.collectUIItems[i]
        for j = 1, #cells do
            local cell = cells[j]
            local data = this.resultElementCellDic[i][j]
            cell:SetDataOnly(data)
        end
    end
end





this.UseItemBtn2 = function(item)
    local canUse, status = ManagementGameData.CheckCanUseProp(ManagementConst.ItemType.RandomSort)
    if canUse == false then
        local tipsContent = ""
        if status == ManagementConst.UseItemStatus.ColdTime then
            tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_27118")
        elseif status == ManagementConst.UseItemStatus.CountLimit then
            tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_27119")
        end
        if status then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        end
        return
    end
    if this.useItemType ~= ManagementConst.ItemType.None then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_27120")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    ManagementGameData.UseProp(ManagementConst.ItemType.RandomSort)
    item:SetIsCold(true)
    item:SetCount(item.count - 1)
    item:SetDownTimer(ManagementGameData.GetUsePropDelay())
    this.usePropTimeDic[ManagementConst.ItemType.RandomSort] = LuaMgr.Timestamp()
    LuaMgr.RemoveTimer(TimerConst.ManagementUsePropDelay)
    LuaMgr.AddTimer(TimerConst.ManagementUsePropDelay, this.UsePropDownTimer, 1, -1, false)
    this.ReshuffleCell()
    this.useItemType = ManagementConst.ItemType.None
end

this.ReshuffleCell = function()
    local mapData = this.passData and this.passData.MapGroup or nil
    if mapData == nil then
        LuaDebug.error("UseItemBtn2：地图数据为空，无法打乱")
        return
    end


local globalElements = {}
local targetPositions = {}


    for row = 1, #mapData do
        for col = 1, ManagementConst.BigRowColCount.Col do
            local bigGridPos = GridPosition.New(col, row)
            local bigCellData = ManagementGameData.GetBigGridElements(bigGridPos)
if bigCellData and bigCellData:GetValid() then

                local layerNums = {}
                for num in pairs(bigCellData.smallCellDic or {}) do
                    table.insert(layerNums, num)
                end
                table.sort(layerNums)

                for _, layerNum in ipairs(layerNums) do
                    local smallCellDic = bigCellData.smallCellDic[layerNum]
                    if not smallCellDic then
                        goto continueLayer
                    end

local smallPosList = {}

                    local smallPosKeys = {}
                    for key in pairs(smallCellDic) do
                        table.insert(smallPosKeys, key)
                    end
                    table.sort(smallPosKeys)


                    for _, smallPosKey in ipairs(smallPosKeys) do
                        local smallCell = smallCellDic[smallPosKey]
                        if not smallCell:IsEmpty() then
                            table.insert(globalElements, smallCell:GetElementID())

                            local smallGridPos = smallCell.data.smallGridPos:ToString()
                            table.insert(smallPosList, smallGridPos)
                        end
                    end


                    if #smallPosList > 0 then
                        local cacheKey = bigGridPos:ToString() .. "-" .. tostring(layerNum)
                        targetPositions[cacheKey] = {
                            bigCellData = bigCellData,
                            layerNum = layerNum,
                            smallPosList = smallPosList
                        }
                    end
                    ::continueLayer::
                end
            end
        end
    end


    if #globalElements == 0 then
        LuaDebug.warn("ShuffleGridCell：无有效小格子元素，无需打乱")
        return
    end
    this.LogGlobalElements(globalElements)


    local function globalShuffle(elements)
        local shuffled = {}
        for i = 1, #elements do
            shuffled[i] = elements[i]
        end
        for i = #shuffled, 2, -1 do
            local j = math.random(1, i)
            shuffled[i], shuffled[j] = shuffled[j], shuffled[i]
        end
        return shuffled
    end


    local targetCacheKeys = {}
    for key in pairs(targetPositions) do
        table.insert(targetCacheKeys, key)
    end
    table.sort(targetCacheKeys)


local maxRetry = 20
    local assigned = false

    for retry = 1, maxRetry do
        local shuffledElements = globalShuffle(globalElements)
local elementIndex = 1
local tempAssignments = {}
local assignValid = true


        for _, cacheKey in ipairs(targetCacheKeys) do
            local layerInfo = targetPositions[cacheKey]
            local smallPosCount = #layerInfo.smallPosList

            if elementIndex + smallPosCount - 1 > #shuffledElements then
                LuaDebug.error("ShuffleGridCell：元素数量不足，分配中断（重试" .. retry .. "次）")
                assignValid = false
                break
            end

            local layerElements = {}
            for i = 1, smallPosCount do
                table.insert(layerElements, shuffledElements[elementIndex])
                elementIndex = elementIndex + 1
            end
            tempAssignments[cacheKey] = layerElements
        end


        if not assignValid then
            goto continueRetry
        end


        local allLayersValid = true
        for _, cacheKey in ipairs(targetCacheKeys) do
            local layerElements = tempAssignments[cacheKey]
            local layerInfo = targetPositions[cacheKey]
            if not this.CheckLayerValidity(layerElements) then
                allLayersValid = false
                this.LogLayerCheckFailed(layerInfo.bigCellData.gridPos, layerInfo.layerNum, layerElements)
                break
            end
        end


        if allLayersValid then
local totalSmall = 0
            for _, cacheKey in ipairs(targetCacheKeys) do
                local layerInfo = targetPositions[cacheKey]
                local bigCellData = layerInfo.bigCellData
                local layerNum = layerInfo.layerNum
                local smallPosList = layerInfo.smallPosList
                local layerElements = tempAssignments[cacheKey]


                local originalLayer = bigCellData.curLayer
                bigCellData.curLayer = layerNum


                totalSmall = totalSmall + #smallPosList
                for idx, smallGridPosStr in ipairs(smallPosList) do
                    local smallGridPos = this.ParseGridKey(smallGridPosStr)
                    local smallCell, success = bigCellData:GetSmallCell(smallGridPos)
                    if success and smallCell then
                        smallCell:SetElement(layerElements[idx])
                    else
                        LuaDebug.error(string.format("赋值失败：大格子%s 层%s 小格子%s不存在", bigCellData.gridPos:ToString(), layerNum, smallGridPos:ToString()))
                    end
                end

                bigCellData.curLayer = originalLayer
                this.LogLayerAssignment(bigCellData.gridPos, layerNum, layerElements)
            end
            assigned = true
            break
        end
::continueRetry::
    end

    if not assigned then
        LuaDebug.error("全局洗牌失败：超过最大重试次数" .. maxRetry .. "，未找到合法分配方案")
    end
end




this.ParseGridKey = function(key)
    local x, y = string.match(key, "(%d+),(%d+)")
    local xInt = tonumber(x) or -1
    local yInt = tonumber(y) or -1
    return GridPosition.New(xInt, yInt)
end




this.UseItemBtn3 = function(item)
    local canUse, status = ManagementGameData.CheckCanUseProp(ManagementConst.ItemType.Swap)
    if canUse == false then
        local tipsContent = ""
        if status == ManagementConst.UseItemStatus.ColdTime then
            tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_27118")
        elseif status == ManagementConst.UseItemStatus.CountLimit then
            tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_27119")
        end
        if status then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        end
        return
    end
    if this.useItemType ~= ManagementConst.ItemType.None then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_27120")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    this.useItemType = ManagementConst.ItemType.Swap
    this.useItemBtn = item
    SetActive(this.propMaskParent.gameObject, true)
    SetActive(this.propMaskParentCloseBtn.gameObject, true)
    this.inputUI:SetUsePropType(this.useItemType)
end

this.OnClosePropUseMask = function()
    this.useItemType = ManagementConst.ItemType.None
    this.inputUI:SetUsePropType(this.useItemType)
    SetActive(this.propMaskParent.gameObject, false)
    SetActive(this.propMaskParentCloseBtn.gameObject, false)
end

this.OnUseProp3Succ = function(params)
    local item = this.useItemBtn
    if item ~= nil then
        ManagementGameData.UseProp(ManagementConst.ItemType.Swap)
        item:SetIsCold(true)
        item:SetCount(item.count - 1)
        item:SetDownTimer(ManagementGameData.GetUsePropDelay())
        this.usePropTimeDic[ManagementConst.ItemType.Swap] = LuaMgr.Timestamp()
        LuaMgr.RemoveTimer(TimerConst.ManagementUsePropDelay)
        LuaMgr.AddTimer(TimerConst.ManagementUsePropDelay, this.UsePropDownTimer, 1, -1, false)
        this.OnClosePropUseMask()
        this.useItemBtn = nil
    end
    if params ~= nil then
        local itemCells = params[0]
        for _, itemCell in pairs(itemCells) do
            itemCell:SetSeleted(false)
        end
    end
end


this.UsePropDownTimer = function(forceReset)
    local curTime = LuaMgr.Timestamp()
    local delay = ManagementGameData.GetUsePropDelay()
    for i = 1, 3 do
        local startTime = this.usePropTimeDic[i]
        if forceReset == true or (startTime ~= nil and curTime - startTime >= delay) then
            ManagementGameData.CheckCanUseProp(i)
            this.usePropItems[i]:SetIsCold(false)
            this.usePropTimeDic[i] = nil
        elseif startTime ~= nil then
            this.usePropItems[i]:SetDownTimer()
        end
    end
end



this.InitNode = function()
    for i = 1, 3 do
        local data = {}
        data.path = "root/Middle/GoalGroup/Goal" .. i
        data.type = UITool.GameObject
        local cellName = "Goal" .. i
        objs[cellName] = data

        local data1 = {}
        data1.path = string.format("root/Middle/GoalGroup/Goal%d/GoalNum%d/Text", i, i)
        data1.type = UITool.Text
        local cellName1 = "GoalNum" .. i
        objs[cellName1] = data1
    end
    for i = 1, 4 do
        local data = {}
        data.path = "root/Middle/DownTimeGroup/DownTime" .. i
        data.type = UITool.GameObject
        local cellName = "StartDownTime" .. i
        objs[cellName] = data
    end
    for i = 1, 3 do
        for j = 1, 3 do
            local data = {}
            local cellName = string.format("GridCell%d_%d", i, j)
            data.path = "root/Middle/PropCollectGroup/" .. cellName
            data.type = UITool.GameObject
            objs[cellName] = data
        end
    end
end

this.InitPropCollectElement = function()
    for i = 1, 3 do
        local items = {}
        for j = 1, 3 do
            local cellName = string.format("GridCell%d_%d", i, j)
            local cell = this[cellName]
            local item = ManagementGameCell.New(cell)
            table.insert(items, #items + 1, item)
        end
        table.insert(this.collectUIItems, #this.collectUIItems + 1, items)
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



this.OnEliminatedElement = function(params)
    this.useItemType = ManagementConst.ItemType.None
    if params == nil or params.Length == 0 or type(params[0]) ~= "table" then
        return
    end
    this.eliminatedParams = params[0]
    if this.eliminatedCor ~= nil then
        coroutine_runner.stop(this.eliminatedCor)
        this.eliminatedCor = nil
    end
    this.eliminatedCor = coroutine_runner.start(this.OnEliminatedElementCor)
end

this.OnEliminatedElementCor = function()
    local data = this.eliminatedParams
    if data == nil then
        coroutine_runner.stop(this.eliminatedCor)
        this.eliminatedCor = nil
        return
    end
    local totalEliminatedElement = 0
    local existElimilate = false
local waitSeconds = 0
local waitSeconds1 = 0
    if data.goalData ~= nil then
        if data.goalData.canElimilateElement == true then

            local smallCellDatas = data.goalData.smallCellsDic
            for key, value in pairs(smallCellDatas) do
                ManagementGameData.RefreshGoal(this.passID, value.data.elementID)
                value:SetElement(0, true)
                value:PlayAnim(true)
            end
            totalEliminatedElement = totalEliminatedElement + 3
            existElimilate = true
            waitSeconds = ManagementConst.EliminateAniTime
        end
    end
    if data.startData ~= nil then
        if data.startData.canElimilateElement == true then

            local smallCellDatas = data.startData.smallCellsDic
            for key, value in pairs(smallCellDatas) do
                ManagementGameData.RefreshGoal(this.passID, value.data.elementID)
                value:SetElement(0, true)
            end
            totalEliminatedElement = totalEliminatedElement + 3
            existElimilate = true
            waitSeconds = ManagementConst.EliminateAniTime
        end
    end
    if waitSeconds then
        coroutine_runner.wait(waitSeconds)
    end
    if data.goalData ~= nil and data.goalData.bigCellData ~= nil then
        local isNewLayer = data.goalData.bigCellData:RefreshLayer()
        waitSeconds1 = isNewLayer and ManagementConst.LayerRiseAniTime or 0
    end
    if data.startData ~= nil and data.startData.bigCellData ~= nil then
        local isNewLayer = data.startData.bigCellData:RefreshLayer()
        waitSeconds1 = isNewLayer and ManagementConst.LayerRiseAniTime or 0
    end
    if waitSeconds1 > 0 then
        coroutine_runner.wait(waitSeconds1)
    end
    if existElimilate == false then
        coroutine_runner.stop(this.eliminatedCor)
        this.eliminatedCor = nil
        this.eliminatedParams = nil
        return
    end
    this.RefreshGoalItem()
    if this.curComboCount == 0 then
        this.curComboRemainTime = this.managementComboCD[1]
    else
        this.curComboRemainTime = this.managementComboCD[this.curComboCount + 1] or this.managementComboCD[#this.managementComboCD]
    end
    this.maxDownTime = this.curComboRemainTime
    LuaMgr.RemoveTimer(TimerConst.ManagementComboTimeDelay)
    LuaMgr.AddTimer(TimerConst.ManagementComboTimeDelay, this.OnComboDownTimer, this.perframeSecond, -1, false)
    this.AddReputation(totalEliminatedElement, false)
    if this.isComboing == true then
        this.curComboCount = this.curComboCount + 1
    end
    if this.curComboCount > 0 then
        SetActive(this.comboGroup, true)
        SetActive(this.comboCountText.gameObject, true)
        SetActive(this.comboProgress.gameObject, true)
        local lanStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_27104")
        this.comboCountText.text = string.format(lanStr, this.curComboCount)
    end
    this.CheckGameOver()
    this.eliminatedParams = nil
end

this.AddReputation = function(totalEliminatedElement, isUseItem)
    local comboCount = isUseItem == true and 0 or this.curComboCount

    local totalReputation = this.baseReputation.count * totalEliminatedElement * (1 + comboCount / 100)
    local curReputation = math.floor(totalReputation)
    local maxGetRewardCount = this.passData.config.limit[1].count
    ManagementGameData.AddReputation(curReputation, maxGetRewardCount)
    this.curReputation.text = tostring(ManagementGameData.GetPassReputation())
end

this.OnComboDownTimer = function()
    this.curComboRemainTime = this.curComboRemainTime - this.perframeSecond
    this.isComboing = true
    this.comboProgress.fillAmount = this.curComboRemainTime / this.maxDownTime
    if this.curComboRemainTime <= 0 then
        this.isComboing = false
        this.curComboCount = 0
        LuaMgr.RemoveTimer(TimerConst.ManagementComboTimeDelay)
        SetActive(this.comboGroup, false)
        SetActive(this.comboCountText.gameObject, false)
        SetActive(this.comboProgress.gameObject, false)
    end
end



this.OnClickBack = function()
    local data = {}
    data.onExistCallback = function()
        LuaMgr.HidePanel(UIName.ManagementGamePausePopup)
        local func = function()
            this.vmBehaviour:UpdateTopBar("", nil)
            LuaMgr.Back()
            local func = function()
                LuaMgr.ShowLuaPanel(UIName.DelegatedPanel)
            end
            LuaMgr.NextFrame(func)
        end
        ManagementGameData.SetGameStatus(ManagementConst.GameStatus.None)
        LuaMgr.NextFrame(func)
    end
    data.onReplayCallback = function()
        this.StartGameBefore()
    end
    data.onContinueCallback = function()
        this.ContinueGame()
    end
    LuaMgr.ShowLuaPanel(UIName.ManagementGamePausePopup, data)
end

this.before_deactive = function()
    this.useItemType = ManagementConst.ItemType.None
    if this.collectElementCor ~= nil then
        coroutine_runner.stop(this.collectElementCor)
        this.collectElementCor = nil
    end
    if this.eliminatedCor ~= nil then
        coroutine_runner.stop(this.eliminatedCor)
        this.eliminatedCor = nil
    end

    SetActive(this.propMaskParent.gameObject, false)
    SetActive(this.propMaskParentCloseBtn.gameObject, false)
    SetActive(this.propCollectGroup.gameObject, false)
    local allSmallCells = ManagementGameData.GetAllBigOfSmallCells()
    for key, value in pairs(allSmallCells) do
        local smallCells = value:GetAllSmallCells()
        for key1, value1 in pairs(smallCells) do
            table.insert(this.gridCellsCache, value1)
            SetActive(value1.gameObject, false)
        end
    end
    ManagementGameData.RecycleBigCellData()
end

this.before_destroy = function()
    ManagementGameData.RecycleBigCellData()
end


this.CheckLayerValidity = function(elements)

    local isAllZero = true
    for _, elem in ipairs(elements) do
        if elem ~= 0 then
            isAllZero = false
            break
        end
    end
    if isAllZero then
        return true
    end


    local elemCount = {}
    for _, elem in ipairs(elements) do
        elemCount[elem] = (elemCount[elem] or 0) + 1
        if elemCount[elem] >= 3 then
            return false
        end
    end
    return true
end




this.FormatElementList = function(list)
    local str = "["
    for i, elem in ipairs(list) do
        str = str .. tostring(elem)
        if i < #list then
            str = str .. ", "
        end
    end
    str = str .. "]"
    return str
end


this.LogGlobalElements = function(elements)
    if not this.shuffleDebug then
        return
    end
    LuaDebug.error("全局有效元素汇总：" .. this.FormatElementList(elements) .. "（共" .. #elements .. "个）")
end


this.LogLayerAssignment = function(bigGridPos, layerNum, elements)
    if not this.shuffleDebug then
        return
    end
    local posStr = bigGridPos:ToString()
    local layerStr = LuaMgr.GetLangText("ManagementGamePanel_4") .. layerNum .. LuaMgr.GetLangText("ManagementGamePanel_5")
    LuaDebug.error(string.format("分配结果：大格子%s %s 元素：%s", posStr, layerStr, this.FormatElementList(elements)))
end


this.LogLayerCheckFailed = function(bigGridPos, layerNum, elements)
    if not this.shuffleDebug then
        return
    end
    local posStr = bigGridPos:ToString()
    local layerStr = LuaMgr.GetLangText("ManagementGamePanel_6") .. layerNum .. LuaMgr.GetLangText("ManagementGamePanel_7")
    LuaDebug.error(string.format("分层校验失败：大格子%s %s 出现三个相同非0元素！元素：%s", posStr, layerStr, this.FormatElementList(elements)))
end



local data = {}
local command = {}
local hook = {
    before_awake = function(vm)
        this.InitNode()
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.InitPropCollectElement()
        LuaMgr.AddClick(this.pauseBtn, this.OnPauseGame)
        LuaMgr.AddClick(this.propCollectGroup, this.CloseCollectGroup)
        LuaMgr.AddClick(this.propMaskParentCloseBtn, this.OnClosePropUseMask)
        this.before_awake()
    end,
    before_active = function(vm)
        this.vmBehaviour = vm.behaviour
        vm.behaviour:UpdateTopBar("", this.OnPauseGame)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.passID = this.vmBehaviour.Params[0].passID
        this.name = this.vmBehaviour.Params[0].name
        LuaMgr.AddUIEventListener(UIEventConst.ManagementEliminatedElement, this.OnEliminatedElement)
        LuaMgr.AddUIEventListener(UIEventConst.ManagementSwapElementPosEnd, this.OnUseProp3Succ)
        this.before_active()
    end,
    before_deactive = function(vm)
        this.before_deactive()
        LuaMgr.RemoveUIEventListener(UIEventConst.ManagementEliminatedElement, this.OnEliminatedElement)
        LuaMgr.RemoveUIEventListener(UIEventConst.ManagementSwapElementPosEnd, this.OnUseProp3Succ)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveTimer(TimerConst.ManagementStartGameDelay)
        LuaMgr.RemoveTimer(TimerConst.ManagementTotaTimeDelay)
        LuaMgr.RemoveTimer(TimerConst.ManagementComboTimeDelay)
        LuaMgr.RemoveClick(this.pauseBtn, this.OnPauseGame)
        LuaMgr.RemoveClick(this.propCollectGroup, this.CloseCollectGroup)
        LuaMgr.RemoveClick(this.propMaskParentCloseBtn, this.OnClosePropUseMask)
        this.before_destroy()
    end
}

return vm({data = data, command = command, hook = hook})