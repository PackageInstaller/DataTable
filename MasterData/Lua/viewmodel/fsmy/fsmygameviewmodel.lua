local ElementType = {
    Start = 1,
    End = 2,
    Standard = 3,
    ScoreUp = 4,
    ScoreDown = 5,
    Trap = 6,
    Obstacle = 7,
}

local StateType = {
    Playing = 1,
    Lost = 2,
    Won = 3,
}

local GridConfig = {
    Cols = 8,
    CellSize = 58,
    Atlas = "FSMY",
    PlayerSprite = "ui_hd_tymt_xyx_gz_dq",
    PathStraightSprite = "ui_hd_tymt_xyx_gz_lj1",
    PathCornerSprite = "ui_hd_tymt_xyx_gz_lj2",
}

local PauseType = {
    Reset = 1,
    Skip = 2,
    Back = 3,
    Lost = 4,
}

local MoveResult = {
    GameOver = LuaMgr.GetLangText("FSMYGameViewModel_0"),
    OutOfBounds = LuaMgr.GetLangText("FSMYGameViewModel_1"),
    Obstacle = LuaMgr.GetLangText("FSMYGameViewModel_2"),
    Repeated = LuaMgr.GetLangText("FSMYGameViewModel_3"),
    Trap = LuaMgr.GetLangText("FSMYGameViewModel_4"),
    Win = LuaMgr.GetLangText("FSMYGameViewModel_5"),
    Trapped = LuaMgr.GetLangText("FSMYGameViewModel_6"),
    Success = LuaMgr.GetLangText("FSMYGameViewModel_7"),
    NoUndo = LuaMgr.GetLangText("FSMYGameViewModel_8"),
}

local SearchDirs = {
    { x = 0,  y = 1 },
    { x = 0,  y = -1 },
    { x = 1,  y = 0 },
    { x = -1, y = 0 },
}


local this = {
    levelId = "",
    cols = 0,
    rows = 0,
    score = 0,
    baseScore = 0,
    skipScore = 0,
    state = StateType.Playing,
    playerX = 1,
    playerY = 1,
    gridData = {},
    linePath = {},
    undoStack = {},
    itemObjBox = {},
    playItem = nil,
    eventConfig = nil,
    mapOffset = Vector2(-195, 205),
    stars = {},
    rewardItems = {},
    isInitStar = true,
    totalStep = 0,
    addScore = 0,
    minusScore = 0,
    addTimes = 0,
    minusTimes = 0,
    addStepScore = 0,
    coroutine = nil,
    isFinish = false,
    directionList = {},
    standCost = 0,
};

local objs = {
    gridItem = { path = "template/gridItem", type = "GameObject" },
    gridItemDirection = { path = "template/gridItemDirection", type = "Transform" },
    gridLeft = { path = "template/gridItemDirection/imgLeft", type = "GameObject" },
    gridRight = { path = "template/gridItemDirection/imgRight", type = "GameObject" },
    gridUp = { path = "template/gridItemDirection/imgUp", type = "GameObject" },
    gridDown = { path = "template/gridItemDirection/imgDown", type = "GameObject" },
    rewardItem = { path = "template/RewardItem", type = "GameObject" },
    textTitle = { path = "root/Middle/TitleBg/TextTitle", type = "Text" },
    itemBox = { path = "root/Middle/ItemBox", type = "RectTransform" },
    btnBack = { path = "root/Right/BtnBack", type = "Button" },
    btnReset = { path = "root/Right/BtnReset", type = "Button" },
    btnSkip = { path = "root/Right/BtnSkip", type = "Button" },
    healthBg = { path = "root/Right/HealthBg", type = "RectTransform" },
    rectContent = { path = "root/Right/reward/tranLevelList/Viewport/Content/rectContent", type = "Transform" },
    btnRight = { path = "root/Left/MoveBox/BtnRight", type = "Button" },
    btnLeft = { path = "root/Left/MoveBox/BtnLeft", type = "Button" },
    btnUp = { path = "root/Left/MoveBox/BtnUp", type = "Button" },
    btnDown = { path = "root/Left/MoveBox/BtnDown", type = "Button" },
    textTotalNum = { path = "root/Left/ImageNumBg/TextTotalNum", type = "Text" },
    textAddNum = { path = "root/Left/ImageNumBg/ImageAdd/TextNum", type = "Text" },
    textMinusNum = { path = "root/Left/ImageNumBg/ImageMinus/TextNum", type = "Text" },
    textStepsNum = { path = "root/Left/ImageNumBg/ImageSteps/TextNum", type = "Text" },
    textAddTimesNum = { path = "root/Left/ImageNumBg/ImageAdd/TextTimes", type = "Text" },
    textMinusTimesNum = { path = "root/Left/ImageNumBg/ImageMinus/TextTimes", type = "Text" },
    textStepsTimesNum = { path = "root/Left/ImageNumBg/ImageSteps/TextTimes", type = "Text" },
    imageTips = { path = "root/ImageTips", type = "GameObject" },
    textTips = { path = "root/ImageTips/TextTips", type = "Text" },
};


