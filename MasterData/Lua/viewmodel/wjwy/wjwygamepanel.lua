







local StateType = {
    Playing = 1,
    Lost    = 2,
    Won     = 3,
}

local PauseType = {
    Reset = 1,
    Skip  = 2,
    Back  = 3,
    Lost  = 4,
}

local this = {
    levelId      = "",
    state        = StateType.Playing,
    eventConfig  = nil,
    rewardItems  = {},
    textItems    = {},
    coroutine    = nil,
    tipsTimer    = nil,
    startDelay   = nil,
    isFinish     = false,


    boardSizeX   = 11,
    boardSizeY   = 11,
    startPos     = { x = 5, y = 5 },
    personPos    = { x = 5, y = 5 },
    obstacles    = {},
    history      = {},
    turnCount    = 0,
    placedCount  = 0,
    gridItems    = {},
    targetTween  = nil,
    curClickGrid = nil,
    oldState     = "",
    isSkip       = false,
}

local objs = {
    animtor     = { path = "root", type = UITool.Animator },
    gridItem    = { path = "template/gridItem", type = UITool.GameObject },
    textItem    = { path = "template/textItem", type = UITool.GameObject },
    rewardItem  = { path = "template/RewardItem", type = UITool.GameObject },
    itemBox     = { path = "root/Middle/ItemBox", type = UITool.RectTransform },
    btnBack     = { path = "root/Right/BtnBack", type = UITool.Button },
    btnReset    = { path = "root/Right/BtnReset", type = UITool.Button },
    btnSkip     = { path = "root/Right/BtnSkip", type = UITool.Button },
    posText     = { path = "root/Right/rewardBg/posText", type = UITool.Text },
    rectContent = { path = "root/Right/reward/tranLevelList/Viewport/Content/rectContent", type = UITool.Transform },
    textContent = { path = "root/Right/Bg/TextScrollView/Viewport/Content", type = UITool.Transform },
    imageTips   = { path = "root/ImageTips", type = UITool.GameObject },
    textTips    = { path = "root/ImageTips/TextTips", type = UITool.Text },
    targetItem  = { path = "root/Middle/targetBox/targetItem", type = UITool.RectTransform },
    spineBody   = { path = "root/Middle/targetBox/targetItem/gridImg", type = UITool.UISpineCharacter },





}









local function GetKey(x, y)
    return x .. "_" .. y
end







local function IsBoundary(x, y, sizeX, sizeY)
    return x == 0 or x == sizeX - 1 or y == 0 or y == sizeY - 1
end







local function GetNeighbors(x, y, sizeX, sizeY)
    local nbrs = {}
    local isEven = (y % 2 == 0)
    local ds = isEven and {
        { 1, 0 }, { -1, 0 }, { -1, -1 }, { 0, -1 }, { -1, 1 }, { 0, 1 }
    } or {
        { 1, 0 }, { -1, 0 }, { 0, -1 }, { 1, -1 }, { 0, 1 }, { 1, 1 }
    }

    for _, d in ipairs(ds) do
        local nx = x + d[1]
        local ny = y + d[2]
        if nx >= 0 and nx < sizeX and ny >= 0 and ny < sizeY then
            table.insert(nbrs, { x = nx, y = ny })
        end
    end
    return nbrs
end






local function BuildDistances(obstacles, sizeX, sizeY)
    local dist = {}
    local queue = {}


    for x = 0, sizeX - 1 do
        for y = 0, sizeY - 1 do
            local k = GetKey(x, y)
            if IsBoundary(x, y, sizeX, sizeY) and not obstacles[k] then
                dist[k] = 0
                table.insert(queue, { x = x, y = y })
            end
        end
    end

    local head = 1
    while head <= #queue do
        local p = queue[head]
        head = head + 1
        local k = GetKey(p.x, p.y)
        local d = dist[k]

        local nbrs = GetNeighbors(p.x, p.y, sizeX, sizeY)
        for _, n in ipairs(nbrs) do
            local nk = GetKey(n.x, n.y)
            if not obstacles[nk] and dist[nk] == nil then
                dist[nk] = d + 1
                table.insert(queue, n)
            end
        end
    end
    return dist
