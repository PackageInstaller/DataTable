require("ViewModel/JSYZ/JSYZGameBomb")
require("ViewModel/JSYZ/JSYZGameConst")
require("ViewModel/JSYZ/JSYZGameAI")
require("ViewModel/JSYZ/JSYZGameDangerMap")
require("ViewModel/JSYZ/JSYZGamePathfinding")
require("ViewModel/JSYZ/JSYZGameEnemy")
require("ViewModel/JSYZ/JSYZGamePlayer")
require("ViewModel/JSYZ/JSYZGameUtils")
require("ViewModel/JSYZ/JSYZGameMapGenerator")
require("ViewModel/JSYZ/JSYZGameMgr")

local this = {
    inRunState = false,
    cellPool = nil,
    entityPools = {},
    explosionPool = nil,
    powerupPools = {},
    entityViews = {},
    cellViews = {},
    powerupViews = {},

    vigilanceViews = {},
    destroyQueue = {},
    cameraConfig = {
smoothSpeed = 0.15,
screenSafeZone = 200,
minMoveThreshold = 0.5,
joystickDeadZone = 15
    },
    cellDelay = {},
    powerupDelay = {},
    touchDelayFram = 0,
    eventConfig = nil,
    mapId = nil,
    dragFingerId = nil,
};

local objs = {
    gridItem = { path = "template/GridItem", type = "GameObject" },
    boomItem = { path = "template/BoomItem", type = "GameObject" },
    explosionItem = { path = "template/ExplosionItem", type = "GameObject" },
    powerItem = { path = "template/PowerItem", type = "GameObject" },
    enemyItem = { path = "template/EnemyItem", type = "GameObject" },
    vigilanceItem = { path = "template/VigilanceItem", type = "GameObject" },
    charaPos = { path = "root/SVChapter/Viewport/tranContent/charaPos", type = "RectTransform" },
    spineBody = { path = "root/SVChapter/Viewport/tranContent/charaPos/Body", type = "UISpineCharacter" },
    effBody = { path = "root/SVChapter/Viewport/tranContent/charaPos/vfx_body", type = "GameObject" },
    tranContent = { path = "root/SVChapter/Viewport/tranContent", type = "RectTransform" },
    tranCity = { path = "root/SVChapter/Viewport/tranContent/tranCity", type = "RawImage" },
    touchEvent = { path = "root/Touch", type = "EventTriggerListener" },
    touchGroup = { path = "root/Touch/Group", type = "GameObject" },
    touchTarget = { path = "root/Touch/Group/target", type = "Transform" },
    touchLeft = { path = "root/Touch/Group/Left", type = "GameObject" },
    touchRight = { path = "root/Touch/Group/Right", type = "GameObject" },
    touchUp = { path = "root/Touch/Group/Up", type = "GameObject" },
    touchDown = { path = "root/Touch/Group/Down", type = "GameObject" },
    btnBome = { path = "root/Right/BtnBome", type = "Button" },
    textRatio = { path = "root/Right/BtnBome/TextRatio", type = "Text" },
    btnQuickBome = { path = "root/Right/BtnBome/BtnQuickBome", type = "Button" },
    pauseBtn = { path = "root/Right/BtnStop", type = "Button" },
    btnSkip = { path = "root/Right/BtnSkip", type = "Button" },
    textTitle = { path = "root/Left/TitleBg/TextTitle", type = "Text" },
    textMonster = { path = "root/Left/TitleBg/MonsterBg/TextMonster", type = "Text" },
    textSpeed = { path = "root/Left/TitleBg/SpeedBg/TextSpeed", type = "Text" },
    textRange = { path = "root/Left/TitleBg/RangeBg/TextRange", type = "Text" },
    textTime = { path = "root/Middle/TimeBg/TextTime", type = "Text" },
    healthBg = { path = "root/Middle/HealthBg", type = "Transform" },
};

this.initPool = function()
    local function CreateUnitySubPool(prefab, parentTransform, initialSize)
        local function factory(id)
            if not prefab then return nil end
            local go = CS.UnityEngine.Object
                .Instantiate(prefab, parentTransform)
            go.name = prefab.name .. "_" .. id
            SetActive(go, false)
            return go
        end
        local function onGet(go, ...)
            SetActive(go, true)
            go.transform:SetAsLastSibling()
        end
        local function onReturn(go) SetActive(go, false) end
        local function onDispose(go)
            if go then
                LuaMgr.DestroyGO(go)
            end
        end
        return JSYZGameMgr.ObjectPool.New(factory, onGet, initialSize, onReturn,
            onDispose)
    end
    if this.gridItem then
        this.cellPool = CreateUnitySubPool(this.gridItem,
            this.tranCity.transform, 1)
    end


    if this.boomItem then
        this.boomPool = CreateUnitySubPool(this.boomItem,
            this.tranCity.transform, 1)
    end


    if this.explosionItem then
        this.explosionPool = CreateUnitySubPool(this.explosionItem,
            this.tranCity.transform, 1)
    end


    for powerupType, config in pairs(JSYZPowerups) do
        if this.powerItem then
            this.powerupPools[powerupType] =
                CreateUnitySubPool(this.powerItem, this.tranCity.transform, 1)
        end
    end


    for enemyId, config in pairs(JSYZEnemies) do
        if this.enemyItem then
            this.entityPools[enemyId] = CreateUnitySubPool(this.enemyItem,
                this.tranCity
                .transform, 1)
        end
    end


    if this.vigilanceItem then
        this.vigilancePool = CreateUnitySubPool(this.vigilanceItem,
            this.tranCity.transform, 1)
    end
