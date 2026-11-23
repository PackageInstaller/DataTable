JSYZGameMgr = {};

local this = {
    gameTime       = 0,
    grid           = nil,
    exitPos        = nil,
    exitRevealed   = false,
    player         = nil,
    enemies        = {},
    bombs          = {},
    explosions     = {},
    powerups       = {},
    dangerMap      = {},
    gameOver       = false,
    win            = false,
    isPlay         = true,
    enemyIdCounter = 0,
    currentTime    = 0,

    bombPool       = nil,
    explosionPool  = nil,
    ObjectPool     = {},
    gameEndTime    = 0,
    mapId          = "",
    setTime        = nil,
    audioPath      = "Assets/_BundleResources/Audio/newUI/%s.mp3",
    powerupIndex   = {},
};

JSYZGameMgr.ObjectPool = {}


function JSYZGameMgr.ObjectPool.New(factoryFunc, resetFunc, initialSize, returnFunc, disposeFunc)
    local available = {}
    local active = {}
    local totalCreated = 0
    local factory = factoryFunc
    local reset = resetFunc
    local onReturn = returnFunc
    local onDispose = disposeFunc
    local function createOne()
        totalCreated = totalCreated + 1
        local obj = factory(totalCreated)
        return obj
    end
    for i = 1, initialSize or 5 do
        table.insert(available, createOne())
    end
    local instance = {}

    instance.Get = function(_self, ...)
        local params
        if _self == instance then params = { ... } else params = { _self, ... } end

        local obj
        if #available > 0 then
            obj = table.remove(available)
        else
            obj = createOne()
        end
        active[obj] = true

        if reset then
            local unpackFunc = unpack or table.unpack
            reset(obj, unpackFunc(params))
        end

        return obj
    end

    instance.Return = function(_self, obj)
        local targetObj = (_self == instance) and obj or _self
        if not targetObj then return end
        if not active[targetObj] then return end
        if onReturn then
            onReturn(targetObj)
        end
        active[targetObj] = nil
        table.insert(available, targetObj)
    end
    instance.Clear = function(_self)
        for _, obj in ipairs(available) do
            if onDispose then onDispose(obj) end
        end
        for obj, _ in pairs(active) do
            if onDispose then onDispose(obj) end
        end
        available = {}
        active = {}
        totalCreated = 0
    end

    return instance
end


JSYZGameMgr.Init = function(mapId, setTime)
    this.mapId = mapId
    this.setTime = setTime
    this.bombPool = JSYZGameMgr.ObjectPool.New(
        function(id) return JSYZGameBomb.New(id) end,
        function(bomb, x, y, range, owner) bomb:Reset(x, y, range, owner) end,
        10
    )

    this.explosionPool = JSYZGameMgr.ObjectPool.New(
        function(id) return { x = 0, y = 0, timer = 0 } end,
        function(exp, x, y, timer)
            exp.x = x; exp.y = y; exp.timer = timer
        end,
        50
    )

    math.randomseed(os.time())
    local mapConfig = ConfigMgr.Config.BoomMaps[this.mapId]
    this.gameEndTime = mapConfig.Time
    if (this.gameEndTime == nil) then
        this.gameEndTime = 180
    end
    this.grid, this.exitPos, this.powerupIndex = JSYZGameMapGenerator.Generate(mapConfig)
    LuaMgr.InvokeUIEventListeners(UIEventConst.JSYZ_MAP_GENERATED, this.grid);


















    this.player = JSYZGamePlayer.New(0, 8)
    LuaMgr.InvokeUIEventListeners(UIEventConst.JSYZ_ENTITY_SPAWNED, this.player);

    this.enemies = {}
    for _, spawn in ipairs(mapConfig.MonsterPos) do
        this.enemyIdCounter = this.enemyIdCounter + 1
        local enemy = JSYZGameEnemy.New("enemy_" .. this.enemyIdCounter, spawn[3], spawn[1], spawn[2])
        if (enemy ~= nil) then
            table.insert(this.enemies, enemy)
            LuaMgr.InvokeUIEventListeners(UIEventConst.JSYZ_ENTITY_SPAWNED, enemy);
        else
            this.enemyIdCounter = this.enemyIdCounter - 1

        end
    end

    this.bombs = {}
    this.explosions = {}
    this.powerups = {}
    this.dangerMap = {}
    this.gameOver = false
    this.win = false
    this.isSettled = false
    this.currentTime = 0