end








local function ReachableArea(startX, startY, obstacles, sizeX, sizeY)
    local startKey = GetKey(startX, startY)
    local seen = { [startKey] = true }
    local queue = { { x = startX, y = startY } }
    local count = 0

    local head = 1
    while head <= #queue do
        local p = queue[head]
        head = head + 1
        count = count + 1

        local nbrs = GetNeighbors(p.x, p.y, sizeX, sizeY)
        for _, n in ipairs(nbrs) do
            local nk = GetKey(n.x, n.y)
            if not obstacles[nk] and not seen[nk] then
                seen[nk] = true
                table.insert(queue, n)
            end
        end
    end
    return count
end









local function ChooseMove(posX, posY, obstacles, sizeX, sizeY)
    local distMap = BuildDistances(obstacles, sizeX, sizeY)
    local curDist = distMap[GetKey(posX, posY)]
    if curDist == nil then
        return nil
    end

    local nbrs = GetNeighbors(posX, posY, sizeX, sizeY)
    local candidates = {}
    for _, n in ipairs(nbrs) do
        local nk = GetKey(n.x, n.y)
        if not obstacles[nk] and distMap[nk] ~= nil then
            table.insert(candidates, n)
        end
    end

    if #candidates == 0 then
        return nil
    end

    table.sort(candidates, function(a, b)
        local da = distMap[GetKey(a.x, a.y)] or 9999
        local db = distMap[GetKey(b.x, b.y)] or 9999
        if da ~= db then
            return da < db
        end
        local areaA = ReachableArea(a.x, a.y, obstacles, sizeX, sizeY)
        local areaB = ReachableArea(b.x, b.y, obstacles, sizeX, sizeY)
        if areaA ~= areaB then
            return areaA > areaB
        end
        return (a.y * sizeX + a.x) < (b.y * sizeX + b.x)
    end)

    return candidates[1]
end




local function ParseObstacles(obstacleData)
    local obstacles = {}
    for _, v in ipairs(obstacleData) do
        if type(v) == "table" and #v >= 3 then
            obstacles[GetKey(v[1], v[2])] = v[3]
        end
    end
    return obstacles
end




local function ParseRewardList(rewardData)
    local list = {}
    if type(rewardData) == "table" then
        return rewardData
    elseif type(rewardData) == "string" then
        for itemId, count in rewardData:gmatch("%[(%d+);(%d+)%]") do
            table.insert(list, { id = tonumber(itemId), count = tonumber(count) })
        end
    end
    return list
end







this.ShowTips = function(msg)
    if this.textTips then
        this.textTips.text = msg
    end
    if this.imageTips then
        SetActive(this.imageTips, true)
        if this.tipsTimer ~= nil then
            coroutine_runner.stop(this.tipsTimer)
            this.tipsTimer = nil
        end
        this.tipsTimer = coroutine_runner.start(function()
            coroutine_runner.wait(1.8)
            if this.imageTips then
                SetActive(this.imageTips, false)
            end
        end)
    end
end



this.CreateGridItemCache = function()
    local go = LuaMgr.InstantiateGO(this.gridItem, this.itemBox, false)
    local gridImg = go.transform:Find("gridImg"):GetComponent("Image")
    local btn = gridImg and gridImg.transform:GetComponent("Button") or go:GetComponent("Button")

    local cache = {
        go      = go,
        anim    = go:GetComponent("Animator"),
        rect    = go:GetComponent("RectTransform"),
        btn     = btn,
        gridImg = gridImg,
    }

    if cache.btn then
        if cache.btn.onClick then
            cache.btn.onClick:RemoveAllListeners()
        end
        LuaMgr.AddClick(cache.btn, function()
            if cache.x and cache.y then
                this.OnClickGridCell(cache.x, cache.y)
            end
        end)
    end
    return cache
end