this.OnBack = function()
    LuaMgr.ShowLuaPanel(UIName.FSMYGamePauseViewModel, PauseType.Back)
end

this.OnClickSkip = function()
    LuaMgr.ShowLuaPanel(UIName.FSMYGamePauseViewModel, PauseType.Skip)
end

this.SkipGame = function()
    this.score = this.skipScore
    this.SwitchState(StateType.Won)
end

this.OnClickReset = function()
    LuaMgr.ShowLuaPanel(UIName.FSMYGamePauseViewModel, PauseType.Reset)
end

this.OnClickBack = function(...)
    return this.BackStep()
end

this.PlayGame = function(args)
    this.eventConfig = args[0]
    this.LoadLevel(this.eventConfig.eventParam)
    if this.startDelay ~= nil then
        coroutine_runner.stop(this.startDelay)
    end
    this.startDelay = coroutine_runner.start(function()
        local levelConfig = ConfigMgr.Config.HackGameLevelMap[this.eventConfig.eventParam]
        SetActive(this.btnSkip.gameObject, false)
        coroutine_runner.wait(levelConfig.SkipTime)
        SetActive(this.btnSkip.gameObject, true)
    end)
end

this.ResetGame = function()
    this.LoadLevel(this.eventConfig.eventParam)
end

this.OnClickRight = function()
    this.Move(1, 0);
end

this.OnClickLeft = function()
    this.Move(-1, 0);
end

this.OnClickUp = function()
    this.Move(0, 1);
end

this.OnClickDown = function()
    this.Move(0, -1);
end


this.Clear = function()
    if (this.rewardItems ~= nil) then
        for k, v in pairs(this.rewardItems) do
            v.rewardObj:Hide();
            SetActive(v.go, false)
        end
    end
    if this.coroutine ~= nil then
        coroutine_runner.stop(this.coroutine)
        this.coroutine = nil
    end
    if this.startDelay ~= nil then
        coroutine_runner.stop(this.startDelay)
    end
end

this.Destroy = function()

end

this.LoadLevel = function(levelId)
    this.isInitStar = true
    SetActive(this.imageTips, false);
    this.levelId = levelId
    local levelConfig = ConfigMgr.Config.HackGameLevelMap[levelId]
    if not levelConfig then return end
    this.textTotalNum.text = 0
    local cacheCofig = ConfigMgr.Config.HackGameElementMap
    this.standCost = -cacheCofig["1003"].Score
    this.textStepsNum.text = LuaMgr.GetLangText("FSMYGameViewModel_9") .. this.standCost
    this.textAddNum.text = "+" .. cacheCofig["1004"].Score
    this.textMinusNum.text = cacheCofig["1005"].Score
    this.totalStep = levelConfig.Cost
    this.SetStepsTimes()
    this.ResetLevelData(levelConfig)
    this.RefreshReward(levelConfig)
    this.RefreshScore()
    local mapRows = this.GetLevelMapRows(levelId)
    this.rows = #mapRows
    this.cols = GridConfig.Cols

    local index = 0;
    for y = 1, this.rows do
        this.gridData[y] = {}
        local rowConfig = mapRows[y]
        for x = 1, this.cols do
            index = index + 1
            local cellData, elementConfig = this.CreateGridCellData(rowConfig, x, index)
            this.gridData[y][x] = cellData
            this.RefreshGridItem(index, x, y, elementConfig)
            this.TrySetStartCell(cellData, x, y)
        end
    end

    this.HideUnusedGridItems(index)
    this.RefreshLinePathGridItems()
    this.ShowDirection()
end