end


JSYZGameMgr.HandleInput = function(dirX, dirY)
    if this.player and not this.player.dead then
        local targetX = this.player.x + dirX
        local targetY = this.player.y + dirY
        if not this.grid or this.grid == nil then return false end
        if this.player:CanMove(targetX, targetY, this.grid, this.bombs) then
            if this.player:TryMove(targetX, targetY) then
                LuaMgr.InvokeUIEventListeners(UIEventConst.JSYZ_ENTITY_MOVED, this.player);
                return true
            end
        end
    end
    return false
end


JSYZGameMgr.UpdateBombs = function(deltaTime)
    local bombsToExplode = {}

    for i = 1, #this.bombs do
        local bomb = this.bombs[i]
        if bomb and not bomb:Update(deltaTime) then
            table.insert(bombsToExplode, bomb)
        end
    end

    for _, bomb in ipairs(bombsToExplode) do
        JSYZGameMgr.ExplodeBomb(bomb)
    end
end


JSYZGameMgr.UpdateExplosions = function(deltaTime)
    for i = #this.explosions, 1, -1 do
        local explosion = this.explosions[i]
        explosion.timer = explosion.timer - deltaTime

        if explosion.timer <= 0 then
            this.explosionPool:Return(explosion)
            table.remove(this.explosions, i)
        end
    end
end


JSYZGameMgr.PlaceBomb = function()
    if this.gameOver or this.win then
        return false
    end


    if this.player.activeBombCount >= this.player.maxBombs then
        return false
    end

    for _, bomb in ipairs(this.bombs) do
        if bomb.x == this.player.x and bomb.y == this.player.y then
            return false
        end
    end

    for _, enemy in ipairs(this.enemies) do
        if enemy.x == this.player.x and enemy.y == this.player.y then
            return false
        end
    end
    local newBomb = this.bombPool:Get(this.player.x, this.player.y, this.player.bombRange, this.player)
    table.insert(this.bombs, newBomb)
    this.player.activeBombCount = this.player.activeBombCount + 1


    local vigilanceZones = JSYZGameMgr.CalculateExplosionByPos(
        newBomb.x, newBomb.y, newBomb.range)
    LuaMgr.InvokeUIEventListeners(UIEventConst.JSYZ_BOMB_PLACED, newBomb, vigilanceZones);

    return true
end



JSYZGameMgr.CalculateExplosionByPos = function(bx, by, range)
    local zones = {}
    local directions = { { 0, 0 }, { 0, 1 }, { 0, -1 }, { 1, 0 }, { -1, 0 } }
    local cellType = JSYZCellType
    local gridSizeX = JSYZGame.gridSizeX
    local gridSizeY = JSYZGame.gridSizeY
    local makeKey = JSYZGameUtils.MakeKey
    local visited = {}

    for _, dir in ipairs(directions) do
        for i = 0, range do

            if i == 0 and (dir[1] ~= 0 or dir[2] ~= 0) then
                goto continue
            end

            local x = bx + dir[1] * i
            local y = by + dir[2] * i

            if x < 0 or x >= gridSizeX or y < 0 or y >= gridSizeY then
                break
            end

            if this.grid[x][y] == cellType.WALL then
                break
            end

            local key = makeKey(x, y)
            if not visited[key] then
                visited[key] = true
                table.insert(zones, { x = x, y = y })
            end

            if this.grid[x][y] == cellType.BRICK then
                break
            end

            ::continue::
        end
    end

    return zones
end




