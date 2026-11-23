ZXLGameData = {}
local this = {
    PassDic = {},
    PassList = {},

    GameStatus = ZXLConst.GameStatus.None,
matchSuccCount = 0,
    remainTipFuncCount = 0
}

ZXLGameData.InitData = function()

    local mapGroupDic = {}
    local mapConfigs = ConfigMgr.Config.PuzzleMaterialMap
    local mapConfigLen = NumTool.GetLen(mapConfigs)
    for i = 1, mapConfigLen do
        local data = {}
        local config = mapConfigs[tostring(2000 + i)]
        local mapID = tostring(config.Belong)
        data.ID = config.Id
        data.config = config
        if mapGroupDic[mapID] == nil then
            mapGroupDic[mapID] = {}
        end
        table.insert(mapGroupDic[mapID], #mapGroupDic[mapID] + 1, data)
    end

    local passConfig = ConfigMgr.Config.PuzzleGameMap
    for key, config in pairs(passConfig) do
        local mapID = config.Id
        local configID = config.Id
        local data = {}
        data.config = config
        data.ID = configID
        data.MapID = mapID
        data.Unlocktype = config.unlocktype
        data.Unlockpara = config.unlockpara
        data.Limittimes = config.Time
        data.Reward = table.CopyNoMeta(config.Reward)
        data.MapGroup = mapGroupDic[mapID]
        data.MaxRow = config.Scale[1]
        data.MaxCol = config.Scale[2]
        data.Map = {}
        for key, value in pairs(data.MapGroup) do
            local orginOccupy, orginPosDatas, normalizePosDatas, rangeX, rangeY = ZXLGameData.GetMaterialStruct(value.config.Occupy, data.MaxCol)
            value.orginOccupy = orginOccupy
            value.orginPosDatas = orginPosDatas
            value.normalizePosDatas = normalizePosDatas
            value.rangeX = rangeX
            value.rangeY = rangeY
        end

        for i = 1, #config.Valid do
            local gridPos = ZXLGameData.DimensionalOneNumToPos(config.Valid[i], data.MaxCol)
            local key = string.format("%d_%d", gridPos.X, gridPos.Y)
            data.Map[key] = gridPos
        end

        this.PassDic[configID] = data
        table.insert(this.PassList, #this.PassList + 1, data)
    end
end

ZXLGameData.GetPassConfigByID = function(passID)
    return this.PassDic[passID]
end

ZXLGameData.GetMaterialStruct = function(config, maxCol)
    local orginOccupy = {}
    for i = 1, #config do
        table.insert(orginOccupy, #orginOccupy + 1, config[i])
    end
    table.sort(orginOccupy)
    local rangeX = {min = 0, max = 0}
    local rangeY = {min = 0, max = 0}
    for i = 1, #orginOccupy do
        local orginPos = ZXLGameData.DimensionalOneNumToPos(orginOccupy[i], maxCol)
        if rangeX.min == 0 or orginPos.X < rangeX.min then
            rangeX.min = orginPos.X
        end
        if rangeX.max == 0 or orginPos.X > rangeX.max then
            rangeX.max = orginPos.X
        end
        if rangeY.min == 0 or orginPos.Y < rangeY.min then
            rangeY.min = orginPos.Y
        end
        if rangeY.max == 0 or orginPos.Y > rangeY.max then
            rangeY.max = orginPos.Y
        end
    end
    local normalizePosDatas = {}
    local orginPosDatas = {}
    for i = 1, #orginOccupy do
        local orginPos = ZXLGameData.DimensionalOneNumToPos(orginOccupy[i], maxCol)
        table.insert(orginPosDatas, #orginPosDatas + 1, orginPos)
        local normalizePos = GridPosition.New(orginPos.X - rangeX.min + 1, orginPos.Y - rangeY.min + 1)
        table.insert(normalizePosDatas, #normalizePosDatas + 1, normalizePos)
    end
    return orginOccupy, orginPosDatas, normalizePosDatas, rangeX, rangeY
end

ZXLGameData.DimensionalOneNumToPos = function(num, maxCol)
    local posX, posY = 0, 0
    if num % maxCol == 0 then
        posX = maxCol
    else
        posX = num % maxCol
    end
    if num % maxCol == 0 then
        posY = num / maxCol
    else
        posY = math.ceil(num / maxCol)
    end
    return GridPosition.New(posX, posY)
end

ZXLGameData.CheckPassIsUnlock = function(passID)
    return true
end

ZXLGameData.SetRemainTime = function(time)
    this.RemainTime = time
end

ZXLGameData.GetRemainTime = function()
    return this.RemainTime
end

ZXLGameData.GetPassData = function(passID)
    return this.PassDic[tostring(passID)]
end

ZXLGameData.GetPassDataLists = function()
    return this.PassList
end

ZXLGameData.GetElementConfigByID = function(elementID)
    local elementConfig = ConfigMgr.Config.ManagementElementMap[tostring(elementID)]
    return elementConfig
end

ZXLGameData.ResetGameData = function(passID)
    this.matchSuccCount = 0
    local passData = ZXLGameData.GetPassData(passID)
    this.remainTipFuncCount = tonumber(passData.config.TipUpperLimit)
end


ZXLGameData.SetGameStatus = function(status, passID)
    if status == ZXLConst.GameStatus.BeforeStart then
        ZXLGameData.ResetGameData(passID)
    end
    this.GameStatus = status
end


ZXLGameData.GetGameStatus = function()
    return this.GameStatus
end

ZXLGameData.AddMatchCount = function(count)
    this.matchSuccCount = this.matchSuccCount + count
end

ZXLGameData.GetMatchCount = function()
    return this.matchSuccCount
end

ZXLGameData.UseTipItem = function()
    local tempRemainCount = this.remainTipFuncCount - 1
    if tempRemainCount >= 0 then
        this.remainTipFuncCount = tempRemainCount
        return true
    end
    return false
end

ZXLGameData.GetTipsItemCount = function ()
    return this.remainTipFuncCount
end

ZXLGameData.SetStar = function(star)
    this.star = star
end

ZXLGameData.GetStar = function()
    return this.star
end