end


this.SetData = function()
    SetActive(this.btnSkip.gameObject, not JSYZMgr.CheckEventIsComplete(this.eventConfig))
    this.Clear()
    this.SetCharacter()
    this.SetTime();
    JSYZGameMgr.Init(this.mapId, this.SetTime)
end

this.SetCharacter = function()
    local skinId = "A0175001";
    this.spineBody:SetBattle(skinId, skinId, "-1", 0, function()
        this.spineBody:Play("idle", true, nil);
    end)
end


this.OnBack = function()
    if (JSYZGameMgr.IsOpen()) then
        JSYZGameMgr.Pause();
    else
        LuaMgr.Back();
    end
end


this.OnClickPause = function()
    if (JSYZGameMgr.IsOpen()) then
        JSYZGameMgr.Pause();
    end
end

this.OnClickSkip = function()
    if (JSYZGameMgr.IsOpen()) then
        JSYZGameMgr.Skip();
    end
end

this.OnClickBome = function()
    JSYZGameMgr.PlaceBomb()
end

this.OnClickQuickBome = function()
    JSYZGameMgr.DetonateAll()
end


this.ClearTouch = function()
    this.touchPosX = 0;
    this.touchPosY = 0;
    this.isTouchDown = false;
    this.dragFingerId = nil;
    this.touchTarget.localPosition = Vector3.zero;
    SetActive(this.touchRight, false);
    SetActive(this.touchLeft, false);
    SetActive(this.touchUp, false)
    SetActive(this.touchDown, false)


end


this.OnTouchUp = function()
    this.ClearTouch();
end


this.OnTouchDown = function()
    this.dragFingerId = nil
    if CS.UnityEngine.Input.touchCount > 0 then
        for i = 0, CS.UnityEngine.Input.touchCount - 1 do
            local touch = CS.UnityEngine.Input.GetTouch(i)
            if touch.phase == CS.UnityEngine.TouchPhase.Began then
                this.dragFingerId = touch.fingerId
                break
            end
        end
        if this.dragFingerId == nil then
            this.dragFingerId = CS.UnityEngine.Input.GetTouch(0).fingerId
        end
    end

    local pos = this.GetCurrentInputPosition()
    this.touchPosX = pos.x;
    this.touchPosY = pos.y
    this.isTouchDown = true;
    this.touchDelayFram = 50;
end

this.OnTouchLongPress = function()
    if not this.isTouchDown then return end

    local diffX, diffY, magnitude, clampedDist = this.CalculateTouchInput()

    if magnitude < this.cameraConfig.joystickDeadZone then
        return
    end

    local ratioX, ratioY = this.ResolveDirection(diffX, diffY, magnitude)
    this.UpdateJoystickVisuals(ratioX, ratioY, diffX, diffY, magnitude, clampedDist)
    local entity = this.entityViews["player"]
    local currentPos = entity.go.transform.localPosition
    local targetPos = entity.targetPos
    if (targetPos ~= nil) then
        local moveDirX = targetPos.x - currentPos.x
        local moveDirY = targetPos.y - currentPos.y
        local dot = ratioX * moveDirX + ratioY * moveDirY
        local dist = Vector3.Distance(currentPos, targetPos)

        if dist > 0.4 and dot > 0 then
            return
        end
    end
    if ratioX ~= 0 then
        this.charaPos.localScale = Vector3(1 * ratioX, 1, 1)
    end
    if ratioX ~= 0 and ratioY ~= 0 then
        if math.abs(diffX) >= math.abs(diffY) then
            if not JSYZGameMgr.HandleInput(ratioX, 0) then
                JSYZGameMgr.HandleInput(0, ratioY)
            end
        else
            if not JSYZGameMgr.HandleInput(0, ratioY) then
                JSYZGameMgr.HandleInput(ratioX, 0)
            end
        end
    elseif ratioX ~= 0 or ratioY ~= 0 then
        JSYZGameMgr.HandleInput(ratioX, ratioY)
    end
end

this.UpdateCameraFollow = function()
    if not this.charaPos then return end

    local playerLocalX = this.charaPos.anchoredPosition.x
    local playerLocalY = this.charaPos.anchoredPosition.y


    local mapTotalWidth = 1967
    local screenW = this.screenWidth
    local maxMapOffsetX = (mapTotalWidth - screenW) / 2
    local targetCameraX = -playerLocalX
    targetCameraX = math.max(-maxMapOffsetX, math.min(maxMapOffsetX, targetCameraX))


    local mapTotalHeight = 1176
    local screenH = this.screenHeight
    local maxMapOffsetY = (mapTotalHeight - screenH) / 2
    local targetCameraY = -playerLocalY
    targetCameraY = math.max(-maxMapOffsetY, math.min(maxMapOffsetY, targetCameraY))

    local currentCameraX = this.tranContent.anchoredPosition.x
    local currentCameraY = this.tranContent.anchoredPosition.y
    local distX = math.abs(targetCameraX - currentCameraX)
    local distY = math.abs(targetCameraY - currentCameraY)

    if distX > this.cameraConfig.minMoveThreshold or distY > this.cameraConfig.minMoveThreshold then
        local newCameraX = currentCameraX + (targetCameraX - currentCameraX) * this.cameraConfig.smoothSpeed
        local newCameraY = currentCameraY + (targetCameraY - currentCameraY) * this.cameraConfig.smoothSpeed
        this.tranContent.anchoredPosition = Vector2(newCameraX, newCameraY)
    end