JSYZGameMgr.DetonateAll = function()
    if this.gameOver or this.win or not this.isPlay then
        return
    end

    if #this.bombs == 0 then
        return
    end


    local snapshot = {}
    for _, bomb in ipairs(this.bombs) do
        table.insert(snapshot, bomb)
    end

    for _, bomb in ipairs(snapshot) do


        JSYZGameMgr.ExplodeBomb(bomb)
    end
end


JSYZGameMgr.ExplodeBomb = function(bomb)
    if not bomb then return end

    if not JSYZGameMgr.FindBombById(bomb.id) then
        return
    end


    if bomb.owner and bomb.owner.activeBombCount then
        bomb.owner.activeBombCount = math.max(0, bomb.owner.activeBombCount - 1)
    end

    local bombsToExplode = { [bomb.id] = bomb }
    local processedBombs = {}
    local allExplosions = {}
    local allDestroyedBricks = {}
    local destroyedPowerups = {}

    local distinctExplosions = {}
    local makeKey = JSYZGameUtils.MakeKey

    local function collectChainBombs(bombId)
        if processedBombs[bombId] then return end
        processedBombs[bombId] = true

        local currentBomb = JSYZGameMgr.FindBombById(bombId)
        if not currentBomb then return end

        local explosions, bricks, chainIds, powerups = JSYZGameMgr.CalculateExplosion(currentBomb)

        if explosions then
            for _, exp in ipairs(explosions) do
                local key = makeKey(exp.x, exp.y)
                if not distinctExplosions[key] then
                    distinctExplosions[key] = true
                    table.insert(allExplosions, exp)
                end
            end
        end

        if bricks then
            for _, brick in ipairs(bricks) do
                table.insert(allDestroyedBricks, brick)
            end
        end

        if powerups then
            for _, p in ipairs(powerups) do
                table.insert(destroyedPowerups, p)
            end
        end

        if chainIds then
            for _, chainId in ipairs(chainIds) do
                if not processedBombs[chainId] then
                    local chainBomb = JSYZGameMgr.FindBombById(chainId)
                    if chainBomb then
                        bombsToExplode[chainId] = chainBomb

                        if chainBomb.owner and chainBomb.owner.activeBombCount then
                            chainBomb.owner.activeBombCount = math.max(0, chainBomb.owner.activeBombCount - 1)
                        end
                        collectChainBombs(chainId)
                    end
                end
            end
        end
    end

    collectChainBombs(bomb.id)
    local returnBombs = {}
    for i = #this.bombs, 1, -1 do
        local b = this.bombs[i]
        if bombsToExplode[b.id] then
            table.insert(returnBombs, b)
            this.bombPool:Return(b)
            table.remove(this.bombs, i)
        end
    end

    local expDuration = JSYZGame.explosionDuration
    for _, exp in ipairs(allExplosions) do
        local expObj = this.explosionPool:Get(exp.x, exp.y, expDuration)
        table.insert(this.explosions, expObj)
    end


    LuaMgr.InvokeUIEventListeners(UIEventConst.JSYZ_BOMB_EXPLODED, returnBombs, allExplosions);

    JSYZGameMgr.DestroyBricks(allDestroyedBricks)
    JSYZGameMgr.DestroyPowerups(destroyedPowerups)
    JSYZGameMgr.CheckEnemyHit(allExplosions)
    JSYZGameMgr.CheckPlayerHit(allExplosions)
end


JSYZGameMgr.CalculateExplosion = function(bomb)
    local explosions = {}
    local destroyedBricks = {}
    local chainBombIds = {}
    local hitPowerups = {}
    local directions = { { 0, 0 }, { 0, 1 }, { 0, -1 }, { 1, 0 }, { -1, 0 } }
    local cellType = JSYZCellType
    local gridSizeX = JSYZGame.gridSizeX
    local gridSizeY = JSYZGame.gridSizeY
    local makeKey = JSYZGameUtils.MakeKey

    for _, dir in ipairs(directions) do
        for i = 0, bomb.range do
            if i == 0 and (dir[1] ~= 0 or dir[2] ~= 0) then
                goto continue
            end

            local x = bomb.x + dir[1] * i
            local y = bomb.y + dir[2] * i

            if x < 0 or x >= gridSizeX or y < 0 or y >= gridSizeY then
                break
            end

            if this.grid[x][y] == cellType.WALL then
                break
            end

            table.insert(explosions, { x = x, y = y })

            local bombAtPos = JSYZGameMgr.FindBombAt(x, y)
            if bombAtPos and bombAtPos.id ~= bomb.id then
                table.insert(chainBombIds, bombAtPos.id)
                break
            end

            if this.grid[x][y] == cellType.BRICK then
                table.insert(destroyedBricks, { x = x, y = y })
                break
            end

            local key = makeKey(x, y)
            if this.powerups[key] then
                table.insert(hitPowerups, { x = x, y = y })
            end

            ::continue::
        end
    end

    return explosions, destroyedBricks, chainBombIds, hitPowerups