this.GetGridItemCache = function(x, y)
    local k = GetKey(x, y)
    local item = this.gridItems[k]
    if not item or IsNull(item.go) then
        item = this.CreateGridItemCache()
        this.gridItems[k] = item
    end
    item.x = x
    item.y = y
    item.go.name = x .. "-" .. y
    return item
end


this.HideUnusedGridItems = function()
    for _, item in pairs(this.gridItems) do
        if item and item.x and item.y then
            if item.x >= this.boardSizeX or item.y >= this.boardSizeY then
                if item.go then
                    SetActive(item.go, false)
                end
            end
        end
    end
end





this.GetCellPosition = function(x, y)
    local cellWidth = 50
    local rowHeight = 45
    local rowOffset = 25


    local sizeX = this.boardSizeX or 11
    local sizeY = this.boardSizeY or 11
    local startX = -((sizeX - 1) * cellWidth + rowOffset) / 2
    local startY = ((sizeY - 1) * rowHeight) / 2


    local offsetX = (y % 2) * rowOffset
    local posX = startX + x * cellWidth + offsetX
    local posY = startY - y * rowHeight
    return Vector2(posX, posY)
end


this.InitBoardUI = function()
    if not this.itemBox or not this.gridItem then return end


    this.HideUnusedGridItems()


    for y = 0, this.boardSizeY - 1 do
        for x = 0, this.boardSizeX - 1 do
            local item = this.GetGridItemCache(x, y)

            if item.rect then
                item.rect.anchoredPosition = this.GetCellPosition(x, y)
            end

            if item.go then
                SetActive(item.go, true)
            end
        end
    end
end


this.RefreshBoardUI = function()
    for y = 0, this.boardSizeY - 1 do
        for x = 0, this.boardSizeX - 1 do
            local k = GetKey(x, y)
            local item = this.gridItems[k]
            if item then
                local isObstacle = (this.obstacles[k] ~= nil)
                if (isObstacle) then
                    item.gridImg.sprite = LuaMgr.GetSprite("WJWY", "ui_hd_tymt_xyx_gz_za");
                    if (this.curClickGrid == k) then
                        item.rect:SetSiblingIndex(-1)
                        item.anim:Rebind()
                        item.anim:Play("ani_WJWYGamePanel_gridItem_02")
                        this.curClickGrid = nil;
                    end
                else
                    item.gridImg.sprite = LuaMgr.GetSprite("WJWY", "ui_hd_tymt_xyx_gz_d");
                end
            end
        end
    end























end



this.RefreshReward = function(levelConfig)
    if this.rewardItems ~= nil then
        for _, v in pairs(this.rewardItems) do
            if v and v.rewardObj then
                v.rewardObj:Hide()
            end
            if v and v.go then
                SetActive(v.go, false)
            end
        end
    end

    this.isFinish = WJWYData.CheckFinish(this.eventConfig)

    local rewards = ParseRewardList(levelConfig.reward or levelConfig.Reward)
    if #rewards > 0 then
        for i, v in ipairs(rewards) do
            if this.rewardItems == nil then
                this.rewardItems = {}
            end
            if this.rewardItems[i] == nil then
                local go            = LuaMgr.InstantiateGO(this.rewardItem, this.rectContent, false)
                local cache         = {}
                cache.go            = go
                cache.box           = go.transform:Find("reward"):GetComponent("Transform")
                cache.get           = go.transform:Find("get").gameObject
                cache.first         = go.transform:Find("first").gameObject
                cache.rewardObj     = GoodsDataItem.New(cache.box)
                this.rewardItems[i] = cache
            else
                this.rewardItems[i].go.transform:SetParent(this.rectContent, false)
            end
            local obj = this.rewardItems[i]

            local itemMap = ConfigMgr.Config.itemMap or {}
            local itemData = table.Copy(itemMap[v.id] or { id = v.id, name = LuaMgr.GetLangText("WJWYGamePanel_0") .. v.id })
            itemData.count0 = v.count or v.count0

            obj.rewardObj:SetData(1, itemData, 1, false, Vector3(0.6, 0.6, 0.6), false, false)
            SetActive(obj.get, this.isFinish)
            SetActive(obj.first, false)
            SetActive(obj.go, true)
        end
    end