end


this.UpdatePlayerMovement = function()
    local playerEntity = this.entityViews["player"]
    if not playerEntity or not playerEntity.targetPos then return end

    local currentPos = playerEntity.go.transform.localPosition
    local targetPos = playerEntity.targetPos
    local dist = Vector3.Distance(currentPos, targetPos)
    if dist > 0.02 then
        local moveSpeed = (140 + playerEntity.data.playerMoveSpeed * 10) * CS.UnityEngine.Time.deltaTime
        local nextPos = Vector3.MoveTowards(currentPos, targetPos, moveSpeed)
        local clampedPos = this.ClampPlayerPosition(nextPos)

        playerEntity.go.transform.localPosition = clampedPos
        this.SwichBodyState(true)
    else
        playerEntity.go.transform.localPosition = targetPos
        this.SwichBodyState(false)
    end
end


this.ClampPlayerPosition = function(pos)
    local mapHalfWidth = (JSYZGame.gridSizeX * JSYZGame.cellSize) / 2
    local mapHalfHeight = (JSYZGame.gridSizeY * JSYZGame.cellSize) / 2
    local margin = JSYZGame.cellSize / 2

    local clampedX = math.max(-mapHalfWidth + margin, math.min(mapHalfWidth - margin, pos.x))
    local clampedY = math.max(-mapHalfHeight + margin, math.min(mapHalfHeight - margin, pos.y))

    return CS.UnityEngine.Vector3(clampedX, clampedY, pos.z)
end

this.GetCurrentInputPosition = function()
    if CS.UnityEngine.Input.touchCount > 0 then
        if this.dragFingerId ~= nil then
            for i = 0, CS.UnityEngine.Input.touchCount - 1 do
                local touch = CS.UnityEngine.Input.GetTouch(i)
                if touch.fingerId == this.dragFingerId then
                    return touch.position
                end
            end
        end
        return CS.UnityEngine.Input.GetTouch(0).position
    else
        return CS.UnityEngine.Input.mousePosition
    end
end

this.CalculateTouchInput = function()
    local pos = this.GetCurrentInputPosition()
    local diffX = pos.x - this.touchPosX
    local diffY = pos.y - this.touchPosY
    local magnitude = math.sqrt(diffX * diffX + diffY * diffY)
    local clampedDist = magnitude
    if (clampedDist > 75) then
        clampedDist = 75
    end

    return diffX, diffY, magnitude, clampedDist
end

this.ResolveDirection = function(diffX, diffY, magnitude)
    local ratioX = 0
    local ratioY = 0

    if magnitude > 0 then
        local absX = math.abs(diffX)
        local absY = math.abs(diffY)
        local tan32_5 = 0.6371
        local tan57_5 = 1.5697
        if absY < absX * tan32_5 then
            ratioX = diffX > 0 and 1 or -1
            ratioY = 0
        elseif absY > absX * tan57_5 then
            ratioX = 0
            ratioY = diffY > 0 and 1 or -1
        else
            ratioX = diffX > 0 and 1 or -1
            ratioY = diffY > 0 and 1 or -1
        end
    end

    return ratioX, ratioY
end

this.UpdateJoystickVisuals = function(ratioX, ratioY, diffX, diffY, magnitude, clampedDist)
    SetActive(this.touchRight, ratioX == 1)
    SetActive(this.touchLeft, ratioX == -1)
    SetActive(this.touchUp, ratioY == 1)
    SetActive(this.touchDown, ratioY == -1)
    if magnitude > 0 then
        local indicatorX = (diffX / magnitude) * clampedDist
        local indicatorY = (diffY / magnitude) * clampedDist
        this.touchTarget.localPosition = Vector3(indicatorX, indicatorY, 0)
    else
        this.touchTarget.localPosition = Vector3.zero
    end
end

this.SwichBodyState = function(isRun)
    if (this.inRunState == isRun) then return end
    this.inRunState = isRun;
    if (isRun) then
        this.spineBody:Play("run", true, nil);
    else
        this.spineBody:Play("idle", true, nil);
    end
end






this.OnMapGenerated = function(data)
    local grid = data[0]
    if not grid or not this.cellPool then return end

    for _, viewData in pairs(this.cellViews) do
        if viewData.obj then
            if (viewData.animator ~= nil) then
                viewData.animator:Rebind();
                viewData.animator.enabled = false
            end
            this.cellPool:Return(viewData.obj)
        end
    end
    this.cellViews = {}


    for x = 0, JSYZGame.gridSizeX - 1 do
        for y = 0, JSYZGame.gridSizeY - 1 do
            if (grid[x] ~= nil) then
                local cellType = grid[x][y]

                if cellType ~= JSYZCellType.EMPTY then
                    this.CreateCellView(x, y, cellType)
                end
            end
        end
    end