this.ResetLevelData = function(levelConfig)
    this.skipScore = levelConfig.SkipScore or 0
    this.baseScore = levelConfig.InitialScore or 0
    this.score = levelConfig.InitialScore or 0
    this.addTimes = 0
    this.addScore = 0
    this.minusScore = 0
    this.minusTimes = 0
    this.addStepScore = this.totalStep * this.standCost
    this.SwitchState(StateType.Playing)
    this.linePath = {}
    this.undoStack = {}
    this.gridData = {}
end

this.GetLevelMapRows = function(levelId)
    local mapRows = {}
    for _, mapData in pairs(ConfigMgr.Config.HackGameMap) do
        if mapData.LevelId == levelId then
            mapRows[mapData.Rows] = mapData
        end
    end
    return mapRows
end

this.CreateGridCellData = function(rowConfig, x, index)
    local elementId = rowConfig["Columns" .. x] .. ""
    local elementConfig = ConfigMgr.Config.HackGameElementMap[elementId]

    return {
        id = elementId,
        type = elementConfig.Type,
        score = elementConfig.Score or 0,
        indexNum = index,
        element = elementConfig.Element,
    }, elementConfig
end

this.CreateGridItemCache = function()
    local go = LuaMgr.InstantiateGO(this.gridItem, this.itemBox, false)
    local cache = {}
    cache.go = go
    cache.rect = go.transform:GetComponent("RectTransform")
    cache.anim = go.transform:GetComponent("Animator")
    cache.icon = go.transform:Find("gridImg"):GetComponent("Image");
    cache.effect = go.transform:Find("gridImg/vfx_jiafenge")
    SetActive(cache.effect.gameObject, false)
    cache.btn = go.transform:Find("gridImg"):GetComponent("Button");
    cache.btn.onClick:RemoveAllListeners()
    LuaMgr.AddClick(cache.btn, function()
        if cache.x and cache.y then
            this.OnGridClicked(cache.x, cache.y)
        end
    end)
    return cache
end

this.OnGridClicked = function(x, y)
    if this.state ~= StateType.Playing then return end

    if x == this.playerX and y == this.playerY then
        return
    end

    for i = 1, #this.linePath do
        if this.linePath[i].x == x and this.linePath[i].y == y then
            if i == #this.linePath - 1 then
                this.BackStep()
            else
                this.ShowTips(LuaMgr.GetLangText("FSMYGameViewModel_10"))
            end
            return
        end
    end

    local dist = math.abs(x - this.playerX) + math.abs(y - this.playerY)
    if dist == 1 then
        this.Move(x - this.playerX, this.playerY - y)
    else
        this.ShowTips(LuaMgr.GetLangText("FSMYGameViewModel_11"))
    end
end

this.GetGridItemCache = function(index)
    if (this.itemObjBox[index] == nil or this.itemObjBox[index].Obj == nil) then
        this.itemObjBox[index] = {}
        this.itemObjBox[index].Obj = this.CreateGridItemCache()
    end
    return this.itemObjBox[index].Obj
end

this.RefreshGridItem = function(index, x, y, elementConfig)
    local obj = this.GetGridItemCache(index)
    obj.x = x
    obj.y = y
    SetActive(obj.go, true)
    obj.go.name = "gridItem(" .. x .. "," .. y .. ")"
    obj.rect.anchoredPosition = this.getAnchoPos(x, y)
    if (elementConfig.Type == 4) then
        obj.anim.enabled = true
        obj.anim:Rebind();
        obj.anim:Play("ani_FSMYGamePanel_gridItem_jiafenge");
    else
        obj.anim.enabled = true
        obj.anim:Rebind();
        obj.anim.enabled = false
        SetActive(obj.effect.gameObject, false)
    end
    this.SetGridItemSprite(obj, elementConfig.Element, 0)
    obj.rect:SetAsFirstSibling()
end

this.SetGridItemSprite = function(obj, spriteName, angle)
    obj.icon.sprite = LuaMgr.GetSprite(GridConfig.Atlas, spriteName);
    obj.icon.transform.localEulerAngles = Vector3(0, 0, angle or 0)
end

this.GetPlayerItemCache = function()
    if (this.playItem == nil) then
        this.playItem = this.CreateGridItemCache()
        this.gridItemDirection:SetParent(this.playItem.go.transform, false)
        this.gridItemDirection.localPosition = Vector3.zero
        table.insert(this.directionList, this.gridDown)
        table.insert(this.directionList, this.gridUp)
        table.insert(this.directionList, this.gridRight)
        table.insert(this.directionList, this.gridLeft)
    end
    return this.playItem