end


JSYZGameMgr.DestroyPowerups = function(powerupList)
    if not powerupList then return end
    local makeKey = JSYZGameUtils.MakeKey

    for _, p in ipairs(powerupList) do
        local key = makeKey(p.x, p.y)
        if this.powerups[key] then
            this.powerups[key] = nil
            LuaMgr.InvokeUIEventListeners(UIEventConst.JSYZ_POWERUP_DESTROYED, p.x, p.y);
        end
    end
end


JSYZGameMgr.DestroyBricks = function(bricks)
    if not bricks or #bricks == 0 then return end

    local processed = {}
    local makeKey = JSYZGameUtils.MakeKey
    local cellType = JSYZCellType

    for _, brick in ipairs(bricks) do
        if brick and brick.x and brick.y then
            local key = makeKey(brick.x, brick.y)
            if not processed[key] then
                processed[key] = true
                this.grid[brick.x][brick.y] = cellType.EMPTY

                LuaMgr.InvokeUIEventListeners(UIEventConst.JSYZ_CELL_CHANGED, brick.x, brick.y, cellType.EMPTY);

                local isExit = false
                if this.exitPos and brick.x == this.exitPos.x and brick.y == this.exitPos.y then
                    this.grid[brick.x][brick.y] = cellType.EXIT
                    this.exitRevealed = true
                    LuaMgr.InvokeUIEventListeners(UIEventConst.JSYZ_EXIT_REVEALED, this.exitPos);
                    isExit = true
                end



                local configuredPowerup = this.powerupIndex[key]
                if configuredPowerup then
                    this.powerups[key] = configuredPowerup
                    LuaMgr.InvokeUIEventListeners(UIEventConst.JSYZ_POWERUP_SPAWNED, brick.x, brick.y,
                        configuredPowerup);
                end

            end
        end
    end
end


JSYZGameMgr.CheckEnemyHit = function(explosions)
    for i = #this.enemies, 1, -1 do
        local enemy = this.enemies[i]
        local isHit = false
        for _, exp in ipairs(explosions) do
            if enemy.x == exp.x and enemy.y == exp.y then
                isHit = true
                break
            end

            if enemy.lastX and enemy.lastY and (enemy.lastX == exp.x and enemy.lastY == exp.y) then
                if enemy.moveSpeed and enemy.moveTimer then
                    local progress = enemy.moveTimer / enemy.moveSpeed

                    if progress < 0.5 then
                        isHit = true
                        break
                    end
                end
            end
        end
        if isHit then
            local config = JSYZEnemies[enemy.configId]
            this.player.score = this.player.score + config.scoreValue
            table.remove(this.enemies, i)
            LuaMgr.InvokeUIEventListeners(UIEventConst.JSYZ_ENTITY_DESTROYED, enemy);
        end
    end
end


JSYZGameMgr.CheckPlayerHit = function(explosions)
    if this.player.invincible then
        return
    end

    for _, exp in ipairs(explosions) do
        if this.player.x == exp.x and this.player.y == exp.y then
            JSYZGameMgr.PlayerUnderAttack()
            return
        end
    end
end