end


this.CreateCellView = function(x, y, cellType)
    if not this.cellPool then return nil end

    local key = JSYZGameUtils.MakeKey(x, y)


    local oldView = this.cellViews[key]
    if oldView and oldView.obj then
        if (oldView.animator ~= nil) then
            oldView.animator:Rebind();
            oldView.animator.enabled = false
        end
        this.cellPool:Return(oldView.obj)
    end


    local cellObj = this.cellPool:Get()
    if not cellObj then return nil end


    cellObj.transform.localPosition = this.GridToWorld(x, y)
    cellObj.gameObject.name = "cell_" .. x .. "_" .. y .. "_T_" .. cellType
    local animator = nil
    if (cellType == 1 or cellType == 2) then
        cellObj.transform:SetAsFirstSibling()
        animator = cellObj.transform:GetChild(0):GetComponent("Animator")
        if (animator ~= nil) then
            animator:Rebind();
            animator.enabled = false
        end
    end

    this.ApplyCellAppearance(cellObj, cellType)


    this.cellViews[key] = { obj = cellObj, cellType = cellType, animator = animator }

    return cellObj
end


this.ApplyCellAppearance = function(cellObj, cellType)
    local config = JSYZVisuals.cells[cellType]
    if not config then return end
    if (cellType == 1) then
        local random = math.random(1, cellObj.transform.childCount - 1)
        for i = 0, cellObj.transform.childCount - 1 do
            local child = cellObj.transform:GetChild(i)
            if (i == random) then
                SetActive(child.gameObject, true)
            else
                SetActive(child.gameObject, false)
            end
        end
    elseif (cellType == 2) then
        for i = 0, cellObj.transform.childCount - 1 do
            local child = cellObj.transform:GetChild(i)
            if (i == 0) then
                SetActive(child.gameObject, true)
            else
                SetActive(child.gameObject, false)
            end
        end
    else
        local image = cellObj.transform:GetChild(0):GetComponent(typeof(
            CS.UnityEngine
            .UI.Image))
        if not image then return end
        image.sprite = LuaMgr.GetSprite("JSYZ", "ui_hd_zdr_icon_" .. config.sprite)
    end
end


this.OnCellChanged = function(data)
    local x = data[0]
    local y = data[1]
    local newCellType = data[2]
    if newCellType == JSYZCellType.EMPTY then
        local key = JSYZGameUtils.MakeKey(x, y)
        local oldView = this.cellViews[key]
        if oldView and oldView.obj then
            if (oldView.animator ~= nil) then
                oldView.animator.enabled = true
            end
            if this.cellDelay[key] ~= nil then
                coroutine_runner.stop(this.cellDelay[key])
            end
            this.cellDelay[key] = coroutine_runner.start(function()
                coroutine_runner.wait(0.5)
                if (oldView.animator ~= nil) then
                    oldView.animator:Rebind();
                    oldView.animator.enabled = false
                end
                this.cellPool:Return(oldView.obj)
                this.cellViews[key] = nil
            end)
        end
    else
        this.CreateCellView(x, y, newCellType)
    end
end


this.OnExitRevealed = function(data)
    local exitPos = data[0]
    if not exitPos then return end

end


