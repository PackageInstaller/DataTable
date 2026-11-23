ManagementGameData = {}
local this = {
    PassDic = {},
    PassList = {},

    BigGridDic = {},
UsePropData = {},
MaxUseItemCount = 0,
UsePropInterval = 0,

    GameStatus = ManagementConst.GameStatus.None,
    PassReputation = 0
}

ManagementGameData.InitData = function()

    local mapGroupDic = {}
    local mapConfigs = ConfigMgr.Config.ManagementMaps
    local mapConfigLen = NumTool.GetLen(mapConfigs)
    for i = 1, mapConfigLen do
        local config = mapConfigs[tostring(i)]
        local mapID = config.mapid
        if mapGroupDic[mapID] == nil then
            mapGroupDic[mapID] = {}
        end
        table.insert(mapGroupDic[mapID], #mapGroupDic[mapID] + 1, config)
    end

    local passConfig = ConfigMgr.Config.ManagementGameMap
    for key, config in pairs(passConfig) do
        local mapID = config.mapid
        local configID = config.id
        local data = {}
        data.config = config
        data.ID = configID
        data.MapID = mapID
        data.Unlocktype = config.unlocktype
        data.Unlockpara = config.unlockpara
        data.GoalPasscondition = {}
        for key, value in pairs(config.passcondition) do
            local tempData = {}
            local elementID = tonumber(value[1]) or 0
            local count = tonumber(value[2])
            table.insert(tempData, #tempData + 1, elementID)
            table.insert(tempData, #tempData + 1, count)
            table.insert(data.GoalPasscondition, #data.GoalPasscondition + 1, tempData)
        end
        data.Limittimes = config.limittimes
        data.Reward = config.reward
        data.MapGroup = mapGroupDic[mapID]

        this.PassDic[configID] = data
        table.insert(this.PassList, #this.PassList + 1, data)
    end
    this.MaxUseItemCount = ConfigMgr.Config.constants.ManagementSpecialItemLimit
    this.UsePropInterval = ConfigMgr.Config.constants.ManagementSpecialItemCD
end

ManagementGameData.CheckPassIsUnlock = function(passID)
    local passData = this.PassDic[passID]
    if passData == nil then
        return false
    end
    local unlockType = passData.Unlocktype
    local unlockParam = passData.Unlockpara
    if unlockType == ManagementConst.UnlockType.Pass then
        local serverData = DataMgr.Player.CasualsGame[unlockParam]
        if serverData ~= nil and serverData.passed == true then
            return true
        end
        return false
    elseif unlockType == ManagementConst.UnlockType.DelayTime then
        local curTime = LuaMgr.Timestamp()
        local activityData = DataExHelper.GetDataExByTag(ActivityKey.LYZM)
        local unlockTime = activityData.startTime + unlockParam * 86400
        if curTime >= unlockTime then
            return true
        end
        return false
    end
end

ManagementGameData.SetRemainTime = function(time)
    this.RemainTime = time
end

ManagementGameData.GetRemainTime = function()
    return this.RemainTime
end

ManagementGameData.GetPassData = function(passID)
    return this.PassDic[passID]
end

ManagementGameData.GetPassDataLists = function()
    return this.PassList
end

ManagementGameData.GetElementConfigByID = function(elementID)
    local elementConfig = ConfigMgr.Config.ManagementElementMap[tostring(elementID)]
    return elementConfig
end

ManagementGameData.ResetGameData = function(passID)
    this.PassReputation = 0
    ManagementGameData.ResetUsePropData()
    if passID ~= nil then
        local data = ManagementGameData.GetPassData(passID)
        if data ~= nil then
            data.CurGoalPasscondition = {}
        end
    end
end


ManagementGameData.SetGameStatus = function(status, passID)
    if status == ManagementConst.GameStatus.BeforeStart then
        ManagementGameData.ResetGameData(passID)
    end
    this.GameStatus = status
end


ManagementGameData.GetGameStatus = function()
    return this.GameStatus
end


ManagementGameData.AddReputation = function(reputation, maxGetRewardCount)
    this.PassReputation = this.PassReputation + reputation
    this.PassReputation = math.min(this.PassReputation, maxGetRewardCount)
end

ManagementGameData.GetPassReputation = function()
    return this.PassReputation
end


ManagementGameData.RefreshGoal = function(passID, elementID, count)
    local passData = ManagementGameData.GetPassData(passID)
    local curGoals = passData.CurGoalPasscondition or {}
    local curGoal = curGoals[elementID] or {}
    if curGoal ~= nil then
        curGoals[elementID] = (curGoals[elementID] or 0) + (count or 1)
    end
end

ManagementGameData.CheckReachGoal = function(passID)
    local passData = ManagementGameData.GetPassData(passID)
    local curGoals = passData.GoalPasscondition
    if passData.CurGoalPasscondition == nil then
        passData.CurGoalPasscondition = {}
    end
    for key, goal in pairs(curGoals) do
        local elementID = goal[1]
        local needCount = goal[2]
        local reachCount = passData.CurGoalPasscondition[elementID]
        if reachCount == nil or reachCount < needCount then
            return false
        end
    end
    return true
end






ManagementGameData.ScreenToGridPosition = function(screenPos, gridTransRect, isSmall)
    if not screenPos or not gridTransRect then
        LuaDebug.error("ScreenToGridPosition入参nil！screenPos=" .. tostring(screenPos) .. ", gridTransRect=" .. tostring(gridTransRect))
        return GridPosition.New(0, 0)
    end

    local localPosResult = RectTool.Screen2Local(Vector2(screenPos.x, screenPos.y), gridTransRect)
    if not localPosResult or not localPosResult.pos then
        LuaDebug.error("RectTool.Screen2Local返回nil！")
        return GridPosition.New(0, 0)
    end
    local localPos = localPosResult.pos

    local gridRect = gridTransRect.rect
    local gridWidth = gridRect.width
    local gridHeight = gridRect.height
    if gridWidth <= 0 or gridHeight <= 0 then
        LuaDebug.error("网格尺寸无效！gridWidth=" .. gridWidth .. ", gridHeight=" .. gridHeight)
        return GridPosition.New(0, 0)
    end

    local adjustedX = localPos.x + gridWidth / 2
    local adjustedY = gridHeight / 2 - localPos.y
    adjustedX = math.max(0, math.min(adjustedX, gridWidth))
    adjustedY = math.max(0, math.min(adjustedY, gridHeight))
    if adjustedX == 0 or adjustedX == gridWidth or adjustedY == 0 or adjustedY == gridHeight then
        return GridPosition.New(0, 0)
    end
    local smallGridPos = ManagementGameData.GetGridPosIndexByPos(adjustedX, adjustedY, isSmall)
    return smallGridPos
end






ManagementGameData.GetGridPosIndexByPos = function(adjustedX, adjustedY, isSmall)

    local cellSize = ManagementConst.SmallCellSize
    local rowColCount = isSmall and ManagementConst.SmallRowColCount or ManagementConst.BigRowColCount
    local maxCol = rowColCount.Col
    local maxRow = rowColCount.Row
    local leftMargin = 7.14
    if isSmall then
        if not ManagementGameData.xSmallPosMap or not ManagementGameData.ySmallPosMap then

ManagementGameData.xSmallPosMap = {}

            local bigOfSmallCount = ManagementConst.BigOfSmallCount
            for col = 1, maxCol do
                local data = {}
                local bigSpaceCount = 0
                local bigSpace = 0
                if col % bigOfSmallCount == 0 then
                    bigSpaceCount = col / bigOfSmallCount - 1
                else
                    bigSpaceCount = math.floor(col / bigOfSmallCount)
                end
                bigSpace = bigSpaceCount * ManagementConst.BigCellSpace.Width
                data.startX = leftMargin + (col - 1) * ManagementConst.SmallCellSpace.Width + ((col - 1) * cellSize.Width) + bigSpace
                data.endX = leftMargin + (col - 1) * ManagementConst.SmallCellSpace.Width + (col * cellSize.Width) + bigSpace
                data.col = col
                ManagementGameData.xSmallPosMap[col] = data
            end

            ManagementGameData.ySmallPosMap = {}
            local topMargin = 16.36
            local rowSpace = 27
            for row = 1, maxRow do
                local data = {}
                data.startY = topMargin + (row - 1) * rowSpace + ((row - 1) * cellSize.Height)
                data.endY = topMargin + (row - 1) * rowSpace + (row * cellSize.Height)
                data.row = row
                ManagementGameData.ySmallPosMap[row] = data
            end
        end


        local xPosMap = ManagementGameData.xSmallPosMap
        local yPosMap = ManagementGameData.ySmallPosMap

        local gridPosX = -1
        for col = 1, maxCol do
            local data = xPosMap[col]
            local startX = data.startX
            local endX = data.endX

            if adjustedX >= startX and adjustedX <= endX then
                gridPosX = data.col
                break
            end
        end

        local gridPosY = -1
        for row = 1, maxRow do
            local data = yPosMap[row]
            local startY = data.startY
            local endY = data.endY
            if adjustedY >= startY and adjustedY <= endY then
                gridPosY = row
                break
            end
        end
        return GridPosition.New(gridPosX, gridPosY)
    else
        if not ManagementGameData.xBigSizePosMap or not ManagementGameData.yBigSizePosMap then

            ManagementGameData.xBigSizePosMap = {}
            local bigOfSmallCount = ManagementConst.BigOfSmallCount
            local totalSmallSizeWidth = cellSize.Width * bigOfSmallCount + ManagementConst.SmallCellSpace.Width * (bigOfSmallCount - 1)
            local bigSpaceWidth = ManagementConst.BigCellSpace.Width + ManagementConst.SmallCellSpace.Width
            for col = 1, maxCol do
                local data = {}
                data.startX = leftMargin + (col - 1) * bigSpaceWidth + ((col - 1) * totalSmallSizeWidth)
                data.endX = leftMargin + (col - 1) * bigSpaceWidth + (col * totalSmallSizeWidth)
                data.col = col
                ManagementGameData.xBigSizePosMap[col] = data
            end

            ManagementGameData.yBigSizePosMap = {}
            local topMargin = 16.36
            local rowSpace = 27
            for row = 1, maxRow do
                local data = {}
                data.startY = topMargin + (row - 1) * rowSpace + ((row - 1) * cellSize.Height)
                data.endY = topMargin + (row - 1) * rowSpace + (row * cellSize.Height)
                data.row = row
                ManagementGameData.yBigSizePosMap[row] = data
            end
        end

        local xBigPosMap = ManagementGameData.xBigSizePosMap
        local yBigPosMap = ManagementGameData.yBigSizePosMap


        local bigGridPosX = -1
        for col = 1, maxCol do
            local data = xBigPosMap[col]
            local startX = data.startX
            local endX = data.endX

            if adjustedX >= startX and adjustedX <= endX then
                bigGridPosX = data.col
                break
            end
        end


        local bigGridPosY = -1
        for row = 1, maxRow do
            local data = yBigPosMap[row]
            local startY = data.startY
            local endY = data.endY
            if adjustedY >= startY and adjustedY <= endY then
                bigGridPosY = row
                break
            end
        end
        return GridPosition.New(bigGridPosX, bigGridPosY)
    end
end







ManagementGameData.AddBigCellData = function(gridPos, bigCellData)
    local posKey = gridPos:ToString()
    this.BigGridDic[posKey] = bigCellData
end

ManagementGameData.RecycleBigCellData = function()
    if this == nil or this.BigGridDic == nil then
        return
    end
    for key, value in pairs(this.BigGridDic) do
        if type(value) == "table" then
            for subKey, _ in pairs(value) do
                value[subKey] = nil
            end
        end
        this.BigGridDic[key] = nil
    end
    this.BigGridDic = {}
end





ManagementGameData.GetSmallGridElement = function(bigGridPos, smallGridPos)
    local bigCell = ManagementGameData.GetBigGridElements(bigGridPos)
    if bigCell == nil then
        return nil
    end
    local smallCell, success = bigCell:GetSmallCell(smallGridPos)
    return smallCell
end




ManagementGameData.GetBigGridElements = function(gridPos)
    return this.BigGridDic[gridPos:ToString()]
end



ManagementGameData.GetAllBigOfSmallCells = function()
    return this.BigGridDic
end





ManagementGameData.ResetUsePropData = function()
    for i = 1, 3 do
        this.UsePropData[i] = {}
    end
    for key, value in pairs(this.UsePropData) do
        value.status = ManagementConst.UseItemStatus.None
        value.useCount = 0
        value.lastUseTime = 0
        value.maxCount = this.MaxUseItemCount
    end
end

ManagementGameData.CheckCanUseProp = function(itemType)
    if ManagementGameData.GetGameStatus() ~= ManagementConst.GameStatus.Gaming then
        return false
    end
    local data = this.UsePropData[itemType]
    if data == nil then
        return true, ManagementConst.UseItemStatus.None
    end
    if data.status == ManagementConst.UseItemStatus.CountLimit then
        return false, data.status
    end
    local curTime = LuaMgr.Timestamp()
    if data.lastUseTime == nil or curTime - data.lastUseTime >= this.UsePropInterval then
        data.status = ManagementConst.UseItemStatus.None
    end
    return data.status == ManagementConst.UseItemStatus.None, data.status
end

ManagementGameData.UseProp = function(itemType)
    local data = this.UsePropData[itemType]
    if data == nil then
        ManagementGameData.ResetUsePropData()
        data = this.UsePropData[itemType]
    end
    data.status = ManagementConst.UseItemStatus.ColdTime
    data.useCount = (data.useCount or 1) + 1
    data.lastUseTime = LuaMgr.Timestamp()
    this.UsePropData[itemType] = data
    if data.useCount >= this.MaxUseItemCount then
        data.status = ManagementConst.UseItemStatus.CountLimit
    end
end

ManagementGameData.GetPropData = function()
    if this.UsePropData == nil or this.UsePropData == {} then
        ManagementGameData.ResetUsePropData()
    end
    return this.UsePropData
end

ManagementGameData.GetUsePropDelay = function()
    return this.UsePropInterval
end