end

this.TrySetStartCell = function(cellData, x, y)
    if cellData.type ~= ElementType.Start then return end

    this.playerX = x
    this.playerY = y
    this.UpdatePlayerPosition()

    local playItem = this.GetPlayerItemCache()
    playItem.anim.enabled = true
    playItem.anim:Rebind();
    playItem.anim:Play("ani_FSMYGamePanel_gridItem_wanjiage");
    this.SetGridItemSprite(playItem, GridConfig.PlayerSprite, 0)
    playItem.rect:SetAsLastSibling()
    table.insert(this.linePath, { x = x, y = y })
end

this.HideUnusedGridItems = function(usedCount)
    local cacheCount = #this.itemObjBox
    if (usedCount >= cacheCount) then return end

    for i = usedCount + 1, cacheCount do
        if this.itemObjBox[i] and this.itemObjBox[i].Obj then
            SetActive(this.itemObjBox[i].Obj.go, false)
        end
    end
end

this.getAnchoPos = function(x, y)
    return this.mapOffset + Vector2((x - 1) * GridConfig.CellSize, -(y - 1) * GridConfig.CellSize)
end

this.UpdatePlayerPosition = function()
    local playItem = this.GetPlayerItemCache()
    playItem.rect.anchoredPosition = this.getAnchoPos(this.playerX, this.playerY)
end

this.RefreshLinePathGridItems = function(newPathIndex)
    for y = 1, this.rows do
        for x = 1, this.cols do
            local cell = this.GetCell(x, y)
            if cell ~= nil then
                local obj = this.GetGridItemCache(cell.indexNum)
                this.SetGridItemSprite(obj, cell.element, 0)
            end
        end
    end

    for i = 2, #this.linePath - 1 do
        local pathData = this.GetPathSpriteData(i)
        if pathData ~= nil then
            local point = this.linePath[i]
            local cell = this.GetCell(point.x, point.y)
            if cell ~= nil then
                local obj = this.GetGridItemCache(cell.indexNum)
                this.SetGridItemSprite(obj, pathData.sprite, pathData.angle)

                if newPathIndex ~= nil and i == newPathIndex - 1 then
                    obj.anim.enabled = true
                    obj.anim:Rebind()
                    obj.anim:Play("ani_FSMYGamePanel_gridItem_yidongge")
                end
            end
        end
    end
end

this.GetPathSpriteData = function(pathIndex)
    local cur = this.linePath[pathIndex]
    if cur == nil then return nil end

    local prev = this.linePath[pathIndex - 1]
    local next = this.linePath[pathIndex + 1]
    if prev == nil and next == nil then return nil end

    local dir1 = nil
    local dir2 = nil
    if prev ~= nil then
        dir1 = this.GetPathDir(cur, prev)
    end
    if next ~= nil then
        dir2 = this.GetPathDir(cur, next)
    end

    if dir1 ~= nil and dir2 ~= nil then
        if this.IsStraightPath(dir1, dir2) then
            return {
                sprite = GridConfig.PathStraightSprite,
                angle = this.GetStraightPathAngle(dir1),
            }
        end

        return {
            sprite = GridConfig.PathCornerSprite,
            angle = this.GetCornerPathAngle(dir1, dir2),
        }
    end

    local dir = dir1 or dir2
    return {
        sprite = GridConfig.PathStraightSprite,
        angle = this.GetStraightPathAngle(dir),
    }
end

this.GetPathDir = function(from, to)
    return {
        x = to.x - from.x,
        y = to.y - from.y,
    }
end

this.IsStraightPath = function(dir1, dir2)
    return (dir1.x ~= 0 and dir2.x ~= 0) or (dir1.y ~= 0 and dir2.y ~= 0)
end

this.GetStraightPathAngle = function(dir)
    if dir.x ~= 0 then
        return 0
    end
    return 90
end

this.HasPathDirs = function(dir1, dir2, x1, y1, x2, y2)
    return (dir1.x == x1 and dir1.y == y1 and dir2.x == x2 and dir2.y == y2)
        or (dir1.x == x2 and dir1.y == y2 and dir2.x == x1 and dir2.y == y1)
end

