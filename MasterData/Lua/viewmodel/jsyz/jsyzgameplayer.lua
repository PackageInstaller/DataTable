JSYZGamePlayer = {};
JSYZGamePlayer.__index = JSYZGamePlayer


function JSYZGamePlayer.New(x, y)
    local player = {}
    setmetatable(player, JSYZGamePlayer);
    player.id = "player"
    player.type = JSYZCellType.PLAYER
    player.x = x
    player.y = y
    player.lastX = x
    player.lastY = y
    player.moveTimer = 0
    player.dead = false
    player.animationState = "idle"
    player.bombRange = ConfigMgr.Config.BoomConstants.StratBoomRange
    player.maxBombs = ConfigMgr.Config.BoomConstants.StratBoomNum
    player.playerMoveSpeed = ConfigMgr.Config.BoomConstants.StratSpeed
    player.playerHp = ConfigMgr.Config.BoomConstants.StratHp
    player.playerHpMax = ConfigMgr.Config.BoomConstants.StratHp
    player.invincible = false
    player.invincibleTimer = 0
    player.score = 0
    player.activeBombCount = 0

    for k, v in pairs(ConfigMgr.Config.BoomTetechMap) do
        if (JSYZMgr.CheckTalentIsComplete(v)) then
            if (v.Type == 1) then
                player.maxBombs = player.maxBombs + 1
            elseif (v.Type == 2) then
                player.playerHp = player.playerHp + 1
                player.playerHpMax = player.playerHpMax + 1
            elseif (v.Type == 3) then
                player.playerMoveSpeed = player.playerMoveSpeed + 1
            else
                player.bombRange = player.bombRange + 1
            end
        end
    end
    return player
end


function JSYZGamePlayer:Update(deltaTime)
    if self.invincible then
        self.invincibleTimer = self.invincibleTimer - deltaTime
        if self.invincibleTimer <= 0 then
            self.invincible = false
            self.invincibleTimer = 0

        end
    end

    if self.x ~= self.lastX or self.y ~= self.lastY then
        self.moveTimer = self.moveTimer + deltaTime

        local moveDuration = 88 / (140 + self.playerMoveSpeed * 10)
        if self.moveTimer >= moveDuration then
            self.lastX = self.x
            self.lastY = self.y
            self.moveTimer = 0
        end
    else
        self.moveTimer = 0
    end

    return true
end


function JSYZGamePlayer:CanMove(newX, newY, grid, bombs)
    if not grid or grid == nil then return false end
    local gridSizeX = JSYZGame.gridSizeX
    local gridSizeY = JSYZGame.gridSizeY
    local cellType = JSYZCellType
    if newX < 0 or newX >= gridSizeX or newY < 0 or newY >= gridSizeY then
        return false
    end

    if newX ~= self.x and newY ~= self.y then
        return false
    end

    local cell = grid[newX][newY]
    if cell == cellType.WALL or cell == cellType.BRICK then
        return false
    end

    for _, bomb in ipairs(bombs) do
        if bomb.x == newX and bomb.y == newY then
            if not (self.x == newX and self.y == newY) then
                return false
            end
        end
    end

    return true
end


function JSYZGamePlayer:TryMove(newX, newY)
    self.lastX = self.x
    self.lastY = self.y
    self.moveTimer = 0
    self.x = newX
    self.y = newY
    return true
end


function JSYZGamePlayer:CollectPowerup(powerupType)
    local config = JSYZPowerups[powerupType]
    if not config then return false end
    local success = false
    if (config.id == JSYZCellType.POWERUP_RANGE) then
        self.bombRange = self.bombRange + 1
        success = true
    elseif (config.id == JSYZCellType.POWERUP_SPEED) then
        self.playerMoveSpeed = self.playerMoveSpeed + 1
        success = true
    elseif (config.id == JSYZCellType.POWERUP_INVINCIBLE) then
        self.invincible = true
        self.invincibleTimer = 5
        success = true
    elseif (config.id == JSYZCellType.POWERUP_BOMB) then
        self.maxBombs = self.maxBombs + 1
        success = true
    elseif (config.id == JSYZCellType.POWERUP_HP) then
        if self.playerHp < self.playerHpMax then
            self.playerHp = self.playerHp + 1
            success = true
        end
    elseif (config.id == JSYZCellType.POWERUP_INVINCIBLE_HURT) then
        self.invincible = true
        self.invincibleTimer = 2
        success = true
    end





    LuaMgr.InvokeUIEventListeners(UIEventConst.JSYZ_POWERUP_COLLECTED, config.id, self, success);
    return success
end