this.OnEntitySpawned = function(data)
    local entity = data[0]
    if not entity then return end
    local entityObj

    if entity.type == JSYZCellType.PLAYER then
        entityObj = this.charaPos.gameObject
    elseif entity.type == JSYZCellType.ENEMY then
        this.textMonster.text = LuaMgr.GetLangText("JSYZGameViewModel_0") .. #JSYZGameMgr.GetGameState().enemies
        local pool = this.entityPools[entity.configId]
        if pool then entityObj = pool:Get() end
    end

    if not entityObj then return end

    local worldPos = this.GridToWorld(entity.x, entity.y)
    entityObj.transform.localPosition = worldPos

    if entity.type == JSYZCellType.PLAYER then
        this.entityViews["player"] = { go = entityObj, data = entity, type = JSYZCellType.PLAYER }
        this.charaPos.anchoredPosition = Vector2(worldPos.x, worldPos.y)

        local targetCameraX = -worldPos.x
        local maxMapOffsetX = (1967 - this.screenWidth) / 2
        targetCameraX = math.max(-maxMapOffsetX, math.min(maxMapOffsetX, targetCameraX))
        local targetCameraY = -worldPos.y
        local maxMapOffsetY = (1176 - this.screenHeight) / 2
        targetCameraY = math.max(-maxMapOffsetY, math.min(maxMapOffsetY, targetCameraY))
        this.tranContent.anchoredPosition = Vector2(targetCameraX, targetCameraY)
        this.textRange.text = "X" .. entity.bombRange
        this.textSpeed.text = "X" .. entity.playerMoveSpeed
        this.refreshBombCount(entity)
        this.refreshHpStar(entity.playerHp)
    else
        local posObj = entityObj.transform:GetChild(0)
        posObj.localScale = Vector3.one
        local spine = posObj.transform:GetChild(0):GetComponent("UISpineCharacter");
        local config = JSYZEnemies[entity.configId]
        spine:Clear()
        local prefabList = NumTool.split(config.prefab, ",");
        local indexNum = math.random(1, #prefabList);
        local prefab = prefabList[indexNum]
        spine:SetBattle(prefab, prefab, "-1", 0, function()
            spine:Play("run", true, nil)
        end)
        this.entityViews[entity.id] = {
            go = entityObj,
            data = entity,
            spine = spine,
            posObj = posObj,
            type = JSYZCellType.ENEMY
        }
    end
end


this.OnEntityMoved = function(data)
    local entityData = data[0]
    if not entityData then return end
    local entity = this.entityViews[entityData.id]
    if entity then
        local targetPos = this.GridToWorld(entityData.x, entityData.y)
        entity.targetPos = targetPos

        local currentPos = entity.go.transform.localPosition
        local dist = Vector3.Distance(currentPos, targetPos)
        if dist > 500 then
            entity.go.transform.localPosition = targetPos
            if entityData.id == "player" then
                this.charaPos.transform.localPosition = targetPos
            end
            entity.targetPos = nil
        end
    end
end


this.OnEntityDestroyed = function(data)
    local entityData = data[0]
    if not entityData then return end

    local entity = this.entityViews[entityData.id]
    if not entity then return end


    if entityData.type == JSYZCellType.ENEMY then
        this.textMonster.text = LuaMgr.GetLangText("JSYZGameViewModel_1") .. #JSYZGameMgr.GetGameState().enemies
        local pool = this.entityPools[entityData.configId]
        entity.spine:Play("death", false, function()
            if pool then pool:Return(entity.go) end
            entity.spine:Clear()
        end)
    else

        LuaMgr.DestroyGO(entity.go)
    end

    this.entityViews[entityData.id] = nil
end




this.OnBombPlaced = function(data)
    local bomb = data[0]
    if not bomb then return end
    local bombObj = this.boomPool:Get()
    bombObj.transform.localPosition = this.GridToWorld(bomb.x, bomb.y)
    this.entityViews[bomb.id] = { go = bombObj, type = JSYZCellType.BOMB }


    local vigilanceZones = data[1]
    if vigilanceZones and this.vigilancePool then
        local views = {}
        for _, zone in ipairs(vigilanceZones) do
            local vObj = this.vigilancePool:Get()
            if vObj then
                vObj.transform.localPosition = this.GridToWorld(zone.x, zone.y)
                vObj.transform:SetAsFirstSibling()
                table.insert(views, vObj)
            end
        end

        this.vigilanceViews[bomb.id] = views
    end
    this.refreshBombCount(this.entityViews["player"].data)
end




this.OnBombExploded = function(data)
    local bombs = data[0]
    local explosions = data[1]

    if bombs then
        for i, v in ipairs(bombs) do
            local bomb = this.entityViews[v.id]
            if bomb then
                this.boomPool:Return(bomb.go)
                this.entityViews[v.id] = nil
            end


            local views = this.vigilanceViews[v.id]
            if views and this.vigilancePool then
                for _, vObj in ipairs(views) do
                    this.vigilancePool:Return(vObj)
                end
            end
            this.vigilanceViews[v.id] = nil
        end
    end


    if explosions and this.explosionPool then
        local duration = JSYZGame.explosionDuration
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "DH/DH_YP_05.mp3");
        for _, exp in ipairs(explosions) do
            local expObj = this.explosionPool:Get()
            if expObj then
                expObj.transform.localPosition = this.GridToWorld(exp.x, exp.y)


                table.insert(this.destroyQueue, {
                    pool = this.explosionPool,
                    obj = expObj,
                    timer = duration
                })
            end
        end
    end
    this.refreshBombCount(this.entityViews["player"].data)
end


this.OnPowerupSpawned = function(data)
    local x = data[0]
    local y = data[1]
    local powerupType = data[2]
    local pool = this.powerupPools[powerupType]
    if not pool then return end

    local powerupObj = pool:Get()
    if not powerupObj then return end

    powerupObj.transform.localPosition = this.GridToWorld(x, y)

    this.ApplyCellAppearance(powerupObj, JSYZPowerups[powerupType].id)
    local eff = powerupObj.transform:GetChild(0):GetChild(0)
    local key = JSYZGameUtils.MakeKey(x, y)
    this.powerupViews[key] = { obj = powerupObj, type = powerupType, eff = eff }
end


this.OnPowerupCollected = function(data)
    local player = data[1]
    if not player then return end

    local key = JSYZGameUtils.MakeKey(player.x, player.y)
    local viewData = this.powerupViews[key]

    if viewData then
        local pool = this.powerupPools[viewData.type]
        if pool and viewData.obj then
            if this.powerupDelay[key] ~= nil then
                coroutine_runner.stop(this.powerupDelay[key])
            end
            this.powerupDelay[key] = coroutine_runner.start(function()
                if (viewData.eff ~= nil) then
                    AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "Parkour/DH_parkour_5.mp3");
                    SetActive(viewData.eff.gameObject, true)
                    coroutine_runner.wait(0.5)
                    SetActive(viewData.eff.gameObject, false)
                end
                pool:Return(viewData.obj)
            end)
        end
        this.powerupViews[key] = nil
    end
    this.ShowPlayerState(data)
