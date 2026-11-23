JSYZGameEnemy = {};
JSYZGameEnemy.__index = JSYZGameEnemy


function JSYZGameEnemy.New(id, configId, x, y)
    local enemy = {}
    setmetatable(enemy, JSYZGameEnemy);
    local config = JSYZEnemies[configId]
    if (config == nil) then
        return nil
    end
    enemy.id = id
    enemy.type = JSYZCellType.ENEMY
    enemy.x = x
    enemy.y = y
    enemy.lastX = x
    enemy.lastY = y
    enemy.dead = false
    enemy.animationState = "idle"
    enemy.lastMoveTime = 0
    enemy.configId = configId
    enemy.moveSpeed = config.moveSpeed
    enemy.scoreValue = config.scoreValue
    enemy.aiType = config.ai
    enemy.chaseRange = config.chaseRange
    enemy.dangerAvoidance = config.dangerAvoidance
    enemy.riskThreshold = config.riskThreshold

    enemy.pathCache = nil
    enemy.pathCacheTimer = 0
    enemy.patrolDirection = nil
    enemy.moveTimer = 0

    return enemy
end


function JSYZGameEnemy:Update(deltaTime, player, grid, bombs, explosions, dangerMap)
    if not player or player.dead then
        return false
    end

    self.pathCacheTimer = self.pathCacheTimer + deltaTime
    self.moveTimer = self.moveTimer + deltaTime

    if self.moveTimer < self.moveSpeed then
        return false
    end

    local needRecalculate = false
    if not self.pathCache or #self.pathCache == 0 then
        needRecalculate = true
    elseif self.pathCacheTimer >= JSYZGame.pathRecalcInterval then
        needRecalculate = true
        self.pathCacheTimer = 0
    end

    if needRecalculate then
        local nextPos = JSYZGameAI.Execute(self, player, grid, bombs, explosions, dangerMap)
        if nextPos then

            if player.invincible then
                self.pathCache = nil
            else
                self.pathCache = { nextPos }
            end
        else
            self.pathCache = nil
        end
    end

    local moved = false

    if self.pathCache and #self.pathCache > 0 then
        local nextPos = self.pathCache[1]
        if self:CanMove(nextPos.x, nextPos.y, grid, bombs) then
            self.lastX = self.x
            self.lastY = self.y
            self.x = nextPos.x
            self.y = nextPos.y
            table.remove(self.pathCache, 1)
            self.patrolDirection = nil
            moved = true
        else
            self.pathCache = nil
        end
    end

    if not moved then
        moved = self:Patrol(grid, bombs)
    end

    if moved then
        self.moveTimer = self.moveTimer - self.moveSpeed

        if self.moveTimer > self.moveSpeed then
            self.moveTimer = self.moveSpeed
        end
        LuaMgr.InvokeUIEventListeners(UIEventConst.JSYZ_ENTITY_MOVED, self);
    else

        if self.moveTimer > self.moveSpeed then
            self.moveTimer = self.moveSpeed
        end
    end

    return moved
end


function JSYZGameEnemy:Patrol(grid, bombs)
    local directions = { { 0, 1 }, { 1, 0 }, { 0, -1 }, { -1, 0 } }

    if not self.patrolDirection then
        self.patrolDirection = directions[math.random(1, 4)]
    end

    local nx = self.x + self.patrolDirection[1]
    local ny = self.y + self.patrolDirection[2]

    if self:CanMove(nx, ny, grid, bombs) then
        self.lastX = self.x
        self.lastY = self.y
        self.x = nx
        self.y = ny
        return true
    else
        local validDirs = {}
        for _, dir in ipairs(directions) do
            local testX = self.x + dir[1]
            local testY = self.y + dir[2]
            if self:CanMove(testX, testY, grid, bombs) then
                table.insert(validDirs, dir)
            end
        end

        if #validDirs > 0 then
            self.patrolDirection = validDirs[math.random(1, #validDirs)]
            self.lastX = self.x
            self.lastY = self.y
            self.x = self.x + self.patrolDirection[1]
            self.y = self.y + self.patrolDirection[2]
            return true
        end
    end

    return false
end


function JSYZGameEnemy:CanMove(x, y, grid, bombs)
    local gridSizeX = JSYZGame.gridSizeX
    local gridSizeY = JSYZGame.gridSizeY
    local cellType = JSYZCellType

    if x < 0 or x >= gridSizeX or y < 0 or y >= gridSizeY then
        return false
    end

    local cell = grid[x][y]
    if cell == cellType.WALL or cell == cellType.BRICK then
        return false
    end

    for _, bomb in ipairs(bombs) do
        if bomb.x == x and bomb.y == y then
            return false
        end
    end

    return true
end