this.GetCornerPathAngle = function(dir1, dir2)
    if this.HasPathDirs(dir1, dir2, -1, 0, 0, 1) then
        return 0
    elseif this.HasPathDirs(dir1, dir2, 0, 1, 1, 0) then
        return 90
    elseif this.HasPathDirs(dir1, dir2, 1, 0, 0, -1) then
        return 180
    elseif this.HasPathDirs(dir1, dir2, 0, -1, -1, 0) then
        return 270
    end
    return 0
end

this.IsInBounds = function(x, y)
    return x >= 1 and x <= this.cols and y >= 1 and y <= this.rows
end

this.GetCell = function(x, y)
    if not this.IsInBounds(x, y) then return nil end
    return this.gridData[y][x]
end

this.IsVisited = function(x, y)
    for i = 1, #this.linePath do
        if this.linePath[i].x == x and this.linePath[i].y == y then
            return true
        end
    end
    return false
end

this.IsWalkableCell = function(x, y)
    local cell = this.GetCell(x, y)
    return cell ~= nil and cell.type ~= ElementType.Obstacle and not this.IsVisited(x, y)
end

this.CheckTrapped = function()
    for i = 1, #SearchDirs do
        local nx = this.playerX + SearchDirs[i].x
        local ny = this.playerY + SearchDirs[i].y
        if this.IsWalkableCell(nx, ny) then
            return false
        end
    end
    return true
end

this.ShowDirection = function()
    for i = 1, #SearchDirs do
        local nx = this.playerX + SearchDirs[i].x
        local ny = this.playerY + SearchDirs[i].y
        local bShow = false
        if this.IsWalkableCell(nx, ny) then
            bShow = true
        end
        SetActive(this.directionList[i], bShow)
    end
end

this.Move = function(dx, dy)
    if this.state ~= StateType.Playing then return false, MoveResult.GameOver end

    local nx = this.playerX + dx
    local ny = this.playerY - dy
    local canMove, message, targetCell = this.ValidateMoveTarget(nx, ny)
    if not canMove then
        this.ShowTips(message)
        return false, message
    end

    this.PushUndoStep(nx, ny, targetCell)
    this.StepToCell(nx, ny)
    local finished, finishMessage = this.ApplyCellEffect(targetCell)
    if finished then
        return true, finishMessage
    end

    if this.CheckTrapped() then

        return true, MoveResult.Trapped
    end
    if (this.totalStep == 0) then
        this.SwitchState(StateType.Lost)
        return true, MoveResult.Lost
    end

    return true, MoveResult.Success
end

this.PushUndoStep = function(x, y, targetCell)
    this.totalStep = this.totalStep - 1
    this.SetStepsTimes()
    table.insert(this.undoStack, {
        playerX = this.playerX,
        playerY = this.playerY,
        score = this.score,
        state = this.state,
        pathLength = #this.linePath,
        targetX = x,
        targetY = y,
        targetType = targetCell.type,
        addStepScore = this.addStepScore,
        addScore = this.addScore,
        minusScore = this.minusScore,
        addTimes = this.addTimes,
        minusTimes = this.minusTimes,
        totalStep = this.totalStep,
    })
end

this.BackStep = function()
    if this.state ~= StateType.Playing then return false, MoveResult.GameOver end
    if #this.undoStack <= 0 then return false, MoveResult.NoUndo end

    local step = table.remove(this.undoStack)
    this.playerX = step.playerX
    this.playerY = step.playerY
    this.score = step.score
    this.state = step.state
    this.addStepScore = step.addStepScore
    this.addScore = step.addScore
    this.minusScore = step.minusScore
    this.addTimes = step.addTimes
    this.minusTimes = step.minusTimes
    this.totalStep = step.totalStep

    local targetCell = this.GetCell(step.targetX, step.targetY)
    if targetCell ~= nil then
        targetCell.type = step.targetType
    end

    while #this.linePath > step.pathLength do
        table.remove(this.linePath)
    end
    this.RefreshLinePathGridItems()
    this.UpdatePlayerPosition()
    this.totalStep = this.totalStep + 1
    this.SetStepsTimes()
    this.RefreshScore()
    this.ShowDirection()
    return true
end

this.SetStepsTimes = function()
    if (this.totalStep < 10) then
        this.textStepsTimesNum.text = "00" .. this.totalStep
    elseif (this.totalStep < 100 and this.totalStep >= 10) then
        this.textStepsTimesNum.text = "0" .. this.totalStep
    else
        this.textStepsTimesNum.text = this.totalStep
    end