JSYZGameMgr.CheckCollisions = function()
    local makeKey = JSYZGameUtils.MakeKey

    if not this.player or this.player.dead then
        return
    end

    local playerKey = makeKey(this.player.x, this.player.y)
    local powerupType = this.powerups[playerKey]
    if powerupType then
        this.player:CollectPowerup(powerupType)
        this.powerups[playerKey] = nil

    end

    local function getSmoothPos(entity)
        if not entity.lastX then return entity.x, entity.y end
        local progress = 1
        if entity.type == JSYZCellType.PLAYER then
            local dur = 88 / (140 + entity.playerMoveSpeed * 10)
            if dur > 0 then
                progress = entity.moveTimer / dur
            end
        elseif entity.type == JSYZCellType.ENEMY then
            if entity.moveSpeed > 0 then
                progress = entity.moveTimer / entity.moveSpeed
            end
        end
        progress = math.max(0, math.min(1, progress))
        local cx = entity.lastX + (entity.x - entity.lastX) * progress
        local cy = entity.lastY + (entity.y - entity.lastY) * progress
        return cx, cy
    end

    if not this.player.invincible then
        local px, py = getSmoothPos(this.player)
        for _, enemy in ipairs(this.enemies) do
            if enemy and not enemy.dead then
                local ex, ey = getSmoothPos(enemy)
                local distSqr = (px - ex) * (px - ex) + (py - ey) * (py - ey)

                if distSqr < 0.25 then
                    JSYZGameMgr.PlayerUnderAttack()
                    return
                end
            end
        end

        for _, explosion in ipairs(this.explosions) do
            if explosion then
                local distSqr = (px - explosion.x) * (px - explosion.x) + (py - explosion.y) * (py - explosion.y)
                if distSqr < 0.25 then
                    JSYZGameMgr.PlayerUnderAttack()
                    return
                end
            end
        end
    end

    if this.exitRevealed and this.exitPos then
        if (this.player.x == this.exitPos.x and this.player.y == this.exitPos.y) then

            this.win = true

            JSYZGameMgr.Result(true)
            LuaMgr.InvokeUIEventListeners(UIEventConst.JSYZ_GAME_WIN);



        end
    end
end

JSYZGameMgr.PlayerUnderAttack = function()
    if (this.player.invincible) then
        return
    end
    this.player.playerHp = this.player.playerHp - 1
    this.player:CollectPowerup(7)
    if (this.player.playerHp <= 0) then
        this.gameOver = true
        this.player.dead = true

        JSYZGameMgr.Result(false)
        LuaMgr.InvokeUIEventListeners(UIEventConst.JSYZ_GAME_OVER);
    end
end


JSYZGameMgr.FindBombById = function(id)
    for _, bomb in ipairs(this.bombs) do
        if bomb.id == id then
            return bomb
        end
    end
    return nil
end


JSYZGameMgr.FindBombAt = function(x, y)
    for _, bomb in ipairs(this.bombs) do
        if bomb.x == x and bomb.y == y then
            return bomb
        end
    end
    return nil
end


JSYZGameMgr.GetGameState = function()
    return {
        grid = this.grid,
        player = this.player,
        enemies = this.enemies,
        bombs = this.bombs,
        explosions = this.explosions,
        powerups = this.powerups,
        dangerMap = this.dangerMap,
        exitPos = this.exitPos,
        exitRevealed = this.exitRevealed,
        gameOver = this.gameOver,
        win = this.win
    }
end

JSYZGameMgr.InitTalent = function()

end

JSYZGameMgr.Show = function()
    JSYZGameMgr.Stop();
    JSYZGameMgr.Clear()
    this.oldTime = LuaMgr.TimestampMS();
    this.gameTime = 0;
    this.isOpen = false;
end

JSYZGameMgr.Clear = function()
    this.grid = nil
    this.gameTime = 0;
    this.bombs = {}
    this.enemies = {}
    this.explosions = {}
    this.powerups = {}
    this.dangerMap = {}
    this.exitRevealed = false
    this.powerupIndex = {}
    this.enemyIdCounter = 0
end

JSYZGameMgr.Destroy = function()
    JSYZGameMgr.Clear();
end