end

this.ShowPlayerState = function(data)
    local powerupType = data[0]
    if not powerupType then return end
    local player = data[1]
    if not player then return end
    local success = data[2]
    if not success then return end
    if (powerupType == JSYZCellType.POWERUP_RANGE) then
        this.textRange.text = "X" .. player.bombRange
    elseif (powerupType == JSYZCellType.POWERUP_SPEED) then
        this.textSpeed.text = "X" .. player.playerMoveSpeed
    elseif (powerupType == JSYZCellType.POWERUP_INVINCIBLE) then
        SetActive(this.effBody, true)
    elseif (powerupType == JSYZCellType.POWERUP_BOMB) then
        this.refreshBombCount(player)
    elseif (powerupType == JSYZCellType.POWERUP_HP) then
        this.refreshHpStar(player.playerHp)
    elseif (powerupType == JSYZCellType.POWERUP_INVINCIBLE_HURT) then
        this.refreshHpStar(player.playerHp)
        this.spineBody:Play("suffer", false, function()
            this.spineBody:Play("idle", true, nil)
            this.inRunState = false
        end);
        SetActive(this.effBody, true)
    end
end

this.refreshBombCount = function(player)
    local curNum = #JSYZGameMgr.GetGameState().bombs
    this.btnQuickBome.gameObject:SetActive(curNum > 0)
    local num = player.maxBombs - curNum
    if (num < 0) then
        num = 0
    end
    this.textRatio.text = num .. "/" .. player.maxBombs
end

this.refreshHpStar = function(hpNum)
    if (this.entityViews["player"] == nil) then
        return
    end
    local hpMax = this.entityViews["player"].data.playerHpMax
    for i = 1, this.healthBg.childCount do
        local star = this.healthBg:GetChild(i - 1)
        local stat1 = star.transform:GetChild(0)
        if i <= hpMax then
            star.gameObject:SetActive(true)
        else
            star.gameObject:SetActive(false)
        end
        if (i <= hpNum) then
            stat1.gameObject:SetActive(true)
        else
            stat1.gameObject:SetActive(false)
        end
    end
end


this.OnPowerupDestroyed = function(data)
    local x = data[0]
    local y = data[1]
    local key = JSYZGameUtils.MakeKey(x, y)
    local viewData = this.powerupViews[key]

    if viewData and viewData.type ~= 5 then
        local pool = this.powerupPools[viewData.type]
        if pool and viewData.obj then
            if this.powerupDelay[key] ~= nil then
                coroutine_runner.stop(this.powerupDelay[key])
            end
            this.powerupDelay[key] = coroutine_runner.start(function()
                if (viewData.eff ~= nil) then
                    SetActive(viewData.eff.gameObject, true)
                    coroutine_runner.wait(0.5)
                    SetActive(viewData.eff.gameObject, false)
                end
                pool:Return(viewData.obj)
            end)
        end
        this.powerupViews[key] = nil
    end
end


this.OnGameOver = function()
    LuaDebug.error("游戏失败")
end


this.OnGameWin = function()
    LuaDebug.error("游戏胜利")
end


this.OnPlaySound = function(data)
    local soundName = data[0]
    LuaDebug.error("播放音效：" .. soundName)
end


this.OnRestart = function()
    JSYZGameMgr.Show()
    this.SetData();
    this.ClearTouch()
    LuaMgr.ShowLuaPanel(UIName.JSYZGamePauseViewModel, 0, function()
        JSYZGameMgr.Play()
    end);
end


this.SetTime = function()
    local time = math.ceil(JSYZGameMgr.GameEndTime());
    local h, m, s = GetTimeHMS(time);
    this.textTime.text = string.format("%s:%s", m, s);
end






this.GridToWorld = function(gridX, gridY)
    local offsetX = -(JSYZGame.gridSizeX * JSYZGame.cellSize) / 2
    local offsetY = -(JSYZGame.gridSizeY * JSYZGame.cellSize) / 2

    local worldX = gridX * JSYZGame.cellSize + offsetX + JSYZGame.cellSize / 2
    local worldY = gridY * JSYZGame.cellSize + offsetY + JSYZGame.cellSize / 2

    return CS.UnityEngine.Vector3(worldX, worldY, 0)
end

this.WorldToGrid = function(worldX, worldY)
    local cellSize = JSYZGame.cellSize
    local mapHalfWidth = (JSYZGame.gridSizeX * cellSize) / 2
    local mapHalfHeight = (JSYZGame.gridSizeY * cellSize) / 2

    local gridX = math.floor((worldX + mapHalfWidth - cellSize / 2) / cellSize + 0.5)
    local gridY = math.floor((worldY + mapHalfHeight - cellSize / 2) / cellSize + 0.5)

    return { x = gridX, y = gridY }
end


this.Clear = function()

    for id, view in pairs(this.entityViews) do