end

this.ValidateMoveTarget = function(x, y)
    if not this.IsInBounds(x, y) then
        return false, MoveResult.OutOfBounds
    end

    local targetCell = this.GetCell(x, y)
    if targetCell.type == ElementType.Obstacle then
        return false, MoveResult.Obstacle
    end

    if this.IsVisited(x, y) then
        return false, MoveResult.Repeated
    end

    return true, nil, targetCell
end

this.ShowTips = function(message)
    this.textTips.text = message
    if this.coroutine ~= nil then
        coroutine_runner.stop(this.coroutine)
        this.coroutine = nil
    end
    this.coroutine = coroutine_runner.start(function()
        SetActive(this.imageTips, true);
        coroutine_runner.wait(1.5)
        SetActive(this.imageTips, false);
    end)
end

this.StepToCell = function(x, y)
    this.playerX = x
    this.playerY = y
    table.insert(this.linePath, { x = x, y = y })
    this.RefreshLinePathGridItems(#this.linePath)
    this.UpdatePlayerPosition()
    this.ShowDirection()
end

this.ApplyCellEffect = function(targetCell)
    this.score = this.score - this.standCost
    this.addStepScore = this.addStepScore - this.standCost
    local type = nil
    local bState = false
    if targetCell.type == ElementType.ScoreUp then
        this.score = this.score + targetCell.score
        this.addScore = this.addScore + targetCell.score
        this.addTimes = this.addTimes + 1
    elseif targetCell.type == ElementType.ScoreDown then
        this.score = this.score + targetCell.score
        this.minusScore = this.minusScore + targetCell.score
        this.minusTimes = this.minusTimes + 1
    elseif targetCell.type == ElementType.Trap then
        this.SwitchState(StateType.Lost)
        bState = true
        type = MoveResult.Trap
    elseif targetCell.type == ElementType.End then
        this.SwitchState(StateType.Won)
        type = MoveResult.Win
    end
    this.RefreshScore()
    return bState, type
end

this.SwitchState = function(state)
    if this.state == state then return end
    this.state = state
    if this.state == StateType.Lost then
        LuaMgr.ShowLuaPanel(UIName.FSMYGamePauseViewModel, PauseType.Lost)
    elseif this.state == StateType.Won then
        ApiMgr.Request("hackGame/settlement", { Id = this.eventConfig.eventParam, Score = this.score }, true,
            function(result)
                local dataBox = {}
                dataBox.baseScore = this.score
                dataBox.addScore = this.addScore
                dataBox.addTimes = this.addTimes
                dataBox.minusScore = this.minusScore
                dataBox.minusTimes = this.minusTimes
                dataBox.addStepScore = this.addStepScore
                dataBox.totalStep = this.totalStep
                dataBox.isFinish = this.isFinish
                LuaMgr.ShowLuaPanel(UIName.FSMYGameResultViewModel, this.eventConfig, dataBox)
            end, nil, true, true);
    end
end

this.InitStar = function()
    for i = 1, this.healthBg.childCount do
        local star = this.healthBg:GetChild(i - 1)
        local numText = star.transform:GetChild(1):GetComponent("Text")
        local star1 = star.transform:GetChild(3)
        local star1Effect = star.transform:GetChild(4)
        local num2Text = star1.transform:GetChild(1):GetComponent("Text")
        this.stars[i] = {
            numText = numText,
            num2Text = num2Text,
            star = star,
            star1 = star1,
            star1Effect = star1Effect,
        }
    end
end

this.RefreshScore = function()
    this.textTotalNum.text = this.score
    this.textAddTimesNum.text = "x" .. this.addTimes
    this.textMinusTimesNum.text = "x" .. this.minusTimes
    local levelConfig = ConfigMgr.Config.HackGameLevelMap[this.levelId]
    if not levelConfig then return end
    if (this.isInitStar) then
        for i = 1, #this.stars do
            local star = this.stars[i]
            SetActive(star.star.gameObject, false)
        end
    end
    for i, v in ipairs(levelConfig.Conditions) do
        local star = this.stars[i]
        if (this.isInitStar) then
            SetActive(star.star.gameObject, true)
            star.numText.text = v
            star.num2Text.text = v
        end
        if (v <= this.score) then
            if (not star.star1.gameObject.activeSelf) then
                SetActive(star.star1Effect.gameObject, true)
            end
            SetActive(star.star1.gameObject, true)
        else
            SetActive(star.star1.gameObject, false)
            SetActive(star.star1Effect.gameObject, false)
        end
    end
    this.isInitStar = false
end

this.RefreshReward = function(levelConfig)
    if (this.rewardItems ~= nil) then
        for k, v in pairs(this.rewardItems) do
            v.rewardObj:Hide();
            SetActive(v.go, false)
        end
    end
    this.isFinish = FSMYMgr.CheckEventIsComplete(this.eventConfig)
    if (levelConfig.Reward and #levelConfig.Reward > 0) then
        for i, v in ipairs(levelConfig.Reward) do
            if (this.rewardItems == nil) then
                this.rewardItems = {}
            end
            if (this.rewardItems[i] == nil) then
                local go = GameObject.Instantiate(this.rewardItem)
                local cache = {}
                cache.go = go
                cache.box = go.transform:Find("reward"):GetComponent("Transform");
                cache.get = go.transform:Find("get").gameObject;
                cache.first = go.transform:Find("first").gameObject;
                cache.rewardObj = GoodsDataItem.New(cache.box);
                this.rewardItems[i] = cache
            end
            local obj = this.rewardItems[i]
            obj.go.transform:SetParent(this.rectContent, false);
            local itemData = table.Copy(ConfigMgr.Config.itemMap[v.id]);
            itemData.count0 = v.count;
            obj.rewardObj:SetData(1, itemData, 1, false, Vector3(0.6, 0.6, 0.6), false, false);

            SetActive(obj.get, this.isFinish)
            SetActive(obj.first, false)
            SetActive(obj.go, true)
        end
    end
end

this.RegisterMoveButtons = function()
    LuaMgr.AddClick(this.btnRight, this.OnClickRight);
    LuaMgr.AddClick(this.btnLeft, this.OnClickLeft);
    LuaMgr.AddClick(this.btnUp, this.OnClickUp);
    LuaMgr.AddClick(this.btnDown, this.OnClickDown);
end

this.RemoveMoveButtons = function()
    LuaMgr.RemoveClick(this.btnRight, this.OnClickRight);
    LuaMgr.RemoveClick(this.btnLeft, this.OnClickLeft);
    LuaMgr.RemoveClick(this.btnUp, this.OnClickUp);
    LuaMgr.RemoveClick(this.btnDown, this.OnClickDown);
end

this.RegisterGameEvents = function()
    LuaMgr.AddUIEventListener(UIEventConst.FSMYPlayGame, this.PlayGame);
    LuaMgr.AddUIEventListener(UIEventConst.FSMYGameRestart, this.ResetGame);
    LuaMgr.AddUIEventListener(UIEventConst.FSMYGameSkip, this.SkipGame);
end

this.RemoveGameEvents = function()
    LuaMgr.RemoveUIEventListener(UIEventConst.FSMYPlayGame, this.PlayGame);
    LuaMgr.RemoveUIEventListener(UIEventConst.FSMYGameRestart, this.ResetGame);
    LuaMgr.RemoveUIEventListener(UIEventConst.FSMYGameSkip, this.SkipGame);
end

local data = {
}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.InitStar();
        LuaMgr.AddClick(this.btnSkip, this.OnClickSkip);
        LuaMgr.AddClick(this.btnReset, this.OnClickReset);
        LuaMgr.AddClick(this.btnBack, this.OnClickBack);
        this.RegisterMoveButtons()
        RedMgr.Singleton:RegisterViewModel(UIName.FSMYGameViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.RegisterGameEvents()
        if vm.behaviour.Params.Length > 0 then
            this.PlayGame(vm.behaviour.Params)
        end






        RedMgr.Singleton:Refresh()
        vm.behaviour:UpdateTopBar("", this.OnBack);
    end,
    before_deactive = function(vm)
        this.Clear()
        this.RemoveGameEvents()
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.btnSkip, this.OnClickSkip);
        LuaMgr.RemoveClick(this.btnReset, this.OnClickReset);
        LuaMgr.RemoveClick(this.btnBack, this.OnClickBack);
        this.RemoveMoveButtons()
        RedMgr.Singleton:RemoveViewModel(UIName.FSMYGameViewModel);
        this.Destroy()
    end
}



return vm({ data = data, command = command, hook = hook })