end



this.RefreshTextContent = function()
    if this.textItems ~= nil then
        for _, v in pairs(this.textItems) do
            if v and v.go then
                SetActive(v.go, false)
            end
        end
    end
    if not this.textItem or not this.textContent then return end
    local textList = { "LangGlobalLan_LangGlobal_name_33201", "LangGlobalLan_LangGlobal_name_33202",
        "LangGlobalLan_LangGlobal_name_33203" }

    if #textList > 0 then
        for i, v in ipairs(textList) do
            if this.textItems == nil then
                this.textItems = {}
            end
            if this.textItems[i] == nil then
                local go           = LuaMgr.InstantiateGO(this.textItem, this.textContent, false)
                local cache        = {}
                cache.go           = go
                cache.transform    = go.transform
                local contentTrans = go.transform:Find("TextContent")
                if contentTrans then
                    cache.textContent = contentTrans:GetComponent("Text")
                    cache.textGo      = contentTrans.gameObject
                end
                this.textItems[i] = cache
            else
                this.textItems[i].go.transform:SetParent(this.textContent, false)
            end
            local obj = this.textItems[i]

            if obj.textContent then
                obj.textContent.text = LuaMgr.GetLangText(v)
            end
            SetActive(obj.go, true)
        end
    end
end







this.LoadLevel = function(levelId)
    this.levelId      = tostring(levelId)
    this.state        = StateType.Playing
    this.history      = {}
    this.turnCount    = 0
    this.curClickGrid = nil

    local constConfig = ConfigMgr.Config.SurroundGameConstants or {}
    if constConfig.BoardSize and type(constConfig.BoardSize) == "table" then
        this.boardSizeX = constConfig.BoardSize[1] or 11
        this.boardSizeY = constConfig.BoardSize[2] or 11
    else
        this.boardSizeX, this.boardSizeY = 11, 11
    end

    if constConfig.StartPoint and type(constConfig.StartPoint) == "table" then
        this.startPos = { x = constConfig.StartPoint[1] or 5, y = constConfig.StartPoint[2] or 5 }
    else
        this.startPos = { x = 5, y = 5 }
    end
    this.personPos = { x = this.startPos.x, y = this.startPos.y }
    this.RefreshTargetItem(this.personPos, true)


    local levelMap = ConfigMgr.Config.SurroundGameLevelMap or {}
    local levelConfig = levelMap[this.levelId]


    local gameMapConfig = ConfigMgr.Config.SurroundGameMaps or {}
    local mapData = gameMapConfig[this.levelId]
    this.obstacles = ParseObstacles(mapData.Obstacle)

    local initObstacleCount = 0
    for _ in pairs(this.obstacles) do
        initObstacleCount = initObstacleCount + 1
    end
    this.placedCount = initObstacleCount
    this.isFinish = WJWYData.CheckFinish(this.eventConfig)
    SetActive(this.posText.gameObject, true)
    if (not this.isFinish) then
        this.posText.text = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_33204"), levelConfig.Score)
    else
        this.posText.text = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_33212"), levelConfig.Score)
    end


    this.InitBoardUI()
    this.RefreshBoardUI()
end



this.PlayGame = function(args)
    if type(args) == "table" and args.eventParam then
        this.eventConfig = args
    elseif args then
        this.eventConfig = args[0] or args[1] or args
    end

    if not this.eventConfig or not this.eventConfig.eventParam then
        return
    end
    this.animtor.enabled = false
    this.animtor.enabled = true
    this.animtor:Rebind()
    this.LoadLevel(this.eventConfig.eventParam)

    if this.startDelay ~= nil then
        coroutine_runner.stop(this.startDelay)
        this.startDelay = nil
    end

    this.startDelay = coroutine_runner.start(function()
        local levelMap = ConfigMgr.Config.SurroundGameLevelMap or {}
        local levelConfig = levelMap[tostring(this.eventConfig.eventParam)] or {}
        local skipTime = levelConfig.SkipTime
        if this.btnSkip then
            SetActive(this.btnSkip.gameObject, false)
        end
        coroutine_runner.wait(skipTime)
        if this.btnSkip then
            SetActive(this.btnSkip.gameObject, true)
        end
    end)