if view and id ~= "player" then
            if (view.type == JSYZCellType.BOMB) then
                this.boomPool:Return(view.go)
            elseif (view.type == JSYZCellType.ENEMY) then
                local pool = this.entityPools[view.data.configId]
                if pool then pool:Return(view.go) end
            else
                LuaMgr.DestroyGO(view.go)
            end
        end
    end
    this.entityViews = {}


    if this.cellPool then
        for _, viewData in pairs(this.cellViews) do
            if viewData and viewData.obj then
                if (viewData.animator ~= nil) then
                    viewData.animator:Rebind();
                    viewData.animator.enabled = false
                end
                this.cellPool:Return(viewData.obj)
            end
        end
    end
    this.cellViews = {}


    for key, viewData in pairs(this.powerupViews) do
        if viewData then
            local pool = this.powerupPools[viewData.type]
            if pool and viewData.obj then pool:Return(viewData.obj) end
        end
    end
    this.powerupViews = {}


    if this.vigilancePool then
        for bombId, views in pairs(this.vigilanceViews) do
            for _, vObj in ipairs(views) do
                this.vigilancePool:Return(vObj)
            end
        end
    end
    this.vigilanceViews = {}


    for _, item in ipairs(this.destroyQueue) do
        if item.pool and item.obj then item.pool:Return(item.obj) end
    end
    this.destroyQueue = {}

    for _, v in pairs(this.cellDelay) do
        coroutine_runner.stop(v)
    end
    this.cellDelay = {}
    for _, v in pairs(this.powerupDelay) do
        coroutine_runner.stop(v)
    end
    this.powerupDelay = {}
end

this.Destroy = function()
    this.cellPool:Clear()
    this.boomPool:Clear()
    this.explosionPool:Clear()
    this.vigilancePool:Clear()
    for k, v in pairs(this.powerupPools) do
        v:Clear()
    end
    for k, v in pairs(this.entityPools) do
        v:Clear()
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.pauseBtn, this.OnClickPause);
        LuaMgr.AddClick(this.btnSkip, this.OnClickSkip);
        LuaMgr.AddClick(this.btnBome, this.OnClickBome)
        LuaMgr.AddClick(this.btnQuickBome, this.OnClickQuickBome)
        RedMgr.Singleton:RegisterViewModel(UIName.JSYZGameViewModel);
        this.touchEvent.onDown = this.OnTouchDown;
        this.touchEvent.onUp = this.OnTouchUp;
        this.touchEvent.onLongPress = this.OnTouchLongPress;
        this.screenWidth = LuaMgr.ScreenWidth();
        this.screenHeight = LuaMgr.ScreenHeight();
        this.halfWidth = this.screenWidth / 2;
        this.halfHeight = this.screenHeight / 2;
        this.initPool()
    end,
    before_active = function(vm)
        LuaMgr.AddUIEventListener(UIEventConst.TopBarHelp, this.OnClickPause)
        LuaMgr.AddUIEventListener(UIEventConst.JSYZ_MAP_GENERATED,
            this.OnMapGenerated)
        LuaMgr.AddUIEventListener(UIEventConst.JSYZ_CELL_CHANGED,
            this.OnCellChanged)
        LuaMgr.AddUIEventListener(UIEventConst.JSYZ_EXIT_REVEALED,
            this.OnExitRevealed)
        LuaMgr.AddUIEventListener(UIEventConst.JSYZ_ENTITY_SPAWNED,
            this.OnEntitySpawned)
        LuaMgr.AddUIEventListener(UIEventConst.JSYZ_ENTITY_MOVED,
            this.OnEntityMoved)
        LuaMgr.AddUIEventListener(UIEventConst.JSYZ_ENTITY_DESTROYED,
            this.OnEntityDestroyed)
        LuaMgr.AddUIEventListener(UIEventConst.JSYZ_BOMB_PLACED,
            this.OnBombPlaced)
        LuaMgr.AddUIEventListener(UIEventConst.JSYZ_BOMB_EXPLODED,
            this.OnBombExploded)
        LuaMgr.AddUIEventListener(UIEventConst.JSYZ_POWERUP_SPAWNED,
            this.OnPowerupSpawned)
        LuaMgr.AddUIEventListener(UIEventConst.JSYZ_POWERUP_COLLECTED,
            this.OnPowerupCollected)
        LuaMgr.AddUIEventListener(UIEventConst.JSYZ_POWERUP_DESTROYED,
            this.OnPowerupDestroyed)
        LuaMgr.AddUIEventListener(UIEventConst.JSYZ_GAME_OVER, this.OnGameOver)
        LuaMgr.AddUIEventListener(UIEventConst.JSYZ_GAME_WIN, this.OnGameWin)
        LuaMgr.AddUIEventListener(UIEventConst.JSYZ_PLAY_SOUND, this.OnPlaySound)
        LuaMgr.AddUIEventListener(UIEventConst.JSYZGameRestart, this.OnRestart);
        LuaMgr.AddUpdate(this.OnUpdate);
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length > 0 then
            local eventConfig = vm.behaviour.Params[0]
            this.eventConfig = eventConfig
            this.mapId = eventConfig.eventParam
            this.textTitle.text = LuaMgr.GetLangText(eventConfig.namelan)
        end
        SetActive(this.touchGroup, true);
        if (RedMgr.Singleton:CheckRedCondition("17603")) then
            RedMgr.Singleton:FrushRedCondition("17603")
        end
        HeroRedDataHelper.SetJSYZRed()
        RedMgr.Singleton:Refresh()
        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.charaPos.localScale = Vector3.one;



        JSYZGameMgr.Show()
        JSYZGameMgr.Play()
        this.SetData();
        this.ClearTouch()
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.TopBarHelp, this.OnClickPause)
        LuaMgr.RemoveUIEventListener(UIEventConst.JSYZ_MAP_GENERATED,
            this.OnMapGenerated)
        LuaMgr.RemoveUIEventListener(UIEventConst.JSYZ_CELL_CHANGED,
            this.OnCellChanged)
        LuaMgr.RemoveUIEventListener(UIEventConst.JSYZ_EXIT_REVEALED,
            this.OnExitRevealed)
        LuaMgr.RemoveUIEventListener(UIEventConst.JSYZ_ENTITY_SPAWNED,
            this.OnEntitySpawned)
        LuaMgr.RemoveUIEventListener(UIEventConst.JSYZ_ENTITY_MOVED,
            this.OnEntityMoved)
        LuaMgr.RemoveUIEventListener(UIEventConst.JSYZ_ENTITY_DESTROYED,
            this.OnEntityDestroyed)
        LuaMgr.RemoveUIEventListener(UIEventConst.JSYZ_BOMB_PLACED,
            this.OnBombPlaced)
        LuaMgr.RemoveUIEventListener(UIEventConst.JSYZ_BOMB_EXPLODED,
            this.OnBombExploded)
        LuaMgr.RemoveUIEventListener(UIEventConst.JSYZ_POWERUP_SPAWNED,
            this.OnPowerupSpawned)
        LuaMgr.RemoveUIEventListener(UIEventConst.JSYZ_POWERUP_COLLECTED,
            this.OnPowerupCollected)
        LuaMgr.RemoveUIEventListener(UIEventConst.JSYZ_POWERUP_DESTROYED,
            this.OnPowerupDestroyed)
        LuaMgr.RemoveUIEventListener(UIEventConst.JSYZ_GAME_OVER,
            this.OnGameOver)
        LuaMgr.RemoveUIEventListener(UIEventConst.JSYZ_GAME_WIN, this.OnGameWin)
        LuaMgr.RemoveUIEventListener(UIEventConst.JSYZ_PLAY_SOUND,
            this.OnPlaySound)
        LuaMgr.RemoveUIEventListener(UIEventConst.JSYZGameRestart,
            this.OnRestart);
        LuaMgr.RemoveUpdate(this.OnUpdate);
        if this.tweener2 ~= nil then this.tweener2:Kill(); end
        JSYZGameMgr.Stop()
        JSYZGameMgr.Clear()
        this.Clear()
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.pauseBtn, this.OnClickPause);
        LuaMgr.RemoveClick(this.btnSkip, this.OnClickSkip);
        LuaMgr.RemoveClick(this.btnBome, this.OnClickBome)
        LuaMgr.RemoveClick(this.btnQuickBome, this.OnClickQuickBome)
        RedMgr.Singleton:RemoveViewModel(UIName.JSYZGameViewModel);
        if this.spineBody ~= nil then this.spineBody:Clear(); end
        this.Destroy()
    end
}