JSYZGameMgr.Play = function()
    this.isPlay = true;
    this.isOpen = true;
    if (this.stopTime ~= 0) then
        local interval = LuaMgr.Timestamp() - this.stopTime;
        this.stopTime = 0
    end
end

JSYZGameMgr.Stop = function()
    this.isPlay = false;
    this.stopTime = LuaMgr.Timestamp()
end

JSYZGameMgr.IsOpen = function()
    return this.isOpen;
end

JSYZGameMgr.Pause = function()
    JSYZGameMgr.Stop();
    LuaMgr.ShowLuaPanel(UIName.JSYZGamePauseViewModel, 1, nil);
end

JSYZGameMgr.Skip = function()
    JSYZGameMgr.Stop();

    if this.isSettled then return end
    this.isSettled = true

    local count = this.enemyIdCounter - #this.enemies
    JSYZGameMgr.Clear();
    local id = this.mapId
    local mapConfig = ConfigMgr.Config.BoomMaps[id]
    if (mapConfig.MonsterKills > count) then
        count = mapConfig.MonsterKills
    end
    this.player.score = count
    ApiMgr.Request("boommap/boomsettlement", { Id = id, Count = count, Jump = true }, true, function(result)
        local data = json.decode(result);
        if (data ~= nil and data.result ~= nil) then
            LuaMgr.ShowLuaPanel(UIName.JSYZGameResultViewModel, true, data.result.Reward);
        end
    end, nil, true, true);
end

JSYZGameMgr.GameTime = function()
    return this.gameTime;
end

JSYZGameMgr.PlayAudio = function(id)
    AudioMgr.Singleton:PlayUISFX(string.format(this.audioPath, id));
end

JSYZGameMgr.GetTexture = function(resId)
    return LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/YPS/%s.png", resId));
end


JSYZGameMgr.Result = function(finish)

    if this.isSettled then return end
    this.isSettled = true


    local count = this.enemyIdCounter - #this.enemies

    JSYZGameMgr.Stop();
    JSYZGameMgr.Clear();
    local id = this.mapId
    if (not finish) then
        id = ""
    end
    this.player.score = count
    ApiMgr.Request("boommap/boomsettlement", { Id = id, Count = count, Jump = false }, true, function(result)
        local data = json.decode(result);
        if (data ~= nil and data.result ~= nil) then
            LuaMgr.ShowLuaPanel(UIName.JSYZGameResultViewModel, finish, data.result.Reward);
        end
    end, nil, true, true);
end


this.CheckGameOver = function()
    if (this.gameEndTime <= 0) then
        this.gameOver = true
        JSYZGameMgr.Result(false);
        return
    end
    if (this.setTime ~= nil) then
        this.setTime();
    end
end


JSYZGameMgr.GameEndTime = function()
    return this.gameEndTime;
end


JSYZGameMgr.OnUpdate = function()
    local nowTime = LuaMgr.TimestampMS();
    local time = nowTime - this.oldTime;
    this.oldTime = nowTime;
    if this.gameOver or this.win or not this.isPlay then
        return
    end
    if (this.isPlay) then
        this.gameTime = this.gameTime + time;
        this.gameEndTime = this.gameEndTime - time;
        if (this.gameEndTime < 0) then
            this.gameEndTime = 0;
        end
        this.CheckGameOver()

        if this.gameOver or this.win then
            return
        end
    end

    local actualDelta = CS.UnityEngine.Time.deltaTime

    this.currentTime = this.currentTime + actualDelta

    this.player:Update(actualDelta)

    JSYZGameMgr.UpdateBombs(actualDelta)
    JSYZGameMgr.UpdateExplosions(actualDelta)

    this.dangerMap = JSYZGameDangerMap.Update(this.bombs, this.grid)

    for i = #this.enemies, 1, -1 do
        local enemy = this.enemies[i]
        if not enemy.dead then
            enemy:Update(actualDelta, this.player, this.grid, this.bombs, this.explosions, this.dangerMap)
        end
    end

    JSYZGameMgr.CheckCollisions()
end