end


this.ResetGame = function()
    if this.eventConfig and this.eventConfig.eventParam then
        this.LoadLevel(this.eventConfig.eventParam)
    end
end




this.OnClickGridCell = function(x, y)
    if this.state ~= StateType.Playing then
        return
    end

    local k = GetKey(x, y)

    if this.obstacles[k] ~= nil then
        this.ShowTips(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_33210"))
        return
    end

    if x == this.personPos.x and y == this.personPos.y then
        this.ShowTips(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_33210"))
        return
    end


    table.insert(this.history, {
        personPos = { x = this.personPos.x, y = this.personPos.y },
        obstacles = table.Copy(this.obstacles),
        turnCount = this.turnCount,
    })


    this.obstacles[k] = -1
    this.turnCount = this.turnCount + 1
    this.curClickGrid = k

    local nextPos = ChooseMove(this.personPos.x, this.personPos.y, this.obstacles, this.boardSizeX, this.boardSizeY)

    if not nextPos then

        this.RefreshBoardUI()
        this.isSkip = false
        this.SwitchState(StateType.Won)

        return
    end


    this.personPos = nextPos
    this.RefreshTargetItem(nextPos)


    if IsBoundary(this.personPos.x, this.personPos.y, this.boardSizeX, this.boardSizeY) then
        this.RefreshBoardUI()
        this.SwitchState(StateType.Lost)
        this.ShowTips(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_33206"))
        return
    end

    this.RefreshBoardUI()
end

this.SetSpine = function()
    local skinId = "ED90901"
    this.spineBody:SetBattle(skinId, skinId, "-1", 0, function()
        this.spineBody:Play("idle", true, nil);
    end)
end




this.RefreshTargetItem = function(pos, isImmediate)
    if not this.targetItem or not pos or pos.x == nil or pos.y == nil then
        return
    end

    if this.targetTween ~= nil then
        this.targetTween:Kill()
        this.targetTween = nil
    end

    local targetPos = this.GetCellPosition(pos.x, pos.y)
    if isImmediate then
        this.targetItem.anchoredPosition = targetPos
    else
        local curPos = this.targetItem.anchoredPosition
        local diffX = targetPos.x - curPos.x
        local diffY = targetPos.y - curPos.y
        if (diffX > 0) then
            this.targetItem.localScale = Vector3(-1, 1, 1)
        else
            this.targetItem.localScale = Vector3(1, 1, 1)
        end
        if (diffY > 0) then
            this.SwichBodyState("run_b")
        else
            this.SwichBodyState("run")
        end

        this.targetTween = DOTWeen.To(
            function() return this.targetItem.anchoredPosition end,
            function(value) this.targetItem.anchoredPosition = value end,
            targetPos,
            0.8
        ):SetEase(Ease.OutSine)
        this.targetTween.onComplete = function()
            this.SwichBodyState("idle")
            this.targetTween = nil
        end
    end
end

this.SwichBodyState = function(runType)
    if (this.oldState == runType) then
        return
    end
    this.oldState = runType;
    this.spineBody:Play(runType, true, nil);
end



this.BackStep = function()
    if #this.history == 0 or this.state ~= StateType.Playing then
        this.ShowTips(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_33211"))
        return false
    end

    local snapshot = table.remove(this.history)
    this.personPos = snapshot.personPos
    this.obstacles = snapshot.obstacles
    this.turnCount = snapshot.turnCount
    this.RefreshTargetItem(snapshot.personPos, true)
    this.RefreshBoardUI()

    return true
end


this.SkipGame = function()
    this.isSkip = true
    this.SwitchState(StateType.Won)
end



this.SwitchState = function(state)
    this.state = state
    this.RefreshBoardUI()
    if state == StateType.Won then
        ApiMgr.Request("surroundGame/finish", { LevelId = this.eventConfig.eventParam, Jump = (this.isSkip and 2 or 1) },
            true,
            function(result)
                local dataBox = {}
                dataBox.isFinish = this.isFinish
                LuaMgr.ShowLuaPanel(UIName.WJWYGameResultPanel, this.eventConfig, dataBox)
            end, nil, true, true);
    elseif state == StateType.Lost then

        LuaMgr.ShowLuaPanel(UIName.WJWYGamePausePanel, PauseType.Lost)
    end
end





this.OnBack = function()
    LuaMgr.ShowLuaPanel(UIName.WJWYGamePausePanel, PauseType.Back)
end

this.OnClickSkip = function()
    LuaMgr.ShowLuaPanel(UIName.WJWYGamePausePanel, PauseType.Skip)
end

this.OnClickReset = function()
    LuaMgr.ShowLuaPanel(UIName.WJWYGamePausePanel, PauseType.Reset)
end

this.OnClickBack = function(...)
    return this.BackStep()
end

this.RegisterGameEvents = function()
    LuaMgr.AddUIEventListener(UIEventConst.FSMYPlayGame, this.PlayGame)
    LuaMgr.AddUIEventListener(UIEventConst.FSMYGameRestart, this.ResetGame)
    LuaMgr.AddUIEventListener(UIEventConst.FSMYGameSkip, this.SkipGame)
end

this.RemoveGameEvents = function()
    LuaMgr.RemoveUIEventListener(UIEventConst.FSMYPlayGame, this.PlayGame)
    LuaMgr.RemoveUIEventListener(UIEventConst.FSMYGameRestart, this.ResetGame)
    LuaMgr.RemoveUIEventListener(UIEventConst.FSMYGameSkip, this.SkipGame)
end






this.Clear = function()
    if this.rewardItems ~= nil then
        for _, v in pairs(this.rewardItems) do
            if v and v.rewardObj then
                v.rewardObj:Hide()
            end
            if v and v.go then
                SetActive(v.go, false)
            end
        end
    end
    if this.textItems ~= nil then
        for _, v in pairs(this.textItems) do
            if v and v.go then
                SetActive(v.go, false)
            end
        end
    end
    if this.coroutine ~= nil then
        coroutine_runner.stop(this.coroutine)
        this.coroutine = nil
    end
    if this.startDelay ~= nil then
        coroutine_runner.stop(this.startDelay)
        this.startDelay = nil
    end
    if this.tipsTimer ~= nil then
        coroutine_runner.stop(this.tipsTimer)
        this.tipsTimer = nil
    end
    if this.targetTween ~= nil then
        this.targetTween:Kill()
        this.targetTween = nil
    end
end


this.Destroy = function()
    this.Clear()
    this.gridItems = {}
    this.history = {}
    this.targetTween = nil
end





local data = {}
local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.btnSkip, this.OnClickSkip)
        LuaMgr.AddClick(this.btnReset, this.OnClickReset)
        LuaMgr.AddClick(this.btnBack, this.OnClickBack)
        RedMgr.Singleton:RegisterViewModel(UIName.WJWYGameViewModel)
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then return end
        this.posText.text = ""
        SetActive(this.imageTips, false)
        this.RegisterGameEvents()
        this.SetSpine()
        if vm.behaviour.Params.Length > 0 then
            this.PlayGame(vm.behaviour.Params)
        end

        this.RefreshTextContent()
        RedMgr.Singleton:Refresh()
        vm.behaviour:UpdateTopBar("", this.OnBack)
    end,
    before_deactive = function(vm)
        this.Clear()
        this.RemoveGameEvents()
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.btnSkip, this.OnClickSkip)
        LuaMgr.RemoveClick(this.btnReset, this.OnClickReset)
        LuaMgr.RemoveClick(this.btnBack, this.OnClickBack)
        RedMgr.Singleton:RemoveViewModel(UIName.WJWYGameViewModel)
        this.Destroy()
        if this.spineBody ~= nil then
            this.spineBody:Clear();
        end
    end,
}

return vm({ data = data, command = command, hook = hook })