this.OnUpdate = function()

    JSYZGameMgr.OnUpdate()


    for i = #this.destroyQueue, 1, -1 do
        local item = this.destroyQueue[i]
        item.timer = item.timer - CS.UnityEngine.Time.deltaTime
        if item.timer <= 0 then
            if item.pool and item.obj then
                item.pool:Return(item.obj)
            end
            table.remove(this.destroyQueue, i)
        end
    end
    if (not this.isTouchDown and this.touchDelayFram > 0) then
        this.touchDelayFram = this.touchDelayFram - 1
    end

    if (this.isTouchDown or this.inRunState or this.touchDelayFram > 0) then

        this.UpdatePlayerMovement()

        this.UpdateCameraFollow()
    end


    for id, entity in pairs(this.entityViews) do
        if id ~= "player" and entity.targetPos then
            local currentPos = entity.go.transform.localPosition
            local targetPos = entity.targetPos
            local dist = Vector3.Distance(currentPos, targetPos)
            local diffX = targetPos.x - currentPos.x
            local diffY = targetPos.y - currentPos.y
            local magnitude = math.sqrt(diffX * diffX + diffY * diffY)
            local ratioX, ratioY = this.ResolveDirection(diffX, diffY, magnitude)
            if ratioX ~= 0 then
                entity.posObj.localScale = Vector3(1 * ratioX, 1, 1)
            end
            if dist > 0.5 then
                local logicInterval = entity.data.moveSpeed
                local realVisualSpeed = JSYZGame.cellSize / logicInterval
                local moveSpeed = realVisualSpeed * CS.UnityEngine.Time.deltaTime
                local nextPos = Vector3.MoveTowards(currentPos, targetPos, moveSpeed)
                entity.go.transform.localPosition = nextPos
            else
                entity.go.transform.localPosition = targetPos
                entity.targetPos = nil
            end
        elseif (id == "player") then
            local invincible = this.entityViews["player"].data.invincible
            SetActive(this.effBody, invincible)
        end
    end
end

this.CheckActivityRunning = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.JSYZ) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,
            ConfigMgr.LangGlobal("15901"))
        return false;
    end
    return true;
end

return vm({ data = data, command = command, hook = hook })